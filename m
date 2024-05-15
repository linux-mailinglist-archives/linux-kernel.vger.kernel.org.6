Return-Path: <linux-kernel+bounces-180457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F048C6ED0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 00:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFE65283427
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 22:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B9E3FE55;
	Wed, 15 May 2024 22:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkJenSik"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7423F9F9
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 22:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715813529; cv=none; b=BpPDLs3gHAWL3nrn/2mHEKs6DEyPU619jfZHq9hz/JrvXfXAURkvZsNQFXt48uzAxdXoQPTPfzy3vG4zZqPSZn4bbdNdrYZVmiB7CTZWPWPEswVWzI6wyRCU04qNTTTuCtsh8KHOmHmzKWyzAey1fwMZMHOTkRaYXydxqyw1P74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715813529; c=relaxed/simple;
	bh=STs8mJIE9jdd4hOQZg34DKQ37+B79CWY4a9uidP2t+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNdAvCv4ZRR6uSyy9eMCyLECAsqaYAvaEqgova9FpG8LocthaIDCBnr4gdvvUFXycvHOl7eDpll8ZVrKg5IYEqpUuKm4aFbmSeJSzj0AQ8XVCZoKm/A79eAirystHJ8QzyRwRcKoXY2xwGZSxmctkp0plsZqvvUPoZPyyjvLAgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkJenSik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF48C116B1;
	Wed, 15 May 2024 22:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715813529;
	bh=STs8mJIE9jdd4hOQZg34DKQ37+B79CWY4a9uidP2t+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bkJenSikP03Wq/GH8WjO1pWjGhY5QO0O4TONQ16gQPvX752Q0+/hfJJgB+XHZdgBM
	 4XOhGW3PSRIsV9yP3AGdpSiRmccSnJS8GZ7C6RQH9gam7mP065ER2MIOQSHlaniWnR
	 mDSevhz+EmiXwWzBuTfjKYsoPER85BHCXSNfPQe2/qB/Huo86vO7Y2d+y1gvkvU175
	 KAQIfUQ+zoLfLf8pfBtsgiWXOLWWQBfEUq4q5H0HQchSlYUjr3MS4epkhJBBNina4P
	 QKnymQBKuX45mcU5oD7edZ/qQwFYQdA963scVGA5Znx3pVcUDvn9cRVYlotZW+sWbi
	 7JjlHed6f+Xjw==
Date: Thu, 16 May 2024 00:52:06 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Levi Yun <ppbuk5246@gmail.com>, Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: anna-maria@linutronix.de, mingo@kernel.org, tglx@linutronix.de,
	Markus.Elfring@web.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] time/tick-sched: idle load balancing when nohz_full
 cpu becomes idle.
Message-ID: <ZkU8lm2tjm_r9FpZ@pavilion.home>
References: <20240508172621.30069-1-ppbuk5246@gmail.com>
 <20240509092931.35209-2-ppbuk5246@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240509092931.35209-2-ppbuk5246@gmail.com>

Le Thu, May 09, 2024 at 10:29:32AM +0100, Levi Yun a écrit :
> When nohz_full CPU stops tick in tick_nohz_irq_exit(),
> It wouldn't be chosen to perform idle load balancing because it doesn't
> call nohz_balance_enter_idle() in tick_nohz_idle_stop_tick() when it
> becomes idle.
> 
> Formerly, __tick_nohz_idle_enter() is called in both
> tick_nohz_irq_exit() and in do_idle().
> That's why commit a0db971e4eb6 ("nohz: Move idle balancer registration
> to the idle path") prevents nohz_full cpu which isn't yet
> idle state but tick is stopped from entering idle balance.
> 
> However, this prevents nohz_full cpu which already stops tick from
> entering idle balacne when this cpu really becomes idle state.
> 
> Currently, tick_nohz_idle_stop_tick() is only called in idle state and
> it calls nohz_balance_enter_idle(). this function tracks the CPU
> which is part of nohz.idle_cpus_mask with rq->nohz_tick_stopped properly.
> 
> Therefore, Change tick_nohz_idle_stop_tick() to call nohz_balance_enter_idle()
> without checking !was_stopped so that nohz_full cpu can be chosen to
> perform idle load balancing when it enters idle state.
> 
> Fixes: a0db971e4eb6 ("nohz: Move idle balancer registration to the idle path")
> Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> ---
> v4:
> 	- Add fixes tags.
> 
> v3:
> 	- Rewording commit message.
> 
> v2:
> 	- Fix typos in commit message.
> 
>  kernel/time/tick-sched.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 71a792cd8936..31a4cd89782f 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -1228,8 +1228,10 @@ void tick_nohz_idle_stop_tick(void)
>  		ts->idle_sleeps++;
>  		ts->idle_expires = expires;
> 
> -		if (!was_stopped && tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
> -			ts->idle_jiffies = ts->last_jiffies;
> +		if (tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
> +			if (!was_stopped)
> +				ts->idle_jiffies = ts->last_jiffies;
> +

I've taken some time to respond because your patch has raised more questions
while discussing this with Anna-Maria:

1) Is Idle load balancing actually relevant for nohz_full? HK_TYPE_MISC already
   prevent those CPUs from becoming idle load balancer. They can still be
   targets for load balancing but nohz_full CPUs are supposed to run only one
   task.

2) This is related to previous point: HK_TYPE_SCHED is never activated. It would
   prevent the CPU from even beeing part of idle load balancing. Should we
   remove it or plug it?
   

3) nohz_balance_enter_idle() is called when the tick is stopped for the first
   time and nohz_balance_exit_idle() is called from the tick. But that also
   applies to idle ticks. So if the load balancing triggers while the tick is
   stopped, nohz_balance_enter_idle() won't be re-called in the idle loop even
   though the tick is stopped (that would be fixed with your patch).

4) Why is nohz_balance_exit_idle() called from the tick and not from the idle
   exit path? Is it to avoid overhead?

I'm adding some scheduler people in Cc who might help answer some of those
questions.

Thanks.
   

>  			nohz_balance_enter_idle(cpu);
>  		}
>  	} else {
> --
> 2.41.0

