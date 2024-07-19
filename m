Return-Path: <linux-kernel+bounces-257127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BF49375A4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44D071F224AE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB8B82D89;
	Fri, 19 Jul 2024 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YfU3zkIG"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763FF7E0E9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721380901; cv=none; b=T1yk3buEeGEsI4MW8AJWhwn3Cul8fguDoeYLRpHAHbw3oqJeMrvxicc6WgU009JXCasGck7aAxqkbivPsw4cQ48fYryE97nPucbvpIqT0C5T04RzUyNqWc8ebxFUrzPEyx+XRLoDE+nZFwmx9XO6D1/RvVBScWWYTQCry59vmt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721380901; c=relaxed/simple;
	bh=6FwXC+k8gSW7AUbb0HuxNfLEcjV+y0ekv+OBRVBR4VI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FZIB9T0uYKGkatH+AhfvvgZLuUHvQupln3l4PaHhP6/6p+1Uy/3HxmVlco+0HQXMiZ4VWpFmw2xY2Ee2xVsga/xPvOMMlT/+Cm30Cf78DVaaTL368AoDG3BFCTMu5helSSIhO/HEr29nabHaDiUwie9jDNXDeP68mshZEa42UHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YfU3zkIG; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=yKu0f
	KvWQXE0pPWAo1bepOPxqYj9sANjynMiSpfTLR8=; b=YfU3zkIG67nAAWsWjgJTM
	wA4dykFFmuav7aEaWRXlVzreqchqqj0Mg88gQpV357kOqSpW3YZmW02iZyZVIefQ
	BAO9ui77fhGszQEuZZHzQSXDg+WIJMNNZ0kvrHc9g+eSPY1SwrjZN8cfIugH1Qh4
	4YObhCkWPD5yaW0y5t0zSg=
Received: from localhost.localdomain (unknown [223.166.237.249])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wD3T3X7L5pmYK8DAg--.13202S4;
	Fri, 19 Jul 2024 17:21:11 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: hare@suse.de,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com,
	Ping Gan <jacky_gam_2001@163.com>
Subject: [PATCH v3 2/2] nvmet-rdma: use unbound_wq for nvmet-rdma by default
Date: Fri, 19 Jul 2024 17:19:59 +0800
Message-Id: <20240719091959.17163-3-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240719091959.17163-1-jacky_gam_2001@163.com>
References: <20240719091959.17163-1-jacky_gam_2001@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3T3X7L5pmYK8DAg--.13202S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw1rCFWUGFy8WFWDKr4Uurg_yoWDJFbEgr
	1xJF1Iga1kCr1qvr1qk3W3Ca4DKa4FgF1IyFs7tr45Aryru3y5Aw1kZFn3urW8Zw18uFyj
	vr17GwsIyryrWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRt73vUUUUUU==
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiKAshKWXAmWCW5wAAsG

To use unbounded workqueue to handle RDMA's IO of CQ by default, which
was discussed in below session.

https://lore.kernel.org/lkml/20240719084953.8050-1-jacky_gam_2001@163.com/

Signed-off-by: Ping Gan <jacky_gam_2001@163.com>
---
 drivers/nvme/target/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 1eff8ca6a5f1..6a54217e3bc5 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1260,7 +1260,7 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 	nr_cqe = queue->recv_queue_size + 2 * queue->send_queue_size;
 
 	queue->cq = ib_cq_pool_get(ndev->device, nr_cqe + 1,
-				   queue->comp_vector, IB_POLL_WORKQUEUE);
+				   queue->comp_vector, IB_POLL_UNBOUND_WORKQUEUE);
 	if (IS_ERR(queue->cq)) {
 		ret = PTR_ERR(queue->cq);
 		pr_err("failed to create CQ cqe= %d ret= %d\n",
-- 
2.26.2


