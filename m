Return-Path: <linux-kernel+bounces-568100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02863A68E25
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F289884B1C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C22257AC2;
	Wed, 19 Mar 2025 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iXwyXTS9"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A15120D519
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742391830; cv=none; b=pQw80lsGOoKMP6lskkgEtgne2yJmM48gm949CnlL3YGgQA1szlpBLiHrhbWcy1u+5EUuHTg9xc34ZcLzS5KL1ljJQRBaUhhHxq4L+36Okd5S9hgJIZfO/sqWhZnfTExfk3h8m+nM2jKg5zuMJ5JQGZ9k/32Z475gwo/Nhn64bfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742391830; c=relaxed/simple;
	bh=3j/k2JuZ0htB3fbG4x0bEP65b3xLx+PBNwGtT586wZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMrjEBcgaJ7M70+jFc+mxtoOQp6Rjc0+i+4a4+Oa1lrhEhCHwqviHmPHyFTIJuGgPFsa/hm5uakaOdIYh63S6U0Atq9vsWv7GJSHTzDsqotJ15U5tFop8bCRhCRaep2VcOcRo+Vk7PPIRXqZrNzF8wVVvb+wz+3HwmAQThPdaU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iXwyXTS9; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3018f827c9bso4649474a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 06:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1742391828; x=1742996628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eJleT+qPEantmni6XpLnHWfYyV+Ug9FMMQoeRtDG1zk=;
        b=iXwyXTS9LXPGiXcSzdG+LvxevKQb73xwqmKC5neMEtXTO1JPN/r5GmjqNKLp/SsPaM
         iijeIbL9lhAwP1QClI3wV8etfQ3lQzfWn8mdhAH4/nhggl3foVqNaL6RgZHk3uqsXMzR
         ePq31QrqncU2I/2E7ONvUBlhU6P/BGBwZO+wRfA9wIXJ9zRPT4IQF1XUNhZoM/SBniCQ
         KsGxb0iWbGaaXGs5nQ+9QA0WsICCDoc4U0ymC6e8f2Yna6dBU8OFFqCgLM1a6jWZ8jZT
         hlMvRU/Vxo80HvkeL6NLI0XiC07gEgT63Wkit038nfnT367bji2DMDqaRHAYo4qMeVun
         NWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742391828; x=1742996628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJleT+qPEantmni6XpLnHWfYyV+Ug9FMMQoeRtDG1zk=;
        b=JIm6WyFG7Xn0t+UdJJJd0PsBtLsEKYgQEJj6IydurxFaMG+uGV3HFmUb37yedPJED6
         EOECf+/47fogMfvVXJg/4FH1A9ll89nFjNU+FHa/Vyvsol++066dnfaYyMafDg+5H00Y
         Wlb5Sj2jxOA7WF1XbWZFyM20JtTJBKhUqznjlF6SireZX4F81pEmMTxl3EB7hrwq9SnP
         P4NcbyYiiCKuJphCgJExdzemgr7fSwI7ib0CBctpaJs1HI44nhXqx7EdRYbgfgv3MYR2
         KB2VfFXJnyBZETxKQhXNM8rYCIPL7nWXBKq/qXH0QvR5L2yzYEnWF4AbAyxrY/1JQe/P
         8NcA==
X-Forwarded-Encrypted: i=1; AJvYcCXOVGaoOiV6qxrv367OBOHKj+ZlWz4s+EXoxDGd6rMs+c3DrjX3Xob01ow1kqokGjwN/rI0KiyEOE2j2Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHwgwfkLAlG8sIxAcNVnqDUz7hwllNWvfWq8n3ouGFDKbdNFGE
	zhA4sp4L4Bzdu9rab5U2EwL96+IZHVaLbmLFPyF+jWUQNV+NuWOnTjLMgznhZk8JAAMaBG6Sdwx
	Okw==
X-Gm-Gg: ASbGnctgBL00kQszTLMJL9PwkGyRjCJD+NlduRuzPDSG1kIwCCCUzE8mUMxz7cAQ853
	MHHDl5ozegGLjS9Cjxs4BuudABvaM5fbDOxGESmR+9BHUTJARIuN5Ar7EEAYXOKSAp/2eRz3Win
	zBYkqEriP9vbokQxKeRyudpAZ52OzfpF4E9m7FBnppI1LMYWaYTQVBEbC54ddyyMiCICAZUXDFK
	g/gXySGXnS3YSO2qsztblZX3Db4mKC49eUD2jseNhIU0eHd4W4sYljwaflpXfurxAADJMi/lRp1
	L1nM6cERMKDmErahyth6NFZRq4inNkjKTyBr359rTd4hUGlLBza+o7U=
