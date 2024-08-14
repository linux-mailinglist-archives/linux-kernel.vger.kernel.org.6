Return-Path: <linux-kernel+bounces-286472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61CA951B4A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EFF5282A4B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549D91B1404;
	Wed, 14 Aug 2024 12:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Inobs3uW"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90F1143887
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 12:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640353; cv=none; b=gh+Cfj7SEcSeKhfhInF4WQehk+KpMT/KUi1LUfduAzbSocgf96OCa8+1sqLfuxXMDXXt2ysWBxerYNeD0xDHGqkAR8h0oqHYZORPD32nbbLhIqrvJuWRdZddMXn4Tb4+KbYidSVkbPOuLygy9eN4zaL7rgfyEZ7t8MoqWKSYBtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640353; c=relaxed/simple;
	bh=b3AEekcdJVdjrCOZOQrx1PVyLLyRqsbjATJySLniWZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrIy7SE072mOouFTn8QRMqoQR/mdCG40+CdFWDiSBnBFhiGvfBOUBXMYxozf2IX/TJwcWftTF2Ie1g/1rm2oM0mu1ZuHBcQEc+f2M5G45RQfLgtaGYIbFt0m7URialcQYPX4cwJwyE1HKcWIn+z5Tr4bKim3+RrlOgOu0oMe0WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Inobs3uW; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d396fde759so1396809a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 05:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723640351; x=1724245151; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UbXEmr1hmgT9oEWNBko+hR4+Hi0A7ZEmMY6SVhV/xQc=;
        b=Inobs3uWdUQKvIluCLmGta5cL0SVDaSm2Sv7yeYiK5vgZqyvCDgk37NtWXuCVjZInz
         xA+p/naJB+KYFbH+fIeOd2lipg2iKLaPfEPhEQ2qaMtkb10evIDxEL/MCdhhvSph3J8E
         p0xI5MWPXYcQpv0GC0x2fhEQrFIAniTkTind1NOm9FWi0gaH53eHf1elr5GT7suxS5G5
         pHU3bYb2OJtWO5ZG8QZeI28k1avw0rRk49F/mYqzfM+yAMHdfanBqG/QenqIdOUwl64E
         kUjCsN2vm2u/80GO+Ca7mG+wTowkQG7oa11t/aO69KpaFzhLe+EW/Jqqqy6sHQbDBfHb
         Idow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723640351; x=1724245151;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbXEmr1hmgT9oEWNBko+hR4+Hi0A7ZEmMY6SVhV/xQc=;
        b=Fy7pY0ITPnkf1I2lG4MLW8xXFP1pcjzINTC1ioaxEhEaiFGpG+L8o4i9En0cBoHBf0
         UYHV1oonPIq3B4iIAm1mPPPCNGeDvac6F1VrTrq04QGU6/gzTI4VTNU/qq9NwDPn/EUB
         SDbSFU6CE+4ZNWrxCegCqa4SJrjP7pyLzSu4w5J69tmo0hJs9JWeeDp9KUsgXpIJT0QA
         rxVvDyZwdUXpYfdsSGjMzZjI5ua2f4e94FSG/rrFQiK4AZ2/FaYHOr93TUycMaSlZDvp
         j8d7Sk4uvWzG9ZqRYGtAp+FSGWYWuDYOCtnchnRaTMcc93fWz3nrmaZdl6WyvfCC92m5
         4mCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKF1ShOhfmgSrNymrJfnq4JI3Nr8T7J5m59B2t5rWMW0HWDT1D7J7aeTltEkp6/X8GgI0R04WWVgu6F/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4NByUsFbSlh0L1cVHzaktjEgN308Odlv41XLAQjAUH6c99ow8
	v2ZNWlcmTffDYrW0rBlLtVxIalqWFW3uQTsf5UV1modHH/f8arx7S34Wzcc5IJ6LMULYCpRs2s4
	bEntEOEKtisdVcUblvGEeJOZEt9Oyr2cSRay1Pg==
