Return-Path: <linux-kernel+bounces-449581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31A79F5105
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 464D016480F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D4E1F75BC;
	Tue, 17 Dec 2024 16:29:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E761F7570
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734452989; cv=none; b=HqusLcxcw6BjuGp3K7WrdfAVmGbJaKShvcXZl3bkRvw+IafprtywepQJdwsJTesnO79EpTY1NiT4SEQlXa3Av2T8JKZQEhLhX6wR9REkK/v4r2h0ZZITWer7Ojmd21ciNDR3ycR8Eb69fNoIR0ShnBnXTeGxMp+yWEGv5PMInXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734452989; c=relaxed/simple;
	bh=ftlei99CJZc1Z0+jLBFENc3sLEE4iqRbQrRDg0WxLPo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=pkfbcnyGmMFAX/Fehta49gifp4P2zP/5xqBTJAlIopkfurmEntBVDupdn44/7zVEaWabj5wTLOjVTVkAdfA4m0kulO5qfb2fcNQ2l6xnhxB3ZBun5n+uxaMIMZZgk1bOtXNP7Xzlf8Gnw+/DApk/JR46GndCiq+HnYlCOwaOC80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C967C4CEDF;
	Tue, 17 Dec 2024 16:29:49 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tNaSn-00000008afL-2Yjy;
	Tue, 17 Dec 2024 11:30:25 -0500
Message-ID: <20241217163025.461545709@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 17 Dec 2024 11:18:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Al Viro <viro@ZenIV.linux.org.uk>,
 Michal Simek <monstr@monstr.eu>,
 Jeff Xie <jeff.xie@linux.dev>,
 Al Viro <viro@zeniv.linux.org.uk>
Subject: [for-linus v2][PATCH 2/2] ftrace: Do not find "true_parent" if HAVE_DYNAMIC_FTRACE_WITH_ARGS is
 not set
References: <20241217161840.069495339@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When function tracing and function graph tracing are both enabled (in
different instances) the "parent" of some of the function tracing events
is "return_to_handler" which is the trampoline used by function graph
tracing. To fix this, ftrace_get_true_parent_ip() was introduced that
returns the "true" parent ip instead of the trampoline.

To do this, the ftrace_regs_get_stack_pointer() is used, which uses
kernel_stack_pointer(). The problem is that microblaze does not implement
kerenl_stack_pointer() so when function graph tracing is enabled, the
build fails. But microblaze also does not enabled HAVE_DYNAMIC_FTRACE_WITH_ARGS.
That option has to be enabled by the architecture to reliably get the
values from the fregs parameter passed in. When that config is not set,
the architecture can also pass in NULL, which is not tested for in that
function and could cause the kernel to crash.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Jeff Xie <jeff.xie@linux.dev>
Link: https://lore.kernel.org/20241216164633.6df18e87@gandalf.local.home
Fixes: 60b1f578b578 ("ftrace: Get the true parent ip for function tracer")
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 74c353164ca1..d358c9935164 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -176,7 +176,8 @@ static void function_trace_start(struct trace_array *tr)
 	tracing_reset_online_cpus(&tr->array_buffer);
 }
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+/* fregs are guaranteed not to be NULL if HAVE_DYNAMIC_FTRACE_WITH_ARGS is set */
+#if defined(CONFIG_FUNCTION_GRAPH_TRACER) && defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS)
 static __always_inline unsigned long
 function_get_true_parent_ip(unsigned long parent_ip, struct ftrace_regs *fregs)
 {
-- 
2.45.2



