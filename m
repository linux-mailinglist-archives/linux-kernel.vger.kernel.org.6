Return-Path: <linux-kernel+bounces-207068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6DF901206
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 16:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C20F282468
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 14:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E2117A92D;
	Sat,  8 Jun 2024 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AsoXqxX6"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00071FBB
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717857111; cv=none; b=YcUEomIj7vgO4Ay8b7IZndV2GzsloHkMApRCK3lr3rIJ0ugHYoLErn/AT9a7ualkM79tipH3K5NErF6MFNKa82Ll74dO5aAGp6CY3l5jRes1F2N+zhahx4BH/pbzDzzw72CFmLxjAZMeIwflCFO+XvkIFuVqxOHZLx6c3P20bU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717857111; c=relaxed/simple;
	bh=5/9a85I5i8X0PqtfKhvRzdHzvpIcMGzFXPg+TzfeH/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oR9rblLflZtkggaQf15he6Wjy0jRW2TQwOwVvGIokxfNV8yt9N3CxBPSPFr8J+1ADS5bf2OJePuoxq2+4B/71pbQLoXH/pICXVinyxs7+b1HqZX075rpnIOH/jNRKquwT4sHe0BCs+FpPzuEpu3uggwPzKBlEd/PITfqO0jCVhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AsoXqxX6; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: axboe@kernel.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717857105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G6bSjM248xI7+oW0z8fYSMF0v53Z/T3KEz7PTnmiSTs=;
	b=AsoXqxX6rKS4PFjzo7S/7byCyNK1WrASUTiymE2yz4/OU0T2jbH9pGcynIbgwtRMwGpU3T
	sxk9EDOLJZOkCCg/KgwVcnUsIZ7uc1vGFUiwJeYNPXF3yiKM/bG3Ap4CRaXgZqOQc+05iG
	O29nUpXOmtniyu3tswqQwbxPZqae5uU=
X-Envelope-To: ming.lei@redhat.com
X-Envelope-To: hch@lst.de
X-Envelope-To: f.weber@proxmox.com
X-Envelope-To: bvanassche@acm.org
X-Envelope-To: linux-block@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: chengming.zhou@linux.dev
X-Envelope-To: zhouchengming@bytedance.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
To: axboe@kernel.dk,
	ming.lei@redhat.com,
	hch@lst.de,
	f.weber@proxmox.com,
	bvanassche@acm.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chengming.zhou@linux.dev,
	zhouchengming@bytedance.com
Subject: [PATCH v2] block: fix request.queuelist usage in flush
Date: Sat,  8 Jun 2024 22:31:15 +0800
Message-Id: <20240608143115.972486-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Friedrich Weber reported a kernel crash problem and bisected to commit
81ada09cc25e ("blk-flush: reuse rq queuelist in flush state machine").

The root cause is that we use "list_move_tail(&rq->queuelist, pending)"
in the PREFLUSH/POSTFLUSH sequences. But rq->queuelist.next == xxx since
it's popped out from plug->cached_rq in __blk_mq_alloc_requests_batch().
We don't initialize its queuelist just for this first request, although
the queuelist of all later popped requests will be initialized.

Fix it by changing to use "list_add_tail(&rq->queuelist, pending)" so
rq->queuelist doesn't need to be initialized. It should be ok since rq
can't be on any list when PREFLUSH or POSTFLUSH, has no move actually.

Please note the commit 81ada09cc25e ("blk-flush: reuse rq queuelist in
flush state machine") also has another requirement that no drivers would
touch rq->queuelist after blk_mq_end_request() since we will reuse it to
add rq to the post-flush pending list in POSTFLUSH. If this is not true,
we will have to revert that commit IMHO.

This updated version adds "list_del_init(&rq->queuelist)" in flush rq
callback since the dm layer may submit request of a weird invalid format
(REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH), which causes double list_add
if without this "list_del_init(&rq->queuelist)". The weird invalid format
problem should be fixed in dm layer.

Reported-by: Friedrich Weber <f.weber@proxmox.com>
Closes: https://lore.kernel.org/lkml/14b89dfb-505c-49f7-aebb-01c54451db40@proxmox.com/
Closes: https://lore.kernel.org/lkml/c9d03ff7-27c5-4ebd-b3f6-5a90d96f35ba@proxmox.com/
Fixes: 81ada09cc25e ("blk-flush: reuse rq queuelist in flush state machine")
Cc: Christoph Hellwig <hch@lst.de>
Cc: ming.lei@redhat.com
Cc: bvanassche@acm.org
Tested-by: Friedrich Weber <f.weber@proxmox.com>
Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 block/blk-flush.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index c17cf8ed8113..cca4f9131f79 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -185,7 +185,7 @@ static void blk_flush_complete_seq(struct request *rq,
 		/* queue for flush */
 		if (list_empty(pending))
 			fq->flush_pending_since = jiffies;
-		list_move_tail(&rq->queuelist, pending);
+		list_add_tail(&rq->queuelist, pending);
 		break;
 
 	case REQ_FSEQ_DATA:
@@ -263,6 +263,7 @@ static enum rq_end_io_ret flush_end_io(struct request *flush_rq,
 		unsigned int seq = blk_flush_cur_seq(rq);
 
 		BUG_ON(seq != REQ_FSEQ_PREFLUSH && seq != REQ_FSEQ_POSTFLUSH);
+		list_del_init(&rq->queuelist);
 		blk_flush_complete_seq(rq, fq, seq, error);
 	}
 
-- 
2.20.1


