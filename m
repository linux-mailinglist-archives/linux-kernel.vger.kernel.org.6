Return-Path: <linux-kernel+bounces-299690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1137895D8BC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA68284796
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 21:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BCB1C86EA;
	Fri, 23 Aug 2024 21:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NTtLhsL8"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA241A08A9
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 21:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724449939; cv=none; b=Hjv2oDiTKtHLfHhDik55jXAhacA++h0wMw5jdprcug/F/3PxpRbPHkIx/+qVabVFLXuhNiES7ypmO0fUa0MnDmFPWpcbDZKgplqgSgEBocpVyZi/j0NcAUODdyUkKmz60UF0FayuQaaNnzlYw+LEtg6NQX/p3iyeqIwOg9QwMWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724449939; c=relaxed/simple;
	bh=CjiS+4IsOskeCWg9+BqN9dUoTpikZsuYPWS6zcJvG9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rbg84h0pVihQGE6tMtTHpyEsEEoI94StuZIVp8Qdf/Gt7BUeoKnq07gYpRMTDHt4W00dg/8iwF3kwxyMOW3H7rHV0A/2Odwfz1y2r3Ou8eRpw9KlwLBhboGOKVrfG6cX7g2CAWSLX7vfMiiGiV/Idl1hiQ6DERZhuiFP2ATPczk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NTtLhsL8; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-45007373217so29040221cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 14:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724449937; x=1725054737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjiS+4IsOskeCWg9+BqN9dUoTpikZsuYPWS6zcJvG9g=;
        b=NTtLhsL8W1JznNGk4kF7ZtKxCDwwuyfHipo6+C+m6Dj0EJE8GXPKcjFPqdY2e3ui21
         z6gwSYNlJgKFcmSbz1LJOXE3Z6HwYFhjcRBwQ2bnY26kr/xdZhV2ngCHAb9XE07C7qB1
         Q3MQ4OzZIB59lMLFlk4m7+bbaYSiweZNVT1gxUp5/tsn8t2ArLl2sGiTaOHiNxeCXEJx
         ZH7wxAkVp7nR3nr8ZpSzq3dGKSb6NrQ3/J2REDBm78V0iR1T/DcFVMVsKSVlYdRmP84u
         QMgZRiP1FiHZYg+uoIw+Gh123iGyBB1tcvNw8daBeUbM8cDHCW6QeKjD0xHK9T4gF6fb
         6wBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724449937; x=1725054737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CjiS+4IsOskeCWg9+BqN9dUoTpikZsuYPWS6zcJvG9g=;
        b=jBratP79GW+yOwFJOc1GQyghiZvKQXGDP7hDCa3NEBNEdEXTMB9/nxdAxOEuQ21vQD
         O9b2WOBzwJJn7zF4SKRzNaZLsV96zxxS2YpV4Mn6T4RaROPjUuUlknrv1HTAuaNaWI7C
         diqrtjVkU7Z0kJvm7m1w678LgDSvixCyoVJ6PoYQv1A16GWYyGzzQC4VG6YDCw01IgYt
         dDdAE3RBQLU2UjDQDCoE1Y6ktbTcrXWFmrcwBuVEkeDXEIscw9IiPCOmVPMdM5xbZuik
         h3/47uSutcbUIp+cffpvWCqcyz9uHXSWT9YJO++WqOy+t2/Yp3objzO+13OPZP8wC9QJ
         6KGw==
X-Forwarded-Encrypted: i=1; AJvYcCW5JTnDbonDR2Et1qZONC7G5tU0Tv2sQWtqF+064FYhY6GO61zd/dtEPDLbkHB+v/tN6AKXix4bn6oZLWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YziN5ghwE9GIjoQYimaNKcLbcblPHn1+KWDx793V9vSUKhVfC/A
	xOvVRlHMSi55oeNVgBuYPmFPcc/5lqkDV48AoCFzCn4tODmN2eL9tT1V2DBR1Oc2po34nTUL0Mz
	FQLXoIz6bC9BKHPiTMreY+7gEiVltLPKZ0qjo
