Return-Path: <linux-kernel+bounces-228989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF36916978
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567811F21CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484F816A945;
	Tue, 25 Jun 2024 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dvpibtpn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED3B16A36E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323572; cv=none; b=hJbS/2t+c1nPKg6PhZm7KTSGOih/ylW+vkrrrc+2xmuq/vz2o88M+SFbWBw57I4ctLNReaTm/DHKBFg0ZfpmqhuDFbV/6uVz/l3tV99KiRRjODrr0ptUGPiGglng3bysM4Zw1dccW/o4VnlaUOGuZn9I1H8I5NGG4HHRzd/vPTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323572; c=relaxed/simple;
	bh=VVQeerrLbO6LlQCdF2302Yt57InaLmIbhRY3uETpAj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnbi68F6mbFrnhX5znBGtnLm4RvKb50PvZWKKBRe6VyADqOXnljAWbemSjZDFAM1w3lNJTuqZNtKLsg+eeBNl0RP+XXp3O0uLvTG+7MinQT6g9XJZgbsl4joILOXgO3v0x/kxZxhLa6GxZCNVLCiBFI9OvNXP7BRfSIpnYmQEVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dvpibtpn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BDFC32781;
	Tue, 25 Jun 2024 13:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719323572;
	bh=VVQeerrLbO6LlQCdF2302Yt57InaLmIbhRY3uETpAj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DvpibtpnDkesQ+tyacOfQjqqQ6LH+vYE+pK/mVCKETW8l+d2hpwKKAzL2PacTZHYi
	 WRMdIJnnxVzpdnY7IGMfKIoYA2A2gkDKow+3F41hlgqLy6TtT5fJtwfm/2CnF97fNa
	 ptqYJ9rMMrP3Xf2VuCqO5l0E51wl42bTKucXuojKKaZFJT/cLmMWD0+ptrr9hlEIP4
	 AA+TejVSt0WYvqP+R9qFJX9Qlqif3mb7UGtRdTKmOV8qmyYEQdo8fHjy5C+OqdMXzz
	 azZi28HNYEFDgYMcoDmDVeQ/0gPSPZP0msEfkw7TKTes9oC3Ju4UWduBncfjppDWkf
	 Am07vcZh58EfQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Oleg Nesterov <oleg@redhat.com>
Subject: [RFC PATCH 1/6] task_work: Provide means to check if a work is queued
Date: Tue, 25 Jun 2024 15:52:39 +0200
Message-ID: <20240625135244.20227-2-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625135244.20227-1-frederic@kernel.org>
References: <20240625135244.20227-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some task work users implement their own ways to know if a callback is
already queued on the current task while fiddling with the callback
head internals.

Provide instead a consolidated API to serve this very purpose.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/task_work.h | 12 ++++++++++++
 kernel/task_work.c        |  1 +
 2 files changed, 13 insertions(+)

diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index 795ef5a68429..f2eae971b73a 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -5,12 +5,15 @@
 #include <linux/list.h>
 #include <linux/sched.h>
 
+#define TASK_WORK_DEQUEUED	((void *) -1UL)
+
 typedef void (*task_work_func_t)(struct callback_head *);
 
 static inline void
 init_task_work(struct callback_head *twork, task_work_func_t func)
 {
 	twork->func = func;
+	twork->next = TASK_WORK_DEQUEUED;
 }
 
 enum task_work_notify_mode {
@@ -25,6 +28,15 @@ static inline bool task_work_pending(struct task_struct *task)
 	return READ_ONCE(task->task_works);
 }
 
+/*
+ * Check if a work is queued. Beware: this is inherently racy if the work can
+ * be queued elsewhere than the current task.
+ */
+static inline bool task_work_queued(struct callback_head *twork)
+{
+	return twork->next != TASK_WORK_DEQUEUED;
+}
+
 int task_work_add(struct task_struct *task, struct callback_head *twork,
 			enum task_work_notify_mode mode);
 
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 95a7e1b7f1da..6e3bee0b7011 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -177,6 +177,7 @@ void task_work_run(void)
 
 		do {
 			next = work->next;
+			work->next = TASK_WORK_DEQUEUED;
 			work->func(work);
 			work = next;
 			cond_resched();
-- 
2.45.2


