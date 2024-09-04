Return-Path: <linux-kernel+bounces-312451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A66549696CA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25AE01F26D46
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E79B205E15;
	Tue,  3 Sep 2024 08:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eR1ma8vP"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40318205E08
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725351442; cv=none; b=Oj/DdhKRv4QL7VU8To+dyXvI0F3MWbKoVGZRxYzjhimCis4g1uJbitGsKkD1u/LsXHPp75F1FRjeawlcmDTI3Hf6Xlez1F1JQDvHII2Y1bJUD8+t9lTDZuPT2/6IEb2y76b1YuOduDtOJTQHLzSqvj8scmLhncNgsUBi1b/1GjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725351442; c=relaxed/simple;
	bh=2nS7H6L6WID7zbgTfR3cXsYRR840ppC8iAY3XsHIAg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pIVhetcdvJ5Pvphg2fIl8M3EcbLvJHuMO/1kKZ5JdEsYrOiysMhJ1U2fpHYOtxXi/w/s96kF7YVzSgskZOfaQA6K7h4ey1rJU73mo8pdNnBtmoWYTrm7a0CqOWUOJu95fMdzsOdCnBC5bfou5SaPnwIE3Mm//VsvBh/e1iUdlmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eR1ma8vP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20570b42f24so16776625ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 01:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725351440; x=1725956240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDpBNlTp4IAb2nYSzA4S5C3FeNDLg/TiXjgWPP/Ofy0=;
        b=eR1ma8vP1rVo2mTTdEb7mmcigU/DSrA3KFc1Tano8EYDkLPVUG2vguMd6M3o61aaUd
         zGUUv0JzlEQLNTQu3rIsFF3+ER1OscK1lRxPtcWtbmnfwrTyl4uVEnryl2qxSnSOTIKO
         kSbNuWgU14s7AgajBYideY69lEMcARo54QaeNv9KmQ7gcK2XKEB+1Xn3nXtHJ6X75lhK
         Yb9HFl8gafzsGH5BQDQaV9Uub1dqjn8fx/RorIkcAytnoPbeoCzLTVUIHIL6QvuVMe/g
         8Pg+MlhNbZ93OJlPLsHcjKMiceZC8E5VnEvxVcsigBKaqULh/oeHtpjsHQOavcqrAL19
         phyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725351440; x=1725956240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDpBNlTp4IAb2nYSzA4S5C3FeNDLg/TiXjgWPP/Ofy0=;
        b=GVbJDSX3mizPcjuKB13UCtBvd9JAfhZi29uTQFePdkg91bYmfipzhK3K9ioDvbWwoi
         3y0j5zcboojBwzYjbD5TgoQJ7X3FxsAjYhvk0a0w38EnMBPDm4iQ2fDapQrtGcJqWlwn
         SsMnnLjAeZhsRKUCJJ0gXWJ31XrrISJ6LIXi7kWxONil1hpfgohICJAma73vrtIyB/No
         4T6L3wzbR4xsdIlHnSkT5Ls1t2t6zxjvlmT1OOvCC5VVsR7aoFzh9tIiCwOLrB7TnkG1
         mDfBaUju4Xbb7DYqrcHd4mwd5xI6iZGTEeNlaIml7AVLIwk5pHvLB2Wa0jtEMG59N3WC
         TdKw==
X-Forwarded-Encrypted: i=1; AJvYcCXWh+7FTSKiDNM3LERuFYP/WCViyiqtXCBbrkcguee98vKt8i7AP7iovtTLEFOu1AVb0tmf9v1uoRfqUDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWR3AKkszYgcXMMKZXiBK5sGyehdzu1GqcJLOAacymG0p4j4y3
	1AK0j3JxlP18rBE2E5Cv2hi4ovHiVCDYEKagbLlo1tceQMmrCPvzFWcOAiSQTLs=
X-Google-Smtp-Source: AGHT+IGlXjkmm4wRivHlKxkzFWkFVKdYxcu00qrJi9p0aoh/oPB1y4lwMJCCvMAwLqQVPKWe0Wg4uw==
X-Received: by 2002:a17:903:230a:b0:203:a13a:c49e with SMTP id d9443c01a7336-20699acb7bfmr12843815ad.1.1725351440502;
        Tue, 03 Sep 2024 01:17:20 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20559cae667sm38155435ad.95.2024.09.03.01.17.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Sep 2024 01:17:19 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: axboe@kernel.dk,
	ming.lei@redhat.com,
	yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] block: fix ordering between checking BLK_MQ_S_STOPPED and adding requests
