Return-Path: <linux-kernel+bounces-533659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18373A45D5B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C223169147
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B45D2153FD;
	Wed, 26 Feb 2025 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="aB+tigxd"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4434215050
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 11:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740569984; cv=none; b=gaR1ZPmLm9pUIIL8J8FFux/GikCcaDHeqea7DDISSDINZPiqkmGzawY5SpJZHxV0RY9NxWVcrVe3x2VuJJCZRSsfhEu132bWtkHksNt4SB8HFXgIFRy/W/0LeUVLjnVU0HGZr5WUU7cQN1ylzTNrmwSaZjLStBFeGoYOER7njzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740569984; c=relaxed/simple;
	bh=nxXKSrBkcEctdHXJ1EIDy5SMRGntL5ukUQhgK9FCjtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HvG7FpPW0OEj7Pldb5LthWunFlUTHoxc0Qo7AfHxo9urXo9YlAtsBhvbtdnL5kIgDWzaTqC86q6G7Cq+8YK4XyJWrdIyJzF74XXtQxCZjX4BgM/nTbjWc27SFhDiWL2Lqwl5GgiUkfINg/PfM8x0qpXSFJsvvJ5/O4SQmvn9OQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=aB+tigxd; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220bfdfb3f4so34436645ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 03:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1740569982; x=1741174782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RvZRoCysp+rlQWcsd6zeQXMTiABhtLdxvlTgkNMlriQ=;
        b=aB+tigxdxeuiWucGJkDQkRXbT2EWBxCCvdwqB0rEtrikTXWYvtQ1e2fEXZ0/WTI7v1
         MYl0cBZ74OapLA+8g4SXAmc+GL2KQHRdETSbQWAcCBuFP/oraSBC3O23EcyE5LRTSYv3
         AXzJjYp8dlHr2anbR9as8M9pYXZtgxw7jiEFchaTLHw4mxt1sfT93Y+cuhf0Sdy8ISrw
         OfxMN3x+6uWaX0F7SoxUyUXSVV0tt9ZFUVPQOX3iL/2nacPpQzpoMi7J2szGWH1Hvcz8
         OU0VzO8dtEIKEDLMZyQ06+ipoB+mkRT1++8y8oPYjlupOG3xot8nyrYi69jLwjgBYDz8
         1pFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740569982; x=1741174782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RvZRoCysp+rlQWcsd6zeQXMTiABhtLdxvlTgkNMlriQ=;
        b=XCVYRgkKT5r7RhkjVixroLw7abzRG6YiZD2iOJPsmq8/hFlQ/LgzSfzlu/4ieIKNac
         RUhgOI3sRl5dyIDV7w0g0sup5sqX25/KI+ql3c7ftoeQCrlq8lE6ql60rsyu3x6e2UBG
         ZaoCIY0x9iIeGUgNMJnK7VF2KXnKnOSdMI6fI+faNFTaSAI2xfFqlzZ6xD2BAt4U6Pjy
         NmamhpWDEo3/l+w0rYJVBAKxLUi7pRXeo9xs5nMZI0iKiQpVI7kmkhBzo8v6inMqD7FI
         dhRqmAFunm6+LCRAQYVqcHTHiEZDNxq1Zbs6JN8QZFNzfuu/xTUh+lDsyJzLcwhkClRt
         0jtA==
X-Forwarded-Encrypted: i=1; AJvYcCUVfgEvHEVVWLJfWLLdv+GMfmYDgcytNFmsMy26KwwJZ7mq9QHXLmhyobdOpSbrjogTk4f+Vvp/iXbYieU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHybiHbw/0s8FVtJ6SGNvVNMWrMx5Q8ooD82lHXQf0Bv2t5pRz
	3AKMSuATk9reLXU8GLt/gOwOHzDIh/bXQh3atGJr8hqsCYMfkzxzYXB6nD8apjBV0GB+ojB7CGW
	iq5s=
X-Gm-Gg: ASbGnctG/nR3PKgcpUAlRxzWZfwRUQ8NQY/RmwFmVNxv/OPV9jGOAOqsx5z1PubOCeP
	qAjwv6HALp82YnF+R4vCd0uKhANVmI00NlbltEjpRgDoWwD8adBmVYEaX+Av12FIolabWvwJxTm
	Pj5ZZjP4gVTWavbmYXBlwCUd1HCTkCd19wgKos/KPiZUF1op2qX964S/Cxknmj3OhhDV4ZAEi4p
	kWF3lHLKLyFa1BawyJToKo8AOEACdBc0WhiT+4X6g95FiiWLuLu2gAnsO8ezvZB86SEhZTJpWQ7
	0vhWo4RbJznscMP4JgNSeF8l4Rr30ZB0sBz3xhs=
X-Google-Smtp-Source: AGHT+IHcn4EEo4WPTpfgcEsDlsTsz+oaWbJGqi2HHp7v/+pSfj1SHXoJSq3noFhxaJx0MCPmKPT7ag==
X-Received: by 2002:a05:6a00:928d:b0:732:7fc1:92b with SMTP id d2e1a72fcca58-7348bdd9611mr4958392b3a.14.1740569981842;
        Wed, 26 Feb 2025 03:39:41 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a83cd83sm3306520b3a.177.2025.02.26.03.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 03:39:41 -0800 (PST)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: asml.silence@gmail.com,
	axboe@kernel.dk,
	ebiederm@xmission.com
Cc: olivier@trillion01.com,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [RFC] io_uring: fix the dead lock between io_uring and core dump
Date: Wed, 26 Feb 2025 19:39:36 +0800
Message-ID: <20250226113936.385747-1-haifeng.xu@shopee.com>
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
 kernel/sched/core.c        |  6 ++++++
 6 files changed, 25 insertions(+), 4 deletions(-)

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
index 9aecd914ac69..1cbe48559163 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6790,6 +6790,7 @@ static inline void sched_submit_work(struct task_struct *tsk)
 {
 	static DEFINE_WAIT_OVERRIDE_MAP(sched_map, LD_WAIT_CONFIG);
 	unsigned int task_flags;
+	struct io_uring_task *io_uring = tsk->io_uring;
 
 	/*
 	 * Establish LD_WAIT_CONFIG context to ensure none of the code called
@@ -6806,6 +6807,11 @@ static inline void sched_submit_work(struct task_struct *tsk)
 		wq_worker_sleeping(tsk);
 	else if (task_flags & PF_IO_WORKER)
 		io_wq_worker_sleeping(tsk);
+	else if ((task_flags & PF_DUMPCORE) && io_uring) {
+		struct io_wq *wq = io_uring->io_wq;
+
+		io_wq_cancel_tw_create(wq);
+	}
 
 	/*
 	 * spinlock and rwlock must not flush block requests.  This will
-- 
2.43.0


