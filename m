Return-Path: <linux-kernel+bounces-180022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0108C68F3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB5F1F22F4B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356B115622F;
	Wed, 15 May 2024 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diMDHaAT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BDB155A43
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715784204; cv=none; b=Ohm6RnWwtDrBopyFhKkKEBT6rq4qBt6nOgLyML5bFq2iehmdLwjv7eL+GihZWGVniZBOe1MFfFwH7zd02FMplm+6mGFUQhkoWZBWCspiENXtUESbBLSt92ze3hRpC7pATJ8JW0c1Mm9liLjaehK70bAKv7r+0+gYlAPMOEfKyBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715784204; c=relaxed/simple;
	bh=rEuS7Fi0Lvzvpv1WWBr1sdY3xojQBPz8s/YrwhEEJOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYp2go7BGG9yhlF3aXO8HoKSYPohKRHzxBdFRGWKB5hJklxH1mLUAfCa32FFnz9mT9r5PIG/t4p8pMvwkj1JJkQ1qA3JIAMs3LvKivzZWInYpF10VkeTZD6y9yVhenkX4x4Y5PA5jxYJX3OB041l57gILFXUG5KiZcbmkpzaDpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diMDHaAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFB4C4AF0B;
	Wed, 15 May 2024 14:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715784204;
	bh=rEuS7Fi0Lvzvpv1WWBr1sdY3xojQBPz8s/YrwhEEJOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=diMDHaATwzi4NBBG/2fL03CZHf/hX/TuU4nURsJgCvFEBa0EN+sthtVmkmTNgAt0T
	 qFDy6S+snkE3FjzUVTFxyCTMLGAjQ9jL3b/W4a4MN2tIFR8Faly8lt1XZ2rrmTWuq+
	 B5Zf+lY8fmRZkWRuPpvtpBx+sMpNcBBPcjkTc/cJ4xdl3RrJch1/Mia4MCcQ69vuHX
	 AF8igkqQGfny5vgq0upSUvSO/8+lzujyQqXYuWsSKV8REpmLdG0J/HJ6E6Y6GRPhZT
	 FFfEo8ceXKq63qHEn6Fdx0jY9pJMydSgd962SSiY/9+Z9rDntZBpPOWWptnO0PldAe
	 wwgJEWa9AUrdg==
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
Date: Wed, 15 May 2024 16:43:09 +0200
Message-ID: <20240515144311.16038-3-frederic@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240515144311.16038-1-frederic@kernel.org>
References: <20240515144311.16038-1-frederic@kernel.org>
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
2.44.0


