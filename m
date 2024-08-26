Return-Path: <linux-kernel+bounces-302008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B9795F88F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BACA828436C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4D31991CB;
	Mon, 26 Aug 2024 17:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="ZCcF4gca"
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14887198A34
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 17:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724694979; cv=none; b=SBngKBI63OLReJpagJn0RABru7IFp+3I5XebzqlvLVgK5WsJYXJClfhnoNCmWkjvoxAmzvzG1pNf2vrBJD+oRNgxdooOs/HKa8fXaeEscqa5pYttFREH/OwgY0CoZDFuD5zixB3bEXb9F4LeNvlJIiwif8lKhq4KubfgtN0ErsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724694979; c=relaxed/simple;
	bh=XxJCzQZWU9OzPhukxyUnCeQa8I9BqgJg+OBvOlXupE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bh2NmKM/vGkXn7KmE0lB5e2jGLVPizY4hhDqZzNP6hfAVcuKebEis/H6XEcLO4gzYpk5ztGUJ2HxVY8Yt0HMxPqev1mGyvEOjvkg1SRpmilshBKTymUSsxwwGmSp/TdIXLazxcdBE7ypuBZMjjmXGywrJ25vtfrnBNVSou9TTAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=ZCcF4gca; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202408261756131e32c872702823b84e
        for <linux-kernel@vger.kernel.org>;
        Mon, 26 Aug 2024 19:56:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=4KBzC3UYDzVcntWEjAfh9aq0jCErmi0ZBb3RSeN9zX0=;
 b=ZCcF4gcaVjDpTCiNWCyvwvj9pNdY3hNHhxuT8fJ7NDjJQuvRXstfh+c//YUMZBv1AXu6Lb
 lHF2wUy+JOtHke4eqbkysph6IHt2LdZPISw8yleKjrVzvOFYkFGP9VRw+VCPS5zz1Xyu6+tD
 7O6h7Vy2nrb3O9V4jUlc6ia8HH7i3BTTAWPHKJU343MrFsl38l6Xh++D68i51CDRa5riEIRm
 gKicJxClz/YT5zlg/xTbejISpHBPlcZ58jOPRAosaCjrClijbzC6tLthDWUWH0hmP56IGChY
 d73E8RXFOwKGGLYokELHjdkZLvcRG/aO3xLNVBK73dlD9BWmtp7WyD1A==;
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
Subject: [PATCH 5/5] arm64: dts: ti: iot2050: Enforce DMA isolation for devices behind PCI RC
Date: Mon, 26 Aug 2024 19:56:09 +0200
Message-ID: <270232f43d17c95610904928502ad00bb975304c.1724694969.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1724694969.git.jan.kiszka@siemens.com>
References: <cover.1724694969.git.jan.kiszka@siemens.com>
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


