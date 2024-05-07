Return-Path: <linux-kernel+bounces-170531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 904708BD8C5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 02:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35981C2228C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 00:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48641877;
	Tue,  7 May 2024 00:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="uOq+zuT5"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CFF19E
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 00:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715043426; cv=none; b=oKSzMr8Q6E2Bn7fLgoHFUxSqCG1Dxn1XMxjoTRAeehqgfAv4IzVttTTmi2FaP+Q05Qzq4OHGGIS4pXKUbdVhSBmfFO5hhuCIe4wULZsws52lXav+yJHjxspO50brTDRGX3c+3kppSxNeKipYnp6S+JcvntKrUFe7XpocGwDLGFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715043426; c=relaxed/simple;
	bh=Zw8IK4Keg4Oc7elbEtugi4fDOS7vRLszl4fUoQe2ADU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBlcpZNsGYqO5FFFa5ld7DGhKgH9lbQxkblSh4F/QRXGSnp3LZtmhfH3wpWdpHBi0Gs3jSDFb1SLJpwQe3sG915YkEukT8lCJN9iaOPYnJqc7MSTp4PUXh3ASmN86AXg3p8y1Q9PeJgC0xLMPLLauwvFiwWJCMKxl4TAqwlFL/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=uOq+zuT5; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4196c62bb4eso19053035e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 17:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1715043423; x=1715648223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sMmZF0AOULHWz7K5sI+Gjh6ormvmra+lWWm5ydpM0vo=;
        b=uOq+zuT5k1bRDD7EJymLnHPNY/UWD8Rx6zcXHTb8EWt/aKGRQLD/+NFQ7TUET6n8Gu
         O/s79AUY6bcu3Ch+rM7pvwi5TyCQzFDOFZEmMbsiWOuxd3cuQcC83s48bLSQlvurlEV3
         RTgqgwhFggPFK1Wxlk4TA/T1KVQ9Uk6A2WeZU1s/K7uLS+5xJGU+1CxS3hg/Z5SL3U90
         ggUB7Ww2O4to+SoVEy1LqUxKM3iCXfA39Wp+1O3vYzZnMyFiox5soOS+/p/3QgL/zZ3H
         gQcoqKaVvCW4QSuqyoTyqiVj1lYJv9irkqQxy9qSr8oC2c+vEdNfrmtB7oB/OCPwl20n
         Rc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715043423; x=1715648223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMmZF0AOULHWz7K5sI+Gjh6ormvmra+lWWm5ydpM0vo=;
        b=CEDnd0Abuq9sC9je970Oy9iPV4dg5y/79cZXSz+wcllod8Gg5xlPnV5w3lJCizbyps
         zgISlBAswViqCYB71QcrymyRDUmabMwMXUiGRNev8uIueAT6fbQIq28kvQPwpGrOzuHo
         +JR8uLcrWAx+OZDxBGwDADeNp+sriCHRL7H3bfh6RSe9+WOWyCp78GhdFQ5LCHJbW0li
         kdr4hczB0kjoeIx9+X5b+pn8Or4vq/PjpG47LmckAH0Dgw2KKn5yZ76S1yoP0jRSF7eM
         HmwzZGt8fEwR062rAmm8Sz/V5jed68yJIAlQOYWpO5SLZCIHk19OkBYqB3EZTwmsBZwm
         37mg==
X-Forwarded-Encrypted: i=1; AJvYcCWpleZbzrMGAYSRlFos8P6x5Y/MN3yaj9MJct77VDu/6jul6P8TfMk+HLm0M/wnGvti17cmMR3Zle3ZSl1QJRIb0zidJhDIZ3Udwzq9
X-Gm-Message-State: AOJu0YzZJ3JCZgO7mhGnSPQmvVt+Go8g9a+0PS28uxoLqgQPCBRQpL0b
	qHG/AYZ9TIAP5zYHTm/QEdYJRYNf4gJWjaejfreW3xQzpbxz7UlpYn+48+3ZiRM=
X-Google-Smtp-Source: AGHT+IHDq/r/e2PEjBaRLdu8UmyqB0m3Y57CsH6ZD4urWyJ2XpIhDjGebxgMbe7km9B2sArJT0Am1A==
X-Received: by 2002:a05:600c:1d28:b0:41c:2931:e670 with SMTP id l40-20020a05600c1d2800b0041c2931e670mr9298095wms.2.1715043422944;
        Mon, 06 May 2024 17:57:02 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id m37-20020a05600c3b2500b0041816c3049csm17640865wms.11.2024.05.06.17.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 17:57:01 -0700 (PDT)
Date: Tue, 7 May 2024 01:56:59 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: Consolidate cpufreq updates
Message-ID: <20240507005659.d4rzzaoq3isanndf@airbuntu>
References: <20240505233103.168766-1-qyousef@layalina.io>
 <20240506100509.GL40213@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240506100509.GL40213@noisy.programming.kicks-ass.net>

