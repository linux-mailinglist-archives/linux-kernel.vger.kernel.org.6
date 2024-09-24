Return-Path: <linux-kernel+bounces-337226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB8198473C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FEC41F2204E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7831AAE36;
	Tue, 24 Sep 2024 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7u/PTOp"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094E41AAE20;
	Tue, 24 Sep 2024 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727186666; cv=none; b=LHeXV0vGDkq/2lhRMceRIcP00wdpDEEOliDL1TPg+vNRqFvQMpxcXB5vlPe0QecLQKFMUz0Q7auUP/syp6DdkyYuEG5+ncAoczf63/DQ8dR6d4xplA/kM00sDfmAxdu/wnLwlyiVUm5lqW0E1+3MgFdAkBENgtc2ij9fEuieYKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727186666; c=relaxed/simple;
	bh=xIKkk1U9nt1KsDn8aCu6JE2gkAes6ko1gfxzmaHOu58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RmkeVLMGcZzQE5z7PCRzwPgyPr0lmpYhCRemYZ4I+3YH9+awTBnvfoVz0SQ7apgZrqRin5fewfPokTITw+AY22YnCGh2ZPsH5lM/axSyYOhHDY0fWKgRBeXAZUR1UX/n1VxFpFsOEaV60VvpPNzYqrThuCa38nsu9B7f3usYBUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7u/PTOp; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2054feabfc3so50022275ad.1;
        Tue, 24 Sep 2024 07:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727186664; x=1727791464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJb8aZABYSBmntQ+6UkADO5FAAy4u7a9s+TPCadQ0vs=;
        b=f7u/PTOpUaN+NyGw7EuBx9da71Oz53AWRHM+gfB17ngdfEOfD5y5ntQG1Lkih4FTs5
         aW6scH9oULkFEL/G86jstJL0Ca9GiZGzID5MkK6vqo/sL6xfUUTd/1g1Pw6tlULKoQJO
         s1ZbH/0rWpWWZL5SL211DsU1YiXfNKTwROXp4gVom09t/9+zgjtHgVjoeLFYZKPfHMiW
         MnndjLuodBu/QkZmR8D7c3DhO9TAr7fF4oJfDhx52eaI6ZR517pQ9LzA828AmzKP9onQ
         G3FX2DJp5I472Hr2R3NKICJu1x0yG9O+jyk4++U/eIHJ6Za2l5RZch4PLSpUz5+Y/yDy
         veRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727186664; x=1727791464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJb8aZABYSBmntQ+6UkADO5FAAy4u7a9s+TPCadQ0vs=;
        b=wJrKAnB3XTAUZdERzCBPW9lczehNRyrnpfY76/nbaIO6prVlfIl7aYqmcHuEyV48gI
         hwyDYA6Ltj/l0mQrXrkYeMYpiIJS3UC570iqnXwGwfWG2ta3Q+o91s8X0q8jTPvca8bg
         ojReFJbIwIQq17WUSVsTH1SoMsjqfQrZgPqNwJhP4xm6ew5zACfiOeX1VahRBgPB9Brg
         /+K3tJBO97A+BfB1nJNGeo8wU9vMvcKIq/nNacn7qoW2P5pkuFQ5z10Ar0hWJ+MXQ4P+
         TXktQQQz0x4AdmxyUdc3A3hT06IFhagnYJO1cxfe5ppOS8JKbCKoZ8BW5YF96q9grCeW
         hVRw==
X-Forwarded-Encrypted: i=1; AJvYcCWBmnbkNkCDFhB8t7QJ3mvY/JJ++RgPAaGB91qigBM3AwBkhNRZZ/+EJ2XlZ/QU+cfv7YbkGIxEG50a@vger.kernel.org, AJvYcCWTzW25y114uBqsioyuEDUpNLDYiRcPJdF72s1efngXgkWcqaixZICa48k9G6NSInh/5UM1UxiD6H/KNnQW@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh0jGwdwL9RAsqvYJH8AiFufueeuhPROgva0Y+xahEzwJWQ321
	5imuEgR3QVjuL09R7DeoON198BZfPMgmmwatBQd/+4n2TerZp1fauUxCuA==
X-Google-Smtp-Source: AGHT+IEXdHTFlXFnRj377KtPfrX+3HJ7gnHzUxpEdufujqHROMYcYl3UGjRF7iJb1ZzzBRKU2AZZ4w==
X-Received: by 2002:a17:902:f68d:b0:206:ae88:417f with SMTP id d9443c01a7336-208d97f3346mr242164065ad.6.1727186664021;
        Tue, 24 Sep 2024 07:04:24 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af1821f33sm10678895ad.219.2024.09.24.07.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 07:04:23 -0700 (PDT)
