Return-Path: <linux-kernel+bounces-204253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2387C8FE642
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D76F1C25593
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D925C198A03;
	Thu,  6 Jun 2024 12:11:03 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612AF19752B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675862; cv=none; b=Vo04ryZySfb2bIMZfrsUDFcD/5F+VjHzF+v7iQ/st2Hp2svLD3w0hDCk9f/r99ValxBnBhcN5iZAKcBWs9RGd5bWS0A1AQs1LfGs7+0TQx38ATctC3D32uAKVTQ2j8XC1B57u1AXCnH1eW7x2Zgq3gjCJzlet8bT+sgkKXRTTYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675862; c=relaxed/simple;
	bh=Vhl003s+9gkJi2wM8NFrJTGXuCSJLdVofnWPtxpbJjQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=RqzA6lfWzF/wYOQtslY+61qKEAS1eifWq1NcdhKFRqLdgFweDyeOfkVmeA9S5sa3Q/+WOWv72hML5UsZ2RiAWHyRttJdTMmLbzgyA4JaTHsevUWoB3IeLOp4dEu6kdOymGHPSSrmTM5HFUo1//LsHoOWC95se/fHV6YjfIZHIm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F37C4AF48;
	Thu,  6 Jun 2024 12:11:02 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sFBxS-00000000nOp-2WDi;
	Thu, 06 Jun 2024 08:11:06 -0400
Message-ID: <20240606121106.459468755@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Jun 2024 08:10:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 kernel test robot <lkp@intel.com>
Subject: [for-next][PATCH 13/15] function_graph: Do not update pid func if CONFIG_DYNAMIC_FTRACE not
 enabled
References: <20240606121004.857581251@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The ftrace subops is only defined if CONFIG_DYNAMIC_FTRACE is enabled. If
it is not, function tracing is extremely limited, and the subops in the
ftrace_ops structure is not defined (and will fail to compile). If
DYNAMIC_FTRACE is not enabled, then function graph filtering will not
work (as it shouldn't).

Link: https://lore.kernel.org/linux-trace-kernel/20240605202709.096020676@goodmis.org

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: df3ec5da6a1e7 ("function_graph: Add pid tracing back to function graph tracer")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406051855.9VIYXbTB-lkp@intel.com/
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 63d828054c79..c0e428c87ea5 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1177,6 +1177,7 @@ void fgraph_update_pid_func(void)
 	if (!(graph_ops.flags & FTRACE_OPS_FL_INITIALIZED))
 		return;
 
+#ifdef CONFIG_DYNAMIC_FTRACE
 	list_for_each_entry(op, &graph_ops.subop_list, list) {
 		if (op->flags & FTRACE_OPS_FL_PID) {
 			gops = container_of(op, struct fgraph_ops, ops);
@@ -1186,6 +1187,7 @@ void fgraph_update_pid_func(void)
 				static_call_update(fgraph_func, gops->entryfunc);
 		}
 	}
+#endif
 }
 
 /* Allocate a return stack for each task */
-- 
2.43.0



