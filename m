Return-Path: <linux-kernel+bounces-388146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAB49B5B42
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 06:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6A51B22082
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 05:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906711CFEA7;
	Wed, 30 Oct 2024 05:36:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7ED1CF5EC
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 05:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730266572; cv=none; b=jegcVQZz8ehJQPMjV30y1dYEV2WtlyN7xzRHsSPD4G0NswdmW5uu2JHYqOMMmck8cUNELRhLKlp3rHu3eULXakruMFOiUEazE5ninQe2CsVOvDLvGY2WErnWCZGV18pthD1Vn6E28UnBTcH/mfc0grxMbxMRj9xssV9UgNBquvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730266572; c=relaxed/simple;
	bh=4JFa/lks/etTOtrtpJZCxlzJzGohLAQHk7UPWvizd+E=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=QVU9JizQ4JcwX89t61M73lRh6+c9gkUjFTuAV/sy/tEF9RXoIZe2XUqmSo/X9U0imw8Cvkca6ZOCp0PbbuoWNi4jKZK6zcqSP60NgD1ejBRvlwz7dRFqVH69kpQXDMsnmuflrH4yiYEwCY0j78Xzg4/MRH/Zeu6QIu+msuWHwkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E1FC4CEEB;
	Wed, 30 Oct 2024 05:36:11 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t61OD-00000005BDe-0KBa;
	Wed, 30 Oct 2024 01:37:05 -0400
Message-ID: <20241030053704.935817830@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 30 Oct 2024 01:36:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [for-next][PATCH 3/7] fgraph: Use guard(mutex)(&ftrace_lock) for unregister_ftrace_graph()
References: <20241030053650.956861738@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The ftrace_lock is held throughout unregister_ftrace_graph(), use a guard
to simplify the error paths.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/20241028071307.770550792@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 001abf376c0c..0bf78517b5d4 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1381,17 +1381,17 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 {
 	int command = 0;
 
-	mutex_lock(&ftrace_lock);
+	guard(mutex)(&ftrace_lock);
 
 	if (unlikely(!ftrace_graph_active))
-		goto out;
+		return;
 
 	if (unlikely(gops->idx < 0 || gops->idx >= FGRAPH_ARRAY_SIZE ||
 		     fgraph_array[gops->idx] != gops))
-		goto out;
+		return;
 
 	if (fgraph_lru_release_index(gops->idx) < 0)
-		goto out;
+		return;
 
 	fgraph_array[gops->idx] = &fgraph_stub;
 
@@ -1413,7 +1413,5 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 		unregister_pm_notifier(&ftrace_suspend_notifier);
 		unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
 	}
- out:
 	gops->saved_func = NULL;
-	mutex_unlock(&ftrace_lock);
 }
-- 
2.45.2



