Return-Path: <linux-kernel+bounces-200122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F778FAB37
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D721C238D6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 06:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C8413EFE3;
	Tue,  4 Jun 2024 06:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wv6ZXi8R"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCA013664B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 06:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717483725; cv=none; b=tbt8ICfXMBwvrC5Oje7u99WDZevWQIarrhXEcfAlfjPnq+/zdpamqXKSl6/1rgdqMkETUklk/y6lyf8TyLjcTHsMzDF9MZxVq+w4WmzQHW2d2V/SuDmTQ/GZmh5GLi5ubiQ+cMxzJXWKSM+6//ieJd6bSGUw4MEWT9ahe5qAIxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717483725; c=relaxed/simple;
	bh=tPHvpfbicx4bIIGo88KcWt4EvJuqworlHYnnK6kTbVU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NZGDD2k3ZHt7R9psGOOxO5Gzi7dkAkK+s71hjfYqO9mxcIlLUwMhuRPT+emLAUKhTMwxI21ofN21K/J3lf92SZwAsAnoxAfw2eQ1oUJKClcwSB3KzzaWOK/D7hhRi11Ycz7RSOwdsee2dIzSCW59Uf61p6oe9+gV2StbqTN+pkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wv6ZXi8R; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: axboe@kernel.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717483717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4r9HLX4g8Q6c88HvJbXRFepUMDoGcBwz+Eo9OhwtTvI=;
	b=Wv6ZXi8RcMarEJRuY4/ayoBOcG3GaFhWwF/Ao6+DFn3lW58hjVhZS8tBaoAda5D2092sl7
	nPXx+SXkWFConykUQKr781pIc+2K3xRMBz+nzeLp5MgQATPODSqAy5hNAnaLr7lAhW3J0n
	PPi3Tn7PncVpxPGFmny6PSlPXQT6B0M=
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
Subject: [PATCH] block: fix request.queuelist usage in flush
Date: Tue,  4 Jun 2024 14:47:45 +0800
Message-Id: <20240604064745.808610-1-chengming.zhou@linux.dev>
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

Reported-by: Friedrich Weber <f.weber@proxmox.com>
Closes: https://lore.kernel.org/lkml/14b89dfb-505c-49f7-aebb-01c54451db40@proxmox.com/
Fixes: 81ada09cc25e ("blk-flush: reuse rq queuelist in flush state machine")
Cc: Christoph Hellwig <hch@lst.de>
Cc: ming.lei@redhat.com
Cc: bvanassche@acm.org
Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 block/blk-flush.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index c17cf8ed8113..e7aebcf00714 100644
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
-- 
2.20.1


