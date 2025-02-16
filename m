Return-Path: <linux-kernel+bounces-516659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1218A37579
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 17:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3BAB16EA1B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 16:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2BD19992D;
	Sun, 16 Feb 2025 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="fzMEiRKI"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628CE9450
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739722284; cv=none; b=pz78yPKdGBYGSLRIhaG6piNyVKL6ZPp0CUP+s4RNmPqFe1db7RTM4GMBoNSbX0WdaBCH/TZ8kGuYOs8hW8UFI3b+tC2B26DaerwbFUnkwZ0sF9HNWv5qqOxPKn21vTcTGQqJWmkQdNx/Snp5O2uQmuIgZ7x4xkcwd5Y+IUiDv/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739722284; c=relaxed/simple;
	bh=JhCBC5InftUm+ioo626PAlxtLry1jPGKPqAu2G8vE3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4aWwqC2rvDsM0enh6iPZ7ISjavX+jjOfZMhS+C1FEL+czuoYfhFTmcROtBevXDeIe7suq+arxCRhAsCLVYuOZio8r9AbIDExVGw/OEa7KIhonElRKjIqHRD8Y51hyDBN0ei2BmTkrDa1PXoacUiVh3MMlc22X5d0rCh/4aCNRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=fzMEiRKI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-438a3216fc2so37675385e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 08:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1739722280; x=1740327080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ph4oV/ymyzAufDohiQMimSBvQlyjW1He1o/sa7c2O9E=;
        b=fzMEiRKI9f/E4/OkrmQYnLQ3E30xrcpkQM/p9hzIEyluE+P3aGOiK9y/1HySqI9rhM
         YDlybVX5EZvUCj6T+0XcXB7LxBi89pTOjTWKdvJRhzFE4CAC/t7KsM/wNuKXMFK/687c
         YmFjciHtSyKUdWIwaa+o+WvIcG5L9pyHNQnxgTL1QbxGWocMRER552JBhR2XhLZVRVff
         rfySPiHl952MAPUxj38NhXmKamOatRiKiYubUhPgtXhO9MkqTAkUVEM3Al5r/W4xAIUX
         kmL9uFyEyLPyUEqyaNlTPC1AygkP1BoVudNeBwa3yPTVd1ix5meOSkM1VhQRNmMIc8lj
         oWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739722280; x=1740327080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ph4oV/ymyzAufDohiQMimSBvQlyjW1He1o/sa7c2O9E=;
        b=uv7Jj/Ye0ocx7WLKz4/P66vociecN3GjEvxD53x73iARkIykOlqgrq1FudW7FpgifH
         UDZ/B7Qj1hj2+8qbJBv/lClrDB7JtFfSDLlZPL2Dc756XAwlkCnR+1vI/44noRnjzyBM
         Fe5RftvRrdWcKhiUv02OgRoeaUDdtcL3ivCMI2VSALnd5Ndm4hrwijFJ4pncWMkgqduR
         Q3z6lLdzlJOSoKNM+BXqrHZGdYvt6KtN7TA9BT9kVGeCRlMNToT+vZ74GuJ2sraPprQ+
         bJOJ4+En/12LwcTHI4otTsO9GtddWMeCaIDu3rdgBZI9bWdDqKAKl8N5lqDAqMQZt5q4
         wHNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyg1ma7inItjiwjn6WuMpOLi8yOiSBU1AwucnHz0be5GYhT4WTAqfzDgxQvP+JJ+q7Ms0rncJBVUCdWTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1HKu5B+dOrgiL/MCD7N0ymFK9tcO1xi42rETIk7IUperC9VFc
	ZPHq8adABCFhmg4MSS4M+pszbjRDvVDz/IqWWKeLHl2QVxiTmc6WSxEey9ttO28=
