Return-Path: <linux-kernel+bounces-401172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CD49C16CA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39AC1284153
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E301D0E31;
	Fri,  8 Nov 2024 07:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kbk1NQf9"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE087DDA8
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 07:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731049707; cv=none; b=ErZw4eN0Gxpa4HmRmdzv/kVpvJMUHe52x0kAdTivP++48m65ruFxzBq/f9yp4PVPn0SsH5Sbgf+fhp9LM9Asb2WyPbXSFYaID6eQ4B2dxnh541RDsSkOUxcOKrFzaAnSTp2jd/IhuUnh0u1Vsd9eDOnIJnP8AmW5q3x9ixfLLVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731049707; c=relaxed/simple;
	bh=cWmxYTV3s6tvwBZeezR8cAb0g9mpZGk8wys+YUJcRHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KvpOGxycuyeOtJR2Op+oT2TOGypHj6PdVkgPk3muMTRQM4zxyWIGCx94nooikB/YQUHvyUdCToMQIEJ5yflN7Sn/gyGUnDTXu5TSJfSh9vynfn5TrRVl7Coj5vFp17WpqzJdUeiUyU7IzhN41Df2xKIUGFfOxAxZKlcE7Ea0JAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kbk1NQf9; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ee51d9ae30so1420945a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 23:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731049705; x=1731654505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWmxYTV3s6tvwBZeezR8cAb0g9mpZGk8wys+YUJcRHA=;
        b=kbk1NQf925k0Rwx4qO9+bUhqV6z2bVbrMhI5PVMEspzErRdhHXM2vrNCx/3u1WoUu8
         jqUa7S0OIMDlqEUtW/9kQrWp7h3B8TFLSQOk6PIwoGfL0r3IHkfkL+LXRpLemurwXo3e
         dkeqCLbJRjAJrgW3e8MclEpfQHp8QVu0iQaCoF6mw3/LqI8QYmbBkdxNc02+lBUL1irG
         adhhOGlW4/OJze5VVjbO91FOHzvy53aNwq3aZnwJn9CiDPkpmz/G50EQZpfEuKCROPsj
         S8Gi0Ywajt+eaEl6tFdvqo4AgBqDQEfbbNh2KF8vMFF7oHI9qG6z5Er0GGjFtm6eTETW
         ytwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731049705; x=1731654505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWmxYTV3s6tvwBZeezR8cAb0g9mpZGk8wys+YUJcRHA=;
        b=SN0jM6FfPeMnD9AyDvHXFJoCCDoATq0b+a4jjwSXdfObVcOaUKULjPIc06YMHrr0yc
         uzC4TgoK5V67Btmg3pOPRoIKKKT52GwmzUEitXF8f2Kj0V1szSP+Sn45LgwNCXKiyD2I
         G4EmVtjlyrtjuP2ouNxxLrVllo8PSuXnjludgsgFFMuqxBxJlPOg5Bq7wc3C+pIp0G4i
         b6b57hbXTqaDDdzracXvt0SVkAWQKXAdWFpXSayji16CXvSWa1j27NPLPu2yM6SSXzID
         UkqW3EvFm3q1uiEJxsVrxYLgNCBClqQXdfWiOcqgKDsJeYG6WsmdURiGmFvzdvUGU/yQ
         4Q7g==
X-Forwarded-Encrypted: i=1; AJvYcCWPptQzlOtHQfWGNwMremorFdBmajR3qhGOd4YRjWFIZzX/XPeOaNXEcIg/f+cKl09LnRCvPrQ64GiC9IM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX5ObEAEIheyNfLgTBlTPxCwqfejabrjIdBOZgz2JsK/0HEnud
	vWZglEMYYvzkZEIIJsQur+nWgOad4wCy6IcY69e+jg/6uT2YKvJoKj1nHtljiSViOx+H4i6UNGh
	G3/fiSA6kqJ9M7DsSC6NsELGDsKbpMaj1JXn7
