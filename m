Return-Path: <linux-kernel+bounces-310649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8DA967FA0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D59282C8C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 06:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A9B155CAC;
	Mon,  2 Sep 2024 06:45:26 +0000 (UTC)
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590BF14F9E6;
	Mon,  2 Sep 2024 06:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.143.206.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725259526; cv=none; b=ddqBeT+seEfztmNP6EQydk1aVEFZv8cX3F1kTXENpQA7Zqg7AoybxekhRkP6a90XdGP4kpWqbVpgUfqm0nhuzw3COGWnfktTdVpL4l9yNt/tYsvv/lhz6CZFFYZXckqzX0GOyJ5vI8G3MkqCOG+ulsaHTY6myDTvSUOlQl8JZXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725259526; c=relaxed/simple;
	bh=yl/7rSIc25TQHIfhai3dXr/kS4Q9/8/pCgV8aGwtBaI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XJU7udGLxPTsyT3LuyGHqbsECD9VNcoVnubLNs/ZKFbbgkL+zTGRYa2cpM1tKW5Uf6b4ZuCEN4TlDkVI/WkKtCdC1Ar8avfCoP57kvCj0RTPW0hS5aJn1tlTJCl0LvTD6pzcr1xtJENhUe7SD+PjcNnLoJaiGx69n2mFhQ7KaWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: IzmxXoSwTbmJa0l14ACVKQ==
X-CSE-MsgGUID: 8Y6nkuFgSUuUi3ynAwa8TA==
X-IronPort-AV: E=Sophos;i="6.10,195,1719849600"; 
   d="scan'208";a="95174249"
From: ZhangHui <zhanghui31@xiaomi.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanghui31@xiaomi.com>
Subject: [PATCH] block: move non sync requests complete flow to softirq
Date: Mon, 2 Sep 2024 14:44:09 +0800
Message-ID: <20240902064409.25637-1-zhanghui31@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX07.mioffice.cn (10.237.8.127) To YZ-MBX07.mioffice.cn
 (10.237.88.127)

From: zhanghui <zhanghui31@xiaomi.com>

Currently, for a controller that supports multiple queues, like UFS4.0,
the mq_ops->complete is executed in the interrupt top-half. Therefore, 
the file system's end io is executed during the request completion process,
such as f2fs_write_end_io on smartphone.

However, we found that the execution time of the file system end io
is strongly related to the size of the bio and the processing speed
of the CPU. Because the file system's end io will traverse every page
in bio, this is a very time-consuming operation.

We measured that the 80M bio write operation on the little CPU will
cause the execution time of the top-half to be greater than 100ms.
The CPU tick on a smartphone is only 4ms, which will undoubtedly affect
scheduling efficiency.

Let's fixed this issue by moved non sync request completion flow to
softirq, and keep the sync request completion in the top-half.

Signed-off-by: zhanghui <zhanghui31@xiaomi.com>
---
 block/blk-mq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e3c3c0c21b55..06b232edff11 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1193,6 +1193,8 @@ static void blk_mq_raise_softirq(struct request *rq)
 
 bool blk_mq_complete_request_remote(struct request *rq)
 {
+	const blk_opf_t is_sync = op_is_sync(rq->cmd_flags);
+
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
 
 	/*
@@ -1210,7 +1212,7 @@ bool blk_mq_complete_request_remote(struct request *rq)
 		return true;
 	}
 
-	if (rq->q->nr_hw_queues == 1) {
+	if ((rq->q->nr_hw_queues == 1) || !is_sync) {
 		blk_mq_raise_softirq(rq);
 		return true;
 	}
-- 
2.43.0


