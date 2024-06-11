Return-Path: <linux-kernel+bounces-210590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 945119045EE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D7F1B21E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D2B152E0D;
	Tue, 11 Jun 2024 20:46:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A2D1CD16
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718138772; cv=none; b=JurthEzRb86ajNDgrAkV9ja23P04KfJ4fWOaVwNz17N2XJ+65+aTA2Den9sse7e5+0BSeMRGlge/pbCo7qbMIfPMzuwBjDnJ2Qxy1KD1x79Ef5avih/kLt8HSvyaNNc8LPonveIdxPa62QJ+ah89XCJBUNOSte06p255X7g4LnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718138772; c=relaxed/simple;
	bh=ImQ9KOd+2hjVgtXx/dfloG4fYodqkEbfTCz8zH9mw/k=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=B21iehOElCmiyuZ6OJNxOQ7fiieie01Bj8rZ4QVktKZc01O26sOojMxkCuUAZ2AEx57+wTZDifIFeE6JEhSjVQMaKuO+8Zrfx4aqAVM2CsJB3VDXOJlRR6qQaaD6YNQA8Jd5MsSdxGBR7FhVGITIqDXzt/Jp/JWz5lBJGc+wQns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130A1C4AF1C;
	Tue, 11 Jun 2024 20:46:12 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sH8Nw-00000001V2e-2eUr;
	Tue, 11 Jun 2024 16:46:28 -0400
Message-ID: <20240611204628.489153002@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 11 Jun 2024 16:45:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 kernel test robot <lkp@intel.com>
Subject: [for-next][PATCH 1/4] function_graph: Make fgraph_update_pid_func() a stub for
 !DYNAMIC_FTRACE
References: <20240611204554.092271761@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

When CONFIG_DYNAMIC_FTRACE is not set, the function
fgraph_update_pid_func() doesn't do anything. Currently, most of its logic
is within a "#ifdef CONFIG_DYNAMIC_FTRACE" block, but its variables were
declared outside that, and when DYNAMIC_FTRACE is not set, it produces
unused variable warnings.

Instead, just place it (and the helper function fgraph_pid_func()) within
the #ifdef block and have the header file use a empty stub function for
when DYNAMIC_FTRACE is not defined.

Link: https://lore.kernel.org/linux-trace-kernel/20240607094833.6a787d73@rorschach.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406071806.BRjaC5FF-lkp@intel.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c          | 4 ++--
 kernel/trace/ftrace_internal.h | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index a13551a023aa..63d0c2f84ce1 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1138,6 +1138,7 @@ void ftrace_graph_exit_task(struct task_struct *t)
 	kfree(ret_stack);
 }
 
+#ifdef CONFIG_DYNAMIC_FTRACE
 static int fgraph_pid_func(struct ftrace_graph_ent *trace,
 			   struct fgraph_ops *gops)
 {
@@ -1164,7 +1165,6 @@ void fgraph_update_pid_func(void)
 	if (!(graph_ops.flags & FTRACE_OPS_FL_INITIALIZED))
 		return;
 
-#ifdef CONFIG_DYNAMIC_FTRACE
 	list_for_each_entry(op, &graph_ops.subop_list, list) {
 		if (op->flags & FTRACE_OPS_FL_PID) {
 			gops = container_of(op, struct fgraph_ops, ops);
@@ -1174,8 +1174,8 @@ void fgraph_update_pid_func(void)
 				static_call_update(fgraph_func, gops->entryfunc);
 		}
 	}
-#endif
 }
+#endif
 
 /* Allocate a return stack for each task */
 static int start_graph_tracing(void)
diff --git a/kernel/trace/ftrace_internal.h b/kernel/trace/ftrace_internal.h
index 4bb1e881154a..3235470e61b3 100644
--- a/kernel/trace/ftrace_internal.h
+++ b/kernel/trace/ftrace_internal.h
@@ -52,7 +52,11 @@ static inline int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_o
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 extern int ftrace_graph_active;
+# ifdef CONFIG_DYNAMIC_FTRACE
 extern void fgraph_update_pid_func(void);
+# else
+static inline void fgraph_update_pid_func(void) {}
+# endif
 #else /* !CONFIG_FUNCTION_GRAPH_TRACER */
 # define ftrace_graph_active 0
 static inline void fgraph_update_pid_func(void) {}
-- 
2.43.0