X-Google-Smtp-Source: AGHT+IFEtD6YW5+tdji/T9SCfpxzaDFLEwoqv4lXKCyMxs13JrbAia/ii67ngSKDjAwbyDh3+xLdMU+/JOF68Aqzezs=
X-Received: by 2002:a17:90b:1c01:b0:2c4:dfa6:df00 with SMTP id
 98e67ed59e1d1-2d3aaa79f94mr3315663a91.8.1723640351183; Wed, 14 Aug 2024
 05:59:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727102732.960974693@infradead.org> <20240727105030.514088302@infradead.org>
 <xhsmh7ccky4mr.mognet@vschneid-thinkpadt14sgen2i.remote.csb> <20240813221806.GB10328@noisy.programming.kicks-ass.net>
In-Reply-To: <20240813221806.GB10328@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 14 Aug 2024 14:59:00 +0200
Message-ID: <CAKfTPtBD3iyR3XSssQDAU=vkPs70tZLukvbwPYpnSv63ra_-Ew@mail.gmail.com>
Subject: Re: [PATCH 19/24] sched/eevdf: Fixup PELT vs DELAYED_DEQUEUE
To: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <vschneid@redhat.com>, mingo@redhat.com, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, linux-kernel@vger.kernel.org, kprateek.nayak@amd.com, 
	wuyun.abel@bytedance.com, youssefesmat@chromium.org, tglx@linutronix.de, 
	efault@gmx.de
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Aug 2024 at 00:18, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Aug 13, 2024 at 02:43:56PM +0200, Valentin Schneider wrote:
> > On 27/07/24 12:27, Peter Zijlstra wrote:
> > > Note that tasks that are kept on the runqueue to burn off negative
> > > lag, are not in fact runnable anymore, they'll get dequeued the moment
> > > they get picked.
> > >
> > > As such, don't count this time towards runnable.
> > >
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  kernel/sched/fair.c  |    2 ++
> > >  kernel/sched/sched.h |    6 ++++++
> > >  2 files changed, 8 insertions(+)
> > >
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -5388,6 +5388,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
> > >                       if (cfs_rq->next == se)
> > >                               cfs_rq->next = NULL;
> > >                       se->sched_delayed = 1;
> > > +                   update_load_avg(cfs_rq, se, 0);
> >
> > Shouldn't this be before setting ->sched_delayed? accumulate_sum() should
> > see the time delta as spent being runnable.
> >
> > >                       return false;
> > >               }
> > >       }
> > > @@ -6814,6 +6815,7 @@ requeue_delayed_entity(struct sched_enti
> > >       }
> > >
> > >       se->sched_delayed = 0;
> > > +   update_load_avg(cfs_rq, se, 0);
> >
> > Ditto on the ordering
>
> Bah, so I remember thinking about it and then I obviously go and do it
> the exact wrong way around eh? Let me double check this tomorrow morning
> with the brain slightly more awake :/
>
> > >  }
> > >
> > >  /*
> > > --- a/kernel/sched/sched.h
> > > +++ b/kernel/sched/sched.h
> > > @@ -816,6 +816,9 @@ static inline void se_update_runnable(st
> > >
> > >  static inline long se_runnable(struct sched_entity *se)
> > >  {
> > > +   if (se->sched_delayed)
> > > +           return false;
> > > +
> >
> > Per __update_load_avg_se(), delayed-dequeue entities are still ->on_rq, so
> > their load signal will increase. Do we want a similar helper for the @load
> > input of ___update_load_sum()?
>
> So the whole reason to keep then enqueued is so that they can continue
> to compete for vruntime, and vruntime is load based. So it would be very
> weird to remove them from load.

We only use the weight to update vruntime, not the load. The load is
used to balance tasks between cpus and if we keep a "delayed" dequeued
task in the load, we will artificially inflate the load_avg on this rq

Shouldn't we track separately the sum of the weight of delayed dequeue
to apply it only on vruntime update ?
>

