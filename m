Return-Path: <linux-kernel+bounces-220835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C775390E7EF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5174E282310
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4E082890;
	Wed, 19 Jun 2024 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4aqWOsB"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3FE824B2;
	Wed, 19 Jun 2024 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718791860; cv=none; b=UNth2eN9sCIHllF2DougUgufOXvGNmyve44qBcVEfLHWwJm98CtSxnyNeE+29iGMDXSiCWOiKZINzFV5/kAcIaYBxQBoBRDOxH9Ww1Bdu5x1fYKrO/P5xgzLsDZyo6cjbf6zdlgbuOHiD1C6RD/7PH3uy7uhaiwcnEkds7J9aAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718791860; c=relaxed/simple;
	bh=0rAZYQHhp2RqKaZAMHmpDf0sdQTZ9FI3Tx8uRVuGaVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oJYKPEvbTx1N0PL3/Z3FWBlsN7ed167/w1EwgcMr4716slcTpAKE/GmgkqbVRZaE82lyYQY7wKTuFbytMEGTnVfUGvu8mel6tye0h7rbTGdL/pSuzzNCLz0UxO0y6utB7uAPbLVLm9LMjRLmdmnx9wqqVAQLs6Lre2K7vOKB2K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4aqWOsB; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6b50aeb2f31so852716d6.0;
        Wed, 19 Jun 2024 03:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718791856; x=1719396656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YE3Lrkv65eZljuEfFBOSDNEGg8fn6zSJ9y1iJWCoGl4=;
        b=H4aqWOsBMBp4Wd9w/fpOKHFBVRanHukuL78KFjfySw9y7RAWKRqbqRMAo0vKGRhXOV
         7GtP82J7WmwNDY/foWnekc2tcksqfWiV7i+2b7uDkdT+Q4lFfXeHcxMa9U+GFsR7Agee
         cvW0aTD/9we+fZTVAtV7MSKIQ7+/Anw67TO2inAxKlAK/0q5Vu51yWt5wgM8pGMmsRxh
         Nx2ToDn8ehGPmpr5P9KPcIhGRq32wUmD42pHtAy5jbJodmlolS9GeiLTh1V+shy1C78M
         EKnFkRAHii9w1BZ5jNvtCjXysxRmLy0PG0rVMZrj0wMTA5GcSRreEaXNRtq30hoT7eBz
         FZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718791856; x=1719396656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YE3Lrkv65eZljuEfFBOSDNEGg8fn6zSJ9y1iJWCoGl4=;
        b=Se02DcJhKYkLtwP/CVPr8N/YCyJ7nH4QweOc2pzzvxA4Q1UOwLn8+msDdFjH3WpmdM
         s+NQKxbttHy7HvFpo2bZBLTmjwaW14Ox9wcL7GKuBmTx9ED0haYBb9+CwJym2Firvk+L
         BIDiuB+HoFAHMesENapLQgOH0wW7+5JHxF8G28uaG2q6r+2sEEXRy2cdqXfD/bSP6DQK
         wGEmmNeZwMeCB/bU2iHDhdI5AoaMTE8oe2LgRgmzEW5JOHWWYcIrOLdMiqhDz+V9IRKP
         L7u5VAWKZc2Z8iM7MdZoGYMz3/rSognQZwFp7axJZfmv9GZUP6OKs8Qcb54C0nuCBg6O
         Wing==
X-Forwarded-Encrypted: i=1; AJvYcCWPGVav/cBL4TVQ3GsTS+HzaAuK1556zCrJoWYD+KTMJPH+mRFxHXTQOGC2WjyfyVU8bqdeSqYNgCoT4fC/AOFlUQmk40IJFp+cNaQ6Vna900PL7UL/iwxCEaUclqril/mHshuq/oX7rA==
X-Gm-Message-State: AOJu0YzDvYOAfDnLks0dLtY0EdbPyE+FAh1jRiiOEFUZFqMBAnbnoILv
	6ndctIjRhqLNoJOktbjqDsKSBrcRABFqSHfu8IVO0t6NIMNFHwcm
X-Google-Smtp-Source: AGHT+IF3P4/l4f+Swlmr4ZOd+VRtcUR3F56EYW5FRGDbYrofYG5NpSJT71LRl1xwlRdhpgjRnFFf7A==
X-Received: by 2002:a0c:dc13:0:b0:6b0:7e44:c89 with SMTP id 6a1803df08f44-6b501ec345emr23691296d6.60.1718791855961;
        Wed, 19 Jun 2024 03:10:55 -0700 (PDT)
