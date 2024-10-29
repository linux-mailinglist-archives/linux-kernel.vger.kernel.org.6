Return-Path: <linux-kernel+bounces-386556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3938D9B450C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C6DB1C20CEF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412A5204029;
	Tue, 29 Oct 2024 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PsV0AbyP"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CA420493B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730192186; cv=none; b=EcITCpRPzkr6HOo0AXdSd1T3R9ez31dw/Oj9JaECKIW4G+Wpzni0LxeUiGdeO7YGvlkSwrPwJOH/7/+qtldgEgpcqxFrOnb/85qb9TPvOxbAVT0bZ2nMjd//DPo5NvVsyXmOeiea+Z+xB8Gv+c8oT0Mpl6Sm+WOWiZk95pPrvTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730192186; c=relaxed/simple;
	bh=AXIBIm6u6Qx7op8AsQATpLo/Zp3lmq8PTNJE67XTfpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G9wXKGdaJ4qFEezzSurfb7udmVwPRNdDopmXVzsxjfStRLPq9Pk34Pt6G+dkBAZjJbK5TzovVwWq8na5/1J4kMaxUtaXQFvLsNp+tpKhwlvNclQP12XFS5ojkNRcuUNUeb8Kzeb5zDhn7g5JfuVhYDhX432aBWAQrJR3ainSvRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PsV0AbyP; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ea6a4f287bso3293837a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730192184; x=1730796984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFSFeeDBOyZstKB4qR1rdcdR6LJarrbDAw3IQnrq+2o=;
        b=PsV0AbyPRImWvDekcrMqlDLXKnJ3jmiOjLhD1PAil9ERY7unor8f3pMgASKq1lCVcV
         k9A/SdCwkfo4MUGO9xk6H75oW44KKIKs0T2C/H8pVU9TwcW9QV8l1qedHCTa763o//Ga
         jyDbcFpJu+/dcXh8Gablk0ZiyiJsSldnvvCZ1nZt/DHR14UvED7wDMSsRMTYd8FP3tTd
         9hlo1caEvw1R218tCVC7XkVnBAoaduThWBA9UZDGnA4a+zceBglw7WyzoiDYv+B7j/e8
         X/V9y4pm0MdEZvmmm5C6LGSsmQd6oxk1qmMuTXIchN1372lS19MtEXZj1VFrZXstxVMD
         fI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730192184; x=1730796984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFSFeeDBOyZstKB4qR1rdcdR6LJarrbDAw3IQnrq+2o=;
        b=kTVMoRmLiN7Pf/DMrI10OqV3oPEVUCZ66I2dR5yD5XvdUPtcXe8Vtcwc1jLCYq3/Yr
         V0+WgwOkEyBmcYY3tEw9xI58DgBsLzyMzF8oaJjQsBvaSAshiMXLhL8a/uk979kJyIcJ
         eYTisKnhSs3XiHute08uJHMQfVchFaZEs5fhWCUDRGbRfEzl/XaLXOAzlIfsYMMDsXJ0
         4P7eqHBuJdwGdlAG+z25Z2uajzKL+szz9DekAZeIjM3ilFp5fOmkPg3heo7n0PcNKl/J
         5/I4+gPKrYrKC1XSBKh4vr94x7N8UwDOElo+HKaWBny0ZyRcFQWHp401BfL075fVO2v9
         UFfA==
X-Forwarded-Encrypted: i=1; AJvYcCVs7eegb8qIloMyu6fvbTw7Rb7IuvfyxOedOICMkashTS8f+hmcZXMbLVm0BeQ8JM7nfLm7EDzdu7ab1mE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqBc8mCEHUVZZzEltIlTDJfVdib02OVKiOSvFuC5/I5wRNAMUq
	CRmWADyuReVecaRVvMW3xZNG2Ybj68z58UZA1YByVPp79yzbFa2dS3ekjlxUMXc=
X-Google-Smtp-Source: AGHT+IHUiKiL8NxbpHUidQXUZlRt/40IbI6UTNYVhRyPPrvl8eNbx53ouNpRbo+L6FHbv61oZFiB4g==
X-Received: by 2002:a05:6a21:1798:b0:1d9:18b7:496 with SMTP id adf61e73a8af0-1d9a851e099mr15600766637.45.1730192183609;
        Tue, 29 Oct 2024 01:56:23 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8696a86sm7156832a12.47.2024.10.29.01.56.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Oct 2024 01:56:23 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: axboe@kernel.dk,
	tj@kernel.org,
	yukuai1@huaweicloud.com
Cc: chengming.zhou@linux.dev,
	muchun.song@linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH v2 2/2] block: refactor rq_qos_wait()
