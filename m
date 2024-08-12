Return-Path: <linux-kernel+bounces-283832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C0F94F927
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76F8280D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29806194AE6;
	Mon, 12 Aug 2024 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B09Inydf"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94AA194A57
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 21:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723499499; cv=none; b=kZ9isVWYLw3zCv4+7chSzmI6H/Uub0lPhyGkZ/u8HP/kqFYAdoKiRIeahVwb1v3VEoFeos4tCbfVXD4ylglErRE6DgwVqg20LCvG+YJGmxNzrSu7pw9DtWYrC38nYPTmyz8kCf/GYiFebeTZhVNlMmbKeuQ0TaT0kvf4LXUzLWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723499499; c=relaxed/simple;
	bh=seu4LYCtD/MjdKXAImxqApty22iI1q5LuF6tnzcbcq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lrsBLJ1TYKn+sE5XZ3PMG0R1iI6UZk/VhQA8U8Sh2y0AbVwLObiV0POCxgQ8vyvR9l3eZiNase1jlWIGaWfGFVYaX06cSnhaN8AMstYpvvwJghvag5GnLAJTyYyivIhT7yVk5nr/fNz5Ry6f8sEyB4xOeW/aGwmhZKRQdn8llKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B09Inydf; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723499495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aUqRk78dmQCyt5RCBpbNSmaxWSsGR3LZo+GmyqABbYs=;
	b=B09InydfLqugPRGwlNrpmfjKsJYoyfFKke4Uu14llQqEEAzw2tV2xkXOlucBAHeLUKFPHM
	NXMh49fskuonnh8Kg19Oa0xhstcnW+bwpOKE6S0txupTpb6AtR+P9bOCwO9MnuKSnysIWi
	YojkjyqbU9bSojrj7cgMiHqMU8Q4hLk=
From: Sean Anderson <sean.anderson@linux.dev>
To: Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 1/3] arm64: zynqmp: Enable AMS for all boards
Date: Mon, 12 Aug 2024 17:51:26 -0400
Message-Id: <20240812215129.3599832-2-sean.anderson@linux.dev>
In-Reply-To: <20240812215129.3599832-1-sean.anderson@linux.dev>
References: <20240812215129.3599832-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The AMS does not rely on external hardware or features, so it can be
enabled unconditionally.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts | 4 ----
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 4 ----
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 4 ----
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts | 4 ----
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts | 4 ----
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi            | 1 -
 6 files changed, 21 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
index 86e6c4990560..4e0e7fdf29ca 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
@@ -366,10 +366,6 @@ &gpio {
 			  "", "", "", ""; /* 170 - 173 */
 };
 
-&xilinx_ams {
-	status = "okay";
-};
-
 &ams_ps {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index c5945067cd57..62c2503a502a 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -590,10 +590,6 @@ &watchdog0 {
 	status = "okay";
 };
 
-&xilinx_ams {
-	status = "okay";
-};
-
 &ams_ps {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index ad8f23a0ec67..ec1d3be703c0 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -1027,10 +1027,6 @@ &watchdog0 {
 	status = "okay";
 };
 
-&xilinx_ams {
-	status = "okay";
-};
-
 &ams_ps {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
index b1eca1bb6a63..eb2090673ec1 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
@@ -511,10 +511,6 @@ &watchdog0 {
 	status = "okay";
 };
 
-&xilinx_ams {
-	status = "okay";
-};
-
 &ams_ps {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
index ddc74d963a05..4694d0a841f1 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
@@ -523,10 +523,6 @@ &watchdog0 {
 	status = "okay";
 };
 
-&xilinx_ams {
-	status = "okay";
-};
-
 &ams_ps {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index b1b31dcf6291..256cff250717 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -1157,7 +1157,6 @@ lpd_watchdog: watchdog@ff150000 {
 
 		xilinx_ams: ams@ffa50000 {
 			compatible = "xlnx,zynqmp-ams";
-			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xffa50000 0x0 0x800>;
-- 
2.35.1.1320.gc452695387.dirty


