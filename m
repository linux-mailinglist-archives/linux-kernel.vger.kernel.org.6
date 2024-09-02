Return-Path: <linux-kernel+bounces-311464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBCE96898A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EBF71C22B92
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1255719F11A;
	Mon,  2 Sep 2024 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j5mzraXN"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19CA2139D4
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286218; cv=none; b=XbuWWkuwGjC7orhMdJpcwNDuoA8be292rvtYXUsgKAN2f2+ARxP7InHzuNIZzYkDQHqvWM7DN1lktWcF6kfpsY4R48vAgOiTESd6oSLXbtAdRMW5yzy0WhQ961Oe9DTsNBSUimOyUv8hdz3qBqwUvWtzhorCjSwT1+cs8pjd8dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286218; c=relaxed/simple;
	bh=6YwwAfyU0B0/g/tSliwXNeMH+iCOQdzN52CjixjX9mk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AgpgOtWxlgwl3aB/a69TLFfJXRwKnrDLiVvsEy1xf+ZNBI+dMw7aSvKFwdGLsBQiHT4ovWu7uauU6paEZNhhYk1vMFAexRLN2CX1Gwe71TTHs5YrdgoZk7GlA0LC4iumP56ZA9UrVvBB74BtAP3KTMp3X74aQcF0AgYlnRv7ilE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j5mzraXN; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8695cc91c8so427727266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725286215; x=1725891015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEXG8xSsxSH4oncQomb3hsfY98uEQJs5PaBlHSgTpck=;
        b=j5mzraXNI+KEuI4thSbE56dS7L+DvBRv36scs/n104p4Yq15ojPwKnwekPOIAPj7wK
         6uxb5KMpjyjYDJh6Uh5GCzVAZjHouARPgFAnyZuRdS7yXcYBhuF/lgrPGNYswiWRbRQk
         +E9YK62slOfkI/rzcw5zxFUTrnY/rJ0f1gP+FfV2HlTtx8ibccXYW/J90ErcMYIYLW8V
         hTDAYclmqXKqtNZAyBJFegA+eTdhEsaziciGZhzSIvipBReZ5/zESmHefWQiBmbuVmzq
         CwCJKNkL8W1UJ//69w+6Ly31ZhtCWQQQJl7eyWpr8bO99QVAhSkNY+SzG1aum4req7BY
         dUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725286215; x=1725891015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEXG8xSsxSH4oncQomb3hsfY98uEQJs5PaBlHSgTpck=;
        b=aOYB1Hb6IQJ7zOQ0o+q983x8lNIOA7ogpNsmdNPbIRbg3+05WYeD/8AlNuAIssJ3Fs
         i6nms78hmSuf5liScb75yowPdmVxXIyWkZJx9qTTK9UrjumeTQTeWb8TPRBUk14sdSbE
         eoGnZBYScpqHLLOjfCp/L0q/kfhva5y0yslNCkZaxgIc9py5qAOgh4sKwmiIbdwJvyqY
         d7Kn22A5iRszMoNbZ33boUz0FKfIGv8edo7fGfHmqf+1ImnvLLwVAxcbdUkIoxMQDL6c
         Xvux5L7ZsDDZHWcLohYYJwRGLnP3sTciGvMwHY2Kg0vcV9jeItm9SIgrQhLTz3M9zoRI
         abIg==
X-Gm-Message-State: AOJu0YxyIgL4ffn87b0Am3WBwbsPRBMdL4uFWq6tq8WS9MAbDicS4wLu
	bx11Aseg55afy3Y4sCKCtykKxPtMAKU2zaAcl8OxThtmldbU7ZoELwqZA14Q13o=
X-Google-Smtp-Source: AGHT+IGXCNyaNZl9sPxZZZ6KU5nSZOR6dYdungazLFE2e1ReXfppeBK2JoIQOrnSSkmu1lL/r4mscg==
X-Received: by 2002:a17:907:3f24:b0:a7a:a892:8e05 with SMTP id a640c23a62f3a-a897f92022amr947243266b.33.1725286214766;
        Mon, 02 Sep 2024 07:10:14 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d6f16sm561716066b.150.2024.09.02.07.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:10:13 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/4] slimbus: generate MODULE_ALIAS() from MODULE_DEVICE_TABLE()
Date: Mon,  2 Sep 2024 15:10:04 +0100
Message-Id: <20240902141004.70048-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902141004.70048-1-srinivas.kandagatla@linaro.org>
References: <20240902141004.70048-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Masahiro Yamada <masahiroy@kernel.org>

Commit 9e663f4811c6 ("slimbus: core: add support to uevent") added the
MODALIAS=slim:* uevent variable, but modpost does not generate the
corresponding MODULE_ALIAS().

To support automatic module loading, slimbus drivers still need to
manually add MODULE_ALIAS("slim:<manf_id>:<prod_code>:*"), as seen in
sound/soc/codecs/wcd9335.c.

To automate this, make modpost generate the proper MODULE_ALIAS() from
MODULE_DEVICE_TABLE(slim, ).

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 scripts/mod/devicetable-offsets.c |  4 ++++
 scripts/mod/file2alias.c          | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index 518200813d4e..9c7b404defbd 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -153,6 +153,10 @@ int main(void)
 	DEVID_FIELD(i3c_device_id, part_id);
 	DEVID_FIELD(i3c_device_id, extra_info);
 
+	DEVID(slim_device_id);
+	DEVID_FIELD(slim_device_id, manf_id);
+	DEVID_FIELD(slim_device_id, prod_code);
+
 	DEVID(spi_device_id);
 	DEVID_FIELD(spi_device_id, name);
 
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 5d1c61fa5a55..99dce93a4188 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -960,6 +960,16 @@ static int do_i3c_entry(const char *filename, void *symval,
 	return 1;
 }
 
+static int do_slim_entry(const char *filename, void *symval, char *alias)
+{
+	DEF_FIELD(symval, slim_device_id, manf_id);
+	DEF_FIELD(symval, slim_device_id, prod_code);
+
+	sprintf(alias, "slim:%x:%x:*", manf_id, prod_code);
+
+	return 1;
+}
+
 /* Looks like: spi:S */
 static int do_spi_entry(const char *filename, void *symval,
 			char *alias)
@@ -1555,6 +1565,7 @@ static const struct devtable devtable[] = {
 	{"rpmsg", SIZE_rpmsg_device_id, do_rpmsg_entry},
 	{"i2c", SIZE_i2c_device_id, do_i2c_entry},
 	{"i3c", SIZE_i3c_device_id, do_i3c_entry},
+	{"slim", SIZE_slim_device_id, do_slim_entry},
 	{"spi", SIZE_spi_device_id, do_spi_entry},
 	{"dmi", SIZE_dmi_system_id, do_dmi_entry},
 	{"platform", SIZE_platform_device_id, do_platform_entry},
-- 
2.25.1


