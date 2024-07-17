Return-Path: <linux-kernel+bounces-254840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0AB93385D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F8D81C227C6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEB01CD16;
	Wed, 17 Jul 2024 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EMZOkiDj"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D693438389
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721202825; cv=none; b=XIme7E1M8nnCbbTFiTEbHN76UoizbegtriyjFmbDBzQb2/ksXTLYwT3Jyz6czGUSRzItGds72v/RXRSQEU9on6fiPdmflBrdgLdebDnQ2ppFjN/Ee5LTqr0srE5LGg9laq1r0cRvYFiNzceYi8vLSxamk/IRq8z/3SPi1ZpSE7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721202825; c=relaxed/simple;
	bh=zK8ruUH07JehWZxI02iwHZoWOCkCvMR3iGwU0ScuYPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vD8IZBsIl/1t7LmIQGMAph/sX4IGr2J6ze03Qq0K56dpIBuo0dif+hNNbrucCJnlHcWqYR9bGl2+UqIb8ry9EurwHhC7vOl6ytG1e5j6VPVCDid4uAwCQlv4IqE2xrOW3HOpy/bntLoHb9e9mzKJHNG85dMdQBYAHTWUq/QXP3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EMZOkiDj; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Mn+4O
	ScY3XRHK3/oW8fy9rYRq32M1Cn4hjrpDWV3OS4=; b=EMZOkiDjvI4cASb49uHnK
	E3PYiy/9fs7dix163PMbuAG+nu8ogaUxJoOZQyWgSA3nIADEZqczK01SQzF7NmcQ
	mQ58D9GHy82U7UMj2JAXlbAv28panIPCY68n51TehLMcWyde2iZbBt8didDlEWYX
	RRoMca36gnJzkmnqPi4hdU=
Received: from localhost.localdomain (unknown [223.166.237.119])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wD3f3ddeJdmTsbxAA--.36565S4;
	Wed, 17 Jul 2024 15:53:17 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: hare@suse.de,
	sagi@grimberg.me,
	hch@lst.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com,
	Ping Gan <jacky_gam_2001@163.com>
Subject: [PATCH 2/2] nvmet-rdma:  add unbound_wq support for nvmet-rdma
Date: Wed, 17 Jul 2024 15:52:08 +0800
Message-Id: <20240717075208.87324-3-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240717075208.87324-1-jacky_gam_2001@163.com>
References: <20240717075208.87324-1-jacky_gam_2001@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f3ddeJdmTsbxAA--.36565S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7CryDAw17XryruF45AFyDAwb_yoW8Wr1rp3
	95CF17Z393KrW2ya98KF4DXan3u3yfuw4UCas3t34UWFnaqrZ3X3WDtry29rW8GF97Jr4x
	Ja1DXr4kuF45WwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zirWrJUUUUU=
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiEA8fKWXAl+IiRAAAsf

To define a module parameter use_unbound_wq to enable unbound
workqueue to handle RDMA's IO of CQ.

Signed-off-by: jackygam2001 <jacky_gam_2001@163.com>
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


