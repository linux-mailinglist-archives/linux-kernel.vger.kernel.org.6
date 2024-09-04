Return-Path: <linux-kernel+bounces-312450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20449696C7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A965C2836F0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194F121C164;
	Tue,  3 Sep 2024 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jfKybEPZ"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011962139A1
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725351438; cv=none; b=NegWuCNlK1Mxh53Bvgcow3lZWjH1S6Seoinl+1rPxXnjImG72CianO6yR0L6FIi0vubhW7u6Fn54PVEc9sDZB/EbRgI96xLGot3PBdULqVrpkPY49xw1/t0/8uuzM6wPc6JDXL1F+a+SPcAxQA2MHtb4caXL/vq5tYBohw3Jcik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725351438; c=relaxed/simple;
	bh=HT1O81auJF8jkUbfoH8a9VXFCdl4byvmYDOuWSv02rQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ajQOzgUqLMGL7y0VY7k1+8dOBvEufZ0oDynqHG0ocjBFk7sk2dFlIFehRz0PWswejVSqXIYD99Xs9x76vf+XQvyLjps5BRI3XMG2tT91z50DiyxgtLkK/mG/JhdGRegYSuSqDb0C1zETvx7F8fVNSBAmyl7hxuICUJMUBiH/G+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jfKybEPZ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7cd8d2731d1so3190268a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 01:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725351436; x=1725956236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5RIKba1vN04ymFPVOLPxfjA30q3/2IhkWeGUF/bwck=;
        b=jfKybEPZZ4IZvQT8g0LM8NUJxUc+tmgXcracvv+pVHq5AWbHQYDpCz8Dkm/7d3PWG8
         ++DPejHMXHkzl9aI/B6fbcVDuN4gzVjAEhVKG54OuxbZ70BebfmGQzuU604UyP0zT6cb
         ydXV1Nk6FqyZB01zQtpYd9jrfUo6k4HCLO1ypTJlCCa5PumOLuF7fGovHpoDixTYzd2r
         UCqty6UfAGWn9uXvk5YrBwlF6tQlYsbxAkskPv84WK2Va+j0QucXuupkCh6TIU74RXvr
         sxutAX0QbQ57idtJm0hS7TdyJ2QoX98yDdGGYISvMNb4Mx176iiWeZVltITfAOCAgZwI
         a+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725351436; x=1725956236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5RIKba1vN04ymFPVOLPxfjA30q3/2IhkWeGUF/bwck=;
        b=mQqoPJV/B/ZSycQ8GI2xJiasdct4mpFYk1Edmp8qnrAuy3l/J19qRKk1Wdw+rl2qGV
         zhmakllc4pEQZUoxCLdrdZeMgXZ8rPPrnqoDOrnhFKUe3IhmWBotjqEeKp6jKjYO575T
         5/pVfdYlo1OZKlUQFNiC8TNUiiZzL57OfmTOeaWuC+kK62jLmZYXiCGgDbRWfet7GM9u
         z/UNmCiwrHJLMjI00+sOLG3Uaqy7cre+WUZr4GOM5N0IqHoRrikYUHXO/XolrGspiwEm
         scNDUz1KNiI/Cq4acRhf2evkDOQWHEVj0xM6Q/fOu0kIDHo5ndtyn591RghZez/LvzFR
         V61w==
X-Forwarded-Encrypted: i=1; AJvYcCVrNNq8vWEEb0TEYVl2VYz4Y3V6ouc2znGpPQDgtXJuKNcWA+UNNpgq6ysXXD1A1u2RZEG6etwb0A49ypI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQbv8caY0xUk8pyXYQxQeeZgWy9WqjDLj5PEd19zN55KZ69MA9
	8p3ltdRHSdFizhraVVTvnvqWp6Q/DhW6/maD159GSz7y83DxTuGmHJ5kFeYN9js=
X-Google-Smtp-Source: AGHT+IG6Sq1/GZFiK1wz/f6HwLVjUyMVd96eIAsnzZlYfQt73JmPituiRdU5k5HR2fvAmfKgLi2QWQ==
X-Received: by 2002:a05:6a21:3483:b0:1cc:de68:436b with SMTP id adf61e73a8af0-1cece503ad2mr8214023637.20.1725351436282;
        Tue, 03 Sep 2024 01:17:16 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20559cae667sm38155435ad.95.2024.09.03.01.17.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Sep 2024 01:17:15 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: axboe@kernel.dk,
	ming.lei@redhat.com,
	yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] block: fix ordering between checking QUEUE_FLAG_QUIESCED and adding requests
