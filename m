Return-Path: <linux-kernel+bounces-349357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A44798F4B7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70F8282799
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE5F1AAE0A;
	Thu,  3 Oct 2024 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yuUBQRzy"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5641A7266;
	Thu,  3 Oct 2024 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974891; cv=none; b=TlQKqx3Zg8ENRy4FJXeK5GoBVxBJgKzM5KFfeJ65cWVASlbF+aSC3f7bi8CLzxwe5LBz0Af6SKlFT5Zgrjbjv2RiXEu9ILKvFHMb4Q3DePOEmOxP2xfBB48ie6dtHkJ0AO3kuU6IZIj3B8tgXjlukGEuu26NF9+8TDqbtb7iG4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974891; c=relaxed/simple;
	bh=rsjyAwUdZPUtpq7X0EOtW5mmNPwrNeArEGoNK40w5+Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ViG4vB1u+0huiG7xL7PIDOOE4f1GSGKPWlji7qrnJbZxjwDwzxQGBj5/ePy7L5sSh3FIxSC9VwjicvhpTkleYj2vLixBzR1Ugx82lhD1+ALtPLzsrZe8k9BssT8tVjzVo/O75/f8Prh+eTROkgmUooL3KV0m5zOQGCa4GTPfTEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yuUBQRzy; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 493H1JWf050026;
	Thu, 3 Oct 2024 12:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727974879;
	bh=6er3fLH1h7Mp2w3l0QFcwApkR0btaLUtHcIDiCixkb8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=yuUBQRzyrQc5Lv09xR4Xrcmz7Ilvkd+r2UhsFygV3dDkZW3UzDBn+5w1RIEW+qj1M
	 pEO124soQK0WAnyP90RrXLjpyOfj/qJskYrk16wEb2SExNetZ2SjgW1zfo0kWMMNXn
	 ziG/JWK5GUaxRsdv4xE07GvEJmy1UFAeuSel2gfo=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 493H1Jne047732
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 3 Oct 2024 12:01:19 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Oct 2024 12:01:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Oct 2024 12:01:18 -0500
Received: from ula0226330.dhcp.ti.com (ula0226330.dhcp.ti.com [128.247.81.173] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 493H1IJd034882;
	Thu, 3 Oct 2024 12:01:18 -0500
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v12 4/5] arm64: dts: ti: k3-am642-sk: Add M4F remoteproc node
Date: Thu, 3 Oct 2024 12:01:17 -0500
Message-ID: <20241003170118.24932-5-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241003170118.24932-1-afd@ti.com>
References: <20241003170118.24932-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Hari Nagalla <hnagalla@ti.com>

The AM64x SoCs of the TI K3 family have a Cortex M4F core in the MCU
domain. This core can be used by non safety applications as a remote
processor. When used as a remote processor with virtio/rpmessage IPC,
two carveout reserved memory nodes are needed. The first region is used
as a DMA pool for the rproc device, and the second region will furnish
the static carveout regions for the firmware memory.

The current carveout addresses and sizes are defined statically for
each rproc device. The M4F processor does not have an MMU, and as such
requires the exact memory used by the firmware to be set-aside.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 86369525259c3..26d4ad5e96f1c 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -99,6 +99,18 @@ main_r5fss1_core1_memory_region: r5f-memory@a3100000 {
 			no-map;
 		};
 
+		mcu_m4fss_dma_memory_region: m4f-dma-memory@a4000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa4000000 0x00 0x100000>;
+			no-map;
+		};
+
+		mcu_m4fss_memory_region: m4f-memory@a4100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa4100000 0x00 0xf00000>;
+			no-map;
+		};
+
 		rtos_ipc_memory_region: ipc-memories@a5000000 {
 			reg = <0x00 0xa5000000 0x00 0x00800000>;
 			alignment = <0x1000>;
@@ -681,6 +693,13 @@ &main_r5fss1_core1 {
 			<&main_r5fss1_core1_memory_region>;
 };
 
+&mcu_m4fss {
+	mboxes = <&mailbox0_cluster6 &mbox_m4_0>;
+	memory-region = <&mcu_m4fss_dma_memory_region>,
+			<&mcu_m4fss_memory_region>;
+	status = "okay";
+};
+
 &ecap0 {
 	status = "okay";
 	/* PWM is available on Pin 1 of header J3 */
-- 
2.39.2


