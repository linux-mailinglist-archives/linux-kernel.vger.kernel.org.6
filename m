Return-Path: <linux-kernel+bounces-348336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA6A98E61D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 00:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4FE41F23F5E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE99199385;
	Wed,  2 Oct 2024 22:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nMxqutCW"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739C612E5D
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 22:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727908278; cv=none; b=WICrsVxhV49XJq2M3wOCYeOfwMzNiyQTcZimvJ/IR3JYVWtRGaGWjQbwrOj4eOqv0DvWKCdaziuc8ng564Vu+VQ1fzP3+K5bJaF10oRGNNxZv2S0JFsELniP/AKvWDeTFczpFW7SxeAIle+zLQJUdmnP2KbVNHHUghV1/nGqbIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727908278; c=relaxed/simple;
	bh=adeYj9PdKiVn7AbPRW7naiJLqjOeyAD5hrmId8/4/tI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uimXlGi1pVj7RgKItqwxFPn6Q92C/1foK4krkIiQv7TmMGJI8jYLZIWMkf/JY+s9Kdmvjuzn4wQt6jejJzdUVxSPeCu2CtKyzzIzG483uN5fBOED6bQvkCPs8UuR71ogPW0u/nPMxMruaQFmlH1+JPt6dH6rWCFJW7Me76sxgEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nMxqutCW; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7d7a9200947so165481a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 15:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727908276; x=1728513076; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lxLw64BWT7K0hpjRH7zBXchfMcEk45GpgPXv5EtmA5c=;
        b=nMxqutCW4LyIL3JWvnRCLktaxFmid+EuuFrLvDOPvT3ujGqWyaxM8WQZ23cVWQEWB+
         U1t9DACMDD9/dPa8NnfIYnOabTQ6UtQNS/L5XMq1yQKpXwrEatSqc1OGCYwyxmyQ3Ik7
         TD7bEi15+WGKE9z5SxE/j+ITlzyODmmoM10FEbh1UklSVUewJIr7TN4/dzR1038nIwCz
         calvEkr/i1ukKrEg5fflBxmtUZ0eSBZRvE1Q7SfM9SHhY5LV9hR1mv+xBtnYKFqQ6E5o
         rz2UB2SiaJnGTRt4LsFfUPRPtpLjw3HfTWQziZ2unydo9bNKkUSH6BXDSwHtMprPOWHb
         d2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727908276; x=1728513076;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxLw64BWT7K0hpjRH7zBXchfMcEk45GpgPXv5EtmA5c=;
        b=UNDpKU7Y7cbzgwCJBe1GqXRKj9zANIO/a90Et2OcIg0nMOV38sWXrs25Xp0DpMO+Db
         Ohjvso0zLgbeTiE9Q195G5IWCoPWXZQrua7ZUpQaS5pkko+S0LxMGJPDicISJQkY/nt5
         FPDefLNuqhfWUVsq3nqQ6cg3/a8Wd/es9QXFY5nY8zb0CJToyeWcw57LIjHbfcmTkFIh
         s0k+X4pMHfosdizk3pJPkZSKZuIYqL4FutDIYBy8KclRPpY7IIcNlMUXR5EDu5T80vG2
         UD23f8ZtD5fg1d2ntViAaRCrHYPfy9RB0/Ri9RP/DI8k76l5SR3z3By8gvJHjJcqeh5N
         PR7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVY0jmc/thQ5bLd3+gT4X4ILv5d9WjE5K8JfJhcfK99kXBDKMEdGY1fufwJlir+zFnNrqY+NdyQBT1lmok=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAYNRLRLBatXkURkVJs8JNcniiQriDXarmr+i2r1DHAimRk3h+
	e6h1HYDIMjC6JGDjCGAeCqGim5kJqEu4XbguIpUhMjw0V44xsbwnw1CMgygScA==
X-Google-Smtp-Source: AGHT+IF1pbg3yz9IKhJHd7nzUSo2khdkehT4w+EJtlzuv3Y3z3Uo+8Fji0pJgA4CSarQTYQDeQyb/g==
X-Received: by 2002:a17:90a:8a10:b0:2da:5289:89a2 with SMTP id 98e67ed59e1d1-2e1849dd9b0mr4890362a91.41.1727908275427;
        Wed, 02 Oct 2024 15:31:15 -0700 (PDT)