On 05/06/24 12:05, Peter Zijlstra wrote:
> On Mon, May 06, 2024 at 12:31:03AM +0100, Qais Yousef wrote:
> 
> > +static inline void update_cpufreq_ctx_switch(struct rq *rq, struct task_struct *prev)
> > +{
> > +#ifdef CONFIG_CPU_FREQ
> > +	unsigned int flags = 0;
> > +
> > +#ifdef CONFIG_SMP
> > +	if (unlikely(current->sched_class == &stop_sched_class))
> > +		return;
> > +#endif
> 
> why do we care about the stop class? It shouldn't, in general, consume a
> lot of cycles.
> 
> > +
> > +	if (unlikely(current->sched_class == &idle_sched_class))
> > +		return;
> 
> And why do we care about idle? Specifically this test doesn't capture
> force-idle threads. Notably see is_idle_task().

It's just We don't want these tasks to 'pollute' cpufreq updates since they
shouldn't care or contribute to what frequency the CPU should be running at.

Yes I missed the is_idle_task() from the exclusion list - which can be
simplified as you suggest later.

> 
> > +
> > +	if (unlikely(task_has_idle_policy(current)))
> > +		return;
> > +
> > +	if (likely(fair_policy(current->policy))) {
> > +
> > +		if (unlikely(current->in_iowait)) {
> > +			flags |= SCHED_CPUFREQ_IOWAIT | SCHED_CPUFREQ_FORCE_UPDATE;
> > +			goto force_update;
> > +		}
> > +
> > +#ifdef CONFIG_SMP
> > +		/*
> > +		 * Allow cpufreq updates once for every update_load_avg() decay.
> > +		 */
> > +		if (unlikely(rq->cfs.decayed)) {
> > +			rq->cfs.decayed = false;
> > +			goto force_update;
> > +		}
> > +#endif
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * RT and DL should always send a freq update. But we can do some
> > +	 * simple checks to avoid it when we know it's not necessary.
> > +	 */
> > +	if (rt_task(current) && rt_task(prev)) {
> 
> IIRC dl tasks also match rt_task, so your else clause might not work the
> way you've intended.
> 
> > +#ifdef CONFIG_UCLAMP_TASK
> > +		unsigned long curr_uclamp_min = uclamp_eff_value(current, UCLAMP_MIN);
> > +		unsigned long prev_uclamp_min = uclamp_eff_value(prev, UCLAMP_MIN);
> > +
> > +		if (curr_uclamp_min == prev_uclamp_min)
> > +#endif
> > +			return;
> > +	} else if (dl_task(current) && current->dl.flags & SCHED_FLAG_SUGOV) {
> 
> Notably DL tasks also match rt_task(), so I don't think this clause

Hmm yes. dl priority is negative and rt_task() will capture this. Shouldn't we
fix the function? Can send a separate patch.

	static inline int rt_task(struct task_struct *p)
	{
		return rt_prio(p->prio) && !dl_prio();
	}

> exactly does as you expect. Also, isn't the flags check sufficient on
> it's own?

I considered this, but opted to keep the dl_task() reservedly assuming access
to dl structure should only be considered valid for dl tasks. It seemed safer
to me against potential future changes to the access pattern.

Happy to drop it if this is too reserved.

> 
> > +		/* Ignore sugov kthreads, they're responding to our requests */
> > +		return;
> > +	}
> > +
> > +	flags |= SCHED_CPUFREQ_FORCE_UPDATE;
> > +
> > +force_update:
> > +	cpufreq_update_util(rq, flags);
> > +#endif
> > +}
> 
> But over-all the thing seems very messy, mixing sched_class, policy and
> prio based selection methods.

Yeah, I started with basic conditions and started walking my way on what things
should be excluded. We don't have fair_task() so used fair_policy() and out of
habit continued to use rt/dl_task() without realizing the caveat you
highlighted.

> 
> Can't this be cleaned up somewhat?
> 
> 
> Notably, if you structure it something like so:
> 
> 	if (fair_policy(current)) {
> 		...
> 		return;
> 	}
> 
> 	if (rt_policy(current)) {
> 		if (dl_task(current) && current->dl.flags & SCHED_FLAG_SUGOV)
> 			return;
> 		if (rt_policy(prev) && uclamps_match(current, prev))
> 			return;
> 		...
> 		return;
> 	}
> 
> 	/* everybody else gets nothing */
> 	return;
> 
> You get a lot less branches in the common paths, no?

Yes. How about this? Since stopper class appears as RT, we should still check
for this class specifically.

Thanks!

--->8---

static inline void update_cpufreq_ctx_switch(struct rq *rq, struct task_struct *prev)
{
#ifdef CONFIG_CPU_FREQ
	if (likely(fair_policy(current->policy))) {

		if (unlikely(current->in_iowait)) {
			cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT | SCHED_CPUFREQ_FORCE_UPDATE);
			return;
		}

#ifdef CONFIG_SMP
		/*
		 * Allow cpufreq updates once for every update_load_avg() decay.
		 */
		if (unlikely(rq->cfs.decayed)) {
			rq->cfs.decayed = false;
			cpufreq_update_util(rq, 0);
			return;
		}
#endif
		return;
	}

	/*
	 * RT and DL should always send a freq update. But we can do some
	 * simple checks to avoid it when we know it's not necessary.
	 */
	if (task_is_realtime(current)) {
		if (dl_task(current) && current->dl.flags & SCHED_FLAG_SUGOV) {
			/* Ignore sugov kthreads, they're responding to our requests */
			return;
		}

		if (rt_task(current) && rt_task(prev)) {
#ifdef CONFIG_UCLAMP_TASK
			unsigned long curr_uclamp_min = uclamp_eff_value(current, UCLAMP_MIN);
			unsigned long prev_uclamp_min = uclamp_eff_value(prev, UCLAMP_MIN);

			if (curr_uclamp_min == prev_uclamp_min)
#endif
				return;
		}

#ifdef CONFIG_SMP
		if (unlikely(current->sched_class == &stop_sched_class))
			return;
#endif

		cpufreq_update_util(rq, SCHED_CPUFREQ_FORCE_UPDATE);
		return;
	}

	/* Everything else shouldn't trigger a cpufreq update */
	return;
#endif
}

