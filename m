Return-Path: <linux-kernel+bounces-275438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DB89485BD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 00:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C30B01C21F4A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 22:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B97D16EBE2;
	Mon,  5 Aug 2024 22:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AD1frPve"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3269C16C696
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 22:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722898785; cv=none; b=qmn1Ufw64C5LaoTqGnpKxagHfcYaAzyMuyNJxLvure45zya9TIgmcd872CJkKzMFq0+IWi064TnzVfxIXp7qveiBJjh4PZhrlsZeUu8kRMiJcOFYxYpJIAnVPVNI15Is+dVKp1LGwKGwjZ72XT2BFloIB4xi25j4EU04tclfvTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722898785; c=relaxed/simple;
	bh=wDE2ZSOFrYCQh3xTvvw+mtJmqSs3hgf/JAk+Tmy33UI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o87VThXtEcgypQRr/3C6DsVZo5zWU0uRsVnakHHgxBwkT2wC530LSUjJdahv3ShtsY3V3CVezkHZrG877bVm7P1vw6u+zv4BpMUp6hEx3uSxenVkSNrQerqdthgTmt0/iDTzZFh+fwq4vN9t9JqiYL1R74daHTRqoPrHi5bOvGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AD1frPve; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2cb56c2c30eso4348656a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 15:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722898782; x=1723503582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ychv8P+gHxsBF6x+Pa2M4R3iLEXkc9nKsE+hso/AZWE=;
        b=AD1frPveAqCHq/wF3GwHGCLrcy/JKHwgolGOZLIyQT50g9Is++Q+LMC3a7kCCZ3vMe
         Bkx9aLxP7SZ35Sb4pTal+tML0DHWX4nGWmKFHvT5SYC4acMjrqjNIEz5Irno7WwHTgP5
         iWZ+olCKCchY0m5cvoiUlsaqMhQHE3XVsfQCiWXQygwMyqNZ9gAxMRIztkCNHzo9wxnb
         9U1h4y2yAByf4+UB56vSgxjSNLhKLfVDB9etSjlUvhMO7z3jSWr4omxcoELGBLubhM1d
         bIXeI4FpnEYDDsuEgzXkw4ZHGSDz7uwuj/VmUQ8vQGQDl//zCBo3dkGIirO6og4YsAUh
         wdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722898782; x=1723503582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ychv8P+gHxsBF6x+Pa2M4R3iLEXkc9nKsE+hso/AZWE=;
        b=MbF+tI3Ksy8ngU4qyMjCmF6WUo25lIYM9QjQwhLe0l1tVjDEHItBETkAmeNELDCd00
         xjeWcCd22bTcaSSLvehaCoECdvnFhfI4Ifm65QHV9KxrJ3AZee49AjFYHgW8sXT5mDGp
         KIPBwpDAHlWoHAulmDjdi8OVSUwm1JPycH3jk2XwGHsaZdHG/32hLV6l5ZjDT7+KqKAX
         VaaJADQSTOweAb9RiC1W62Npm1vF2+OoXMuX3zc01EDKDd/yVba8X/FCM3flh5e1yCW/
         9RIPJshfm+nmvVxBVjM/G9lbVWkkHLbVbpTWZ6xhmrn6H3a23zHecxb/4NsNXz3ID7Z4
         utKA==
X-Forwarded-Encrypted: i=1; AJvYcCXqGZCC40yngIwslT5IEIqXox6nBq5Z7aglkTJqfr5i4gsgKK5Dm/VaFjbHyyqyAOS8U+YXhjpYadhf0nJwT5igWIBdfZnltJN4QPv2
X-Gm-Message-State: AOJu0Yx/u7cwTAAPoKuVVK1ApyEnEWPJcpfs6h6iD8c82q8aKAwE4+HT
	QFeGj9snqmZnwlh8nGx3Tms1VgGi3odUBvmyWXWrOU5GljguwyJUx6Ys8kQrS/sw64vP7oJbjjx
	8ZjPRbszZ6i3ZZa962uzGF3BCRa+8rm0fi0pU6w==
X-Google-Smtp-Source: AGHT+IH8/fKH8YruVmhd08G2v0pY38l7ldBHESBue+KE50IqMJX0Fdkro8zj/EwtsiWmV4eJ2BDRm3nBlca77KkY6jM=
X-Received: by 2002:a17:90a:9a4:b0:2ab:8324:1b47 with SMTP id
 98e67ed59e1d1-2cffa292697mr20899102a91.15.1722898782204; Mon, 05 Aug 2024
 15:59:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729070029.407884-1-yu.c.chen@intel.com> <CAKfTPtD4Vg8rjWVAp=WnaCoMXkee6y2Vd7LT2FyMMtHGtORa5w@mail.gmail.com>
 <20240805222515.wshfsl3x4khc6ytg@airbuntu>