Date: Tue,  3 Sep 2024 16:16:53 +0800
Message-Id: <20240903081653.65613-4-songmuchun@bytedance.com>
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

Supposing first scenario with a virtio_blk driver.

CPU0                                                                CPU1

blk_mq_try_issue_directly()
    __blk_mq_issue_directly()
        q->mq_ops->queue_rq()
            virtio_queue_rq()
                blk_mq_stop_hw_queue()
                                                                    virtblk_done()
    blk_mq_request_bypass_insert()                                      blk_mq_start_stopped_hw_queues()
        /* Add IO request to dispatch list */   1) store                    blk_mq_start_stopped_hw_queue()
                                                                                clear_bit(BLK_MQ_S_STOPPED)                 3) store
    blk_mq_run_hw_queue()                                                       blk_mq_run_hw_queue()
        if (!blk_mq_hctx_has_pending())                                             if (!blk_mq_hctx_has_pending())         4) load
            return                                                                      return
        blk_mq_sched_dispatch_requests()                                            blk_mq_sched_dispatch_requests()
            if (blk_mq_hctx_stopped())          2) load                                 if (blk_mq_hctx_stopped())
                return                                                                      return
            __blk_mq_sched_dispatch_requests()                                          __blk_mq_sched_dispatch_requests()

Supposing another scenario.

CPU0                                                                CPU1

blk_mq_requeue_work()
    /* Add IO request to dispatch list */       1) store            virtblk_done()
    blk_mq_run_hw_queues()/blk_mq_delay_run_hw_queues()                 blk_mq_start_stopped_hw_queues()
        if (blk_mq_hctx_stopped())              2) load                     blk_mq_start_stopped_hw_queue()
            continue                                                            clear_bit(BLK_MQ_S_STOPPED)                 3) store
        blk_mq_run_hw_queue()/blk_mq_delay_run_hw_queue()                       blk_mq_run_hw_queue()
                                                                                    if (!blk_mq_hctx_has_pending())         4) load
                                                                                        return
                                                                                    blk_mq_sched_dispatch_requests()

Both scenarios are similar, the full memory barrier should be inserted between
1) and 2), as well as between 3) and 4) to make sure that either CPU0 sees
BLK_MQ_S_STOPPED is cleared or CPU1 sees dispatch list. Otherwise, either CPU
will not rerun the hardware queue causing starvation of the request.

The easy way to fix it is to add the essential full memory barrier into helper
of blk_mq_hctx_stopped(). In order to not affect the fast path (hardware queue
is not stopped most of the time), we only insert the barrier into the slow path.
Actually, only slow path needs to care about missing of dispatching the request
to the low-level device driver.

Fixes: 320ae51feed5c ("blk-mq: new multi-queue block IO queueing mechanism")
Cc: stable@vger.kernel.org
Cc: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 block/blk-mq.c |  6 ++++++
 block/blk-mq.h | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ac39f2a346a52..48a6a437fba5e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2413,6 +2413,12 @@ void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 		return;
 
 	clear_bit(BLK_MQ_S_STOPPED, &hctx->state);
+	/*
+	 * Pairs with the smp_mb() in blk_mq_hctx_stopped() to order the
+	 * clearing of BLK_MQ_S_STOPPED above and the checking of dispatch
+	 * list in the subsequent routine.
+	 */
+	smp_mb__after_atomic();
 	blk_mq_run_hw_queue(hctx, async);
 }
 EXPORT_SYMBOL_GPL(blk_mq_start_stopped_hw_queue);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 260beea8e332c..f36f3bff70d86 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -228,6 +228,19 @@ static inline struct blk_mq_tags *blk_mq_tags_from_data(struct blk_mq_alloc_data
 
 static inline bool blk_mq_hctx_stopped(struct blk_mq_hw_ctx *hctx)
 {
+	/* Fast path: hardware queue is not stopped most of the time. */
+	if (likely(!test_bit(BLK_MQ_S_STOPPED, &hctx->state)))
+		return false;
+
+	/*
+	 * This barrier is used to order adding of dispatch list before and
+	 * the test of BLK_MQ_S_STOPPED below. Pairs with the memory barrier
+	 * in blk_mq_start_stopped_hw_queue() so that dispatch code could
+	 * either see BLK_MQ_S_STOPPED is cleared or dispatch list is not
+	 * empty to avoid missing dispatching requests.
+	 */
+	smp_mb();
+
 	return test_bit(BLK_MQ_S_STOPPED, &hctx->state);
 }
 
-- 
2.20.1


