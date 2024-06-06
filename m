Return-Path: <linux-kernel+bounces-204244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 466F68FE639
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C159B24DAB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035E119750D;
	Thu,  6 Jun 2024 12:11:02 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D993195F1C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675861; cv=none; b=Tl8KnIpL2edqlhlTK03sl2SVEJuTcpZS87nbtzVrNOuwNpYFwx5pzqWKDEzG8AS7lkM6Gt+4P5PvSO2M9hQcU/FURs/3JlMP1lvz8OfjSgBveFfx4O52CQHeSLkzuOh8w17gVAJgstz5AUVFfwRHfnvkoa7Zl8azJLhkrQds7hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675861; c=relaxed/simple;
	bh=W4l6MfqT8UKz1IsW80Cwa7ibONhnzaZC8uRE0CV67ig=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=dA5rLE+FshybQLGRr/oMI9bgapfqsLTswjqzHMXGncfTab6pGdQSNakN5JVZTirmCNTe8rXLkC2yqMJIWi+Zz7SIHVWspINxrX9rr1P9H1z/thVHbWnX9mPrHUl1OBCZCrDnOI4urh8lXZXdzgCRm26xF2lQwZmyuQmrp+IfOqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57A8C4DDE1;
	Thu,  6 Jun 2024 12:11:00 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sFBxR-00000000nKM-0jbN;
	Thu, 06 Jun 2024 08:11:05 -0400
Message-ID: <20240606121105.037365034@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Jun 2024 08:10:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 04/15] ftrace: Remove "ftrace_hash" parameter from
 __ftrace_hash_rec_update()
References: <20240606121004.857581251@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

While adding comments to the function __ftrace_hash_rec_update() and
trying to describe in detail what the parameter for "ftrace_hash" does, I
realized that it basically does exactly the same thing (but differently)
if it is set or not!

If it is set, the idea was the ops->filter_hash was being updated, and the
code should focus on the functions that are in the ops->filter_hash and
add them. But it still had to pay attention to the functions in the
ops->notrace_hash, to ignore them.

If it was cleared, it focused on the ops->notrace_hash, and would add
functions that were not in the ops->notrace_hash but would still keep
functions in the "ops->filter_hash". Basically doing the same thing.

In reality, the __ftrace_hash_rec_update() only needs to either remove the
functions associated to the give ops (if "inc" is set) or remove them (if
"inc" is cleared). It has to pay attention to both the filter_hash and
notrace_hash regardless.

Remove the "filter_hash" parameter from __filter_hash_rec_update() and
comment the function for what it really is doing.

Link: https://lore.kernel.org/linux-trace-kernel/20240605180408.691995506@goodmis.org

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 102 ++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 64 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f4b253d20df8..abcdffa4d572 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1384,10 +1384,8 @@ alloc_and_copy_ftrace_hash(int size_bits, struct ftrace_hash *hash)
 	return NULL;
 }
 
-static void
-ftrace_hash_rec_disable_modify(struct ftrace_ops *ops, int filter_hash);
-static void
-ftrace_hash_rec_enable_modify(struct ftrace_ops *ops, int filter_hash);
+static void ftrace_hash_rec_disable_modify(struct ftrace_ops *ops);
+static void ftrace_hash_rec_enable_modify(struct ftrace_ops *ops);
 
 static int ftrace_hash_ipmodify_update(struct ftrace_ops *ops,
 				       struct ftrace_hash *new_hash);
@@ -1475,11 +1473,11 @@ ftrace_hash_move(struct ftrace_ops *ops, int enable,
 	 * Remove the current set, update the hash and add
 	 * them back.
 	 */
-	ftrace_hash_rec_disable_modify(ops, enable);
+	ftrace_hash_rec_disable_modify(ops);
 
 	rcu_assign_pointer(*dst, new_hash);
 
-	ftrace_hash_rec_enable_modify(ops, enable);
+	ftrace_hash_rec_enable_modify(ops);
 
 	return 0;
 }
@@ -1702,12 +1700,21 @@ static bool skip_record(struct dyn_ftrace *rec)
 		!(rec->flags & FTRACE_FL_ENABLED);
 }
 
+/*
+ * This is the main engine to the ftrace updates to the dyn_ftrace records.
+ *
+ * It will iterate through all the available ftrace functions
+ * (the ones that ftrace can have callbacks to) and set the flags
+ * in the associated dyn_ftrace records.
+ *
+ * @inc: If true, the functions associated to @ops are added to
+ *       the dyn_ftrace records, otherwise they are removed.
+ */
 static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
