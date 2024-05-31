Return-Path: <linux-kernel+bounces-197364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BC68D69C2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F9C1F28B90
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA0517F4F6;
	Fri, 31 May 2024 19:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VB7wcl3j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3781C6BD;
	Fri, 31 May 2024 19:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717183869; cv=none; b=ZQngLk/LRWY/UHWmtxWv3vVvloOCRaTWRqAkamubYQHsFjAMEJiPmookErKw2HFy5ypnmYd3/MkBTiZh2ObmmqafHS0fv84jrxLDZldmCVCJ931YtLuxkE3UStupYtegwMn2HbzbH4i/Tlvb8TjBH7pZrCSC6OQCavpuOvDLIzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717183869; c=relaxed/simple;
	bh=aQ8gzOeuRTghVVqbbLrrVe8iWbU0R6iLu7KgCeY1I2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IK7dM1DRMYTjTr+tuWNGpPmP26NZnXjfWTGbzcf1X2/S0sIzGDzgXJDtRjtDQsYK7BtlcTHXHqi6jIS9OESX15JSspKHRA5Tnp9HdTetOIoXqHQvzkVf8O/Wk+KM1FC/UxyQIi7S4w4p/47o20z89lwVNreeavXJ0ktu8TkkbiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VB7wcl3j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770BDC4AF08;
	Fri, 31 May 2024 19:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717183868;
	bh=aQ8gzOeuRTghVVqbbLrrVe8iWbU0R6iLu7KgCeY1I2Y=;
	h=From:To:Cc:Subject:Date:From;
	b=VB7wcl3js0H751wiNr6J+mwUtsOprAHtIuWmBg0P2MvFNrF0/nKQtgpsxF63vDVwC
	 HPcKYLhGD44OvOI1MpAghKd5Lk2AIdaNtkTFyWG2VbkDzfhqYTuv85DIlxS31mmBAb
	 zV5URaNzB01Eh+XNQHLv726Sv3qXqair9/aomH+ug5PhaaWIN+5N5fZbBiUcC/ixGo
	 c+BbD0aFrXcFZEbqbd+nMgokFQzxnDCTa9I9KqyTX1lYHhZ1TWiA71wwsCHrFB/XnX
	 gDdYwIBL5+wmtlqQb8q0ZvLqjDUeHBjQnsY9EsdRth4zna6zQfSndmUar39Y002IA8
	 KIjyddTRQTSgA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: openbmc@lists.ozlabs.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm: dts: nuvoton: Use standard 'i2c' bus node name
Date: Fri, 31 May 2024 14:31:04 -0500
Message-ID: <20240531193104.3814663-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The standard node name for I2C buses is 'i2c'.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../boot/dts/nuvoton/nuvoton-npcm730-kudo.dts | 22 +++++++++----------
 .../nuvoton-npcm750-runbmc-olympus.dts        | 22 +++++++++----------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dts b/arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dts
index 5787ae95d3b4..1f07ba382910 100644
--- a/arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dts
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dts
@@ -525,7 +525,7 @@ max31790@58 {
 			};
 		};
 
-		i2c-bus@4 {
+		i2c@4 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <4>;
@@ -537,7 +537,7 @@ lm75@5c {
 			};
 		};
 
-		i2c-bus@5 {
+		i2c@5 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <5>;
@@ -549,7 +549,7 @@ lm75@5c {
 			};
 		};
 
-		i2c-bus@6 {
+		i2c@6 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <6>;
@@ -561,7 +561,7 @@ lm75@5c {
 			};
 		};
 
-		i2c-bus@7 {
+		i2c@7 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <7>;
@@ -580,7 +580,7 @@ i2c-mux@77 {
 		reg = <0x77>;
 		i2c-mux-idle-disconnect;
 
-		i2c-bus@2 {
+		i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
@@ -620,7 +620,7 @@ i2c-mux@77 {
 		reg = <0x77>;
 		i2c-mux-idle-disconnect;
 
-		i2c-bus@0 {
+		i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
@@ -632,7 +632,7 @@ adm1266@40 {
 			};
 		};
 
-		i2c-bus@1 {
+		i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
@@ -691,7 +691,7 @@ i2c-mux@77 {
 		reg = <0x77>;
 		i2c-mux-idle-disconnect;
 
-		i2c-bus@3 {
+		i2c@3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <3>;
@@ -703,7 +703,7 @@ lm75@28 {
 			};
 		};
 
-		i2c-bus@4 {
+		i2c@4 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <4>;
@@ -715,7 +715,7 @@ lm75@29 {
 			};
 		};
 
-		i2c-bus@5 {
+		i2c@5 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <5>;
@@ -726,7 +726,7 @@ lm75@28 {
 				reg = <0x28>;
 			};
 		};
-		i2c-bus@6 {
+		i2c@6 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <6>;
diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dts b/arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dts
index baa39d0c1032..087f4ac43187 100644
--- a/arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dts
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dts
@@ -215,43 +215,43 @@ i2c-mux@70 {
 		reg = <0x70>;
 		i2c-mux-idle-disconnect;
 
-		i2c_slot1a: i2c-bus@0 {
+		i2c_slot1a: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
 		};
 
-		i2c_slot1b: i2c-bus@1 {
+		i2c_slot1b: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
 		};
 
-		i2c_slot2a: i2c-bus@2 {
+		i2c_slot2a: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
 		};
 
-		i2c_slot2b: i2c-bus@3 {
+		i2c_slot2b: i2c@3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <3>;
 		};
 
-		i2c_slot3: i2c-bus@4 {
+		i2c_slot3: i2c@4 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <4>;
 		};
 
-		i2c_slot4: i2c-bus@5 {
+		i2c_slot4: i2c@5 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <5>;
 		};
 
-		i2c_slot5: i2c-bus@6 {
+		i2c_slot5: i2c@6 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <6>;
@@ -265,24 +265,24 @@ i2c-mux@71 {
 		#size-cells = <0>;
 		i2c-mux-idle-disconnect;
 
-		i2c_m2_s1: i2c-bus@0 {
+		i2c_m2_s1: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
 		};
 
-		i2c_m2_s2: i2c-bus@1 {
+		i2c_m2_s2: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
 		};
-		i2c_m2_s3: i2c-bus@2 {
+		i2c_m2_s3: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
 		};
 
-		i2c_m2_s4: i2c-bus@3 {
+		i2c_m2_s4: i2c@3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <3>;
-- 
2.43.0


