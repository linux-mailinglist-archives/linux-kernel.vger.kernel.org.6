Return-Path: <linux-kernel+bounces-348617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C95498E9B8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A817E1F2400E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 06:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA867A724;
	Thu,  3 Oct 2024 06:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xjcP8E8Q"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E33EB67A
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 06:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727936834; cv=none; b=M2G5yneTwS/6saFWY/wzioBfJSNlWCsAc7qATrTIxevITfHaLBawaWAcRoUc5FC5MgChhudFPZYP80H1DIOysoKJAgZPXqNfQqVdlv3zEfPjLbMW1Iu9yCh5YuKz8qlos8LNbtcSm2Idlv3s1somr4awNLkB1BgAvtU18HHUeM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727936834; c=relaxed/simple;
	bh=AgVdJowGkzor64rGl6LHUfpvrMIliagSW+r3SgfgSmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2SIu3I1WkTyu9zVq3VfINEJFSthCWD1T2J1vQQlHpftvXTHr+aC6xPixsqtHBMcJt3lR05Mx2SXZQMKCg7cHKBRGx+fPR745zto0p2cLTJKvXpGDy3k+FOd3LtTUBMo0pIH+DZnXWyZgiR8uyyhcHIs9PCGzHrene+vTQ6x4mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xjcP8E8Q; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e0a74ce880so546289a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 23:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727936832; x=1728541632; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vQjT5Am4n/E3xikTmt9haMIzMh32HFTARiYogm0jnPk=;
        b=xjcP8E8QqmKJLGtlkUkfliGkR5GhCNatBd44c9ayS7naAut61jZTTa+K5iSB8jMdfO
         TZeu68rhC3Av7HhaMwUGKHqkO/ihunT74fLN3uku3+YBtBlJeZI7862PYY0uEd7CK53h
         V+J7jtF6wKLQbl+I8N4iv6HBPhdUflKmfuvCA+PZRR2hY5l0+JmCky3JckUKxSLBpJvK
         Q33aAwkNOxh7bUBeId7mXANi9LBYyakOqqbpV3Wp2GTBp9axKEPhxeG6YUaxxJOoRxND
         VrdxpxVnK2br4LWuWzo5LDg+qJkll0tqnuQ+kIUrbH7a7DQMd86O3lglmroh51HPHksX
         nm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727936832; x=1728541632;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQjT5Am4n/E3xikTmt9haMIzMh32HFTARiYogm0jnPk=;
        b=rMTIkSnHg4a+TaaK4eZo/L8Xqa6i4iafAG12GgjKMaHCg8+/vTglkhe1bqMxTOXs69
         I9n0YmRUl1dcsAkBdQuf8QwPSP8FQPyQgfG8ZjPAX4dL/6KuoNw7lUtZHUV9JTvJUfb6
         ahWZs7rNoNij27efsta6ezBDUc1bjOdyFCVXm+iA+lSTBpbSpNititXsLwtXhwx27pLh
         cW5t/bqODhKa4HJOFgGVwTKX2qrVLYyh50Uk4viaEsbERR4ee4TFpTnC2I7Re3QW6x5b
         MXj/g1+9l99/ZiZM+nAJvz2fOaZulcwiZamOio0wHL2070Y64Fb7jeR9sR8dU1rC/L69
         YJzA==
X-Forwarded-Encrypted: i=1; AJvYcCVmb+kU5tUikcfTdejvKcz+Sjeaw3xk8d0cs2APHWI8zcMEkNJLYoGXMxLXUV2EZAgvTVYVKO7P79+4XGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiIgX88g2UNEF0omPF5a6OdlfzXU3jjJ4Lycd+xQ+rd7XTaISZ
	nmz85IE+KFkuLtSLAo42m0Et7TOdcWQvkJP2+Lg7g0h2RLfmrhx6czu7NXRgHctgMC1zo7hmksQ
	m/PXbdFyVm3wz/pYQfZRENPrNzz85PcXleGh3CA==