-				     int filter_hash,
 				     bool inc)
 {
 	struct ftrace_hash *hash;
-	struct ftrace_hash *other_hash;
+	struct ftrace_hash *notrace_hash;
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
 	bool update = false;
@@ -1719,35 +1726,16 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
 		return false;
 
 	/*
-	 * In the filter_hash case:
 	 *   If the count is zero, we update all records.
 	 *   Otherwise we just update the items in the hash.
-	 *
-	 * In the notrace_hash case:
-	 *   We enable the update in the hash.
-	 *   As disabling notrace means enabling the tracing,
-	 *   and enabling notrace means disabling, the inc variable
-	 *   gets inversed.
 	 */
-	if (filter_hash) {
-		hash = ops->func_hash->filter_hash;
-		other_hash = ops->func_hash->notrace_hash;
-		if (ftrace_hash_empty(hash))
-			all = true;
-	} else {
-		inc = !inc;
-		hash = ops->func_hash->notrace_hash;
-		other_hash = ops->func_hash->filter_hash;
-		/*
-		 * If the notrace hash has no items,
-		 * then there's nothing to do.
-		 */
-		if (ftrace_hash_empty(hash))
-			return false;
-	}
+	hash = ops->func_hash->filter_hash;
+	notrace_hash = ops->func_hash->notrace_hash;
+	if (ftrace_hash_empty(hash))
+		all = true;
 
 	do_for_each_ftrace_rec(pg, rec) {
-		int in_other_hash = 0;
+		int in_notrace_hash = 0;
 		int in_hash = 0;
 		int match = 0;
 
@@ -1759,26 +1747,17 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
 			 * Only the filter_hash affects all records.
 			 * Update if the record is not in the notrace hash.
 			 */
-			if (!other_hash || !ftrace_lookup_ip(other_hash, rec->ip))
+			if (!notrace_hash || !ftrace_lookup_ip(notrace_hash, rec->ip))
 				match = 1;
 		} else {
 			in_hash = !!ftrace_lookup_ip(hash, rec->ip);
-			in_other_hash = !!ftrace_lookup_ip(other_hash, rec->ip);
+			in_notrace_hash = !!ftrace_lookup_ip(notrace_hash, rec->ip);
 
 			/*
-			 * If filter_hash is set, we want to match all functions
-			 * that are in the hash but not in the other hash.
-			 *
-			 * If filter_hash is not set, then we are decrementing.
-			 * That means we match anything that is in the hash
-			 * and also in the other_hash. That is, we need to turn
-			 * off functions in the other hash because they are disabled
-			 * by this hash.
+			 * We want to match all functions that are in the hash but
+			 * not in the other hash.
 			 */
-			if (filter_hash && in_hash && !in_other_hash)
-				match = 1;
-			else if (!filter_hash && in_hash &&
-				 (in_other_hash || ftrace_hash_empty(other_hash)))
+			if (in_hash && !in_notrace_hash)
 				match = 1;
 		}
 		if (!match)
@@ -1884,24 +1863,21 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
 	return update;
 }
 
-static bool ftrace_hash_rec_disable(struct ftrace_ops *ops,
-				    int filter_hash)
+static bool ftrace_hash_rec_disable(struct ftrace_ops *ops)
 {
-	return __ftrace_hash_rec_update(ops, filter_hash, 0);
+	return __ftrace_hash_rec_update(ops, 0);
 }
 
-static bool ftrace_hash_rec_enable(struct ftrace_ops *ops,
-				   int filter_hash)
+static bool ftrace_hash_rec_enable(struct ftrace_ops *ops)
 {
-	return __ftrace_hash_rec_update(ops, filter_hash, 1);
+	return __ftrace_hash_rec_update(ops, 1);
 }
 
-static void ftrace_hash_rec_update_modify(struct ftrace_ops *ops,
-					  int filter_hash, int inc)
+static void ftrace_hash_rec_update_modify(struct ftrace_ops *ops, int inc)
 {
 	struct ftrace_ops *op;
 
-	__ftrace_hash_rec_update(ops, filter_hash, inc);
+	__ftrace_hash_rec_update(ops, inc);
 
 	if (ops->func_hash != &global_ops.local_hash)
 		return;
@@ -1915,20 +1891,18 @@ static void ftrace_hash_rec_update_modify(struct ftrace_ops *ops,
 		if (op == ops)
 			continue;
 		if (op->func_hash == &global_ops.local_hash)
-			__ftrace_hash_rec_update(op, filter_hash, inc);
+			__ftrace_hash_rec_update(op, inc);
 	} while_for_each_ftrace_op(op);
 }
 
-static void ftrace_hash_rec_disable_modify(struct ftrace_ops *ops,
-					   int filter_hash)
+static void ftrace_hash_rec_disable_modify(struct ftrace_ops *ops)
 {
-	ftrace_hash_rec_update_modify(ops, filter_hash, 0);
+	ftrace_hash_rec_update_modify(ops, 0);
 }
 
-static void ftrace_hash_rec_enable_modify(struct ftrace_ops *ops,
-					  int filter_hash)
+static void ftrace_hash_rec_enable_modify(struct ftrace_ops *ops)
 {
-	ftrace_hash_rec_update_modify(ops, filter_hash, 1);
+	ftrace_hash_rec_update_modify(ops, 1);
 }
 
 /*
@@ -3051,7 +3025,7 @@ int ftrace_startup(struct ftrace_ops *ops, int command)
 		return ret;
 	}
 
-	if (ftrace_hash_rec_enable(ops, 1))
+	if (ftrace_hash_rec_enable(ops))
 		command |= FTRACE_UPDATE_CALLS;
 
 	ftrace_startup_enable(command);
@@ -3093,7 +3067,7 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
 	/* Disabling ipmodify never fails */
 	ftrace_hash_ipmodify_disable(ops);
 
-	if (ftrace_hash_rec_disable(ops, 1))
+	if (ftrace_hash_rec_disable(ops))
 		command |= FTRACE_UPDATE_CALLS;
 
 	ops->flags &= ~FTRACE_OPS_FL_ENABLED;
-- 
2.43.0



