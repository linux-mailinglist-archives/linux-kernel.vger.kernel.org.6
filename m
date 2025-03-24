Return-Path: <linux-kernel+bounces-574455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 873FDA6E58B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DF54189664F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA0D1DEFD7;
	Mon, 24 Mar 2025 21:17:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC69193402
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742851075; cv=none; b=ZZ0HZDb1cdiRN2rlomB3peOJ29puVGPHUVIWTytoztNdoxYbGF73NV/w7Kj6ksadOaD+gjxX5nMg/wr9zICn40jvrt3Rd0k3b+76G/jB6xz6wKBzTa5+cE6oa5s2KE+7Gm5YnnszPgJE51WLwSYHAtt8pWREsYLqTqjfRFG4+tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742851075; c=relaxed/simple;
	bh=vfyr5k1ytxbqD5dDvZv/NHqPDJ06Jbpq2YW1jgz8ODE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=te2G/c1NCecq88dfJwtX8sGBhWjYR7oF2E52xKHcZxeij25OxX0tUeceoplPDQbAzqgcChEAbuXb1HKOg9h4gkjZer87IVx/VYOxS8Gkcda0MLnW1DuXpxGqJINRaYkr2/pBZUkI7OUpm1kmOAbRgjCFbHhovPO5wJrIiNfzEEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEABFC4CEE4;
	Mon, 24 Mar 2025 21:17:54 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1twpBt-00000002Acp-1Lzs;
	Mon, 24 Mar 2025 17:18:37 -0400
Message-ID: <20250324211837.171611564@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 24 Mar 2025 17:18:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Abaci Robot <abaci@linux.alibaba.com>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [for-next][PATCH 1/3] function_graph: Remove the unused variable func
References: <20250324211821.731702961@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Variable func is not effectively used, so delete it.

kernel/trace/trace_functions_graph.c:925:16: warning: variable ‘func’ set but not used.

This happened because the variable "func" which came from "call->func" was
replaced by "ret_func" coming from "graph_ret->func" but "func" wasn't
removed after the replacement.

Link: https://lore.kernel.org/20250307021412.119107-1-jiapeng.chong@linux.alibaba.com
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=19250
Fixes: ff5c9c576e754 ("ftrace: Add support for function argument to graph tracer")
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions_graph.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 71b2fb068b6b..ed61ff719aa4 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -922,7 +922,6 @@ print_graph_entry_leaf(struct trace_iterator *iter,
 	struct ftrace_graph_ent *call;
 	unsigned long long duration;
 	unsigned long ret_func;
-	unsigned long func;
 	int args_size;
 	int cpu = iter->cpu;
 	int i;
@@ -933,8 +932,6 @@ print_graph_entry_leaf(struct trace_iterator *iter,
 	call = &entry->graph_ent;
 	duration = ret_entry->rettime - ret_entry->calltime;
 
-	func = call->func + iter->tr->text_delta;
-
 	if (data) {
 		struct fgraph_cpu_data *cpu_data;
 
-- 
2.47.2



