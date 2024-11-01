Return-Path: <linux-kernel+bounces-392069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF729B8F5C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E641F21AE9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBEB19CC0C;
	Fri,  1 Nov 2024 10:36:09 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF5D19B3D3
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730457369; cv=none; b=q7Y/QyfZ1IhszZTusVTzhIM5jx+jtCLmEdyLYY0CvQjXtUUumgEzlAalYqxzoB31IrwFKvb3047s1h4YTZ4wfY4+VvT2dIMiQq7yVGNYjuHfddSzpOoH9ZaoXBq+xZ7M9POA8UfeDZVoyDBPLqS6oGSWByhJirLSMOY99H7P8Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730457369; c=relaxed/simple;
	bh=0ECHqyMrwF1RhGCyzmASRVHGaUNHJ0obns2rz4Str50=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Rwjm3DiOVayocGXPflMXdpuWD58y6k6kvHMS4qwfrC0ZLYqep1gc9awWgryv6fImtPpvSsxaszletpohzrE1NscX88qddQq3JTU2WPTFZTMDT7gZsi4Ct1zLibgGbLSXnmtGqFWeTr3pcRHWCiZSvnMrkF2MTUvx5Yr5vaJ1SBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D117CC4CED1;
	Fri,  1 Nov 2024 10:36:08 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t6p1f-00000005S4c-0T84;
	Fri, 01 Nov 2024 06:37:07 -0400
Message-ID: <20241101103706.970906571@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 01 Nov 2024 06:36:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ryan Roberts <ryan.roberts@arm.com>
Subject: [for-next][PATCH 01/11] tracing: Make percpu stack trace buffer invariant to PAGE_SIZE
References: <20241101103647.011707614@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Ryan Roberts <ryan.roberts@arm.com>

Previously the size of "struct ftrace_stacks" depended upon PAGE_SIZE.
For the common 4K page size, on a 64-bit system, sizeof(struct
ftrace_stacks) was 32K. But for a 64K page size, sizeof(struct
ftrace_stacks) was 512K.

But ftrace stack usage requirements should be invariant to page size. So
let's redefine FTRACE_KSTACK_ENTRIES so that "struct ftrace_stacks" is
always sized at 32K for 64-bit and 16K for 32-bit.

As a side effect, it removes the PAGE_SIZE compile-time constant
assumption from this code, which is required to reach the goal of
boot-time page size selection.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20241021141832.3668264-1-ryan.roberts@arm.com
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bdb776e6ceb9..f1d613d924e9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2898,7 +2898,7 @@ trace_function(struct trace_array *tr, unsigned long ip, unsigned long
 /* Allow 4 levels of nesting: normal, softirq, irq, NMI */
 #define FTRACE_KSTACK_NESTING	4
 
-#define FTRACE_KSTACK_ENTRIES	(PAGE_SIZE / FTRACE_KSTACK_NESTING)
+#define FTRACE_KSTACK_ENTRIES	(SZ_4K / FTRACE_KSTACK_NESTING)
 
 struct ftrace_stack {
 	unsigned long		calls[FTRACE_KSTACK_ENTRIES];
-- 
2.45.2



