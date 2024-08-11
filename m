Return-Path: <linux-kernel+bounces-282206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED26994E0D6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 12:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE0F281B8B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 10:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79974D8AE;
	Sun, 11 Aug 2024 10:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OTwUzk6L"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8835A0FE
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723371588; cv=none; b=gmq4D8NGodXh+3rCN00Ow+1uYTj6U+hHA3rZuF0G3OTOhJaugG69nKIWYmgNwJIrFTMaN62NlJYQQVY6swowFsHX+GEYdaiTsy+l5pR/XcSe3WFjgOrVulP9XguiLTir5y//1eFoCQMrN0qeFerllmZ5h2jEpopksUfB17wIkQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723371588; c=relaxed/simple;
	bh=yv62PE+HHdpS6svbT+CRG1qAc/38LkE6TMF1vR09V/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iURvo9/UQoud/tJYdgdHm0l08X/XRJTAHGXLqNMOeExGcdXvgGsHAFiS0iFsPk3c6vs2/vXQp2Zhyyvf8uQMrcMAjabSb6lcsEhVr3ZtUIxdSEzsS5sYJQysPv9ifuXektawpe81mm7lXR+Krza6BbrPCxXaniCckCZTj56r1r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OTwUzk6L; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fdd6d81812so34686445ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 03:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723371586; x=1723976386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeL46knJ+ZqHC6WT5dXT2aP7zuNbEux3//I19LuUM/0=;
        b=OTwUzk6L5nbjJxLvTk57t2KBqvW1ZODkQks7xyGlW9FJXhnQxFnZVagL4ECEzMFg9U
         9/J9GkvjfRQKeLjxV5i2hCMnb3hMMpUrMUpZEalrVwsrRSbYUZTBuFWNaa0T7Xavw+Cj
         Rt5mCKkx+kNGo6YwZNDAsyWwtUD9+bs1pyjWxqgT5EafV70n4UZFOhB3yrbR1KSRieUx
         gjI62/b3XrfBFUOLc8bYEnHXoqkQbh166rcWJSpwj10bjHeDbREs6oeMTC9bHLM1p3Za
         Gf8sFp8OTrmENp+C/mpqIk10P7mrm2iw6tD19hLTqqUbyulnI8xfiMYAr6gqIJguKYUy
         iaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723371586; x=1723976386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeL46knJ+ZqHC6WT5dXT2aP7zuNbEux3//I19LuUM/0=;
        b=ejMe11tbgZ8+sKAqvEckiLDy1aXm3LJlfoNLfutz/5JvkcXBn4tJTdh9CEtSps2gvD
         9UrzNu4XAjT9fXKUxega6h+KcxXgDZKlCoadrLx5th3V5s1muSmeWh8Nnpec8omzCqR5
         YuJoOS65N52TdvOnVvGez0t/1uLHnBUiVWmWsia8e77FKQKKgL392Sqn3beC/VGPNS5v
         ScrULryomeJvghHme8H6Ij9i7UAOWdRFjmHdIz25r8MDxboU/ehsDkP4SAA6n3UKvnTc
         kfT01T8WtCKcLkfNM4A7AMJSfWFe9RstjTB0ggcpKUWgAu6XR1t8wwaL8tAKXc+LSXS/
         hiYA==
X-Forwarded-Encrypted: i=1; AJvYcCWuCadEoC0SXMglYM6UzHP98uJKAarTF8RTgtyn3GcExLpGm9oMP2EWX/O4N5Wdms7oCRImsoHEmdyzOd3Jp5QJZxGuH8bUAuzmsCe9
X-Gm-Message-State: AOJu0YwBJ9jQ26E19bveQXRLGnKMNcSpgjJPy+klKsLfERC8Ax+br49A
	3KhGbRfa8LIwRx8Su0GUZP6aM/fhg1cTKntpvG2cmsPXHER5R+KX7JmO/sMClg0=
X-Google-Smtp-Source: AGHT+IEQlVNibHSTFhZ2s10HfYkPh8ARzQx4wM3RfJLUDq+guzel8WQQIkhmkI9Swx2NtwrIvNj/lw==
X-Received: by 2002:a17:902:ced0:b0:1fb:2e9a:beea with SMTP id d9443c01a7336-200ae258491mr73318225ad.0.1723371585843;
        Sun, 11 Aug 2024 03:19:45 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bbb48b81sm20992155ad.297.2024.08.11.03.19.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 Aug 2024 03:19:45 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 4/4] block: fix fix ordering between checking QUEUE_FLAG_QUIESCED and adding requests to hctx->dispatch
