Return-Path: <linux-kernel+bounces-561332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52722A61027
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29B1C178402
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AB21FE457;
	Fri, 14 Mar 2025 11:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GUzp+Rrf"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE161FDA8D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952287; cv=none; b=GEemyCohxw9bceguoJybAFw9NwldmvYsOQYGl3rMMzhGrOPmFVTYoC8z2JTvX0la8ahpB3vzEXBFQs/d1M5M+fzAhnyTONzPnya7XHzMBpLWhCEJi/rQ2lKb/EZHTh4Ny2ABGZ1X88eb9HO2lRtLRsC5E4m4uAmN0qirujDFKeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952287; c=relaxed/simple;
	bh=O842J10jRPm+8RIGm6aBD/CjYB0Sq4RFVkakEI3wPVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceuADQxqtD6DM/Taf+kUBfVlqebDG6VY5ZFzKxKQ9IYLleJk9X/ekEUB5AbtN9YiuA0YSNlGX8/sn8TCNaplBLfCevImT+PeoTJ0ABDweeS/hrydu5wNeKV1jHjgpCWRHpwdjY/KWf1VBs6IeT9Mtio8ZoIxM6mR4M2Z4VMdWFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GUzp+Rrf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-224171d6826so49012365ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 04:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741952284; x=1742557084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d/UjZ5myCJymzSxmgoTBd9qXKJYbpN/Fj9IHHVv+QlM=;
        b=GUzp+RrfFb/VK9mfWW0RYdiWX/SLvpea3I08XzCIjeK1cN9HJ9+XA/9K4CwiQ4hBN9
         UdurWdHakU0HwReKxCc3qDndt4dauQck/tg4RmuBdOHanvleNESQFLcZTyIE4FwRmjn4
         Bq4aEc5HakRpOzHeqbVNFdXfXPHYXTKwENIrPlG5vBho8lU2JJa8I1glv7cRProzXF2w
         Uj9UHQvUAnOCnXFCeixVHn1NaKHjU3kEgRYO+ECFNOvPJEKx9Rkhm44R9SrsGLdZdRu8
         lo9PGByy4JDmiDo7cF1jgX8FbstF77oVy2o8k94FdWXrSnBRqdQwv8t8bwwNfVKpB4dk
         w5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741952284; x=1742557084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/UjZ5myCJymzSxmgoTBd9qXKJYbpN/Fj9IHHVv+QlM=;
        b=GtLs9FLwVoyXEhZ3+p5WWth7xett3abx6/MoqlS8DsTsJyExg7ZbJ14obEdWskpRll
         EZydWidqSMbf5ebsHSXpYr2q4AejMGc3W/mAsro3JtKTXnn+JjOT3PwBlzB339M1t92t
         s+rlpFbmKbopiNtaCXtCUGkRz/PzI5CW7pef1fS6hz99ixleWjTohkWQmbcYSWkOC4Ve
         fwZHIRjP9zKTsgVaYPg1Qc1/Prt+D//1VHBaQ5962toCEDCL+XsnErAgco6oNZrzG0AQ
         74His+ULk6nXr+ZPQI7AcPdtVYn8Ddq6nges1/pDFqVz9YD1qt544zzMFV2nfjnVA3Iz
         0P9w==
X-Forwarded-Encrypted: i=1; AJvYcCUiOaXfWwZ6k2hSJLTT1JlftkI8jSnEVoHUmIWqes1nWjb2J49piOiuskeeZnIBjy5fnfbnyv2qHzPeAa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX0YHBVFvzUmNpwqQWMXCMq5byItz6oQRLILi8uJAURsaAmVh9
	kMtJ97mLFMNBh+YducEKtSUNvc/CEbr0FiFU95Z2AeZ2bv0rg8lFs9EOOYDpJg==
