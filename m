Return-Path: <linux-kernel+bounces-566409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B62A67797
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD90F16623B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D9A20E711;
	Tue, 18 Mar 2025 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KQh2Uzj1"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E1820E6F9
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311284; cv=none; b=RYjeFvcH8p3KAAqDCl79ZmAzaLRPNVAH1W2ZNGtcoktMBWn7OlVX5q76j97XAM7D90Ib+GY2m8SIEP6ev1qrOYkt//m8R5yUCu6V+DCGfWVORkD9LTae8IJc27dY85d8QkudyHqRKZbGYbLJwFNeE6E/0V7UG3NB/MZjpN2nef0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311284; c=relaxed/simple;
	bh=ikl3rkeQnLiGTEwhtDsuQZ0Era+RRUfSI1GQRsd5rKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mh85u1+rarPDsDy61AIAFGCN88uWl0dYzhoLnbLTcGGr/WLp8B4dS6UgKvrU+nd1mwwDaOZl0NCxUz+Byl8PxH4Ajt4UpxcT13BOHh6X/18IWzX8E47ndJogd5g5b1oRlctqmAVgOjSVSS1HylwZ+qXC0MsvVIL6KnkSdAyWbg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KQh2Uzj1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742311281;
	bh=ikl3rkeQnLiGTEwhtDsuQZ0Era+RRUfSI1GQRsd5rKk=;
	h=From:To:Cc:Subject:Date:From;
	b=KQh2Uzj1upplFHfwz9hQ9ANnArlYejbPYiBBTXjp95CU3QcRfhQ7UOVPI+NyYIGwb
	 DZVhoYSMC7aYHKs03qhCjF3RTaJME3UWdWy/jNPUalGTlyuXDsA0YgMS4RKTJPHapv
	 pY3raIGtiua01SNHB8ME9PjAYwjRcx8Tnj99dShYuekQJgwTCde22Mx4vMOJCGH5F2
	 3AWykmi5mHEcBj/mWBB/hoiRJbLFEFgyZM5ulCAYs3ToqEjQrZmkLCdV7lY7VfJFD0
	 3uixhy/3/2OZ7r18GPZdrz3LUQztRlSTNkpVkaNvzp7o3hbhdKNUkNpO3BMUIwMGxj
	 xci45pvz6E/ow==
Received: from trenzalore.hitronhub.home (unknown [23.233.251.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8DD9517E0E8D;
	Tue, 18 Mar 2025 16:21:19 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Heiko Stuebner <heiko@sntech.de>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Jonas Karlman <jonas@kwiboo.se>,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH] iommu/rockchip: Add flush_iotlb_all ops
Date: Tue, 18 Mar 2025 11:20:49 -0400
Message-ID: <20250318152049.14781-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonas Karlman <jonas@kwiboo.se>

On some Rockchip cores (like the vdpu34x video decoder), the IOMMU device
is inside the the device that uses it.

The IOMMU device can still be driven by the iommu driver, but when an
error occurs in the main device (e.g. a decoding error that resets the
decoder), the IOMMU device will also be reseted.
In such situation, the IOMMU driver and the hardware are out of sync and
IOMMU errors will start popping up.

To avoid that, add a flush_iotlb_all function that will let the main drivers
(e.g. rkvdec) tell the IOMMU driver to write all its cached mappings into
the IOMMU hardware when such an error occured.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/iommu/rockchip-iommu.c | 45 ++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 323cc665c357..7086716cb8fc 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -899,6 +899,40 @@ static size_t rk_iommu_unmap(struct iommu_domain *domain, unsigned long _iova,
 	return unmap_size;
 }
 
+static void rk_iommu_flush_iotlb_all(struct iommu_domain *domain)
+{
+	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
+	struct list_head *pos;
+	unsigned long flags;
+	int i, ret;
+
+	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
+	list_for_each(pos, &rk_domain->iommus) {
+		struct rk_iommu *iommu = list_entry(pos, struct rk_iommu, node);
+
+		ret = pm_runtime_get_if_in_use(iommu->dev);
+		if (!ret || WARN_ON_ONCE(ret < 0))
+			continue;
+
+		if (WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks)))
+			continue;
+
+		rk_iommu_enable_stall(iommu);
+		for (i = 0; i < iommu->num_mmu; i++) {
+			rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
+				rk_ops->mk_dtentries(rk_domain->dt_dma));
+			rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_ZAP_CACHE);
+			rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, RK_MMU_IRQ_MASK);
+		}
+		rk_iommu_enable_paging(iommu);
+		rk_iommu_disable_stall(iommu);
+
+		clk_bulk_disable(iommu->num_clocks, iommu->clocks);
+		pm_runtime_put(iommu->dev);
+	}
+	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
+}
+
 static struct rk_iommu *rk_iommu_from_dev(struct device *dev)
 {
 	struct rk_iommudata *data = dev_iommu_priv_get(dev);
@@ -1172,11 +1206,12 @@ static const struct iommu_ops rk_iommu_ops = {
 	.pgsize_bitmap = RK_IOMMU_PGSIZE_BITMAP,
 	.of_xlate = rk_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= rk_iommu_attach_device,
-		.map_pages	= rk_iommu_map,
-		.unmap_pages	= rk_iommu_unmap,
-		.iova_to_phys	= rk_iommu_iova_to_phys,
-		.free		= rk_iommu_domain_free,
+		.attach_dev		= rk_iommu_attach_device,
+		.map_pages		= rk_iommu_map,
+		.unmap_pages		= rk_iommu_unmap,
+		.flush_iotlb_all	= rk_iommu_flush_iotlb_all,
+		.iova_to_phys		= rk_iommu_iova_to_phys,
+		.free			= rk_iommu_domain_free,
 	}
 };
 
-- 
2.49.0


