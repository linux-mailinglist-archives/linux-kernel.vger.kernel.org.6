Return-Path: <linux-kernel+bounces-385030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7EF9B318F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01DE3282C40
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B009F1DDA14;
	Mon, 28 Oct 2024 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RZkIo/WW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C4M/VMf/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219FD1DD86C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730121639; cv=none; b=ZzukhYjU+fLl2kmFHy+dyF63YTEFvM+Q03hCwKifDQg6hIUE0G8Q8nCf23GC2xKZBCM8rDpI8UEleONfIwblGwdzYMjGt36LaJek1FOUhtOk79XByRBUSznz3++i96vVU61KxY6MAhLRiPL0QiAkne7Fqfi751lZNHDItegMIjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730121639; c=relaxed/simple;
	bh=Suwv9Pz/ODA+4gDt8HzisNZt+p8mAGn9UIo7CtFSq5o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dSE0tx/X7N5Xh/P7XGMke07htWVVZIlVYpAhsF4MGo/aAy4HBijOs5lAer4++xvecGyV9g+hSDNIf1Suy9Q2jddIometHC50cI7kFTpiuczK+5R8wcZDwoBRhMgzflkGz+7jNVuUHBp7tJDbPzryvgkPl6tDHUXkCp2ZtFBwlQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RZkIo/WW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C4M/VMf/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730121635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dO0Sbf4gVFSLA8fH2N1EVtb3XGzxJuTgSp+ujywVrwA=;
	b=RZkIo/WWb7KARcBBajXuPqH8VfyA1KQSxKizF+j7w2Nqq+kaDdyiipuGCpd6FgiNo+ViAL
	C2ILFljJXfnwCFpHlR7EUAhpaTmft1V2czR4ilA7xRjmO9qyKtUZwSOoT3KP03hzH7KY+0
	ZDmJ+fU1lldl+nDfiM0iZ5DpFAHXIzf3D6lQJITRDAGOHhbV1cxhlFGUgpuPFzTJaTdiO3
	w+fbZ8JAIOAPP1QRWLGXDO/8095mDzzySUETklmv4ocZ4f9As6OEGP3MzWVexPB5XeIUM9
	17WJLFxd0LDNjipvzRJBeZEDeB30OZrd2SBMAZNGKIRrFcWUt/2HDQPf/ushSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730121635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dO0Sbf4gVFSLA8fH2N1EVtb3XGzxJuTgSp+ujywVrwA=;
	b=C4M/VMf/ettOBTsBj8TKTzHNFm7MqoPZm/Hn44/n3OOJBNoHprePvbI6ioO0A00p2WaeMP
	4zfE5jRoQQAWg4Bg==
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, David
 Vernet <void@manifault.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, Ingo Molnar <mingo@kernel.org>, Rasmus
 Villemoes <ravi@prevas.dk>
Subject: [patch v1A 2/2] sched/ext: Remove sched_fork() hack
In-Reply-To: <20241028103142.423153706@linutronix.de>
References: <20241028103006.008053168@linutronix.de>
 <20241028103142.423153706@linutronix.de>
Date: Mon, 28 Oct 2024 14:20:35 +0100
Message-ID: <87ldy82wkc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Instead of solving the underlying problem of the double invocation of
__sched_fork() for idle tasks, sched-ext decided to hack around the issue
by partially clearing out the entity struct to preserve the already
enqueued node. A provided analysis and solution has been ignored for four
months.

Now that someone else has taken care of cleaning it up, remove the
disgusting hack and clear out the full structure. Remove the comment in the
structure declaration as well, as there is no requirement for @node being
the last element anymore.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Valentin Schneider <vschneid@redhat.com>
---
V2: Remove the comment in ext.h  (Rasmus)
---
 include/linux/sched/ext.h |    1 -
 kernel/sched/ext.c        |    7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -199,7 +199,6 @@ struct sched_ext_entity {
 #ifdef CONFIG_EXT_GROUP_SCHED
 	struct cgroup		*cgrp_moving_from;
 #endif
-	/* must be the last field, see init_scx_entity() */
 	struct list_head	tasks_node;
 };
 
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3548,12 +3548,7 @@ static void scx_ops_exit_task(struct tas
 
 void init_scx_entity(struct sched_ext_entity *scx)
 {
-	/*
-	 * init_idle() calls this function again after fork sequence is
-	 * complete. Don't touch ->tasks_node as it's already linked.
-	 */
-	memset(scx, 0, offsetof(struct sched_ext_entity, tasks_node));
-
+	memset(scx, 0, sizeof(*scx));
 	INIT_LIST_HEAD(&scx->dsq_list.node);
 	RB_CLEAR_NODE(&scx->dsq_priq);
 	scx->sticky_cpu = -1;

