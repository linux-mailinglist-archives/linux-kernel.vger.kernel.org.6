Return-Path: <linux-kernel+bounces-561250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AE4A60F3E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641CE1B61F64
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64F81FA854;
	Fri, 14 Mar 2025 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="egprhvgB"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7A61F9A90
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741949004; cv=none; b=hQPB3NVSMQFFCl587ekHKyjt9gJlG0w21L7W9fOHXEH63cGLctA/wa/0Bz5vV7XgesOXxEfLIUgnXAjsn706Vvaw4DO1r5cna/XNmMRgup9xQnWFev6gTLSjxiGneAfay1q6yTzac21fq4Sa2weFvsMUYNKTeTrwfrAHCWIRdI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741949004; c=relaxed/simple;
	bh=5jTXyayO6Q3KIY9LJfU0tXvtnd2vFJFBraH9hLwJB5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ys3YD2lpfxBHZ8r2XjNziuQHJZ+FSmJLXGESNe2fpUZndfkk2ONt+7ofLI3mRn+zKd0CHRTaFjlqW5oc1QpYdkDxxaEwq0HDlnxvXMWTncmyQi3pZbrH5hm2d8ey+Sc8G5OBg6JxXEVu/YPsPUQ4wYPjq4a+YZEi785N8C5pl9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=egprhvgB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-223fd89d036so40796905ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741949002; x=1742553802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UTlDKnMLcXVyGSVAY6ALlY0e8v0hRnFduog7uNlIoQI=;
        b=egprhvgBvYieioxclIWS1TNr2WRdqgjpo21PyuKStP+UQckRcDIiVAuXDfxc66OJYQ
         hImCecmzxHBhV7ygbCriegAaI/tIFjpp2axDaS6S4o+yKpweR9u69EUl3JWJVCVJlK2T
         /9BMU6n2QWHQkPXPA7e2hAnn0X5zqeDm3xdwfOCKe/kwMJb/wUJPK1OJko5ss/iu8GZz
         aXEVebXWV61Ku8QpjsWgTzOqcGr0rJeEUFyWMrpm/2YkrxbaOVL85fXT/w8rAtwqQgB3
         SNqOx6bAM0nkeBEpM4HH6WN4Fu4zVG6R7M1v1balBbPU8Qub4mK5Zsrox8ZbEbzceowL
         GjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741949002; x=1742553802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTlDKnMLcXVyGSVAY6ALlY0e8v0hRnFduog7uNlIoQI=;
        b=PoUC+wP62qaPpqMkE01FF01NmMIUD6ZMHKqE7vM5d/riyQtc56pMRBZA4FwwGgc8Lk
         fdwbORQ+sefpXJzcrsY//tcHOHCqenHmo7jYRb++Pit0sPkV99i2fY00hJyh/+yKVvKY
         mmGlX6nkxB2AFMPNRu2WuH4IGUPTmr513ktQvYbvsMnAtoFe3p6+FY9V0nBxGopr8vHl
         3/I2zhEfcY20oUXYEpXkPWk56RLplLkzoRXKk9cEtWqqHvSI8U0MoWyb5QA7zlKIjjOO
         4cN4Nh8tWs8erSbrQA+n3h4O7Rq77m9YIs6vmKt6WyMZrH2ixIxuotQ90Pp/MbqPvlCD
         Txjw==
X-Forwarded-Encrypted: i=1; AJvYcCW7WQz2dIm0vzypM+bp36cB9YVE258BojWhLbRUpG12pr8hJBLHXqPYwVPVMuBuagt4v29/p4koFq8FQac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4h6dWxCeBNRGINiOtRfUnCST8r8MctAoV7pIezNifAGc1KgXb
	A1SxtMf3O9qM7ZZQsyN7T1HY1N8DljwZo01MgFYGwg9VpODfBTRLLcC5c8MFfw==
X-Gm-Gg: ASbGnctbm963XcpGpgIpmVujp99xsr5UV/u470jC1SQn+t8beamrQna8kO5+6vtUaTJ
	kZxmO6lfbdjKHLOKIvsQf4W8PycDCtL3lg2sXZa8bT5tDJ1ZIPq14TICzDE4bLM6BGM3USm9+V6
	NMD/JPnnPciH4BTWX943vWtkFAMC4E+DZ0C1f1dBECqcu4caOJ2LAcYmPL0ujWjiOW/pV6yHcKB
	ynIIoGwx6zeBV3HIFB964EkFRTb+r8THTQ3th4KiYaOuG6KRbwaKFh6qyhieOzyRF6fI7oQ6LTd
	hs+lDiI1YQDyhkQ6/MmmTMhbItVy2nEAW5owkrYVjXUqvq97Dq4c/E8=
