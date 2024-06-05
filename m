Return-Path: <linux-kernel+bounces-202593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5858FCE65
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE4A01C252E5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB11F1B582C;
	Wed,  5 Jun 2024 12:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jQY4ivix"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAA11BC09B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717590172; cv=none; b=bfMpC9MD/LPNzaVOWmZz3RXcCQwdR6OgjUV/ySBY8zXePX+SI6tJB6LIwisSLAd1ZqxAQcczXmiZd5Ky3Dt7Cj110OW8a6N5I+OBcvSRl0UPCsA51UjriAEGxjJH79hxaom4PZQPvSOWv1ZlUYnjckF9pXwsUWJXETllYxpEfqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717590172; c=relaxed/simple;
	bh=rN6D+drnQ7oIKFqqWdEs/XbcUPdcu5n1hFir82M3sUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2rkwG4K1SOoqONyqQQLGNAzNuj+Q+IziO2OQ6osoHANOvCtjFBXAeHF1R+1lyI+awaPHvLYGmBCWkS47xWAm343ZG2idTMZW9XaGmWyf+DMgk7jEHnuX2JFc/C56rDqvPZbP1fMuigAmIXTWLp025YkRfKKqBavxIXjMMZRwmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jQY4ivix; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7025b253f64so3103825b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 05:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717590170; x=1718194970; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UN3odDsXiwuGQcA+cVOrXxYKDZzyHlwRnZKVdXaRoNc=;
        b=jQY4ivixelA+dkDYVxEkJX8/sgAJnR7vvnXlQNWm7F+30DAVEl/DMZc083kINGgsq0
         aVWjG8sOF0FIaHjQZW4GKCTr38+FxjN5rEbTY6upb7XQY0im5ou3wTi3wsPwzGz+OgkN
         hxjNI6XPFsX/kR9dAeeFF7POAPuID8ChN01H9uO6IAJqTWbB2ww9YrJN2kmHZu07+/Qd
         hxGL8/oV9c7zBAAB2QJ+gqJ1hn1biAxtEoMBt6mvMVLeoq1AODAIgD5CDcng2EjZmfZ3
         0ExBktGIKsI4r2fdenaD7uJUKD2VXvFGwcZZ1xk7JN2T4P94Aju2D5/qJVZPjd5WFoM3
         UAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717590170; x=1718194970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UN3odDsXiwuGQcA+cVOrXxYKDZzyHlwRnZKVdXaRoNc=;
        b=lg86kJlmGk1/cpuoGqDMnuIRbydHWiFUUJCDWSKab1nsjOJUn4N21aQHEHVMYS+aeS
         f9g/PDMRHlERcpnlq2ZEx1uUt1dsgx6bhIiES19LIkQfoOzVlVg09EFdvDGRuMwPvHMc
         sJOTh3RLzLTg/HlHWIA5pZyriO6MoMQbnkE4kUlWkXGO3f0i0wyFsANDusD8nnXCTzoH
         MqLUqWdEEsGyvE/3qBtLhtADObq0j6/PymXHc4OLQCk8L+PPX2+DHGW4w4yn+unnBjor
         ZLRHMKnEt/E2/Ovfr//JOnm/ugKyZlNklJ0dOmKFGy218i1nr11pHjkZNoFhw84S2T7Z
         jcjA==
X-Forwarded-Encrypted: i=1; AJvYcCXIheDA1WKn5YfecuOD8G3Pribs2Zksqg4C4y1ED/nWgoNm9/OAIHgDLhwOlYjvvHfyfq0IELUbI1YdcVu+rpBcRu2rB6jzZ2495fzq
X-Gm-Message-State: AOJu0Yxh0VO/mD+oDd4HHdLt9o3GwwgY2nI4ebT3ARdRgyipMM/sE/nV
	/wIGVcPaLv3HH3dWwPuPKreagnvPIy2iUyS+9ytGoR0m+swygCMz5GWASzdVC8HvSybv/rgVrF3
	IZ7WFdzzRAjCAIeah/Oi8Yr35U20o6bhwLvmbBg==
X-Google-Smtp-Source: AGHT+IEFuUkk7iV72uQp4EundUO1FNdJF6F+FGJKyAiU13YGj/6ybXK1CzgZlE6WDBW9tzU/j1RoXJwims62rqAHYpM=
X-Received: by 2002:a05:6a21:99a7:b0:1b2:3fc:9ab2 with SMTP id
 adf61e73a8af0-1b2b6e5999emr2911157637.1.1717590169870; Wed, 05 Jun 2024
 05:22:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530104653.1234004-1-qyousef@layalina.io> <20240601224017.qku2mhbaz4vsh3a3@airbuntu>