Received: from bsegall.svl.corp.google.com.localhost ([2620:15c:2a3:200:b8cb:b97:833f:19dd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1bfd2c28csm26292a91.43.2024.10.02.15.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 15:31:15 -0700 (PDT)
From: Benjamin Segall <bsegall@google.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Vishal Chourasia <vishalc@linux.ibm.com>,  Peter Zijlstra
 <peterz@infradead.org>,  linux-kernel@vger.kernel.org,  Ingo Molnar
 <mingo@redhat.com>,  Vincent Guittot <vincent.guittot@linaro.org>,  Juri
 Lelli <juri.lelli@redhat.com>,  Dietmar Eggemann
 <dietmar.eggemann@arm.com>,  Steven Rostedt <rostedt@goodmis.org>,  Mel
 Gorman <mgorman@suse.de>,  Valentin Schneider <vschneid@redhat.com>,
  luis.machado@arm.com
Subject: Re: sched/fair: Kernel panics in pick_next_entity
In-Reply-To: <55a2acefffb8c99e4234bd18656a75625447c2d0.camel@gmx.de> (Mike
	Galbraith's message of "Tue, 01 Oct 2024 10:30:26 +0200")
References: <ZvVWq3WM6zVza_mD@linux.ibm.com>
	<20240930144157.GH5594@noisy.programming.kicks-ass.net>
	<Zvr2bLBEYyu1gtNz@linux.ibm.com> <Zvr4wJ9YJRzWrbEF@linux.ibm.com>
	<55a2acefffb8c99e4234bd18656a75625447c2d0.camel@gmx.de>
Date: Wed, 02 Oct 2024 15:31:13 -0700
Message-ID: <xm26msjmm91q.fsf@bsegall.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mike Galbraith <efault@gmx.de> writes:

> On Tue, 2024-10-01 at 00:45 +0530, Vishal Chourasia wrote:
>> >
>> for sanity, I ran the workload (kernel compilation) on the base commit
>> where the kernel panic was initially observed, which resulted in a
>> kernel panic, along with it couple of warnings where also printed on the
>> console, and a circular locking dependency warning with it.
>>
>> Kernel 6.11.0-kp-base-10547-g684a64bf32b6 on an ppc64le
>>
>> ------------[ cut here ]------------
>>
>> ======================================================
>> WARNING: possible circular locking dependency detected
>> 6.11.0-kp-base-10547-g684a64bf32b6 #69 Not tainted
>> ------------------------------------------------------
>
> ...
>
>> --- interrupt: 900
>> se->sched_delayed
>> WARNING: CPU: 1 PID: 27867 at kernel/sched/fair.c:6062 unthrottle_cfs_rq+0x644/0x660
>
> ...that warning also spells eventual doom for the box, here it does
> anyway, running LTPs cfs_bandwidth01 testcase and hackbench together,
> box grinds to a halt in pretty short order.
>
> With the patchlet below (submitted), I can beat on box to my hearts
> content without meeting throttle/unthrottle woes.
>
> sched: Fix sched_delayed vs cfs_bandwidth
>
> Meeting an unfinished DELAY_DEQUEUE treated entity in unthrottle_cfs_rq()
> leads to a couple terminal scenarios.  Finish it first, so ENQUEUE_WAKEUP
> can proceed as it would have sans DELAY_DEQUEUE treatment.
>
> Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
> Signed-off-by: Mike Galbraith <efault@gmx.de>
> ---
>  kernel/sched/fair.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6058,10 +6058,13 @@ void unthrottle_cfs_rq(struct cfs_rq *cf
>  	for_each_sched_entity(se) {
>  		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
>
> -		if (se->on_rq) {
> -			SCHED_WARN_ON(se->sched_delayed);
> +		/* Handle any unfinished DELAY_DEQUEUE business first. */
> +		if (se->sched_delayed) {
> +			int flags = DEQUEUE_SLEEP | DEQUEUE_DELAYED;
> +
> +			dequeue_entity(qcfs_rq, se, flags);
> +		} else if (se->on_rq)
>  			break;
> -		}
>  		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);
>
>  		if (cfs_rq_is_idle(group_cfs_rq(se)))

Yeah, if we can wind up here to hit that warning, then we need to get it
out of delay state, not just leave it. Whether dequeue_entity +
enqueue_entity is better or worse than requeue_delayed_entity (+ break), I really
don't know.

This did prompt me to try and figure out if we could limit delay to the
EEVDF parts. I think ideally, we'd only have delayed tasks accounted for
in min_vruntime/avg_vruntime/avg_load, but trying to keep them out of
nr_running/load.weight seems like it runs into too many issues, while
having them still counted there means skipping dequeue_entity like the
current version, which means it wouldn't have saved us this.

I think we could still probably remove the current core.c touchpoints in
favor of just having migrate_task_rq_fair take a parameter for "do we
already hold rq_lock rather than just p->pi_lock" (and it and
switched_from/changed_group handling things)? We'd probably need to do
something very careful to avoid migrate_task_rq_fair unconditionally
needing rq_lock though, which would be a pain, so it might not be worth
it even if I'm not forgetting some other reason for pushing the delay
knowledge all the way out to p->on_rq.


