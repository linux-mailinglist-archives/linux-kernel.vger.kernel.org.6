Return-Path: <linux-kernel+bounces-282204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3B194E0D1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 12:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3961C20A8B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 10:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C27D4D8A2;
	Sun, 11 Aug 2024 10:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XXAkHmvb"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB73481CE
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 10:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723371582; cv=none; b=lxutwZ2aDmx4IWN92Dn+w8nUP4MLPEayGeugXLkQXShwoTpntKIbl8/7BibsdJgmJV90tHQqPRNogCp0UPIAimEyG9end+VWEJeP1qeEqV622gIv1LwiVphjBjxZvHM/7n1Uje3Of3ICD9meoKgY1DqLzSiwtL+RPGJNnl2T034=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723371582; c=relaxed/simple;
	bh=6pftb2nnNbxoYTrue2Jw5X76kBNH8jDfyjIN9qpxI1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BNg7ljbgWpLbMU51ADo3yTUos4bfTIPt87nk+Q4AhCM0SYIu4dn5ruMyDA8xxry+vZ6T7zcbaWIBc54C1MQKrfra2mXMNXxAVFOTJMKSR8PHx35LPrBP71id7ZLFj4p/Qw8F7Cl4nNCs0065w2PBtWQRrVrLAohgNdGmiK6pX64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XXAkHmvb; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3db16b2c1d2so2661377b6e.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 03:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723371580; x=1723976380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nvX3wlUypt+6rCQzwo1fpItqGzwm6bo/2mQyCkFK9s=;
        b=XXAkHmvbt1ZgL+N+KEuYtJsOrMixC5FPNa1YEInbx6I+R2Ke+Q2gIM+QgZoNTC3eqK
         xOPWXRmSZlQHlHphWNrRME2zuNuOCFm01GDi8Eaf1kyfhZuNQH7Coe1e+COrhAPHHL7a
         pC4PStqaZ7eNKiEH8QaT+vSv5eUDkhUQb9ZcP044sG3gH2YFaezVCxrUT2HZhkZaXdqW
         fYQSsIJQCmwv71WY3MjycM8x8GEcilUYj+IFEjDCAirMVCtgoNkWAsJykhehQ/shbblJ
         MDUJD7F5kIiGOIluoE3yhYDZBXdO/S+uJovNfmm06+J71C3f1nsJqCjpnlMwfmY5Q0t1
         rawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723371580; x=1723976380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nvX3wlUypt+6rCQzwo1fpItqGzwm6bo/2mQyCkFK9s=;
        b=YJlcs5jqVYGZJeD6rlp8l0H42QTZRS6GZPO3f/oV6tkQY9j4l+hk31QVbBkL932+RM
         Br6U1nlflaNgU3URHMohUtQgRAWvSUwrEmEYUtPfcdX/Ag2vCB4DSv2idY22ba0TDDDe
         HZy9ek1yX0PcbQ13LvUC0C/Urr1WToSk9T/KErWJMkPY687575nfgVv9DI2DCzzPEIB8
         Uq3IXvpL4UOmDpgXwsqb5FHfQV0PNgzECxlcdCcAM2V1DmCg0GL7WOPToYxc5DdhI34t
         E/Tnf7P62Ym9fmMmz1kYQPD28NH3EOsO7tlllq3bEuV3dx0pD+fVwFaP3pht4VimDH6o
         4fZw==
X-Forwarded-Encrypted: i=1; AJvYcCUrHfu5xWzph5DmMYrHtIC2uW/ukNO2lnaRaW08+YJvokrfOSR4jDQvRYDhXVoIt71ZMEt3i8IVbRUbe8C6XGzzdYq9bcLhd8A0WVPY
X-Gm-Message-State: AOJu0YwmuJlfglahkgjN+sMtCxyyUHzGQvrI9zLMUe5tfUvUvrN/JBiY
	rXhV/dfd3Htb/WF0Q6ZPDTYrXlZjjG9TPYm/q2PKLE1OrSBZ5oSgDrLttH3vy/LVWZFsdbeXrD0
	F
X-Google-Smtp-Source: AGHT+IGNBvMJelhnYpGmxkSKFmzcolA3NBJvUuOHdFqKSBrLXqP7AFYt9sICFSkTLaLIlAD7xmrYZw==
X-Received: by 2002:a05:6808:30a5:b0:3da:ae19:ef0 with SMTP id 5614622812f47-3dc417059e8mr9311323b6e.49.1723371579831;
        Sun, 11 Aug 2024 03:19:39 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bbb48b81sm20992155ad.297.2024.08.11.03.19.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 Aug 2024 03:19:39 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 2/4] block: fix ordering between checking BLK_MQ_S_STOPPED and adding requests to hctx->dispatch
Date: Sun, 11 Aug 2024 18:19:19 +0800
Message-Id: <20240811101921.4031-3-songmuchun@bytedance.com>
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

Supposing the following scenario with a virtio_blk driver.

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

The full memory barrier should be inserted between 1) and 2), as well as between
3) and 4) to make sure that either CPU0 sees BLK_MQ_S_STOPPED is cleared or CPU1
sees dispatch list or setting of bitmap of software queue. Otherwise, either CPU
will not re-run the hardware queue causing starvation.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 block/blk-mq.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b2d0f22de0c7f..6f18993b8f454 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2075,6 +2075,13 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 		 * in blk_mq_sched_restart(). Avoid restart code path to
 		 * miss the new added requests to hctx->dispatch, meantime
 		 * SCHED_RESTART is observed here.
+		 *
+		 * This barrier is also used to order adding of dispatch list
+		 * above and the test of BLK_MQ_S_STOPPED in the following
+		 * routine (in blk_mq_delay_run_hw_queue()). Pairs with the
+		 * barrier in blk_mq_start_stopped_hw_queue(). So dispatch code
+		 * could either see BLK_MQ_S_STOPPED is cleared or dispatch list
+		 * to avoid missing dispatching requests.
 		 */
 		smp_mb();
 
@@ -2237,6 +2244,17 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 	if (!need_run)
 		return;
 
+	/*
+	 * This barrier is used to order adding of dispatch list or setting
+	 * of bitmap of any software queue outside of this function and the
+	 * test of BLK_MQ_S_STOPPED in the following routine. Pairs with the
+	 * barrier in blk_mq_start_stopped_hw_queue(). So dispatch code could
+	 * either see BLK_MQ_S_STOPPED is cleared or dispatch list or setting
+	 * of bitmap of any software queue to avoid missing dispatching
+	 * requests.
+	 */
+	smp_mb();
+
 	if (async || !cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask)) {
 		blk_mq_delay_run_hw_queue(hctx, 0);
 		return;
@@ -2392,6 +2410,13 @@ void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 		return;
 
 	clear_bit(BLK_MQ_S_STOPPED, &hctx->state);
+	/*
+	 * Pairs with the smp_mb() in blk_mq_run_hw_queue() or
+	 * blk_mq_dispatch_rq_list() to order the clearing of
+	 * BLK_MQ_S_STOPPED and the test of dispatch list or
+	 * bitmap of any software queue.
+	 */
+	smp_mb__after_atomic();
 	blk_mq_run_hw_queue(hctx, async);
 }
 EXPORT_SYMBOL_GPL(blk_mq_start_stopped_hw_queue);
-- 
2.20.1


