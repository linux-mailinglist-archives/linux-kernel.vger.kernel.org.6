Return-Path: <linux-kernel+bounces-302288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E49B95FC25
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 23:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD1B284D9A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2761F19DFA6;
	Mon, 26 Aug 2024 21:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="h6GzX7KF"
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9086919D881
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 21:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724709017; cv=none; b=UTGtf0pRjNu+qTG/TC//4sXaUVA3R4ZanRyWZZ4DlNu4cB42pg4CWRoBEUtQ0sTFLGEb84yWKcVlKNB/u2BuFnLafXA2WnTTp/Ga0yKkV0UNgCv4gCE6lS0KeMS2jxuDkeAPVv1pEUJytgSI9D8DpJns57ZBHb1YGDTYI9xYoW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724709017; c=relaxed/simple;
	bh=XxJCzQZWU9OzPhukxyUnCeQa8I9BqgJg+OBvOlXupE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPgqbSjjWdwGl/h4eof9SIf9ddmrGcWW5lOb5YCesSO5SwacAZxR6YyHRSjxiw5ez8M5lD0ZQqMFOwStGQMtS5olbpkkc7NlEIYBQOUlXR6CbD5uqVdbzB+T1pbwBVWw+1sKgCeDMiGMrFOnTeOPrkAu+d7cMb0LbjJOAOtVKTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=h6GzX7KF; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240826215011a875acca4b0af49b2b
        for <linux-kernel@vger.kernel.org>;
        Mon, 26 Aug 2024 23:50:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=4KBzC3UYDzVcntWEjAfh9aq0jCErmi0ZBb3RSeN9zX0=;
 b=h6GzX7KFlNaUEaizddMQ1Ra0NaF8FCZZ5+TjHqio13SV6DdYo61qRs592yR47duXx5xW2v
 I8FJeTp6+sKqLcaARcIjQvecZ4b+FgKgzG/KchNF+HsQveb/rptwbsJdzqGFlzGLlQEvGDy2
 YGyFduuPUa82CSzttK+yFLKkGJ7ScMpY3fXxs153jtDTu8y+soal0TGGjixUDCKXih4BWFhY
 90vJZJSzoVRY4ANh9PwBmSNLW/c8QW9zL2RXO18noyEg8PPNK6gDmSR0iFpxTaC/DD7dLHFE
 xIOpyWMDw4/HMfaxZ1qlDZ1z0NX/KHGrJTpC99+tye8vbTSRafV89dHg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Hua Qian Li <huaqian.li@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>
Subject: [PATCH v2 6/6] arm64: dts: ti: iot2050: Enforce DMA isolation for devices behind PCI RC
Date: Mon, 26 Aug 2024 23:50:07 +0200
Message-ID: <695e8ffeca42a765a35ea1e5df61a5ed16ef7180.1724709007.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1724709007.git.jan.kiszka@siemens.com>
References: <cover.1724709007.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

Reserve a 64M memory region below the top of 1G RAM (smallest RAM size
across the series, space left for firmware carve-outs) and ensure that
all PCI devices do their DMA only inside that region. This is configured
via a restricted-dma-pool and enforced with the help of the first PVU.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index e76828ccf21b..cc0f33e3519c 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -82,6 +82,11 @@ wdt_reset_memory_region: wdt-memory@a2200000 {
 			reg = <0x00 0xa2200000 0x00 0x1000>;
 			no-map;
 		};
+
+		pci_restricted_dma_region: restricted-dma@ba000000 {
+			compatible = "restricted-dma-pool";
+			reg = <0 0xba000000 0 0x4000000>;
+		};
 	};
 
 	leds {
@@ -571,6 +576,10 @@ seboot-backup@e80000 {
 	};
 };
 
+&pcie0_rc {
+	memory-region = <&pci_restricted_dma_region>;
+};
+
 &pcie1_rc {
 	status = "okay";
 	pinctrl-names = "default";
@@ -580,6 +589,8 @@ &pcie1_rc {
 	phys = <&serdes1 PHY_TYPE_PCIE 0>;
 	phy-names = "pcie-phy0";
 	reset-gpios = <&wkup_gpio0 27 GPIO_ACTIVE_HIGH>;
+
+	memory-region = <&pci_restricted_dma_region>;
 };
 
 &mailbox0_cluster0 {
@@ -640,3 +651,24 @@ &mcu_r5fss0 {
 	/* lock-step mode not supported on iot2050 boards */
 	ti,cluster-mode = <0>;
 };
+
+&main_navss {
+	ti_pvu0: ti-pvu@30f80000 {
+		compatible = "ti,am654-pvu";
+		reg = <0 0x30f80000 0 0x1000>,
+		      <0 0x36000000 0 0x100000>;
+		reg-names = "cfg", "tlbif";
+		interrupts-extended = <&intr_main_navss 390>;
+		interrupt-names = "pvu";
+	};
+
+	ti_pvu1: ti-pvu@30f81000 {
+		compatible = "ti,am654-pvu";
+		reg = <0 0x30f81000 0 0x1000>,
+		      <0 0x36100000 0 0x100000>;
+		reg-names = "cfg", "tlbif";
+		interrupts-extended = <&intr_main_navss 389>;
+		interrupt-names = "pvu";
+		status = "disabled";
+	};
+};
-- 
2.43.0


