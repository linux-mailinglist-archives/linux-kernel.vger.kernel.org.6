Return-Path: <linux-kernel+bounces-320341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C793297090E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 19:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B005F1C21096
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 17:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C382817C23D;
	Sun,  8 Sep 2024 17:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="LoKs2TnZ"
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE72176FAB
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725816769; cv=none; b=XB8Hzt4DqF8nxPMrdh4R3L6WKYSyu6839eM4OkGdS66w97hn0RPzzU3zba0FG5+o8Dikziq0ygYS238DRT32ptWkmeF55tG6MAOA+uK1Kq/Jic5LT0J4F2en5/BW2u2zLTpi39/NYcm/AXMq1ssbNCN+nh7qYOLmiXtBe+NjNNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725816769; c=relaxed/simple;
	bh=8DZAIx78tX09RUB958aT4rufSeZEMPqRli6/uDdiQJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=peMNb6XkRk8m6KyVY5H+CicrpWb09VRJW4OAMi7cu7v72S4uDybcX8qt1GRpSLxSsQLH4hS2u0rae9P2YuE3kQRh8BzQb9+DdHcNh90xahuWCmEfheW2AalYT7mVN3F3xbRa/Ti3VcBFBZu3Qsq4Xo6xBY6hEb4PRa4J330UaEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=LoKs2TnZ; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240908173239c655594a584c2c57bb
        for <linux-kernel@vger.kernel.org>;
        Sun, 08 Sep 2024 19:32:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=iFfd2t0Dq0yUbDlytZqHUfYp4qV0roKUDvsOPNNJEZ0=;
 b=LoKs2TnZzLXdjszaU1pSG3Bnko+QVRi/hrJJmm5YVDXgFTeJrEr9bgBNLlWvrNEDw0Qgk7
 JRKPhlsKuO4ToDf4DfYAiUkww8qjWPZiaKsne9pKQec/7ByBPlsHJf5iFRghS1rXgAFvQDop
 2RnbSOrT2a9OuPKX8c4rVJktnlYMnshIf7oSq3rWbV25w3Wz3YbapdZnpgewhQlvdiVVRn5I
 ZmF6jk7csaA93FMD/BVa//7W+arhlbmgfRYtJpa/AniwE0ydghoraOaxxL6VdgYT2xsHjEfL
 Ks2l3qzAvPtlDTHaObzpHvxplnIJe+MTiC6YrXzT1+qSpkWDCGASMhSg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Hua Qian Li <huaqian.li@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>
Subject: [PATCH v5 7/7] arm64: dts: ti: iot2050: Add overlay for DMA isolation for devices behind PCI RC
Date: Sun,  8 Sep 2024 19:32:33 +0200
Message-ID: <da330487b9fbf471ae06acc0aa6bd9f87a95d1c6.1725816753.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1725816753.git.jan.kiszka@siemens.com>
References: <cover.1725816753.git.jan.kiszka@siemens.com>
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

Reserve a 64M memory region and ensure that all PCI devices do their DMA
only inside that region. This is configured via a restricted-dma-pool
and enforced with the help of the first PVU.

Applying this isolation is not totally free in terms of overhead and
memory consumption. It  makes only sense for variants that support
secure booting, and generally only when this is actually enable.
Therefore model it as overlay that can be activated on demand. The
firmware will take care of this via DT fixup during boot and will also
provide a way to adjust the pool size.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm64/boot/dts/ti/Makefile               |  5 +++
 ...am6548-iot2050-advanced-dma-isolation.dtso | 33 +++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-dma-isolation.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index bcd392c3206e..b6ee943be8c6 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -74,8 +74,10 @@ k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb \
 k3-am654-evm-dtbs := k3-am654-base-board.dtb k3-am654-icssg2.dtbo
 k3-am654-idk-dtbs := k3-am654-evm.dtb k3-am654-idk.dtbo k3-am654-pcie-usb2.dtbo
 k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-dtbs := k3-am6548-iot2050-advanced-m2.dtb \
+	k3-am6548-iot2050-advanced-dma-isolation.dtbo \
 	k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie.dtbo
 k3-am6548-iot2050-advanced-m2-bkey-usb3-dtbs := k3-am6548-iot2050-advanced-m2.dtb \
+	k3-am6548-iot2050-advanced-dma-isolation.dtbo \
 	k3-am6548-iot2050-advanced-m2-bkey-usb3.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic-pg2.dtb
@@ -240,7 +242,10 @@ DTC_FLAGS_k3-am62p5-sk += -@
 DTC_FLAGS_k3-am642-evm += -@
 DTC_FLAGS_k3-am642-phyboard-electra-rdk += -@
 DTC_FLAGS_k3-am642-tqma64xxl-mbax4xxl += -@
+DTC_FLAGS_k3-am6548-iot2050-advanced += -@
 DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
+DTC_FLAGS_k3-am6548-iot2050-advanced-pg2 += -@
+DTC_FLAGS_k3-am6548-iot2050-advanced-sm += -@
 DTC_FLAGS_k3-am68-sk-base-board += -@
 DTC_FLAGS_k3-am69-sk += -@
 DTC_FLAGS_k3-j721e-common-proc-board += -@
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-dma-isolation.dtso b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-dma-isolation.dtso
new file mode 100644
index 000000000000..dfd75d2dc245
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-dma-isolation.dtso
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IOT2050, overlay for isolating DMA requests via PVU
+ * Copyright (c) Siemens AG, 2024
+ *
+ * Authors:
+ *   Jan Kiszka <jan.kiszka@siemens.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+&{/reserved-memory} {
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	pci_restricted_dma_region: restricted-dma@c0000000 {
+		compatible = "restricted-dma-pool";
+		reg = <0 0xc0000000 0 0x4000000>;
+	};
+};
+
+&pcie0_rc {
+	memory-region = <&pci_restricted_dma_region>;
+};
+
+&pcie1_rc {
+	memory-region = <&pci_restricted_dma_region>;
+};
+
+&ti_pvu0 {
+	status = "okay";
+};
-- 
2.43.0


