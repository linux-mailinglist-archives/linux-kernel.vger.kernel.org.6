Return-Path: <linux-kernel+bounces-561650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6FFA6148A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39A8A3A34F1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70BA201032;
	Fri, 14 Mar 2025 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MXTpvPYi"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E327428DB3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741965059; cv=none; b=uz4THuT3UgDzndWYXzXyzw6JE4wh4zdv+OoDBab4PsEuzMCu2XFmSPhyT0BZd+4EdY4N5TqpuMGufdVmHBJGRmBD2PYmt/WBD9woqPhrTJo3d8Lg7tPfEPWDAyFQvJmomxKijQgkVY8RgTB59nPzSDyvLxd528ENOiEwZOIDML4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741965059; c=relaxed/simple;
	bh=hgtQP5gQzp/SlUcnIUo4xf8jBY0UWeX0VQEixIdLJYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQSuxXbw7eDSuiSJV6uERk+FswCassNEfEdmYj2mFmItcPle7YCLud7hE1gHsETbqXSlm312mj3T8e6xLttWoq1TF9b1ya73acxOIM7S5VagQbXwRavoA9sM2IgDccQ0eKldEjuzQSmAcVumb2jENX2t+3mRq0ZRrZvNVc3KdRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MXTpvPYi; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fa8ada6662so4806194a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741965055; x=1742569855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xjw/V4RN71VvtE/cr2npyka4PWnJK8bUXBsUb81gGS0=;
        b=MXTpvPYiLqPv4F/izTXirP+IlAOOAVtEqkM6tpNrixmKIkINPBTd447RZ7UK0W8SGX
         vuULtTEdNZM+JYtuZutYGPnm0OPyWzOvI581gziyhDK2KoMtnjgMZr9erKjX5eq2VYlT
         hhr8lrf5+JtmHRNAyvzG3+1kzpHlPNogwzl7fVNS1LKB+xdzeCRnbkrl2vuXR1NgDoEL
         7s7bwWh6weOblFqaKKOSyvv2bp3zft6WiCDBBGBFerUo8a3XEdwTyjacdpdHxe0VxTMx
         j6JMxxCAsqSPlByU3tCC7JnREKYtWcrF0l+Q7V6WM4fehm9PqyXmuqHMvIdYyTBOGmwv
         2fZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741965055; x=1742569855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjw/V4RN71VvtE/cr2npyka4PWnJK8bUXBsUb81gGS0=;
        b=JYhIOl38zWRw9Az4rbDOm4G3B7YVUnfzSt+HAMPOul7VaZfHKjxugYp6CBb0qjDlKs
         Ik/Ybfd215F2Oo/Q2lJ725ob8AdrrHtMBVxRRq5VQOQVa4ze9i1ogkvCezqHziz4RqNA
         Xnn7wqLydI4uMbKh3wl1loIQnDQ0PzDdmVDlH6FCi/sGeaqRxva0bgmWJYL3sHb+UP5J
         AYD60XbuB8NW4LuCqkyu0Y9YK5XCfUElnU+nS0EQNwg68jET7PLwm9DVbMed4PkJTgyT
         dnJ2TSZ3Ps85hvkhVSu2N4jTF1Po9LqI0ZdYWL83NI/FF4rUj6VRWv5SRjNXsMW8w1PN
         1hSw==
X-Forwarded-Encrypted: i=1; AJvYcCWjpbcKlnRDGlOiLbDelz0W0nfQ61TXxpHJsVLKmhbPxRcxny2XAbDdp+ieIR4mNerbWglOgiPhJQZQkw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzElV3WF58xquVqRy6CL7fT/xvoOyuXVfdXWo1MCsWktY4m4+Mw
	66mgGSU9KUV3yRzhl/RgZrnmuN23Hgs9dMcQvAF5xbWTBuxCPF58Csdof9M+6w==
X-Gm-Gg: ASbGncv4QkVD9tvGxa0BafJj3zg9P80+LZ7KKdxMpFBx+ulNpJsRWcDdLwOxAdSHqow
	md7eaD8iMB/c545LCS5G0R9oZsMGJKhY3S/QHv9r20bjUH0FMl2P/hczzFznmzZROmqv6n0pCZ7
	OmQmC/iaJqIGtDu72+TxD3rw/R/1sYscWh+b8eR9/1zcDC62kVgKrbDJwnJjwNjzfU80O48MmO/
	SUpkn8xXVZMVOsJgszAPMK07Zezv228R2dquQuUYXei/jrybopxMXopD7fHyByI11zXKyCQikSA
	yLR5N7ZbScWok/eeW1TDBZjEXaOrmcwTIPM8RJz7SEK3
