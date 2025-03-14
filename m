Return-Path: <linux-kernel+bounces-561353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF665A6105F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977AB189F5E2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C4A1FAC37;
	Fri, 14 Mar 2025 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NrEkyVFB"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EE81FCFE3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952867; cv=none; b=Xtz7ToQzbmwFxKDqAhUNw+YsAx3R3nkwAgpLXGZo0m4UoztQHEzl7640vAepEjz/aHTzi9w3q/DwZUWHT66u/bI6mTcBNrDRk5MFoJEej3SCwUGqfb4NJrPjV013U+BPdTsMUcIF4SBogQX7nRRuhMj8uv6jT/jfe8GHCHnZCRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952867; c=relaxed/simple;
	bh=VcH1gJZsSk1M7P5qO3V7YGMI1VV23snd5GSxLtSQt+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ofa0dRujFnViTN9H4+Wy1Whmn9sinVGJXkowo36gTDVtrakc88I1Xw6fpCqLsA82+YOeYobt1T3YEJadSCdUBodgOedn2bSeLzFcVBqNJnvXJUA4f3Vi6jbxq6Z51hPFkEJ4cTpU1e771Lysj8QpkKg5170Abp2LEbBnStFU2Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NrEkyVFB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-225e3002dffso5953085ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 04:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741952865; x=1742557665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KBiyROSgn5in4w+V/nHkLtYS4AWX4kvd2MsiWf5BEKo=;
        b=NrEkyVFBxP3SrP9/4xTnWJ5HkXr1Dpc8F8VvxU53QVW9lc6ctatFYthYA3uCiTCpDg
         3orOyIXeNy/cT0rJlWrQMTJAtXwLRznS7sHIdKbFAMz9S+Q82bfoKi1WpvBKOIDb4EhK
         ybNNisn48j5wazEJEE6DNV6wkRC31MWWe25SywJTFWB85AGLwOpty8jLdNzbX2MUdX1G
         ajM79JM46VrOe4v35Ylf6uxZmPp5fPv35k6w1qugPZZ60IWm3SRKnabDLSe8vrZGOKGm
         Jw1iwt2AvKPe+3qCA6p4zi5WvN89+J4iHRl/L5CI2Qrr6O8QSrs2To+Lglsz8J8kzfCX
         nwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741952865; x=1742557665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBiyROSgn5in4w+V/nHkLtYS4AWX4kvd2MsiWf5BEKo=;
        b=k5r8oFARhSJ4s6+8c0L3Put3JcAPd9KMFSc7Jg9PkASWrLSkM05gbBd0e9L3Q9r05N
         XC6jPCCXyPLnCsro3uDFhPCu4jtJ7oeyhi7poiR6umCUaWimRDjCE64JpRM1aPFiPRP7
         urfHp9p36QGeoWK5GomS4138b+POQ/jpCUTUWVbICjVjKEwp7vj2jbJpYAHzrBOnSy35
         Gx9oeSbGuAHiLmvCMuCu22X7/8CuYcndhFpGPbshgsJVmvALQxAwt/qvpOmUMNm6QDsI
         fL2EpyPvTYWZ/l+jB410GkKTWTLPwe453Mxyy+slqr3yMZSjUzWTPRNvmnCdT0zKEuyp
         aL1A==
X-Forwarded-Encrypted: i=1; AJvYcCV4CsCag97MEcSHmlMdIdx4ZyY2PMaKqVuZNVuQjjDcxZInCVee/0jBGEARYJaYgXApvLOZY9fibnV5iYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxClB1xDUQ5ajzVYXxE0ZUoSbKHULeCTp6zx7i/fhlqs0kh0gzd
	Nk4yLJH1/TnhlgotTNul7g7Tp/k9srI2p3J5bFFh9z/6kI15fRBiBixXQj2FKg==
X-Gm-Gg: ASbGnctcV94bz0jYC+IhPoPeqcMG4w9gCnTfBOgUp+q8YLbhE2QFfLuGJwlmQx6qP/P
	U8BBdP9c7xPJkMkvHruTO9Gm1xK2ZCzkgMqROdqmDtYTxSyeRZvrdn2bU5OCJ7Ujbb8Mpw0+8wx
	26NrjRV/tMJV+lBxGSQUxpFIb0I3f/cqCLR+DTyUwe83zOYeORccuobiEJVokNPzlKzyMUZICAR
	PNtuDvjiQnBywprxzz50nNzDwHJ5lHvpUGC5nfgy6E3+/otNGJygqlUqxEPKa0vN+OqpANa1M9p
	7Aw6AqWcFhikzznLfM/yI1v5dmhQEz0A65/5jcPjy4fJQAdUYpATLls=
X-Google-Smtp-Source: AGHT+IEA6I+cD8u5D7DCwEfRcYX1baJMT81AiWgbO9fZdfcNlp6paZd27IKiwVrqDTI+gl70IW25UQ==
X-Received: by 2002:a05:6a00:1ace:b0:736:4e67:d631 with SMTP id d2e1a72fcca58-73722453e49mr2990038b3a.23.1741952864931;
        Fri, 14 Mar 2025 04:47:44 -0700 (PDT)
