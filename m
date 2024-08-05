Return-Path: <linux-kernel+bounces-275423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A23194856E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 00:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C7D91C21FDA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 22:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D6F16D9CB;
	Mon,  5 Aug 2024 22:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="Ube3ZqWU"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A7814264C
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 22:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722896721; cv=none; b=KEmSCwJlUxCz1/NFCRlMVwijaQYZf39zbJi1Nw7sbnWywejfrHbe4g161EgDc76ZlhBbZK1PICMX/Ea66TQVscYxNIu0ZFHJ6/N0f5El13wPpnCoBnzf8bA4GlJzACYCC4M2YIdAWCCKHVAK5LFKz/uTku1ZyRetRRk3Th754hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722896721; c=relaxed/simple;
	bh=ZzV06iVhVfvDdshBGp/MHfU6JvneXfYLd4+1djwL45E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8Jskyyq5CGWu5PLuOUGNVD5SN/O4q+W1yG9Qt7GJAd5kC88VNgS63xbxzvH5NzuUm0yfBX/15/uO0vsMWGVtfNOmu9mbNZ4nOE0X6g708eZ0g1hn8Vj6EIZ8lMxjqZLK2z3bADNpwPlkzSq25i0UouGWRQ0NGZf9egD/oMiTVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=Ube3ZqWU; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-426526d30aaso172765e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 15:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1722896716; x=1723501516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=STIyiAiOJeSBfX9+H6J+2HL7jv/bBiTlB6eBeK0ViJc=;
        b=Ube3ZqWUf6zNimzpXpIlmDZqIieCNSQgkYbqOpNqgG/r8Ama6uQ1C019k4zAaB3h+r
         oLTvet5tOXcr49ILHxfe6xcgYJTPbx7j9+bcwMvi33TuOBDSohrh56kOzdcNEI+D2Hmv
         9WQ8M6yIciVgmnHnAFem13/uI5hijss14SsDBR3lyC5SJPjbH6GNsVDygo94tYDya5Up
         TI6jedfW6OLzmM5ADEF/IB6xwZAcUk0omdf7u+Fam2CuVfmKF4A3hcqCO+6/xSjFKtJ8
         MX44sJmT0SIDC6gh6zxT4JpUJMQqQYkwmWlGABMtOXJze9ggYrAjB+MR5aeGhLs81AXF
         5GLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722896716; x=1723501516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STIyiAiOJeSBfX9+H6J+2HL7jv/bBiTlB6eBeK0ViJc=;
        b=Tl1p9/pCsHYU/wfi7/0wIjHwIMRxXJz7XrfinokkABmGuWtfDorDG5xYYe4u9tsdwN
         fzyX2vkgQINdcK/cogCPHRiTEKcA0Zd0EQNq/APoxSO8AtrfoM20CciQG9liPy68t8Qc
         9GYZ2FRS2A2Qt7e08HSYBYOr3maLuvfAV/7Qf+4lYbcMSl+hIjoUh4E90/4gBWrwcvat
         LdhlYPHgUFUp/oarue+cEyLhHUERTiULJLIzWb6lkloE/Tdauyi0HX8YsnSZ4Y8utbu5
         Ay8AXTacD1KvY6nBUcWhyXV02mLqNsTmldaitlBxPOmiHozMt5tcbzFGao+6bHpxQRbc
         k+Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVBjkQI8AwMQybIs+Dt9eWYsJ54kZJReV2lWteFUhWkrxCQU0HVpsCWxT9JiErhgEWTrx1WH8Y1OrRyW7FBW/nSGiynW2wqvy6yqbsq
X-Gm-Message-State: AOJu0YzwL6yej500/X2dzeRs6YxO+Vroj/bxYAI/CvLXYT51pOnkM8dQ
	Gujon9RHnd5LH90/UX1ycpACgx6NE0A5KVuiD9cswGqrajYqvrZmGcPT0AJEvWY=
X-Google-Smtp-Source: AGHT+IFbcvvN2IxOzfFX1rgCiQ2c71waYNh5jDpedwSRkeyLJV5mPXKx4utT+QX6D+j+qh6jSt+HWg==
X-Received: by 2002:a5d:5e10:0:b0:36b:c638:abf2 with SMTP id ffacd0b85a97d-36bc638afb6mr7296351f8f.39.1722896716406;
        Mon, 05 Aug 2024 15:25:16 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf0c33bsm11113358f8f.22.2024.08.05.15.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 15:25:16 -0700 (PDT)
Date: Mon, 5 Aug 2024 23:25:15 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Chen Yu <yu.c.chen@intel.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched/pelt: Use rq_clock_task() for hw_pressure
Message-ID: <20240805222515.wshfsl3x4khc6ytg@airbuntu>
References: <20240729070029.407884-1-yu.c.chen@intel.com>
 <CAKfTPtD4Vg8rjWVAp=WnaCoMXkee6y2Vd7LT2FyMMtHGtORa5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtD4Vg8rjWVAp=WnaCoMXkee6y2Vd7LT2FyMMtHGtORa5w@mail.gmail.com>

