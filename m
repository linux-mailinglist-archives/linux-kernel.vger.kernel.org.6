Return-Path: <linux-kernel+bounces-548070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE7FA53F7B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56AE3AAAD9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85861547CA;
	Thu,  6 Mar 2025 00:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3R3sv69"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD79E15383D;
	Thu,  6 Mar 2025 00:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741222700; cv=none; b=YUM9RWHVhYzCWm9cGTT+k0ci8aJz2A5YXcFjNR4itOA80ozjaycpyugBA9I6iW6Zxzsjn4TwOygaCGBAU3efOZk8jGAKud3H/b6nU+L0RMbZPFGKcYMUzeCKNanROX73aXRFhziS9oekCQfAL8YJFcDIeMCxUluWvEEwS9Nyg3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741222700; c=relaxed/simple;
	bh=DcRXWRac1PvW+T1CPw2St2sfblMHRa99Gb0r4bB8SaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MaSct4zfvTK1GJ8otVO/oi3wZetXDNkb71pQvWr3nf3RhiRo3NTHVhFYy7czHyp68y7TTh3KblLuyagQYhVnCvuM3yVQtX0vEh/yKPYGuergjjKP02RMVSWYUbr4OpYLm26r6xPA8MUGHhXuDbZV74KXth/hX/1fdti56MeRpoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3R3sv69; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-86d30787263so34898241.1;
        Wed, 05 Mar 2025 16:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741222695; x=1741827495; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jeW9jjPJ9A+VG5BvvYKHWDIzx5AtWJe9yPCzeW/GQ7Q=;
        b=W3R3sv69d09YsjsSGsKC/nz08/JkvtkpgKybUFiV0qN35IudYtPj7KkRr3keGofgsl
         4sB80FOhBEXCCGRk0xHRwcIZA1wvvFPqfJU9pNmGu7Zt1lvajvaz6llVecz3F6oHsKeq
         ywOa0Sm5ck6mgLB+ELgfuck50qe1qSVwQBJc5ItxiUsUhFDJrx2R5axytdIR0t3Kl+4G
         QC4YPN4Q21G+wBZCIrba1AJZPCAsNH7/vkDCawoaLIZNMk1v7fc4ObAa9roI8xXbFCmK
         6Gr8yucUTP42sLOvZNALt6GHiLs2kc4WYnAjpwyKah3TE4duq/NPfNiAFNLzAhY2CJ/B
         CQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741222695; x=1741827495;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeW9jjPJ9A+VG5BvvYKHWDIzx5AtWJe9yPCzeW/GQ7Q=;
        b=xOZH2ZvLHKNwLpG2QSHclgJA6XLWdUCn17swG7KUjZhESA+coAwKl95ciDClDYjHKy
         DIOYkqPh/wnSkMKTCVHNuNND0vFZP5hAtacaSmnC0kuqloTM9HH1ubMWB0idBlvHQdg6
         yQe6cYNzjXeMRBK3OQWMRETJfLmY204BekdV9KVHiw0+k6RqPBAANzWGYCiiwiVDVLYF
         6cxuXC7xmMjRVxnbE11h+Hn5zMarfSglSBAKAwosMNFoc1EWZfAhPV0vGX9CweZ8ZZOM
         vefv9lRcILnsNKYhUkdoWcxnEssF1ozLSm/Re7i4dcA7SWKyEPlaiJAIOpe6y2z8kslx
         YgCg==
X-Forwarded-Encrypted: i=1; AJvYcCUaYeLBMR5CkNXEakuHe9DjQUSUJEb0pzQrwzhkGm9GwRvswN5xjhKJCmmS3nUDXDPJqZUoJCFAwo9udHXyg9tmQJFv+A==@vger.kernel.org, AJvYcCXAeinBGIO6bfXSMIoSZkOqbjtRr1I23iq1lLdv7aqN8tYtDGfCjxJ3fie2CLxGbaFMbhWcncGPgu/SLf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUc22nB5sEox57rZzwIA+2RgbRxVe9C1r6U9ccSmsQGstNK0wO
	9egEm1AskyzLD6o1wEmUtrvJ+i4dyarDYKTNwf5Ps906NMgRBV5Q
