Return-Path: <linux-kernel+bounces-361204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8219B99A507
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44677282E7C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3941C2194A7;
	Fri, 11 Oct 2024 13:29:47 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F88218D9C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728653386; cv=none; b=ZmZ1iMIweyjXE8Ndg0XkpPTIxkLa0XimDBnsgHWW6Jtt7THkxYKJHdUHCiMgvcRW+IxI+oyn4NIKlYrmLMPnk81hBogdvTBZGezjhKkGz3ETxUBaYBvVXP8/nTIGnt9JdSedh1bZX8dW2IM0R1sRErVn0ch5ZP97ufAHjOfQxMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728653386; c=relaxed/simple;
	bh=+XISmM2VvGSUmiMheR2aUfqyNySUbmNxPWbAeB06aww=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=DABB2qfO0AFX3uADFnCmabb7uvXH2LvbT3GRZ6U9CVwi/XJpndWQxpiSR4op0jGYuo9+Rs2tjUAGL8uJKbOFqvPy9Rnd5Az4GlwIiXenJhedyVuR639XHSJ5a+yKJCVxoOQylNfTqziDMeGK80xx7xnSX39XT2kJrOqknUDGxY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932BCC4CED1;
	Fri, 11 Oct 2024 13:29:46 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1szFiO-00000001QXz-2zNk;
	Fri, 11 Oct 2024 09:29:56 -0400
Message-ID: <20241011132956.573414507@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 11 Oct 2024 09:29:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Donglin Peng <dolinux.peng@gmail.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [for-next][PATCH 2/4] fgragh: No need to invoke the function call_filter_check_discard()
References: <20241011132941.339392460@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The function call_filter_check_discard() has been removed in the
commit 49e4154f4b16 ("tracing: Remove TRACE_EVENT_FL_FILTERED logic"),
from another topic branch. But when merged together with commit
21e92806d39c6 ("function_graph: Support recording and printing the
function return address") which added another call to
call_filter_check_discard(), it caused the build to fail. Since the
function call_filter_check_discard() is useless, it can simply be removed
regardless of being merged with commit 49e4154f4b16 or not.

Link: https://lore.kernel.org/all/20241010134649.43ed357c@canb.auug.org.au/

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>
Link: https://lore.kernel.org/20241010194020.46192b21@gandalf.local.home
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 21e92806d39c6 ("function_graph: Support recording and printing the function return address")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions_graph.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 20d0c579d3b5..03c5a0d300a5 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -137,7 +137,6 @@ int __trace_graph_retaddr_entry(struct trace_array *tr,
 				unsigned int trace_ctx,
 				unsigned long retaddr)
 {
-	struct trace_event_call *call = &event_fgraph_retaddr_entry;
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
 	struct fgraph_retaddr_ent_entry *entry;
@@ -150,8 +149,7 @@ int __trace_graph_retaddr_entry(struct trace_array *tr,
 	entry->graph_ent.func = trace->func;
 	entry->graph_ent.depth = trace->depth;
 	entry->graph_ent.retaddr = retaddr;
-	if (!call_filter_check_discard(call, entry, buffer, event))
-		trace_buffer_unlock_commit_nostack(buffer, event);
+	trace_buffer_unlock_commit_nostack(buffer, event);
 
 	return 1;
 }
-- 
2.45.2



