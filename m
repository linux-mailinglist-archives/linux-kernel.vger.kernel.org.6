Return-Path: <linux-kernel+bounces-200689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F16A08FB35C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41B528638F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E2F146A7B;
	Tue,  4 Jun 2024 13:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="SauHD4QZ"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C490146591
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507144; cv=none; b=NIW80EVHMdCWus74ITbSiEDYMaNwLDZL+J26/SnOg0lhP3Pi+CsEmSxmD8af0vs3rmdpt4zOsKW5pxNQaEFwW7x7eu+7d0+wuSodReOgWMLNS4enk5ZXD8Ht7fkJbjj7NIZweOZii1XjfOallkRUPT7E5nCBYovcE5KE9LYgJFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507144; c=relaxed/simple;
	bh=QN1KDvDgCHEjnwbsi4eIwg+D7sd+cKlvp5Dpqb5+VW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXfOGyG34II+GJ44BXZ0vRkVbFXMxoCAftHaPjM/p2yRtzGGzGo8aRZgToN6Yi+KmhKW7rcnEsPhDSd6Xp0FZOC/1R5pz6rczoyduJgtyWUxAe6IrJ0PLJoOAEbyfya6y5EoCroQRfka+lnQPO0sCXDhft3UgD/X0xnXjrCpf3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=SauHD4QZ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-35e0eb3efd0so930241f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 06:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1717507141; x=1718111941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A4I5mVWcncdsUtwv83ZbQ60TOwO6vb1IJQtGWULCteA=;
        b=SauHD4QZ+zgLhbx3J2B0Z5QbO5dWRUT7mbINKCWSmvGVhTNqnVD5R4EWvX1Ufwg45G
         L9lWeFL4TsWlnnHYzrmvJDnfUwBxHqQzWZa/BV5tGtiA3wTgAcXQdQYuF103NdM6wGrj
         ysxI8PD8FK9CRBpoq95/BjnFDAPGCjMBQo6us2mGDTr7Rvfgrjdwh8O2Q7bR/WTlUyC3
         WMuo7RLPwca7AuTKAChRFmwDrMQ+pWvhNkS0vKke11xuBj6+75aB9vMLj53Z1RzfsqiL
         Cd0Hp73kznh2G5zsxiyjgck1n2JRzNr+Kmlks2L7siRcofCCDBmwjRZOgfmAbKSBLaz3
         m+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717507141; x=1718111941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4I5mVWcncdsUtwv83ZbQ60TOwO6vb1IJQtGWULCteA=;
        b=QP1tAxJczEv/PBwmZ9uXKeWZ6F1TeQavv5fIAk98rkHqmpa3ZofRILl5z82bsguWXN
         4dp011YnD70ndrGreZG2tang/bytx9jeTvr6EQE1qoDiatR4n1gbiE80kXkU59woHdXr
         HMHPVFvGXeikpIsTOo/b6LxFJiCNxwIz8r0yOJOls58NBPmT9jhafqBMy3ypfymsDNFX
         jOlXgh1samH4K5imcbMQIB71yiCUpORXQ0T2Vh0WpL3f14J+3AenZN2IxKRfKp0SVwBr
         WJjxqEgBhfkGdw+e9iTBJQPuov12ZeiWKGxyfZRLjJRAvu1Z55WDxlQfc7WNfs011Q/V
         ugbw==
X-Gm-Message-State: AOJu0YxpwssxIJIKpO7ccYEh5UvQKQguAQ7gu1od/NnDRtHda0HPCehV
	KbElaGZS9v8C5GYiYJynM9JNN2FxB6g8bK+KEmMNt6NwvXeIXiJqda/1UAwOuZw=
X-Google-Smtp-Source: AGHT+IGUEs8rfya5EAPjqdiPQVQizs+L/+eY8JEtTGn7YcUhHmvmbI/TxqOjQFeSaEwtEPohKB9IMw==
X-Received: by 2002:a05:6000:8c:b0:35d:c375:1586 with SMTP id ffacd0b85a97d-35e0f25a676mr7918399f8f.8.1717507140831;
        Tue, 04 Jun 2024 06:19:00 -0700 (PDT)
