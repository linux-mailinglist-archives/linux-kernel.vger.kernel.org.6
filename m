Return-Path: <linux-kernel+bounces-535018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE17A46DDE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 796377A6C60
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2B325D520;
	Wed, 26 Feb 2025 21:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJ/wYJ72"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9061E25A2DB;
	Wed, 26 Feb 2025 21:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740606487; cv=none; b=FKFmTD3gBmG1j3P1Ze2Z0ReHrZZC9xisxbsp51P0PgKyWjnxGnoabK5RDfo2zAL+zMyCla4XMk9wYESi3CV9Yhs/AvsFZRC4k+VFLyNjLFT4F7eQxKkfUgA+xOmAKnFOS+r7RBIin9o9kRh3DLTBN43ACdKel63Zap3/Rm3fs4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740606487; c=relaxed/simple;
	bh=NdZQtJa0ZOh04+9rg2b+zZfqMIh7fGLxHzRoGo/wQPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iVFIxoML6V5YfKdGpmwdF2ettLaN3CsyA5zrO7O5RpnI05CxkPeV4qvRMFa0PrMbWPk08TtmrzyGBqmyHbKtpceurPwAO5lO7lvdPX5wW/Y2QiLJIQtskqVRRu3f9lBrBdY7Bq6am8bGTGYmrLc7qjWto/c7vFDAL+FvmOjUHW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJ/wYJ72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FA4C4CEE7;
	Wed, 26 Feb 2025 21:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740606487;
	bh=NdZQtJa0ZOh04+9rg2b+zZfqMIh7fGLxHzRoGo/wQPU=;
	h=From:To:Cc:Subject:Date:From;
	b=hJ/wYJ72T5RjKXMzhBQJarDAqsDZESzXnWGIjAbWtskg4RFrSB1wSsRzLLfPPFmHd
	 5/ov6wSvD3YRa31Acss5MehJj3HvVsIf5wBLA4ewCwy6PwlHUCiSg+RsvGkTh3WbhC
	 ZLPnew8efhF0m/r613hL1raarFRkutVCivDeeoBHPQcay7UXwDpGmzDDkbM1/EVfvN
	 udlPIhr9CJz1HIO0uq9mERN9PHo/3xTE7M+pd8i6fiqta6dq/SkAbbRJgDioD/x37Q
	 K6On/LrCyU36pLcSw5hTrV2OKUd4VbsdZbD7mwxtMxJAvJT0MagtYKC/ha7yVPFX6l
	 aW90udr+qvjQg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: marvell: Move arch timer and pmu nodes to top-level
Date: Wed, 26 Feb 2025 15:47:47 -0600
Message-ID: <20250226214751.3751865-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Arm arch timer and PMU are not memory-mapped peripherals, and
therefore should not be under a "simple-bus" node. Move them to the
top-level like other platforms.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi | 29 ++++++++++---------
 .../boot/dts/marvell/armada-ap810-ap0.dtsi    | 18 ++++++------
 2 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
index fdf88cd0eb02..e206d03a2867 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
@@ -48,6 +48,21 @@ tee@4400000 {
 		};
 	};
 
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a72-pmu";
+		interrupt-parent = <&pic>;
+		interrupts = <17>;
+	};
+
 	AP_NAME {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -122,20 +137,6 @@ gic_v2m3: v2m@2b0000 {
 				};
 			};
 
-			timer {
-				compatible = "arm,armv8-timer";
-				interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-					     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-					     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-					     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
-			};
-
-			pmu {
-				compatible = "arm,cortex-a72-pmu";
-				interrupt-parent = <&pic>;
-				interrupts = <17>;
-			};
-
 			odmi: odmi@300000 {
 				compatible = "marvell,odmi-controller";
 				msi-controller;
diff --git a/arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi b/arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi
index 2f9ab6b4a2c9..f5a89af154d4 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi
@@ -14,6 +14,7 @@ / {
 	compatible = "marvell,armada-ap810";
 	#address-cells = <2>;
 	#size-cells = <2>;
+	interrupt-parent = <&gic>;
 
 	aliases {
 		serial0 = &uart0_ap0;
@@ -25,11 +26,18 @@ psci {
 		method = "smc";
 	};
 
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+				<GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+				<GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+				<GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+
 	ap810-ap0 {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		compatible = "simple-bus";
-		interrupt-parent = <&gic>;
 		ranges;
 
 		config-space@e8000000 {
@@ -62,14 +70,6 @@ gic_its_ap0: msi-controller@3040000 {
 				};
 			};
 
-			timer {
-				compatible = "arm,armv8-timer";
-				interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
-					     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
-					     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
-					     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
-			};
-
 			xor@400000 {
 				compatible = "marvell,armada-7k-xor", "marvell,xor-v2";
 				reg = <0x400000 0x1000>,
-- 
2.47.2


