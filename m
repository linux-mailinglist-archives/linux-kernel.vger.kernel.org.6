Return-Path: <linux-kernel+bounces-260889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B744B93AFDC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 12:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1F341C22144
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 10:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C5C15099A;
	Wed, 24 Jul 2024 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCFw0WaH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053941BF38
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 10:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721817083; cv=none; b=QR6J87JNTOgNbk2CHwnZpoOuhoMp1itesQe3mAmjRB2NWMedMJXcUbfgJylQF4E0iK6s/Zxb5fY05IwNvNTNFhPVP1PkUeLW4BLpqVkUq04G8BS3won+5cdAetUbgvLBohf+7ZcExM/lU6dgu8cOkQtslK0cZLjNOCo61e5/Ya0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721817083; c=relaxed/simple;
	bh=oTEiypWgCfBrzn0eenLSvsKim3M9QkN5uZiMhaGWmT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b/O85y17Z31CKmc+pSRxAiRL1usKLn4Fu3ROzDALwXBGTdDeWDbuL4FDoP2sGdbQmA94L3o6XBGMRsCc3KDrdgrzQa8mzWwVLuglxDvrlvaAic3aVUuplMI4AbZQr1z7Bqr73koRzPCvVYcz4NpRIbZY13oustSJNmeeCYU5owA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCFw0WaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BC1C32782;
	Wed, 24 Jul 2024 10:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721817082;
	bh=oTEiypWgCfBrzn0eenLSvsKim3M9QkN5uZiMhaGWmT4=;
	h=From:To:Cc:Subject:Date:From;
	b=HCFw0WaHJuXuMUVjOgqhoM2ArhaW9vnZ4MAEwxWu8FLzRdTje2kB4andVY6bO7X5t
	 H17dNr5pY/9/b2GC//lBpFEiBIeNxYKGNoU/ZNVR8zt8VfrWcwxbI5eXvJAoNKVB0r
	 cZU5iY4Sj83M1hz4kFeB53wBTYYDtxuOHSV83OyYALotnhrA264OhqEPfGCObGGcUe
	 8u/KKLUh0IT6PD9KZX3Y6gWMpbpJJoIGSBZdqt4yPaAWhTzc76VAeyFCwiUMwbjA0m
	 BuyLWoS9RDKS9aJX9O4pQxP9FlN78yW8VyNuNZ7tAcRdrvOcV6Pm0gD2jxkVKU+noP
	 KsgXe+k3g6KJQ==
From: Leon Romanovsky <leon@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: add missing condition check for existence of mapped data
Date: Wed, 24 Jul 2024 13:31:14 +0300
Message-ID: <23e8ca814177474160a516e09b562af339cec837.1721816805.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

nvme_map_data() is called when request has physical segments, hence
the nvme_unmap_data() should have same condition to avoid dereference.

Fixes: 4aedb705437f ("nvme-pci: split metadata handling from nvme_map_data / nvme_unmap_data")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 102a9fb0c65f..cdc0b25091e9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -863,7 +863,8 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 	nvme_start_request(req);
 	return BLK_STS_OK;
 out_unmap_data:
-	nvme_unmap_data(dev, req);
+	if (blk_rq_nr_phys_segments(req))
+		nvme_unmap_data(dev, req);
 out_free_cmd:
 	nvme_cleanup_cmd(req);
 	return ret;
-- 
2.45.2


