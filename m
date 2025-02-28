Return-Path: <linux-kernel+bounces-538365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC12A4979F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E193BA50F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD2225F7A9;
	Fri, 28 Feb 2025 10:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="iiOyoC/F"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B3925C715
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740739442; cv=none; b=ipHHdPUuZyVAzjUdmxMoz9DAkS+RnNdVzvO/sZF+pQ/kaWUmV2lJu3lJl4+BXQN+sjoVe1CQBxFvyvUJodZ875v+AggmvOgyeOcM8s8JhiTNBy7qSHIO20FOdMn/ps0+R6tFcFTf5FPubPtiFr8MU2jL9iilczEsVMx5QPIhzWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740739442; c=relaxed/simple;
	bh=30gTwZ7bAoXwE4rB6Ipx4ul5/zTbp92zD7vXVbloYAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K0ulCj+HAsqrU/jnUse3VmYFK4u3fk+8nmpEUpNSDgZM914Pv5vx6GsdCVnzL5RzVLD0K5UPPHed2JigGhdXmnnQ+oGtC/KzPyxGPVCY5kuQ/29birw1tZOOMTqS4zOLaEYD/dxwgiNfmKcVvml+8N5uxKKj0lKzMwnZfVD5LHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=iiOyoC/F; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fbffe0254fso4026917a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1740739440; x=1741344240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=joQAlWzi3rsOp1MlSht4qO1NHlVdWdwzqn85zxRvT2o=;
        b=iiOyoC/FoD0rsrtsUY6TsSh3hzXcKgPGfDAod6ZSGAT/05ohiK+P9/vg1tpiZc5qAN
         DbW8wt4+m8T4WAkTyXw0QnemFbfEzy25CbPOQXyZz6+gWtHYiiXSq4fy/kWFGtZy8En/
         qdBf9rYFziIL5f/Y+F01quQmPanQZZshJjprCo4GJNOadCoTnpY/sf4XSLhE5TZqoGss
         MEDahcZ27jjWwODWRl0ZKxaNI26ZHtWXBL5acGNihfYQRinxantiW370kTn4j1LmErc2
         PILuASAmqhiDiqXxPeAuEnpDVKekiGi+NorPLgQfiSmWwl8JHQeHiifSyMWMQ9r1Kv11
         1OTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740739440; x=1741344240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=joQAlWzi3rsOp1MlSht4qO1NHlVdWdwzqn85zxRvT2o=;
        b=E0R+r3eRyvJQ4NBkZD5dAS4vfPkKi3VR9Ftf4OTdRl46WMihUNBwmMfGMWZXSmvisd
         5mqb7/OXfzJhQXdQsSCmcsVMYwZ1SbaB/Dlkr+vbgG2tlPX9bKBj9u2XqysKTB63eRgn
         C+FQugtmvnhkzM9HAy7kDvRL3qDegI/dZxHnIPpbFq+MwJR6zl4OTP1vlwblEsgLJP0i
         wymyNLEKIQ+PYzhwbJquQkSSMk77RBtKiayprDPVEIJR02SeXtvtcf1h+r3mXF75K8sL
         kkuYZmtXfkbnB2qwbd+yoavZE7iqt51LJ7x7ZSK2mrM4i+dPlK5WH5PnFJw5yMcUAQr6
         b51Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdsUSY6Q//AfWDGSR8MjCvnjhvpeYtV0f6mPo/Fyahhw14JXWPWkzB/1mTX9at/3Miaa7NDpswU8jKH60=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNw1Jf1KnpHdRpinUyMyPJ0Ho7rPuO0I2UgnyTHFcZ5SKeFRl+
	fXy6Bnqb2mErID791KhSI9vTIApfplTOSIUWHpJIGZIZSKNMXAj3SlOKy7+QEog=
X-Gm-Gg: ASbGnctyVZq35pMLiKLv6m2MyW+0oJe0hmiHQ7ifmV3jyjgwZKfCqorKnsnL8QpQSoE
	O+lbJ70WcQyuCnozNbrkWIZUP0VlAyMhRVKuSeJT1JU7aDifc7w0t0If1wJNLTB6QRxg90DrUhc
	6ppb4DoKkcwvgNde5O4zyKhl81U4nwN4WuWQS7OZ0nNCXZUwGhxCsKRrZbCNL59jAqQEoe4KalX
	LXfcgY635PF1F9eKUgg16oxNyyOJwebyh1i+EZHHBf3zJTlY7JeDTTbfqypxl0N0iiCBOJKOzrE
	1tnU0nnXCvTAy12oP0ZLDYY+r5OOY9YwVt6wfsk=
