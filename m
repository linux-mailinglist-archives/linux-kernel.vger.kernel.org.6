Return-Path: <linux-kernel+bounces-390049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 347399B74EF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F700B245EE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C4714F123;
	Thu, 31 Oct 2024 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="TjTf16nc"
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD56E1487E1;
	Thu, 31 Oct 2024 07:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730358212; cv=none; b=ZnysZzvMSxot4YbgeQM71sKYsWiDETkzvKgXuSf9PvU7zUR1YGyWzgBVeCZsZvg0b3meeyM8ew/NBYVOoEc+rt0Z0sn+YJ8x8I5i0+Y77q2qhsOnsld/Ax5zwnNC75YHhBd2ooc78L0ByL1JKOqVPgGptAaxA6Wog8SqAGb+hv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730358212; c=relaxed/simple;
	bh=8tBNvio1ObQTdhVztprL74DuHbZpuJ/042vXRGsdyBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABLu7OF1AjDa31rYEiqHQBZ5Cv7YQ13GbuJaoqCDUK+2eLlWIQpOPM+GA2/wzhaN4/efyTFmopllb2Uh9tiHNdF/2YFMLVmjHneTwKKy6+nQ/opkR8XDrzioEyEo/ovOP7rGFIy3dvVMi3Qtv0bqLlysqSN9lpNQLS0S1WptR2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=TjTf16nc; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1730358202;
	bh=8tBNvio1ObQTdhVztprL74DuHbZpuJ/042vXRGsdyBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TjTf16nc8iYEMJyvbicHtqGQ97fTYI9rGJAh82SXsh/2rRoxAGl/64f37MmbCx46i
	 L01LMA40RpHP8RO92/LweHSLTvvVvoO19GWwvh+qjjtXGbpmwSbhlsvx9eecKq1QBD
	 EcXLUnmzOfNc1IoGx5LfPdscA31PMh5U7yfZL1/OZMvMOZnLbMMkHTOL1owa2IiHPF
	 byDAEWSUEkU7OeB7s4b4dS6JZPHjDbj2ivtEc9seMedSh9iDYdFfn9NQM3iIm33Qvq
	 8OL8ODYQsYMyVgAecCgU9+FQjkYzFR4TckVeeAnxHW8I8i2JyUzL/euI38l/UtvwTA
	 ehCEzzGY1SlAg==
X-Virus-Scanned: by epochal.quest
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Nishanth Menon <nm@ti.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Parthiban <parthiban@linumiz.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Cody Eksal <masterr3c0rd@epochal.quest>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/13] arm64: dts: allwinner: A100: Add PMU mode
Date: Thu, 31 Oct 2024 04:02:14 -0300
Message-ID: <20241031070232.1793078-2-masterr3c0rd@epochal.quest>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yangtao Li <frank@allwinnertech.com>

Add the Performance Monitoring Unit (PMU) device tree node to the A100
.dtsi, which tells DT users which interrupts are triggered by PMU overflow
events on each core.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
---
 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
index a3dccf193765..1eca7c220ede 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
@@ -25,21 +25,21 @@ cpu0: cpu@0 {
 			enable-method = "psci";
 		};
 
-		cpu@1 {
+		cpu1: cpu@1 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			reg = <0x1>;
 			enable-method = "psci";
 		};
 
-		cpu@2 {
+		cpu2: cpu@2 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			reg = <0x2>;
 			enable-method = "psci";
 		};
 
-		cpu@3 {
+		cpu3: cpu@3 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			reg = <0x3>;
@@ -47,6 +47,15 @@ cpu@3 {
 		};
 	};
 
+	pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
-- 
2.47.0


