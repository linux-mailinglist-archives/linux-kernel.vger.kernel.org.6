Return-Path: <linux-kernel+bounces-315824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEAC96C762
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC27287592
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABB01E6DC0;
	Wed,  4 Sep 2024 19:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+qdyN7s"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F541E6311
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725477681; cv=none; b=JisnFAyzTqQ3CqeaKs1Jmf57XntqPC9eeLu5wPaxZCnWS6tr801BUMhw3ih3qZkOWJcaEp5VCe6JLVBTGoopbIXEA4QEH5yLl84zWh9HMe6ZuHRLa2ml8eyQrsKwZVFg4bRgEEFjnh8myFmv3BZ1DG2Yl65z5QfIMoaG9/izCJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725477681; c=relaxed/simple;
	bh=pGa7u7ieb4EUdWX9xTK0+u0ZbSur2prvixiWQUtZWCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Re4c6N1xYhX+M6i1GS/U0ipaIRZfACuIFBTXRTNwEOIe+zy3GAd0+FS7dAQnHia2NDti+tkSfP2yQzk8lgiPNyD5mHK0ODWA0T6hGfbtxdbveCLWkaYa6g6IceUpV6n7wfRB9sbrRt3mpFu0EFKr2Y8FR7UTJMt6NhEhhLj0vok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+qdyN7s; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428e1915e18so57415865e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 12:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725477677; x=1726082477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wdqAsVpkuRSY1jXdBBvUbDMsUymqTBzc3tB6AHQ0SKk=;
        b=c+qdyN7sEeDE0844LzOCMh14puVei9/4OjXtOZxkSNhXANOesyBo50BOtSWGtojfs3
         LA7ylqeZX4N+IShyUyYErgaNClzWvD8/FJOkdQWwybT+cyDBjIY/6egTj+CccjMRXp35
         1/bajjUOB7vgHZfU4LYD2XSzH21OvMoxpNtjB3UB4gjwLoLY5ltwOY0fOTbFgG/KuSgl
         ZaA9o1/STB/56CIeaaCNlAPfAywTLZ/j6UCP2jmJrvZOKzSs/ZbA4HmO+nhHjjdWXU5Y
         BilACj0lZYBPI7rzy5yI7ZMupLrfnB+L+ZhujLppdmnj7pZDlry1DN2EB/XTUnoC/ljb
         gRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725477677; x=1726082477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wdqAsVpkuRSY1jXdBBvUbDMsUymqTBzc3tB6AHQ0SKk=;
        b=Nuwen+eS/hnZR8BaKsv3xW8RODe9rvWz0iRiXQ6oiK3TaGKFF5qi4Z7EDBLoVA2jMC
         ZwHbVGOlSOR1Y0w8LZPBgMs2Pj0t854TVjT35jMKB1gP2/1Z70Ip5rcaX5c75JbMZcLL
         qVm1R0Dl7CGXogW9CIVK4iV+5eiMqPOw8jrFMK/ftOQ+CuiROaqvLkWJQLPi49BYnpF7
         XBmtulMxovKSq8rsk3TvHOUUNJhr1kfq7215vnbIbo/2tGDlUp11kiLxTuIaRr1xJm+o
         DdMDiqDcf+SxcmaEULsI8SB2sVWi/EOh2Zf0tB13j2w0opYl4V+UxmNqamaHoKOgzgk6
         MmvQ==
X-Gm-Message-State: AOJu0Yz0RqQev/JB4NiBmGaCeaDtbl/cN+gk5nIvgPrgEk5pEyZcw3sW
	PfrfmwQ0bhc3GnZ389wTfzP4SOQeIBP5fSEeD6HzJhY1OEYqsrRaOXYsKGiPjPo=
X-Google-Smtp-Source: AGHT+IHTb1whdWr/g0jbtW7if8TSwPVnmMfUSQZRg5D6dFL9c+je/dwYxXcBhENiIMVvHQn3ZgS46A==
X-Received: by 2002:a05:600c:3582:b0:42b:9260:235f with SMTP id 5b1f17b1804b1-42c7b5b4b72mr92303965e9.19.1725477676576;
        Wed, 04 Sep 2024 12:21:16 -0700 (PDT)
Received: from localhost.localdomain ([156.197.26.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bba57bb20sm189366175e9.4.2024.09.04.12.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 12:21:16 -0700 (PDT)
From: Ahmed Ehab <bottaawesome633@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] Refactor switch_mm_cid() to avoid unnecessary checks
Date: Thu,  5 Sep 2024 01:18:17 +0300
Message-ID: <20240904221817.56664-1-bottaawesome633@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The issue is that we check if we are switching from {kernel,user} to
{kernel, user} multiple times unnecessarily.

To fix this, refactor switch_mm_cid() and break it into multiple methods
to handle the cases of switching from {kernel,user} to {kernel, user}.
Hence, we avoid any redundant checks.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408270455.R85TrPfw-lkp@intel.com/
Signed-off-by: Ahmed Ehab <bottaawesome633@gmail.com>
---
 kernel/sched/core.c  | 15 +++++---
 kernel/sched/sched.h | 84 +++++++++++++++++++++++++++-----------------
 2 files changed, 62 insertions(+), 37 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f3951e4a55e5..900c5a763e0a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5155,9 +5155,15 @@ context_switch(struct rq *rq, struct task_struct *prev,
 		enter_lazy_tlb(prev->active_mm, next);
 
 		next->active_mm = prev->active_mm;
-		if (prev->mm)                           // from user
+		if (prev->mm) {                           // from user
 			mmgrab_lazy_tlb(prev->active_mm);
+			switch_mm_cid_from_user_to_kernel(rq, prev, next);
+		}
 		else
+			/*
+			 * kernel -> kernel transition does not change rq->curr->mm
+			 * state. It stays NULL.
+			 */
 			prev->active_mm = NULL;
 	} else {                                        // to user
 		membarrier_switch_mm(rq, prev->active_mm, next->mm);
@@ -5176,12 +5182,11 @@ context_switch(struct rq *rq, struct task_struct *prev,
 			/* will mmdrop_lazy_tlb() in finish_task_switch(). */
 			rq->prev_mm = prev->active_mm;
 			prev->active_mm = NULL;
-		}
+			switch_mm_cid_from_kernel_to_user(rq, prev, next);
+		} else
+			switch_mm_cid_from_user_to_user(rq, prev, next);
 	}
 
