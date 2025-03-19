Return-Path: <linux-kernel+bounces-567569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADB5A687DB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4C13A88C8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F35B25332B;
	Wed, 19 Mar 2025 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BK4J3wuh"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49DD211486
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376401; cv=none; b=ES1erdsM+bhyXEzq+f5u5IkOH5B5H0AxE6scZHtSKlCe/QInhk2sJG6CBpfnwXX/oADbM/i1UewpopIf+8LlvoLV0mGiT1oYyvOTns8jUNe9GkUpP0mTAsTI8w52rY62OX1Ptcc3UMOEB6HKPMwWCyu80OBAsYyaaceQvPyR508=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376401; c=relaxed/simple;
	bh=0Kw2u6Sd+X50A15M8jPMDGGQzjFoolq3KL2QXXX7Sr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LMhidUB6xQSTqTvWuC4fFc82+A/qsBa+Nj5WhwbSXIbrdtBLpisgKyU745Sl0FzRkWy77uEBIE1ZhTiSk1DzA50O6jgWVCvDjcpQXVe7otzwYUjEBNJv4D+xskDopHf4A16dSJQRpOl0kFakNOP66AfnzVW3QrB+wlaDztwqbDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BK4J3wuh; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaecf50578eso46413766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 02:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742376398; x=1742981198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSUAZQZVW3jhxdptOmScTzhs7icSfbpe98mbAEHu2z4=;
        b=BK4J3wuhVmZ88rcz3WjuIcK1cgg8njSYsKYNwCcI8+I1LOe60TjxgXJ4QY/y93K/Yh
         d+qI4gjsH41QcUhQppRJ3gv8nU7v+klV92xPQMbkK2aek8js0kfRI8vC7+8qdpQhlFMo
         CW/luisnO0XFLC/DpmoYXTqiHCvEcoYoE+paTzeTguFCgCNDwaETedP8OkQGr+wQSZtL
         ATK5vqCIgFoETyck8+iMVd8Beu8hljrIQxszpXWPWtVAgJxhMVUBUpDHYVuKKKT/A8zt
         0BKGkDq5lokcUtOWrTWRDOGHmHR7pEyNlxKDqXkgqoUasf6sgPtuRNh1kyBMw9FfR3yA
         etMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742376398; x=1742981198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSUAZQZVW3jhxdptOmScTzhs7icSfbpe98mbAEHu2z4=;
        b=ivY8XGySIGYygBsNwmnp7Vq06XAH55oJAosLcENHfUPeW8uB0Z2wggsi42yuo1JYtU
         yoDKomuT6DuKcrwJ9nuuK3d4gQPCc6ISu7e77NHpYKLNLg4ZjtYo8a2sa2ZOQa1bAqA2
         7jmbHORhJiNRvSE4uohgju5MN8xVAZIfb8+XJk7XYFQCsmo3OghjAMxkcj5+gkfWcvKh
         UUBr8Mdf+1yOS2IWAn1hVI+NlL8Unh6OhAeyUgGj8KzvljwULofUxfyEpd14SV8u982W
         ogUV/d9gmI1qkXMsX/VgQ+tMd2g1Jtjx/UvCkO7j9oIsH1MWF0EEzPeZKQW+EAatQqCi
         omuA==
X-Forwarded-Encrypted: i=1; AJvYcCVGGR5cup5d4h3koaW5WQCm6ZRFjnLCxkNFcvu6iLEwXHsMtOlV+8HfIvzuXdqjeBfshvR37IP8JC7QKIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwiNFJEnzuPm9jth4BOJK+rTRuwzex8/2QsckvXT43+PUW1u0V
	BXUcA3UXs8JgESMvNSfQi0bEAkTutNRBVJ4+MQtVJqp064ugeRJCVd4u1ZrMufnt/TObASZHD/L
	OiOiVgIacFhLQxRhcY7GHx7gWoc0PIJ/O6eoFQKbEkpcVo3ZhSW4=
X-Gm-Gg: ASbGncskmy0ZaF63Ql9wUW5RwCugMtu4eI0qP60hVuTM1dKNNmE4Pik8mjAdBSzLB5x
	UMfM/bBFE1SqtbyLI/qTf6c0BOToZKOR6cOSzLQ7ranUP8ijcL6PaQY101crMNC+PeqW6p3cZJS
	m5PtWcgbfeKBnJ7tFukd9SMpQN
X-Google-Smtp-Source: AGHT+IFuypBC9+90QJnKqpF1hLuwOxL2P+M4EtdJRPUq0bV3s20s7KFlcyifTTo0pglI8oTs9S7q/UYIdylzRdAWrAs=
X-Received: by 2002:a17:907:bb4b:b0:ac3:2a77:cb4e with SMTP id
 a640c23a62f3a-ac3b7d7cbcbmr214002366b.13.1742376397807; Wed, 19 Mar 2025
 02:26:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318022358.195154-1-wujianyong@hygon.cn> <CAKfTPtA+41UxOi6C2fcgZ1mjaL19rBYi5Kidc6TSYLhNt3u1mw@mail.gmail.com>
 <a056a0ec6a4646fbb4a6e1a30bc2fcab@hygon.cn>