Received: from airbuntu ([87.127.96.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd062ea66sm11541993f8f.78.2024.06.04.06.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 06:19:00 -0700 (PDT)
Date: Tue, 4 Jun 2024 14:18:56 +0100
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
Subject: Re: [PATCH v10 5/7] sched: Consolidate pick_*_task to
 task_is_pushable helper
Message-ID: <20240604131856.xo6jxe2geetq6jlg@airbuntu>
References: <20240507045450.895430-1-jstultz@google.com>
 <20240507045450.895430-6-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240507045450.895430-6-jstultz@google.com>

On 05/06/24 21:54, John Stultz wrote:
> From: Connor O'Brien <connoro@google.com>
> 
> This patch consolidates rt and deadline pick_*_task functions to
> a task_is_pushable() helper
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
> [jstultz: split out from larger chain migration patch,
>  renamed helper function]
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
> v7:
> * Split from chain migration patch
> * Renamed function
> ---
>  kernel/sched/deadline.c | 10 +---------
>  kernel/sched/rt.c       | 11 +----------
>  kernel/sched/sched.h    | 10 ++++++++++
>  3 files changed, 12 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index eaedc69c5e30..ae583a427539 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2179,14 +2179,6 @@ static void task_fork_dl(struct task_struct *p)
>  /* Only try algorithms three times */
>  #define DL_MAX_TRIES 3
>  
> -static int pick_dl_task(struct rq *rq, struct task_struct *p, int cpu)
> -{
> -	if (!task_on_cpu(rq, p) &&
> -	    cpumask_test_cpu(cpu, &p->cpus_mask))
> -		return 1;
> -	return 0;
> -}
> -
>  /*
>   * Return the earliest pushable rq's task, which is suitable to be executed
>   * on the CPU, NULL otherwise:
> @@ -2205,7 +2197,7 @@ static struct task_struct *pick_earliest_pushable_dl_task(struct rq *rq, int cpu
>  	if (next_node) {
>  		p = __node_2_pdl(next_node);
>  
> -		if (pick_dl_task(rq, p, cpu))
> +		if (task_is_pushable(rq, p, cpu) == 1)

Any reason we're checking specifically for == 1? Could the function later
return something other than 0 or 1?

It's explaining if 1 could end up meaning something else in the commit message
and in function docs. Otherwise let's make it a bool and not do explicit check
for return value.

With this

Reviewed-by: Qais Yousef <qyousef@layalina.io>

>  			return p;
>  
>  		next_node = rb_next(next_node);
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 975cb49a64dc..8b6fb77e095b 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1791,15 +1791,6 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
>  /* Only try algorithms three times */
>  #define RT_MAX_TRIES 3
>  
> -static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
> -{
> -	if (!task_on_cpu(rq, p) &&
> -	    cpumask_test_cpu(cpu, &p->cpus_mask))
> -		return 1;
> -
> -	return 0;
> -}
> -
>  /*
>   * Return the highest pushable rq's task, which is suitable to be executed
>   * on the CPU, NULL otherwise
> @@ -1813,7 +1804,7 @@ static struct task_struct *pick_highest_pushable_task(struct rq *rq, int cpu)
>  		return NULL;
>  
>  	plist_for_each_entry(p, head, pushable_tasks) {
> -		if (pick_rt_task(rq, p, cpu))
> +		if (task_is_pushable(rq, p, cpu) == 1)
>  			return p;
>  	}
>  
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 2d41ebe200c7..e46f69ba9ba2 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3490,6 +3490,16 @@ void move_queued_task_locked(struct rq *rq, struct rq *dst_rq, struct task_struc
>  	set_task_cpu(task, dst_rq->cpu);
>  	activate_task(dst_rq, task, 0);
>  }
> +
> +static inline
> +int task_is_pushable(struct rq *rq, struct task_struct *p, int cpu)
> +{
> +	if (!task_on_cpu(rq, p) &&
> +	    cpumask_test_cpu(cpu, &p->cpus_mask))
> +		return 1;
> +
> +	return 0;
> +}
>  #endif
>  
>  #endif /* _KERNEL_SCHED_SCHED_H */
> -- 
> 2.45.0.rc1.225.g2a3ae87e7f-goog
> 

