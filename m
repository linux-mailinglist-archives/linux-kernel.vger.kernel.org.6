Return-Path: <linux-kernel+bounces-203469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE6E8FDBAB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AAEA282ACA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F103FC0B;
	Thu,  6 Jun 2024 00:53:36 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FECEADA;
	Thu,  6 Jun 2024 00:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717635216; cv=none; b=Mzsk5hLIckIqlxd8yCuyJ8roHLYF5aP1lycX3/4V7fgOA4dOXw6Ao/OpMDvPvi7QB8DgNv23V7pbutbfocTYrAGSwgpyVvBAfM1zoiFEl2vWWjD8Nvxde2wiGwNAUmS4VdTXE1PZsAxdEpZ+HdjZVQjmXeXHcC+GWj0eMmgU0uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717635216; c=relaxed/simple;
	bh=ECUC++fo6Hg0SW5qsVvf+6iJNl2DVQrRUPqRM0w3Les=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=o6HFGUMxxEGu3blITF1jrUIilqpOXh3rN7QMPJCOlaQ3o8QI6q07EspE9fH0j/7FKt89G80eiQfmUzBDurr4ZOSkZziqIVxmU5l+aQkzC/AkP0MQowWRdEUXfI8DI/FiTJVZUI169sgmW62da9cU/vkWLPzTaJOpqMnxkW9BPw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC52DC4AF07;
	Thu,  6 Jun 2024 00:53:34 +0000 (UTC)
Date: Wed, 5 Jun 2024 20:53:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] ftrace: Add back ftrace_update_trampoline() to
 ftrace_update_pid_func()
Message-ID: <20240605205337.6115e9a5@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The update to the ops trampoline done by the function
ftrace_update_trampoline() was accidentally removed from
ftrace_update_pid_func(). Add it back.

Fixes: df3ec5da6a1e ("function_graph: Add pid tracing back to function graph tracer")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index da7e6abf48b4..897d7541041c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -402,6 +402,7 @@ static void ftrace_update_pid_func(void)
 		if (op->flags & FTRACE_OPS_FL_PID) {
 			op->func = ftrace_pids_enabled(op) ?
 				ftrace_pid_func : op->saved_func;
+			ftrace_update_trampoline(op);
 		}
 	} while_for_each_ftrace_op(op);
 
-- 
2.43.0


