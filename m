Return-Path: <linux-kernel+bounces-393191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 171BA9B9D7B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 07:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89AB6B22986
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 06:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C1114D428;
	Sat,  2 Nov 2024 06:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MALtmqx1"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E97218035
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 06:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730529647; cv=none; b=K6czPlQq7tD+f1245jxy++ANbQXYNG8692uFD7Z92gS8V4IwTf3c95+NBWL8HIZ5nzTs9SA6Mo7QkK2VcZCMNZyU1tvzv9GkT4bqRygkDCU9v4OJJMkxBirS32qzGBFpM5IjaQZ5iTkchxguSWVI18QUhG7JvFzdQwk8zE5Lgxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730529647; c=relaxed/simple;
	bh=f6x6wRSgqbldWG1dme/0EDWxZbtfqbTGkNaHT+781DA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S33LYwGlwbfnlCeKpVo3avZ7QyLMC8ENcOf7vp6/IOsrqF65zPjxeFtHs5l8eDd3/eqMm+9xr/cyGJMbg5psFmVHotDBj7Rh8glqYsSz1h8eHZZ+yHP+8ZfcwkZqV83lJl5YQZ2mexqREzi935t0fgCsngSTIIdEW6mYeZdUOLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MALtmqx1; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=4epiw
	3ui9HD6taTZFIBUVIzwxVQK2JBCcmQ9ZscPasI=; b=MALtmqx1aMjyoaPSxsqns
	76WTVXlgGdo6RK4xFT9L1y4bcE1qDCy7qYPrEuAQ1KHJfzAiABIleY5ACaBmsM3N
	G/BFIit7LsuVUDmrPVDnvIUKSou9D3cW+T9yf/7rggIzxG2NfP/unAbp04c567cQ
	VRaWSkaWMXCB6ImpHdHYMQ=
Received: from fc39.. (unknown [125.33.14.1])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAnnw9IySVnWEkjCQ--.19355S4;
	Sat, 02 Nov 2024 14:40:10 +0800 (CST)
From: Honggang LI <honggangli@163.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Honggang LI <honggangli@163.com>
Subject: [PATCH] nvmet-rdma: WARN_ON when nvmet_rdma_rsp::n_rdma equal zero
Date: Sat,  2 Nov 2024 14:39:53 +0800
Message-ID: <20241102063953.228107-1-honggangli@163.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgAnnw9IySVnWEkjCQ--.19355S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrW3WFyfuF43Gw13Jw43ZFb_yoWDWrcEkw
	1IyF1fu3WDur1xKr129w1YyryqkFnruF1xKF4ft3y2yrWUWr90kw1ktr93Zr1xZa18CrWx
	CFsrJrWagFWxJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNJ5o7UUUUU==
X-CM-SenderInfo: 5krqwwxdqjzxi6rwjhhfrp/xtbBDwKLRWclu+jbJgAAsv

nvmet_rdma_rsp::n_rdma is an u8, which can't be negative.

Signed-off-by: Honggang LI <honggangli@163.com>
---
 drivers/nvme/target/rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 1afd93026f9b..cdeb275a388b 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -750,7 +750,7 @@ static void nvmet_rdma_read_data_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct nvmet_rdma_queue *queue = wc->qp->qp_context;
 	u16 status = 0;
 
-	WARN_ON(rsp->n_rdma <= 0);
+	WARN_ON(rsp->n_rdma == 0);
 	atomic_add(rsp->n_rdma, &queue->sq_wr_avail);
 	rsp->n_rdma = 0;
 
@@ -787,7 +787,7 @@ static void nvmet_rdma_write_data_done(struct ib_cq *cq, struct ib_wc *wc)
 	if (!IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY))
 		return;
 
-	WARN_ON(rsp->n_rdma <= 0);
+	WARN_ON(rsp->n_rdma == 0);
 	atomic_add(rsp->n_rdma, &queue->sq_wr_avail);
 	rsp->n_rdma = 0;
 
-- 
2.47.0


