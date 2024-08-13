Return-Path: <linux-kernel+bounces-285574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 265E0950FDB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56171F23416
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089401ABECF;
	Tue, 13 Aug 2024 22:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gnZy3Asg"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E2F1A76B6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 22:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723589440; cv=none; b=Dv92OQUJ/9ubhHRhbw3ewKJ6I7E9NfAiEtazMsMgweUlqN9FsgWT4r3P2nBs7lkYRif5JnvmE9mb9mw4FARoYaJvv5e3gDdbBwFMl936OmC4kM2suR5nFTyuFiI69FN6VMrFZMwv1+3kKqdRAv7L0LioYbzXsVxV/SsHcUz++Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723589440; c=relaxed/simple;
	bh=TnZwOCNsTC50oF6WkkQSYwA75XDmDW0q3W7IG+O8RYo=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=kNoYPjnFmwqJu/YGt+4pk7tT40CrDrU9mlJ+UxYzrvxYLWqk28yXfqYeEi7UKYBZf1nV67Z5Ogx2Fhw88OjDfHlnOhEeCWCuRn/Qdd33dj9bcilkJPdj2lYlk60Wa/BXHkLu8jaZaS3ab9oajLHLBgjwi1znCa46K2jU33/8o28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gnZy3Asg; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=N4qqyYvidrFryHZvi0gNFY6ukjdqN3urPMEKouQkyVY=; b=gnZy3AsgiNu6CZhX9QSQDLum5D
	QmIvz0JJsAzn+5rF+ctYWSVlzoBUEXMfCh1kNXgN6fv5hUla+VfLd3buhYOPz5g6bG79nDdCYFhc0
	QE3ziTwq968d+Z/CV+3UsGcrWUocYZ17ZRP2NVEkviLkNiazba8IvXndudVJ4KS8/8AZOsi9TVhfz
	aCPXvM0bNlYT855FcAydppQc1bSu2MctyNqXfpPiwIYRKyNRnAlRHxfREqTLdHoNIe9AlXvXiTdrV
	Vu6z7yWAvTRc9WgM/isZPgnz3dVAAzuM42QBEkxUjI7203O5k17FKsC1kI3odMvUsod0DqnUkImiu
	WPYr4wKg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se0LW-00000007s12-0hti;
	Tue, 13 Aug 2024 22:50:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 3DDE8302440; Wed, 14 Aug 2024 00:50:29 +0200 (CEST)
Message-Id: <20240813224015.943143811@infradead.org>
User-Agent: quilt/0.65
Date: Wed, 14 Aug 2024 00:25:52 +0200
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
Subject: [PATCH 4/9] sched: Split up put_prev_task_balance()
References: <20240813222548.049744955@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

With the goal of pushing put_prev_task() after pick_task() / into
pick_next_task().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5841,8 +5841,8 @@ static inline void schedule_debug(struct
 	schedstat_inc(this_rq()->sched_count);
 }
 
-static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
-				  struct rq_flags *rf)
+static void prev_balance(struct rq *rq, struct task_struct *prev,
+			 struct rq_flags *rf)
 {
 #ifdef CONFIG_SMP
 	const struct sched_class *class;
@@ -5860,8 +5860,6 @@ static void put_prev_task_balance(struct
 	}
 #endif
 
-	put_prev_task(rq, prev);
-
 	/*
 	 * We've updated @prev and no longer need the server link, clear it.
 	 * Must be done before ->pick_next_task() because that can (re)set
@@ -5917,7 +5915,8 @@ __pick_next_task(struct rq *rq, struct t
 	}
 
 restart:
-	put_prev_task_balance(rq, prev, rf);
+	prev_balance(rq, prev, rf);
+	put_prev_task(rq, prev);
 
 	for_each_class(class) {
 		p = class->pick_next_task(rq);
@@ -6017,7 +6016,8 @@ pick_next_task(struct rq *rq, struct tas
 		goto out;
 	}
 
-	put_prev_task_balance(rq, prev, rf);
+	prev_balance(rq, prev, rf);
+	put_prev_task(rq, prev);
 
 	smt_mask = cpu_smt_mask(cpu);
 	need_sync = !!rq->core->core_cookie;