X-Google-Smtp-Source: AGHT+IEXM8Hl65f9VBidJfr6xhS16N45GlUrNTaace61xpGVMFjlV4G78nmeJfiFIijTFbWQihn3xw==
X-Received: by 2002:a17:90b:574c:b0:2fa:b84:b304 with SMTP id 98e67ed59e1d1-2febabdc1fdmr4085761a91.22.1740739440439;
        Fri, 28 Feb 2025 02:44:00 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825a98e7sm5534840a91.4.2025.02.28.02.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 02:43:59 -0800 (PST)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: brauner@kernel.org,
	ebiederm@xmission.com,
	asml.silence@gmail.com
Cc: axboe@kernel.dk,
	olivier@trillion01.com,
	jack@suse.cz,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH RESEND] io_uring: fix the dead lock between io_uring and core dump
Date: Fri, 28 Feb 2025 18:43:53 +0800
Message-ID: <20250228104353.300686-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In our production environment, we found many hung tasks.

	Thead A (exit_mm)
	...
		if (core_state) {
		struct core_thread self;

		mmap_read_unlock(mm);

		self.task = current;
		if (self.task->flags & PF_SIGNALED)
			self.next = xchg(&core_state->dumper.next, &self);
		else
			self.task = NULL;
		/*
		 * Implies mb(), the result of xchg() must be visible
		 * to core_state->dumper.
		 */
		if (atomic_dec_and_test(&core_state->nr_threads))
			complete(&core_state->startup);

		for (;;) {
			set_current_state(TASK_UNINTERRUPTIBLE);
			if (!self.task) /* see coredump_finish() */
				break;
			freezable_schedule();
		}
		__set_current_state(TASK_RUNNING);
		mmap_read_lock(mm);
	}
	...

	Thead B (coredump_wait)
	...
		if (core_waiters > 0) {
		struct core_thread *ptr;

		freezer_do_not_count();
		wait_for_completion(&core_state->startup);
		freezer_count();
		/*
		 * Wait for all the threads to become inactive, so that
		 * all the thread context (extended register state, like
		 * fpu etc) gets copied to the memory.
		 */
		ptr = core_state->dumper.next;
		while (ptr != NULL) {
			wait_task_inactive(ptr->task, 0);
			ptr = ptr->next;
		}
	...

	Thead C (io_worker_exit)
	...
		if (refcount_dec_and_test(&worker->ref))
		complete(&worker->ref_done);
		wait_for_completion(&worker->ref_done);
	...

Thread A is waiting Thead B to finish core dump, but Thead B found that there is
still one thread which doesn't step into exit_mm() to dec core_state->nr_threads.
The thead is Thread C, it has submitted a task_work (create_worker_cb) to Thread B
and then wait Thread B to execute or cancel the work. So this causes deadlock between
io_uring and core dump.

Our kernel vesion is stable 5.15.125, and the commit 1d5f5ea7cb7d ("io-wq: remove worker to owner tw dependency")
is included. When the last io woker exits, it doesn't find any callback. Once scheduled out,
it will invoke io_wq_worker_sleeping() to submit a task work to the master thread. So the
commit 1d5f5ea7cb7d ("io-wq: remove worker to owner tw dependency") won't help in this case.

For the core dump thread, we can set a timeout to check whether the taks_work callback exists,
If needed, cancel the task_work and wake up the io worker, so the dead lock will be resolved.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 fs/coredump.c              |  6 ++++--
 include/linux/completion.h |  2 ++
 io_uring/io-wq.c           |  3 +--
 io_uring/io-wq.h           |  1 +
 kernel/sched/completion.c  | 11 +++++++++++
 kernel/sched/core.c        |  8 ++++++++
 6 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 591700e1b2ce..1d972d5882f0 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -42,6 +42,7 @@
 #include <linux/path.h>
 #include <linux/timekeeping.h>
 #include <linux/sysctl.h>
+#include <linux/sched/sysctl.h>
 #include <linux/elf.h>
 
 #include <linux/uaccess.h>
@@ -406,6 +407,7 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
 {
 	struct task_struct *tsk = current;
 	int core_waiters = -EBUSY;
+	unsigned long hang_check = sysctl_hung_task_timeout_secs;
 
 	init_completion(&core_state->startup);
 	core_state->dumper.task = tsk;
@@ -415,8 +417,8 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
 	if (core_waiters > 0) {
 		struct core_thread *ptr;
 
-		wait_for_completion_state(&core_state->startup,
-					  TASK_UNINTERRUPTIBLE|TASK_FREEZABLE);
+		wait_for_completion_state_timeout(&core_state->startup, TASK_UNINTERRUPTIBLE|TASK_FREEZABLE,
+						  hang_check * (HZ/2));
 		/*
 		 * Wait for all the threads to become inactive, so that
 		 * all the thread context (extended register state, like
diff --git a/include/linux/completion.h b/include/linux/completion.h
index fb2915676574..432de8ecc32d 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -104,6 +104,8 @@ extern void wait_for_completion_io(struct completion *);
 extern int wait_for_completion_interruptible(struct completion *x);
 extern int wait_for_completion_killable(struct completion *x);
 extern int wait_for_completion_state(struct completion *x, unsigned int state);
+extern int wait_for_completion_state_timeout(struct completion *x, unsigned int state,
+					     unsigned long timeout);
 extern unsigned long wait_for_completion_timeout(struct completion *x,
 						   unsigned long timeout);
 extern unsigned long wait_for_completion_io_timeout(struct completion *x,
diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 91019b4d0308..1c03dc57a3b3 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -141,7 +141,6 @@ static bool io_acct_cancel_pending_work(struct io_wq *wq,
 					struct io_wq_acct *acct,
 					struct io_cb_cancel_data *match);
 static void create_worker_cb(struct callback_head *cb);
-static void io_wq_cancel_tw_create(struct io_wq *wq);
 
 static bool io_worker_get(struct io_worker *worker)
 {
@@ -1230,7 +1229,7 @@ void io_wq_exit_start(struct io_wq *wq)
 	set_bit(IO_WQ_BIT_EXIT, &wq->state);
 }
 
-static void io_wq_cancel_tw_create(struct io_wq *wq)
+void io_wq_cancel_tw_create(struct io_wq *wq)
 {
 	struct callback_head *cb;
 
diff --git a/io_uring/io-wq.h b/io_uring/io-wq.h
index b3b004a7b625..48ba66b5d0bd 100644
--- a/io_uring/io-wq.h
+++ b/io_uring/io-wq.h
@@ -43,6 +43,7 @@ struct io_wq_data {
 	free_work_fn *free_work;
 };
 
+void io_wq_cancel_tw_create(struct io_wq *wq);
 struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data);
 void io_wq_exit_start(struct io_wq *wq);
 void io_wq_put_and_exit(struct io_wq *wq);
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 3561ab533dd4..9e7936a3cad4 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -269,6 +269,17 @@ int __sched wait_for_completion_state(struct completion *x, unsigned int state)
 }
 EXPORT_SYMBOL(wait_for_completion_state);
 
+int __sched wait_for_completion_state_timeout(struct completion *x, unsigned int state,
+					      unsigned long timeout)
+{
+	long t = wait_for_common(x, timeout, state);
+
+	if (t == -ERESTARTSYS)
+		return t;
+	return 0;
+}
+EXPORT_SYMBOL(wait_for_completion_state_timeout);
+
 /**
  * wait_for_completion_killable_timeout: - waits for completion of a task (w/(to,killable))
  * @x:  holds the state of this particular completion
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9aecd914ac69..e0c9694d8134 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6806,6 +6806,14 @@ static inline void sched_submit_work(struct task_struct *tsk)
 		wq_worker_sleeping(tsk);
 	else if (task_flags & PF_IO_WORKER)
 		io_wq_worker_sleeping(tsk);
+#ifdef CONFIG_IO_URING
+	else if (task_flags & PF_DUMPCORE) {
+		struct io_uring_task *io_uring = tsk->io_uring;
+
+		if (io_uring)
+			io_wq_cancel_tw_create(io_uring->io_wq);
+	}
+#endif
 
 	/*
 	 * spinlock and rwlock must not flush block requests.  This will
-- 
2.43.0


