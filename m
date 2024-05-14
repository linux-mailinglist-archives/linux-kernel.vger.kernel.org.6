Return-Path: <linux-kernel+bounces-178922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C11058C597C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC2A281EDD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B9717F389;
	Tue, 14 May 2024 16:14:58 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B181217EBBD
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715703297; cv=none; b=HlNduO3tcS8+6sghiEwTQiay6SAp3sxLMhLBd268ePR3HrzHH0KkYKMcb3n9lcn6cYKBHdNF9J5arPP2ntAL0y1k07oPrSLklXf7rpg1KD1cZGirHgcqFSN8PaMXsbalCZjcyVuoEn6D2VLU6slyn0hWSgqcTalqzFT8hNgA19s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715703297; c=relaxed/simple;
	bh=xpNUKXxZg5qc/m0w5UgHuX1xFL6MNEp0QCdXc0cQBDo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=uPnv+GDBM0NLNS+HqORsgd22/37I0DejxJXGs+tbc0O6q74MdRvcj21vrST2xmLQ0Kw2fMhXdoCPdibsR+DSW9U7i8jZsZUYtY3tyruflc7fuJlX/12bdXwv1uQQZDWTShyi2ubar4+KvQQT0HnuRx+LkuLAIc/9s+4hoMEfmpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC69C4AF09;
	Tue, 14 May 2024 16:14:57 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s6uoE-00000003t3U-1G0w;
	Tue, 14 May 2024 12:15:22 -0400
Message-ID: <20240514161522.157427484@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 14 May 2024 12:14:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Chris Mason <clm@fb.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
Subject: [for-next][PATCH 2/7] ftrace: Use asynchronous grace period for register_ftrace_direct()
References: <20240514161438.134250861@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Paul E. McKenney" <paulmck@kernel.org>

When running heavy test workloads with KASAN enabled, RCU Tasks grace
periods can extend for many tens of seconds, significantly slowing
trace registration.  Therefore, make the registration-side RCU Tasks
grace period be asynchronous via call_rcu_tasks().

Link: https://lore.kernel.org/linux-trace-kernel/ac05be77-2972-475b-9b57-56bef15aa00a@paulmck-laptop

Reported-by: Jakub Kicinski <kuba@kernel.org>
Reported-by: Alexei Starovoitov <ast@kernel.org>
Reported-by: Chris Mason <clm@fb.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 3951c0d0ec63..f9223513414a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5366,6 +5366,13 @@ static void remove_direct_functions_hash(struct ftrace_hash *hash, unsigned long
 	}
 }
 
+static void register_ftrace_direct_cb(struct rcu_head *rhp)
+{
+	struct ftrace_hash *fhp = container_of(rhp, struct ftrace_hash, rcu);
+
+	free_ftrace_hash(fhp);
+}
+
 /**
  * register_ftrace_direct - Call a custom trampoline directly
  * for multiple functions registered in @ops
@@ -5464,10 +5471,8 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
  out_unlock:
 	mutex_unlock(&direct_mutex);
 
-	if (free_hash && free_hash != EMPTY_HASH) {
-		synchronize_rcu_tasks();
-		free_ftrace_hash(free_hash);
-	}
+	if (free_hash && free_hash != EMPTY_HASH)
+		call_rcu_tasks(&free_hash->rcu, register_ftrace_direct_cb);
 
 	if (new_hash)
 		free_ftrace_hash(new_hash);
-- 
2.43.0



