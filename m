Return-Path: <linux-kernel+bounces-200707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DFC8FB3CA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCCC32893CE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EE5146A9D;
	Tue,  4 Jun 2024 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="LSZqRd7K"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12762146A87
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507756; cv=none; b=j3WOpIXWOtRF/M8BhN5MiyjhcX+oml6qPLirIN9mrrL6xc4XTTlGc2nHc0VQgUVN/PEuibyrZ/E+IQjqQUz99rmtA/kC8CAWpNmCm/U5qT4fOe0tmIetha3nZO1N+ofg+/pAZUGB3RqPieUVZzvMmGUELSB8nJdrgCjo5nKp2XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507756; c=relaxed/simple;
	bh=SgPEpS+MqulS2tsTeKftzbR4Z9uYwx6KnXBdOcorlVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k66m90k+fo/HbV9UTVLvbZuCs4aDlp2XljlMs5Y+2m6OTBlILcrRDcjJPZOapDiDknSnTp5ppt1CLF9bzwS6boR2AIMdYY4k4wUwNiAG3RUhQsliHFro0ByIbUg666zksXNVQuDeDfAafrmb9YSDlAXRSrnsNJCt/pK6GclsRVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=LSZqRd7K; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e78fe9fc2bso78446891fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 06:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1717507752; x=1718112552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LYcvAoRebzfM9FUzxsxh5Z/gVBI6ElMARHyhZH9mzfE=;
        b=LSZqRd7KnKQ0KqUQhwovCqMSI8cN5V4yvNfL53RiCsfavKHWRxTHVEJWxA0BWOt6IP
         wkKqcl8LyYyePtojLcDfys3xwvXJiR4zcgHazh38lKgUFJ6ZT8juzuzuad7R4cPdBeuP
         CPJhM8ata5GngeOMg3sscMaAAQujANhovW0kGvixnvrXXRmwU6D6kkY5Lxdjavzmp0Hu
         QYA7xadztQWLRqOz/+NdJR4TBqenEdWZap/a1+ikVG1eJBvC1Mdn50yDmemR+yZjJQQk
         GkdII7ULp0Dmql0aNKtpXArUSDZADEF7QTQOcunn6yLsn8bHtniH/IFMwBojZcgHxG0o
         JPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717507752; x=1718112552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYcvAoRebzfM9FUzxsxh5Z/gVBI6ElMARHyhZH9mzfE=;
        b=Zc60RVYsWC5msnRjHustoQ8D0dMBeeObJxIlzuvdnKeihogM8BE/f+ciE6lRTB0jLr
         /J5ioZvpccEa0sA+vHaCbxk9svborqltUuYMJHHHuvfLv9Z09AXfyQL/lEHdBq3Qe+Hp
         PVDvAN+K8Jjze/FisvfbpeTD56ESnMuNMZoCl3Q3gU3xHjF3foypEp9NEX20khF0S1B2
         eCjm1+3xrgQ6Bz+17X+jUqw60aRRD9/5gj5WUJK3KnxzkK8gTfosAwovCRQyRBlKH/c9
         DnqFbF9uVmwgi0LNlG39DQce+88gB+CpFvH9LJ9b+x/X/yTyLRua7byyjqxdDInCiDrQ
         8vlA==
X-Gm-Message-State: AOJu0Yyj3zA/14+8n2lTXy2diUiJODZmgibS5AiDIYN/5ipy6eNBuQcc
	87gq+VT01C+sTm/0hQC88Pl0RLrIGfVtde+Klditga7WfaljQGZl8V4wsOjPj/E=
X-Google-Smtp-Source: AGHT+IG1yK8wXIXSAc2Qu3UHK/1E9kX1vDVgIa52aITlUems1356uTU03d8TKCib/yzRBp8myJ5VCA==
X-Received: by 2002:a2e:9acd:0:b0:2e7:bc7:b6ea with SMTP id 38308e7fff4ca-2ea9512afdfmr76112151fa.14.1717507752012;
        Tue, 04 Jun 2024 06:29:12 -0700 (PDT)
