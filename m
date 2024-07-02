Return-Path: <linux-kernel+bounces-237848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 420AC923EE9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA774B2206C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EB11B47B5;
	Tue,  2 Jul 2024 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g2UENySI"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CAC1BA08D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926743; cv=none; b=PM0Vw1YUpPnsWXRlZv2uqfnSmTJrBxuB5bLTKb2ao8YbFheVVLKHMipvC6xgA5ZA5+WzaACRPOuiG2J/sqXBmxmYU/EhCz5NIrUsLlxzLTmWvZt9ndE6ZpGGd1qekA1YdsP0mA1Jd/tJTAFJvgbVTEClcTV/wB1j5DdXpbMM4kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926743; c=relaxed/simple;
	bh=LDbBMgURoimPN8pnzhNAdm0t9sywKUzDkH05WXpy9+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MlPlYsUrBj1+bBRnmFzhf3THy/2tz/pt6hyfdgB16BaLj1IyDt7rK9iJsaxZCZVqptLQlbFI4ByVtmGGgbaKjllxFd4w2ozLQsMt1RrM1DWBGW9g9g31PUO9ewyWnWCFfILBao/07KzmLv90sQ1IRjumlXScwEDrPv/tdE6+VAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g2UENySI; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7066c9741b7so2539297b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 06:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719926741; x=1720531541; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eKrbYmlryvrrza+SxvqUJ8Kw/3hJWfiKxWp/gumJk80=;
        b=g2UENySI8HFTlJbjmAYm/QiZdLCxC1yvElI/J95WiTNiVoexRZlrvcgqAsnxvP7oC2
         SMwkzlvKY9B2YoeSw99tSsS2alH0U+2317ytLEkxv2XLFyo0xz1/NhWnL86ATTcKZXuj
         H/2GwY5XtFunGJ23OkzvQWG0yypflBq2q0Wloh5+XC+VsO37pf8hxaZwUXcR5MrQ++9d
         eGhl0G+ab3w/SN1fzZmYSNICrPG9TesVEB/X8UtQbMJZLp3M1kv7tSI4PR6KeFDk1lCq
         W3BbYgzc1FTQkN4GHwhFJg3t32ZKxWkY/A30SrIwFhweZg+j8DuWlCsPX66xr+rxtOLS
         b8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719926741; x=1720531541;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eKrbYmlryvrrza+SxvqUJ8Kw/3hJWfiKxWp/gumJk80=;
        b=X3KVSZd11fKBRswZt7Fli++mlfAGlYYeLlziMv+v8bMEBh1T6nB1AO8nf1L+BRlu37
         JsDT4hJESdGPOb88uIBsZ+VpNSaFWt9xK80XZ94ekn9hJfOvZKmens+7yDwGshxnL5Vw
         I6KNdzc47uQ6WaYt9QUPhGrZTfv+QLtFsOZ31hUPEpNkT2wcaEPXqNO42IwFShlY2UQB
         9sIMuDtUHNTDX/nnwLU+DLEjey8Zn/cXYpWlswQBBw7+ue0hmWE5E8nZzZ3hl46Yk7EX
         38rEjMM9JxxUAOP4kWHJFj8bN8dWXwQXrUWDPIggZEFntA8ZS5xTftdKqE98Xce1QCGO
         +4bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlU6DxNUvwhMsy1g6lrpwmf81QoPEtDm/Qtqqlvo0UUrl7hhx+/11BpT/VVH0pGYHb4Vx3VSf3L8GqFrUCbUB3iOLgdm4GE9llNYV4
X-Gm-Message-State: AOJu0YxIkojdg4YnnjtpTE+CFbS7FazIKU4hCUJ0IOwDSCI1BibdQYRG
	fI2mCW+Q1fIUvv5mPeqOhZhxyM4YFfCZ+OSyKWfjPTJOMWriBBJxf7LxRbmZYpGycKGQUWhltcp
	eE08K0otkZoQ3Cjv+a495Mo9vyKNkW6MB/g1A8Q==
X-Google-Smtp-Source: AGHT+IH2jsMeeJ7hhaJ9eZiUnwgxIWqwHKuYFmZWuJEUw4Q2J3DcFYMPakqScS2mtSeVsrzkTEUaYaxN+8Il3PKIaQA=
X-Received: by 2002:a05:6a20:7285:b0:1be:e0ed:6b49 with SMTP id
 adf61e73a8af0-1bef60f3d38mr8464078637.3.1719926740802; Tue, 02 Jul 2024
 06:25:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624082011.4990-1-xuewen.yan@unisoc.com> <20240624082011.4990-3-xuewen.yan@unisoc.com>
 <20240628012832.37swdtxr4ds2kkp7@airbuntu>
