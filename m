Return-Path: <linux-kernel+bounces-577361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A5AA71C16
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2CDC7A8BAD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC8D1F6664;
	Wed, 26 Mar 2025 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dum3kG8j"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DED31547E7
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007408; cv=none; b=ogf2GOfqXMsiVvEengI22ErcEhVhuIxMkV3OMl2wje5Q14ElMD3KCWRm6S7K3alu7r/y0dvviILQmlwkYevvtR5wVCoswV3dL2ebnXpm1/PMF8EUEkwfq+y5BJXr3CcCOlJ0fzEDjqbPTfvwjkTubggF3wQSgGdJh6iiZa1LCEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007408; c=relaxed/simple;
	bh=N7yedQXHCWJJSpkeX4sf2KRcR+qb7GITXxEytvJOQBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nlR0yT2f9vhEl9Oz3HLp8m5CESscdADIBJcmkHFGxtvuLSj/1THf6SJezMGk58TL7gymQ4Fzx1Oooy74NAvui+YpbqFUwlQcp854w32mJ8CebybZEDcGBH11Yhnpo4Sk6MWAkyYhb4Kh6ql4xNZLlt9eYqA5XFKFqTZ7X8tJdU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dum3kG8j; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e5e34f4e89so15078a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743007404; x=1743612204; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r3mHtuFS2L+ZA8HTWSpIHVhFAJlupWD9X5kq+E3WTzE=;
        b=Dum3kG8jhtxcr9TUNpztETbhvthz2oMR3+H11IotVlcmCondR9XHQ9QF0Bw50nyOA9
         UuAJwLIwC2orM8Htx3ea5+Xvphfycgok9ZsSQhABwpeEgmaps2H0IdM7pKFUya7Vq/ha
         NvZbfNGBF+g5fM2obUUwlctB6CRXszr3hIEnkSF4/i7OSsFhXr2kTq86l+LYEKF1x/1h
         9+g02MiU4WOL4WyfOg5zajS/mqYkyKoxbq8W9CzVz3YhvVC6APyzxJVq8WwaoqkABvz2
         OUJ9QyRvVt7qFm60f88vzfJkP6YPB/cMSwArWpdudJMbw60VbASQkd3URI35Gj8w6yjl
         zrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743007404; x=1743612204;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r3mHtuFS2L+ZA8HTWSpIHVhFAJlupWD9X5kq+E3WTzE=;
        b=L3mAVbnzEEFIg72703mi0uEc9RFFsaPH9d9xl52NSt3yiaGPzpqlIDoHb+Cue3ESlC
         a3FiO5JwqIH4MOt6XESraYt5uW/0SrQDm4ZQeKN8n+bpYX4ZVbO/fq1o9ZM48/+/Jc1S
         lryyLaUvwGzk+jgDhdViVMXz1LZzQd5lpAMhqlX6QOOCuMNLEnJVr+4I+140XYfbxfMn
         DKXoH/glRxH5BOHgTWepBcuCJ1ves7iWiWvZdcEj8IjXp/vg5sKPYmNHcCt+JNsYHgNZ
         48MHCcQ+h3WkjiE8SSDbe+1zTz7dm2sBdgpmFBX8YZkqXvmb1yPt0+Z+6ih4CHY6clY2
         kjqQ==
X-Gm-Message-State: AOJu0Yx4KG1+jG+Oaw0pOi1gVG3em2cajMIZTycedCdF3QZMH/RzTgmV
	ydbPQbAmYoaUHqGDOdnlA8H9dbPfduKfGCm2ThH4CUJ1B7fu6LnVzum/tfCCUfpzI85hdLHgH/9
	ElHrK589FlR8y1ufyzp3xK6z6WCN2muxrJQEOTA==
X-Gm-Gg: ASbGnctmmaA19E8M0oYimTjqc0qqgOk1vFFpJjw94HneLbR6xxyr2hWaiztoLyhQ3d6
	kODqEeZ1XCK7Sh5ngEu2sJJoRJ9exQTeAvX2xW+aAG5n8ofc7FDF5tooYCILDlmNfJsDAg5KlZc
	mPjbcq+U5XNBF04MOFr0e1N6uO1Jk9hyEqIF897P7Aa2j3eMHzDuw0bnV876ycXNRxug==
X-Google-Smtp-Source: AGHT+IGR8/THrp/6t8yZR3dpczgrHk4+FJ3mEQbOGCvq3ovK+tbifhcOivKucw9gQAaF0D/SVCyg7EWsKFkz6ZdP8+k=
X-Received: by 2002:a17:906:f59d:b0:ac3:2d47:f6af with SMTP id
 a640c23a62f3a-ac6faeb1b91mr9064666b.20.1743007403647; Wed, 26 Mar 2025
 09:43:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001134603.2758480-1-pierre.gondois@arm.com> <d629b646-d04b-4a26-86a2-34300dcd3e9f@arm.com>
In-Reply-To: <d629b646-d04b-4a26-86a2-34300dcd3e9f@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 26 Mar 2025 17:43:11 +0100
X-Gm-Features: AQ5f1Jrc3oRl6pP2bBCnGcuEEoHOIPC0KovEMFTFxqJ90QBF2lmmLhrOsrN00Rk
Message-ID: <CAKfTPtAPEma3DnKLY80zF2tSFxyT1MPPF+6w5vRkEVX4r5k0xA@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Fix integer underflow
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"

Hi Pierre,

On Tue, 25 Mar 2025 at 16:10, Pierre Gondois <pierre.gondois@arm.com> wrote:
>
> Hello Vincent,
>
> This patch should still be relevant, would it be possible to pick it ?
> Or maybe something is missing ?

Nothing is missing, the patch just got lost somewhere.

Ingo, Peter,
Could we take it once rc1 is published ?

Regards,
Vincent

>
> Regards,
> Pierre
>
> On 10/1/24 15:46, Pierre Gondois wrote:
> > (struct sg_lb_stats).idle_cpus is of type 'unsigned int'.
> > (local->idle_cpus - busiest->idle_cpus) can underflow to UINT_MAX
> > for instance, and max_t(long, 0, UINT_MAX) will output UINT_MAX.
> >
> > Use lsub_positive() instead of max_t().
> >
> > Fixes: 16b0a7a1a0af ("sched/fair: Ensure tasks spreading in LLC during LB")
> > cc: stable@vger.kernel.org
> > Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> > Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >   kernel/sched/fair.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 9057584ec06d..6d9124499f52 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -10775,8 +10775,8 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
> >                        * idle CPUs.
> >                        */
> >                       env->migration_type = migrate_task;
> > -                     env->imbalance = max_t(long, 0,
> > -                                            (local->idle_cpus - busiest->idle_cpus));
> > +                     env->imbalance = local->idle_cpus;
> > +                     lsub_positive(&env->imbalance, busiest->idle_cpus);
> >               }
> >
> >   #ifdef CONFIG_NUMA

