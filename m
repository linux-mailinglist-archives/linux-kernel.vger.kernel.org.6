Return-Path: <linux-kernel+bounces-571626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F927A6BFDA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E79033BB2C9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1EF22836C;
	Fri, 21 Mar 2025 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/U7QE/S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E001CF8B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742574273; cv=none; b=U5euS2C1oX+nOFxQBM9USYPdZBCqmT/TnjlL9zQ7r1y6cnG5oxno+d9c3AorVubyjIUIoLVc7O7sP76UBUoryl4AvryhG/W94H1XhKBirGL1aicfghq8PTCHvErEryI/visQsP7fYxlo5SK1E7Y+qOR5Q1v/nSFhScAgKd9VUVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742574273; c=relaxed/simple;
	bh=H2y2nRWmakGnpy3JeVRWta/rM5SXOOhVIXKcy4ezc8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bDVDbaLWm/qiez90Hx9rPEuOoxnG/6gRnRPhp/PjNN3MPnU3a0LUgNBRaDdoryMoc9fgQJ1m8ft53yCd2P8p6yrfvHb7vYY5TpcRwYKEANwS3LGI77ermNGUOhHjgHSSCgGHhwLxhlNhfS27LLd5Dr5cUSJKtwi9UqpjFCQ6Gm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/U7QE/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80239C4CEE3;
	Fri, 21 Mar 2025 16:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742574272;
	bh=H2y2nRWmakGnpy3JeVRWta/rM5SXOOhVIXKcy4ezc8w=;
	h=From:To:Cc:Subject:Date:From;
	b=h/U7QE/SHSeUU5xH58Z1vAVXYlPB+DXTB6uQ5mEVRbnxNEEX/DWGufdSJo6gBfiLy
	 oqUZy2IItTtA3rmhu38IvyGPnRL1+1sRA/GRrASpdLRGvTTAkV4qoIgFsTZ/9tnzGT
	 meocn8pzJDQvtb1IS+GeGbI6J8Es8rdM+/dNI2s6D94cBan4PXpt4PGYI9wQDIVTSC
	 B5+Nzh0Ylf1scEar0Q4ycywHGu6buC1E3LqYXlpctg/NnbudPuZGjS9W5nvGvEGH/4
	 CyBBJc9s5wfwWDhIQBvHP+oKvEVRQdW9cUGKQK1OtaFWLgCiCMib7180yOVi9X8tji
	 qGC9CTPigkHSg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1tvfAh-00000000562-0835;
	Fri, 21 Mar 2025 17:24:35 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] wifi: ath12k: extend dma mask to 36 bits
Date: Fri, 21 Mar 2025 17:23:31 +0100
Message-ID: <20250321162331.19507-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the DMA mask to 36 bits to avoid using bounce buffers on machines
without an iommu (under OS control) similar to what was done for ath11k
in commit dbd73acb22d8 ("wifi: ath11k: enable 36 bit mask for stream
DMA").

This specifically avoids using bounce buffers on Qualcomm Snapdragon X
Elite machines like the Lenovo ThinkPad T14s when running at EL1.

Note that the mask could possibly be extended further but unresolved DMA
issues with 64 GiB X Elite machines currently prevents that from being
tested.

Also note that the driver is limited to 32 bits for coherent
allocations and that there is no need to check for errors when setting
masks larger than 32 bits.

Tested-on: WCN7850 hw2.0 WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/net/wireless/ath/ath12k/mhi.c |  2 +-
 drivers/net/wireless/ath/ath12k/pci.c | 12 ++++--------
 drivers/net/wireless/ath/ath12k/pci.h |  1 +
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mhi.c b/drivers/net/wireless/ath/ath12k/mhi.c
index 2f6d14382ed7..9c929c4ad8a8 100644
--- a/drivers/net/wireless/ath/ath12k/mhi.c
+++ b/drivers/net/wireless/ath/ath12k/mhi.c
@@ -379,7 +379,7 @@ int ath12k_mhi_register(struct ath12k_pci *ab_pci)
 		mhi_ctrl->irq_flags = IRQF_SHARED | IRQF_NOBALANCING;
 
 	mhi_ctrl->iova_start = 0;
-	mhi_ctrl->iova_stop = 0xffffffff;
+	mhi_ctrl->iova_stop = ab_pci->dma_mask;
 	mhi_ctrl->sbl_size = SZ_512K;
 	mhi_ctrl->seg_len = SZ_512K;
 	mhi_ctrl->fbc_download = true;
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 06cff3849ab8..e77c50fc48ca 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -17,7 +17,7 @@
 #include "debug.h"
 
 #define ATH12K_PCI_BAR_NUM		0
-#define ATH12K_PCI_DMA_MASK		32
+#define ATH12K_PCI_DMA_MASK		36
 
 #define ATH12K_PCI_IRQ_CE0_OFFSET		3
 
@@ -874,13 +874,9 @@ static int ath12k_pci_claim(struct ath12k_pci *ab_pci, struct pci_dev *pdev)
 		goto disable_device;
 	}
 
-	ret = dma_set_mask_and_coherent(&pdev->dev,
-					DMA_BIT_MASK(ATH12K_PCI_DMA_MASK));
-	if (ret) {
-		ath12k_err(ab, "failed to set pci dma mask to %d: %d\n",
-			   ATH12K_PCI_DMA_MASK, ret);
-		goto release_region;
-	}
+	ab_pci->dma_mask = DMA_BIT_MASK(ATH12K_PCI_DMA_MASK);
+	dma_set_mask(&pdev->dev, ab_pci->dma_mask);
+	dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
 
 	pci_set_master(pdev);
 
diff --git a/drivers/net/wireless/ath/ath12k/pci.h b/drivers/net/wireless/ath/ath12k/pci.h
index 31584a7ad80e..9e89b64b3545 100644
--- a/drivers/net/wireless/ath/ath12k/pci.h
+++ b/drivers/net/wireless/ath/ath12k/pci.h
@@ -116,6 +116,7 @@ struct ath12k_pci {
 	unsigned long irq_flags;
 	const struct ath12k_pci_ops *pci_ops;
 	u32 qmi_instance;
+	u64 dma_mask;
 };
 
 static inline struct ath12k_pci *ath12k_pci_priv(struct ath12k_base *ab)
-- 
2.48.1


