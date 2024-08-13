Return-Path: <linux-kernel+bounces-285582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD76950FE4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66CCB1F24883
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF5F1AD9E8;
	Tue, 13 Aug 2024 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rXhvFuwe"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C911A707C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 22:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723589442; cv=none; b=ELdaXPSdw1Kyohfwam0lP5oL3vnssGD0MfTzj4U6f3duQjgRL20ejbmpTIWEMhnhy/Z9ZKyDCcdc9ADJfqsq/ztQXJ/YS2Z3VTfuw80LTYFWKJN+tR68xJTwtKmlrnK9T4psKhKcLduuDvfIhQFnsqpcC/2AssfqjcoPewAxdxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723589442; c=relaxed/simple;
	bh=TxWCzl4+hNsTYCaW4f6uKRhQxDd87wdqETPidEJ/etU=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=OAyu+IVQnEtHMNRUi1iYn9wCbXSszpnpUi2vf5ZRTjpA0xu2kFaK1jvyC6MivMyI0wrSrMP3EBwdr76GFMTJrUPvRrRLSm8UG4IpqzJfyEcB3VTDtzMR9UcpjDp5AMr9pvsT/bZpvjd5EpphCR6qQopSdtM7vfrzFx199lMkOZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rXhvFuwe; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=92noLzsJHL60m/QmsKdMpJSMk3hBlxpRjHA3o4EaS/s=; b=rXhvFuweWltESHRag9cir4ZZYI
	S1cQCp18WDW4+qjpmRUT93VDm+r3TDL18afGrCgtaLUEXkgw6Ub4FqasqvlLjHIi/RTla7uoXx6/N
	JBitBIa1UX/u/iXKBWmSYcQ8dlCRU3X5+W25vc9GzVufY1LAH9636fUVEze2rWT1QNlFAHhApVPGh
	hNwbDBpmgNPrGtec8E29BbP94Ly3pwQeCF3S9zn3TCB84E3CGmrOXXKoah4AsRTbCyrp2s00cKepn
	yjixoo3kN1hJyZ6PwZ+6ULCXMl4G17wUcuYAcDqjFWiswwjFxdDT+hd9fim4SmqFVV6OPYFjzC5z7
	AWSEeCSw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se0LW-00000007s1A-3W6Q;
	Tue, 13 Aug 2024 22:50:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 48BBB302D64; Wed, 14 Aug 2024 00:50:29 +0200 (CEST)
Message-Id: <20240813224016.158454756@infradead.org>
User-Agent: quilt/0.65
Date: Wed, 14 Aug 2024 00:25:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 tj@kernel.org,
 void@manifault.com
Cc: peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org,
 joelaf@google.com
Subject: [PATCH 6/9] sched: Combine the last put_prev_task() and the first set_next_task()
References: <20240813222548.049744955@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Ensure the last put_prev_task() and the first set_next_task() always
go together.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |   17 ++++-------------
 kernel/sched/fair.c  |    3 +--
 kernel/sched/sched.h |   10 +++++++++-
 3 files changed, 14 insertions(+), 16 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5894,8 +5894,7 @@ __pick_next_task(struct rq *rq, struct t
 		/* Assume the next prioritized class is idle_sched_class */
 		if (!p) {
 			p = pick_task_idle(rq);
-			put_prev_task(rq, prev);
-			set_next_task_first(rq, p);
+			put_prev_set_next_task(rq, prev, p);
 		}
 
 		/*
@@ -5926,8 +5925,7 @@ __pick_next_task(struct rq *rq, struct t
 		} else {
 			p = class->pick_task(rq);
 			if (p) {
-				put_prev_task(rq, prev);
-				set_next_task_first(rq, p);
+				put_prev_set_next_task(rq, prev, p);
 				return p;
 			}
 		}
@@ -6016,13 +6014,8 @@ pick_next_task(struct rq *rq, struct tas
 		WRITE_ONCE(rq->core_sched_seq, rq->core->core_pick_seq);
 
 		next = rq->core_pick;
-		if (next != prev) {
-			put_prev_task(rq, prev);
-			set_next_task_first(rq, next);
-		}
-
 		rq->core_pick = NULL;
-		goto out;
+		goto out_set_next;
 	}
 
 	prev_balance(rq, prev, rf);
@@ -6192,9 +6185,7 @@ pick_next_task(struct rq *rq, struct tas
 	}
 
 out_set_next:
-	put_prev_task(rq, prev);
-	set_next_task_first(rq, next);
-out:
+	put_prev_set_next_task(rq, prev, next);
 	if (rq->core->core_forceidle_count && next == rq->idle)
 		queue_core_balance(rq);
 
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8817,8 +8817,7 @@ pick_next_task_fair(struct rq *rq, struc
 
 simple:
 #endif
-	put_prev_task(rq, prev);
-	set_next_task_fair(rq, p, true);
+	put_prev_set_next_task(rq, prev, p);
 	return p;
 
 idle:
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2370,8 +2370,16 @@ static inline void set_next_task(struct
 	next->sched_class->set_next_task(rq, next, false);
 }
 
-static inline void set_next_task_first(struct rq *rq, struct task_struct *next)
+static inline void put_prev_set_next_task(struct rq *rq,
+					  struct task_struct *prev,
+					  struct task_struct *next)
 {
+	WARN_ON_ONCE(rq->curr != prev);
+
+	if (next == prev)
+		return;
+
+	prev->sched_class->put_prev_task(rq, prev);
 	next->sched_class->set_next_task(rq, next, true);
 }
 



