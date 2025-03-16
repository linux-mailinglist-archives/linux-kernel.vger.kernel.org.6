Return-Path: <linux-kernel+bounces-562826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 835DBA6336A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 04:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B463C1892908
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 03:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB6E6BB5B;
	Sun, 16 Mar 2025 03:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R8O/C8gx"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2584DEAE7
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 03:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742095568; cv=none; b=qcHaXyXrcls5fDhq4ZFfnTFxQPEypsH8BV7qEvYkDlk6kamNCRAnV/dBF9LYrdCBnYsGnnUp0fNMO37CUbDPZCS3lFEIlpxLWxGS1WWEXeszJgYb/LzuwtI1lAWhsbcn3jHXaLxx51D6dN+GDA6SVlhs7gpe1VlSPoU+IY1pMso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742095568; c=relaxed/simple;
	bh=mekDKf9S5kLQUk/7oPM/toKjbBmIyGcb3i4p1vmkiPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8jwLWjVUvtxCvd2pFUkM6CXO/xvHxGh0deREJyHHYZCRyGx6Oj1Jo7y1Cv+0cOLD6QQ3Nlw2gOcQ3XCJUX6V2cA0kVwLUCT0lVdNzBk/Zsr1GLY8WWUeAHnP+zGSU/pkxNy9MVLbXKyiV0K/IRjSD13PRHZWK0gECDw3qi7h2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R8O/C8gx; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-476693c2cc2so304891cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 20:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742095566; x=1742700366; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I031H45oHHjrgnbC6qk0p0UOqaWjWPGvi+XZ/FpIMo8=;
        b=R8O/C8gxxNVTMFC+8vYoHOiwV2PExai5cyiXkDRBHn4uzCTcsabdrlBXMGCXFCWycr
         YmzOj9yfSLfontGVlyS3ZxQLMPjf96hk2G5GbwFcHrG8M6MZPAfyXmxU2zWE6gRgJR5z
         r1xBJtDaG15GipUcJW1QDpduXzoXps3RSiX2rLsoPeh4IitgzKW1+7Xw2MQb6CE/vR0V
         7tVX0nJ7NPYKOGcT8N6wMp3o/Bevwh/oMBHPCDMkW7FRx1i1/oE2oxyyjMimY831bHW3
         IOe0mC5mC+QbrK1r0R4RHgLMjE0+4e9+vObA8bz2PSOttqmhfjpYyJZXtESlDzDOG01f
         wGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742095566; x=1742700366;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I031H45oHHjrgnbC6qk0p0UOqaWjWPGvi+XZ/FpIMo8=;
        b=kUGNcaDUqROhWthmJEZPzaoMyvCZSrpJj7e3BztEXpAb1vnUGZ00S0b2WHvynyRjR1
         RCx4qEQ80Z4UqYfJ8rz0jA904dySA4rLI+bQHaFV9yEWjXf0Adf2FrP1oLOAsXrqYa9K
         jF3cM0RKMuwrHnsSrcrTkKryOa51nzoMgZ4hlZIFjh2U2FxDdi5+U04fDKGr9c8fLAhE
         W+X8W4GUwtDsRXGdAWdF0ayBOivrcZwOHxRrwKqS2ggjFAepCCnsoySPpRKpN00wDAMl
         q/pk2zxndJ5ZVw8pLY8zGW9GlcBRoAw1R1zWVIgBjJHcwE1kglBd8UFV94Qq23Og2M57
         Bevw==
X-Forwarded-Encrypted: i=1; AJvYcCX5bkfrRxUMa9g+MHWjcYJEfIXJvdnAl3AAAZ4++4R473Z/0AMp0VePsM0j4K51GMgfJ8r2WZBpy2qGa0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPvbfhZMjZt6Aq+gc4mbR+iDq2NscVpa075E4KQnJ4dJvzjVMu
	ohMhm35GXy+tWX7Ke/ZsBhtrMWiOkATAJycgwX7aptKqQFJDz2NF0T9gdsl0S3fUEoPM4PezLqC
	X3oq5jB2Z2DY/SR0DEtfSWUlQXRSse5QLuHte
