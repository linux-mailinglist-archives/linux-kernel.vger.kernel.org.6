Return-Path: <linux-kernel+bounces-193707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F39798D30ED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75111F2A4C6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542D216E886;
	Wed, 29 May 2024 08:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qPLQi19C"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55D216D9BE
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716970459; cv=none; b=N7ckfsLbdxK12huJfXreLjangSr3KGfs5km7XGX0PgsCnNC+03KMZTdI9zQ8pjuw1Oc+8CEo7LQxL99NwIb5ppV3y2Qem6vFRnMQeDxmlsEnMTDtqZP63u+sD6F35NrV5z6NshLm7Fq4TPGFABLxe47TVjE1Zzz3A/pH7tVC7f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716970459; c=relaxed/simple;
	bh=8oG+ebmceilmIBqaQs2tVtIByd4rhD1pcJkEmxIya24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjeyyFsqI767es9na/wuqyMxDcV9+8D/uvVj5Ke5Wmq0zg5gp0t7qZPlBOUtlhlcMKA1ID1XAkA99ytcMRFYsHE++jYuYXqudOlmnlG5NVrfPfkWLmMwN9sm7Z/S3yYi94a3VdqTVLEAmBp9gXpE/Pl9oQAfluwWEaoee+BTiIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qPLQi19C; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=patzQVXRASfi38qVj0cUhUjqqyVmf9/+BCwLPiPV1GI=; b=qPLQi19C+wAn8GpEMZh/j38woN
	7J+Cl4k+j6fNeZgZxDTUdFwPj7uY2RmEutmPJHdUmRSjx2nvWk0HV02WviwKdajaER+5VlE6mG8Nu
	3Zj9G/QHpKRjP/kSY+058cT4PCYkhnuBE0OI5D8vN2PL5Q9V2HDll62+WUcCzA1C+Wmu/fdbS1P5C
	st96wFwDTVLSvNtm0l4EJ/+8o4/S7tEZpe72ecCwS40lpBIAI5nGqD+xZxPncI2aMV7aAemoPaPta
	h//OZ0OhY3ijRukyjUbUiGb4LRx7tJGmVJljn5QhcgbqVA62neQLHtIsdAWoEC9AuS/mP3vInZaJE
	JfW8+HHg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCERg-0000000DSTZ-3HXB;
	Wed, 29 May 2024 08:14:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 611CC30073F; Wed, 29 May 2024 10:14:04 +0200 (CEST)
Date: Wed, 29 May 2024 10:14:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	torvalds@linux-foundation.org, paulmck@kernel.org,
	rostedt@goodmis.org, mark.rutland@arm.com, juri.lelli@redhat.com,
	joel@joelfernandes.org, raghavendra.kt@amd.com,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 16/35] preempt,rcu: warn on PREEMPT_RCU=n, preempt=full
Message-ID: <20240529081404.GI26599@noisy.programming.kicks-ass.net>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-17-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528003521.979836-17-ankur.a.arora@oracle.com>

On Mon, May 27, 2024 at 05:35:02PM -0700, Ankur Arora wrote:
> The combination of PREEMPT_RCU=n and (PREEMPT_AUTO=y, preempt=full)
> works at cross purposes: the RCU read side critical sections disable
> preemption, while preempt=full schedules eagerly to minimize
> latency.
> 
> Warn if the user is switching to full preemption with PREEMPT_RCU=n.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Link: https://lore.kernel.org/lkml/842f589e-5ea3-4c2b-9376-d718c14fabf5@paulmck-laptop/
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  kernel/sched/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d7804e29182d..df8e333f2d8b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8943,6 +8943,10 @@ static void __sched_dynamic_update(int mode)
>  		break;
>  
>  	case preempt_dynamic_full:
> +		if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
> +			pr_warn("%s: preempt=full is not recommended with CONFIG_PREEMPT_RCU=n",
> +				PREEMPT_MODE);
> +

Yeah, so I don't believe this is a viable strategy.

Firstly, none of these RCU patches are actually about the whole LAZY
preempt scheme, they apply equally well (arguably better) to the
existing PREEMPT_DYNAMIC thing.

Secondly, esp. with the LAZY thing, you are effectively running FULL at
all times. It's just that some of the preemptions, typically those of
the normal scheduling class are somewhat delayed. However RT/DL classes
are still insta preempt.

Meaning that if you run anything in the realtime classes you're running
a fully preemptible kernel. As such, RCU had better be able to deal with
it.

So no, I don't believe this is right.

