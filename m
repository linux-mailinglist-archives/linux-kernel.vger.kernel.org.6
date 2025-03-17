Return-Path: <linux-kernel+bounces-563371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E29A64025
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5DD17A6978
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 05:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409D921884A;
	Mon, 17 Mar 2025 05:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TedKtWJC"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE6A19E99E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 05:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742190549; cv=none; b=bE5xn0lVy3ecMqomvsSEhWq33JCeMA+dXonU1H1RuQbXeVnMj2FLjFcFMQHC5ZNB8ot6BDkljiX45Fj3q2pCnZRyZFu5AoL3ATdwNC4C6JQas9IkvGqwno/GxYKq96My7xGQDXKBzuphkQY+YSLcGEQ8S6kqQznH/YRKVMnftHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742190549; c=relaxed/simple;
	bh=b4ET+kmStg4kYp97gsva7ZKtE4llSQn+wBVk4iJUuCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2yBrwA/QdyuxT1yd/M7ZkBcV8drNjtxKgRBE3fQ8rboujbJR2g0Ed5YMn5bMrFSDtF27bGA4SV2YpPYOM8BL1I/Jan9aTKm+x31zD0fSqh6rWInY34Ht80g8Ocf5vFdhnbFCdfN7GWafE3XUPOUe/60pSM8iAYX3DHfVEoqIkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TedKtWJC; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff694d2d4dso1916818a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 22:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1742190546; x=1742795346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TKXW11VtaMuobC163bGqLeavsNh8UtgyJ54q+fYvbSw=;
        b=TedKtWJC5w1iN9qeb2CjOl4mKfVMsKa5nkWK79hbHGJlPfCRBQAa5IrA9mOYnWNgqe
         9IduPeJYzLzkU8usZjr7jk3voirRm+1n7gRd6ja3llyIQnFziJJzOSx2SJwbtG+VVqB4
         YN8aoult0weTei2HYES0eIyWDv9yGBFEkkAbPvKC9NVVJdUc2HA+Z/RCMxL46SIZjQ7m
         VxDFuix95rRUcqPSIbqwu9Q+CIkcgs8LpPvxp7tZ1GfwqeQUNHeVNDx+M8OwyfwusRAv
         zb4QpGce8VUSoLxzqDg79+8B2YO88TLr1nOJVtEEpVrk6Rl+JYfPpQUoDfaSGil1xHgr
         ckTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742190546; x=1742795346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKXW11VtaMuobC163bGqLeavsNh8UtgyJ54q+fYvbSw=;
        b=QVc8bUjERF1e4cRpvV5oVUwa2eA7VHWiHq9CqbfN7SgdVkb14FkhqFsv8nWOJqdem0
         6d/goBzPw99w7g6PB2W5wKktUmVcvZHYWiNdD8NWMwNYkjNY7u6xYl+GG4fHffvHoqw6
         En1QD+psDfGg5XPNzM0lP5mj9s0SkcEI12WA4wAUY7yTvIC3Gm0DMyb/h+HSJaeD2bb8
         wmygqhFqO0ykY4LZwj/uUnwBclx3KuHHH5G8/tCo8xfLUOntsqT8M63DPONbEXSa5/Ff
         Z74DlfDKvOD82/RrSu6KUpz/nSYyAbywtB8r4p5ihewtJf04pIBWDFaYzDFm1YXs699r
         EUGw==
X-Forwarded-Encrypted: i=1; AJvYcCVDnL2ltNZpinEN8TPcEF9/S+LyZImxCavyrrBRAwuqi4vXtXr0z0XdHd4fG0+pQ1C/L058YvqmXSIRSig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtdGmGPej7XNaxhtH9obWCzajoR4Ss+IU6TWwaDIHXljyHlD1H
	8KwCQaLtw8TBfpAQIBFQepvkVkeRg85s/qrYshxRBXhLpsWmTGAtNos+M7QxqQ==
X-Gm-Gg: ASbGncvt86FwTEbBSEnADA9v4ZgIBxHSK37BO+4VFPdZz3u3kq5OK4LOOgFF8NaoYsk
	dVTpSjab55xg5M/4kcDvlrdigAaO4vTFQ5zxYtJtQz7fwZgfZIa3aljZ9E/m9D6yC2z7GNZIZfr
	HWJl+tOo5a6kxCfpTcHYmig2hPPHeUwOsW8sLh1SRIsTp+lGS9+1E+h2mYfe0jNNN3BXa4MyVE0
	8DMMt6EDxfOH0QrDGavDHL6caYoIwTwcLMURi+fyhijsRHxCoodP8CJ0psvciL4qqWnDdQueccz
	z8AUHK0uuTsYhnKnqkkF34mzEAQh2Z7nqRdA4xlH2ddj
X-Google-Smtp-Source: AGHT+IHQZB/LzF7QYVTTddAwRnUQT5Em8+btqUAAePgxsG9SPEKtLX6tte8HbpNbzmI85WxKzvcUiA==
X-Received: by 2002:a05:6a21:394c:b0:1f5:889c:3cdb with SMTP id adf61e73a8af0-1f5c11936e7mr15763813637.8.1742190546526;
        Sun, 16 Mar 2025 22:49:06 -0700 (PDT)
