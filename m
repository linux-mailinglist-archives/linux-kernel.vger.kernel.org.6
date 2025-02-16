Return-Path: <linux-kernel+bounces-516836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A62A3780A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 23:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A972816E385
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 22:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948951A5B94;
	Sun, 16 Feb 2025 22:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="ApLuwNHv"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283031422AB;
	Sun, 16 Feb 2025 22:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739744299; cv=pass; b=UEDxpR9/sVFEKPr5SICCPEH2zItQYLQAh+6MKDXfWQH6cNK7bz6T1X/PwuziGhv0XHxg3M9QmxMwo4ChmgODUAdBmAIb0oHJQ9uW/NemGHpp6StNmlsNV8hcMrclr9QSQAW+IE5NtpwRMcbZ2kWIrzlHdDURJxURV5kTVNE1liM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739744299; c=relaxed/simple;
	bh=ZHbWqwF9ybm0WFYof3+flZ8eWAC291dR62OqgRCnn1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmrzSu9Di9CTIG+gpUbCBPE0Ouc8KdghANU60dkkoyDI3tps0i6QviIy9sjkERYGnvyKVZy1duLZ3YfeGXcT3BS1DFwhR1KLBEnx2/7FlS1xwHfDJ0YTqhWCTwOv5XupV3v5mFW0oqHuvHK8lQn5dgqJ/obWsrIljlMVHRE6R1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=ApLuwNHv; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739744265; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ORzp7KlFNwkmQr+kQmhUVilbBN+qZ6IqFC6CHZ0o2nLGkTc+hVGIln8pVXFgUxcEFWxUVsdYRiFF/I6ufcaP2iNx5gqId3a9Sz1mmbNSBXPI321ABv8z3RA9TpdM4iARjkTSSep+i5RsrMndffyVw1Rm104pLgB93/ga0unezOs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739744265; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Q75cQOfZzNd7YlqQXzBT5khX7N9EAQ92SxJwQnSbgUI=; 
	b=YrhlRu+um52z9zAwgD3vgjV/uvTORo2k708xnoSJnmucCg+HbqdR0tVlcn0m50OVJEMmfMO6NKw8/+2cDk8xazbVON77LSnQU9CCizzB6/TexwRr2KYvT//dfOKX+fW34z0R4ps6dAD+rM+icUfyMWkV/AXwZDfLAUkoUARnUBA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739744264;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Q75cQOfZzNd7YlqQXzBT5khX7N9EAQ92SxJwQnSbgUI=;
	b=ApLuwNHvry5nFXi/B16ix2LRwBxS4+Qouiq2uYtYTTWz4YQQVc4JF4lpe5eu7pdr
	Pm8TVJhq734FL+kPueFXNUGdsYFRyzcDvYjp1vBbSKV9F0FImAfrcIFtr7eZ/PXRw4B
	d7PDPIHH3hBKyzp1xEhmfqhoh4fR+awPYjJrCZV0=
Received: by mx.zohomail.com with SMTPS id 1739744262024296.6829777439069;
	Sun, 16 Feb 2025 14:17:42 -0800 (PST)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Marc Zyngier <maz@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kever Yang <kever.yang@rock-chips.com>,
	XiaoDong Huang <derrick.huang@rock-chips.com>,
	Peter Geis <pgwipeout@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	kernel@collabora.com
Subject: [PATCH v2 1/3] irqchip/gic-v3: Add Rockchip 3568002 erratum workaround
Date: Mon, 17 Feb 2025 01:16:32 +0300
Message-ID: <20250216221634.364158-2-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250216221634.364158-1-dmitry.osipenko@collabora.com>
References: <20250216221634.364158-1-dmitry.osipenko@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Rockchip RK3566/RK3568 GIC600 integration has DDR addressing
limited to the first 32bit of physical address space. Rockchip
assigned Erratum ID #3568002 for this issue. Add driver quirk for
this Rockchip GIC Erratum.

Note, that the 0x0201743b GIC600 ID is not Rockchip-specific and is
common for many ARM GICv3 implementations. Hence, there is an extra
of_machine_is_compatible() check.

Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 Documentation/arch/arm64/silicon-errata.rst |  2 ++
 arch/arm64/Kconfig                          |  9 ++++++++
 drivers/irqchip/irq-gic-v3-its.c            | 23 ++++++++++++++++++++-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index f074f6219f5c..f968c13b46a7 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -284,6 +284,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Rockchip       | RK3588          | #3588001        | ROCKCHIP_ERRATUM_3588001    |
 +----------------+-----------------+-----------------+-----------------------------+
+| Rockchip       | RK3568          | #3568002        | ROCKCHIP_ERRATUM_3568002    |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Fujitsu        | A64FX           | E#010001        | FUJITSU_ERRATUM_010001      |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c997b27b7da1..3619eca185f9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1302,6 +1302,15 @@ config NVIDIA_CARMEL_CNP_ERRATUM
 
 	  If unsure, say Y.
 
+config ROCKCHIP_ERRATUM_3568002
+	bool "Rockchip 3568002: GIC600 can not access physical addresses higher than 4GB"
+	default y
+	help
+	  The Rockchip RK3566 and RK3568 GIC600 SoC integrations have AXI
+	  addressing limited to the first 32bit of physical address space.
+
+	  If unsure, say Y.
+
 config ROCKCHIP_ERRATUM_3588001
 	bool "Rockchip 3588001: GIC600 can not support shareability attributes"
 	default y
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 8c3ec5734f1e..f30ed281882f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -205,13 +205,15 @@ static DEFINE_IDA(its_vpeid_ida);
 #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
 #define gic_data_rdist_vlpi_base()	(gic_data_rdist_rd_base() + SZ_128K)
 
+static gfp_t gfp_flags_quirk;
+
 static struct page *its_alloc_pages_node(int node, gfp_t gfp,
 					 unsigned int order)
 {
 	struct page *page;
 	int ret = 0;
 
-	page = alloc_pages_node(node, gfp, order);
+	page = alloc_pages_node(node, gfp | gfp_flags_quirk, order);
 
 	if (!page)
 		return NULL;
@@ -4887,6 +4889,17 @@ static bool __maybe_unused its_enable_quirk_hip09_162100801(void *data)
 	return true;
 }
 
+static bool __maybe_unused its_enable_rk3568002(void *data)
+{
+	if (!of_machine_is_compatible("rockchip,rk3566") &&
+	    !of_machine_is_compatible("rockchip,rk3568"))
+		return false;
+
+	gfp_flags_quirk |= GFP_DMA32;
+
+	return true;
+}
+
 static const struct gic_quirk its_quirks[] = {
 #ifdef CONFIG_CAVIUM_ERRATUM_22375
 	{
@@ -4954,6 +4967,14 @@ static const struct gic_quirk its_quirks[] = {
 		.property = "dma-noncoherent",
 		.init   = its_set_non_coherent,
 	},
+#ifdef CONFIG_ROCKCHIP_ERRATUM_3568002
+	{
+		.desc   = "ITS: Rockchip erratum RK3568002",
+		.iidr   = 0x0201743b,
+		.mask   = 0xffffffff,
+		.init   = its_enable_rk3568002,
+	},
+#endif
 	{
 	}
 };
-- 
2.48.1


