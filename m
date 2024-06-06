Return-Path: <linux-kernel+bounces-204241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2720B8FE635
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBCEE280D46
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC823195F00;
	Thu,  6 Jun 2024 12:11:00 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809B5195988
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675860; cv=none; b=q2QRixQIV2+0PUM84kIL25KDVMgz5B6yevMMPnfJNttqEEhwfRDXQZtGejF178TfpBtOItG2PqtsswkYIcT71dd2Pr/FT3pCJHlSHooqZAWrIhGM6b/xy0rriMQy56ebK8/2xlj+r4+e73chwXHS4fW90tOiDZ5cGN87eYg4z70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675860; c=relaxed/simple;
	bh=PNceJ0fe4F1UTs7lOuAfilYYz36/N4ma7OLgumFm98I=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=GrwV+SLph3lwa4rSc5/ZeRRHKM50mpk3IVhlYbk+1dUJvL5Am2Kk1EaTn87hGsMfKB3aMYjqSsUre7TJCZdVXJhqirrUo9t7ceru4tNUJMIhL5HOqQKqYC7Knpa/qGa5eSwMKvjQMrZSwfOfLEvokuC2hAAcTtHz3YkMyKWsPFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237EFC4AF08;
	Thu,  6 Jun 2024 12:11:00 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sFBxQ-00000000nIt-2veA;
	Thu, 06 Jun 2024 08:11:04 -0400
Message-ID: <20240606121104.557984575@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Jun 2024 08:10:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 01/15] ftrace: Add back ftrace_update_trampoline() to
 ftrace_update_pid_func()
References: <20240606121004.857581251@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The update to the ops trampoline done by the function
ftrace_update_trampoline() was accidentally removed from
ftrace_update_pid_func(). Add it back.

Link: https://lore.kernel.org/linux-trace-kernel/20240605205337.6115e9a5@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
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



