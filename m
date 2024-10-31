Return-Path: <linux-kernel+bounces-390814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 056E99B7EDE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE912281391
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AFC1AC456;
	Thu, 31 Oct 2024 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8c8Y6EK"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF2B1A4F01;
	Thu, 31 Oct 2024 15:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389523; cv=none; b=PhcVF8iGPwcRi/JJW/7HSgjPOXnQYDUKeugOKck++n+mO3VkqikMnh5bw+oXVGmWVsxHhMYdtZ8ipmDABH0F3mWCzhTYc8R6uScdWmqJeSkO2g3NFuD8ldtYpl1UeC8VGawXH80RuLVep5IIiLfwNUn24UO4BpTo32l0vlhEg/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389523; c=relaxed/simple;
	bh=4asKQz8BlpJNUrdZhQ29gzgZCv2VO5bREGlNaueBoVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAJrB5gVpMCHipqBZCIRFPVfbMQdmcLzUW5krUskJ/Xwfwt8bMvZ6gDJCTrrswlAQecgirwDj433Sz4k6CORJOR1pld+5853EunmB6z/o/T8Dg2Q5SWIxBbPjqHy+8d8ut6/WOnZUFYke32s+6dJ3lf8+VWu0WmUmBMdHPESPDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8c8Y6EK; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7edb6879196so803941a12.3;
        Thu, 31 Oct 2024 08:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730389521; x=1730994321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcdrQiXH1Ai25k8tG5sWlTGqXb3UpGbFG/HnKOgIkSs=;
        b=c8c8Y6EK+FjT4d0VvtZIfbthom8iQAWUtgj4GXKegGOnQOcsD4/fMnRJxnEAhwSkzR
         Ks5fSh7ZOrFIy/hBQ30+thW03tx/xRjH29E5ITWEKNsrOQ2kV7fTrLuWIwdN9EYwjqbV
         Jy/424HAGnA1ROnQOZE46yHbeTOUpC2+9elE78BV1Nx3azKDlTco3CoAKKA4Fw232dO6
         70IwVu/eKGOzjcXHfwI7p5tyJLHOdg/TfwQHylPXLSANyF2fapjx8ykbWhSAEFJB9tuF
         COk+Hr45tMQruH92QABJHtESPJaJM4z4YpdwNFnShBZE4TrgDAztOCmXmIJurWUvsdrJ
         sH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730389521; x=1730994321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcdrQiXH1Ai25k8tG5sWlTGqXb3UpGbFG/HnKOgIkSs=;
        b=ZkzZ3uqNqdhFiYqlOsctQAS6M5pDtZ68DmICz/ElOecpFHxgMMYQHxGIvQhGmOsMKQ
         jnMt3TR3SqsfjYauN7X6FuOTrg4ZH+SrPu2gjvhkzgoZv/WETz2KfT+Q4t686g6l6gL5
         FoZxfMOVkef4rA4m8WeAVUS1NkpvxovdCwuAmTRWZwfEVc5tAjocWRb0kHCTChNmTfbk
         t0gSnegXNSjFUUkhQmsCBMzWSNurQsGm18c4OB+KyKx71BxgF3zFQqWXVx9xqQ9HBFT0
         zwqdzFJGqz8FcESpniy39TWjaVYQT7gsnrdNP8G5I72RNGtVVHL0VoN1t+QV4MrFRCRd
         cC4g==
X-Forwarded-Encrypted: i=1; AJvYcCWeWthcQAaaw7KCgkRfoKLUDWg0fCDc7Y1fYHmFVtE94F1Dc/3RcIGRS0sfNkB1TE+7RKEZYQuAaz6DJCat26XD3h6pPg==@vger.kernel.org, AJvYcCXyiHbd9JxfmtWTJ1AFpTPkGc7+wQBvvpNNNajPIhji9m3jBLp4tHLYoP9P+gGJWmbiY6OUwfw4T0dAxH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXCgbQpmeILoJfdKO38RKGX+GJ9x1vhZ3mRqSfhrPSCI0zdwPe
	vwaa/EOeAL2oRuPh5Pq/2GzeBI3jlCaKZ+hQcVdpQ8t+nzy6IUkB
X-Google-Smtp-Source: AGHT+IH4fCkgmP7iojZ/BQoHL465KrlePVvyrnC+kpcoX/EnkLheoMocGoZWzuvJN6fNg6yBkkQiIw==
X-Received: by 2002:a17:902:ea0b:b0:20c:f39e:4c15 with SMTP id d9443c01a7336-210c68c6dadmr236555115ad.22.1730389520780;
        Thu, 31 Oct 2024 08:45:20 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057c0a53sm10142465ad.192.2024.10.31.08.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:45:20 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	pali@kernel.org,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [PATCH v2 2/2] dell-wmi-base: Handle META key Lock/Unlock events
Date: Thu, 31 Oct 2024 12:44:42 -0300
Message-ID: <20241031154441.6663-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031154023.6149-2-kuurtb@gmail.com>
References: <20241031154023.6149-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Alienware devices have a key that locks/unlocks the Meta key. This
key triggers a WMI event that should be ignored by the kernel, as it's
handled by internally the firmware.

There is no known way of changing this default behavior. The firmware
would lock/unlock the Meta key, regardless of how the event is handled.

Tested on an Alienware x15 R1.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
v2:
 - Fixed entry style
 - Commit message clarifies firmware behavior
 - Commit message now has "Tested on"
---
 drivers/platform/x86/dell/dell-wmi-base.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/platform/x86/dell/dell-wmi-base.c
index 502783a7a..ce421e51b 100644
--- a/drivers/platform/x86/dell/dell-wmi-base.c
+++ b/drivers/platform/x86/dell/dell-wmi-base.c
@@ -80,6 +80,12 @@ static const struct dmi_system_id dell_wmi_smbios_list[] __initconst = {
 static const struct key_entry dell_wmi_keymap_type_0000[] = {
 	{ KE_IGNORE, 0x003a, { KEY_CAPSLOCK } },
 
+	/* Meta key lock */
+	{ KE_IGNORE, 0xe000, { KEY_RIGHTMETA } },
+
+	/* Meta key unlock */
+	{ KE_IGNORE, 0xe001, { KEY_RIGHTMETA } },
+
 	/* Key code is followed by brightness level */
 	{ KE_KEY,    0xe005, { KEY_BRIGHTNESSDOWN } },
 	{ KE_KEY,    0xe006, { KEY_BRIGHTNESSUP } },
-- 
2.47.0