Received: from aford-System-Version.lan ([2601:447:d002:5be:82:66f1:d3bb:c66f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c2fbbasm74734976d6.60.2024.06.19.03.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 03:10:55 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Peng Fan <peng.fan@nxp.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mp: Fix pgc vpu locations
Date: Wed, 19 Jun 2024 05:10:44 -0500
Message-ID: <20240619101045.6317-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The various pgv_vpu nodes have a mismatch between the value after
the @ symbol and what is referenced by 'reg' so reorder the nodes
to align.

Fixes: df680992dd62 ("arm64: dts: imx8mp: add vpu pgc nodes")
Suggested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 3576d2b89b43..ee0c864f27e8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -838,6 +838,12 @@ pgc_gpumix: power-domain@7 {
 						assigned-clock-rates = <800000000>, <400000000>;
 					};
 
+					pgc_vpumix: power-domain@8 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MP_POWER_DOMAIN_VPUMIX>;
+						clocks = <&clk IMX8MP_CLK_VPU_ROOT>;
+					};
+
 					pgc_gpu3d: power-domain@9 {
 						#power-domain-cells = <0>;
 						reg = <IMX8MP_POWER_DOMAIN_GPU3D>;
@@ -853,6 +859,28 @@ pgc_mediamix: power-domain@10 {
 							 <&clk IMX8MP_CLK_MEDIA_APB_ROOT>;
 					};
 
+					pgc_vpu_g1: power-domain@11 {
+						#power-domain-cells = <0>;
+						power-domains = <&pgc_vpumix>;
+						reg = <IMX8MP_POWER_DOMAIN_VPU_G1>;
+						clocks = <&clk IMX8MP_CLK_VPU_G1_ROOT>;
+					};
+
+					pgc_vpu_g2: power-domain@12 {
+						#power-domain-cells = <0>;
+						power-domains = <&pgc_vpumix>;
+						reg = <IMX8MP_POWER_DOMAIN_VPU_G2>;
+						clocks = <&clk IMX8MP_CLK_VPU_G2_ROOT>;
+
+					};
+
+					pgc_vpu_vc8000e: power-domain@13 {
+						#power-domain-cells = <0>;
+						power-domains = <&pgc_vpumix>;
+						reg = <IMX8MP_POWER_DOMAIN_VPU_VC8000E>;
+						clocks = <&clk IMX8MP_CLK_VPU_VC8KE_ROOT>;
+					};
+
 					pgc_hdmimix: power-domain@14 {
 						#power-domain-cells = <0>;
 						reg = <IMX8MP_POWER_DOMAIN_HDMIMIX>;
@@ -890,33 +918,6 @@ pgc_ispdwp: power-domain@18 {
 						reg = <IMX8MP_POWER_DOMAIN_MEDIAMIX_ISPDWP>;
 						clocks = <&clk IMX8MP_CLK_MEDIA_ISP_ROOT>;
 					};
-
-					pgc_vpumix: power-domain@19 {
-						#power-domain-cells = <0>;
-						reg = <IMX8MP_POWER_DOMAIN_VPUMIX>;
-						clocks = <&clk IMX8MP_CLK_VPU_ROOT>;
-					};
-
-					pgc_vpu_g1: power-domain@20 {
-						#power-domain-cells = <0>;
-						power-domains = <&pgc_vpumix>;
-						reg = <IMX8MP_POWER_DOMAIN_VPU_G1>;
-						clocks = <&clk IMX8MP_CLK_VPU_G1_ROOT>;
-					};
-
-					pgc_vpu_g2: power-domain@21 {
-						#power-domain-cells = <0>;
-						power-domains = <&pgc_vpumix>;
-						reg = <IMX8MP_POWER_DOMAIN_VPU_G2>;
-						clocks = <&clk IMX8MP_CLK_VPU_G2_ROOT>;
-					};
-
-					pgc_vpu_vc8000e: power-domain@22 {
-						#power-domain-cells = <0>;
-						power-domains = <&pgc_vpumix>;
-						reg = <IMX8MP_POWER_DOMAIN_VPU_VC8000E>;
-						clocks = <&clk IMX8MP_CLK_VPU_VC8KE_ROOT>;
-					};
 				};
 			};
 		};
-- 
2.43.0


