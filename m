Return-Path: <linux-kernel+bounces-281282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A03CE94D515
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5664C285BF8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF7D3C6BA;
	Fri,  9 Aug 2024 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqDyiEmd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DBD14F70
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723222418; cv=none; b=VnqW+b6XptASm6J5PaAVqI+6vNwoXg2Mc9VgwxR/WM67zn8qaLmxN4sJXW9J9j2b41RQlYBdBsAl8sEy8d+4OJcPHnNwKOaUVy96yan6C5Z4kKyV2hDirJJqU3ZV60CdWxNjgboCtrbGO7+ahiXIMKZPdHpYwCIWlwm286RxWzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723222418; c=relaxed/simple;
	bh=Ot6pDchm1hxiXy4sOfaytvjIT4EULapO/lvEbV0ci1k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jJ2+xZFZp5M77wC+BzgPcy6HReIWE/HJpaImmel7GnBAYqXMZfyvZW2oa8dJGXuyG/BSMN1YQP7w7ZvHmU+iEhYDhXf/JoxCZlaYVkgLt3heU1hIvZ1kdm34FckKt+UjK/rn4BM838aA8iKbs6TjBMYZiLH6QKaZ3hGtzKIULiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eqDyiEmd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723222415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3gNM1Um+DBkxuDVxehFnpUWCFgg5MJ0B55Pe48VVIUY=;
	b=eqDyiEmdEv4j1cHCbcNR7AiRxFFHE/Fv6PzoBOJgY2IX5Kz1CG+S7l56j2T0hVS8Gp/Yor
	2XwZ+bTDMRfw/TULxRutRxmPt/FExw1UYX7qNTQdoJoU1FZQYXceaPNfp6mXZMaZ92g6yu
	+/w9dK9jl99lvt9G7YO93n+dvSPspRI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-BPXu2IyBPYSJ3iEiNvL3uA-1; Fri, 09 Aug 2024 12:53:33 -0400
X-MC-Unique: BPXu2IyBPYSJ3iEiNvL3uA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42816aacabcso15936355e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 09:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723222413; x=1723827213;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3gNM1Um+DBkxuDVxehFnpUWCFgg5MJ0B55Pe48VVIUY=;
        b=R0lIjMmUqXqD223fzi6sAOJgtyjqoutf3pi6oX0s+xIzcVQatUUZwsIR+G3TgsCSQa
         DJ1BgBovEh/I4K3wGFF8kAkRQQjGffqZ84sRO6KGv1ZL/lScgXkJazxxGJchobD4amvn
         zNxHhQeTeJePKrygCg403VGjwfUw61xTN+moXv0Us1jqdfIWEspgxxUsonpe4CaMLV8X
         3kCAdVdCL1CTFEYoK04v/xtHB7jnSNPbLocT9pFZMWQ2TGWqP8KZrwKsMyYWMDGIcJPU
         gQpK07fuEomu1Lj1/U523gHc2vcau7zYH/4LFO72M6993BmTtEhRjb85tpkhao6yX7SI
         3vww==
X-Forwarded-Encrypted: i=1; AJvYcCXaSdo98k7WJM4JwuteQSKenzmJhbymU8HazmXl4vcgdxOMAvx434tIa1EPABiduuRtKGQStLG/PK9IBW8wv+sy73994wJd8secZExe
X-Gm-Message-State: AOJu0Yzm0apaSRZdYWocBXjs3ghAy3qLWlb5zFHOg83B39LnJasN1Sor
	GHri46uG4afcHcNuu7gbxb/QHJ1KP5JyvrhTSRSwZIF5w14udfcB3S2u4e2CeQuUkIhkLZQ0RYA
	frMPMNJxBHKSVSmZQpuukE/gKREWHqJTct7LTBQUf6CtFTQI5NayI48ypg+BSEw==
X-Received: by 2002:a05:600c:4686:b0:426:6b92:387d with SMTP id 5b1f17b1804b1-429c3a2a820mr16062875e9.21.1723222412593;
        Fri, 09 Aug 2024 09:53:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZghwnwa2m2YAZo1XbIltaBf9u3WZiS+/fAODv6gjUee6eEHauw2dNVGuSHWkr+JsYbvwZ8Q==
X-Received: by 2002:a05:600c:4686:b0:426:6b92:387d with SMTP id 5b1f17b1804b1-429c3a2a820mr16062605e9.21.1723222412100;
        Fri, 09 Aug 2024 09:53:32 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c74a96bsm83750995e9.24.2024.08.09.09.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 09:53:31 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
 youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [PATCH 07/24] sched/fair: Re-organize dequeue_task_fair()
In-Reply-To: <20240727105028.977256873@infradead.org>
References: <20240727102732.960974693@infradead.org>
 <20240727105028.977256873@infradead.org>
Date: Fri, 09 Aug 2024 18:53:30 +0200
Message-ID: <xhsmhh6bty6wl.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 27/07/24 12:27, Peter Zijlstra wrote:
> Working towards delaying dequeue, notably also inside the hierachy,
> rework dequeue_task_fair() such that it can 'resume' an interrupted
> hierarchy walk.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/fair.c |   61 ++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 40 insertions(+), 21 deletions(-)
>
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6861,34 +6861,43 @@ enqueue_task_fair(struct rq *rq, struct
>  static void set_next_buddy(struct sched_entity *se);
>
>  /*
> - * The dequeue_task method is called before nr_running is
> - * decreased. We remove the task from the rbtree and
> - * update the fair scheduling stats:
> + * Basically dequeue_task_fair(), except it can deal with dequeue_entity()
> + * failing half-way through and resume the dequeue later.
> + *
> + * Returns:
> + * -1 - dequeue delayed
> + *  0 - dequeue throttled
> + *  1 - dequeue complete
>   */
> -static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> +static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
>  {
> -	struct cfs_rq *cfs_rq;
> -	struct sched_entity *se = &p->se;
> -	int task_sleep = flags & DEQUEUE_SLEEP;
> -	int idle_h_nr_running = task_has_idle_policy(p);
>       bool was_sched_idle = sched_idle_rq(rq);
>       int rq_h_nr_running = rq->cfs.h_nr_running;
> +	bool task_sleep = flags & DEQUEUE_SLEEP;
> +	struct task_struct *p = NULL;
> +	int idle_h_nr_running = 0;
> +	int h_nr_running = 0;
> +	struct cfs_rq *cfs_rq;
>
> -	util_est_dequeue(&rq->cfs, p);
> +	if (entity_is_task(se)) {
> +		p = task_of(se);
> +		h_nr_running = 1;
> +		idle_h_nr_running = task_has_idle_policy(p);
> +	}
>

This leaves the *h_nr_running to 0 for non-task entities. IIUC this makes
sense for ->sched_delayed entities (they should be empty of tasks), not so
sure for the other case. However, this only ends up being used for non-task
entities in:
- pick_next_entity(), if se->sched_delayed
- unregister_fair_sched_group()

IIRC unregister_fair_sched_group() can only happen after the group has been
drained, so it would then indeed be empty of tasks, but I reckon this could
do with a comment/assert in dequeue_entities(), no? Or did I get too
confused by cgroups again?