X-Google-Smtp-Source: AGHT+IGadTP+nHuhzChDppfT52vtLyF6YFDEfbxLQ3V1GR1yOqsNPZzdjkg+yBtzT9EU7daw9Q4oiA==
X-Received: by 2002:a17:90b:1f86:b0:2ee:c91a:acf7 with SMTP id 98e67ed59e1d1-30151c7a5a5mr3776134a91.4.1741965055029;
        Fri, 14 Mar 2025 08:10:55 -0700 (PDT)
Received: from bytedance ([115.190.40.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153b9953bsm1217257a91.37.2025.03.14.08.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 08:10:54 -0700 (PDT)
Date: Fri, 14 Mar 2025 23:10:32 +0800
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
Subject: Re: [RFC PATCH 2/7] sched/fair: Handle throttle path for task based
 throttle
Message-ID: <20250314151032.GA2000430@bytedance>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0GcFF7cnR4rCbU5MmY1Gq3M+r4gPXv39QPXXC=Cdr6sRww@mail.gmail.com>
 <ddd839a6-916b-4a23-a998-0d44486588ab@amd.com>
 <20250314085709.GB1633113@bytedance>
 <2c38d5a3-4d00-4139-a71c-00ca90375489@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c38d5a3-4d00-4139-a71c-00ca90375489@amd.com>

On Fri, Mar 14, 2025 at 02:42:46PM +0530, K Prateek Nayak wrote:
> Hello Aaron,
> 
> On 3/14/2025 2:27 PM, Aaron Lu wrote:
> > > > 
> > > > +static inline bool task_has_throttle_work(struct task_struct *p)
> > > > +{
> > > > +	return p->sched_throttle_work.next != &p->sched_throttle_work;
> > > > +}
> > > > +
> > > > +static inline void task_throttle_setup_work(struct task_struct *p)
> > > > +{
> > > > +	/*
> > > > +	 * Kthreads and exiting tasks don't return to userspace, so adding the
> > > > +	 * work is pointless
> > > > +	 */
> > > > +	if ((p->flags & (PF_EXITING | PF_KTHREAD)))
> > > > +		return;
> > > > +
> > > > +	if (task_has_throttle_work(p))
> > > > +		return;
> > > > +
> > > > +	task_work_add(p, &p->sched_throttle_work, TWA_RESUME);
> > > > +}
> > > > +
> > > >    static int tg_throttle_down(struct task_group *tg, void *data)
> > > >    {
> > > >    	struct rq *rq = data;
> > > >    	struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
> > > > +	struct task_struct *p;
> > > > +	struct rb_node *node;
> > > > +
> > > > +	cfs_rq->throttle_count++;
> > > > +	if (cfs_rq->throttle_count > 1)
> > > > +		return 0;
> > > 
> > > General question: Do we need the throttled_lb_pair() check in
> > > can_migrate_task() with the per-task throttle? Moving a throttled task
> > > to another CPU can ensures that the task can run quicker and exit to
> > > user space as quickly as possible and once the task dequeues, it will
> > > remove itself from the list of fair tasks making it unreachable for
> > > the load balancer. Thoughts?
> > 
> > That's a good point.
> > 
> > The current approach dequeued the task and removed it from rq's
> > cfs_tasks list, causing it lose the load balance opportunity. This is
> > pretty sad.
> 
> That is fine. Today we have the throttled_lb_pair() check since tasks
> on throttled hierarchy remain on the fair tasks list and the load
> balancer should not move the around since they don't contribute to
> current load in throttled state and moving them around will not change
> anything since they'll still be waiting on another CPU for unthrottle.

OK I misunderstood. I thought tasks in throttled hierarchy still has
chance to participate load balance.

> With per-task throttle, we know that all the tasks on the fair task
> list are runnable (except for the delayed ones but they contribute to
> the load) - tasks on throttled hierarchy that exit to userspace will
> dequeue themselves, removing them from the fair task list too.
> 
> Since a task that hasn't dequeued itself on a throttled hierarchy is
> runnable, I'm suggesting we get rid of the throttled_lb_pair() check
> in can_migrate_task() entirely.

Agree, will fix this in next version, thanks.

Best regards,
Aaron

> > 
> > I'll need to think about this. I hope we can somehow keep the throttled
> > tasks in cfs_tasks list, I'll see how to make this happen.
> > 
> > Thanks,
> > Aaron
> > 
> 
> [..snip..]
> 
> -- 
> Thanks and Regards,
> Prateek
> 

