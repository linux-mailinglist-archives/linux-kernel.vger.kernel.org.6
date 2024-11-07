Return-Path: <linux-kernel+bounces-400333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B92F9C0BFE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6DD283703
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655D12161E1;
	Thu,  7 Nov 2024 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=bob.beckett@collabora.com header.b="A+TMt1FG"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073021DF273
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 16:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730998346; cv=pass; b=c7kasMvvQZPXkAe5hI/R4FnNHxQ11efA2M/S2VdGVen/WdZIhWDN7Oho51kRQZaY+BY6tTgbHvd1/3P09WGTKeumsAjtVJNUXsYSJYxH76c8oTvBXgEIiCOXc4cjAwsPXKLByDQWYSoJv5mdcPAlQEzUoyskCbeyqpNdWxDmGBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730998346; c=relaxed/simple;
	bh=kgm0UaFT51ZT5uxm3BOHs7ARO4dwvKQrPFvHcXGueaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcQrvnpFGAMBgqtaq8RKUieDpI+judVM1nBX5mjPW0cDIWXiW2z251WtICN3eaEDUA6UFqy5BgtHKeeJR6sqAEAlErE1C4/TVpobw6jY7tvYbpn2SaTtn71ufwDkP5nUzNrcO8Hl6SUbbWHe3fdniWyT4GSEr1fzPBXCqR1ep88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=bob.beckett@collabora.com header.b=A+TMt1FG; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1730998325; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lWTv7xDJvgDIrcBGGcdLtBEWdYLPBow45KwRuJd+AvFHjtmxE18OK6ZN5w6saJDwxVi9jYKP0tGIOmqbsg5oiACZrAVUGX4txQLK00EDCsuRy0hZnhVWp5fTcGdJpEem0oH4AhKej7JWr1MEoLR625aJ2Ab+alFkvQUWS0bo69w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730998325; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qzqIdjsCiS6cIWwwB390ikHO12RkhCwtxFNjtkJpmCM=; 
	b=crN/74d6dPzUvFAtg1XfG8lo9TQAqBZ8CB9/imlYCwcPrsHzPeaUgO2lDNakMaXyH7hBZrMhzf2t0makK3Tr+9RCOAFVQdr76Xc3KGSGrJq5zjstjC7NZT79hBcWbn6lXA8bM5O2FQ85l2GA4dDWIijUxt4MCK5tjIzdCO608Z4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=bob.beckett@collabora.com;
	dmarc=pass header.from=<bob.beckett@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730998325;
	s=zohomail; d=collabora.com; i=bob.beckett@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=qzqIdjsCiS6cIWwwB390ikHO12RkhCwtxFNjtkJpmCM=;
	b=A+TMt1FGEs7F+7X1Jdkt23CldBdl8Y0qlhY4XFKgZO1JTK1Bg6X+fT5cpr2bjwsq
	fLa73UE9pa5Url2h9GoNhfUx4FGvObOUNTfelvYZ3h7424GF25iOMYmLe8ErbFoO28W
	ZMfnI2UKSsIERCIUsI+rXFpXzqayH+da2HemJboI=
Received: by mx.zohomail.com with SMTPS id 1730998323777636.0274986216729;
	Thu, 7 Nov 2024 08:52:03 -0800 (PST)
From: Bob Beckett <bob.beckett@collabora.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: kernel@collabora.com,
	Robert Beckett <bob.beckett@collabora.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: 512 byte dma pool segment quirk
Date: Thu,  7 Nov 2024 16:50:46 +0000
Message-ID: <20241107165131.3462171-1-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <ZyE0kYvRZbek7H_g@kbusch-mbp.dhcp.thefacebook.com>
References: <ZyE0kYvRZbek7H_g@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Robert Beckett <bob.beckett@collabora.com>

We initially put in a quick fix of limiting the queue depth to 1
as experimentation showed that it fixed data corruption on 64GB
steamdecks.

After further experimentation, it appears that the corruption
is fixed by increasing the small dma pool segment size to
512 bytes. Testing via desync image verification shows that
it now passes thousands of verification loops, where previously
it never managed above 7.

Currently it is not known why this fixes the corruption.
Perhaps it is doing something nasty like using an mmc page
as a cache for the prp lists (mmc min. page size is 512 bytes)
and not invalidating properly, so that the dma pool change to
treats segment list as a stack ends up giving a previous
segment in the same cached page.

This fixes the previous queue depth limitation as it fixes
the corruption without incurring a 37% tested performance
degredation.

Fixes: 83bdfcbdbe5d ("nvme-pci: qdepth 1 quirk")
Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
---
 drivers/nvme/host/nvme.h |  5 +++++
 drivers/nvme/host/pci.c  | 17 ++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 093cb423f536..bbad25d15360 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -173,6 +173,11 @@ enum nvme_quirks {
 	 * MSI (but not MSI-X) interrupts are broken and never fire.
 	 */
 	NVME_QUIRK_BROKEN_MSI			= (1 << 21),
+
+	/*
+	 * Min. dma pool segment size 512 bytes
+	 */
+	NVME_QUIRK_SMALL_DMAPOOL_512		= (1 << 22),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4b9fda0b1d9a..0782c9b1b4e7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -141,6 +141,7 @@ struct nvme_dev {
 	struct nvme_ctrl ctrl;
 	u32 last_ps;
 	bool hmb;
+	u32 small_dmapool_seg_size;
 
 	mempool_t *iod_mempool;
 
@@ -611,7 +612,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 	}
 
 	nprps = DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE);
-	if (nprps <= (256 / 8)) {
+	if (nprps <= (dev->small_dmapool_seg_size / 8)) {
 		pool = dev->prp_small_pool;
 		iod->nr_allocations = 0;
 	} else {
@@ -701,7 +702,7 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
 		return BLK_STS_OK;
 	}
 
-	if (entries <= (256 / sizeof(struct nvme_sgl_desc))) {
+	if (entries <= (dev->small_dmapool_seg_size / sizeof(struct nvme_sgl_desc))) {
 		pool = dev->prp_small_pool;
 		iod->nr_allocations = 0;
 	} else {
@@ -2700,8 +2701,9 @@ static int nvme_setup_prp_pools(struct nvme_dev *dev)
 		return -ENOMEM;
 
 	/* Optimisation for I/Os between 4k and 128k */
-	dev->prp_small_pool = dma_pool_create("prp list 256", dev->dev,
-						256, 256, 0);
+	dev->prp_small_pool = dma_pool_create("prp list small", dev->dev,
+						dev->small_dmapool_seg_size,
+						dev->small_dmapool_seg_size, 0);
 	if (!dev->prp_small_pool) {
 		dma_pool_destroy(dev->prp_page_pool);
 		return -ENOMEM;
@@ -3063,6 +3065,11 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	 * a single integrity segment for the separate metadata pointer.
 	 */
 	dev->ctrl.max_integrity_segments = 1;
+
+	if (dev->ctrl.quirks & NVME_QUIRK_SMALL_DMAPOOL_512)
+		dev->small_dmapool_seg_size = 512;
+	else
+		dev->small_dmapool_seg_size = 256;
 	return dev;
 
 out_put_device:
@@ -3449,7 +3456,7 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(REDHAT, 0x0010),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1217, 0x8760), /* O2 Micro 64GB Steam Deck */
-		.driver_data = NVME_QUIRK_QDEPTH_ONE },
+		.driver_data = NVME_QUIRK_SMALL_DMAPOOL_512 },
 	{ PCI_DEVICE(0x126f, 0x2262),	/* Silicon Motion generic */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_BOGUS_NID, },
-- 
2.45.2