Date: Sun, 11 Aug 2024 18:19:21 +0800
Message-Id: <20240811101921.4031-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240811101921.4031-1-songmuchun@bytedance.com>
References: <20240811101921.4031-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Supposing the following scenario.

CPU0                                                                CPU1

blk_mq_request_issue_directly()                                     blk_mq_unquiesce_queue()
    if (blk_queue_quiesced())                                           blk_queue_flag_clear(QUEUE_FLAG_QUIESCED)   3) store
        blk_mq_insert_request()                                         blk_mq_run_hw_queues()
            /*                                                              blk_mq_run_hw_queue()
             * Add request to dispatch list or set bitmap of                    if (!blk_mq_hctx_has_pending())     4) load
             * software queue.                  1) store                            return
             */
        blk_mq_run_hw_queue()
            if (blk_queue_quiesced())           2) load
                return
            blk_mq_sched_dispatch_requests()

The full memory barrier should be inserted between 1) and 2), as well as
between 3) and 4) to make sure that either CPU0 sees QUEUE_FLAG_QUIESCED is
cleared or CPU1 sees dispatch list or setting of bitmap of software queue.
Otherwise, either CPU will not re-run the hardware queue causing starvation.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 block/blk-mq.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 385a74e566874..66b21407a9a6c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -264,6 +264,13 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
 		;
 	} else if (!--q->quiesce_depth) {
 		blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
+		/**
+		 * The need of memory barrier is in blk_mq_run_hw_queues() to
+		 * make sure clearing of QUEUE_FLAG_QUIESCED is before the
+		 * checking of dispatch list or bitmap of any software queue.
+		 *
+		 * smp_mb__after_atomic();
+		 */
 		run_queue = true;
 	}
 	spin_unlock_irqrestore(&q->queue_lock, flags);
@@ -2222,6 +2229,21 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 {
 	bool need_run;
 
+	/*
+	 * This barrier is used to order adding of dispatch list or setting
+	 * of bitmap of any software queue outside of this function and the
+	 * test of BLK_MQ_S_STOPPED in the following routine. Pairs with the
+	 * barrier in blk_mq_start_stopped_hw_queue(). So dispatch code could
+	 * either see BLK_MQ_S_STOPPED is cleared or dispatch list or setting
+	 * of bitmap of any software queue to avoid missing dispatching
+	 * requests.
+	 *
+	 * This barrier is also used to order adding of dispatch list or
+	 * setting of bitmap of any software queue outside of this function
+	 * and test of QUEUE_FLAG_QUIESCED below.
+	 */
+	smp_mb();
+
 	/*
 	 * We can't run the queue inline with interrupts disabled.
 	 */
@@ -2244,17 +2266,6 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 	if (!need_run)
 		return;
 
-	/*
-	 * This barrier is used to order adding of dispatch list or setting
-	 * of bitmap of any software queue outside of this function and the
-	 * test of BLK_MQ_S_STOPPED in the following routine. Pairs with the
-	 * barrier in blk_mq_start_stopped_hw_queue(). So dispatch code could
-	 * either see BLK_MQ_S_STOPPED is cleared or dispatch list or setting
-	 * of bitmap of any software queue to avoid missing dispatching
-	 * requests.
-	 */
-	smp_mb();
-
 	if (async || !cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask)) {
 		blk_mq_delay_run_hw_queue(hctx, 0);
 		return;
@@ -2308,6 +2319,11 @@ void blk_mq_run_hw_queues(struct request_queue *q, bool async)
 	 * either see BLK_MQ_S_STOPPED is cleared or dispatch list or setting
 	 * of bitmap of any software queue to avoid missing dispatching
 	 * requests.
+	 *
+	 * This barrier is also used to order clearing of QUEUE_FLAG_QUIESCED
+	 * outside of this function in blk_mq_unquiesce_queue() and checking
+	 * of dispatch list or bitmap of any software queue in
+	 * blk_mq_run_hw_queue().
 	 */
 	smp_mb();
 
-- 
2.20.1


