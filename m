Return-Path: <linux-kernel+bounces-546056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC657A4F5B7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 04:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CCBE3AC6A4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF5C1990BA;
	Wed,  5 Mar 2025 03:50:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0163A18C01E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 03:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741146632; cv=none; b=ktKtTpIUnz+u4DYPqUUQcZcj9NRbjcGtracDxX8SJYycbgqGGFATMBmRBx0wbqEsiGIYJZFTI96ZUjPHhaI7BKJzK/ECyVcVTLZF6jNTcRiqQOZSyLjZLNQKoAl1hfL6Fuyqqrr0oV5OU8ngaP/D6I7/ACvnyIuof6fTuMiq5AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741146632; c=relaxed/simple;
	bh=f5zHQtYHx+2zBb4Fx/oiKb2X39t0J40I20Ws+Qb07A0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=LGenIpmQ6BUnRVF1WHk6eKvAySAcz8tLn0Ras7tHMaAZqkWXPbmljN9sTpX6DXgAAaFSFbfGxsseIlepkqmW+QWUI/OZMgg3noCo4GkMoDNh9aDXa8g8VtnW59vEAN60pHQ2lwZQAHNNTNF8zfzK5Qzzse90/SDvI1cU3MHucOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A258C4CEEA;
	Wed,  5 Mar 2025 03:50:31 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tpfn6-0000000CYWP-0JNO;
	Tue, 04 Mar 2025 22:51:28 -0500
Message-ID: <20250305035127.922362057@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 04 Mar 2025 22:51:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sven Schnelle <svens@linux.ibm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>,
 Donglin Peng <dolinux.peng@gmail.com>,
 Zheng Yejian <zhengyejian@huaweicloud.com>
Subject: [for-next][PATCH 5/6] ftrace: Have funcgraph-args take affect during tracing
References: <20250305035107.307030265@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Currently, when function_graph is started, it looks at the option
funcgraph-args, and if it is set, it will enable tracing of the arguments.

But if tracing is already running, and the user enables funcgraph-args, it
will have no effect. Instead, it should enable argument tracing when it is
enabled, even if it means disabling the function graph tracing for a short
time in order to do the transition.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Guo Ren <guoren@kernel.org>
Cc: Donglin Peng <dolinux.peng@gmail.com>
Cc: Zheng Yejian <zhengyejian@huaweicloud.com>
Link: https://lore.kernel.org/20250227185822.978998710@goodmis.org
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions_graph.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 5049fe25ceef..71b2fb068b6b 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -464,7 +464,7 @@ static int graph_trace_init(struct trace_array *tr)
 	else
 		tr->gops->retfunc = trace_graph_return;
 
-	/* Make gops functions are visible before we start tracing */
+	/* Make gops functions visible before we start tracing */
 	smp_mb();
 
 	ret = register_ftrace_graph(tr->gops);
@@ -475,6 +475,28 @@ static int graph_trace_init(struct trace_array *tr)
 	return 0;
 }
 
+static int ftrace_graph_trace_args(struct trace_array *tr, int set)
+{
+	trace_func_graph_ent_t entry;
+
+	if (set)
+		entry = trace_graph_entry_args;
+	else
+		entry = trace_graph_entry;
+
+	/* See if there's any changes */
+	if (tr->gops->entryfunc == entry)
+		return 0;
+
+	unregister_ftrace_graph(tr->gops);
+
+	tr->gops->entryfunc = entry;
+
+	/* Make gops functions visible before we start tracing */
+	smp_mb();
+	return register_ftrace_graph(tr->gops);
+}
+
 static void graph_trace_reset(struct trace_array *tr)
 {
 	tracing_stop_cmdline_record();
@@ -1607,6 +1629,9 @@ func_graph_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
 	if (bit == TRACE_GRAPH_GRAPH_TIME)
 		ftrace_graph_graph_time_control(set);
 
+	if (bit == TRACE_GRAPH_ARGS)
+		return ftrace_graph_trace_args(tr, set);
+
 	return 0;
 }
 
-- 
2.47.2