In-Reply-To: <20240805222515.wshfsl3x4khc6ytg@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 6 Aug 2024 00:59:31 +0200
Message-ID: <CAKfTPtCZiD7+WxCvrOYoiT+xMRGj=emJEa+RJeOC88h6wu0pwg@mail.gmail.com>
Subject: Re: [PATCH v3] sched/pelt: Use rq_clock_task() for hw_pressure
To: Qais Yousef <qyousef@layalina.io>
Cc: Chen Yu <yu.c.chen@intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Hongyan Xia <hongyan.xia2@arm.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Aug 2024 at 00:25, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 08/05/24 12:56, Vincent Guittot wrote:
> > Sorry for the late reply on this
> >
> > On Mon, 29 Jul 2024 at 09:05, Chen Yu <yu.c.chen@intel.com> wrote:
> > >
> > > commit 97450eb90965 ("sched/pelt: Remove shift of thermal clock")
> > > removed the decay_shift for hw_pressure. This commit uses the
> > > sched_clock_task() in sched_tick() while it replaces the
> > > sched_clock_task() with rq_clock_pelt() in __update_blocked_others().
> >
> > Good catch, it should be sched_clock_task() everywhere
> >
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
> > > Fix this by using rq_clock_task() inside update_hw_load_avg(),
> > > because:
> >
> > No, don't call the rq_clock_task() inside update_hw_load_avg(), keep
> > it outside. V2 was the correct solution
>
> Curious, why this is not correct?

Not correct in the sense that don't embed the clock in the pelt
function but keep it outside like others. The only one doing this is
update_irq_load_avg() which  is one my todo list for a while to be
aligned with others (just missing time)

>
> > Nack for this v3. Please come back on v2
> >
> > > 1. hw_pressure doesn't care about invariance.
> > > 2. avoid any inconsistence in the future.
> > >
> > > Fixes: 97450eb90965 ("sched/pelt: Remove shift of thermal clock")
> > > Suggested-by: Qais Yousef <qyousef@layalina.io>
> > > Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>
> > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > ---
> > > v2>v3:
> > >   call rq_clock_task() inside update_hw_load_avg() to avoid any
> > >   inconsistence in the future. (Qais Yousef)
> > >   Added comments around update_hw_load_avg(). (Qais Yousef)
> > > v1->v2:
> > >   Added Hongyan's Reviewed-by tag.
> > >   Removed the Reported-by/Closes tags because they are not related
> > >   to this fix.(Hongyan Xia)
> > > ---
> > >  kernel/sched/core.c | 2 +-
> > >  kernel/sched/fair.c | 2 +-
> > >  kernel/sched/pelt.c | 5 +++--
> > >  kernel/sched/pelt.h | 6 +++---
> > >  4 files changed, 8 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index a9f655025607..011d447e065f 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -5462,7 +5462,7 @@ void sched_tick(void)
> > >
> > >         update_rq_clock(rq);
> > >         hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
> > > -       update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
> > > +       update_hw_load_avg(rq, hw_pressure);
> > >         curr->sched_class->task_tick(rq, curr, 0);
> > >         if (sched_feat(LATENCY_WARN))
> > >                 resched_latency = cpu_resched_latency(rq);
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 9057584ec06d..193ac2c702d9 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -9362,7 +9362,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
> > >
> > >         decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
> > >                   update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
> > > -                 update_hw_load_avg(now, rq, hw_pressure) |
> > > +                 update_hw_load_avg(rq, hw_pressure) |
> > >                   update_irq_load_avg(rq, 0);
> > >
> > >         if (others_have_blocked(rq))
> > > diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> > > index fa52906a4478..06a5fa85327c 100644
> > > --- a/kernel/sched/pelt.c
> > > +++ b/kernel/sched/pelt.c
> > > @@ -400,9 +400,10 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
> > >   *                     capped capacity a cpu due to a HW event.
> > >   */
> > >
> > > -int update_hw_load_avg(u64 now, struct rq *rq, u64 capacity)
> > > +int update_hw_load_avg(struct rq *rq, u64 capacity)
> > >  {
> > > -       if (___update_load_sum(now, &rq->avg_hw,
> > > +       /* hw_pressure doesn't care about invariance */
> > > +       if (___update_load_sum(rq_clock_task(rq), &rq->avg_hw,
> > >                                capacity,
> > >                                capacity,
> > >                                capacity)) {
> > > diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
> > > index 2150062949d4..261172c29f8f 100644
> > > --- a/kernel/sched/pelt.h
> > > +++ b/kernel/sched/pelt.h
> > > @@ -8,7 +8,7 @@ int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
> > >  int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
> > >
> > >  #ifdef CONFIG_SCHED_HW_PRESSURE
> > > -int update_hw_load_avg(u64 now, struct rq *rq, u64 capacity);
> > > +int update_hw_load_avg(struct rq *rq, u64 capacity);
> > >
> > >  static inline u64 hw_load_avg(struct rq *rq)
> > >  {
> > > @@ -16,7 +16,7 @@ static inline u64 hw_load_avg(struct rq *rq)
> > >  }
> > >  #else
> > >  static inline int
> > > -update_hw_load_avg(u64 now, struct rq *rq, u64 capacity)
> > > +update_hw_load_avg(struct rq *rq, u64 capacity)
> > >  {
> > >         return 0;
> > >  }
> > > @@ -202,7 +202,7 @@ update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
> > >  }
> > >
> > >  static inline int
> > > -update_hw_load_avg(u64 now, struct rq *rq, u64 capacity)
> > > +update_hw_load_avg(struct rq *rq, u64 capacity)
> > >  {
> > >         return 0;
> > >  }
> > > --
> > > 2.25.1
> > >

