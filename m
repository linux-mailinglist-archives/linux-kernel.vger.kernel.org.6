Return-Path: <linux-kernel+bounces-363702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6229C99C5CA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F661C22B82
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44527156C72;
	Mon, 14 Oct 2024 09:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SXF2Ncj6"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4EE15689A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898371; cv=none; b=qVCrHZqdDZK3fSXExLSThS+NI/2ntia4ueYJhkOWGWvA0UemXMFGXq3Tc6/0JQhLq2KvYr+Vwngw5aUimnpPOapS8SZ1yFONLT9XTpaLdUbovXH/IzhR9UlK6MZbpi+wa2SCI66NYxoFvMXAgSODl4v9G0GN1sErPEY4TtSWH6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898371; c=relaxed/simple;
	bh=KPYlAEycxQewUTOUahfTRncxoD2+pw617t+q4Tal4uA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HUCYC83ZzyRD8BZQZiddhhxAoR4nKJ1wvIrd1pnQORvTQWztCY2kcnFAkU/N8aOZRvq1Sc5olvI0KP89fm70vU18MURL8ahGzDO1/k8wgQtXLuFTwKy0aHINM6UYU5XYgZwWsf9YJMd6T/pi59C/SOam+jxy0tHTxy8tWzr7Sbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SXF2Ncj6; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e5130832aso942366b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 02:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728898369; x=1729503169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08ooLorU1l3a5zJ7wHu/dTOBgAYH9XEx3vZXzuZBYRU=;
        b=SXF2Ncj6g9TFV6T6I8WCm2zJGEIq+Ktc6KmjRAaO4i+Dy2SycqoTEvA5UHe48HApJk
         PRfzmOOuh6JgxPY0cjsuIVz/svvHGnxtTzM2UtlZrCvAzy0Z5uRjc7vuYAUnLnEuuO+r
         gMwNSKF5e55VGPoaV1mn2TUM3TPP7YMG31R/A3YJdayhJVoLPlZCnBgRmo+ThN2MOuPo
         pXxFIVR0C5RidkPJs+8eoF3WoARlNUQS2PLg8AQ7zJ2Nes/qmVPV9u1hXmmw3pHjSxsD
         jDQlVInhtoUuPyQnznQipG/rrImp+WUy1Bonyu+SxQwr3Z0p8rFYNiKUXxzoCzu1ATtX
         onlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728898369; x=1729503169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08ooLorU1l3a5zJ7wHu/dTOBgAYH9XEx3vZXzuZBYRU=;
        b=d2rPFe0r4laYcTqBMkkJ7NQyr52+vJ5yAnODzIGmZ6wWdebKBtFLGpeBShGbQZ8yDZ
         2zG2xkfYXJmaduuv+Pm++51hP9sHSL8Hdob+85wOoNzMHgl2TIEeyIJEp4HlMLZcdL12
         xD9M92BKB3fuZTkpUglkqVnFZhXc3kNDpYzC6eldjPLoY+5VNPXeXvmBR8iDqwPZ7/lM
         BPQwTaEVBZBmH+FFAVHAOgyS+8pw0XA0XnhMiKg9pkc/txYR9VLgFEx2gQE2x326TdUE
         +JsGePQ8ySmCCLxaUjuYI+4pe73v8Vf8vhI+0QdE6om5G+ghwRPS3pgOWwX9lOnVhUiw
         m7OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuGF2htuq3WT8nM5/wE0xTQWJb6rOAi1g4cJE4wEF5Shs9rVUN8wlpCip1oD0C/4JvQuHGAsNi9aLYh34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6ADRbXVsu2O70ZQSaC9l8kPX51bkjdN71T69OWImH2+KlyDMv
	8DATLDKAVKXMU3iNiYVa/ADytxmzxotAmnGPeYuwavGT0DXuvPNPhttMY99hAhc=
X-Google-Smtp-Source: AGHT+IGBMDRNMKLO//5sYGfMXInq4aAF8gwrpnqlC4y4fsMFrWqYiR5I8wa6nev+Irqz/anUVaW0UQ==
X-Received: by 2002:a05:6a00:23d1:b0:71e:3b51:e856 with SMTP id d2e1a72fcca58-71e4c13dd24mr10888349b3a.1.1728898369262;
        Mon, 14 Oct 2024 02:32:49 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e60bbec80sm2339338b3a.95.2024.10.14.02.32.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 02:32:48 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: axboe@kernel.dk,
	ming.lei@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH RESEND v3 2/3] block: fix ordering between checking QUEUE_FLAG_QUIESCED and adding requests
Date: Mon, 14 Oct 2024 17:29:33 +0800
Message-Id: <20241014092934.53630-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241014092934.53630-1-songmuchun@bytedance.com>
References: <20241014092934.53630-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Supposing the following scenario.

CPU0                        CPU1

blk_mq_insert_request()     1) store
                            blk_mq_unquiesce_queue()
                            blk_queue_flag_clear()                3) store
                              blk_mq_run_hw_queues()
                                blk_mq_run_hw_queue()
                                  if (!blk_mq_hctx_has_pending()) 4) load
                                    return
blk_mq_run_hw_queue()
  if (blk_queue_quiesced()) 2) load
    return
  blk_mq_sched_dispatch_requests()

The full memory barrier should be inserted between 1) and 2), as well as
between 3) and 4) to make sure that either CPU0 sees QUEUE_FLAG_QUIESCED is
cleared or CPU1 sees dispatch list or setting of bitmap of software queue.
Otherwise, either CPU will not rerun the hardware queue causing starvation.

So the first solution is to 1) add a pair of memory barrier to fix the
problem, another solution is to 2) use hctx->queue->queue_lock to
synchronize QUEUE_FLAG_QUIESCED. Here, we chose 2) to fix it since memory
barrier is not easy to be maintained.

Fixes: f4560ffe8cec ("blk-mq: use QUEUE_FLAG_QUIESCED to quiesce queue")
Cc: stable@vger.kernel.org
Cc: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 47 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b2d0f22de0c7f..ff6df6c7eeb25 100644
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
+		need_run = !blk_queue_quiesced(hctx->queue) &&
+		blk_mq_hctx_has_pending(hctx));
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
+		 * Synchronize with blk_mq_unquiesce_queue(), because we check
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


