Return-Path: <linux-kernel+bounces-445081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0573F9F10F4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EED71882A5E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1B81E3761;
	Fri, 13 Dec 2024 15:26:39 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC221E25FE
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734103598; cv=none; b=GA4qvpN2HVG8gN8HlEJFOv5MowLSQ2ZXmfkneqdseCMTEPeOTgH4L+6mfSmgSYxqol+S/6HzMm2diMEYi2xeMf6bSLcZCOjaLWEZNoTLrE8TYgrzqTSbLbiKN5i5uK3dBDTsamkhpbrP2M4SRVpK49bkl5lHy56REMW2oPnGh2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734103598; c=relaxed/simple;
	bh=lmCm9UtAO2/cJpwPsH47vXHv0VeqqSpC/ZMVZXWHtHk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=P+yJrnHit93e79tzZpZBKcE0DQm0kSONM87aBlAIK5GQOCo9GEyC7p+XQeqc4GMc2vlcDlGHttroHRi5wUNuIamWW4+qNEZYel0O0Vy/60xSPo2BoeSqDXxX0LSyoWlLHhIEuiVo59HFVpYyz0OcoO8VnBTJfJEnyy/fHlJ6YTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4A5C4CEE4;
	Fri, 13 Dec 2024 15:26:38 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tM7ZI-00000005PHg-2Vt6;
	Fri, 13 Dec 2024 10:27:04 -0500
Message-ID: <20241213152704.448212590@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 13 Dec 2024 10:26:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Al Viro <viro@ZenIV.linux.org.uk>,
 Michal Simek <monstr@monstr.eu>,
 Al Viro <viro@zeniv.linux.org.uk>
Subject: [for-linus][PATCH 3/3] ftrace/microblaze: Do not find "true_parent" for return address
References: <20241213152647.904822987@goodmis.org>
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
build fails.

Modify the #ifdef check to the code around ftrace_get_true_parent_ip() to
include !defined(CONFIG_MICROBLAZE) which will default it to just return
the parent ip passed in, which may still be the ip of the function garph
trampoline.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Michal Simek <monstr@monstr.eu>
Link: https://lore.kernel.org/20241211153634.69c75afa@batman.local.home
Fixes: 60b1f578b578 ("ftrace: Get the true parent ip for function tracer")
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 74c353164ca1..a75d107a45f8 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -176,7 +176,8 @@ static void function_trace_start(struct trace_array *tr)
 	tracing_reset_online_cpus(&tr->array_buffer);
 }
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+/* Microblaze currently doesn't implement kernel_stack_pointer() */
+#if defined(CONFIG_FUNCTION_GRAPH_TRACER) && !defined(CONFIG_MICROBLAZE)
 static __always_inline unsigned long
 function_get_true_parent_ip(unsigned long parent_ip, struct ftrace_regs *fregs)
 {
-- 
2.45.2