Date: Tue,  3 Sep 2024 16:16:52 +0800
Message-Id: <20240903081653.65613-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240903081653.65613-1-songmuchun@bytedance.com>
References: <20240903081653.65613-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Supposing the following scenario.

CPU0                                        CPU1

blk_mq_insert_request()         1) store    blk_mq_unquiesce_queue()
blk_mq_run_hw_queue()                       blk_queue_flag_clear(QUEUE_FLAG_QUIESCED)       3) store
    if (blk_queue_quiesced())   2) load         blk_mq_run_hw_queues()
        return                                      blk_mq_run_hw_queue()
    blk_mq_sched_dispatch_requests()                    if (!blk_mq_hctx_has_pending())     4) load
                                                           return

The full memory barrier should be inserted between 1) and 2), as well as
between 3) and 4) to make sure that either CPU0 sees QUEUE_FLAG_QUIESCED is
cleared or CPU1 sees dispatch list or setting of bitmap of software queue.
Otherwise, either CPU will not re-run the hardware queue causing starvation.

So the first solution is to 1) add a pair of memory barrier to fix the
problem, another solution is to 2) use hctx->queue->queue_lock to synchronize
QUEUE_FLAG_QUIESCED. Here, we chose 2) to fix it since memory barrier is not
easy to be maintained.

Fixes: f4560ffe8cec1 ("blk-mq: use QUEUE_FLAG_QUIESCED to quiesce queue")
Cc: stable@vger.kernel.org
Cc: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 block/blk-mq.c | 47 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b2d0f22de0c7f..ac39f2a346a52 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2202,6 +2202,24 @@ void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs)
 }
 EXPORT_SYMBOL(blk_mq_delay_run_hw_queue);
 
+static inline bool blk_mq_hw_queue_need_run(struct blk_mq_hw_ctx *hctx)
+{
+	bool need_run;
+
+	/*
+	 * When queue is quiesced, we may be switching io scheduler, or
+	 * updating nr_hw_queues, or other things, and we can't run queue
+	 * any more, even blk_mq_hctx_has_pending() can't be called safely.
+	 *
+	 * And queue will be rerun in blk_mq_unquiesce_queue() if it is
+	 * quiesced.
+	 */
+	__blk_mq_run_dispatch_ops(hctx->queue, false,
+				  need_run = !blk_queue_quiesced(hctx->queue) &&
+					      blk_mq_hctx_has_pending(hctx));
+	return need_run;
+}
+
 /**
  * blk_mq_run_hw_queue - Start to run a hardware queue.
  * @hctx: Pointer to the hardware queue to run.
@@ -2222,20 +2240,23 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 
 	might_sleep_if(!async && hctx->flags & BLK_MQ_F_BLOCKING);
 
-	/*
-	 * When queue is quiesced, we may be switching io scheduler, or
-	 * updating nr_hw_queues, or other things, and we can't run queue
-	 * any more, even __blk_mq_hctx_has_pending() can't be called safely.
-	 *
-	 * And queue will be rerun in blk_mq_unquiesce_queue() if it is
-	 * quiesced.
-	 */
-	__blk_mq_run_dispatch_ops(hctx->queue, false,
-		need_run = !blk_queue_quiesced(hctx->queue) &&
-		blk_mq_hctx_has_pending(hctx));
+	need_run = blk_mq_hw_queue_need_run(hctx);
+	if (!need_run) {
+		unsigned long flags;
 
-	if (!need_run)
-		return;
+		/*
+		 * Synchronize with blk_mq_unquiesce_queue(), becuase we check
+		 * if hw queue is quiesced locklessly above, we need the use
+		 * ->queue_lock to make sure we see the up-to-date status to
+		 * not miss rerunning the hw queue.
+		 */
+		spin_lock_irqsave(&hctx->queue->queue_lock, flags);
+		need_run = blk_mq_hw_queue_need_run(hctx);
+		spin_unlock_irqrestore(&hctx->queue->queue_lock, flags);
+
+		if (!need_run)
+			return;
+	}
 
 	if (async || !cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask)) {
 		blk_mq_delay_run_hw_queue(hctx, 0);
-- 
2.20.1


