Return-Path: <linux-kernel+bounces-543631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14612A4D7AE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317631646E5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E976E1F4CB0;
	Tue,  4 Mar 2025 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8Snu2zC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6293823B0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741079775; cv=none; b=BSNwN8QxFGujMSZo9sGi5QBrPfSwuZ9/pflkDj46YwIXyxfpLkAPDqrP6EQ8Otghr5+Vv8AVyvRR74wHNSAioWwnwM5yYjobw8JcLiM6id4rcTd03FDG0nN3jJVZAlCHapNdbA6k+m/ingJORnIWphHrI3Q8djFtwLdGSKSCyLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741079775; c=relaxed/simple;
	bh=fzMnd7M6rwCyOtB8q34CUuM6FNDauTxpaDL9Z6xCCYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJMks9OzYPuANFITbqAZCt6fWT7TbHxkuU5x70kcvow3LZ2LaC7H0/QGz5WimO7sVi2+UqKS8iIINxOXnBcERXeOzdO+mw6jp8RFyTWodIzpDPvi2uMrPcltojcVJ/at0XdBg3rJsEVs8D1wcaI4NiFxxnQG82XBDEfDizHpj1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e8Snu2zC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741079772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=twbfMmYGP3kHV1qPJcf6r3dyxEQU/j00LNN32qJ4mH4=;
	b=e8Snu2zCbQ4yb9eapmEZNo3w+kFhjzaxjHc8JW01xlyHBUR7xIfkJxZr2qCsUfTWyj8N+H
	IVmZ6d6XkMI7vqMFdxI7ii2SBUDhHUlMqsYSN5r+E5kssRQzzK3HaA7ulXx00op27evvqM
	AlPNRF5nlm2sbJ6pQLu72EFfEjPogIo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-kRKi8jfLM5qSvaIjwVAklQ-1; Tue, 04 Mar 2025 04:16:06 -0500
X-MC-Unique: kRKi8jfLM5qSvaIjwVAklQ-1
X-Mimecast-MFC-AGG-ID: kRKi8jfLM5qSvaIjwVAklQ_1741079765
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7bb849aa5fbso1480411585a.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 01:16:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741079763; x=1741684563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twbfMmYGP3kHV1qPJcf6r3dyxEQU/j00LNN32qJ4mH4=;
        b=Z5SZNyvloC9nGGdgVxMZ47OqNx/kMSS3DPAUC5oRyhGGDJ/BMhNYKAwHrqxzxSicFl
         h5LtNGYLhtGHJxv52nWYzzaXVh3JtDoR+HK+iXvGLd5gA+PrKMOoLa2CWRg1My1r9wpY
         Oy1XbqmDBo1biwJvsWSB9NqpSdtrBjdPAErU2PwUuOj+DHG4acdT+icV/SsoIzVcpljy
         wGtcYFFZBmCRbLwoz9KrrQw6dM0oVqwhgZfMJIEy0+Q2C/uhuQ2/nfJbGWB1MSLtT7O2
         BFm1+7F6mZXLnOAxs1J/gGRyztoF/sDRQGdUqym9oiwdorY0h0ERHS8a71+BJBsVF7lH
         K1EA==
X-Forwarded-Encrypted: i=1; AJvYcCVUi12TnKv7TByiwwQDu2MVhYa3NTLyo4vUmp3VjfAsOC+pt1fLrix21cVITLItoIMexSIR96KKgzYNzjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQvYMu47VEhRU1aaA4+lSTDF/f4UlUxa4/RmzHiwTsnsQcyn5Q
	AD8MhPkZaMlibmuR9bdgRHgV96XNR2zsUjm8TbxfMtvyncYhButiEt4M1djbSHyQw8VNhuOnb91
	3gfovDEq+otuaUVyrXnSeL4kpKa9+Cla87wWCW3J7Jo9Ivwd9hyxajlRVn4e02m19fZz26c2b
X-Gm-Gg: ASbGncs2+40PgFhytp1gMJ3vvJaUoicCG0vgPO9qWtzt26WhVOzvvwq7G4Fa5VuqBUf
	+xO01zNKstMpkHrjsye2Xiv1Xm0cFy8XcyKvN70gROx1BSFCS1be0PoBNW9gKVyt3o4SSnwvWa2
	U+Gb6RrjBckZwBSAtJa1YbjA+L3PdIFSee0faEuz32GC1cE71KeGasQrX9etxSAIipRq8ow9Jy4
	QZlPBCEAnP49B3SN4ytwcYnpJ6Ez2UjlYwmi+e649aqd+PkA2Vj2k5AmA7pQ6fzYVW3YtIgfSnK
	dUOxs9B1Sa0BpE7WLlSLO4DMSLxAj31wNg30StXaICueXMROfY1ESbavgS+bb1A1EzVhA6C+psy
	vkzDS
X-Received: by 2002:a05:620a:3902:b0:7c0:6419:8bd3 with SMTP id af79cd13be357-7c39c4b678bmr2271034385a.22.1741079761453;
        Tue, 04 Mar 2025 01:16:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHENlR8nCjhV94d1R8ys7ThN2NQzinSvDAG1fi5LyI/AFJRlI8nAiJwrzKnAO3Hrp6y5e7WgQ==
