Return-Path: <linux-kernel+bounces-388148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CFA9B5B4A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 06:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2461B22972
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 05:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338FF1D131F;
	Wed, 30 Oct 2024 05:36:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711151CF7C3
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 05:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730266572; cv=none; b=eea9ift1sFNfe90sAQrliiX1AGBjtGu4pB8yGlqi1llzdSHsZQPlP19L99ZQP38jRYgWFBvyV/fy/Q9KNn2jdtFrifB6zFgHtI8Oai8K5uEDO1WeNSmUegMzik7hHtl/A/ammNmXf+CVlnWpJI24DitxI/j3l4J6ZJcUx4eW+Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730266572; c=relaxed/simple;
	bh=QuMj2j7J2Ycw9ms4XdQMDgXZ6XGNcGjJq/4L8I63wTo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=nhObgNm+xVLvDfqnvuW5gWMC59o5Rf6diHyvtlWvh/wSGq+yspPJD9xAI04bPws53uWaUEz5CvKbJlWRKe8UrsOYfGIfRMF8PSGoTWtzXd0aNgeRGvCm0hcqY0+z9nMp+9uAK4cvKz5w+msWBqyWfBtdzPi5bNAYeE8c4X1mCHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C8FC4CEED;
	Wed, 30 Oct 2024 05:36:12 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t61OD-00000005BFa-30L7;
	Wed, 30 Oct 2024 01:37:05 -0400
Message-ID: <20241030053705.580984615@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 30 Oct 2024 01:36:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [for-next][PATCH 7/7] ftrace: Use guard to take ftrace_lock in ftrace_graph_set_hash()
References: <20241030053650.956861738@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The ftrace_lock is taken for most of the ftrace_graph_set_hash() function
throughout the end. Use guard to take the ftrace_lock to simplify the exit
paths.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/20241028071308.406073025@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c0fabd7da5b2..b4ef469f4fd2 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6816,12 +6816,10 @@ ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer)
 
 	func_g.len = strlen(func_g.search);
 
-	mutex_lock(&ftrace_lock);
+	guard(mutex)(&ftrace_lock);
 
-	if (unlikely(ftrace_disabled)) {
-		mutex_unlock(&ftrace_lock);
+	if (unlikely(ftrace_disabled))
 		return -ENODEV;
-	}
 
 	do_for_each_ftrace_rec(pg, rec) {
 
@@ -6837,7 +6835,7 @@ ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer)
 				if (entry)
 					continue;
 				if (add_hash_entry(hash, rec->ip) == NULL)
-					goto out;
+					return 0;
 			} else {
 				if (entry) {
 					free_hash_entry(hash, entry);
@@ -6846,13 +6844,8 @@ ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer)
 			}
 		}
 	} while_for_each_ftrace_rec();
-out:
-	mutex_unlock(&ftrace_lock);
 
-	if (fail)
-		return -EINVAL;
-
-	return 0;
+	return fail ? -EINVAL : 0;
 }
 
 static ssize_t
-- 
2.45.2



