Return-Path: <linux-kernel+bounces-271218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 553F8944B31
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33841F2399E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553B51A00F8;
	Thu,  1 Aug 2024 12:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="xFtOJvpT"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC1519E7E0
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 12:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515023; cv=none; b=uVH7CNzpPS9c53iTS40JseQjHF14wytlAuLnlqTHOCSF7s2OMOXTJAj7jcCA4OwBeELtmGeOuvlU5N4yVaDbZlIqz3lLQ9GHf84kzqPZQ2/QVDPxLDWLiN/gRkUAYzqRk15bDGFaszykLNV4RLZiEqlqrtEtGu4tmARK8h27GBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515023; c=relaxed/simple;
	bh=214zRZ/VAGaMQ8qyt3P8tcGtr1gEuAJLy0l8ZuKT82M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5GTIW8LU2kCxlhAQoEnvTPFs+blUsP47r+sQ0bd0tsCxTe2hGxApMzF21TbLqQ4odUTZJg5QLh4WCm+tQgPIieQKHDxbvsRO0YjO/epZlq2fssyUMIcZCB6cBJ7u98wEWj/licFG1sHHQ42g4E7bpeEliMXrloMPxHFxW47ySw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=xFtOJvpT; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-369f68f63b1so3295912f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 05:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1722515020; x=1723119820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ue0eNqdaHpex8UihZBAt9VF3tST+4arUgqcUSI7gum4=;
        b=xFtOJvpTuOz2bJCzIdXdNcmI3nhpYVyMRgrIN9/ZNQl9/vRzP+T2n056krbixpOYvM
         fTjEeVMph4RoH5OuN0oZynF8kCrvNadK6Hf3+LdlEiyhDrauuiTR17R7D8mchuHZs2/o
         TMJvNFUIdkBIverhp/yx92pkVhLvuYXUAWVrXkN2dqYmfzMz4YRnussIL3nMgeWrW77o
         dW5n/g6P9LkKZwH5iT/lFsAa63nV/ZtWGZJCj2k+lx7Cr27sFT+wbuqgejyDPo4v16la
         2hbYMj4fJaRJ3y4iwaS7qvYVQ2NuUVtLzMxdqBII9yFv+HXSteywKQmqUA+WQTfhoPbX
         uKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722515020; x=1723119820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ue0eNqdaHpex8UihZBAt9VF3tST+4arUgqcUSI7gum4=;
        b=b/vSxVYCLVUJ/WdL5tq3KBQGwpdvLDZcVoeM2XEA1O9DTyKE3LhsipKUgNI34tz6n3
         RugcfA5ZEZs0/TWdmT/FlecBVcNC78wCYR7vOS3mpOtP/NCYGYgTffYCSmmXMmb2P47D
         ac1rhPnS4w22kqk9dNideNMBZZ1wf1oqq06gRBwQ6/bKXGJT0sc3AZW8+5SLeQxn3SsY
         fHwyNhgiMd/CPr5hYZZAxmvzbq7A5Z8yIC1e+fQaSUfBUQxcev53r2SgdAjC13lWl74E
         UniUDpvcbIPzB/zcrPEKfq+PAkuLfJ4Myhek72I03/vCYdofyA4d/g1Kr6knFhIUEtpi
         GCdg==
X-Forwarded-Encrypted: i=1; AJvYcCVFRLY0l6rRj+GOVdv8tJrGrhvSUb0paG32+1B6j4uaNGlt8OOPqGDUNEo9CTxhPSKcBBfLLhFo7aBlYsIXuVkOYhYd7AeK9iwD0noO
X-Gm-Message-State: AOJu0YzdNKUgMzL1qBvYsAhoz8fITjbmQjf3DcAiVwxBJdFbs8fb/sNB
	1DMTBY5qdvRKn/QQIbmjXGK7a6vQR2qPLEt5UNKIVcK+E7ZB3L2gHKp3PMpQAvs=
X-Google-Smtp-Source: AGHT+IELqlyHB80sYMkJXFbAKViNmjxK/lBhvamsUyC29Dx7wu3JRfOZ0KaoZ4OH24P9dF5e0GjTcQ==
X-Received: by 2002:a5d:5e04:0:b0:36b:b24b:d14f with SMTP id ffacd0b85a97d-36bb24c041emr1071804f8f.36.1722515020076;
        Thu, 01 Aug 2024 05:23:40 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b8f51eaf5sm5936103f8f.29.2024.08.01.05.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 05:23:39 -0700 (PDT)
Date: Thu, 1 Aug 2024 13:23:38 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/pelt: Use rq_clock_task() for hw_pressure
Message-ID: <20240801122338.rudyb7y2nw3w5jzv@airbuntu>
References: <20240725150820.376623-1-yu.c.chen@intel.com>
 <20240728201028.oylcxv3rwuihqugq@airbuntu>
 <Zqb+TeV1AaQSFMp8@chenyu5-mobl2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zqb+TeV1AaQSFMp8@chenyu5-mobl2>

On 07/29/24 10:28, Chen Yu wrote:
> Hi Qais,
> 
> thanks for taking a look,
> 
> On 2024-07-28 at 21:10:28 +0100, Qais Yousef wrote:
> > On 07/25/24 23:08, Chen Yu wrote:
> > > commit 97450eb90965 ("sched/pelt: Remove shift of thermal clock")
> > > removed the decay_shift for hw_pressure. This commit uses the
> > > sched_clock_task() in sched_tick() while it replaces the
> > > sched_clock_task() with rq_clock_pelt() in __update_blocked_others().
> > > This could bring inconsistence. One possible scenario I can think of
> > > is in ___update_load_sum():
> > > 
> > > u64 delta = now - sa->last_update_time
> > > 
> > > 'now' could be calculated by rq_clock_pelt() from
> > > __update_blocked_others(), and last_update_time was calculated by
> > > rq_clock_task() previously from sched_tick(). Usually the former
> > > chases after the latter, it cause a very large 'delta' and brings
> > > unexpected behavior.
> > > 
> > > Fixes: 97450eb90965 ("sched/pelt: Remove shift of thermal clock")
> > > Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>
> > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > ---
> > > v1->v2:
> > >   Added Hongyan's Reviewed-by tag.
> > >   Removed the Reported-by/Closes tags because they are not related
> > >   to this fix.(Hongyan Xia)
> > > ---
> > >  kernel/sched/fair.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 9057584ec06d..cfd4755954fd 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -9362,7 +9362,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
> > >  
> > >  	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
> > >  		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
> > > -		  update_hw_load_avg(now, rq, hw_pressure) |
> > > +		  update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure) |
> > 
> > NIT:
> > 
> > Wouldn't it be better to remove 'now' and call rq_clock_task() inside
> > update_hw_load_avg()? Adding a comment on why we should use this not clock_pelt
> > would be helpful too. hw_pressure doesn't care about invariance.
> >
> 
> OK, will do in the next version.
>  
> > ie:
> > 
> > update_hw_load_avg(rq, hw_pressure)
> > {
> > }
> > 
> > LGTM anyway. I think this is called most of the time from idle when clock_pelt
> > is synced with clock_task. So the impact is low, I believe.
> >
> 
> Yes, when the current task is found to be idle, clock_pelt is synced with
> clock_task by update_rq_clock(). While a case is that, in the softirq load balance,
> sched_balance_softirq()->sched_balance_update_blocked_averages()->__update_blocked_others()
> ->update_hw_load_avg() is not always called by the idle task, and clock_pelt has not been
> synced with clock_task yet.

Yes. I think it is less often happens from there though, that's why I said the
impact is low. But yes there's a problem.