X-Received: by 2002:a05:620a:3902:b0:7c0:6419:8bd3 with SMTP id af79cd13be357-7c39c4b678bmr2271031685a.22.1741079761188;
        Tue, 04 Mar 2025 01:16:01 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3d30cc5fdsm18304985a.72.2025.03.04.01.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 01:16:00 -0800 (PST)
Date: Tue, 4 Mar 2025 09:15:55 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Harshit Agarwal <harshit@nutanix.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, Jon Kohler <jon@nutanix.com>,
	Gauri Patwardhan <gauri.patwardhan@nutanix.com>,
	Rahul Chunduru <rahul.chunduru@nutanix.com>,
	Will Ton <william.ton@nutanix.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3] sched/rt: Fix race in push_rt_task
Message-ID: <Z8bEyxZCf8Y_JReR@jlelli-thinkpadt14gen4.remote.csb>
References: <20250225180553.167995-1-harshit@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225180553.167995-1-harshit@nutanix.com>

Hi Harshit,

On 25/02/25 18:05, Harshit Agarwal wrote:
> Overview
> ========
> When a CPU chooses to call push_rt_task and picks a task to push to
> another CPU's runqueue then it will call find_lock_lowest_rq method
> which would take a double lock on both CPUs' runqueues. If one of the
> locks aren't readily available, it may lead to dropping the current
> runqueue lock and reacquiring both the locks at once. During this window
> it is possible that the task is already migrated and is running on some
> other CPU. These cases are already handled. However, if the task is
> migrated and has already been executed and another CPU is now trying to
> wake it up (ttwu) such that it is queued again on the runqeue
> (on_rq is 1) and also if the task was run by the same CPU, then the
> current checks will pass even though the task was migrated out and is no
> longer in the pushable tasks list.

...

> ---
>  kernel/sched/rt.c | 54 +++++++++++++++++++++++------------------------
>  1 file changed, 26 insertions(+), 28 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 4b8e33c615b1..4762dd3f50c5 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1885,6 +1885,27 @@ static int find_lowest_rq(struct task_struct *task)
>  	return -1;
>  }
>  
> +static struct task_struct *pick_next_pushable_task(struct rq *rq)
> +{
> +	struct task_struct *p;
> +
> +	if (!has_pushable_tasks(rq))
> +		return NULL;
> +
> +	p = plist_first_entry(&rq->rt.pushable_tasks,
> +			      struct task_struct, pushable_tasks);
> +
> +	BUG_ON(rq->cpu != task_cpu(p));
> +	BUG_ON(task_current(rq, p));
> +	BUG_ON(task_current_donor(rq, p));
> +	BUG_ON(p->nr_cpus_allowed <= 1);
> +
> +	BUG_ON(!task_on_rq_queued(p));
> +	BUG_ON(!rt_task(p));
> +
> +	return p;
> +}
> +
>  /* Will lock the rq it finds */
>  static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>  {
> @@ -1915,18 +1936,16 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>  			/*
>  			 * We had to unlock the run queue. In
>  			 * the mean time, task could have
> -			 * migrated already or had its affinity changed.
> -			 * Also make sure that it wasn't scheduled on its rq.
> +			 * migrated already or had its affinity changed,
> +			 * therefore check if the task is still at the
> +			 * head of the pushable tasks list.
>  			 * It is possible the task was scheduled, set
>  			 * "migrate_disabled" and then got preempted, so we must
>  			 * check the task migration disable flag here too.
>  			 */
> -			if (unlikely(task_rq(task) != rq ||
> +			if (unlikely(is_migration_disabled(task) ||
>  				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
> -				     task_on_cpu(rq, task) ||
> -				     !rt_task(task) ||
> -				     is_migration_disabled(task) ||
> -				     !task_on_rq_queued(task))) {
> +				     task != pick_next_pushable_task(rq))) {
>  
>  				double_unlock_balance(rq, lowest_rq);
>  				lowest_rq = NULL;
> @@ -1946,27 +1965,6 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>  	return lowest_rq;
>  }
>  
> -static struct task_struct *pick_next_pushable_task(struct rq *rq)
> -{
> -	struct task_struct *p;
> -
> -	if (!has_pushable_tasks(rq))
> -		return NULL;
> -
> -	p = plist_first_entry(&rq->rt.pushable_tasks,
> -			      struct task_struct, pushable_tasks);
> -
> -	BUG_ON(rq->cpu != task_cpu(p));
> -	BUG_ON(task_current(rq, p));
> -	BUG_ON(task_current_donor(rq, p));
> -	BUG_ON(p->nr_cpus_allowed <= 1);
> -
> -	BUG_ON(!task_on_rq_queued(p));
> -	BUG_ON(!rt_task(p));
> -
> -	return p;
> -}
> -

As usual, we have essentially the same in deadline.c, do you think we
should/could implement the same fix proactively in there as well? Steve?

Thanks,
Juri


