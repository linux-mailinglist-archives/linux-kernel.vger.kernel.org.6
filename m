Return-Path: <linux-kernel+bounces-178925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8738C5981
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99DDB281BB9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CBB1802CD;
	Tue, 14 May 2024 16:14:58 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5038B17F396
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715703298; cv=none; b=mGBjZlgILyDI1Z7B3TRAhLaUkb6WNBLBxIrBcKp6OxYtBykW2miLHvWpY04LyZ9BfV1Krr8Nut6CZE89gEdU17a0NNUenI950cuHaH2RW0/14nkBzwn9vDRItRwQNssQiF9UfHRzECJI+4rQs3d5caeuOqGXLp3BvjJOokT3o0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715703298; c=relaxed/simple;
	bh=wC8IYxT+LIeFFoutQ6v1smCYJ0sa4DakIEZW5Bh9MB4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=a+8YnQDeoeo3+FAGzuNodTpkwO9dwSpbeXZSdL98nDpvnk8VjUXPMb7z5YwX6/hIhaJFb4e0162g8Y0VeLScxghe7wZhAe6SrC+yqN7tT9cbfqiM9sGv+LVQNSSVyGIH/O95hUUOo9d1+vwgxIPvnV87mNIQqpK8Ghb8cK8RSco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0B5C4AF12;
	Tue, 14 May 2024 16:14:58 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s6uoE-00000003t4w-3FdS;
	Tue, 14 May 2024 12:15:22 -0400
Message-ID: <20240514161522.633057821@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 14 May 2024 12:14:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [for-next][PATCH 5/7] ftrace: Remove unused global ftrace_direct_func_count
References: <20240514161438.134250861@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Commit 8788ca164eb4b ("ftrace: Remove the legacy _ftrace_direct API")
stopped setting the 'ftrace_direct_func_count' variable, but left
it around.  Clean it up.

Link: https://lore.kernel.org/linux-trace-kernel/20240506233305.215735-1-linux@treblig.org

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ftrace.h |  2 --
 kernel/trace/fgraph.c  | 11 -----------
 kernel/trace/ftrace.c  |  1 -
 3 files changed, 14 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index b01cca36147f..e3a83ebd1b33 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -413,7 +413,6 @@ struct ftrace_func_entry {
 };
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
-extern int ftrace_direct_func_count;
 unsigned long ftrace_find_rec_direct(unsigned long ip);
 int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
 int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr,
@@ -425,7 +424,6 @@ void ftrace_stub_direct_tramp(void);
 
 #else
 struct ftrace_ops;
-# define ftrace_direct_func_count 0
 static inline unsigned long ftrace_find_rec_direct(unsigned long ip)
 {
 	return 0;
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index c83c005e654e..a130b2d898f7 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -125,17 +125,6 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 {
 	struct ftrace_graph_ent trace;
 
-#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
-	/*
-	 * Skip graph tracing if the return location is served by direct trampoline,
-	 * since call sequence and return addresses are unpredictable anyway.
-	 * Ex: BPF trampoline may call original function and may skip frame
-	 * depending on type of BPF programs attached.
-	 */
-	if (ftrace_direct_func_count &&
-	    ftrace_find_rec_direct(ret - MCOUNT_INSN_SIZE))
-		return -EBUSY;
-#endif
 	trace.func = func;
 	trace.depth = ++current->curr_ret_depth;
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 4613bf67ef2c..5a01d72f66db 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2538,7 +2538,6 @@ ftrace_find_unique_ops(struct dyn_ftrace *rec)
 /* Protected by rcu_tasks for reading, and direct_mutex for writing */
 static struct ftrace_hash __rcu *direct_functions = EMPTY_HASH;
 static DEFINE_MUTEX(direct_mutex);
-int ftrace_direct_func_count;
 
 /*
  * Search the direct_functions hash to see if the given instruction pointer
-- 
2.43.0