X-Gm-Gg: ASbGnct8buTwK/9VegTGekhQRVftCGjVZs654qg3Shs8IGtw5IMA9Wr0Nt9vjlol/PE
	xyESyTlruIQkkzehi58f/SlgXoP7DOiv1LRrpB491HZ6mgOY9R/gdp6Vb2KivVRvVq+4n+kXLfC
	jgNsti3CyYHIaTdPoc/vTX6gL5YRs=
X-Google-Smtp-Source: AGHT+IFrqUQXyl1Pn1EaIiL+ZTOOQoB0Pn52TLnAqKlkpCBgguZcVlYaAvSK/jLyL0iXMLjUrUwueiH9z9r3yhRNyzY=
X-Received: by 2002:a05:622a:424a:b0:476:861d:10ec with SMTP id
 d75a77b69052e-476d6464a94mr2961381cf.15.1742095565487; Sat, 15 Mar 2025
 20:26:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313072030.1032893-1-ziqianlu@bytedance.com> <CANCG0GcFF7cnR4rCbU5MmY1Gq3M+r4gPXv39QPXXC=Cdr6sRww@mail.gmail.com>
In-Reply-To: <CANCG0GcFF7cnR4rCbU5MmY1Gq3M+r4gPXv39QPXXC=Cdr6sRww@mail.gmail.com>
From: Josh Don <joshdon@google.com>
Date: Sat, 15 Mar 2025 20:25:53 -0700
X-Gm-Features: AQ5f1JokS5KIu90bXzb2JRcu-FHIAYwb4q7wMRxrEzOEl-iXUB454l52aysMBcA
Message-ID: <CABk29Nuuq6s1+FBftOPAcMkYU+F1n2nebcP5tDK9dH4_KXA2cw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/7] sched/fair: Handle throttle path for task based throttle
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mel Gorman <mgorman@suse.de>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Chuyi Zhou <zhouchuyi@bytedance.com>, Xi Wang <xii@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Aaron,

>  static int tg_throttle_down(struct task_group *tg, void *data)
>  {
>         struct rq *rq = data;
>         struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
> +       struct task_struct *p;
> +       struct rb_node *node;
> +
> +       cfs_rq->throttle_count++;
> +       if (cfs_rq->throttle_count > 1)
> +               return 0;
>
>         /* group is entering throttled state, stop time */
> -       if (!cfs_rq->throttle_count) {
> -               cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
> -               list_del_leaf_cfs_rq(cfs_rq);
> +       cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
> +       list_del_leaf_cfs_rq(cfs_rq);
>
> -               SCHED_WARN_ON(cfs_rq->throttled_clock_self);
> -               if (cfs_rq->nr_queued)
> -                       cfs_rq->throttled_clock_self = rq_clock(rq);
> +       SCHED_WARN_ON(cfs_rq->throttled_clock_self);
> +       if (cfs_rq->nr_queued)
> +               cfs_rq->throttled_clock_self = rq_clock(rq);
> +
> +       WARN_ON_ONCE(!list_empty(&cfs_rq->throttled_limbo_list));
> +       /*
> +        * rq_lock is held, current is (obviously) executing this in kernelspace.
> +        *
> +        * All other tasks enqueued on this rq have their saved PC at the
> +        * context switch, so they will go through the kernel before returning
> +        * to userspace. Thus, there are no tasks-in-userspace to handle, just
> +        * install the task_work on all of them.
> +        */
> +       node = rb_first(&cfs_rq->tasks_timeline.rb_root);
> +       while (node) {
> +               struct sched_entity *se = __node_2_se(node);
> +
> +               if (!entity_is_task(se))
> +                       goto next;
> +
> +               p = task_of(se);
> +               task_throttle_setup_work(p);
> +next:
> +               node = rb_next(node);
> +       }

I'd like to strongly push back on this approach. This adds quite a lot
of extra computation to an already expensive path
(throttle/unthrottle). e.g. this function is part of the cgroup walk
and so it is already O(cgroups) for the number of cgroups in the
hierarchy being throttled. This gets even worse when you consider that
we repeat this separately across all the cpus that the
bandwidth-constrained group is running on. Keep in mind that
throttle/unthrottle is done with rq lock held and IRQ disabled.

In K Prateek's last RFC, there was discussion of using context
tracking; did you consider that approach any further? We could keep
track of the number of threads within a cgroup hierarchy currently in
kernel mode (similar to h_nr_runnable), and thus simplify down the
throttling code here.

Best,
Josh

