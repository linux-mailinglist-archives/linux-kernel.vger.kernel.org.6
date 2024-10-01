Return-Path: <linux-kernel+bounces-346705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E05998C7B7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 23:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916D71C23836
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97C61CEE89;
	Tue,  1 Oct 2024 21:42:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4E31CCEF2
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 21:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727818937; cv=none; b=Ig2m3K0Vw2TTLowWbRGTbk6Niu+iK2a9HfYZk0e891igmQwkhZUjLmvgLTrFT+9OUYpBpk5wPMRP7dLgcj39cwXQAWTwV6yB89EFM5udfc13lrVlbvl6YwhPiDTskBLOuIZTauRj1Xm1LFPEfSZfVWyfLmM3d1d5sLaRZzBEQM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727818937; c=relaxed/simple;
	bh=m5XMvIg0ae5syhrqN+4d8WP0q5+Df96LS+NLh220V9o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=KFA554T8EFM44SJzysbT3quJtvyBEaFIfXIL92Z4iVSX+PFryjXBbkTbIlEli6J+654KuB076CjT7CCVbxzyV6FBVq/cn74jsh4vWEouccHL/zGhXCZlab+/uSTH3fMsA1kHRE05vFd/LNFsv73qggLAu8704RT9EbUwef78tH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF8AC4CED3;
	Tue,  1 Oct 2024 21:42:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1svkeB-00000004cta-1gKX;
	Tue, 01 Oct 2024 17:43:07 -0400
Message-ID: <20241001214307.262550910@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 01 Oct 2024 17:42:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jiri Olsa <olsajiri@gmail.com>
Subject: [for-next][PATCH 3/5] fgraph: Use fgraph data to store subtime for profiler
References: <20241001214241.688116616@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Instead of having the "subtime" for the function profiler in the
infrastructure ftrace_ret_stack structure, have it use the fgraph data
reserve and retrieve functions.

