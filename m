Return-Path: <linux-kernel+bounces-406481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822E19C5FEE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E03EBE074B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9537F2178F8;
	Tue, 12 Nov 2024 18:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxMU3yr9"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999DA148FF3
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434409; cv=none; b=ktn/RSSMjEevrRXx5SdoA2kqI7FYuxIgAwtYsapuqxzgOMgzwtZSsN907zilCXM6qhla9MnCUPOCdtl3M5r8O50sZCuOjCiSc6L0KNiptzaZWkh0Qw51NaaaWgMVLEX+pb4n5qua+oiAH5vasHE7UX90O3yp6GC5SXqu2QfJs+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434409; c=relaxed/simple;
	bh=XNIbje+vYA/inNW64dUHI3KFTiSNhHjq8byWTNrabQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AoGJiaJb+3BCYhaaHiKEbw4pQLwAJ48xjS3ywcHKuwzltfW48+ANELBH5nRCJbDBix4GmUmzFfFVr5/py4N8ZiNYlaiO9KU50gg+7QwsOjVbgwLslRRQ4v8FJZ2xQ6spfxHUg0j7ZLQRgFlOhkxH1nwX6G1VwR7x8WIeGjwowdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxMU3yr9; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea7e250c54so4416366a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731434407; x=1732039207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=54q4eYyScDWFGKt3cp1r2MjmiDAz8++iYp48KLTi77k=;
        b=lxMU3yr9t8/zeuCdYdP0CHvHjLKPDcdX6CT1H1BYZHUK5CDPWDKkfG3o4+Ya1pniYj
         U46F37L6QQCzz7M87j5uXm5v3dSXB0bdq70YUzE+s1iNQlNj7u5GVuVoO/wPJMl2WqKV
         yA18/vYPt1P7jYM8P0n3gEtQA5XqulDrkOds+8Y50So7cxPE3/IR2dtBu+XvYYQYUVru
         A6mMiBtUmR4kB10MZ51WkOnyTytTuZuicNTMRK+uHvDFawZuQynAdb3vVV0sJNZfU8+A
         G+rilmuRhvEAePLic77+UJ2O4Ak64O4juspUVdGzR6hui0J76MEFX0VTWmJvqa+hhFJ9
         xfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731434407; x=1732039207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=54q4eYyScDWFGKt3cp1r2MjmiDAz8++iYp48KLTi77k=;
        b=sXB4Yb1OV5jZYY8bZ78t90KgRJY+agbzs9i5918o4bJonDS6p4OmCna/ikI2wag21R
         jdvDn9doker0INpfNvpn4pE4ibuU+jZA/9foXDThHrU+WZ+sktLaxtb4bYsQPXV4ZVcb
         493/gVDHmkunmdMml1lJSIAl5RxpzG3/5l+9qNs3JqpkE1gaNgH5mbKy1aHhCBoHpvfd
         n8igETbzQGlNTGCsnUW2EPpX6GtzMjy7HaBwECARXb7HVI1zbKwK3jThF0FgAz5QFfPC
         AqoP8kUZ4aSZO19kDDPNfomPqeEP3AsOuqrBQlwuf0GUFcSTV2xUeJaqDL9sofaI3q9j
         nZKw==
X-Forwarded-Encrypted: i=1; AJvYcCVTcjXfgiinCd6Q0UoNQovwujg+Fww+Nyp4eYAIHPaSq3UW7yDluw5YsYp9E9D1EZnIQaFEE/jqs5jLAfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX00F99/JbBI7x9RqA2ttGtIQuAmWU4z+kiIgXK1/8roAS7DaW
	n8VNyF62Epud2BOWgetLnGZL1MIuYCLFUnd+2FKm/aNSueMjmDWI
X-Google-Smtp-Source: AGHT+IEjmGmPUXgN/Z4en4rN1VSNsF+Q+L/QIi86m1uy8qTTse9NP+UITQiTgLlpUNTK99xDnRxDGw==
X-Received: by 2002:a17:90a:e7cb:b0:2e2:a8dd:9bb5 with SMTP id 98e67ed59e1d1-2e9b170d9f4mr21955617a91.12.1731434406489;
        Tue, 12 Nov 2024 10:00:06 -0800 (PST)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e99a541da0sm14458797a91.13.2024.11.12.10.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 10:00:06 -0800 (PST)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>
Cc: dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Mohammed Anees <pvmohammedanees2003@gmail.com>
Subject: [PATCH] dm: Allow the use of escaped characters in str_field_delimit()
Date: Tue, 12 Nov 2024 23:27:58 +0530
Message-ID: <20241112175758.114080-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Escape characters were not handled before, which could lead to
unwanted issues. Some device-mapper names may contain backslashes (`\`)
as valid characters and should not be treated as escape characters. Only
escape characters followed directly by the separator are considered
valid and need to be processed. After handling, the escape characters
are removed to ensure the final string is correctly parsed without
unwanted escape sequences which were used only for escaping.

Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
---
 drivers/md/dm-init.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-init.c b/drivers/md/dm-init.c
index b37bbe762500..dad9d523f7fb 100644
--- a/drivers/md/dm-init.c
+++ b/drivers/md/dm-init.c
@@ -88,13 +88,33 @@ static void __init dm_setup_cleanup(struct list_head *devices)
 static char __init *str_field_delimit(char **str, char separator)
 {
 	char *s;
+	/* This variable handles removing escape characters, which are
+	 * only used to avoid the separator and aren't needed in the
+	 * final string.
+	 */
+	char *write;
 
-	/* TODO: add support for escaped characters */
 	*str = skip_spaces(*str);
-	s = strchr(*str, separator);
+	s = *str;
+	write = *str;
+
+	/* Find the separator and handle escape character */
+	while (*s) {
+		/* If '\' is followed by the separator, skip '\' by
+		 * incrementing s, write will then overwrite the
+		 * escape character with the separator.
+		 */
+		if (*s == '\\' && *(s + 1) != '\0' && *(s + 1) == separator)
+			s++;
+		else if (*s == separator)
+			break;
+
+		*write++ = *s++;
+	}
+
 	/* Delimit the field and remove trailing spaces */
-	if (s)
-		*s = '\0';
+	if (write)
+		*write = '\0';
 	*str = strim(*str);
 	return s ? ++s : NULL;
 }
-- 
2.47.0


