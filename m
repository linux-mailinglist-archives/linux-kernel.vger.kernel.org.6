Return-Path: <linux-kernel+bounces-200673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5087F8FB344
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91688B244B7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B24146A69;
	Tue,  4 Jun 2024 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="x+X8PfFF"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6A1144D2E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717506730; cv=none; b=X/S4h93zZkRfZv+qSHOgkDeM8cHfHutav24T5BjnGKkk2IAeJfwtTuiZnZw13YMpkBnbvqadES5oY2H1ahZmwD/SJobwrCou7IaeQ0Hcaxm5TKIGbiMsWocyyv5AKzBoVawmTH2/vTweQY+I8PtcATuu5ZwnR0dBcPlQi4C17Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717506730; c=relaxed/simple;
	bh=qhTCFsYPePDiCeuzGwHsbrgV1F5/toPRZdL/NB2zFA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbWSqQdoMiocjt3w50CiOy2FwESunaTTJtfmVZP/sixnvm+XQbG65K/CvL9ekA+nyYZ3kT83R5yTK4XG3ZVPr9r3z1Ot6uXoDQ93aeNYr4K6nLUn0B5ceDuVCoCmI0Htl4y80KAzCEXbpTTIhA1zMazycpDpgLf1E6gVQaO3po4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=x+X8PfFF; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6269885572so973045566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 06:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1717506727; x=1718111527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=piNBRJdrtbJp/vQpDqdFlu0Tyy+nG5nFU5mXkH+yz5g=;
        b=x+X8PfFF+HuFTO99PqNmvSUj9V06XhOaCkfVwc0vAbzGaGnZ7apeVbtx0Inoy0ktDj
         zEKeGhXfuaxMY3PlyKyiIWmpugcm8/193JLdiVffX94vix1Kfqsl+UuzxiiiAdVxA430
         OFz6ZN4Ah49s5buyohIaVtYCPYwxyCptPFzWzZeptQj85NPfWWchMEijVcW7WwUhhCqn
         cjQxolObaLVf9YUOmiP5IDXLyNVLaeH3iMhq1ThxVRYhl3svGoLLM6ThBp1D/R1Lwtqv
         W8I8R/PI4CVrj0w1jv8+6e6LdeiE5hmNxlV2kvnZw3rwA0waG7qjjP3k9kZWP4fp0KqM
         aMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717506727; x=1718111527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=piNBRJdrtbJp/vQpDqdFlu0Tyy+nG5nFU5mXkH+yz5g=;
        b=W2zF10g/8U3glkw7UdOXZE52B0Wi5f0sTgjYSZBLplVJuVW5zdrc6WM36hEDQKxRrW
         3zy0qjnJB/lZdc1E2Ss/SJoe3v0DwoSmaEUomnehSLHzzVqShQA6UxeW20vJY6hHW/ag
         OajKKhFcLSWCwvnieUvdMEUU+i+GI6MKG0Z3bNg+gDJ5FRH1zp2h/kBOavJmFTMpxhCG
         x5dk2T/p6vVM5zSYDcCcnv6VHWj3Y7ZeDfO6LBwQsaWDW1o2Pxs25+wkklkTdziUJd8i
         TqnNopjx7me9LinrN64v5gmuO775OxgD1l6j5GXIbXXUAiCOO3J/WlQK6F9ATxOnVxiy
         45MA==
X-Gm-Message-State: AOJu0Yxb0SHpvT+pzUVRiMGuvKrcRgeoylMTTYInXQu7k0JPhRsRA37+
	f86ldxwJo9ArF58AjHu8gYAYYwQ52VzLYc6G2BQOTLGJKw6BJgYUU0ak0PssDNc=
X-Google-Smtp-Source: AGHT+IG089MjdQVNXPQZ0eprs6BzC28ZRisqe/u3lo3PcGQeLGVl99GzyqbCPgp2fLIAKrlsJkFmWw==
X-Received: by 2002:a17:907:76f7:b0:a68:cf34:c95b with SMTP id a640c23a62f3a-a695413e308mr200095066b.7.1717506726792;
        Tue, 04 Jun 2024 06:12:06 -0700 (PDT)
