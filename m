Return-Path: <linux-kernel+bounces-416477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500029D45AC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ECDEB224CE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 02:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195B861FCE;
	Thu, 21 Nov 2024 02:10:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CE923098E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 02:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732155016; cv=none; b=F7pKEpR/a7XiPdpdKE/tVUu05EZB3ekNLOPJ8AXZ9CSrQOtJkZ8rq5DB62K34ZkAZUOiABXO6Inr3et9yY0Ql/5V6Ze0IluIYUHDGQUb6E2tRPqhXKiQek+26SC4RWUUtJeofvsYuJgpKWoEYY7Gbm/nFbxgNlE+FCYsqO/TWaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732155016; c=relaxed/simple;
	bh=BdDrSsbgvrK7uSMlaoRE3Ct9mpLRzFKAgwFn+eQCwE0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=lqbmT2BnlkoxUSSeOZ4RTfmbFhk+dm5k0/fTlbO624agAf8spYppJAP0z1NbEzggJOF+CD0pa21ioaHg22euSfdAY3pGcsXr+wcfAdGtZn7jZRR8qfyzRsGeiQZyKBM07Uj20kHLtLspLdsz66PBXOro5Qv/AS/pGB/kG7O/57M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8868EC4CECD;
	Thu, 21 Nov 2024 02:10:15 +0000 (UTC)
Date: Wed, 20 Nov 2024 21:10:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 guoweikang <guoweikang.kernel@gmail.com>
Subject: [for-next][PATCH] ftrace: Fix regression with module command in
 stack_trace_filter
Message-ID: <20241120211051.6d085095@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: 45af52e7d3b8560f21d139b3759735eead8b1653


guoweikang (1):
      ftrace: Fix regression with module command in stack_trace_filter

----
 kernel/trace/ftrace.c | 3 +++
 1 file changed, 3 insertions(+)
---------------------------
commit 45af52e7d3b8560f21d139b3759735eead8b1653
Author: guoweikang <guoweikang.kernel@gmail.com>
Date:   Wed Nov 20 13:27:49 2024 +0800

    ftrace: Fix regression with module command in stack_trace_filter
    
    When executing the following command:
    
        # echo "write*:mod:ext3" > /sys/kernel/tracing/stack_trace_filter
    
    The current mod command causes a null pointer dereference. While commit
    0f17976568b3f ("ftrace: Fix regression with module command in stack_trace_filter")
    has addressed part of the issue, it left a corner case unhandled, which still
    results in a kernel crash.
    
    Cc: stable@vger.kernel.org
    Cc: Masami Hiramatsu <mhiramat@kernel.org>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Link: https://lore.kernel.org/20241120052750.275463-1-guoweikang.kernel@gmail.com
    Fixes: 04ec7bb642b77 ("tracing: Have the trace_array hold the list of registered func probes");
    Signed-off-by: guoweikang <guoweikang.kernel@gmail.com>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 4c28dd177ca6..5ff0822342ac 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5076,6 +5076,9 @@ ftrace_mod_callback(struct trace_array *tr, struct ftrace_hash *hash,
 	char *func;
 	int ret;
 
+	if (!tr)
+		return -ENODEV;
+
 	/* match_records() modifies func, and we need the original */
 	func = kstrdup(func_orig, GFP_KERNEL);
 	if (!func)

