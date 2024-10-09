Return-Path: <linux-kernel+bounces-357112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E974E996BB7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68778B23C7B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31261198E71;
	Wed,  9 Oct 2024 13:21:15 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C5E194AEB
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480074; cv=none; b=BNJbB7SR2Z8zWY75mKDzMipqnwVA/9DhmE6PCo+1KigmLXvyn/84RIHiF4UiHnqW0ZxZ0WSR5M+kH/qOUr0CB0gasjIQdEIOhiQBhWg34P0TeqQ0AEN0BE+IE6INX/rVWC9I+m0Wl5YYCVGrQLP35wpixUwXv5taDc8Uvvx7YEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480074; c=relaxed/simple;
	bh=ERoXFPVgC1wX2vu2OhU6ijnkpELxgnhoNg6sfXACYw8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Vy3sbXiCyn9VpP4H/TDs/7SY0IlCY1Gd1PFyfGhwYc1h3C8OBXd+Lhjnfgp1WVEo2M9vNdhIjqFsZAL3cz6x1PPb9aKQ647717lBxsPlX8vqWe69JixihNk6n5h5D4jfrvR6wNgXwI8oYjIT3f1VbwxQXwlRgA5naEMqo2S/J4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E896C4CECF;
	Wed,  9 Oct 2024 13:21:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1syWcx-0000000175r-3LVt;
	Wed, 09 Oct 2024 09:21:19 -0400
Message-ID: <20241009132119.658356665@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 09 Oct 2024 09:21:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Li Chen <chenl311@chinatelecom.cn>
Subject: [for-next][PATCH 1/6] ftrace: Use this_cpu_ptr() instead of per_cpu_ptr(smp_processor_id())
References: <20241009132104.470687911@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Li Chen <chenl311@chinatelecom.cn>

Use this_cpu_ptr() instead of open coding the equivalent in various
ftrace functions.

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lore.kernel.org/87y14t6ofi.wl-me@linux.beauty
Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 3b0cea37e029..65fed0bbc5c2 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -184,7 +184,6 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
 	struct trace_array_cpu *data;
 	unsigned int trace_ctx;
 	int bit;
-	int cpu;
 
 	if (unlikely(!tr->function_enabled))
 		return;
@@ -195,8 +194,7 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
 
 	trace_ctx = tracing_gen_ctx();
 
-	cpu = smp_processor_id();
-	data = per_cpu_ptr(tr->array_buffer.data, cpu);
+	data = this_cpu_ptr(tr->array_buffer.data);
 	if (!atomic_read(&data->disabled))
 		trace_function(tr, ip, parent_ip, trace_ctx);
 
@@ -300,7 +298,6 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
 	unsigned int trace_ctx;
 	unsigned long flags;
 	int bit;
-	int cpu;
 
 	if (unlikely(!tr->function_enabled))
 		return;
@@ -309,8 +306,7 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
 	if (bit < 0)
 		return;
 
-	cpu = smp_processor_id();
-	data = per_cpu_ptr(tr->array_buffer.data, cpu);
+	data = this_cpu_ptr(tr->array_buffer.data);
 	if (atomic_read(&data->disabled))
 		goto out;
 
@@ -321,7 +317,7 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
 	 * TODO: think about a solution that is better than just hoping to be
 	 * lucky.
 	 */
-	last_info = per_cpu_ptr(tr->last_func_repeats, cpu);
+	last_info = this_cpu_ptr(tr->last_func_repeats);
 	if (is_repeat_check(tr, last_info, ip, parent_ip))
 		goto out;
 
-- 
2.45.2



