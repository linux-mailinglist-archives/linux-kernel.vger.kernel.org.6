Return-Path: <linux-kernel+bounces-260100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4A993A30B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5334628549E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CED155A55;
	Tue, 23 Jul 2024 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVI+B9R4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B393F15574F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745772; cv=none; b=W0eCxGbp51SJPVM00x6Zp7yZBls4lE1GCxgU0cccKtmZsZyK62dtKSO2vJMMop5lpCQNGZA6EUA4586nVi544rtu/17stS+PuC1xF61W94g1UI7quOMvK7490lfuN97gGw8P6OZmIlnRViSbLNDS1UvPxZRqcOy5ijyzwCnUs6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745772; c=relaxed/simple;
	bh=lG9RgmXhJCtvO6wgicdAyd9RWNSZCUZjg/dXD55cEl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfWBmQ6Lx8m+kJI+JIjJ1/yw0lfR/zsZAWdV7olinEUW2KtYaTaMIOTN7bpCxKAREjLXG/vSvqAgatqGCKDMU6pmghOinJcUSEtzQaZzriBBO7dj4uEaDIq14FSVOVCkLL0h57uO9w08KXihjF9/zFclJE6uk0b7fAxuRyM3j9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GVI+B9R4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721745769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YaUPHOqEAQapPEeUY+Q1djoiy+ILMGQR6AKUvhzDaEQ=;
	b=GVI+B9R4I4DducevUyMW0pH7FnEpOhagQ2orIo4u3h3TudvRyRnEL57iQ5OpwyGP6gYBR7
	Slh6emPeCt5gvqBEJiEmS0KGIS3SA1i4uX8bdM/7VeOMtLUdGDuUA9eCjxofACreeWGNlj
	hETqX8BWq1lU9pfPG7LN07jDSclqpsI=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-OV63WwCgMMKyPzbF3E4Lew-1; Tue, 23 Jul 2024 10:42:48 -0400
X-MC-Unique: OV63WwCgMMKyPzbF3E4Lew-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-4929b9c17feso1455535137.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 07:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745768; x=1722350568;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YaUPHOqEAQapPEeUY+Q1djoiy+ILMGQR6AKUvhzDaEQ=;
        b=vZkIuMVfk0a/HtPTy0etUkKOU9ieZupojl8wpFbx7fFPHiMpI4LtbIPEDI+Z/+FrlI
         FghEXf4FBvAAoIMZZcJo1j8KB4BOrh2QokztPE4m9L3CSLGZFEU+KZroZBC6vNV11yNB
         k5XPbKDPX8oX+ucZ2CniW0w0QTWWu0IZCk08SrolFVfOIVAcf3qDEIufcGb8VSIBj2rQ
         p3NgMdzvCY8w6sNp4MtLYBRZalfyE+aNwGs9GBDTq2reyrlsxIrjbshmqnnxyqjvtQj6
         Q9+4QX11vj+JsISVP3rn2iPyvw2TMKZ4sfwYGmOkM9Zku8Vi7hsdlSnFvEb6YuzGm7MI
         CQog==
X-Forwarded-Encrypted: i=1; AJvYcCWXaftzSQPVZIZDWZmoJbaGF41dk9WPovWWb03IZrYWhRBMkBlGF4/v8RK4XFnFergQh90hiJnFij5YnlEaSANe1xbkk+j/iBhItMf1
X-Gm-Message-State: AOJu0YwVFy8bjdXULjPEaTmzsiY/xeoqNF9a2NxQR+OLA+B4ZsdVfVL7
	Kx93+hgbvv4vMyP0Qy2KG9i8gBvsJxayTmqYsS0QPb3py+2lx501fBko0ViwOHnJxaciL5u+ME3
	rVM70Cfd5zBOpgybgc0K5UDx1BKA/VaF+fK8hWojqlNl0AMYKohG/Z5XTcuK6XQ==
X-Received: by 2002:a05:6102:3e05:b0:493:bf9b:166 with SMTP id ada2fe7eead31-493bf9b0a8amr734259137.3.1721745767886;
        Tue, 23 Jul 2024 07:42:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGygu+Nm1cQMiKKAvl1NMqK1pXN5NRVdqJNMgbBevF+bvsBpo508L5dgA/qZFOan0h65HogJA==
X-Received: by 2002:a05:6102:3e05:b0:493:bf9b:166 with SMTP id ada2fe7eead31-493bf9b0a8amr734231137.3.1721745767531;
        Tue, 23 Jul 2024 07:42:47 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.147.11])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a198faea7asm486936485a.19.2024.07.23.07.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:42:47 -0700 (PDT)
Date: Tue, 23 Jul 2024 16:42:42 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] sched/deadline: avoid redundant check for boosted
 task
Message-ID: <Zp_BYrWoGADj5gwa@jlelli-thinkpadt14gen4.remote.csb>
References: <20240722132935.14426-1-wander@redhat.com>
 <20240722132935.14426-3-wander@redhat.com>
 <Zp9v8gJ8nqyLkL1m@jlelli-thinkpadt14gen4.remote.csb>
 <CAAq0SU=s+UMZWXBfHWG4tPCM5VM35T6B0i+JcimbRXm0Q+ZvJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAq0SU=s+UMZWXBfHWG4tPCM5VM35T6B0i+JcimbRXm0Q+ZvJA@mail.gmail.com>

On 23/07/24 09:27, Wander Lairson Costa wrote:
> On Tue, Jul 23, 2024 at 5:55 AM Juri Lelli <juri.lelli@redhat.com> wrote:
> >
> > Hi Wander,
> >
> > On 22/07/24 10:29, Wander Lairson Costa wrote:
> > > enqueue_dl_entity only calls setup_new_dl_entity if the task is not
> > > boosted, so the WARN_ON check is unnecessary.
> > >
> > > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > > ---
> > >  kernel/sched/deadline.c | 11 ++++++++---
> > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > > index 312e8fa7ce94..908d5ce79425 100644
> > > --- a/kernel/sched/deadline.c
> > > +++ b/kernel/sched/deadline.c
> > > @@ -785,12 +785,11 @@ static inline void replenish_dl_new_period(struct sched_dl_entity *dl_se,
> > >   * one, and to (try to!) reconcile itself with its own scheduling
> > >   * parameters.
> > >   */
> > > -static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
> > > +static inline void __setup_new_dl_entity(struct sched_dl_entity *dl_se)
> > >  {
> > >       struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
> > >       struct rq *rq = rq_of_dl_rq(dl_rq);
> > >
> > > -     WARN_ON(is_dl_boosted(dl_se));
> > >       WARN_ON(dl_time_before(rq_clock(rq), dl_se->deadline));
> > >
> > >       /*
> > > @@ -809,6 +808,12 @@ static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
> > >       replenish_dl_new_period(dl_se, rq);
> > >  }
> > >
> > > +static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
> > > +{
> > > +     WARN_ON(is_dl_boosted(dl_se));
> > > +     __setup_new_dl_entity(dl_se);
> > > +}
> > > +
> >
> > So, the other call path is from dl_server_start() and for this we know
> > the entity is not boosted either. We could probably just remove the
> > WARN_ON w/o the additional wrapper function. That said, considering it's
> > not fast path, I wonder if we actually want to leave the WARN_ON where
> > it is, so that we can catch potential future erroneous usages?
> >
> 
> Yeah, if you feel the patch is not worth it, I am more in favor of
> dropping the patch than removing the WARN_ON.

Think we can drop it yes.

Thanks,
Juri