X-Google-Smtp-Source: AGHT+IG5l/LT+i3SONq1iBsw2+xv/uwNjxvXqOJ+Gap/QUjr3AWF7w7FYuJM/iDpLs0N/rZJi5M70Jqnpb+DEKpz+6s=
X-Received: by 2002:a05:622a:420d:b0:44f:ea31:cdbd with SMTP id
 d75a77b69052e-45509306525mr72956431cf.24.1724449936452; Fri, 23 Aug 2024
 14:52:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806111157.1336532-1-suleiman@google.com> <185314eedbe4e19a2a1cd7faf32b9a3a3e6acd07.camel@infradead.org>
In-Reply-To: <185314eedbe4e19a2a1cd7faf32b9a3a3e6acd07.camel@infradead.org>
From: Suleiman Souhlal <suleiman@google.com>
Date: Sat, 24 Aug 2024 06:52:05 +0900
Message-ID: <CABCjUKAEsK1EKCD07cfsftj1pKGXv7KkCup9VDPaS44MAY1xwA@mail.gmail.com>
Subject: Re: [PATCH] sched: Don't try to catch up excess steal time.
To: David Woodhouse <dwmw2@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, joelaf@google.com, 
	vineethrp@google.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	ssouhlal@freebsd.org, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 12:51=E2=80=AFAM David Woodhouse <dwmw2@infradead.o=
rg> wrote:
>
> On Tue, 2024-08-06 at 20:11 +0900, Suleiman Souhlal wrote:
> > When steal time exceeds the measured delta when updating clock_task, we
> > currently try to catch up the excess in future updates.
> > However, this results in inaccurate run times for the future clock_task
> > measurements, as they end up getting additional steal time that did not
> > actually happen, from the previous excess steal time being paid back.
> >
> > For example, suppose a task in a VM runs for 10ms and had 15ms of steal
> > time reported while it ran. clock_task rightly doesn't advance. Then, a
> > different task runs on the same rq for 10ms without any time stolen.
> > Because of the current catch up mechanism, clock_sched inaccurately end=
s
> > up advancing by only 5ms instead of 10ms even though there wasn't any
> > actual time stolen. The second task is getting charged for less time
> > than it ran, even though it didn't deserve it.
> > In other words, tasks can end up getting more run time than they should
> > actually get.
> >
> > So, we instead don't make future updates pay back past excess stolen ti=
me.
>
> My understanding was that it was done this way for a reason: there is a
> lot of jitter between the "run time" (your 10ms example), and the steal
> time (15ms). What if 5ms really *did* elapse between the time that
> 'delta' is calculated, and the call to paravirt_steal_clock()?
>
> By accounting that steal time "in advance" we ensure it isn't lost in
> the case where the same process remains running for the next timeslice.

This is an interesting observation, but I'd argue that even in the scenario
where the same task stays running, the extra 5ms should not be accounted
for in steal time:
From what I can tell, update_curr() is only updating the task's runtime by =
the
"delta" that was calculated, so the extra "stolen" time that happened betwe=
en
the delta measurement and the steal time application does not seem to be
relevant. From what I can tell, that stolen time happened at a point where =
the
task is not being counted as running in its run time, so it should not be
accounted.

I am however struggling to express this in a way that is easily understanda=
ble
by others.

> However, that does cause problems when the steal time goes negative
> (due to hypervisor bugs). So in
> https://lore.kernel.org/all/20240522001817.619072-22-dwmw2@infradead.org/
> I limited the amount of time which would be accounted to a future tick.

That would definitely be an improvement over the old behavior.

I noticed the issue because I've been trying to make sense of the numbers w=
hile
trying to include the time that host was suspended in steal time in
https://lore.kernel.org/kvm/20240820043543.837914-1-suleiman@google.com/
(But I think the issue can happen even without these changes.)

Thanks,
-- Suleiman