In-Reply-To: <a056a0ec6a4646fbb4a6e1a30bc2fcab@hygon.cn>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 19 Mar 2025 10:26:25 +0100
X-Gm-Features: AQ5f1Jqpodh-TA8gE0aQtntDbSsyqCcM_O0JAQZim__BBr-JSbb0gnMq8jzqLPk
Message-ID: <CAKfTPtAZ_unLKjg5rxDOonrRdz3-4fqV6uEyd3eGLT5SFEjdOA@mail.gmail.com>
Subject: Re: [PATCH] SCHED: scatter nohz idle balance target cpus
To: Jianyong Wu <wujianyong@hygon.cn>
Cc: "mingo@redhat.com" <mingo@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"jianyong.wu@outlook.com" <jianyong.wu@outlook.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Mar 2025 at 10:03, Jianyong Wu <wujianyong@hygon.cn> wrote:
>
>
>
> > -----Original Message-----
> > From: Vincent Guittot <vincent.guittot@linaro.org>
> > Sent: Wednesday, March 19, 2025 4:46 PM
> > To: Jianyong Wu <wujianyong@hygon.cn>
> > Cc: mingo@redhat.com; peterz@infradead.org; jianyong.wu@outlook.com;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] SCHED: scatter nohz idle balance target cpus
> >
> > On Tue, 18 Mar 2025 at 03:27, Jianyong Wu <wujianyong@hygon.cn> wrote:
> > >
> > > Currently, cpu selection logic for nohz idle balance lacks history
> > > info that leads to cpu0 is always chosen if it's in nohz cpu mask.
> > > It's not fair fot the tasks reside in numa node0. It's worse in the
> > > machine with large cpu number, nohz idle balance may be very heavy.
> >
> > Could you provide more details about why it's not fair for tasks that r=
eside on
> > numa node 0 ? cpu0 is idle so ilb doesn't steal time to other tasks.
> >
> > Do you have figures or use cases to highlight this unfairness ?
> >
> [Jianyong Wu]
> Yeah, here is a test case.
> In a system with a large number of CPUs (in my scenario, there are 256 CP=
Us), when the entire system is under a low load, if you try to bind two or =
more CPU - bound jobs to a single CPU other than CPU0, you'll notice that t=
he softirq utilization for CPU0 can reach approximately 10%, while it remai=
ns negligible for other CPUs. By checking the /proc/softirqs file, it becom=
es evident that a significant number of SCHED softirqs are only executed on=
 CPU0.

yes, but this 10% of softirq time would have been idle time otherwise
so why should we care ?

At the opposite, if all your cpus are busy, then cpu0 will do the busy
load balance of parents sched domain level whereas other cpus will not
and this time is stolen to the task running on CPU0 which could be
unfair compared to task running on other CPUS


> > >
> > > To address this issue, adding a member to "nohz" to indicate who is
> > > chosen last time and choose next for this round of nohz idle balance.
> > >
> > > Signed-off-by: Jianyong Wu <wujianyong@hygon.cn>
> > > ---
> > >  kernel/sched/fair.c | 9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c index
> > > c798d2795243..ba6930c79e25 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -7197,6 +7197,7 @@ static struct {
> > >         atomic_t nr_cpus;
> > >         int has_blocked;                /* Idle CPUS has blocked load
> > */
> > >         int needs_update;               /* Newly idle CPUs need their
> > next_balance collated */
> > > +       int last_cpu;                   /* Last cpu chosen to do nohz
> > idle balance */
> > >         unsigned long next_balance;     /* in jiffy units */
> > >         unsigned long next_blocked;     /* Next update of blocked loa=
d in
> > jiffies */
> > >  } nohz ____cacheline_aligned;
> > > @@ -12266,13 +12267,15 @@ static inline int find_new_ilb(void)
> > >
> > >         hk_mask =3D housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
> > >
> > > -       for_each_cpu_and(ilb_cpu, nohz.idle_cpus_mask, hk_mask) {
> > > +       for_each_cpu_wrap(ilb_cpu, nohz.idle_cpus_mask, nohz.last_cpu
> > > + + 1) {
> > >
> > > -               if (ilb_cpu =3D=3D smp_processor_id())
> > > +               if (ilb_cpu =3D=3D smp_processor_id() ||
> > > + !cpumask_test_cpu(ilb_cpu, hk_mask))
> > >                         continue;
> > >
> > > -               if (idle_cpu(ilb_cpu))
> > > +               if (idle_cpu(ilb_cpu)) {
> > > +                       nohz.last_cpu =3D ilb_cpu;
> > >                         return ilb_cpu;
> > > +               }
> > >         }
> > >
> > >         return -1;
> > > --
> > > 2.43.0
> > >

