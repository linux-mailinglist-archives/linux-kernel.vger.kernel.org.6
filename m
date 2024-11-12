Return-Path: <linux-kernel+bounces-406662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0689C61E1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05AD1F23778
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E234219CAB;
	Tue, 12 Nov 2024 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=bob.beckett@collabora.com header.b="XdDW8jpf"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3891219485
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 19:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731441127; cv=pass; b=gJj+C9QLCOWAo9vOwNnSsrIintyKPufegbUpyUJdP25t3d0PuR2E8araauTOHoKEnmh4LHHQVP209asmEJ49cSaPk6Z9P4FD4i7xMlhKHKxbcwCvN08MtHiHA1dyJOpG0MCwOqWKxAVXJCjak80boq3tsobPpvJecgaOsxqBCGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731441127; c=relaxed/simple;
	bh=UEChvOmoTx535X0vTzOrF/1jVXlSzMADwiLAPfR2Crs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s9eRefSA8c8K5GFUZged7rd7BViVkPBNWV6YpCtls5Vmr9tCOLQNlP+1ziO+udBYDoXU/MlEJGVambOz7uFvoEoOulxZN9rMK+AfDOkqhIPiVmcetDuRFU/mllfeEELEwHzKDHKWlTpaFX516BWxDL0ozXk0fVibANVREQlEadU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=bob.beckett@collabora.com header.b=XdDW8jpf; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1731441112; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aRtgj7mr2WNC/5zk/fp43UyVx8wy31cxZ/1Dp4vSKbS1DhkwoLHEhQpGkRa9g48VSlj4tmZXWxb/Bogrsby4m8IpUM2lWnTTbAT5MOqBF92y1fzag/V4crhWU2iWxT2t7BELeSVhr9Ro2TFIlxQaewyytvaQrWe+Bz04SIdm5B8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1731441112; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nooNrk0pdLGb6HpWRiivYxPtImtREYw4ohNgd/wPIVM=; 
	b=jqTblEQgIDj7cq0oGMLfJbrAkKU+v1Yq+bP7zoc+liUK04wySJ/GICZoKNHCjESMChYHI40sbgJTA2PcFuH5JYkYOKyPxG/NNO7D0NNwOVODKSiWQEmQBQcIvfOhFefgQp1MuyOdTJi3cbF3nnzZFoTeVyvDDp72cHSOJjWdzDY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=bob.beckett@collabora.com;
	dmarc=pass header.from=<bob.beckett@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731441112;
	s=zohomail; d=collabora.com; i=bob.beckett@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=nooNrk0pdLGb6HpWRiivYxPtImtREYw4ohNgd/wPIVM=;
	b=XdDW8jpfXsigiE8D60e0eWVpedR5DrKMIMmaVF4nHSRy+Bdka0zRh4DxG5BZWfDo
	TlBbtn19fSzuXyS4RoVAR24IS9bQ+B0M8B/+6gSfQ+SdewD9ojOw4v+CydAwEz+3Up+
	AiJhFcoiI5ql2JrqSMEguCj043pX1v6z5A/oFPNo=
Received: by mx.zohomail.com with SMTPS id 1731441109569554.7931799757025;
	Tue, 12 Nov 2024 11:51:49 -0800 (PST)
From: Bob Beckett <bob.beckett@collabora.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: kernel@collabora.com,
	Robert Beckett <bob.beckett@collabora.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
Date: Tue, 12 Nov 2024 19:50:00 +0000
Message-ID: <20241112195053.3939762-1-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.45.2
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
is fixed by aligning the small dma pool segments to 512 bytes.
Testing via desync image verification shows that it now passes
thousands of verification loops, where previously
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
 drivers/nvme/host/nvme.h | 5 +++++
 drivers/nvme/host/pci.c  | 6 +++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 093cb423f536..61bba5513de0 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -173,6 +173,11 @@ enum nvme_quirks {
 	 * MSI (but not MSI-X) interrupts are broken and never fire.
 	 */
 	NVME_QUIRK_BROKEN_MSI			= (1 << 21),
+
+	/*
+	 * Align dma pool segment size to 512 bytes
+	 */
+	NVME_QUIRK_DMAPOOL_ALIGN_512		= (1 << 22),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4b9fda0b1d9a..6fcd3bb413c4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2700,8 +2700,8 @@ static int nvme_setup_prp_pools(struct nvme_dev *dev)
 		return -ENOMEM;
 
 	/* Optimisation for I/Os between 4k and 128k */
-	dev->prp_small_pool = dma_pool_create("prp list 256", dev->dev,
-						256, 256, 0);
+	dev->prp_small_pool = dma_pool_create("prp list 256", dev->dev,256,
+				       dev->ctrl.quirks & NVME_QUIRK_DMAPOOL_ALIGN_512 ? 512 : 256, 0);
 	if (!dev->prp_small_pool) {
 		dma_pool_destroy(dev->prp_page_pool);
 		return -ENOMEM;
@@ -3449,7 +3449,7 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(REDHAT, 0x0010),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1217, 0x8760), /* O2 Micro 64GB Steam Deck */
-		.driver_data = NVME_QUIRK_QDEPTH_ONE },
+		.driver_data = NVME_QUIRK_DMAPOOL_ALIGN_512, },
 	{ PCI_DEVICE(0x126f, 0x2262),	/* Silicon Motion generic */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_BOGUS_NID, },
-- 
2.45.2


