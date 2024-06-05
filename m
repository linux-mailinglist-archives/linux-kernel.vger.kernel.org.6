Return-Path: <linux-kernel+bounces-202637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D514F8FD02F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95FBFB2CDD5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861631A1886;
	Wed,  5 Jun 2024 12:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Iy62n24a"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A352195998;
	Wed,  5 Jun 2024 12:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717591749; cv=none; b=RKFt1BlbDmiz4Wzy3kwqoQ1uZ6Lw9WiC2mOQlwTAoftxFBQLKBoHxcoS9UKq8IUE1QIkjhT7nyuACj2XrjG9Uj6grZ38DK/xD9Zz9zz3gxU7HINs3oNT2roOrgSFtSXkwl7/3aRnXp2S3y4K1Z/9tT5jYfYa3y2XmsYu34hask8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717591749; c=relaxed/simple;
	bh=L9+hZAByHr0QqaSzPq7eWIW5fqJHnRTGRSdpO8HN9kQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bzzGz8cgtCNBehYrtrLGveLtXXIqMv45aK9MFJtNpE9Zr96Qa1TzXFB2gja9y6FZWB9E6QPcNDKvg5BunOHfoSUaIzpQT/h4dpUG1wZaNF1SBfq08TI+gmi9qQmcE/MGSc/hSsmJ0LdRr7oiXlqA9hrjj7N9F+YmwQM4V6ELcSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Iy62n24a; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 455Cn1ea004999;
	Wed, 5 Jun 2024 07:49:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717591741;
	bh=86yfY+eJrB34WAYTx6KvqoZheG9Z7Dr5pqmOO/cToUY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Iy62n24atMtI0Bu3ztqkQCGPpRu1z++WJhNzOlqRksjTAfy+iCdjL4q10tPkcVaz0
	 rSz3cZ08mn9QAb4glKpPD2RczHoIl78PFTpitc9D7rOTorApk2PXW1i2WPpEFqTHyx
	 Pe/e2mgEr7ix86/QNZdzG6ukQskRoHQK+8H3aFCk=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 455Cn0E7004238
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Jun 2024 07:49:01 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Jun 2024 07:49:00 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Jun 2024 07:49:00 -0500
Received: from localhost ([10.249.48.175])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 455Cn0Zh058475;
	Wed, 5 Jun 2024 07:49:00 -0500
From: Hari Nagalla <hnagalla@ti.com>
To: <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nm@ti.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v3 4/4] arm64: dts: ti: k3-am62a7-sk: Enable ipc with remote proc nodes
Date: Wed, 5 Jun 2024 07:48:59 -0500
Message-ID: <20240605124859.3034-5-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240605124859.3034-1-hnagalla@ti.com>
References: <20240605124859.3034-1-hnagalla@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Devarsh Thakkar <devarsht@ti.com>

Reserve memory for remote rpoc IPC and bind the mailbox assignments
for each remote proc. Two memory regions are reserved for each
remote processor. The first region of 1Mb of memory is used for Vring
shared buffers and the second region is used as external memory to the
remote processor, resource table and as tracebuffer.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 68 +++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index fa43cd0b631e..09bb8af53b1e 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -52,11 +52,40 @@ secure_ddr: optee@9e800000 {
 			no-map;
 		};
 
+		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9c800000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9c800000 0x00 0x100000>;
+			no-map;
+		};
+
 		wkup_r5fss0_core0_memory_region: r5f-dma-memory@9c900000 {
 			compatible = "shared-dma-pool";
 			reg = <0x00 0x9c900000 0x00 0x01e00000>;
 			no-map;
 		};
+		mcu_r5fss0_core0_dma_memory_region: r5f-dma-memory@9b800000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9b800000 0x00 0x100000>;
+			no-map;
+		};
+
+		mcu_r5fss0_core0_memory_region: r5f-dma-memory@9b900000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9b900000 0x00 0x0f00000>;
+			no-map;
+		};
+
+		c7x_0_dma_memory_region: c7x-dma-memory@99800000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x99800000 0x00 0x100000>;
+			no-map;
+		};
+
+		c7x_0_memory_region: c7x-memory@99900000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x99900000 0x00 0x01efffff>;
+			no-map;
+		};
 	};
 
 	vmain_pd: regulator-0 {
@@ -721,3 +750,42 @@ dpi1_out: endpoint {
 		};
 	};
 };
+
+&mailbox0_cluster0 {
+	mbox_r5_0: mbox-r5-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+};
+
+&mailbox0_cluster1 {
+	mbox_c7x_0: mbox-c7x-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+};
+
+&mailbox0_cluster2 {
+	mbox_mcu_r5_0: mbox-mcu-r5-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+};
+
+&c7x_0 {
+	mboxes = <&mailbox0_cluster1>, <&mbox_c7x_0>;
+	memory-region = <&c7x_0_dma_memory_region>,
+			<&c7x_0_memory_region>;
+};
+
+&wkup_r5fss0_core0 {
+	mboxes = <&mailbox0_cluster0>, <&mbox_r5_0>;
+	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
+		<&wkup_r5fss0_core0_memory_region>;
+};
+
+&mcu_r5fss0_core0 {
+	mboxes = <&mailbox0_cluster2>, <&mbox_mcu_r5_0>;
+	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
+			<&mcu_r5fss0_core0_memory_region>;
+};
-- 
2.34.1


