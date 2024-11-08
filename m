Return-Path: <linux-kernel+bounces-402468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 880409C2806
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D27AFB21F00
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C731E22EC;
	Fri,  8 Nov 2024 23:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m+DEZ4uD"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF28F29CF4
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 23:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731107889; cv=none; b=j7NN6rn60qJ25g9ayQsTOWJeB+ET3C842sDQRYa+XjGez8jiI+jP40QXvPqTXcPlbDHmC3soE2CltisAq6SKSAaDBFJPD4pPJ5J6ODmRsK/E8ojFjCaaebTR1ic22Zw2E7A6DZY4dFLi/vZctuBVpZf4/geqBQbUvWisQ/MnDEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731107889; c=relaxed/simple;
	bh=nsipveHOm+v7XoAV7srg8nEJGZcMhkiU7dP62aQVhP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ObRzVHyeRvTxIK7MhlF9IJyocT8lr3fLCwT4X12HLxYI5+0bqcN3Gly9mslEA5sqfd5bmTZmUl55O2JP15vCelvv2QGvm772yp77hXeDZnKkLwyMLTXC7YAfFNh+hqO8UnsmrHBvJiq1F1c9/0zSnTMW7gcQb3fifeZmfAZHrW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m+DEZ4uD; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e56750bb0dso2030726a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 15:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731107887; x=1731712687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaYZ3J+sAQ2g1x6XojZyNv59A7o7T/wBN6MJlsjSLqs=;
        b=m+DEZ4uD5M7885gxtuFz6Pg6iAoRMnJA9BjRip2RMHuBoc0ML6f7LJws8f8hcRbZpQ
         l76kVywjXtlHLGqOjrXTZNAi/Uf/2f1Y6jLRFURWWv6RZjHqseKbezJ22i3wKNlgB6Jg
         Hk5RfRSoHzuOgEFIBIILEd7V5f00w3IMEX6+WbhPhlvexkHn+JA6dysZT979iFcadBvR
         1KYAuBcM8j4bbdDkx+xtK2JncnYyBc2prR7N9f6GBGgai4gVblDWOy68ILor0hLpS/Gx
         FQfpKv8Ts65DsvIUORxkLLd5hj4hjcBUmvlA3IAQvw6tIRYfw6YjhWsl//cHKwgVWJWk
         Etiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731107887; x=1731712687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yaYZ3J+sAQ2g1x6XojZyNv59A7o7T/wBN6MJlsjSLqs=;
        b=ohcXo/RKVV2dikd641kTFBqmcKvmmKc8YGefgNQEl34qThbaoBulKfPgS0dUMZdMCV
         8fYQZAaha/AKTJxGmO3PqSUSbRAIcshvkH8Nzj17C7sa2gXib0wYIfEDCKRq79IMAGBi
         PcBeH74zRMa5Z53moKPb6xhfNUcfOLtOR1hP6dG748z1NXKocKNp7OhsxNzM89mzCdTi
         2QXY/feIhqFJnGvOyxRGLpA4hM/Cgu0PEYYi6KArcGrvt3Boz7i/032u4I0DvwP14SDL
         0K0snZ7nU8znrcIMZwjJpJ7qSQTOM9A+cY48zJ9v6HOlaDIRBEDbw/XgCLtYYheASul1
         lZ7A==
X-Forwarded-Encrypted: i=1; AJvYcCX0rOHJ8K2wq1kOcXdh7xekjURn8SILtG10XcxRMWciuc4W3IAD6E+wIWxN03uz2/mMgE+lDfG/dnXcgqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+1bFpbd2YhLVKYAOuz7qJxGDtvwAYwLTd6yMpYvWu92gmvHCK
	YOL1GkL/BlvsgSgdHr+7fzyWTGGdCdvaqO8fqgBMHMkvbcrwg8v0BrgfuhAu0HnjWsgXZkLf+S4
	CDsxUWcOMyHNH+xPtvKn+e0hSIn76TJfuYxC8
X-Google-Smtp-Source: AGHT+IH0kM6cwANRYMub0MHaGmkZN/dddnLjoFWvwES6A99JWdtv5aOZ561qFJXqz0p3DO9OEDVIHdYgkTFE9n1eYl8=
X-Received: by 2002:a17:90b:53c6:b0:2e2:cf5c:8edf with SMTP id
 98e67ed59e1d1-2e9b170eaf9mr6116506a91.9.1731107885910; Fri, 08 Nov 2024
 15:18:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727102732.960974693@infradead.org> <CAGETcx97SEHP5MspzBHsMkmSExnY870DQ-F5L077vzOGnPx0UA@mail.gmail.com>
 <4a3dac53-69e5-d3cd-8bc0-3549af4932b3@amd.com> <20241106110925.GK24862@noisy.programming.kicks-ass.net>
 <345dfc04-753b-4411-be2d-e4f604c1c4b1@arm.com> <CAGETcx_ZkvCgG0F41-cW9NLXn8s__6zZF8=yjEqR05ykhZAtiw@mail.gmail.com>