On 08/05/24 12:56, Vincent Guittot wrote:
> Sorry for the late reply on this
> 
> On Mon, 29 Jul 2024 at 09:05, Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > commit 97450eb90965 ("sched/pelt: Remove shift of thermal clock")
> > removed the decay_shift for hw_pressure. This commit uses the
> > sched_clock_task() in sched_tick() while it replaces the
> > sched_clock_task() with rq_clock_pelt() in __update_blocked_others().
> 
> Good catch, it should be sched_clock_task() everywhere
> 
> > This could bring inconsistence. One possible scenario I can think of
> > is in ___update_load_sum():
> >
> > u64 delta = now - sa->last_update_time
> >
> > 'now' could be calculated by rq_clock_pelt() from
> > __update_blocked_others(), and last_update_time was calculated by
> > rq_clock_task() previously from sched_tick(). Usually the former
> > chases after the latter, it cause a very large 'delta' and brings
> > unexpected behavior.
> >
> > Fix this by using rq_clock_task() inside update_hw_load_avg(),
> > because:
> 
> No, don't call the rq_clock_task() inside update_hw_load_avg(), keep
> it outside. V2 was the correct solution

Curious, why this is not correct?

> Nack for this v3. Please come back on v2
> 
> > 1. hw_pressure doesn't care about invariance.
> > 2. avoid any inconsistence in the future.
> >
> > Fixes: 97450eb90965 ("sched/pelt: Remove shift of thermal clock")
> > Suggested-by: Qais Yousef <qyousef@layalina.io>
> > Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> > v2>v3:
> >   call rq_clock_task() inside update_hw_load_avg() to avoid any
> >   inconsistence in the future. (Qais Yousef)
> >   Added comments around update_hw_load_avg(). (Qais Yousef)
> > v1->v2:
> >   Added Hongyan's Reviewed-by tag.
> >   Removed the Reported-by/Closes tags because they are not related
> >   to this fix.(Hongyan Xia)
> > ---
> >  kernel/sched/core.c | 2 +-
> >  kernel/sched/fair.c | 2 +-
> >  kernel/sched/pelt.c | 5 +++--
> >  kernel/sched/pelt.h | 6 +++---
> >  4 files changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index a9f655025607..011d447e065f 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -5462,7 +5462,7 @@ void sched_tick(void)
> >
> >         update_rq_clock(rq);
> >         hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
> > -       update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
> > +       update_hw_load_avg(rq, hw_pressure);
> >         curr->sched_class->task_tick(rq, curr, 0);
> >         if (sched_feat(LATENCY_WARN))
> >                 resched_latency = cpu_resched_latency(rq);
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 9057584ec06d..193ac2c702d9 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9362,7 +9362,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
> >
> >         decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
> >                   update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
> > -                 update_hw_load_avg(now, rq, hw_pressure) |
> > +                 update_hw_load_avg(rq, hw_pressure) |
> >                   update_irq_load_avg(rq, 0);
> >
> >         if (others_have_blocked(rq))
> > diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> > index fa52906a4478..06a5fa85327c 100644
> > --- a/kernel/sched/pelt.c
> > +++ b/kernel/sched/pelt.c
> > @@ -400,9 +400,10 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
> >   *                     capped capacity a cpu due to a HW event.
> >   */
> >
> > -int update_hw_load_avg(u64 now, struct rq *rq, u64 capacity)
> > +int update_hw_load_avg(struct rq *rq, u64 capacity)
> >  {
> > -       if (___update_load_sum(now, &rq->avg_hw,
> > +       /* hw_pressure doesn't care about invariance */
> > +       if (___update_load_sum(rq_clock_task(rq), &rq->avg_hw,
> >                                capacity,
> >                                capacity,
> >                                capacity)) {
> > diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
> > index 2150062949d4..261172c29f8f 100644
> > --- a/kernel/sched/pelt.h
> > +++ b/kernel/sched/pelt.h
> > @@ -8,7 +8,7 @@ int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
> >  int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
> >
> >  #ifdef CONFIG_SCHED_HW_PRESSURE
> > -int update_hw_load_avg(u64 now, struct rq *rq, u64 capacity);
> > +int update_hw_load_avg(struct rq *rq, u64 capacity);
> >
> >  static inline u64 hw_load_avg(struct rq *rq)
> >  {
> > @@ -16,7 +16,7 @@ static inline u64 hw_load_avg(struct rq *rq)
> >  }
> >  #else
> >  static inline int
> > -update_hw_load_avg(u64 now, struct rq *rq, u64 capacity)
> > +update_hw_load_avg(struct rq *rq, u64 capacity)
> >  {
> >         return 0;
> >  }
> > @@ -202,7 +202,7 @@ update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
> >  }
> >
> >  static inline int
> > -update_hw_load_avg(u64 now, struct rq *rq, u64 capacity)
> > +update_hw_load_avg(struct rq *rq, u64 capacity)
> >  {
> >         return 0;
> >  }
> > --
> > 2.25.1
> >