Received: from bytedance ([115.190.40.14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9ccb0csm2616449a12.2.2025.03.14.04.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 04:47:44 -0700 (PDT)
Date: Fri, 14 Mar 2025 19:47:38 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Chengming Zhou <chengming.zhou@linux.dev>,
	Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: Re: [RFC PATCH 2/7] sched/fair: Handle throttle path for task based
 throttle
Message-ID: <20250314114738.GI1633113@bytedance>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0GcFF7cnR4rCbU5MmY1Gq3M+r4gPXv39QPXXC=Cdr6sRww@mail.gmail.com>
 <58e0515a-ed67-4d1a-825f-bfc2b31d1d18@linux.dev>
 <20250314094249.GC1633113@bytedance>
 <6688eade-8eec-4d76-87f2-637425b1c2d2@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6688eade-8eec-4d76-87f2-637425b1c2d2@amd.com>

Hi Prateek,

On Fri, Mar 14, 2025 at 03:56:26PM +0530, K Prateek Nayak wrote:
> Hello Aaron,
> 
> On 3/14/2025 3:12 PM, Aaron Lu wrote:
> > > Then then if we pick a task from a throttled cfs_rq subtree, we can setup task work
> > > for it, so we don't botter with the delayed_dequeue task case that Prateek mentioned.
> > If we add a check point in pick time, maybe we can also avoid the check
> > in enqueue time. One thing I'm thinking is, for a task, it may be picked
> > multiple times with only a single enqueue so if we do the check in pick,
> > the overhead can be larger?
> 
> I think it can be minimized to a good extent. Something like:

I see, thanks for the illustration.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d646451d617c..ba6571368840 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5942,6 +5942,9 @@ static inline bool task_has_throttle_work(struct task_struct *p)
>  static inline void task_throttle_setup_work(struct task_struct *p)
>  {
> +	if (task_has_throttle_work(p))
> +		return;
> +
>  	/*
>  	 * Kthreads and exiting tasks don't return to userspace, so adding the
>  	 * work is pointless
> @@ -5949,9 +5952,6 @@ static inline void task_throttle_setup_work(struct task_struct *p)
>  	if ((p->flags & (PF_EXITING | PF_KTHREAD)))
>  		return;
> -	if (task_has_throttle_work(p))
> -		return;
> -
>  	task_work_add(p, &p->sched_throttle_work, TWA_RESUME);
>  }
> @@ -6000,12 +6000,6 @@ static int tg_throttle_down(struct task_group *tg, void *data)
>  		node = rb_next(node);
>  	}
> -	/* curr is not in the timeline tree */
> -	if (cfs_rq->curr && entity_is_task(cfs_rq->curr)) {
> -		p = task_of(cfs_rq->curr);
> -		task_throttle_setup_work(p);
> -	}
> -

Should we also remove adding throttle work for those tasks in
cfs_rq->tasks_timeline?

>  	return 0;
>  }
> @@ -6049,6 +6043,18 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
>  	SCHED_WARN_ON(cfs_rq->throttled_clock);
>  	if (cfs_rq->nr_queued)
>  		cfs_rq->throttled_clock = rq_clock(rq);
> +
> +	/*
> +	 * If cfs_rq->curr is set, check if current task is queued
> +	 * and set up the throttle work proactively.
> +	 */
> +	if (cfs_rq->curr) {
> +		struct task_struct *p = rq->donor; /* scheduling context with proxy */

I'll have to check what rq->donor means.
I think the point is to proactively add throttle work for rq->curr if
rq->curr is in this throttled hierarchy? Because the only check point to
add throttle work will be at pick time and curr will probably not be
picked anytime soon.

Thanks,
Aaron

> +
> +		if (task_on_rq_queued(p))
> +			task_throttle_setup_work(p);
> +	}
> +
>  	return;
>  }
> @@ -8938,6 +8944,13 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
>  		struct sched_entity *pse = &prev->se;
>  		struct cfs_rq *cfs_rq;
> +		/*
> +		 * Check if throttle work needs to be setup when
> +		 * switching to a different task.
> +		 */
> +		if (throttled_hierarchy(cfs_rq_of(se)))
> +			task_throttle_setup_work(p);
> +
>  		while (!(cfs_rq = is_same_group(se, pse))) {
>  			int se_depth = se->depth;
>  			int pse_depth = pse->depth;
> @@ -13340,6 +13353,9 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
>  		account_cfs_rq_runtime(cfs_rq, 0);
>  	}
> +	if (throttled_hierarchy(cfs_rq_of(se)))
> +		task_throttle_setup_work(p);
> +
>  	__set_next_task_fair(rq, p, first);
>  }
> --
> 
> .. with the additional plumbing in place of course.
> 
> -- 
> Thanks and Regards,
> Prateek
> 