From: Yang Chen <yangchen.openbmc@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	patrick@stwcx.xyz,
	amithash@meta.com
Cc: Jerry.Lin@quantatw.com,
	yangchen.openbmc@gmail.com
Subject: [PATCH v1 1/3] ARM: dts: aspeed: minerva: Revise the SGPIO line name
Date: Tue, 24 Sep 2024 22:02:13 +0800
Message-Id: <20240924140215.2484170-2-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240924140215.2484170-1-yangchen.openbmc@gmail.com>
References: <20240924140215.2484170-1-yangchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify the SGPIO line names sent from the CMM CPLD in the DVT version and
map the blade and FCB numbers to match the silkscreen labels on the rack as
follows:

1. Change the compute blade numbering from 0-15 to 1-16.
2. Change the network blade numbering from 0-5 to 1-6.
3. Update the FCB numbering from TOP0/1, MID0/1, and BOT0/1 to FCB1-6.
4. Revise the SGPIO line name for DVT changed.

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 110 +++++++++---------
 1 file changed, 55 insertions(+), 55 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 41e2246cfbd1..38eb42aaa98b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -627,7 +627,6 @@ &sgpiom0 {
 	gpio-line-names =
 	/*"input pin","output pin"*/
 	/*A0 - A7*/
-	"PRSNT_MTIA_BLADE0_N","PWREN_MTIA_BLADE0_EN_N",
 	"PRSNT_MTIA_BLADE1_N","PWREN_MTIA_BLADE1_EN_N",
 	"PRSNT_MTIA_BLADE2_N","PWREN_MTIA_BLADE2_EN_N",
 	"PRSNT_MTIA_BLADE3_N","PWREN_MTIA_BLADE3_EN_N",
@@ -635,8 +634,8 @@ &sgpiom0 {
 	"PRSNT_MTIA_BLADE5_N","PWREN_MTIA_BLADE5_EN_N",
 	"PRSNT_MTIA_BLADE6_N","PWREN_MTIA_BLADE6_EN_N",
 	"PRSNT_MTIA_BLADE7_N","PWREN_MTIA_BLADE7_EN_N",
-	/*B0 - B7*/
 	"PRSNT_MTIA_BLADE8_N","PWREN_MTIA_BLADE8_EN_N",
+	/*B0 - B7*/
 	"PRSNT_MTIA_BLADE9_N","PWREN_MTIA_BLADE9_EN_N",
 	"PRSNT_MTIA_BLADE10_N","PWREN_MTIA_BLADE10_EN_N",
 	"PRSNT_MTIA_BLADE11_N","PWREN_MTIA_BLADE11_EN_N",
@@ -644,80 +643,80 @@ &sgpiom0 {
 	"PRSNT_MTIA_BLADE13_N","PWREN_MTIA_BLADE13_EN_N",
 	"PRSNT_MTIA_BLADE14_N","PWREN_MTIA_BLADE14_EN_N",
 	"PRSNT_MTIA_BLADE15_N","PWREN_MTIA_BLADE15_EN_N",
+	"PRSNT_MTIA_BLADE16_N","PWREN_MTIA_BLADE16_EN_N",
 	/*C0 - C7*/
-	"PRSNT_NW_BLADE0_N","PWREN_NW_BLADE0_EN_N",
 	"PRSNT_NW_BLADE1_N","PWREN_NW_BLADE1_EN_N",
 	"PRSNT_NW_BLADE2_N","PWREN_NW_BLADE2_EN_N",
 	"PRSNT_NW_BLADE3_N","PWREN_NW_BLADE3_EN_N",
 	"PRSNT_NW_BLADE4_N","PWREN_NW_BLADE4_EN_N",
 	"PRSNT_NW_BLADE5_N","PWREN_NW_BLADE5_EN_N",
-	"PRSNT_FCB_TOP_0_N","PWREN_MTIA_BLADE0_HSC_EN_N",
-	"PRSNT_FCB_TOP_1_N","PWREN_MTIA_BLADE1_HSC_EN_N",
+	"PRSNT_NW_BLADE6_N","PWREN_NW_BLADE6_EN_N",
+	"PRSNT_FCB_1_N","PWREN_MTIA_BLADE1_HSC_EN_N",
+	"PRSNT_FCB_2_N","PWREN_MTIA_BLADE2_HSC_EN_N",
 	/*D0 - D7*/
-	"PRSNT_FCB_MIDDLE_0_N","PWREN_MTIA_BLADE2_HSC_EN_N",
-	"PRSNT_FCB_MIDDLE_1_N","PWREN_MTIA_BLADE3_HSC_EN_N",
-	"PRSNT_FCB_BOTTOM_1_N","PWREN_MTIA_BLADE4_HSC_EN_N",
-	"PRSNT_FCB_BOTTOM_0_N","PWREN_MTIA_BLADE5_HSC_EN_N",
-	"PWRGD_MTIA_BLADE0_PWROK_N","PWREN_MTIA_BLADE6_HSC_EN_N",
+	"PRSNT_FCB_3_N","PWREN_MTIA_BLADE3_HSC_EN_N",
+	"PRSNT_FCB_4_N","PWREN_MTIA_BLADE4_HSC_EN_N",
+	"PRSNT_FCB_6_N","PWREN_MTIA_BLADE5_HSC_EN_N",
+	"PRSNT_FCB_5_N","PWREN_MTIA_BLADE6_HSC_EN_N",
 	"PWRGD_MTIA_BLADE1_PWROK_N","PWREN_MTIA_BLADE7_HSC_EN_N",
 	"PWRGD_MTIA_BLADE2_PWROK_N","PWREN_MTIA_BLADE8_HSC_EN_N",
 	"PWRGD_MTIA_BLADE3_PWROK_N","PWREN_MTIA_BLADE9_HSC_EN_N",
-	/*E0 - E7*/
 	"PWRGD_MTIA_BLADE4_PWROK_N","PWREN_MTIA_BLADE10_HSC_EN_N",
+	/*E0 - E7*/
 	"PWRGD_MTIA_BLADE5_PWROK_N","PWREN_MTIA_BLADE11_HSC_EN_N",
 	"PWRGD_MTIA_BLADE6_PWROK_N","PWREN_MTIA_BLADE12_HSC_EN_N",
 	"PWRGD_MTIA_BLADE7_PWROK_N","PWREN_MTIA_BLADE13_HSC_EN_N",
 	"PWRGD_MTIA_BLADE8_PWROK_N","PWREN_MTIA_BLADE14_HSC_EN_N",
 	"PWRGD_MTIA_BLADE9_PWROK_N","PWREN_MTIA_BLADE15_HSC_EN_N",
-	"PWRGD_MTIA_BLADE10_PWROK_N","PWREN_NW_BLADE0_HSC_EN_N",
+	"PWRGD_MTIA_BLADE10_PWROK_N","PWREN_MTIA_BLADE16_HSC_EN_N",
 	"PWRGD_MTIA_BLADE11_PWROK_N","PWREN_NW_BLADE1_HSC_EN_N",
-	/*F0 - F7*/
 	"PWRGD_MTIA_BLADE12_PWROK_N","PWREN_NW_BLADE2_HSC_EN_N",
+	/*F0 - F7*/
 	"PWRGD_MTIA_BLADE13_PWROK_N","PWREN_NW_BLADE3_HSC_EN_N",
 	"PWRGD_MTIA_BLADE14_PWROK_N","PWREN_NW_BLADE4_HSC_EN_N",
 	"PWRGD_MTIA_BLADE15_PWROK_N","PWREN_NW_BLADE5_HSC_EN_N",
-	"PWRGD_NW_BLADE0_PWROK_N","PWREN_FCB_TOP_0_EN_N",
-	"PWRGD_NW_BLADE1_PWROK_N","PWREN_FCB_TOP_1_EN_N",
-	"PWRGD_NW_BLADE2_PWROK_N","PWREN_FCB_MIDDLE_0_EN_N",
-	"PWRGD_NW_BLADE3_PWROK_N","PWREN_FCB_MIDDLE_1_EN_N",
+	"PWRGD_MTIA_BLADE16_PWROK_N","PWREN_NW_BLADE6_HSC_EN_N",
+	"PWRGD_NW_BLADE1_PWROK_N","PWREN_SGPIO_FCB_2_EN_N",
+	"PWRGD_NW_BLADE2_PWROK_N","PWREN_SGPIO_FCB_1_EN_N",
+	"PWRGD_NW_BLADE3_PWROK_N","PWREN_SGPIO_FCB_4_EN_N",
+	"PWRGD_NW_BLADE4_PWROK_N","PWREN_SGPIO_FCB_3_EN_N",
 	/*G0 - G7*/
-	"PWRGD_NW_BLADE4_PWROK_N","PWREN_FCB_BOTTOM_1_EN_N",
-	"PWRGD_NW_BLADE5_PWROK_N","PWREN_FCB_BOTTOM_0_EN_N",
-	"PWRGD_FCB_TOP_0_PWROK_N","FM_CMM_AC_CYCLE_N",
-	"PWRGD_FCB_TOP_1_PWROK_N","MGMT_SFP_TX_DIS",
-	"PWRGD_FCB_MIDDLE_0_PWROK_N","FM_MDIO_SW_SEL",
-	"PWRGD_FCB_MIDDLE_1_PWROK_N","FM_P24V_SMPWR_EN",
-	"PWRGD_FCB_BOTTOM_1_PWROK_N","",
-	"PWRGD_FCB_BOTTOM_0_PWROK_N","",
+	"PWRGD_NW_BLADE5_PWROK_N","PWREN_SGPIO_FCB_5_EN_N",
+	"PWRGD_NW_BLADE6_PWROK_N","PWREN_SGPIO_FCB_6_EN_N",
+	"PWRGD_FCB_1","FM_BMC_RST_RTCRST_R",
+	"PWRGD_FCB_2","",
+	"PWRGD_FCB_3","FM_MDIO_SW_SEL",
+	"PWRGD_FCB_4","FM_P24V_SMPWR_EN",
+	"PWRGD_FCB_6","",
+	"PWRGD_FCB_5","",
 	/*H0 - H7*/
-	"LEAK_DETECT_MTIA_BLADE0_N","",
 	"LEAK_DETECT_MTIA_BLADE1_N","",
 	"LEAK_DETECT_MTIA_BLADE2_N","",
 	"LEAK_DETECT_MTIA_BLADE3_N","",
 	"LEAK_DETECT_MTIA_BLADE4_N","",
 	"LEAK_DETECT_MTIA_BLADE5_N","",
 	"LEAK_DETECT_MTIA_BLADE6_N","",
-	"LEAK_DETECT_MTIA_BLADE7_N","",
+	"LEAK_DETECT_MTIA_BLADE7_N","ERR_INJECT_CMM_PWR_FAIL_N",
+	"LEAK_DETECT_MTIA_BLADE8_N","",
 	/*I0 - I7*/
-	"LEAK_DETECT_MTIA_BLADE8_N","RST_I2CRST_FCB_BOTTOM_1_N",
-	"LEAK_DETECT_MTIA_BLADE9_N","RST_I2CRST_FCB_BOTTOM_0_N",
-	"LEAK_DETECT_MTIA_BLADE10_N","RST_I2CRST_FCB_MIDDLE_0_N",
-	"LEAK_DETECT_MTIA_BLADE11_N","RST_I2CRST_FCB_MIDDLE_1_N",
-	"LEAK_DETECT_MTIA_BLADE12_N","RST_I2CRST_FCB_TOP_0_N",
-	"LEAK_DETECT_MTIA_BLADE13_N","RST_I2CRST_FCB_TOP_1_N",
-	"LEAK_DETECT_MTIA_BLADE14_N","BMC_READY",
-	"LEAK_DETECT_MTIA_BLADE15_N","FM_88E6393X_BIN_UPDATE_EN_N",
+	"LEAK_DETECT_MTIA_BLADE9_N","RST_I2CRST_FCB_5_N",
+	"LEAK_DETECT_MTIA_BLADE10_N","RST_I2CRST_FCB_6_N",
+	"LEAK_DETECT_MTIA_BLADE11_N","RST_I2CRST_FCB_4_N",
+	"LEAK_DETECT_MTIA_BLADE12_N","RST_I2CRST_FCB_3_N",
+	"LEAK_DETECT_MTIA_BLADE13_N","RST_I2CRST_FCB_2_N",
+	"LEAK_DETECT_MTIA_BLADE14_N","RST_I2CRST_FCB_1_N",
+	"LEAK_DETECT_MTIA_BLADE15_N","BMC_READY",
+	"LEAK_DETECT_MTIA_BLADE16_N","FM_88E6393X_BIN_UPDATE_EN_N",
 	/*J0 - J7*/
-	"LEAK_DETECT_NW_BLADE0_N","WATER_VALVE_CLOSED_N",
-	"LEAK_DETECT_NW_BLADE1_N","",
+	"LEAK_DETECT_NW_BLADE1_N","WATER_VALVE_CLOSED_N",
 	"LEAK_DETECT_NW_BLADE2_N","",
 	"LEAK_DETECT_NW_BLADE3_N","",
 	"LEAK_DETECT_NW_BLADE4_N","",
 	"LEAK_DETECT_NW_BLADE5_N","",
-	"PWRGD_MTIA_BLADE0_HSC_PWROK_N","",
+	"LEAK_DETECT_NW_BLADE6_N","",
 	"PWRGD_MTIA_BLADE1_HSC_PWROK_N","",
-	/*K0 - K7*/
 	"PWRGD_MTIA_BLADE2_HSC_PWROK_N","",
+	/*K0 - K7*/
 	"PWRGD_MTIA_BLADE3_HSC_PWROK_N","",
 	"PWRGD_MTIA_BLADE4_HSC_PWROK_N","",
 	"PWRGD_MTIA_BLADE5_HSC_PWROK_N","",
@@ -725,49 +724,50 @@ &sgpiom0 {
 	"PWRGD_MTIA_BLADE7_HSC_PWROK_N","",
 	"PWRGD_MTIA_BLADE8_HSC_PWROK_N","",
 	"PWRGD_MTIA_BLADE9_HSC_PWROK_N","",
-	/*L0 - L7*/
 	"PWRGD_MTIA_BLADE10_HSC_PWROK_N","",
+	/*L0 - L7*/
 	"PWRGD_MTIA_BLADE11_HSC_PWROK_N","",
 	"PWRGD_MTIA_BLADE12_HSC_PWROK_N","",
 	"PWRGD_MTIA_BLADE13_HSC_PWROK_N","",
 	"PWRGD_MTIA_BLADE14_HSC_PWROK_N","",
 	"PWRGD_MTIA_BLADE15_HSC_PWROK_N","",
-	"PWRGD_NW_BLADE0_HSC_PWROK_N","",
+	"PWRGD_MTIA_BLADE16_HSC_PWROK_N","",
 	"PWRGD_NW_BLADE1_HSC_PWROK_N","",
-	/*M0 - M7*/
 	"PWRGD_NW_BLADE2_HSC_PWROK_N","",
+	/*M0 - M7*/
 	"PWRGD_NW_BLADE3_HSC_PWROK_N","",
 	"PWRGD_NW_BLADE4_HSC_PWROK_N","",
 	"PWRGD_NW_BLADE5_HSC_PWROK_N","",
+	"PWRGD_NW_BLADE6_HSC_PWROK_N","",
 	"RPU_READY","",
 	"IT_GEAR_RPU_LINK_N","",
 	"IT_GEAR_LEAK","",
 	"WATER_VALVE_CLOSED_N","",
 	/*N0 - N7*/
-	"VALVE_STS0","",
-	"VALVE_STS1","",
-	"PCA9555_IRQ0_N","",
+	"VALVE_STATUS_0","",
+	"VALVE_STATUS_1","",
 	"PCA9555_IRQ1_N","",
+	"PCA9555_IRQ2_N","",
 	"CR_TOGGLE_BOOT_N","",
-	"IRQ_FCB_TOP0_N","",
-	"IRQ_FCB_TOP1_N","",
+	"IRQ_FCB_1_N","",
+	"IRQ_FCB_2_N","",
 	"CMM_CABLE_CARTRIDGE_PRSNT_BOT_N","",
 	/*O0 - O7*/
 	"CMM_CABLE_CARTRIDGE_PRSNT_TOP_N","",
 	"BOT_BCB_CABLE_PRSNT_N","",
 	"TOP_BCB_CABLE_PRSNT_N","",
-	"IRQ_FCB_MID0_N","",
-	"IRQ_FCB_MID1_N","",
+	"IRQ_FCB_3_N","",
+	"IRQ_FCB_4_N","",
 	"CHASSIS_LEAK0_DETECT_N","",
 	"CHASSIS_LEAK1_DETECT_N","",
-	"VALVE_RMON_A_1","",
+	"PCA9555_IRQ3_N","",
 	/*P0 - P7*/
-	"VALVE_RMON_A_2","",
-	"VALVE_RMON_B_1","",
-	"VALVE_RMON_B_2","",
+	"PCA9555_IRQ4_N","",
+	"PCA9555_IRQ5_N","",
+	"CMM_AC_PWR_BTN_N","",
 	"RPU_READY_SPARE","",
 	"IT_GEAR_LEAK_SPARE","",
 	"IT_GEAR_RPU_LINK_SPARE_N","",
-	"IRQ_FCB_BOT0_N","",
-	"IRQ_FCB_BOT0_N","";
+	"IRQ_FCB_6_N","",
+	"IRQ_FCB_5_N","";
 };
-- 
2.34.1


