Return-Path: <linux-kernel+bounces-224289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 881F4912045
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B722A1C21884
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE12916EBE1;
	Fri, 21 Jun 2024 09:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PENtdBkZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAFD16EB59
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718961374; cv=none; b=m9Pa4C1QN4KRVrbyUFdcITR+xpQTLKO8bKerWSWrj/VIMQev/+R7fNXie3Ywuovj8NbyGVqJuiry0vV0fdD94yp32LIiyr37SSZJxJ7VGyNVEwlNlEyX3zNvoRlQtn7w/sncOEiTews4Z1oK6+tSIwo+9pQV7coSj/Cxygd+eRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718961374; c=relaxed/simple;
	bh=yxEHyP8F59DlEgnpBUShwu2ascF0KGLnYNcwxKRX5ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RI1BZ75FxcUfHGNzPLHJNbanlr4gXzj7vsH+Z5jsytEuE4fOqHJyhXB+iWaQajkwD/vzhddTMbyIu0Ahz62A7xA4ln3/RCBI59EwY9JZk/rGhvW57sDyyqbfURDMOtx5gYFZukG2I0MqkRD72UDbh2VkbD+SEhcSh6k7AX8Oo8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PENtdBkZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277F5C4AF0F;
	Fri, 21 Jun 2024 09:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718961373;
	bh=yxEHyP8F59DlEgnpBUShwu2ascF0KGLnYNcwxKRX5ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PENtdBkZXrxpozLB69Dm8bpmeyW0THBFbKA1GfpgYQxjyTf6QCWSySA3zZ93EQQwS
	 cFiyrHFfk+ufP4kOcHDcpjNhB7+ERI9l9YQkDK1Gtr5FWXELeDgXI7RqvMD6iFV/U5
	 RYgzTbbWBW16DIOpMlnp7MtckBaxNNyTcrB1VsWIGQF5/PBqSY5cBz/g3EXO6KIpy7
	 0w2ftYSvlP7QYtPktXDWkHakCIdiKqF90uUTN2hAPdsFbdGpi7q76er1AqRf5rvS2k
	 /0PldJoxDmxV91Peezzvq8ezR+01Rss5eRh4NDus01wG4tIGJ5J+2TtlA9G62yG6/S
	 fQ9Ey0e8QSS7Q==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/4] task_work: Introduce task_work_cancel() again
Date: Fri, 21 Jun 2024 11:15:59 +0200
Message-ID: <20240621091601.18227-3-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621091601.18227-1-frederic@kernel.org>
References: <20240621091601.18227-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Re-introduce task_work_cancel(), this time to cancel an actual callback
and not *any* callback pointing to a given function. This is going to be
needed for perf events event freeing.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/task_work.h |  1 +
 kernel/task_work.c        | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index 23ab01ae185e..26b8a47f41fc 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -31,6 +31,7 @@ int task_work_add(struct task_struct *task, struct callback_head *twork,
 struct callback_head *task_work_cancel_match(struct task_struct *task,
 	bool (*match)(struct callback_head *, void *data), void *data);
 struct callback_head *task_work_cancel_func(struct task_struct *, task_work_func_t);
+bool task_work_cancel(struct task_struct *task, struct callback_head *cb);
 void task_work_run(void);
 
 static inline void exit_task_work(struct task_struct *task)
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 54ac24059daa..2134ac8057a9 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -136,6 +136,30 @@ task_work_cancel_func(struct task_struct *task, task_work_func_t func)
 	return task_work_cancel_match(task, task_work_func_match, func);
 }
 
+static bool task_work_match(struct callback_head *cb, void *data)
+{
+	return cb == data;
+}
+
+/**
+ * task_work_cancel - cancel a pending work added by task_work_add()
+ * @task: the task which should execute the work
+ * @cb: the callback to remove if queued
+ *
+ * Remove a callback from a task's queue if queued.
+ *
+ * RETURNS:
+ * True if the callback was queued and got cancelled, false otherwise.
+ */
+bool task_work_cancel(struct task_struct *task, struct callback_head *cb)
+{
+	struct callback_head *ret;
+
+	ret = task_work_cancel_match(task, task_work_match, cb);
+
+	return ret == cb;
+}
+
 /**
  * task_work_run - execute the works added by task_work_add()
  *
-- 
2.45.2