X-Google-Smtp-Source: AGHT+IH4HVTj5G94qBlSR+32O3cnXo54xoPoTjvthZB8xDdxWsgOjQZhZvjZhDrVsLg8Rwvu9AHwaEiHMBHOQg3xshc=
X-Received: by 2002:a17:90b:3890:b0:2e2:e6c8:36a7 with SMTP id
 98e67ed59e1d1-2e9b178ed4amr2645926a91.31.1731049704734; Thu, 07 Nov 2024
 23:08:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727102732.960974693@infradead.org> <CAGETcx97SEHP5MspzBHsMkmSExnY870DQ-F5L077vzOGnPx0UA@mail.gmail.com>
 <4a3dac53-69e5-d3cd-8bc0-3549af4932b3@amd.com> <20241106110925.GK24862@noisy.programming.kicks-ass.net>
 <345dfc04-753b-4411-be2d-e4f604c1c4b1@arm.com>
In-Reply-To: <345dfc04-753b-4411-be2d-e4f604c1c4b1@arm.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 7 Nov 2024 23:07:46 -0800
Message-ID: <CAGETcx_ZkvCgG0F41-cW9NLXn8s__6zZF8=yjEqR05ykhZAtiw@mail.gmail.com>
Subject: Re: [PATCH 00/24] Complete EEVDF
To: Luis Machado <luis.machado@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Samuel Wu <wusamuel@google.com>, David Dai <davidai@google.com>, mingo@redhat.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, wuyun.abel@bytedance.com, 
	youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de, 
	Android Kernel Team <kernel-team@android.com>, Qais Yousef <qyousef@google.com>, 
	Vincent Palomares <paillon@google.com>, John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 4:07=E2=80=AFAM Luis Machado <luis.machado@arm.com> =
wrote:
>
> Hi,
>
> On 11/6/24 11:09, Peter Zijlstra wrote:
> > On Wed, Nov 06, 2024 at 11:49:00AM +0530, K Prateek Nayak wrote:
> >
> >> Since delayed entities are still on the runqueue, they can affect PELT
> >> calculation. Vincent and Dietmar have both noted this and Peter posted
> >> https://lore.kernel.org/lkml/172595576232.2215.18027704125134691219.ti=
p-bot2@tip-bot2/
> >> in response but it was pulled out since Luis reported observing -ve
> >> values for h_nr_delayed on his setup. A lot has been fixed around
> >> delayed dequeue since and I wonder if now would be the right time to
> >> re-attempt h_nr_delayed tracking.
> >
> > Yeah, it's something I meant to get back to. I think the patch as poste=
d
> > was actually right and it didn't work for Luis because of some other,
> > since fixed issue.
> >
> > But I might be misremembering things. I'll get to it eventually :/
>
> Sorry for the late reply, I got sidetracked on something else.
>
> There have been a few power regressions (based on our Pixel6-based testin=
g) due
> to the delayed-dequeue series.
>
> The main one drove the frequencies up due to an imbalance in the uclamp i=
nc/dec
> handling. That has since been fixed by "[PATCH 10/24] sched/uclamg: Handl=
e delayed dequeue". [1]
>
> The bug also made it so disabling DELAY_DEQUEUE at runtime didn't fix thi=
ngs, because the
> imbalance/stale state would be perpetuated. Disabling DELAY_DEQUEUE befor=
e boot did fix things.
>
> So power use was brought down by the above fix, but some issues still rem=
ained, like the
> accounting issues with h_nr_running and not taking sched_delayed tasks in=
to account.
>
> Dietmar addressed some of it with "kernel/sched: Fix util_est accounting =
for DELAY_DEQUEUE". [2]
>
> Peter sent another patch to add accounting for sched_delayed tasks [3]. T=
hough the patch was
> mostly correct, under some circumstances [4] we spotted imbalances in the=
 sched_delayed
> accounting that slowly drove frequencies up again.
>
> If I recall correctly, Peter has pulled that particular patch from the tr=
ee, but we should
> definitely revisit it with a proper fix for the imbalance. Suggestion in =
[5].
>
> [1] https://lore.kernel.org/lkml/20240727105029.315205425@infradead.org/
> [2] https://lore.kernel.org/lkml/c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm=
.com/
> [3] https://lore.kernel.org/lkml/172595576232.2215.18027704125134691219.t=
ip-bot2@tip-bot2/
> [4] https://lore.kernel.org/lkml/6df12fde-1e0d-445f-8f8a-736d11f9ee41@arm=
.com/
> [5] https://lore.kernel.org/lkml/6df12fde-1e0d-445f-8f8a-736d11f9ee41@arm=
.com/

Thanks for the replies. We are trying to disable DELAY_DEQUEUE and
recollect the data to see if that's the cause. We'll get back to this
thread once we have some data.

-Saravana