Received: from airbuntu ([87.127.96.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04d9c73sm11632280f8f.58.2024.06.04.06.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 06:29:11 -0700 (PDT)
Date: Tue, 4 Jun 2024 14:29:10 +0100
From: Qais Yousef <qyousef@layalina.io>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>,
	Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [PATCH v10 6/7] sched: Split out __schedule() deactivate task
 logic into a helper
Message-ID: <20240604132910.25pgz3mjrnnwitve@airbuntu>
References: <20240507045450.895430-1-jstultz@google.com>
 <20240507045450.895430-7-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240507045450.895430-7-jstultz@google.com>

On 05/06/24 21:54, John Stultz wrote:
> As we're going to re-use the deactivation logic,
> split it into a helper.
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
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
> v6:
> * Define function as static to avoid "no previous prototype"
>   warnings as Reported-by: kernel test robot <lkp@intel.com>
> v7:
> * Rename state task_state to be more clear, as suggested by
>   Metin Kaya
> ---
>  kernel/sched/core.c | 72 +++++++++++++++++++++++++++------------------
>  1 file changed, 43 insertions(+), 29 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 48f0d4b381d5..8bc5844ebab9 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6572,6 +6572,48 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  # define SM_MASK_PREEMPT	SM_PREEMPT
>  #endif
>  
> +/*
> + * Helper function for __schedule()
> + *
> + * If a task does not have signals pending, deactivate it and return true
> + * Otherwise marks the task's __state as RUNNING and returns false
> + */
> +static bool try_to_deactivate_task(struct rq *rq, struct task_struct *p,
> +				   unsigned long task_state)
> +{
> +	if (signal_pending_state(task_state, p)) {
> +		WRITE_ONCE(p->__state, TASK_RUNNING);

We can avoid extra indention for the other (lengthy) leg if we return here?

The return value is ignored for now, I don't mind keeping it but better call it
out in the commit message or when you add the new user later you can update the
signature more easily.

Generally I think patches 4, 5 and 6 could be sent as their own series with
minor commit messages tweaks to make them more independent and I hope Ingo and
Peter are okay to pick them up as they look a nice clean up in general.

Anyway:

Reviewed-by: Qais Yousef <qyousef@layalina.io>

> +	} else {
> +		p->sched_contributes_to_load =
> +			(task_state & TASK_UNINTERRUPTIBLE) &&
> +			!(task_state & TASK_NOLOAD) &&
> +			!(task_state & TASK_FROZEN);
> +
> +		if (p->sched_contributes_to_load)
> +			rq->nr_uninterruptible++;
> +
> +		/*
> +		 * __schedule()			ttwu()
> +		 *   prev_state = prev->state;    if (p->on_rq && ...)
> +		 *   if (prev_state)		    goto out;
> +		 *     p->on_rq = 0;		  smp_acquire__after_ctrl_dep();
> +		 *				  p->state = TASK_WAKING
> +		 *
> +		 * Where __schedule() and ttwu() have matching control dependencies.
> +		 *
> +		 * After this, schedule() must not care about p->state any more.
> +		 */
> +		deactivate_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
> +
> +		if (p->in_iowait) {
> +			atomic_inc(&rq->nr_iowait);
> +			delayacct_blkio_start();
> +		}
> +		return true;
> +	}
> +	return false;
> +}
> +
>  /*
>   * __schedule() is the main scheduler function.
>   *
> @@ -6665,35 +6707,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>  	 */
>  	prev_state = READ_ONCE(prev->__state);
>  	if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
> -		if (signal_pending_state(prev_state, prev)) {
> -			WRITE_ONCE(prev->__state, TASK_RUNNING);
> -		} else {
> -			prev->sched_contributes_to_load =
> -				(prev_state & TASK_UNINTERRUPTIBLE) &&
> -				!(prev_state & TASK_NOLOAD) &&
> -				!(prev_state & TASK_FROZEN);
> -
> -			if (prev->sched_contributes_to_load)
> -				rq->nr_uninterruptible++;
> -
> -			/*
> -			 * __schedule()			ttwu()
> -			 *   prev_state = prev->state;    if (p->on_rq && ...)
> -			 *   if (prev_state)		    goto out;
> -			 *     p->on_rq = 0;		  smp_acquire__after_ctrl_dep();
> -			 *				  p->state = TASK_WAKING
> -			 *
> -			 * Where __schedule() and ttwu() have matching control dependencies.
> -			 *
> -			 * After this, schedule() must not care about p->state any more.
> -			 */
> -			deactivate_task(rq, prev, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
> -
> -			if (prev->in_iowait) {
> -				atomic_inc(&rq->nr_iowait);
> -				delayacct_blkio_start();
> -			}
> -		}
> +		try_to_deactivate_task(rq, prev, prev_state);
>  		switch_count = &prev->nvcsw;
>  	}
>  
> -- 
> 2.45.0.rc1.225.g2a3ae87e7f-goog
> 