X-Gm-Gg: ASbGnctTV+i2KskV5cknAsu0G7/7G1GMsUqcJAZCqSzJUpsRPVgwhLqvJjPN1jaMzXj
	giCZQt8Ri9yZaw+Fmd+JmU9QfPxt2O12Su22kR6hxobivsImsO4YEsTZBTz+FKe6ow71gQIUl9U
	NyY7PQwzu9GNZdoClUz69bF1EnmfVR8OTc0YQws94SjhFO28nMHL9aicAkO69ITEv2U3nvmAkc5
	juFnwcpKJqsRrMpLUG8z7nRla5cKX2Q9PrTICQLb503ww1h+AUT5jbzRt4H4XhiZ5mfolVwmNc3
	5AMT1hwSCSVu+7KSu/Cx6WbPx5qaiBzKbFijS0TS07rC
X-Google-Smtp-Source: AGHT+IG5Eq1iUQZKKrRv42suczFu1CWGTbs3roNMNaPoqRlyteW70KC4dNpYDPbZDHnWgsbtXUgjOw==
X-Received: by 2002:a17:902:e5d2:b0:21f:859a:9eab with SMTP id d9443c01a7336-225e0b18f5bmr32180115ad.37.1741952284564;
        Fri, 14 Mar 2025 04:38:04 -0700 (PDT)
Received: from bytedance ([115.190.40.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301533e6515sm829547a91.0.2025.03.14.04.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 04:38:04 -0700 (PDT)
Date: Fri, 14 Mar 2025 19:37:56 +0800
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
Subject: Re: [External] Re: [RFC PATCH 6/7] sched/fair: fix tasks_rcu with
 task based throttle
Message-ID: <20250314113756.GF1633113@bytedance>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0GehTMm3sbtXMy9MMFtG=kPYpHiFwy63OO4+dmXh68bWfA@mail.gmail.com>
 <28267ba4-94a2-4a77-9c34-7273a102c183@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28267ba4-94a2-4a77-9c34-7273a102c183@amd.com>

On Fri, Mar 14, 2025 at 09:44:45AM +0530, K Prateek Nayak wrote:
> Hello Aaron,
> 
> On 3/13/2025 12:52 PM, Aaron Lu wrote:
> > Taskes throttled on exit to user path are scheduled by cond_resched() in
> > task_work_run() but that is a preempt schedule and doesn't mark a task
> > rcu quiescent state.
> > 
> > Fix this by directly calling schedule() in throttle_cfs_rq_work().
> 
> Perhaps that can be gotten around by just using set_ti_thread_flag()
> resched_curr() will also call set_preempt_need_resched() which allows
> cond_resched() to resched the task.
> 
> Since exit_to_user_mode_loop() will run once again seeing that
> TIF_NEED_RESCHED is set, schedule() should follow soon. Thoughts?

Might also work, will give it a shot, thanks for the suggestion.

Best regards,
Aaron

> > 
> > Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
> > ---
> >   kernel/sched/fair.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index f26d53ac143fe..be96f7d32998c 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5847,6 +5847,7 @@ static void throttle_cfs_rq_work(struct
> > callback_head *work)
> >   	struct cfs_rq *cfs_rq;
> >   	struct rq *rq;
> >   	struct rq_flags rf;
> > +	bool sched = false;
> > 
> >   	WARN_ON_ONCE(p != current);
> >   	p->sched_throttle_work.next = &p->sched_throttle_work;
> > @@ -5879,9 +5880,13 @@ static void throttle_cfs_rq_work(struct
> > callback_head *work)
> >   	dequeue_task_fair(rq, p, DEQUEUE_SLEEP | DEQUEUE_SPECIAL);
> >   	list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
> >   	resched_curr(rq);
> > +	sched = true;
> > 
> >   out_unlock:
> >   	task_rq_unlock(rq, p, &rf);
> > +
> > +	if (sched)
> > +		schedule();
> >   }
> > 
> >   void init_cfs_throttle_work(struct task_struct *p)
> 
> -- 
> Thanks and Regards,
> Prateek
> 