This will keep the limited shadow stack from wasting 8 bytes for something
that is seldom used.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <olsajiri@gmail.com>
Link: https://lore.kernel.org/20240914214826.780323141@goodmis.org
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ftrace.h |  4 +--
 kernel/trace/fgraph.c  | 64 ++++++++++++++++++++++++++++++++----------
 kernel/trace/ftrace.c  | 23 +++++++--------
 3 files changed, 62 insertions(+), 29 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 42106b3de396..aabd348cad4a 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1081,6 +1081,7 @@ struct fgraph_ops {
 
 void *fgraph_reserve_data(int idx, int size_bytes);
 void *fgraph_retrieve_data(int idx, int *size_bytes);
+void *fgraph_retrieve_parent_data(int idx, int *size_bytes, int depth);
 
 /*
  * Stack of return addresses for functions
@@ -1091,9 +1092,6 @@ struct ftrace_ret_stack {
 	unsigned long ret;
 	unsigned long func;
 	unsigned long long calltime;
-#ifdef CONFIG_FUNCTION_PROFILER
-	unsigned long long subtime;
-#endif
 #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
 	unsigned long fp;
 #endif
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index d7d4fb403f6f..095ceb752b28 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -390,21 +390,7 @@ void *fgraph_reserve_data(int idx, int size_bytes)
  */
 void *fgraph_retrieve_data(int idx, int *size_bytes)
 {
-	int offset = current->curr_ret_stack - 1;
-	unsigned long val;
-
-	val = get_fgraph_entry(current, offset);
-	while (__get_type(val) == FGRAPH_TYPE_DATA) {
-		if (__get_data_index(val) == idx)
-			goto found;
-		offset -= __get_data_size(val) + 1;
-		val = get_fgraph_entry(current, offset);
-	}
-	return NULL;
-found:
-	if (size_bytes)
-		*size_bytes = __get_data_size(val) * sizeof(long);
-	return get_data_type_data(current, offset);
+	return fgraph_retrieve_parent_data(idx, size_bytes, 0);
 }
 
 /**
@@ -460,6 +446,54 @@ get_ret_stack(struct task_struct *t, int offset, int *frame_offset)
 	return RET_STACK(t, offset);
 }
 
+/**
+ * fgraph_retrieve_parent_data - get data from a parent function
+ * @idx: The index into the fgraph_array (fgraph_ops::idx)
+ * @size_bytes: A pointer to retrieved data size
+ * @depth: The depth to find the parent (0 is the current function)
+ *
+ * This is similar to fgraph_retrieve_data() but can be used to retrieve
+ * data from a parent caller function.
+ *
+ * Return: a pointer to the specified parent data or NULL if not found
+ */
+void *fgraph_retrieve_parent_data(int idx, int *size_bytes, int depth)
+{
+	struct ftrace_ret_stack *ret_stack = NULL;
+	int offset = current->curr_ret_stack;
+	unsigned long val;
+
+	if (offset <= 0)
+		return NULL;
+
+	for (;;) {
+		int next_offset;
+
+		ret_stack = get_ret_stack(current, offset, &next_offset);
+		if (!ret_stack || --depth < 0)
+			break;
+		offset = next_offset;
+	}
+
+	if (!ret_stack)
+		return NULL;
+
+	offset--;
+
+	val = get_fgraph_entry(current, offset);
+	while (__get_type(val) == FGRAPH_TYPE_DATA) {
+		if (__get_data_index(val) == idx)
+			goto found;
+		offset -= __get_data_size(val) + 1;
+		val = get_fgraph_entry(current, offset);
+	}
+	return NULL;
+found:
+	if (size_bytes)
+		*size_bytes = __get_data_size(val) * sizeof(long);
+	return get_data_type_data(current, offset);
+}
+
 /* Both enabled by default (can be cleared by function_graph tracer flags */
 static bool fgraph_sleep_time = true;
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index d2dd71d04b8a..bac1f2ee1983 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -823,7 +823,7 @@ void ftrace_graph_graph_time_control(bool enable)
 static int profile_graph_entry(struct ftrace_graph_ent *trace,
 			       struct fgraph_ops *gops)
 {
-	struct ftrace_ret_stack *ret_stack;
+	unsigned long long *subtime;
 
 	function_profile_call(trace->func, 0, NULL, NULL);
 
@@ -831,9 +831,9 @@ static int profile_graph_entry(struct ftrace_graph_ent *trace,
 	if (!current->ret_stack)
 		return 0;
 
-	ret_stack = ftrace_graph_get_ret_stack(current, 0);
-	if (ret_stack)
-		ret_stack->subtime = 0;
+	subtime = fgraph_reserve_data(gops->idx, sizeof(*subtime));
+	if (subtime)
+		*subtime = 0;
 
 	return 1;
 }
@@ -841,11 +841,12 @@ static int profile_graph_entry(struct ftrace_graph_ent *trace,
 static void profile_graph_return(struct ftrace_graph_ret *trace,
 				 struct fgraph_ops *gops)
 {
-	struct ftrace_ret_stack *ret_stack;
 	struct ftrace_profile_stat *stat;
 	unsigned long long calltime;
+	unsigned long long *subtime;
 	struct ftrace_profile *rec;
 	unsigned long flags;
+	int size;
 
 	local_irq_save(flags);
 	stat = this_cpu_ptr(&ftrace_profile_stats);
@@ -861,13 +862,13 @@ static void profile_graph_return(struct ftrace_graph_ret *trace,
 	if (!fgraph_graph_time) {
 
 		/* Append this call time to the parent time to subtract */
-		ret_stack = ftrace_graph_get_ret_stack(current, 1);
-		if (ret_stack)
-			ret_stack->subtime += calltime;
+		subtime = fgraph_retrieve_parent_data(gops->idx, &size, 1);
+		if (subtime)
+			*subtime += calltime;
 
-		ret_stack = ftrace_graph_get_ret_stack(current, 0);
-		if (ret_stack && ret_stack->subtime < calltime)
-			calltime -= ret_stack->subtime;
+		subtime = fgraph_retrieve_data(gops->idx, &size);
+		if (subtime && *subtime && *subtime < calltime)
+			calltime -= *subtime;
 		else
 			calltime = 0;
 	}
-- 
2.45.2



