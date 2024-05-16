Return-Path: <linux-kernel+bounces-181152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D08908C7844
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BDE71F21870
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5671314A612;
	Thu, 16 May 2024 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrvobaTp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C66A14B969
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715868587; cv=none; b=KNixPW/nHQl5yBnxDFXeOKq7bfunssZnDwxGa8cWH8SVDWsndOhkrJUZxnJS1YL21M9N4DdTjrjesdk29r8nJjBkD2KVKSx4Bm56OQi6Mwjw25gTLsEkPhA5mVJzGf2582hFPKT8uQmRBfEveQUHQgNPrTHMOLcK4BXnv7dRMfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715868587; c=relaxed/simple;
	bh=8ujq2iQEISU0Ou+VI37VHgm8fH2OCc7fS2VtpmzXXUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m1aXCjqsmsbvSuVDweNYEtWDMiI2sfsHXLyIzhXCcX9hk2F6RrBra0wbgjZDIE34Pm+mssk/9BGnT/PjqnPP9hyQywgcM8Q6Y3az7HgnLuO65FU47Ud12jJB0TwyQrp9JwiKthbgu52mlT3jFIp3ZqOK9mGcnZ1RP2w616bh8BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrvobaTp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0185CC32786;
	Thu, 16 May 2024 14:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715868587;
	bh=8ujq2iQEISU0Ou+VI37VHgm8fH2OCc7fS2VtpmzXXUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IrvobaTpzSzkaFAgbJfPzWh4QH25Ys49NPrVlxjiT90HomxxrxvF/qEPFaYsDbfrJ
	 euuhho0U9A5h90eoJMphnQhwXDKcfO6bzb11i67H528Lb9By8wBN+yqnbRpKnD1u6O
	 bZFbgnRG8Y2b92WU8WzO99xsIrti7Y9E1Y15U478LvKzg2b5/1TvahFrsItwiL4f8P
	 iZoCYp4EbBzY+IL7S+d+LQa8Ageyx6Q02psdtscG0n2RsQndbKikpDXt+m4vFJZFzL
	 O4g7E54WkTpv4ca4Xj+UwTr2hOYnD0HREYWCCZeGTyWmdiSQ3UivKWV4g6jaZYJ79p
	 deJZpaqQocGvw==
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
Date: Thu, 16 May 2024 16:09:34 +0200
Message-Id: <20240516140936.13694-3-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516140936.13694-1-frederic@kernel.org>
References: <20240516140936.13694-1-frederic@kernel.org>
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
2.34.1