Received: from airbuntu ([87.127.96.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68f56506dcsm365805266b.57.2024.06.04.06.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 06:12:06 -0700 (PDT)
Date: Tue, 4 Jun 2024 14:12:04 +0100
From: Qais Yousef <qyousef@layalina.io>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Connor O'Brien <connoro@google.com>,
	Joel Fernandes <joelaf@google.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>,
	Youssef Esmat <youssefesmat@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Subject: Re: [PATCH v10 4/7] sched: Add move_queued_task_locked helper
Message-ID: <20240604131204.n4njtgo4tpo352ht@airbuntu>
References: <20240507045450.895430-1-jstultz@google.com>
 <20240507045450.895430-5-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240507045450.895430-5-jstultz@google.com>

On 05/06/24 21:54, John Stultz wrote:
> From: Connor O'Brien <connoro@google.com>
> 
> Switch logic that deactivates, sets the task cpu,
> and reactivates a task on a different rq to use a
> helper that will be later extended to push entire
> blocked task chains.
> 
> This patch was broken out from a larger chain migration
> patch originally by Connor O'Brien.
> 
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Qais Yousef <qyousef@layalina.io>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Zimuzo Ezeozue <zezeozue@google.com>
> Cc: Youssef Esmat <youssefesmat@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Metin Kaya <Metin.Kaya@arm.com>
> Cc: Xuewen Yan <xuewen.yan94@gmail.com>
> Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: kernel-team@android.com
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Tested-by: Metin Kaya <metin.kaya@arm.com>
> Reviewed-by: Metin Kaya <metin.kaya@arm.com>
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: Connor O'Brien <connoro@google.com>
> [jstultz: split out from larger chain migration patch]
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
> v8:
> * Renamed from push_task_chain to do_push_task so it makes
>   more sense without proxy-execution
> v10:
> * Changed name to move_queued_task_locked as suggested by Valentin
> ---
>  kernel/sched/core.c     |  4 +---
>  kernel/sched/deadline.c |  8 ++------
>  kernel/sched/rt.c       |  8 ++------
>  kernel/sched/sched.h    | 11 +++++++++++
>  4 files changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7019a40457a6..48f0d4b381d5 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2712,9 +2712,7 @@ int push_cpu_stop(void *arg)
>  
>  	// XXX validate p is still the highest prio task
>  	if (task_rq(p) == rq) {
> -		deactivate_task(rq, p, 0);
> -		set_task_cpu(p, lowest_rq->cpu);
> -		activate_task(lowest_rq, p, 0);
> +		move_queued_task_locked(rq, lowest_rq, p);
>  		resched_curr(lowest_rq);
>  	}
>  
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index a04a436af8cc..eaedc69c5e30 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2443,9 +2443,7 @@ static int push_dl_task(struct rq *rq)
>  		goto retry;
>  	}
>  
> -	deactivate_task(rq, next_task, 0);
> -	set_task_cpu(next_task, later_rq->cpu);
> -	activate_task(later_rq, next_task, 0);
> +	move_queued_task_locked(rq, later_rq, next_task);
>  	ret = 1;
>  
>  	resched_curr(later_rq);
> @@ -2531,9 +2529,7 @@ static void pull_dl_task(struct rq *this_rq)
>  			if (is_migration_disabled(p)) {
>  				push_task = get_push_task(src_rq);
>  			} else {
> -				deactivate_task(src_rq, p, 0);
> -				set_task_cpu(p, this_cpu);
> -				activate_task(this_rq, p, 0);
> +				move_queued_task_locked(src_rq, this_rq, p);
>  				dmin = p->dl.deadline;
>  				resched = true;
>  			}
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 3261b067b67e..975cb49a64dc 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2106,9 +2106,7 @@ static int push_rt_task(struct rq *rq, bool pull)
>  		goto retry;
>  	}
>  
> -	deactivate_task(rq, next_task, 0);
> -	set_task_cpu(next_task, lowest_rq->cpu);
> -	activate_task(lowest_rq, next_task, 0);
> +	move_queued_task_locked(rq, lowest_rq, next_task);
>  	resched_curr(lowest_rq);
>  	ret = 1;
>  
> @@ -2379,9 +2377,7 @@ static void pull_rt_task(struct rq *this_rq)
>  			if (is_migration_disabled(p)) {
>  				push_task = get_push_task(src_rq);
>  			} else {
> -				deactivate_task(src_rq, p, 0);
> -				set_task_cpu(p, this_cpu);
> -				activate_task(this_rq, p, 0);
> +				move_queued_task_locked(src_rq, this_rq, p);
>  				resched = true;
>  			}
>  			/*
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index ae50f212775e..2d41ebe200c7 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3480,5 +3480,16 @@ static inline void init_sched_mm_cid(struct task_struct *t) { }
>  
>  extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
>  extern int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se);
> +#ifdef CONFIG_SMP
> +static inline
> +void move_queued_task_locked(struct rq *rq, struct rq *dst_rq, struct task_struct *task)
> +{
> +	lockdep_assert_rq_held(rq);
> +	lockdep_assert_rq_held(dst_rq);
> +	deactivate_task(rq, task, 0);
> +	set_task_cpu(task, dst_rq->cpu);
> +	activate_task(dst_rq, task, 0);
> +}
> +#endif

I see this pattern in __migrate_swap_task() and try_steal_cookie(), should they
be converted to?

Beside this

Reviewed-by: Qais Yousef <qyousef@layalina.io>

>  
>  #endif /* _KERNEL_SCHED_SCHED_H */
> -- 
> 2.45.0.rc1.225.g2a3ae87e7f-goog
> 

