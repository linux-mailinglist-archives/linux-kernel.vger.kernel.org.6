Return-Path: <linux-kernel+bounces-264104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 832ED93DEFD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B92B1F218C1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3799B8002E;
	Sat, 27 Jul 2024 11:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rkpx50GJ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B806853E22
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722078148; cv=none; b=KCpL/er2M7iLAefQFJs0b4z817gkEtsCcvxAO5zVQWQGxWIVDCVJ02TePPxWQP0k4WVds8xBus9rE9skmywwnYiJNr4nb8+UT0sHQffcCVi0pt7p7CqWINi1AALw73BIPJGmQ7ahVgL/fdp2z+cBNE6gh+GX0NPDSLAQV3rcnzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722078148; c=relaxed/simple;
	bh=WxACGyjM8uXZHdHrTp/rYtGc/g0ySsYwgQvxlBhYS3g=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=gojDzDsb+av4LluagyMsx8zQEunpC/F9EaNo5m/NNymVRTSkNYqYxOYAesyqISqoEpj2hHakp6SKvgYyIKFcOddC6VenkpxjqfFThDismBAH51e25Vvo9G8xXI1xPnvmJlzRaqMMgcnKDgLVV4gzrYLYN/AvmakDE6t/LDAa5PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Rkpx50GJ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=NLtNFSK8fuvX7I5XkvXJ2Vk6YGgGJlY5tluqW0aUh0o=; b=Rkpx50GJ4UC8xdjckeH/jFwm5A
	GgiuPzfBhftQQuedLIsEo9HyN2RgeDC7eBUbqdNP8QbK7qtsJz1uW6FOlf1JKexmXUmXykh+IKcJq
	8Gex4ws1IVVjdGr9EHKYU4yUSjSbgmWvuyvA9o64dtBhKZt3pa1D4e6VCkIPfUkpN5VJfVg038hR2
	OWmm7/lXE5Cxqr2r7y/+yndDswD4ld8u4g5CWfWn6JR/tK12HJWnREDCpUnw9BN98j5z/KppwjGzl
	JXZVBtghX4yIFmMMzFpLHAccE9nfj/EOkodsjArVRLbajHDh3CHxprJqR12F8/UhRDXnCyQ1gfjP2
	ohEw/1PQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXfBg-00000004QMn-3xkM;
	Sat, 27 Jul 2024 11:02:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id D741C3061E4; Sat, 27 Jul 2024 13:02:06 +0200 (CEST)
Message-Id: <20240727105030.110439521@infradead.org>
User-Agent: quilt/0.65
Date: Sat, 27 Jul 2024 12:27:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@redhat.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com,
 youssefesmat@chromium.org,
 tglx@linutronix.de,
 efault@gmx.de
Subject: [PATCH 16/24] sched: Teach dequeue_task() about special task states
References: <20240727102732.960974693@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Since special task states must not suffer spurious wakeups, and the
proposed delayed dequeue can cause exactly these (under some boundary
conditions), propagate this knowledge into dequeue_task() such that it
can do the right thing.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |    7 ++++++-
 kernel/sched/sched.h |    3 ++-
 2 files changed, 8 insertions(+), 2 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6521,11 +6521,16 @@ static void __sched notrace __schedule(u
 		if (signal_pending_state(prev_state, prev)) {
 			WRITE_ONCE(prev->__state, TASK_RUNNING);
 		} else {
+			int flags = DEQUEUE_NOCLOCK;
+
 			prev->sched_contributes_to_load =
 				(prev_state & TASK_UNINTERRUPTIBLE) &&
 				!(prev_state & TASK_NOLOAD) &&
 				!(prev_state & TASK_FROZEN);
 
+			if (unlikely(is_special_task_state(prev_state)))
+				flags |= DEQUEUE_SPECIAL;
+
 			/*
 			 * __schedule()			ttwu()
 			 *   prev_state = prev->state;    if (p->on_rq && ...)
@@ -6537,7 +6542,7 @@ static void __sched notrace __schedule(u
 			 *
 			 * After this, schedule() must not care about p->state any more.
 			 */
-			block_task(rq, prev, DEQUEUE_NOCLOCK);
+			block_task(rq, prev, flags);
 		}
 		switch_count = &prev->nvcsw;
 	}
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2254,10 +2254,11 @@ extern const u32		sched_prio_to_wmult[40
  *
  */
 
-#define DEQUEUE_SLEEP		0x01
+#define DEQUEUE_SLEEP		0x01 /* Matches ENQUEUE_WAKEUP */
 #define DEQUEUE_SAVE		0x02 /* Matches ENQUEUE_RESTORE */
 #define DEQUEUE_MOVE		0x04 /* Matches ENQUEUE_MOVE */
 #define DEQUEUE_NOCLOCK		0x08 /* Matches ENQUEUE_NOCLOCK */
+#define DEQUEUE_SPECIAL		0x10
 #define DEQUEUE_MIGRATING	0x100 /* Matches ENQUEUE_MIGRATING */
 #define DEQUEUE_DELAYED		0x200 /* Matches ENQUEUE_DELAYED */
 