-	/* switch_mm_cid() requires the memory barriers above. */
-	switch_mm_cid(rq, prev, next);
-
 	prepare_lock_switch(rq, next, rf);
 
 	/* Here we just switch the register state and the stack. */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4c36cc680361..c01ca8962518 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3524,38 +3524,6 @@ static inline void switch_mm_cid(struct rq *rq,
 	 *
 	 * Should be adapted if context_switch() is modified.
 	 */
-	if (!next->mm) {                                // to kernel
-		/*
-		 * user -> kernel transition does not guarantee a barrier, but
-		 * we can use the fact that it performs an atomic operation in
-		 * mmgrab().
-		 */
-		if (prev->mm)                           // from user
-			smp_mb__after_mmgrab();
-		/*
-		 * kernel -> kernel transition does not change rq->curr->mm
-		 * state. It stays NULL.
-		 */
-	} else {                                        // to user
-		/*
-		 * kernel -> user transition does not provide a barrier
-		 * between rq->curr store and load of {prev,next}->mm->pcpu_cid[cpu].
-		 * Provide it here.
-		 */
-		if (!prev->mm) {                        // from kernel
-			smp_mb();
-		} else {				// from user
-			/*
-			 * user->user transition relies on an implicit
-			 * memory barrier in switch_mm() when
-			 * current->mm changes. If the architecture
-			 * switch_mm() does not have an implicit memory
-			 * barrier, it is emitted here.  If current->mm
-			 * is unchanged, no barrier is needed.
-			 */
-			smp_mb__after_switch_mm();
-		}
-	}
 	if (prev->mm_cid_active) {
 		mm_cid_snapshot_time(rq, prev->mm);
 		mm_cid_put_lazy(prev);
@@ -3565,8 +3533,60 @@ static inline void switch_mm_cid(struct rq *rq,
 		next->last_mm_cid = next->mm_cid = mm_cid_get(rq, next->mm);
 }
 
+static inline void switch_mm_cid_from_user_to_kernel(struct rq *rq,
+						     struct task_struct *prev,
+						     struct task_struct *next)
+
+{
+	/**
+	 * user -> kernel transition does not guarantee a barrier, but
+	 * we can use the fact that it performs an atomic operation in
+	 * mmgrab().
+	 */
+	smp_mb__after_mmgrab();
+	switch_mm_cid(rq, prev, next);
+
+}
+
+static inline void switch_mm_cid_from_kernel_to_user(struct rq *rq,
+						     struct task_struct *prev,
+						     struct task_struct *next)
+
+{
+	/*
+	 * kernel -> user transition does not provide a barrier
+	 * between rq->curr store and load of {prev,next}->mm->pcpu_cid[cpu].
+	 * Provide it here.
+	 */
+	smp_mb();
+	switch_mm_cid(rq, prev, next);
+
+}
+
+
+static inline void switch_mm_cid_from_user_to_user(struct rq *rq,
+						   struct task_struct *prev,
+						   struct task_struct *next)
+
+{
+	/*
+	 * user->user transition relies on an implicit
+	 * memory barrier in switch_mm() when
+	 * current->mm changes. If the architecture
+	 * switch_mm() does not have an implicit memory
+	 * barrier, it is emitted here.  If current->mm
+	 * is unchanged, no barrier is needed.
+	 */
+	smp_mb__after_switch_mm();
+	switch_mm_cid(rq, prev, next);
+
+}
+
 #else /* !CONFIG_SCHED_MM_CID: */
 static inline void switch_mm_cid(struct rq *rq, struct task_struct *prev, struct task_struct *next) { }
+static inline void switch_mm_cid_from_user_to_user(struct rq *rq, struct task_struct *prev, struct task_struct *next) { }
+static inline void switch_mm_cid_from_user_to_kernel(struct rq *rq, struct task_struct *prev, struct task_struct *next) { }
+static inline void switch_mm_cid_from_kernel_to_user(struct rq *rq, struct task_struct *prev, struct task_struct *next) { }
 static inline void sched_mm_cid_migrate_from(struct task_struct *t) { }
 static inline void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t) { }
 static inline void task_tick_mm_cid(struct rq *rq, struct task_struct *curr) { }
-- 
2.46.0