X-Google-Smtp-Source: AGHT+IG81uZw+KPCCmh+o2aSFU2gw418toVRtcmgIQLXXwbvow4AkmOlfshMNNjMNwoKZvr8ydd+BdqA/HGD6KT3TPI=
X-Received: by 2002:a17:90b:19c5:b0:2cf:fe5d:ea12 with SMTP id
 98e67ed59e1d1-2e1846ec822mr7696206a91.24.1727936832386; Wed, 02 Oct 2024
 23:27:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-5-vincent.guittot@linaro.org> <Zu2gHOv7mqArWXLZ@google.com>
 <CAKfTPtCvwPq+8pQcTZePiee9EXxKAQS=J57X2OavWFrQwkDt5A@mail.gmail.com>
 <ZvUlB8s-zIkDQji7@google.com> <CAKfTPtAzG7u0+e=8skMhnCETVxbDTOxT-zLaoqUXB-Zz5=4t+A@mail.gmail.com>
 <Zvw2O4JGBpMXwOZA@google.com>
In-Reply-To: <Zvw2O4JGBpMXwOZA@google.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 3 Oct 2024 08:27:00 +0200
Message-ID: <CAKfTPtDOhNmL0Nn3g-agnL5HH5nhwXb3-sfzydEe4nvRKAq3HQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] sched/fair: Use EAS also when overutilized
To: Quentin Perret <qperret@google.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, lukasz.luba@arm.com, 
	rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, qyousef@layalina.io, 
	hongyan.xia2@arm.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Oct 2024 at 19:51, Quentin Perret <qperret@google.com> wrote:
>
> On Tuesday 01 Oct 2024 at 18:20:03 (+0200), Vincent Guittot wrote:
> > With commit 50181c0cff31 ("sched/pelt: Avoid underestimation of task
> > utilization"), the util_est remains set the value before having to
> > share the cpu with other tasks which means that the util_est remains
> > correct even if its util_avg decrease because of sharing the cpu with
> > other task. This has been done to cover the cases that you mention
> > above whereboth util_avg and util_est where decreasing when tasks
> > starts to  share  the CPU bandwidth with others
>
> I don't think I agree about the correctness of that util_est value at
> all. The above patch only makes it arbitrarily out of date in the truly
> overcommitted case. All the util-based heuristic we have in the
> scheduler are based around the assumption that the close future will
> look like the recent past, so using an arbitrarily old util-est is still
> incorrect. I can understand how this may work OK in RT-app or other

This fixes a real use case on android device

> use-cases with perfectly periodic tasks for their entire lifetime and
> such, but this doesn't work at all in the general case.
>
> > And feec() will return -1 for that case because util_est remains high
>
> And again, checking that a task fits is broken to start with if we don't
> know how big the task is. When we have reasons to believe that the util
> values are no longer correct (and the absence of idle time is a very
> good reason for that) we just need to give up on them. The fact that we
> have to resort to using out-of-date data to sort of make that work is
> just another proof that this is not a good idea in the general case.

That's where I disagree, this is not an out-of-date value, this is the
last correct one before sharing the cpu

>
> > the commit that I mentioned above covers those cases and the task will
> > not incorrectly fit to another smaller CPU because its util_est is
> > preserved during the overutilized phase
>
> There are other reasons why a task may look like it fits, e.g. two tasks
> coscheduled on a big CPU get 50% util each, then we migrate one away, the

50% of what ? not the cpu capacity. I think you miss one piece of the
recent pelt behavior here. I fullygree that when the system os
overcommitted the util base task placement is not correct but I also
think that feec() can't find a cpu in such case

> CPU looks half empty. Is it half empty? We've got no way to tell until

The same here, it's not thanks to util_est

> we see idle time. The current util_avg and old util_est value are just
> not helpful, they're both bad signals and we should just discard them.
>
> So again I do feel like the best way forward would be to change the
> nature of the OU threshold to actually ask cpuidle 'when was the last
> time there was idle time?' (or possibly cache that in the idle task
> directly). And then based on that we can decide whether we want to enter
> feec() and do util-based decision, or to kick the push-pull mechanism in
> your other patches, things like that. That would solve/avoid the problem
> I mentioned in the previous paragraph and make the OU detection more
> robust. We could also consider using different thresholds in different
> places to re-enable load-balancing earlier, and give up on feec() a bit
> later to avoid messing the entire task placement when we're only
> transiently OU because of misfit. But eventually, we really need to just
> give up on util values altogether when we're really overcommitted, it's
> really an invariant we need to keep.

For now, I will increase the OU threshold to cpu capacity to reduce
the false overutilized state because of misfit tasks which is what I
really care about. The redesign of OU will come in a different series
as this implies more rework. IIUC your point, we are more interested
by the prev cpu than the current one

>
> Thanks,
> Quentin