X-Google-Smtp-Source: AGHT+IHEIImlaM784W7QpGqvoNscilIRXOZO9EaThuaGt5JkpmY4d0AkU2XDXPIzPuhaVlyOzO0rpQ==
X-Received: by 2002:a17:90a:e18f:b0:2ee:b6c5:1def with SMTP id 98e67ed59e1d1-30151ce1224mr2900866a91.8.1741949001769;
        Fri, 14 Mar 2025 03:43:21 -0700 (PDT)
Received: from bytedance ([115.190.40.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3015363217dsm744379a91.32.2025.03.14.03.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:43:21 -0700 (PDT)
Date: Fri, 14 Mar 2025 18:43:15 +0800
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
Message-ID: <20250314104315.GE1633113@bytedance>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0GcAic5QThYG-r9CaXPgZtXJuB0RuCW5Y0SyBn7VyOQi=g@mail.gmail.com>
 <3fdb7163-d1f0-45c8-89fa-7c904b567696@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fdb7163-d1f0-45c8-89fa-7c904b567696@amd.com>

On Fri, Mar 14, 2025 at 09:23:47AM +0530, K Prateek Nayak wrote:
> Hello Aaron,
> 
> On 3/13/2025 12:51 PM, Aaron Lu wrote:
> 
> [..snip..]
> 
> > ---
> >   kernel/sched/fair.c | 132 +++++++++++++++-----------------------------
> >   1 file changed, 45 insertions(+), 87 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index ab403ff7d53c8..4a95fe3785e43 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5366,18 +5366,17 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct
> > sched_entity *se, int flags)
> > 
> >   	if (cfs_rq->nr_queued == 1) {
> >   		check_enqueue_throttle(cfs_rq);
> > -		if (!throttled_hierarchy(cfs_rq)) {
> > -			list_add_leaf_cfs_rq(cfs_rq);
> > -		} else {
> > +		list_add_leaf_cfs_rq(cfs_rq);
> >   #ifdef CONFIG_CFS_BANDWIDTH
> > +		if (throttled_hierarchy(cfs_rq)) {
> >   			struct rq *rq = rq_of(cfs_rq);
> > 
> >   			if (cfs_rq_throttled(cfs_rq) && !cfs_rq->throttled_clock)
> >   				cfs_rq->throttled_clock = rq_clock(rq);
> >   			if (!cfs_rq->throttled_clock_self)
> >   				cfs_rq->throttled_clock_self = rq_clock(rq);
> 
> These bits probabaly need revisiting. From what I understand, these
> stats were maintained to know when a task was woken up on a
> throttled hierarchy which was not connected to the parent essentially
> tracking the amount of time runnable tasks were waiting on the
> cfs_rq before an unthrottle event allowed them to be picked.

Do you mean these throttled_clock stats?

I think they are here because we do not record the throttled_clock for
empty cfs_rqs and once the cfs_rq has task enqueued, it needs to record
its throttled_clock. This is done in commit 79462e8c879a("sched: don't
account throttle time for empty groups") by Josh. I don't think per-task
throttle change this.

With this said, I think there is a gap in per-task throttle, i.e. when
all tasks are dequeued from this throttled cfs_rq, we should record its
throttled_time and clear its throttled_clock.

> 
> With per-task throttle, these semantics no longer apply since a woken
> task will run and dequeue itself when exiting to userspace.
> 
> Josh do you have any thoughts on this?
> 
> > -#endif
> >   		}
> > +#endif
> >   	}
> >   }
> >

> > @@ -5947,12 +5967,16 @@ static int tg_throttle_down(struct task_group
> > *tg, void *data)
> > 
> >   	/* group is entering throttled state, stop time */
> >   	cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
> > -	list_del_leaf_cfs_rq(cfs_rq);
> > 
> >   	SCHED_WARN_ON(cfs_rq->throttled_clock_self);
> >   	if (cfs_rq->nr_queued)
> >   		cfs_rq->throttled_clock_self = rq_clock(rq);
> > 
> > +	if (!cfs_rq->nr_queued) {
> > +		list_del_leaf_cfs_rq(cfs_rq);
> > +		return 0;
> > +	}
> > +
> 
> This bit can perhaps go in Patch 2?

I kept all the changes to leaf cfs_rq handling in one patch, I think it
is easier to review :-)

Thanks,
Aaron

> >   	WARN_ON_ONCE(!list_empty(&cfs_rq->throttled_limbo_list));
> >   	/*
> >   	 * rq_lock is held, current is (obviously) executing this in kernelspace.