In-Reply-To: <20240601224017.qku2mhbaz4vsh3a3@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 5 Jun 2024 14:22:38 +0200
Message-ID: <CAKfTPtCHfnDAD-p_ScqHh7cZ=7AXDTw3fE0+ynMHNvCjuG8ogw@mail.gmail.com>
Subject: Re: [PATCH v5] sched: Consolidate cpufreq updates
To: Qais Yousef <qyousef@layalina.io>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, 
	Valentin Schneider <vschneid@redhat.com>, Christian Loehle <christian.loehle@arm.com>, 
	Hongyan Xia <hongyan.xia2@arm.com>, John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Qais,

On Sun, 2 Jun 2024 at 00:40, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 05/30/24 11:46, Qais Yousef wrote:
>
> > +static __always_inline void
> > +__update_cpufreq_ctx_switch(struct rq *rq, struct task_struct *prev)
> > +{
>
> I found a problem here. We should check if prev was sugov task. I hit a
> corner case where we were constantly switching between RT task and sugov.
>
>         if (prev && prev->dl.flags & SCHED_FLAG_SUGOV) {
>                 /* Sugov just did an update, don't be too aggressive */
>                 return;
>         }
>

I reran my test with this v5 and the fix above but the problem is
still there, it waits for the next tick to update the frequency
whereas the cpu was idle.

Also continuing here the discussion started on v2:

I agree that in the current implementation we are probably calling way
too much cpufreq_update, we can optimize some sequences and using the
context switch is a good way to get a better sampling but this is not
enough and we still need to call cpufreq_update in some other case
involving enqueue. The delay of waiting for the next tick is not
acceptable nor sustainable especially with 250 and lower HZ but I'm
pretty sure it would be the same for some system using 1000HZ. IIUC
new HW is becoming much more efficient at updating the frequency so it
would not be a problem for this new system to update performance more
frequently especially when it ends up being as simple as writing a
value in a memory region without waiting for it to be applied (like
cpufreq fast_switch methods). All this to say that always/only waiting
for context switch or tick might be suitable for your case but it
doesn't look like the right solution for all devices and systems

> > +#ifdef CONFIG_CPU_FREQ
> > +     /*
> > +      * RT and DL should always send a freq update. But we can do some
> > +      * simple checks to avoid it when we know it's not necessary.
> > +      *
> > +      * iowait_boost will always trigger a freq update too.
> > +      *
> > +      * Fair tasks will only trigger an update if the root cfs_rq has
> > +      * decayed.
> > +      *
> > +      * Everything else should do nothing.
> > +      */
> > +     switch (current->policy) {
> > +     case SCHED_NORMAL:
> > +     case SCHED_BATCH:
> > +             if (unlikely(current->in_iowait)) {
> > +                     cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT | SCHED_CPUFREQ_FORCE_UPDATE);
> > +                     return;
> > +             }
> > +
> > +#ifdef CONFIG_SMP
> > +             if (unlikely(rq->cfs.decayed)) {
> > +                     rq->cfs.decayed = false;
> > +                     cpufreq_update_util(rq, 0);
> > +                     return;
> > +             }
> > +#endif
> > +             return;
> > +     case SCHED_FIFO:
> > +     case SCHED_RR:
> > +             if (prev && rt_policy(prev->policy)) {
> > +#ifdef CONFIG_UCLAMP_TASK
> > +                     unsigned long curr_uclamp_min = uclamp_eff_value(current, UCLAMP_MIN);
> > +                     unsigned long prev_uclamp_min = uclamp_eff_value(prev, UCLAMP_MIN);
> > +
> > +                     if (curr_uclamp_min == prev_uclamp_min)
> > +#endif
> > +                             return;
> > +             }
> > +#ifdef CONFIG_SMP
> > +             /* Stopper task masquerades as RT */
> > +             if (unlikely(current->sched_class == &stop_sched_class))
> > +                     return;
> > +#endif
> > +             cpufreq_update_util(rq, SCHED_CPUFREQ_FORCE_UPDATE);
> > +             return;
> > +     case SCHED_DEADLINE:
> > +             if (current->dl.flags & SCHED_FLAG_SUGOV) {
> > +                     /* Ignore sugov kthreads, they're responding to our requests */
> > +                     return;
> > +             }
> > +             cpufreq_update_util(rq, SCHED_CPUFREQ_FORCE_UPDATE);
> > +             return;
> > +     default:
> > +             return;
> > +     }
> > +#endif
> > +}

