Return-Path: <linux-kernel+bounces-192923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827E88D2465
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD9991C27190
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4636B446DC;
	Tue, 28 May 2024 19:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcReLsyv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809BA6DD0D;
	Tue, 28 May 2024 19:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716923716; cv=none; b=S9N1hb+Q3bIDNGS9J3yLZk3KQP21OdQQh6sM1/IJx/n9LTF1wUVk5Nml2/+R/hF3ap09mlGF2aqOjzrchGt9V5VaytldShN3jTZOUPMysNE+FCIsc9NSe2TARb1FX4kpMXc8ERxf3/yG7JbHXVWN7m3hWhWmARUo82kEbrK5PBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716923716; c=relaxed/simple;
	bh=Hra9Q0rL1LWCN7mVFcRCPWW4IW99U8F2m0XsTT0WuUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W/sjX9B9VRDsHg/pEc1FdroliUzGQ/61IiXucj10BH4h/pxlPGoUUx9mtJ+5KVON2GEHa59JF1uo/xw/pQ0Tq8s+os93SsnoVsd31j5FKJR5Du1zj7GQH15/t/YHcsms9arCqNGmvPc8gdz3Nrg+macT76cUJabMzRjbFi1jBAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcReLsyv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BADC3277B;
	Tue, 28 May 2024 19:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716923716;
	bh=Hra9Q0rL1LWCN7mVFcRCPWW4IW99U8F2m0XsTT0WuUc=;
	h=From:To:Cc:Subject:Date:From;
	b=qcReLsyvvCHeHXiHouO6mecFQSx/fyCVOsYTHQ/f3ItdRk1iuypJaXiBV4aMQBkU6
	 3ugRZTZkyZmMDCYrbNzSsvkFP8gkig4vkYNiZLbYj4DUw0qsDpmpnuZ/bXuOZDmrwD
	 V8vaxeCAVOi/b/wNa5DM9LNETUGbeoiethCdYogVN4xVLwOuGnPKZjYTDSloJhYNN8
	 srNk5mWWrbNK7iTyhCqz5PcdioMKTXYt09TWUPiwojnThC5VJ5RdPxTvE6ixShwFNQ
	 Bis6dSapQFQeWIKhTz//2ViYMzwKmtMCMjK7EpKmmWvMrH9WRsvZHU+NAECtzULhi1
	 SJeatq+i7IZhg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm: dts: realview: Add/drop missing/spurious unit-addreses
Date: Tue, 28 May 2024 14:15:09 -0500
Message-ID: <20240528191510.1444068-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Various nodes on the Arm Realview boards have missing or spurious
unit-addresses.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm/boot/dts/arm/arm-realview-eb-mp.dtsi | 2 +-
 arch/arm/boot/dts/arm/arm-realview-pb11mp.dts | 2 +-
 arch/arm/boot/dts/arm/arm-realview-pba8.dts   | 2 +-
 arch/arm/boot/dts/arm/arm-realview-pbx-a9.dts | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/arm/arm-realview-eb-mp.dtsi b/arch/arm/boot/dts/arm/arm-realview-eb-mp.dtsi
index 26783d053ac7..40f7515aa068 100644
--- a/arch/arm/boot/dts/arm/arm-realview-eb-mp.dtsi
+++ b/arch/arm/boot/dts/arm/arm-realview-eb-mp.dtsi
@@ -103,7 +103,7 @@ twd_wdog: watchdog@1f000620 {
 		};
 
 		/* PMU with one IRQ line per core */
-		pmu: pmu@0 {
+		pmu: pmu {
 			compatible = "arm,arm11mpcore-pmu";
 			interrupt-parent = <&intc>;
 			interrupts = <0 17 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm/boot/dts/arm/arm-realview-pb11mp.dts b/arch/arm/boot/dts/arm/arm-realview-pb11mp.dts
index 14ce47d42e3d..29afc5c05759 100644
--- a/arch/arm/boot/dts/arm/arm-realview-pb11mp.dts
+++ b/arch/arm/boot/dts/arm/arm-realview-pb11mp.dts
@@ -92,7 +92,7 @@ intc_tc11mp: interrupt-controller@1f000100 {
 		      <0x1f000100 0x100>;
 	};
 
-	L2: cache-controller {
+	L2: cache-controller@1f002000 {
 		compatible = "arm,l220-cache";
 		reg = <0x1f002000 0x1000>;
 		interrupt-parent = <&intc_tc11mp>;
diff --git a/arch/arm/boot/dts/arm/arm-realview-pba8.dts b/arch/arm/boot/dts/arm/arm-realview-pba8.dts
index d3238c252b59..d2e0082245f9 100644
--- a/arch/arm/boot/dts/arm/arm-realview-pba8.dts
+++ b/arch/arm/boot/dts/arm/arm-realview-pba8.dts
@@ -40,7 +40,7 @@ cpu0: cpu@0 {
 		};
 	};
 
-	pmu: pmu@0 {
+	pmu: pmu {
 		compatible = "arm,cortex-a8-pmu";
 		interrupt-parent = <&intc>;
 		interrupts = <0 47 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/arm/arm-realview-pbx-a9.dts b/arch/arm/boot/dts/arm/arm-realview-pbx-a9.dts
index 85d3968fbb91..507ad7ac4974 100644
--- a/arch/arm/boot/dts/arm/arm-realview-pbx-a9.dts
+++ b/arch/arm/boot/dts/arm/arm-realview-pbx-a9.dts
@@ -97,7 +97,7 @@ twd_wdog: watchdog@1f000620 {
 		interrupts = <1 14 0xf04>;
 	};
 
-	pmu: pmu@0 {
+	pmu: pmu {
 		compatible = "arm,cortex-a9-pmu";
 		interrupt-parent = <&intc>;
 		interrupts = <0 44 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.43.0


