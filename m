Return-Path: <linux-kernel+bounces-292658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A629095726C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A1A1C2324F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2D7188CAF;
	Mon, 19 Aug 2024 17:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bf1gkKNT"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B11D531
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724089958; cv=none; b=MEXeCYmy+uw+6R7xXunurm2q5zWTL8JWfSZz2vDDEl+YqukwprD8xTzLCE9kr+g1FMHl6pg2r6Z71dURHaVmYc4d6OufuxWeaGiMpH1lMiiNftGu9C51sAxkQFS4F9/V4GGrwUttv+gYHMkzEICSK1yhAWJa47TKqv2bfEuZoSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724089958; c=relaxed/simple;
	bh=y1QwZTuvE2ZkvmNKtJwqxK9L/MdUdDFAHSOWf/9ogNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gOqEYGGUcskl8Q0lXPuz2tqSQTU/CfLfHdp5jwUfLkooOkPKa7dAK1wjMgL9weByk6+R7z9q+2EQwSTLT3dp1/GTt7Cx1PYMP1J3/rHSh9rOcWq4Ee6jvp9BZ4jnlwpPboL+CQfVZ1Fain+sHjAZNHL7LtGqcuggS/zm3iISBic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bf1gkKNT; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d439583573so870879a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 10:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724089957; x=1724694757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vrl19mqws/+cluViI8m9rcTcYnyGlPjI1zYV7NRxDIE=;
        b=Bf1gkKNT5++KYPSUf0N81eylv6uAfbPEEjJb4QyvxEJ7QFzmzewVelidZBwHtefzlg
         8pfdpy+d9bTIzeBML9oub4jOefjmGmz8UQQR9TZzjXrh1wmPvdZiaykrR1xg5vknJjzo
         jmUNtNRKNzXaFOo8ZCa/x+Mz2RzdVJ8eflSLAt9iwrkbt97ZVQlzNA0DmMjoVZQZKq0r
         GnTAoCdBDrCEWpClKYigP75OEIz5mwey8ngcZ66dEeDHqKv90lU+21CZqYSoxQkmx1sk
         kZnTkV6vi9uePKWDJvdhXXR2y1IFG6/YofWcataU/xSl/IhJ06fV4Pz9j/rXu8UItDK1
         apJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724089957; x=1724694757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vrl19mqws/+cluViI8m9rcTcYnyGlPjI1zYV7NRxDIE=;
        b=rV3m+UrrtQd4eW0TvzMCcN9sgdxn6S/QfsFLHvV6Z8i92r8BALUU+pNcqZoSIEvHDS
         GT0pO3nphK5tUDuCrqfsccgn2jEBoEkIozDbPQou3S/KoUM/NMw3OwVpimKJ0NlWrIg0
         Hm6AMNFCsGiclUy2giWkOs+9eqHH5ZZeOCiA+mLOjPMHWRxzX8FY+ZmsJZ+DSiwWSgWw
         TQDxh5ZQNS7mAb+MVF5QhcI9YKWesYWbJVKaVpr/8SlmucUYj1qaXEImRK6gCRBgr49M
         pDvCGG5XDZgW/MWp1C19Z5SM2HaPwGDxjMbPdPQLUQ3oJo1YQ2l+dC6W5PjW50dCgNcY
         Dh4A==
X-Forwarded-Encrypted: i=1; AJvYcCUwvO6MCLNH0IUg3DY2FC+Omd43+am8SwIEnzBdtTdsJz0t0IumJ8c3S24lIX/WRz5e25E4epjn/jTFYRtzUZ1GBTblQZyZMPxYrk/P
X-Gm-Message-State: AOJu0Yw4n3PHYh8LtsVd82CzWIW+Z11zILOkopqQtjNgCPHJKy2AZlmt
	0W0qcoaqPd7IHB7eqCoJCSXk/ARoP57/+NVajmCsA11/J2Lcke9B
X-Google-Smtp-Source: AGHT+IHvY5FsJmcFyBLd68H463HEg+9AYFBSgdZgFa0Uo2yp0Vuaagu34O0T61d8e5QdpKKdaRHXNQ==
X-Received: by 2002:a17:90b:234f:b0:2cf:28c1:4cc9 with SMTP id 98e67ed59e1d1-2d3dfc2ae5bmr10731210a91.3.1724089956692;
        Mon, 19 Aug 2024 10:52:36 -0700 (PDT)
Received: from embed-PC.. ([106.222.231.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e317527csm7538297a91.26.2024.08.19.10.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 10:52:35 -0700 (PDT)
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: neil.armstrong@linaro.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: quic_jesszhan@quicinc.com,
	dri-devel@lists.freedesktop.org,
	skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/panel: ili9341: Add comments for registers in ili9341_config()
Date: Mon, 19 Aug 2024 23:21:22 +0530
Message-Id: <20240819175122.33176-1-abhishektamboli9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add detail comments for registers definitions in struct ili9341_config().
Replace TODO with comment for each registers.

Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
---
Changes in v2:
- Rephrased the commit message.

 drivers/gpu/drm/panel/panel-ilitek-ili9341.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
index 775d5d5e828c..1fbc5d433d75 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
@@ -121,19 +121,19 @@ struct ili9341_config {
 	const struct drm_display_mode mode;
 	/* ca: TODO: need comments for this register */
 	u8 ca[ILI9341_CA_LEN];
-	/* power_b: TODO: need comments for this register */
+	/* power_b: Power control B (CFh) */
 	u8 power_b[ILI9341_POWER_B_LEN];
-	/* power_seq: TODO: need comments for this register */
+	/* power_seq: Power on sequence control (EDh) */
 	u8 power_seq[ILI9341_POWER_SEQ_LEN];
-	/* dtca: TODO: need comments for this register */
+	/* dtca: Driver timing control A (E8h) */
 	u8 dtca[ILI9341_DTCA_LEN];
-	/* dtcb: TODO: need comments for this register */
+	/* dtcb: Driver timing control B (EAh) */
 	u8 dtcb[ILI9341_DTCB_LEN];
-	/* power_a: TODO: need comments for this register */
+	/* power_a: Power control A (CBh) */
 	u8 power_a[ILI9341_POWER_A_LEN];
 	/* frc: Frame Rate Control (In Normal Mode/Full Colors) (B1h) */
 	u8 frc[ILI9341_FRC_LEN];
-	/* prc: TODO: need comments for this register */
+	/* prc: Pump ratio control (F7h) */
 	u8 prc;
 	/* dfc_1: B6h DISCTRL (Display Function Control) */
 	u8 dfc_1[ILI9341_DFC_1_LEN];
@@ -147,7 +147,7 @@ struct ili9341_config {
 	u8 vcom_2;
 	/* address_mode: Memory Access Control (36h) */
 	u8 address_mode;
-	/* g3amma_en: TODO: need comments for this register */
+	/* g3amma_en: Enable 3G (F2h) */
 	u8 g3amma_en;
 	/* rgb_interface: RGB Interface Signal Control (B0h) */
 	u8 rgb_interface;
--
2.34.1