X-Gm-Gg: ASbGncvgKpRi+wbgm0URPr8wTtrCXGGtfefie+vksOtQYG0azPXqYU4f2zFCE0DPnSV
	6Oxv160JKApDjIDPru/N0+H0/yliW3OhY6HZCFwgRjGtcDE+Nc5gYCl/WtWaMLQvm10lL0SBSQe
	nrKor4Kb3gTD4c60n79IsFrkGWlUAobVPVzrZbGmO1veKEI/0X0gR4Lp/a0QTf9AzaHR8FQlbAq
	nXXsxBAc9RiCe5bXcNer1kyVMu/nApkbm3/2P3/HVSU3AXSWQcUZXtBceqS/lTcd7s/aZmcJn0T
	RwNtouambyow37cB9srZKcQeUFjmD8VC5EgzhuL8KdAeiQ==
X-Google-Smtp-Source: AGHT+IFGyzHCzbT2iBAD+6faSIpe2YDQM6J6GhX2MNIXEjyioMqdXvwDn4OLiBk9ZvQGDE9MJOFHgA==
X-Received: by 2002:a05:6102:3594:b0:4c1:9e13:827c with SMTP id ada2fe7eead31-4c2e270969bmr3522493137.5.1741222695554;
        Wed, 05 Mar 2025 16:58:15 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86d33bc0065sm25925241.4.2025.03.05.16.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 16:58:14 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Wed, 05 Mar 2025 19:56:57 -0500
Subject: [PATCH v3 06/10] platform/x86: alienware-wmi-wmax: Add support for
 the "custom" thermal profile
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-hwm-v3-6-395e7a1407e2@gmail.com>
References: <20250305-hwm-v3-0-395e7a1407e2@gmail.com>
In-Reply-To: <20250305-hwm-v3-0-395e7a1407e2@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: Kurt Borja <kuurtb@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

All models with the "AWCC" WMAX device support a "custom" thermal
profile. In some models this profile signals user-space that the user
wants to manually control the fans, which are always unlocked. In other
models it actually unlocks manual fan control.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index a89fac80fa9e819e042f3807eb69dc8ddd9a4841..71fc17e8d103146b8edf53a552ae5ba64414e873 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -29,8 +29,6 @@
 #define AWCC_METHOD_THERMAL_CONTROL		0x15
 #define AWCC_METHOD_GAME_SHIFT_STATUS		0x25
 
-#define AWCC_THERMAL_MODE_GMODE			0xAB
-
 #define AWCC_FAILURE_CODE			0xFFFFFFFF
 #define AWCC_FAILURE_CODE_2			0xFFFFFFFE
 #define AWCC_THERMAL_TABLE_MASK			GENMASK(7, 4)
@@ -177,6 +175,11 @@ enum AWCC_THERMAL_TABLES {
 	AWCC_THERMAL_TABLE_USTT			= 0xA,
 };
 
+enum AWCC_SPECIAL_THERMAL_CODES {
+	AWCC_SPECIAL_PROFILE_CUSTOM		= 0x00,
+	AWCC_SPECIAL_PROFILE_GMODE		= 0xAB,
+};
+
 enum awcc_thermal_profile {
 	AWCC_PROFILE_USTT_BALANCED,
 	AWCC_PROFILE_USTT_BALANCED_PERFORMANCE,
@@ -577,7 +580,10 @@ static inline int awcc_op_activate_profile(struct wmi_device *wdev, u8 profile)
 static int awcc_profile_id_to_pprof(u32 id, enum platform_profile_option *profile)
 {
 	switch (id) {
-	case AWCC_THERMAL_MODE_GMODE:
+	case AWCC_SPECIAL_PROFILE_CUSTOM:
+		*profile = PLATFORM_PROFILE_CUSTOM;
+		return 0;
+	case AWCC_SPECIAL_PROFILE_GMODE:
 		*profile = PLATFORM_PROFILE_PERFORMANCE;
 		return 0;
 	default:
@@ -691,11 +697,17 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
 
 	if (awcc->gmode) {
 		priv->supported_profiles[PLATFORM_PROFILE_PERFORMANCE] =
-			AWCC_THERMAL_MODE_GMODE;
+			AWCC_SPECIAL_PROFILE_GMODE;
 
 		__set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
 	}
 
+	/* Every model supports the "custom" profile */
+	priv->supported_profiles[PLATFORM_PROFILE_CUSTOM] =
+		AWCC_SPECIAL_PROFILE_CUSTOM;
+
+	__set_bit(PLATFORM_PROFILE_CUSTOM, choices);
+
 	return 0;
 }
 

-- 
2.48.1


