Return-Path: <linux-kernel+bounces-388149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A2B9B5B49
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 06:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E51284E29
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 05:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FE01D14E0;
	Wed, 30 Oct 2024 05:36:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362B21CF5F2
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 05:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730266572; cv=none; b=XNz3aX9ybAcbJj3Pabtzi2M5EdO10lUi9n8g2/n4DplQxMvp8lM2y1Ub4c9DkUzfTXMLS5LH27D3NFLXKpdUVDTx9w6zesAf6FDQ609gMgCLagHpYEGHi3Zp70xVLyrpy6RUAGPhPouAK1HDIPUe+oC58lx4SXpCW+YKFGFfXXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730266572; c=relaxed/simple;
	bh=vABfQU5WgsXJEBcJ/VpC+SkLw/4ZGNvqd7pkyDXSqTk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BokkZrBYpAgLqKEa0ROI7ik0OSiup5Fm+bMzNgaYf21nghc/NE/yrXSU8cCqOXygpYm7eycPCNOPyyJb9zUBBiHw1utixsuvAtkPtcZDNbS6oW6fYf1+WgyMh/JuoohQAJLbcApblTgoR3FRP4uJrPctzlPJJanYTcCb4LODDis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B86DC4CEE6;
	Wed, 30 Oct 2024 05:36:12 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t61OD-00000005BEc-1gQg;
	Wed, 30 Oct 2024 01:37:05 -0400
Message-ID: <20241030053705.261500336@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 30 Oct 2024 01:36:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [for-next][PATCH 5/7] ftrace: Use guard to lock ftrace_lock in cache_mod()
References: <20241030053650.956861738@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The ftrace_lock is held throughout cache_mod(), use guard to simplify the
error paths.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/20241028071308.088458856@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 44adc34643c9..64997416415e 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4947,14 +4947,14 @@ static int cache_mod(struct trace_array *tr,
 {
 	struct ftrace_mod_load *ftrace_mod, *n;
 	struct list_head *head = enable ? &tr->mod_trace : &tr->mod_notrace;
-	int ret;
 
-	mutex_lock(&ftrace_lock);
+	guard(mutex)(&ftrace_lock);
 
 	/* We do not cache inverse filters */
 	if (func[0] == '!') {
+		int ret = -EINVAL;
+
 		func++;
-		ret = -EINVAL;
 
 		/* Look to remove this hash */
 		list_for_each_entry_safe(ftrace_mod, n, head, list) {
@@ -4970,20 +4970,15 @@ static int cache_mod(struct trace_array *tr,
 				continue;
 			}
 		}
-		goto out;
+		return ret;
 	}
 
-	ret = -EINVAL;
 	/* We only care about modules that have not been loaded yet */
 	if (module_exists(module))
-		goto out;
+		return -EINVAL;
 
 	/* Save this string off, and execute it when the module is loaded */
-	ret = ftrace_add_mod(tr, func, module, enable);
- out:
-	mutex_unlock(&ftrace_lock);
-
-	return ret;
+	return ftrace_add_mod(tr, func, module, enable);
 }
 
 static int
-- 
2.45.2



