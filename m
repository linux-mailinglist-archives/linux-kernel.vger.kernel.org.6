Return-Path: <linux-kernel+bounces-254954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EB89339BC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBFFF1F234A2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9C454BD4;
	Wed, 17 Jul 2024 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dXPKbUMU"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CC54437C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 09:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721207791; cv=none; b=U1w5jtP9rp3NpFAHAklBmyCdM9jh6Gw1NJqnCCp7CZ0OMpRwNHDjF6DEllgmacqICQBJhQBjRc4ZV1M2nAGA7IcMYkNBpKTV35+Ff540IbBwGCv+FoUFvlXxuyCThanFdpjC0uYldaNu0Yfhhy9/WQWWK+6ARolLuWKiGvghdBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721207791; c=relaxed/simple;
	bh=gyv+bR46tq6MKbMFNaXBytQqOl8y3S4hYh0EtUx32ZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FbIffHbmzufj4PhZwsZr8pts81x4yf2rBWg6X6wh1ODgTYeJFpwGJpPydol9vwFSRfXS/0rV0TvpjgKfExuPFMYR8DGyF33t8rTXy1mYK2NckV+e78Tj+r3R+lPWApiGcdcJvNKEY1lYQyqNHgwzma/QHjpTGuz8paamOrAf1Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dXPKbUMU; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=e62nI
	TpAz+fELQO3Wpxu5xtovyKXRrI0UgadVew2J8g=; b=dXPKbUMUiCVOCRLDlbUhL
	JTkKGnwl6fN0EKLUKceZoZ3MaE6CYb4X3Kob0RczYUzD2Dg0HI06oE+DmBuwzf91
	RPf5Ez0iaqoSIopLecFb09zJASaHzP7O02mtAPsb7vVCsAIuV8LoOlidyxEe40gq
	TuyMDX1n7uC+mGLNrSFgFA=
Received: from localhost.localdomain (unknown [223.166.237.119])
	by gzga-smtp-mta-g2-1 (Coremail) with SMTP id _____wD3Py3Ki5dmGNFmDQ--.41698S4;
	Wed, 17 Jul 2024 17:16:03 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: hare@suse.de,
	sagi@grimberg.me,
	hch@lst.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com,
	Ping Gan <jacky_gam_2001@163.com>
Subject: [PATCH v2 2/2] nvmet-rdma:  add unbound_wq support for nvmet-rdma
Date: Wed, 17 Jul 2024 17:14:51 +0800
Message-Id: <20240717091451.111158-3-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240717091451.111158-1-jacky_gam_2001@163.com>
References: <20240717091451.111158-1-jacky_gam_2001@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Py3Ki5dmGNFmDQ--.41698S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7CryfGFyUAr4UKFy8tF4Utwb_yoW8WrWDp3
	93CF17Z397KrW2ya98KFsrXan3u3yfu3yUCas3t34jgFn5trZ3X3WDtry29rW8GF97Jr4x
	Ja1UXr4kZF4Y9wUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zirWrJUUUUU=
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiKBMfKWXAmTj9MwABsG

To define a module parameter use_unbound_wq to enable unbound
workqueue to handle RDMA's IO of CQ.

Signed-off-by: Ping Gan <jacky_gam_2001@163.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/rdma.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 1eff8ca6a5f1..bfd7106316bc 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -155,6 +155,10 @@ static int nvmet_rdma_srq_size = 1024;
 module_param_cb(srq_size, &srq_size_ops, &nvmet_rdma_srq_size, 0644);
 MODULE_PARM_DESC(srq_size, "set Shared Receive Queue (SRQ) size, should >= 256 (default: 1024)");
 
+static bool use_unbound_wq;
+module_param(use_unbound_wq, bool, 0444);
+MODULE_PARM_DESC(use_unbound_wq, "use unbound workqueue to handle IO request: Default false");
+
 static DEFINE_IDA(nvmet_rdma_queue_ida);
 static LIST_HEAD(nvmet_rdma_queue_list);
 static DEFINE_MUTEX(nvmet_rdma_queue_mutex);
@@ -1259,7 +1263,11 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 	 */
 	nr_cqe = queue->recv_queue_size + 2 * queue->send_queue_size;
 
-	queue->cq = ib_cq_pool_get(ndev->device, nr_cqe + 1,
+	if (use_unbound_wq)
+		queue->cq = ib_cq_pool_get(ndev->device, nr_cqe + 1,
+				   queue->comp_vector, IB_POLL_UNBOUND_WORKQUEUE);
+	else
+		queue->cq = ib_cq_pool_get(ndev->device, nr_cqe + 1,
 				   queue->comp_vector, IB_POLL_WORKQUEUE);
 	if (IS_ERR(queue->cq)) {
 		ret = PTR_ERR(queue->cq);
-- 
2.26.2