X-Gm-Gg: ASbGncsWuIwtY/fW3vBxi72aCCvJMZ6uNl5QjPEVFuVgmVutL4AEcUS/VVyNcmPQbU8
	cBuayZo5cnUyJCzaO12Yu/lB7Qq9seVlCHlZM6O05sr7tBtnb7DW/0hu6e5teBinA+rDDwHNfd4
	2vQfdhiHWXSFLx9wGJ/TACkP7XHwl4SIJzlDKzlw82aH+3L6iBWUh0YAdBTgv75uuEu02KfGhPu
	rlGijXhO1hn8VE5tvTgkolOJQbs5mJXznwFRowF9FUhYsnYjvRR7D2MV0IKauDxexeE3U5gS16O
	ggbR3qnrXbCbcU1Gk4wEpLY7EWg9MVSqfxvFHksSkLU7OVnnh8cqI6qGdIDjk6/qMbHd
X-Google-Smtp-Source: AGHT+IG3yHWWbTKRnpDVnMFxa77O4CdOBxTynKUeOuJ5925c0tsbx/vIgmcTrYPB62OmI1k2Q2OmwA==
X-Received: by 2002:a05:600c:3b25:b0:439:5573:9348 with SMTP id 5b1f17b1804b1-4396e745ac2mr59340805e9.22.1739722280263;
        Sun, 16 Feb 2025 08:11:20 -0800 (PST)
Received: from airbuntu (host109-154-33-115.range109-154.btcentralplus.com. [109.154.33.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1b84bcsm133200835e9.40.2025.02.16.08.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 08:11:19 -0800 (PST)
Date: Sun, 16 Feb 2025 16:11:18 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Stultz <jstultz@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kconfig.hz: Change default HZ to 1000
Message-ID: <20250216161118.m4c4m4jsjyskuwsc@airbuntu>
References: <20250210001915.123424-1-qyousef@layalina.io>
 <20250212145054.GA1965539@joelnvbox>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250212145054.GA1965539@joelnvbox>

On 02/12/25 09:50, Joel Fernandes wrote:
> On Mon, Feb 10, 2025 at 12:19:15AM +0000, Qais Yousef wrote:
> > The frequency at which TICK happens is very important from scheduler
> > perspective. There's a responsiveness trade-of that for interactive
> > systems the current default is set too low.
> 
> Another thing that screws up pretty badly at least with pre-EEVDF CFS is the
> extra lag that gets added to high nice value tasks due to the coarser tick
> causes low nice value tasks to get an even longer time slice. I caught this
> when tracing Android few years ago. ISTR, this was pretty bad almost to a
> point of defeating fairness. Not sure if that shows with EEVDF though.

There was a bug that Vincent fixed with sched_period in extreme scenarios. But
generally starvation problems are common with 4ms TICK when the CPU is
overloaded as it could be a long time before the task gets a chance to run
again.

> > NOHZ should be good enough to alleviate these concerns. And recent
> > addition of RCU_LAZY further helps with keeping TICK quite in idle
> > scenarios.
> > 
> > As pointed out to me by Saravana though, the longer TICK did indirectly
> > help with timer coalescing which means it could hide issues with
> > drivers/tasks asking for frequent timers preventing entry to deeper idle
> > states (4ms is a high value to allow entry to deeper idle state for many
> > systems). But one can argue this is a problem with these drivers/tasks.
> > And if the coalescing behavior is desired we can make it intentional
> > rather than accidental.
> 
> I am not sure how much coalescing of timer-wheel events matter. My impression
> is coalescing matters only for HRtimer since those can be more granular.

Bad usage of english from my side. It just they trigger accurately now and they
were accidentally deferred to the next jiffie which has 4ms granularity.

> >  kernel/Kconfig.hz | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/Kconfig.hz b/kernel/Kconfig.hz
> > index 38ef6d06888e..c742c9298af3 100644
> > --- a/kernel/Kconfig.hz
> > +++ b/kernel/Kconfig.hz
> > @@ -5,7 +5,7 @@
> >  
> >  choice
> >  	prompt "Timer frequency"
> > -	default HZ_250
> > +	default HZ_1000
> 
> Its fine with me, but I wonder who else cares about HZ_250 default. I
> certainly don't. And if someone really wants it for an odd reason, then can
> just adjust the config for themselves.

I think it is a common source of latency and performance and the arguments for
throughput and power are now outdated IMHO. Modern hardware and workloads are
different and time to modernize some default value to better suite the wider
audience.

> Acked-by: Joel Fernandes <joelagnelf@nvidia.com>

Thanks!

--
Qais Yousef