X-Google-Smtp-Source: AGHT+IGy1Z2WwzACeJeWDB55MWJY3SqRNAvSfKJ/5QfGPe2DHMz9RdgK+v66q42NuLGnVIN7BVEF6Q==
X-Received: by 2002:a17:90b:5550:b0:2ff:570d:88c5 with SMTP id 98e67ed59e1d1-301bde6dcc9mr4753403a91.9.1742391828038;
        Wed, 19 Mar 2025 06:43:48 -0700 (PDT)
Received: from bytedance ([115.190.40.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf58af67sm1554526a91.17.2025.03.19.06.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 06:43:47 -0700 (PDT)
Date: Wed, 19 Mar 2025 21:43:23 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Josh Don <joshdon@google.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chuyi Zhou <zhouchuyi@bytedance.com>, Xi Wang <xii@google.com>
Subject: Re: [RFC PATCH 2/7] sched/fair: Handle throttle path for task based
 throttle
Message-ID: <20250319134257.GA1428417@bytedance>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0GcFF7cnR4rCbU5MmY1Gq3M+r4gPXv39QPXXC=Cdr6sRww@mail.gmail.com>
 <CABk29Nuuq6s1+FBftOPAcMkYU+F1n2nebcP5tDK9dH4_KXA2cw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29Nuuq6s1+FBftOPAcMkYU+F1n2nebcP5tDK9dH4_KXA2cw@mail.gmail.com>

Hi Josh,

On Sat, Mar 15, 2025 at 08:25:53PM -0700, Josh Don wrote:
> Hi Aaron,
> 
> >  static int tg_throttle_down(struct task_group *tg, void *data)
> >  {
> >         struct rq *rq = data;
> >         struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
> > +       struct task_struct *p;
> > +       struct rb_node *node;
> > +
> > +       cfs_rq->throttle_count++;
> > +       if (cfs_rq->throttle_count > 1)
> > +               return 0;
> >
> >         /* group is entering throttled state, stop time */
> > -       if (!cfs_rq->throttle_count) {
> > -               cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
> > -               list_del_leaf_cfs_rq(cfs_rq);
> > +       cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
> > +       list_del_leaf_cfs_rq(cfs_rq);
> >
> > -               SCHED_WARN_ON(cfs_rq->throttled_clock_self);
> > -               if (cfs_rq->nr_queued)
> > -                       cfs_rq->throttled_clock_self = rq_clock(rq);
> > +       SCHED_WARN_ON(cfs_rq->throttled_clock_self);
> > +       if (cfs_rq->nr_queued)
> > +               cfs_rq->throttled_clock_self = rq_clock(rq);
> > +
> > +       WARN_ON_ONCE(!list_empty(&cfs_rq->throttled_limbo_list));
> > +       /*
> > +        * rq_lock is held, current is (obviously) executing this in kernelspace.
> > +        *
> > +        * All other tasks enqueued on this rq have their saved PC at the
> > +        * context switch, so they will go through the kernel before returning
> > +        * to userspace. Thus, there are no tasks-in-userspace to handle, just
> > +        * install the task_work on all of them.
> > +        */
> > +       node = rb_first(&cfs_rq->tasks_timeline.rb_root);
> > +       while (node) {
> > +               struct sched_entity *se = __node_2_se(node);
> > +
> > +               if (!entity_is_task(se))
> > +                       goto next;
> > +
> > +               p = task_of(se);
> > +               task_throttle_setup_work(p);
> > +next:
> > +               node = rb_next(node);
> > +       }
> 
> I'd like to strongly push back on this approach. This adds quite a lot
> of extra computation to an already expensive path
> (throttle/unthrottle). e.g. this function is part of the cgroup walk
> and so it is already O(cgroups) for the number of cgroups in the
> hierarchy being throttled. This gets even worse when you consider that
> we repeat this separately across all the cpus that the
> bandwidth-constrained group is running on. Keep in mind that
> throttle/unthrottle is done with rq lock held and IRQ disabled.

Agree that it's not good to do this O(nr_task) thing in
throttle/unthrottle path. As Chengming mentioned, throttle path can
avoid this but unthrottle path does not have an easy way to avoid this.

> In K Prateek's last RFC, there was discussion of using context
> tracking; did you consider that approach any further? We could keep

I haven't tried that approach yet.

> track of the number of threads within a cgroup hierarchy currently in
> kernel mode (similar to h_nr_runnable), and thus simplify down the
> throttling code here.

My initial feeling is the implementation looks pretty complex. If it can
be simplified somehow, that would be great.

Best regards,
Aaron

