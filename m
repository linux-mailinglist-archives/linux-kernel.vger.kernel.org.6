Return-Path: <linux-kernel+bounces-388147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADAB9B5B40
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 06:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8FFB284286
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 05:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA201CFEA0;
	Wed, 30 Oct 2024 05:36:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8501CF5EF
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 05:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730266572; cv=none; b=ORe+flSLlKx/ygDjdP9q2u+TJfi/QqgcSwGeME0YnACt76O407nPdYJ2ScXOPMLSmQw7hdgfPRCgxSShGXzzhMYCHMoMmKt7VdPEVlIwyMDwAZE+RPXfANmBFgkikPQMBJz8lW8DWGNv3zvsoWGOEPjJm23ZsYXmDzP1kgjb8UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730266572; c=relaxed/simple;
	bh=OuLL3exypl11ULrKaSrCWv5HuV9Jk6r3IsdHk1JgQz8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rvjvqeqT1g7Eiaj1LU5veEjpcVzhvDa6NKBGc7RMRs3tCdscrNwxkSa4Nh8tjYuvxv05fFToIAJZtGeGLLBb65caPof9ehxlBtXAWveSo3dYt9ipj0Cx6HWr7HdZYgazWY9TjWYCo0e+rR3Vx7xlWB1Wezik5OV4oOcm5rKJr1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFF2C4CEEE;
	Wed, 30 Oct 2024 05:36:11 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t61OD-00000005BE8-10oi;
	Wed, 30 Oct 2024 01:37:05 -0400
Message-ID: <20241030053705.099732744@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 30 Oct 2024 01:36:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [for-next][PATCH 4/7] ftrace: Use guard for match_records()
References: <20241030053650.956861738@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The ftrace_lock is held for most of match_records() until the end of the
function. Use guard to make error paths simpler.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/20241028071307.927146604@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index e9fd4fb2769e..44adc34643c9 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4829,15 +4829,13 @@ match_records(struct ftrace_hash *hash, char *func, int len, char *mod)
 		mod_g.len = strlen(mod_g.search);
 	}
 
-	mutex_lock(&ftrace_lock);
+	guard(mutex)(&ftrace_lock);
 
 	if (unlikely(ftrace_disabled))
-		goto out_unlock;
+		return 0;
 
-	if (func_g.type == MATCH_INDEX) {
-		found = add_rec_by_index(hash, &func_g, clear_filter);
-		goto out_unlock;
-	}
+	if (func_g.type == MATCH_INDEX)
+		return add_rec_by_index(hash, &func_g, clear_filter);
 
 	do_for_each_ftrace_rec(pg, rec) {
 
@@ -4846,16 +4844,12 @@ match_records(struct ftrace_hash *hash, char *func, int len, char *mod)
 
 		if (ftrace_match_record(rec, &func_g, mod_match, exclude_mod)) {
 			ret = enter_record(hash, rec, clear_filter);
-			if (ret < 0) {
-				found = ret;
-				goto out_unlock;
-			}
+			if (ret < 0)
+				return ret;
 			found = 1;
 		}
 		cond_resched();
 	} while_for_each_ftrace_rec();
- out_unlock:
-	mutex_unlock(&ftrace_lock);
 
 	return found;
 }
-- 
2.45.2



