Return-Path: <linux-kernel+bounces-427115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAB59DFCE1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF01281D55
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1459D1FA15D;
	Mon,  2 Dec 2024 09:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nedw/1z3"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0748B1D6DB5
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733131147; cv=none; b=DO09HYYXy7POXJ5wntFwVV6UtrcMDfvw3DflpftSiZc2BvnPN3d9XgbShGPo3RJF420+9FGFyQolWwmHxWUoE4eaKmsgv1uuquLVqoVFC1pywgI7jksLCCMufOOWvuu3Z4gABtjBfHI3cEoAFVrCwzWEUjKcokaJIjy3KLVjM9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733131147; c=relaxed/simple;
	bh=bYHAyix+6yw+2xyLFB2F2Nk3Q50Bk36W+zMsOAndchc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kd/lvp0YtbA+cGnyeiIiGrIBsvTZRncONmc50191rjNQUoPj3kVE2oBmxSGwwaGqT3SUz+5PbB57K4jCirEcevyzBH3W9vFvPBdC/mHMgfG3q89KXWwSguGHQzwJ3vg94+NSbc8AEeU26cB9Q8IXcDic+TKpgYrGJJXAK2LKelQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nedw/1z3; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ee6c2d6db0so1945679a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 01:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733131145; x=1733735945; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5CCtAc4dO1UCXJ0QB9ff/gvPe8DNHqUFycRoru3JYxc=;
        b=nedw/1z3TZ81NfAmvEPMvK8Lzg7OayDFpFnFS08kgM2tFcRdkmXZF4bSV/Oma4WVKp
         YeUuq0s9Netz/4KsoMqO7jZ15OZv36z1hSpHdaXEDNIZ1ZjimCtFCiOBPIalO0Sfg26t
         qgTfIBh/gGYFemqZ8QlWaw8KG+/jYd3OG1if/+QamqDVy0OLzt5RbInZ5C2c7PhS4hAH
         su+wMFLyQG/c/L7NB9byu4yorvh1RHRkyAIvzRLMHiTP+OrT1wRzoHGkb1s0b6RtLk4I
         tY+Pz8D/qlXL5r8Xji6vVexy18fATN3NZ5KnGG6b+1c++tKRfchIR9UUL0mSmmsCmqi7
         l1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733131145; x=1733735945;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5CCtAc4dO1UCXJ0QB9ff/gvPe8DNHqUFycRoru3JYxc=;
        b=XJIyQWC4PVKt/Y4Pnm1ND3l5KjHKOoWUpjK5sPIn76wAQhKYBn8ErDaMUky3QYaRJI
         4jqLTDL58hyc6PWQ6COI+yeftzhrC5JjZ9BjSsT2ey3/YYKaWCXlYW56/YWWCSC2WrHZ
         U+sgHe6kP5HSV+wmfIJ2VnL+KQcbKHMk3shyuQJBfbhsVrJWZL6APOmLzs76EgIF8f6q
         WPhk9wv/xoaIwuQKan4zFHrR6OQAFe29Sy80uUifBhwqg/moa8cWzS9yi2r6gOXg9lE0
         71P4mQmwiB7WsccUGWNoUrVqk7IwWEPiffq0eHsJQy3nF+ZRjvmB+Cop8rmeDlJ95N3H
         GTgA==
X-Forwarded-Encrypted: i=1; AJvYcCWlk5foapbGu1WerurVnbjlBoxSmPg0Rq5IQxv2JMrD7NkQRouPPvWadY4ior8Yip1dRZ8/6/T23ESlvU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz55v3zck4+mGjJbhlAM0Zg5FkYgldgq8MS/qXAyVo9DXOnjgL5
	2p9bD8ztDEHivFb5UytmT+tnoh6scBQ/Jzzi9d+713l5U08KsEd+2lz9emrPE0QlVFKjqWlL24x
	CqY33L8LpjcGiql5RPxHAt5Zx+cTqNZAd0rJHJg==
X-Gm-Gg: ASbGncvGihsqu+da10budK7OSkS6qlkCYKFHdhvUsMWzizLQ/uHb3fe1LrJVZ+qUF8e
	HiXzOketzYF1AJGZWcjLTanuR4mKygj70MhIQtthj75wuv9szCMdrKEEI+Xzl
X-Google-Smtp-Source: AGHT+IEoa4r9C8dfZ/DNVAKwlWbXm1jK3X+9BMva9C5iAwIqTNTWRPpWnrjKApfrShz9TLZe46CIITB3Bx5GoGpt1+w=
X-Received: by 2002:a17:90a:e7c1:b0:2ee:8ea0:6b9c with SMTP id
 98e67ed59e1d1-2ee8ea0715fmr13489551a91.12.1733131145225; Mon, 02 Dec 2024
 01:19:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129161756.3081386-1-vincent.guittot@linaro.org>
 <20241129161756.3081386-10-vincent.guittot@linaro.org> <c82ed217-cfe4-41a4-b39a-e7356231835f@amd.com>
In-Reply-To: <c82ed217-cfe4-41a4-b39a-e7356231835f@amd.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 2 Dec 2024 10:18:54 +0100
Message-ID: <CAKfTPtAcqXB=5FF_dteucisiYcdtFoaKVbqGE+iK3nipX7je_w@mail.gmail.com>
Subject: Re: [PATCH 09/10 v2] sched/fair: Fix sched_can_stop_tick() for fair tasks
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org, 
	pauld@redhat.com, efault@gmx.de, luis.machado@arm.com, 
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Nov 2024 at 19:26, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> (+ Tejun, David)
>
> Hello Vincent,
>
> On 11/29/2024 9:47 PM, Vincent Guittot wrote:
> > We can't stop the tick of a rq if there are at least 2 tasks enqueued in
> > the whole hierarchy and not only at the root cfs rq.
> >
> > rq->cfs.nr_queued tracks the number of sched_entity at one level
> > whereas rq->cfs.h_nr_enqueued tracks all enqueued tasks in the
> > hierarchy.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >   kernel/sched/core.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 3571f91d4b0d..866a1605656c 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1341,7 +1341,7 @@ bool sched_can_stop_tick(struct rq *rq)
> >       if (scx_enabled() && !scx_can_stop_tick(rq))
> >               return false;
> >
> > -     if (rq->cfs.nr_queued > 1)
> > +     if (rq->cfs.h_nr_queued > 1)
>
> Perhaps we can move this fix to the beginning of the series and add:
>
> Fixes: 11cc374f4643b ("sched_ext: Simplify scx_can_stop_tick() invocation in sched_can_stop_tick()")
>
> before converting the h_nr_running to h_nr_queued  since prior to that
> commit, sched_can_stop_tick() used to check "rq->nr_running" and since
> we check the count of DL, RR, and FIFO tasks up above, it would have
> captured number of fair tasks running before sched-ext. That way the fix
> can be backported easily to LTS too. Thoughts?

Yes I can do that

>
> >               return false;
> >
> >       /*
>
> --
> Thanks and Regards,
> Prateek
>