Received: from bytedance ([115.190.40.12])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9e0fe3sm6397284a12.24.2025.03.16.22.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 22:49:05 -0700 (PDT)
Date: Mon, 17 Mar 2025 13:48:47 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: Re: [RFC PATCH 3/7] sched/fair: Handle unthrottle path for task
 based throttle
Message-ID: <20250317054847.GA3107573@bytedance>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0GcAic5QThYG-r9CaXPgZtXJuB0RuCW5Y0SyBn7VyOQi=g@mail.gmail.com>
 <3fdb7163-d1f0-45c8-89fa-7c904b567696@amd.com>
 <20250314104315.GE1633113@bytedance>
 <dd749cb4-fcf7-4007-a68e-3ca405925e9d@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd749cb4-fcf7-4007-a68e-3ca405925e9d@amd.com>

On Fri, Mar 14, 2025 at 11:22:20PM +0530, K Prateek Nayak wrote:
> Hello Aaron,
> 
> On 3/14/2025 4:13 PM, Aaron Lu wrote:
> > On Fri, Mar 14, 2025 at 09:23:47AM +0530, K Prateek Nayak wrote:
> > > Hello Aaron,
> > > 
> > > On 3/13/2025 12:51 PM, Aaron Lu wrote:
> > > 
> > > [..snip..]
> > > 
> > > > ---
> > > >    kernel/sched/fair.c | 132 +++++++++++++++-----------------------------
> > > >    1 file changed, 45 insertions(+), 87 deletions(-)
> > > > 
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index ab403ff7d53c8..4a95fe3785e43 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -5366,18 +5366,17 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct
> > > > sched_entity *se, int flags)
> > > > 
> > > >    	if (cfs_rq->nr_queued == 1) {
> > > >    		check_enqueue_throttle(cfs_rq);
> > > > -		if (!throttled_hierarchy(cfs_rq)) {
> > > > -			list_add_leaf_cfs_rq(cfs_rq);
> > > > -		} else {
> > > > +		list_add_leaf_cfs_rq(cfs_rq);
> > > >    #ifdef CONFIG_CFS_BANDWIDTH
> > > > +		if (throttled_hierarchy(cfs_rq)) {
> > > >    			struct rq *rq = rq_of(cfs_rq);
> > > > 
> > > >    			if (cfs_rq_throttled(cfs_rq) && !cfs_rq->throttled_clock)
> > > >    				cfs_rq->throttled_clock = rq_clock(rq);
> > > >    			if (!cfs_rq->throttled_clock_self)
> > > >    				cfs_rq->throttled_clock_self = rq_clock(rq);
> > > 
> > > These bits probabaly need revisiting. From what I understand, these
> > > stats were maintained to know when a task was woken up on a
> > > throttled hierarchy which was not connected to the parent essentially
> > > tracking the amount of time runnable tasks were waiting on the
> > > cfs_rq before an unthrottle event allowed them to be picked.
> > 
> > Do you mean these throttled_clock stats?
> > 
> > I think they are here because we do not record the throttled_clock for
> > empty cfs_rqs and once the cfs_rq has task enqueued, it needs to record
> > its throttled_clock. This is done in commit 79462e8c879a("sched: don't
> > account throttle time for empty groups") by Josh. I don't think per-task
> > throttle change this.
> > 
> > With this said, I think there is a gap in per-task throttle, i.e. when
> > all tasks are dequeued from this throttled cfs_rq, we should record its
> > throttled_time and clear its throttled_clock.
> 
> Yes but then what it'll track is the amount of time task were running
> when the cfs_rq was on a throttled hierarchy. Is that what we want to
> track or something else.

Right, my last comment was not correct.

Basically, my current approach tried to mimic the existing accounting,
i.e. when there is task enqueued in a throttled cfs_rq, start recording
this cfs_rq's throttled_clock. It kind of over-accounts the throttled
time for cfs_rq with this per-task throttle model because some task can
still be running in kernel mode while cfs_rq is throttled.

> The commit log for 677ea015f231 ("sched: add throttled time stat for
> throttled children") says the following for "throttled_clock_self_time":
> 
>     We currently export the total throttled time for cgroups that are given
>     a bandwidth limit. This patch extends this accounting to also account
>     the total time that each children cgroup has been throttled.
> 
>     This is useful to understand the degree to which children have been
>     affected by the throttling control. Children which are not runnable
>     during the entire throttled period, for example, will not show any
>     self-throttling time during this period.
> 
> but with per-task model, it is probably the amount of time that
> "throttled_limbo_list" has a task on it since they are runnable
> but are in-fact waiting for an unthrottle.
>
> If a task enqueues itself on a throttled hierarchy and then blocks
> again before exiting to the userspace, it should not count in
> "throttled_clock_self_time" since the task was runnable the whole
> time despite the hierarchy being frozen.

I think there is a mismatch between per-task throttle and per-cfs_rq
stats, it's hard to make the accounting perfect. Assume a throttled
cfs_rq has 4 tasks, with 2 tasks blocked on limbo_list and 2 tasks still
running in kernel mode. Should we treat this time as throttled or not
for this cfs_rq?

This is similar to the pelt clock freeze problem. For the above example,
should we freeze the cfs_rq's pelt clock or let it continue when this
cfs_rq is throttled with some task blocked on limbo_list and some task
still running in kernel mode?

My understanding is, neither approach is perfect, so I just chose the
simpler one for now. Please correct me if my understaning is wrong.

Thanks,
Aaron