Date: Tue, 29 Oct 2024 16:55:59 +0800
Message-Id: <20241029085559.98390-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241029085559.98390-1-songmuchun@bytedance.com>
References: <20241029085559.98390-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When rq_qos_wait() is first introduced, it is easy to understand. But
with some bug fixes applied, it is not easy for newcomers to understand
the whole logic under those fixes. In this patch, rq_qos_wait() is
refactored and more comments are added for better understanding. There
are 3 points for the improvement:

1) Use waitqueue_active() instead of wq_has_sleeper() to eliminate
   unnecessary memory barrier in wq_has_sleeper() which is supposed
   to be used in waker side. In this case, we do need the barrier.
   So use the cheaper one to locklessly test for waiters on the queue.

2) Remove acquire_inflight_cb() logic for the first waiter out of the
   while loop to make the code clear.

3) Add more comments to explain how to sync with different waiters and
   the waker.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
---
v2:
 - Introduce init_wait_func() in a seprate patch (Yu Kuai).

 block/blk-rq-qos.c | 68 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 21 deletions(-)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 858ce69c04ece..5d995d389eaf5 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -223,6 +223,14 @@ static int rq_qos_wake_function(struct wait_queue_entry *curr,
 	 * Remove explicitly and use default_wake_function().
 	 */
 	default_wake_function(curr, mode, wake_flags, key);
+	/*
+	 * Note that the order of operations is important as finish_wait()
+	 * tests whether @curr is removed without grabbing the lock. This
+	 * should be the last thing to do to make sure we will not have a
+	 * UAF access to @data. And the semantics of memory barrier in it
+	 * also make sure the waiter will see the latest @data->got_token
+	 * once list_empty_careful() in finish_wait() returns true.
+	 */
 	list_del_init_careful(&curr->entry);
 	return 1;
 }
@@ -248,37 +256,55 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 		 cleanup_cb_t *cleanup_cb)
 {
 	struct rq_qos_wait_data data = {
-		.rqw = rqw,
-		.cb = acquire_inflight_cb,
-		.private_data = private_data,
+		.rqw		= rqw,
+		.cb		= acquire_inflight_cb,
+		.private_data	= private_data,
+		.got_token	= false,
 	};
-	bool has_sleeper;
+	bool first_waiter;
 
-	has_sleeper = wq_has_sleeper(&rqw->wait);
-	if (!has_sleeper && acquire_inflight_cb(rqw, private_data))
+	/*
+	 * If there are no waiters in the waiting queue, try to increase the
+	 * inflight counter if we can. Otherwise, prepare for adding ourselves
+	 * to the waiting queue.
+	 */
+	if (!waitqueue_active(&rqw->wait) && acquire_inflight_cb(rqw, private_data))
 		return;
 
 	init_wait_func(&data.wq, rq_qos_wake_function);
-	has_sleeper = !prepare_to_wait_exclusive(&rqw->wait, &data.wq,
+	first_waiter = prepare_to_wait_exclusive(&rqw->wait, &data.wq,
 						 TASK_UNINTERRUPTIBLE);
+	/*
+	 * Make sure there is at least one inflight process; otherwise, waiters
+	 * will never be woken up. Since there may be no inflight process before
+	 * adding ourselves to the waiting queue above, we need to try to
+	 * increase the inflight counter for ourselves. And it is sufficient to
+	 * guarantee that at least the first waiter to enter the waiting queue
+	 * will re-check the waiting condition before going to sleep, thus
+	 * ensuring forward progress.
+	 */
+	if (!data.got_token && first_waiter && acquire_inflight_cb(rqw, private_data)) {
+		finish_wait(&rqw->wait, &data.wq);
+		/*
+		 * We raced with rq_qos_wake_function() getting a token,
+		 * which means we now have two. Put our local token
+		 * and wake anyone else potentially waiting for one.
+		 *
+		 * Enough memory barrier in list_empty_careful() in
+		 * finish_wait() is paired with list_del_init_careful()
+		 * in rq_qos_wake_function() to make sure we will see
+		 * the latest @data->got_token.
+		 */
+		if (data.got_token)
+			cleanup_cb(rqw, private_data);
+		return;
+	}
+
+	/* we are now relying on the waker to increase our inflight counter. */
 	do {
-		/* The memory barrier in set_task_state saves us here. */
 		if (data.got_token)
 			break;
-		if (!has_sleeper && acquire_inflight_cb(rqw, private_data)) {
-			finish_wait(&rqw->wait, &data.wq);
-
-			/*
-			 * We raced with rq_qos_wake_function() getting a token,
-			 * which means we now have two. Put our local token
-			 * and wake anyone else potentially waiting for one.
-			 */
-			if (data.got_token)
-				cleanup_cb(rqw, private_data);
-			return;
-		}
 		io_schedule();
-		has_sleeper = true;
 		set_current_state(TASK_UNINTERRUPTIBLE);
 	} while (1);
 	finish_wait(&rqw->wait, &data.wq);
-- 
2.20.1


