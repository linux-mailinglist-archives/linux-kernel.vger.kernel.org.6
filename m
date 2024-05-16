Return-Path: <linux-kernel+bounces-180722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BD88C724A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 09:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08A71F213B0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 07:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9B3604D5;
	Thu, 16 May 2024 07:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iKVF4eIc"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E6550A80
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 07:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715846216; cv=none; b=H4f1AI49DReIaD0aMQUPoZAK/WFoOiYixPngFF6UM0Ce1X+HKGIPQGlwPCQ8SSB8kebyuQebnzxOWZJ6HgKjCrwtxRJ+6QTe6qhQFLEKEPLputuTq5cPow6MQ6JIvzI01Z83tMsjrTLzxzlLTsf/tyUaERSexqvbcEum1dTiNwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715846216; c=relaxed/simple;
	bh=Q+g6RohzgurGfkkfJHgvSkttco96KwzHqWDEt+e0kVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEgheqAyz8rKD8CKJsZETlVepQ5t0JYT9ThNW98lu1GcBfGeGbr4UR0zKaIbSwklNKn691a5ld29FMCa869rEPsedg6hiapJlfrNWQtfG8DAJyfpNXdrMrB+lXKt5QAaYod8swmenDvbZbeeNswWdu98CjzADbINdDmBJRk73uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iKVF4eIc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=v68Ze4zS81jeyEPkpC8TF4NYVy29m7I2JYql5hSnaB8=; b=iKVF4eIcJHJ/g9qCyhQYNuNdzN
	sS63KHa/kpNtE/QGQqzvkWBf5won4RdHaZecRuJwFg5vNKX4rxJDYOkLmZShZXtQDQldM6zNg0zI1
	nU4ZZGnenrFdppCKXrmLaO/vlw4p2jsMovExzNiLhlpyEsUERFE3l0DINCBFxJ/q2K4aG2s9O9voC
	FiX/wGn92TBoKfACEmo4SUTYX/J5vkEQoOO8sWtJ9nkLU+BATLg9t6VPcWfzG0u2Nl4LLOjc2FGae
	bjbA+Md2Hncx6CijPDZZmE6IMjMA/J3miuwpsFwXlvLRAbn1kT61LOvJo1laNpVIcbRpEaCcec1mc
	DGYnm81A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7VyX-00000005NMW-1BmR;
	Thu, 16 May 2024 07:56:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AFDFC30068B; Thu, 16 May 2024 09:56:28 +0200 (CEST)
Date: Thu, 16 May 2024 09:56:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Levi Yun <ppbuk5246@gmail.com>, Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	anna-maria@linutronix.de, mingo@kernel.org, tglx@linutronix.de,
	Markus.Elfring@web.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] time/tick-sched: idle load balancing when nohz_full
 cpu becomes idle.
Message-ID: <20240516075628.GC22557@noisy.programming.kicks-ass.net>
References: <20240508172621.30069-1-ppbuk5246@gmail.com>
 <20240509092931.35209-2-ppbuk5246@gmail.com>
 <ZkU8lm2tjm_r9FpZ@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZkU8lm2tjm_r9FpZ@pavilion.home>

On Thu, May 16, 2024 at 12:52:06AM +0200, Frederic Weisbecker wrote:
> Le Thu, May 09, 2024 at 10:29:32AM +0100, Levi Yun a écrit :
> > When nohz_full CPU stops tick in tick_nohz_irq_exit(),
> > It wouldn't be chosen to perform idle load balancing because it doesn't
> > call nohz_balance_enter_idle() in tick_nohz_idle_stop_tick() when it
> > becomes idle.
> > 
> > Formerly, __tick_nohz_idle_enter() is called in both
> > tick_nohz_irq_exit() and in do_idle().
> > That's why commit a0db971e4eb6 ("nohz: Move idle balancer registration
> > to the idle path") prevents nohz_full cpu which isn't yet
> > idle state but tick is stopped from entering idle balance.
> > 
> > However, this prevents nohz_full cpu which already stops tick from
> > entering idle balacne when this cpu really becomes idle state.
> > 
> > Currently, tick_nohz_idle_stop_tick() is only called in idle state and
> > it calls nohz_balance_enter_idle(). this function tracks the CPU
> > which is part of nohz.idle_cpus_mask with rq->nohz_tick_stopped properly.
> > 
> > Therefore, Change tick_nohz_idle_stop_tick() to call nohz_balance_enter_idle()
> > without checking !was_stopped so that nohz_full cpu can be chosen to
> > perform idle load balancing when it enters idle state.
> > 
> > Fixes: a0db971e4eb6 ("nohz: Move idle balancer registration to the idle path")
> > Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> > ---
> > v4:
> > 	- Add fixes tags.
> > 
> > v3:
> > 	- Rewording commit message.
> > 
> > v2:
> > 	- Fix typos in commit message.
> > 
> >  kernel/time/tick-sched.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index 71a792cd8936..31a4cd89782f 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -1228,8 +1228,10 @@ void tick_nohz_idle_stop_tick(void)
> >  		ts->idle_sleeps++;
> >  		ts->idle_expires = expires;
> > 
> > -		if (!was_stopped && tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
> > -			ts->idle_jiffies = ts->last_jiffies;
> > +		if (tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
> > +			if (!was_stopped)
> > +				ts->idle_jiffies = ts->last_jiffies;
> > +
> 
> I've taken some time to respond because your patch has raised more questions
> while discussing this with Anna-Maria:
> 
> 1) Is Idle load balancing actually relevant for nohz_full? HK_TYPE_MISC already
>    prevent those CPUs from becoming idle load balancer. They can still be
>    targets for load balancing but nohz_full CPUs are supposed to run only one
>    task.
> 
> 2) This is related to previous point: HK_TYPE_SCHED is never activated. It would
>    prevent the CPU from even beeing part of idle load balancing. Should we
>    remove it or plug it?
>    
> 
> 3) nohz_balance_enter_idle() is called when the tick is stopped for the first
>    time and nohz_balance_exit_idle() is called from the tick. But that also
>    applies to idle ticks. So if the load balancing triggers while the tick is
>    stopped, nohz_balance_enter_idle() won't be re-called in the idle loop even
>    though the tick is stopped (that would be fixed with your patch).
> 
> 4) Why is nohz_balance_exit_idle() called from the tick and not from the idle
>    exit path? Is it to avoid overhead?
> 
> I'm adding some scheduler people in Cc who might help answer some of those
> questions.

None of that HK nonsense is relevant. The NOHZ_FULL nonsense implies
single CPU partitions, and *that* should be avoiding any and all
load-balancing.

If there still is, that's a bug, but that's not related to HK goo.

As such, I don't think the HK_TYPE_SCHED check in
nohz_balance_enter_idle() actually makes sense, the on_null_omain()
check a little below that should already take care of things, no?

