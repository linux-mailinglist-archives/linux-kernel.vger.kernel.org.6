Return-Path: <linux-kernel+bounces-516433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F16A3715D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 00:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC87188FA96
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 23:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564E21FDA9B;
	Sat, 15 Feb 2025 23:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="cq7SsNZh"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0494B1FDA7C;
	Sat, 15 Feb 2025 23:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739663711; cv=pass; b=inwe33TQzGBfecSZtZHuo25xPyImmNR63cGebQgWyxI9MScj5kRuNRq2S1ldOhDP4vehv5F0r7U3soQEfgY+Yb4GgPQSx5sL1yY1qzPPsLJQdXd3QSFwJF/WzyFGxAjcM3Yoy+kOMzOI3zMPYtYh9GSNLlqOysRpKzk+CjHncwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739663711; c=relaxed/simple;
	bh=yZI9YkppnA4Jrt7zIZ8DGmdRDeuDKuobF+K2ibWtqEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKfx/iPDfxJ+iD6z6VQalwhwz/dW8GAqByZoRws5VYBZjDULqB+O4UXDfpVbtOqb9f7uwZcps/AwfQdsT5gKxU2EgBYrpEt1TnY5fkgJvF6Mwi7ceZeOXA2vQU6b15bepJljGyTyeuOJCrVEPZvSCepZgUR4uYZisct6x0gP2zE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=cq7SsNZh; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739663686; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Xzszj1H9esnDOxaT7RtmpY0fJVWJpM5duJudkMNLr/EM/Gvcr7/ap1lVv1FaKPkyZorODjnLtgSKBS9kiKCU20DOobjw+fWwEOuGIOmfWy1GYFz8rPJ9hnxBGeQRk1iFPLTIFkK/6d5XsoAXZb0Zfr3HjMPaw9VBIoQzamK+2Fs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739663686; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Rg2lRKuMuur32yytc+cosmJNyARibhGFTS7jn14DKBw=; 
	b=nmiwRwC7ZD1Cce/YzEICyeDQsKgaLEvDElqUe5K8D7ItqvlxNc6r94VnMFOhtK5MCx5fGYfOO+FJjwKjbzEhYh+e16t699jYb3Z6ER+myIek2drT/gLhLClhDYkABnhbNTeCgzuyt+OzfmOMQFCm169fe6UUy33MEf5w2la9F7g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739663686;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Rg2lRKuMuur32yytc+cosmJNyARibhGFTS7jn14DKBw=;
	b=cq7SsNZhdvFjqITiwXM1Cdr4UQXV6/7+PB+Fp1MYCrtgzXMd9SWQf/5Za4l2E/Dw
	aXZMn5wlRkB4emkpx13kWzoKs3izrL5j6J9KJm+5X0VHFwYuVkSaHScl/tno3/7hzBr
	ciQxiJt5MyjKWkgu9OWRWm1anOv279+Vfm66Lmto=
Received: by mx.zohomail.com with SMTPS id 1739663684002695.9780529795356;
	Sat, 15 Feb 2025 15:54:44 -0800 (PST)
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
Subject: [PATCH v1 1/4] irqchip/gic-v3: Add Rockchip 3568002 erratum workaround
Date: Sun, 16 Feb 2025 02:54:28 +0300
Message-ID: <20250215235431.143138-2-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250215235431.143138-1-dmitry.osipenko@collabora.com>
References: <20250215235431.143138-1-dmitry.osipenko@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Rockchip RK3566/RK3568 GIC600 integration has DDR addressing
limited to first 4GB of DRAM. Rockchip assigned Erratum ID #3568002
for this issue. Add driver quirk for this Rockchip GIC Erratum.

Note, that the 0x0201743b ID is not Rockchip 356x specific and thus
there is an extra of_machine_is_compatible() check. Rockchip 3588 uses
same ID and it is not affected by this errata.

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
index c997b27b7da1..0428ad8f324d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1302,6 +1302,15 @@ config NVIDIA_CARMEL_CNP_ERRATUM
 
 	  If unsure, say Y.
 
+config ROCKCHIP_ERRATUM_3568002
+	bool "Rockchip 3568002: can not support DDR addresses higher than 4G"
+	default y
+	help
+	  The Rockchip RK3566 and RK3568 GIC600 SoC integrations have DDR
+	  addressing limited to first 4GB.
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


