Return-Path: <linux-kernel+bounces-191296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 045D38D0978
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 19:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884091F22255
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB9A15EFDF;
	Mon, 27 May 2024 17:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="0DJ+9IAz"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329C7155CA7
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 17:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716831428; cv=none; b=VuzFFYbpu+Qh8E67/jplvb3Dt9JQWX9TRKIsawZ9RjLG5W9xyOvXJGsoQJPg6fWSDXE2Y8/PdGmFQe5Pt2jRp/V81vsobIZFFxjxtp8C/5ljj6fOeWJJT4iG7HrlwNfU2Aua2EfdqhIzeXyGThyF13HQYymHn+t7x9l3qpiAERU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716831428; c=relaxed/simple;
	bh=XI6erCDnrp+edCzPtCdt2hp9LgvvOZnP83lVYPYHph4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OaffY4vLWMKaGlxkaXbw7WJ7F4KcnXLtfbpA0UjkeAhtuiRbpRjB1tp6bBk0/Pwz/EuOWPddljXcLLxI3SnXtqApYyAzbHkzs4+iFIWnSoKlQ8lFLZiCT+aTPenXDDzgBDr7cgoH33bOJ6ShONp3fuIvLcxFeosi/Kd5TUt7sRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=0DJ+9IAz; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-354faf5f1b4so4172338f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 10:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1716831425; x=1717436225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hr18hpneNHT7XlkoThFD4j7gue3uN8Une2pu0eWpvNk=;
        b=0DJ+9IAzti2vugVYkKwZ+eJC/QJQBMTuE7BzanFIcrz86+S5rgwcYc8wUbHu0tc+0O
         wu0RYLQ4IUbKGdQy4+7VB+HtKxXkyj4RySCqJeCgRtr5lxhTp4bCuKsOCmCSXE0tIk10
         mYcf15pN735Pa1t4/yj0Y0eOEPI6ukHH89/wyS2VTveRXolA8FB3PGrQIhebf9Go57Bm
         6kgE9d2JEEUIEUA40Z8lNoXKByAbkbfnWYgqWYyM6g07H/desKIaXhyFOtjanSVomrx6
         pVG4OC4XizNAzfhFHSLmJs/KCIDU+nl6Kno0jQTwWvecS6yiqGk2vscEPjxkgURFCwO7
         +xuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716831425; x=1717436225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hr18hpneNHT7XlkoThFD4j7gue3uN8Une2pu0eWpvNk=;
        b=hBmXls3Kyk4w4ZcF9ZikmiXPCXvDNLdo8XA6hexd1UHbI1WL/w069DMgjRzJO3pIlE
         NNT4fnuLa1PC73Y4Xnjbb26OKfBAJf8Zwj5xeGc3U8u8jR6Yla51WDoiC7UMi7E2tKVi
         eupF4vrPR628oBIHBvmzLsoq23NNPNhv9Z0W90xx8y4ybxjUkj7BqpQZlk2nvHLm2dnU
         DtxnXvlSEbIAgW2Fu/qM9pmGND2/xUs1Hzf9nq3xd/uJdsEONgszW5Q+CU6zzQF0E02p
         LovQUG/yvUTx9OJyj2Bl6oxpsNEr2uBbXeWqfGju67smPWLQsQS1BYp29kOb3cKm4KHl
         Jxqw==
X-Forwarded-Encrypted: i=1; AJvYcCWUqJ7+uA9IlGGcoZlxcCN7ERx2DSWMJEQmQOJqcAUmbBPRgIMUoEPwLoZcecBHuLf5ShjE/WX+p4k5X5wcpp2meFnFwpISn4apT5so
X-Gm-Message-State: AOJu0YzL+9xyPnC5XQBUjmp1M7KacVLuSEe/NnhpakqygE58XWXRwD4J
	khIeXm8N2/gVHY3yUSPYvcC3KxRp/K1CKt6FjzXRdPuPUi01J6eEFYv1Zb3rwII=
X-Google-Smtp-Source: AGHT+IFHCdjZfBLADJgWvonL4PKkMzOE4//76Gn2zYKCwqPkEaCY0W71oc+vzFaisXznPhCsroiviQ==
X-Received: by 2002:a05:6000:1001:b0:354:db70:3815 with SMTP id ffacd0b85a97d-355270567abmr9685956f8f.7.1716831425563;
        Mon, 27 May 2024 10:37:05 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a1c9530sm9512807f8f.81.2024.05.27.10.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 10:37:05 -0700 (PDT)
Date: Mon, 27 May 2024 18:37:03 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2] sched/rt: Clean up usage of rt_task()
Message-ID: <20240527173703.52wsstp5dnczaxrv@airbuntu>
References: <20240515220536.823145-1-qyousef@layalina.io>
 <20240523114540.2856c109@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523114540.2856c109@gandalf.local.home>

