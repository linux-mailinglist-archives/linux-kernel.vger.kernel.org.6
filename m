Return-Path: <linux-kernel+bounces-204248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 561D48FE63E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4EC0B2546F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192A9197A75;
	Thu,  6 Jun 2024 12:11:03 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B7B195FCD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675861; cv=none; b=k3jIySiJ1H1JwbnL8yIsPfrw3kLoJ6Q1jbhp7qvBTfbTqyIrk620Qm3vKgoNwEq5vj2fqL/CC4BU7r/Gxg7TYeA4hJPE0V4T07Ij+1fRF86788sdtq2m7P8tMbyLEkF4PiWoBXQYrmp7pvx2OMWnxV2wXiIZ+FjZEAWFjkAPACs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675861; c=relaxed/simple;
	bh=iVZzamMFw4KSf7EJWCT9D8ewRTw/E7zgRCVheMa8EUU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=NB7Jy5weE6FawZ/6GoOvIbvqfJlwV1QrEl/0g1aKxHJnE77qlpc8op+k6yKAA73oWkHLRkoKxO22pdt/UkvO+pjODF5uMM1bbRT2jX4bGrmW/6GqgGY96UQF4pNP4wu3roossrnTphmAJQmyeOdpVtu37rL1zAqp+YVTRTc6cuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48262C4DDE4;
	Thu,  6 Jun 2024 12:11:01 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sFBxR-00000000nMK-3Oit;
	Thu, 06 Jun 2024 08:11:05 -0400
Message-ID: <20240606121105.667743331@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Jun 2024 08:10:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 08/15] ftrace: Declare function_trace_op in header to quiet sparse warning
References: <20240606121004.857581251@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Sparse complains that function_trace_op is not static but is not declared
in a header file. It is used only in assembly code. But add it to a header
so that sparse no longer complains:

 kernel/trace/ftrace.c:99:19: warning: symbol 'function_trace_op' was not declared. Should it be static?

Link: https://lore.kernel.org/linux-trace-kernel/20240605202708.289105647@goodmis.org

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ftrace.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 9f61556a9491..4135dc171447 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1131,6 +1131,9 @@ extern void ftrace_graph_init_task(struct task_struct *t);
 extern void ftrace_graph_exit_task(struct task_struct *t);
 extern void ftrace_graph_init_idle_task(struct task_struct *t, int cpu);
 
+/* Used by assembly, but to quiet sparse warnings */
+extern struct ftrace_ops *function_trace_op;
+
 static inline void pause_graph_tracing(void)
 {
 	atomic_inc(&current->tracing_graph_pause);
-- 
2.43.0



