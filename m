Return-Path: <linux-kernel+bounces-557227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740A5A5D559
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20603B195F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 05:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E741E8824;
	Wed, 12 Mar 2025 05:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NteUun+J"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7F51E5B7A;
	Wed, 12 Mar 2025 05:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741756334; cv=none; b=JH9EpTE9EJteW7BO8/OLp9QMmrFElDtdVU/No3h3TlGg01qGO7gUbkNABhUPzYSOzhOKwahmfZQo3vCZd+5N4qqOgrJOHep2/fNWTg4fOehEP0M3ROnGBrUSYT/z19/r2JiQmotXfRjx139lbVVDnW86qgpo2CT3NTxsK0CRX6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741756334; c=relaxed/simple;
	bh=/RVTDk95xTdgwIURpxctNMV56eIngqQ4/eX5yRQzsK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tj4UpkYS/dM8trTuGhGfDcHjqYCcJ4Ct53hgXcvC3oAT6wCzfe+/ztHbfw8YanDbyzUEgz5FZbZavnpkVzOguvWUBBrdL3G0WQLcuPWa1jYD6PQxO902gm4Nrrf6YO2ez+7CdtE5JhlIh/X+u9p2RO1oOEja61j66kMhA8GLQCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NteUun+J; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e63504bedd0so4528679276.0;
        Tue, 11 Mar 2025 22:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741756331; x=1742361131; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H43dqBGhipBxPHVP+jwxsicROhpGVr1mHnd5dBnGOsU=;
        b=NteUun+JL899DrJ7NPL0noTjsfvNIW4B8jWWLsTpb8GiuGa7IPiX0jDChnHzrP6v0r
         X6HIuywr+i7ddiMerF6SVdIvwbwG7mbaCfO/rxwxzjdLvkfaxPbb2U3zuMIfF06nvO+E
         4L/H7lhRl889jWgz5LYIC7IAjCcpv7SePK3fU3YNLmTcgkPaZLQ/OYdA2qPHSwZj188H
         83cdSuoIb2r/mf1zlPzzcrkMc+fWIiGmblkxjB46OEdy6o/wGlB8rCcs41EPeZsM8VSa
         m3GkAK0gNFBL//8i3Uhl5BvjdB77l4YWQevOWh10YONNEjDPHDU/ScDDr3r9wi0pFH04
         coHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741756331; x=1742361131;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H43dqBGhipBxPHVP+jwxsicROhpGVr1mHnd5dBnGOsU=;
        b=PTj6HETufNOdM9Y1UWpBtQaVxsbnr5XASFGlNhCLIURcDcToHV4GmnzXJgdFVbfGN4
         6s2eIa9ZZt2FQxPfUbbWPf7Y/k6+Ly4YOhbp8NgA3cOpWAsX1C5GBI22bKtNdcAVeG5V
         kVYsFfPgD/ohFramMajnJyjiqbjJbgBhdg1wlFDwQP5xfApgHwWkDQZWBOEnyLB+hpCl
         FIROz66wgTgwkeMCUmlRDPm/mRAOWHHmQ6kDjiYhHK+GSyIacXe4oglFkbqndiE1FHvo
         9MXIXt7yNrtYf9KnE94BX85qdHsBFb7iPixSq6BDQ/OquMF57PL4+Yc2RkHyGfRSc3Ix
         JJFg==
X-Forwarded-Encrypted: i=1; AJvYcCV8hA3s/9/74bjZb+7OuJEww4L9Z/mXy9LjdHPUf1V2irGQwVn1DHKFgIP1xEkkg076g3+HvP2L9p6hgY48WXdIuce+BA==@vger.kernel.org, AJvYcCWU852zeY1/wH99N1Es4NaW988RSvbmZdVXokXyuVkreQmWhQszu75jxBBR2LcHy6FoJt9hDAXRpNG44I0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPKDN48IJW7LyNFZ8qiaAm/KIHd3P8lCtIValTflRlqo1vLDyH
	MGpq9S5Xd2b3mXGK49AnqG10tWe7TcuoqRV6TyxIFpcxbhMoIaFHGwuM/UR9
X-Gm-Gg: ASbGnctbmI6HYSexP+oO/B6m2ilCO2ZhgTUYzDkq/7/mK9kE+IavVySnVcKSn5R0DEF
	T15TEJQDaAXfenULBbTw9sROL1IJrfuCZteylMGYDH8A31BS3OwGkyr+1OFYLY6ysrCxDwPVp/w
	vjjUT50s/4YXC0JqdhGkcPceZGmAwxK8JzaAsx6NdHBzGt2GjyAlvKBwnnmFS7dXRLsSKvOApke
	2icThbZSx2JCaR+DoZQMI0m8kU0bYO5PobVR3eSaJIQsRbFtZIPqa9Srkz24uWJbxUaGJ89YpCz
	v+3xN2RWvlitFT0nRBcoBLGApmdgnWi5L3W8YhPc9JY/aFOVCs34pacL
X-Google-Smtp-Source: AGHT+IH4Vu4OGMsGsx44C/OICTmAEU8UVkdKCjnypWyMPPD+9hifuXf5H/3pPZRe0qul97sQnepWtQ==
X-Received: by 2002:a05:690c:74c5:b0:6f7:5605:c62b with SMTP id 00721157ae682-6ff0925ec53mr89327537b3.27.1741756331513;
        Tue, 11 Mar 2025 22:12:11 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6feb2c46defsm29811287b3.105.2025.03.11.22.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 22:12:10 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Wed, 12 Mar 2025 00:11:19 -0500
Subject: [PATCH v5 06/12] platform/x86: alienware-wmi-wmax: Add support for
 the "custom" thermal profile
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-hwm-v5-6-deb15ff8f3c6@gmail.com>
References: <20250312-hwm-v5-0-deb15ff8f3c6@gmail.com>
In-Reply-To: <20250312-hwm-v5-0-deb15ff8f3c6@gmail.com>
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
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 0530f25b956f73f47c0354f40dac2910448c894e..3b37e4456482bc284b8e867c1c5b6255fc6c8ef2 100644
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
@@ -589,9 +592,15 @@ static int awcc_platform_profile_get(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (out_data == AWCC_THERMAL_MODE_GMODE) {
+	switch (out_data) {
+	case AWCC_SPECIAL_PROFILE_CUSTOM:
+		*profile = PLATFORM_PROFILE_CUSTOM;
+		return 0;
+	case AWCC_SPECIAL_PROFILE_GMODE:
 		*profile = PLATFORM_PROFILE_PERFORMANCE;
 		return 0;
+	default:
+		break;
 	}
 
 	if (!is_awcc_thermal_profile_id(out_data))
@@ -679,11 +688,17 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
 
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


