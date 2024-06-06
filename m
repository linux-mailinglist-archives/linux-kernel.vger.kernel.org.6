Return-Path: <linux-kernel+bounces-204243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 321438FE637
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 447F91C25A4A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F1A195FC9;
	Thu,  6 Jun 2024 12:11:01 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171C6195F08
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675861; cv=none; b=eVH+uDKX1tUeixnbgYQFaD8pTxMVSN9eI6teQEewuaaGxAghTZS6nxmeNqxr043EZcGix9Aw34W1KFH6v64aaEobeX4ygtOzib4al9u2O+knG11v40SU8vJYUnT2GGWi/2pqW8NtCv7CfyUiP88L+Tqs3cBK64ag4K80OEyrPDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675861; c=relaxed/simple;
	bh=c9qk2ba39DxvpoLJ7rt1t9FBbO0uYm2kZ33GQZpUTfQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ZD45h7VhZLiPjPppZDCYoNJyuxngA/rYSTkL/Ao0KYfadrKZn/B2tl7j0wIXs4CEr5zU4m7Y0UjKJzr0glYDay95EnI/VxhUdQrY1pcw0WLQZmR9CsY54Wd52JD4sNF7ux77PO63eHjZ4AljOIryN5OWDd/ysIfL75hFRs3Ux0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8880BC4AF60;
	Thu,  6 Jun 2024 12:11:00 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sFBxR-00000000nJr-04Tq;
	Thu, 06 Jun 2024 08:11:05 -0400
Message-ID: <20240606121104.879342374@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Jun 2024 08:10:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 03/15] ftrace: Rename dup_hash() and comment it
References: <20240606121004.857581251@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The name "dup_hash()" is a misnomer as it does not duplicate the hash that
is passed in, but instead moves its entities from that hash to a newly
allocated one. Rename it to "__move_hash()" (using starting underscores as
it is an internal function), and add some comments about what it does.

Link: https://lore.kernel.org/linux-trace-kernel/20240605180408.537723591@goodmis.org

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 897d7541041c..f4b253d20df8 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1392,7 +1392,11 @@ ftrace_hash_rec_enable_modify(struct ftrace_ops *ops, int filter_hash);
 static int ftrace_hash_ipmodify_update(struct ftrace_ops *ops,
 				       struct ftrace_hash *new_hash);
 
-static struct ftrace_hash *dup_hash(struct ftrace_hash *src, int size)
+/*
+ * Allocate a new hash and remove entries from @src and move them to the new hash.
+ * On success, the @src hash will be empty and should be freed.
+ */
+static struct ftrace_hash *__move_hash(struct ftrace_hash *src, int size)
 {
 	struct ftrace_func_entry *entry;
 	struct ftrace_hash *new_hash;
@@ -1439,7 +1443,7 @@ __ftrace_hash_move(struct ftrace_hash *src)
 	if (ftrace_hash_empty(src))
 		return EMPTY_HASH;
 
-	return dup_hash(src, size);
+	return __move_hash(src, size);
 }
 
 static int
-- 
2.43.0