In-Reply-To: <20240628012832.37swdtxr4ds2kkp7@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 2 Jul 2024 15:25:28 +0200
Message-ID: <CAKfTPtALDtnbPmq4401oLKzcEDurLKuCyqyNKOb1oYLAVJ2P4A@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] sched/fair: Use actual_cpu_capacity everywhere in util_fits_cpu()
To: Qais Yousef <qyousef@layalina.io>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, dietmar.eggemann@arm.com, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	christian.loehle@arm.com, vincent.donnefort@arm.com, ke.wang@unisoc.com, 
	di.shen@unisoc.com, xuewen.yan94@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Jun 2024 at 03:28, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 06/24/24 16:20, Xuewen Yan wrote:
> > Commit f1f8d0a22422 ("sched/cpufreq: Take cpufreq feedback into account")
> > introduced get_actual_cpu_capacity(), and it had aggregated the
> > different pressures applied on the capacity of CPUs.
> > And in util_fits_cpu(), it would return true when uclamp_max
> > is smaller than SCHED_CAPACITY_SCALE, althought the uclamp_max
> > is bigger than actual_cpu_capacity.
> >
> > So use actual_cpu_capacity everywhere in util_fits_cpu() to
> > cover all cases.
> >
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > ---
> >  kernel/sched/fair.c | 19 +++++++++----------
> >  1 file changed, 9 insertions(+), 10 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 5ca6396ef0b7..9c16ae192217 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4980,7 +4980,7 @@ static inline int util_fits_cpu(unsigned long util,
> >                               int cpu)
> >  {
> >       unsigned long capacity = capacity_of(cpu);
> > -     unsigned long capacity_orig;
> > +     unsigned long capacity_actual;
> >       bool fits, uclamp_max_fits;
> >
> >       /*
> > @@ -4992,15 +4992,15 @@ static inline int util_fits_cpu(unsigned long util,
> >               return fits;
> >
> >       /*
> > -      * We must use arch_scale_cpu_capacity() for comparing against uclamp_min and
> > +      * We must use actual_cpu_capacity() for comparing against uclamp_min and
> >        * uclamp_max. We only care about capacity pressure (by using
> >        * capacity_of()) for comparing against the real util.
> >        *
> >        * If a task is boosted to 1024 for example, we don't want a tiny
> >        * pressure to skew the check whether it fits a CPU or not.
> >        *
> > -      * Similarly if a task is capped to arch_scale_cpu_capacity(little_cpu), it
> > -      * should fit a little cpu even if there's some pressure.
> > +      * Similarly if a task is capped to actual_cpu_capacity, it should fit
> > +      * the cpu even if there's some pressure.
>
> This statement is not clear now. We need to be specific since
> actual_cpu_capacity() includes thermal pressure and cpufreq limits.
>
> /even if there's some pressure/even if there is non OPP based pressure ie: RT,
> DL or irq/?
>
> >        *
> >        * Only exception is for HW or cpufreq pressure since it has a direct impact
> >        * on available OPP of the system.
> > @@ -5011,7 +5011,7 @@ static inline int util_fits_cpu(unsigned long util,
> >        * For uclamp_max, we can tolerate a drop in performance level as the
> >        * goal is to cap the task. So it's okay if it's getting less.
> >        */
> > -     capacity_orig = arch_scale_cpu_capacity(cpu);
> > +     capacity_actual = get_actual_cpu_capacity(cpu);
> >
> >       /*
> >        * We want to force a task to fit a cpu as implied by uclamp_max.
> > @@ -5039,7 +5039,7 @@ static inline int util_fits_cpu(unsigned long util,
> >        *     uclamp_max request.
> >        *
> >        *   which is what we're enforcing here. A task always fits if
> > -      *   uclamp_max <= capacity_orig. But when uclamp_max > capacity_orig,
> > +      *   uclamp_max <= capacity_actual. But when uclamp_max > capacity_actual,
> >        *   the normal upmigration rules should withhold still.
> >        *
> >        *   Only exception is when we are on max capacity, then we need to be
> > @@ -5050,8 +5050,8 @@ static inline int util_fits_cpu(unsigned long util,
> >        *     2. The system is being saturated when we're operating near
> >        *        max capacity, it doesn't make sense to block overutilized.
> >        */
> > -     uclamp_max_fits = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
> > -     uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_orig);
> > +     uclamp_max_fits = (capacity_actual == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
>
> We should use capacity_orig here. We are checking if the CPU is the max
> capacity CPU.

I was also wondering what would be the best choice there. If we
consider that we have only one performance domain with all max
capacity cpus then I agree that we should keep capacity_orig as we
can't find a better cpu that would fit. But is it always true that all
max cpu are tied to the same perf domain ?

>
> > +     uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_actual);
> >       fits = fits || uclamp_max_fits;
> >
> >       /*
> > @@ -5086,8 +5086,7 @@ static inline int util_fits_cpu(unsigned long util,
> >        * handle the case uclamp_min > uclamp_max.
> >        */
> >       uclamp_min = min(uclamp_min, uclamp_max);
> > -     if (fits && (util < uclamp_min) &&
> > -         (uclamp_min > get_actual_cpu_capacity(cpu)))
> > +     if (fits && (util < uclamp_min) && (uclamp_min > capacity_actual))
> >               return -1;
> >
> >       return fits;
> > --
> > 2.25.1
> >

