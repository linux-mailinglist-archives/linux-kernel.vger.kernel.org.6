Return-Path: <linux-kernel+bounces-212673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272B39064AC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E8F4B22E99
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 07:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611691386B7;
	Thu, 13 Jun 2024 07:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Ou6DEDdw"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DC9137C54
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 07:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718262827; cv=none; b=uQjSg7ZjJAfZqDaGomNnzHedL0MHJOo5rmAERG0xeDh2ezfBK77423dPw6LQlUHrX47fsKVlMor0/TnyTiweT36HiSbLRe/gc52QUOGGjVdLMziK8ww37uOqko/ouEGzNGRfHdmRgXDm19b9cQdkZjGhFRJKYGMTNoP0azTbCQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718262827; c=relaxed/simple;
	bh=FaY7rOb5o/fuM43F0E49atnCtdWEW2SMePwZ2LSV5tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVqh0lNxhYxtQ6eWpwJ+zxkl5qFYJKo5+Mcc1Ayz7JxqX7SQ5IuZnmnyX4BkGEBVXRuDha4XWYIOtJRsccWzSEm5gIkGWrKwDmrcFRLGlp6DhTbcmVD374rqmd9Q8BvM4pC0iZ0VTC1xPWmLZrxXqLZKAn9mP+IZPFKXQIvTU7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=Ou6DEDdw; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3737b70a74aso5897665ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 00:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1718262825; x=1718867625; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M1COWHSNOmy07a/fhUj3hCu/9pJXU420gP9gRCiZJ30=;
        b=Ou6DEDdwuRK9iLqGkrpj/Bc9WYCm63XVARY4JmSfMv283xZIAPXjPe5eD11mkO3kgM
         GTuJd/6HbRUKZvrMf3deNhrvymtLzliiMyzCJpVL8bk/od5Am8Z6guMRhbTJ+pLQuv9U
         g8UaGxC/mkpqUo/uUZ4/T4bKHlKoJ54uEZQsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718262825; x=1718867625;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M1COWHSNOmy07a/fhUj3hCu/9pJXU420gP9gRCiZJ30=;
        b=ZqtL3Hb4NFt6NnInV3Li141EOeU5ZhtfgU+mgEwV8UuXwQZNimKZUp4jy5Fu1zGgzK
         B+HdhMd+Ufu0y5CEjlYCKCeMnZ+cV4rfQJdW/c8FtNg2XMW9t9nhOSrM1vPa3CbcouRC
         gVSUcvfEt7PzYgq1ZXZ1gVLv3HUS+EB3Rr11zxdA/EkX7ISIVzm1+ytRBj9D21sv9L8u
         hQ3LAUCQmYh4pjGc+23rlGW3xrTmCy/n+UCNGed2PKigQTfutJpMms4tO6WVxHyNOvXM
         fMHgflB+o4Z7t3BZzdK+ldwCYOrBM1uTlEZI5YH+eckLAgu0OoZau/n8HP4XfsthvP+h
         yirw==
X-Gm-Message-State: AOJu0YyzoQKadGzS7QoJ37Tzmu35aZptAWDWREupZhcfHTEfIXfGmeXS
	ZNMGV21zN4+I7aa/wVqFs7H8qAuhs1+mvP6xcNBzvIyFbRYPoHh2IPBVZLMDqDY=
X-Google-Smtp-Source: AGHT+IEO8gxkQWzu5Ah/GO3WrdkSeSXg33rusDjfhwfO+8Ep5u2j3U5TJykxSJAEqWaDyJpLKGcMSg==
X-Received: by 2002:a92:ca91:0:b0:375:af5b:109b with SMTP id e9e14a558f8ab-375d57263e8mr12859455ab.4.1718262824590;
        Thu, 13 Jun 2024 00:13:44 -0700 (PDT)
Received: from localhost (113.176.132.34.bc.googleusercontent.com. [34.132.176.113])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9569e8fa0sm210711173.99.2024.06.13.00.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 00:13:43 -0700 (PDT)
Date: Thu, 13 Jun 2024 07:13:42 +0000
From: Joel Fernandes <joel@joelfernandes.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 3/3] sched: Update ->next_balance correctly during
 newidle balance
Message-ID: <20240613071342.GA1810503@google.com>
References: <20231020014031.919742-1-joel@joelfernandes.org>
 <20231020014031.919742-3-joel@joelfernandes.org>
 <CAKfTPtDk+awL2RxrRL_4-epj069-iXRbUeSwPH5NYz7ncpVzHA@mail.gmail.com>
 <20231022002805.GA3219395@google.com>
 <CAKfTPtCAbMERMkD9h1QRLUti0nPVW_u9N1Vr7W4ONbu_rEjTtw@mail.gmail.com>
 <20231109100254.GA111915@google.com>
 <ZVOVkDf28foTkn/A@vingu-book>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZVOVkDf28foTkn/A@vingu-book>

Getting to this pretty late, sorry, see below.