On 05/23/24 11:45, Steven Rostedt wrote:
> On Wed, 15 May 2024 23:05:36 +0100
> Qais Yousef <qyousef@layalina.io> wrote:
> > diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
> > index df3aca89d4f5..5cb88b748ad6 100644
> > --- a/include/linux/sched/deadline.h
> > +++ b/include/linux/sched/deadline.h
> > @@ -10,8 +10,6 @@
> >  
> >  #include <linux/sched.h>
> >  
> > -#define MAX_DL_PRIO		0
> > -
> >  static inline int dl_prio(int prio)
> >  {
> >  	if (unlikely(prio < MAX_DL_PRIO))
> > @@ -19,6 +17,10 @@ static inline int dl_prio(int prio)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Returns true if a task has a priority that belongs to DL class. PI-boosted
> > + * tasks will return true. Use dl_policy() to ignore PI-boosted tasks.
> > + */
> >  static inline int dl_task(struct task_struct *p)
> >  {
> >  	return dl_prio(p->prio);
> > diff --git a/include/linux/sched/prio.h b/include/linux/sched/prio.h
> > index ab83d85e1183..6ab43b4f72f9 100644
> > --- a/include/linux/sched/prio.h
> > +++ b/include/linux/sched/prio.h
> > @@ -14,6 +14,7 @@
> >   */
> >  
> >  #define MAX_RT_PRIO		100
> > +#define MAX_DL_PRIO		0
> >  
> >  #define MAX_PRIO		(MAX_RT_PRIO + NICE_WIDTH)
> >  #define DEFAULT_PRIO		(MAX_RT_PRIO + NICE_WIDTH / 2)
> > diff --git a/include/linux/sched/rt.h b/include/linux/sched/rt.h
> > index b2b9e6eb9683..a055dd68a77c 100644
> > --- a/include/linux/sched/rt.h
> > +++ b/include/linux/sched/rt.h
> > @@ -7,18 +7,43 @@
> >  struct task_struct;
> >  
> >  static inline int rt_prio(int prio)
> > +{
> > +	if (unlikely(prio < MAX_RT_PRIO && prio >= MAX_DL_PRIO))
> > +		return 1;
> > +	return 0;
> > +}
> > +
> > +static inline int realtime_prio(int prio)
> >  {
> >  	if (unlikely(prio < MAX_RT_PRIO))
> >  		return 1;
> >  	return 0;
> >  }
> 
> I'm thinking we should change the above to bool (separate patch), as
> returning an int may give one the impression that it returns the actual
> priority number. Having it return bool will clear that up.
> 
> In fact, if we are touching theses functions, might as well change all of
> them to bool when returning true/false. Just to make it easier to
> understand what they are doing.

I can add a patch on top, sure.

> 
> >  
> > +/*
> > + * Returns true if a task has a priority that belongs to RT class. PI-boosted
> > + * tasks will return true. Use rt_policy() to ignore PI-boosted tasks.
> > + */
> >  static inline int rt_task(struct task_struct *p)
> >  {
> >  	return rt_prio(p->prio);
> >  }
> >  
> > -static inline bool task_is_realtime(struct task_struct *tsk)
> > +/*
> > + * Returns true if a task has a priority that belongs to RT or DL classes.
> > + * PI-boosted tasks will return true. Use realtime_task_policy() to ignore
> > + * PI-boosted tasks.
> > + */
> > +static inline int realtime_task(struct task_struct *p)
> > +{
> > +	return realtime_prio(p->prio);
> > +}
> > +
> > +/*
> > + * Returns true if a task has a policy that belongs to RT or DL classes.
> > + * PI-boosted tasks will return false.
> > + */
> > +static inline bool realtime_task_policy(struct task_struct *tsk)
> >  {
> >  	int policy = tsk->policy;
> >  
> 
> 
> 
> > diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
> > index 0469a04a355f..19d737742e29 100644
> > --- a/kernel/trace/trace_sched_wakeup.c
> > +++ b/kernel/trace/trace_sched_wakeup.c
> > @@ -545,7 +545,7 @@ probe_wakeup(void *ignore, struct task_struct *p)
> >  	 *  - wakeup_dl handles tasks belonging to sched_dl class only.
> >  	 */
> >  	if (tracing_dl || (wakeup_dl && !dl_task(p)) ||
> > -	    (wakeup_rt && !dl_task(p) && !rt_task(p)) ||
> > +	    (wakeup_rt && !realtime_task(p)) ||
> >  	    (!dl_task(p) && (p->prio >= wakeup_prio || p->prio >= current->prio)))
> >  		return;
> >  
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks!

--
Qais Yousef

> 
> 