In-Reply-To: <CAGETcx_ZkvCgG0F41-cW9NLXn8s__6zZF8=yjEqR05ykhZAtiw@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Fri, 8 Nov 2024 15:17:54 -0800
Message-ID: <CAG2Kctp9LpVybdhNURSVe0Xgk65AiJ55qDg+GL2+NiTXAfWYKA@mail.gmail.com>
Subject: Re: [PATCH 00/24] Complete EEVDF
To: Saravana Kannan <saravanak@google.com>
Cc: Luis Machado <luis.machado@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, David Dai <davidai@google.com>, mingo@redhat.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, wuyun.abel@bytedance.com, 
	youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de, 
	Android Kernel Team <kernel-team@android.com>, Qais Yousef <qyousef@google.com>, 
	Vincent Palomares <paillon@google.com>, John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 11:08=E2=80=AFPM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> On Wed, Nov 6, 2024 at 4:07=E2=80=AFAM Luis Machado <luis.machado@arm.com=
> wrote:
> >
> > Hi,
> >
> > On 11/6/24 11:09, Peter Zijlstra wrote:
> > > On Wed, Nov 06, 2024 at 11:49:00AM +0530, K Prateek Nayak wrote:
> > >
> > >> Since delayed entities are still on the runqueue, they can affect PE=
LT
> > >> calculation. Vincent and Dietmar have both noted this and Peter post=
ed
> > >> https://lore.kernel.org/lkml/172595576232.2215.18027704125134691219.=
tip-bot2@tip-bot2/
> > >> in response but it was pulled out since Luis reported observing -ve
> > >> values for h_nr_delayed on his setup. A lot has been fixed around
> > >> delayed dequeue since and I wonder if now would be the right time to
> > >> re-attempt h_nr_delayed tracking.
> > >
> > > Yeah, it's something I meant to get back to. I think the patch as pos=
ted
> > > was actually right and it didn't work for Luis because of some other,
> > > since fixed issue.
> > >
> > > But I might be misremembering things. I'll get to it eventually :/
> >
> > Sorry for the late reply, I got sidetracked on something else.
> >
> > There have been a few power regressions (based on our Pixel6-based test=
ing) due
> > to the delayed-dequeue series.
> >
> > The main one drove the frequencies up due to an imbalance in the uclamp=
 inc/dec
> > handling. That has since been fixed by "[PATCH 10/24] sched/uclamg: Han=
dle delayed dequeue". [1]
> >
> > The bug also made it so disabling DELAY_DEQUEUE at runtime didn't fix t=
hings, because the
> > imbalance/stale state would be perpetuated. Disabling DELAY_DEQUEUE bef=
ore boot did fix things.
> >
> > So power use was brought down by the above fix, but some issues still r=
emained, like the
> > accounting issues with h_nr_running and not taking sched_delayed tasks =
into account.
> >
> > Dietmar addressed some of it with "kernel/sched: Fix util_est accountin=
g for DELAY_DEQUEUE". [2]
> >
> > Peter sent another patch to add accounting for sched_delayed tasks [3].=
 Though the patch was
> > mostly correct, under some circumstances [4] we spotted imbalances in t=
he sched_delayed
> > accounting that slowly drove frequencies up again.
> >
> > If I recall correctly, Peter has pulled that particular patch from the =
tree, but we should
> > definitely revisit it with a proper fix for the imbalance. Suggestion i=
n [5].
> >
> > [1] https://lore.kernel.org/lkml/20240727105029.315205425@infradead.org=
/
> > [2] https://lore.kernel.org/lkml/c49ef5fe-a909-43f1-b02f-a765ab9cedbf@a=
rm.com/
> > [3] https://lore.kernel.org/lkml/172595576232.2215.18027704125134691219=
.tip-bot2@tip-bot2/
> > [4] https://lore.kernel.org/lkml/6df12fde-1e0d-445f-8f8a-736d11f9ee41@a=
rm.com/
> > [5] https://lore.kernel.org/lkml/6df12fde-1e0d-445f-8f8a-736d11f9ee41@a=
rm.com/
>
> Thanks for the replies. We are trying to disable DELAY_DEQUEUE and
> recollect the data to see if that's the cause. We'll get back to this
> thread once we have some data.
>
> -Saravana

The test data is back to pre-EEVDF state with DELAY_DEQUEUE disabled.

Same test example from before, when thread is affined to the big cluster:
+----------------------------------+
| Data            | Enabled | Disabled |
|-----------------------+----------|
| 5th percentile  | 96     | 143    |
|-----------------------+----------|
| Median          | 144    | 147   |
|-----------------------+----------|
| Mean            | 134    | 147   |
|-----------------------+----------|
| 95th percentile | 150    | 150   |
+----------------------------------+

What are the next steps to bring this behavior back? Will DELAY_DEQUEUE alw=
ays
be enabled by default and/or is there a fix coming for 6.12?

Thanks,
Sam