On Tue, Nov 14, 2023 at 04:43:12PM +0100, Vincent Guittot wrote:
> Le jeudi 09 nov. 2023 à 10:02:54 (+0000), Joel Fernandes a écrit :
> > Hi Vincent,
> > 
> > Sorry for late reply, I was in Tokyo all these days and was waiting to get to
> > writing a proper reply. See my replies below:
> > 
> > On Thu, Oct 26, 2023 at 04:23:35PM +0200, Vincent Guittot wrote:
> > > On Sun, 22 Oct 2023 at 02:28, Joel Fernandes <joel@joelfernandes.org> wrote:
> > > >
> > > > On Fri, Oct 20, 2023 at 03:40:14PM +0200, Vincent Guittot wrote:
> > > > > On Fri, 20 Oct 2023 at 03:40, Joel Fernandes (Google)
> > > > > <joel@joelfernandes.org> wrote:
> > > > > >
> > > > > > From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
> > > > > >
> > > > > > When newidle balancing triggers, we see that it constantly clobbers
> > > > > > rq->next_balance even when there is no newidle balance happening due to
> > > > > > the cost estimates.  Due to this, we see that periodic load balance
> > > > > > (rebalance_domains) may trigger way more often when the CPU is going in
> > > > > > and out of idle at a high rate but is no really idle. Repeatedly
> > > > > > triggering load balance there is a bad idea as it is a heavy operation.
> > > > > > It also causes increases in softirq.
> > > > >
> > > > > we have 2 balance intervals:
> > > > > - one when idle based on the sd->balance_interval = sd_weight
> > > > > - one when busy which increases the period by multiplying it with
> > > > > busy_factor = 16
> > > >
> > > > On my production system I see load balance triggering every 4 jiffies! In a
> > > 
> > > Which kind of system do you have? sd->balance_interval is in ms
> > 
> > Yes, sorry I meant it triggers every jiffies which is extreme sometimes. It
> > is an ADL SoC (12th gen Intel, 4 P cores 8 E cores) get_sd_balance_interval()
> > returns 4 jiffies there. On my Qemu system, I see 8 jiffies.
> 
> Do you have details about the sched_domain  hierarchy ?
> That could be part of your problem (see below)

The hierarchy is pretty simple:

$ cat /sys/kernel/debug/sched/domains/cpu*/domain0/name
MC
MC
MC
MC

I boot qemu like this by passing "-smp cpus=4,threads=1,sockets=1"

> > 
> > [...]
> > > > > > Another issue is ->last_balance is not updated after newidle balance
> > > > > > causing mistakes in the ->next_balance calculations.
> > > > >
> > > > > newly idle load balance is not equal to idle load balance. It's a
> > > > > light load balance trying to pull one  task and you can't really
> > > > > consider it to the normal load balance
> > > >
> > > > True. However the point is that it is coupled with the other load balance
> > > > mechanism and the two are not independent. As you can see below, modifying
> > > > rq->next_balance in newidle also causes the periodic balance to happen more
> > > > aggressively as well if there is a high transition from busy to idle and
> > > > viceversa.
> > > 
> > > As mentioned, rq->next_balance is updated whenever cpu enters idle
> > > (i.e. in newidle_balance() but it's not related with doing a newly
> > > idle load balance.
> > 
> > Yes, I understand that. But my point was that the update of rq->next_balance
> > from the newidle path is itself buggy and interferes with the load balance
> > happening from the tick (trigger_load_balance -> run_rebalance_domains).
> 
> Newidle path is not buggy. It only uses sd->last_balance + interval to
> estimate the next balance  which is the correct thing to do. Your problem
> comes from the update of sd->last_balance which never happens and remains
> in the past whereas you call run_rebalance_domains() which should
> run load_balance for all domains with a sd->last_balance + interval in the
> past.
> Your problem most probably comes from the should_we_balance which always or
> "almost always" returns false in your use case for some sched_domain and
> prevents to updat sd->last_balance. Could you try the patch below ?
> It should fix your problem of trying to rebalance every tick whereas
> rebalance_domain is called.
> At least this should show if it's your problem but I'm not sure it's the right
> things to do all the time ...

I tried your diff below. It did not make a difference to the problem. Only
this patch series made a ~10-20x softirq reduction.

> 
> ---
>  kernel/sched/fair.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3745ca289240..9ea1f42e5362 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11568,17 +11568,6 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
>  		need_decay = update_newidle_cost(sd, 0);
>  		max_cost += sd->max_newidle_lb_cost;
> 
> -		/*
> -		 * Stop the load balance at this level. There is another
> -		 * CPU in our sched group which is doing load balancing more
> -		 * actively.
> -		 */
> -		if (!continue_balancing) {
> -			if (need_decay)
> -				continue;
> -			break;
> -		}
> -
>  		interval = get_sd_balance_interval(sd, busy);
> 
>  		need_serialize = sd->flags & SD_SERIALIZE;
> @@ -11588,7 +11577,12 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
>  		}
> 
>  		if (time_after_eq(jiffies, sd->last_balance + interval)) {
> -			if (load_balance(cpu, rq, sd, idle, &continue_balancing)) {
> +			/*
> +			 * Stop the load balance at this level. There is another
> +			 * CPU in our sched group which is doing load balancing more
> +			 * actively.
> +			 */
> +			if (continue_balancing && load_balance(cpu, rq, sd, idle, &continue_balancing)) {

This diff did not solve the problem. Let me go see what other paths are not
updating sd->last_balance in the run_rebalance_domains()..

thanks,

 - Joel


