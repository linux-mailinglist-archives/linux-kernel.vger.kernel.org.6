Return-Path: <linux-kernel+bounces-422900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2839D9FB0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 00:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87DEC28384E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 23:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848C6189B94;
	Tue, 26 Nov 2024 23:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iaovzdei"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9273199FBB
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 23:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732664000; cv=none; b=VyIEgDOdXTQuZZhtRhmnV0mE4VSLa/qQaIjXvHivvxez7Ur260CNSPryNjLfvrlBt8n8VYpd7QppZ4aOJgCKX4ZyoVIJLgUmDP9Ao5K3/lSd7Qkyd+TFBOtNvFyOd8zUanQlN2QJneo3KD36Uz5nL5RPhtrcxk45bmKlIcKkAYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732664000; c=relaxed/simple;
	bh=IRQYDQFDlkkfRV5khY5Ub+jRcjFso/AreLH7XKCvidg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TA1ZHctkizh6iq3Eiy5UgAXdGvwIsavDlrjiRPhUZdxEqPsEfp4pX2MPOtgWXZqy1ZKirda2SkHM4PHLTn+bcH4xJxbgV6G2ovRTD4u+92gG0gEa8HIi5Kz7Z/ppjpsPGqjkMzQPVXvBiFfS7QvDvLqH1EWeGvqS88wi3W8o/3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iaovzdei; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ffc7a2c5d5so25492191fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 15:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732663997; x=1733268797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZxgDeycOn0JKIxso03uSDbsoauQhldd6oukXtTelYk=;
        b=iaovzdeiE05LxSuz/dVbsjz0vT4c7qJX1IENgLi+e2HfXrpKPw7lEw7UFKRTLdNOIf
         PDoMvoUkLsWA3Sd8ozTSe0qrcP7j/fWg+I1zB1N1MutX5oflOpK4rnh3yFFF4A/RXLua
         yoTvVbbVkOOxns9P7/0a7Kuvuk8f5XPQ7j3Cd3HGU26OVj/tU8skZ8TSWVnTBPvtThuP
         LMZgnykOyxA3X6QgDkx7dHtvDCO2gCVinQg5K7bnbfyhb6ciDSiDRb8SE8jPcAipwCkD
         MdgRglo33A7ABsb4tgVkT6urnvQxanPD+6rhsjTZSDAHCaeud1wV1bCwHYTwsjsTCNpx
         NGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732663997; x=1733268797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZxgDeycOn0JKIxso03uSDbsoauQhldd6oukXtTelYk=;
        b=Wj/KBQRC1Qa8U/CZ/E7FauCZnsnTglw9GEVK9B49QbQWEkGOA6ASAiM0RlHqZ8/j+F
         bblkL+XKRrcEZ9H2mwCyEjfH+D/o15ucSSI4LCdg2pL0kUkY5T3YKFu/WVXoFCDYVGjx
         XTot0T94ubT/8djLNd/h57sUJS4S7+x4YCpaLYD8Etkcu+4flDYlHnBmI0BWX46KynFN
         qnP6whz6F5lL9LB6ywVb8DW6D9bm82Bdsq926rTe/x8YMu+O/GU7V4TWIXYPg/F2qcA2
         SVjJCm9wBXfoDl+bB3Uyi3sQYkyMakgy7/X+boRkvPQy4ug5kNv/ljMFF6RH0Kx2x8s4
         9ieQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRdWBUWcWixlJu4r80QP0iKH4JROhny47P9oauCHN0Pwb6G+cd7mc/ndPE8wb1gd7UC8VzlJbnAUxfkNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe0Jr079xpRfir+vqIFuMUZrcoutCZEaYevsMj5Hg8SUfBU2tf
	ok8wY9enC1Ar+EHQ79slfV34Y2G9SX19tM4wVwaQ5mNrIrPf8Q/3GBE1TmwN+srYJE8Ldsp4vdn
	JtVcIKkD+gLfzKBK/LYf6yseUtMAZh5ScdtS7
X-Gm-Gg: ASbGncvuzvON0lHv21A4Rbt4S1UU10d8tCwqwoV8uBAGKbtn9OSrFyagCvg+pfGKKJY
	H3NPeXxl4Yb5ViGaeXbK31YMvJmNiYt5lVcebKptfHvRwwi9FvrjFB7lMbQ==
X-Google-Smtp-Source: AGHT+IGEX9497L2MS4TzXFEZq86xEympG4xOZRQyfi6oULH4I8MNTc40vN6kDtrW/tlNRSJkpFzkx76cfHd9yF83QUY=
X-Received: by 2002:a2e:be24:0:b0:2fb:58b1:3731 with SMTP id
 38308e7fff4ca-2ffd5fcc293mr2230511fa.6.1732663996843; Tue, 26 Nov 2024
 15:33:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727102732.960974693@infradead.org> <CAGETcx97SEHP5MspzBHsMkmSExnY870DQ-F5L077vzOGnPx0UA@mail.gmail.com>
 <4a3dac53-69e5-d3cd-8bc0-3549af4932b3@amd.com> <20241106110925.GK24862@noisy.programming.kicks-ass.net>
 <345dfc04-753b-4411-be2d-e4f604c1c4b1@arm.com> <CAGETcx_ZkvCgG0F41-cW9NLXn8s__6zZF8=yjEqR05ykhZAtiw@mail.gmail.com>
 <CAG2Kctp9LpVybdhNURSVe0Xgk65AiJ55qDg+GL2+NiTXAfWYKA@mail.gmail.com> <aef0df21-7cd6-8e92-dd58-f571669b2115@amd.com>
In-Reply-To: <aef0df21-7cd6-8e92-dd58-f571669b2115@amd.com>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 26 Nov 2024 15:32:40 -0800
Message-ID: <CAGETcx_1pZCtWiBbDmUcxEw3abF5dr=XdFCkH9zXWK75g7457w@mail.gmail.com>
Subject: Re: [PATCH 00/24] Complete EEVDF
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Samuel Wu <wusamuel@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Luis Machado <luis.machado@arm.com>, David Dai <davidai@google.com>, mingo@redhat.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, wuyun.abel@bytedance.com, 
	youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de, 
	Android Kernel Team <kernel-team@android.com>, Qais Yousef <qyousef@google.com>, 
	Vincent Palomares <paillon@google.com>, John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2024 at 8:08=E2=80=AFPM K Prateek Nayak <kprateek.nayak@amd=
.com> wrote:
>
> Hello Sam,
>
> On 11/9/2024 4:47 AM, Samuel Wu wrote:
> > On Thu, Nov 7, 2024 at 11:08=E2=80=AFPM Saravana Kannan <saravanak@goog=
le.com> wrote:
> >>
> >> On Wed, Nov 6, 2024 at 4:07=E2=80=AFAM Luis Machado <luis.machado@arm.=
com> wrote:
> >>>
> >>> Hi,
> >>>
> >>> On 11/6/24 11:09, Peter Zijlstra wrote:
> >>>> On Wed, Nov 06, 2024 at 11:49:00AM +0530, K Prateek Nayak wrote:
> >>>>
> >>>>> Since delayed entities are still on the runqueue, they can affect P=
ELT
> >>>>> calculation. Vincent and Dietmar have both noted this and Peter pos=
ted
> >>>>> https://lore.kernel.org/lkml/172595576232.2215.18027704125134691219=
.tip-bot2@tip-bot2/
> >>>>> in response but it was pulled out since Luis reported observing -ve
> >>>>> values for h_nr_delayed on his setup. A lot has been fixed around
> >>>>> delayed dequeue since and I wonder if now would be the right time t=
o
> >>>>> re-attempt h_nr_delayed tracking.
> >>>>
> >>>> Yeah, it's something I meant to get back to. I think the patch as po=
sted
> >>>> was actually right and it didn't work for Luis because of some other=
,
> >>>> since fixed issue.
> >>>>
> >>>> But I might be misremembering things. I'll get to it eventually :/
> >>>
> >>> Sorry for the late reply, I got sidetracked on something else.
> >>>
> >>> There have been a few power regressions (based on our Pixel6-based te=
sting) due
> >>> to the delayed-dequeue series.
> >>>
> >>> The main one drove the frequencies up due to an imbalance in the ucla=
mp inc/dec
> >>> handling. That has since been fixed by "[PATCH 10/24] sched/uclamg: H=
andle delayed dequeue". [1]
> >>>
> >>> The bug also made it so disabling DELAY_DEQUEUE at runtime didn't fix=
 things, because the
> >>> imbalance/stale state would be perpetuated. Disabling DELAY_DEQUEUE b=
efore boot did fix things.
> >>>
> >>> So power use was brought down by the above fix, but some issues still=
 remained, like the
> >>> accounting issues with h_nr_running and not taking sched_delayed task=
s into account.
> >>>
> >>> Dietmar addressed some of it with "kernel/sched: Fix util_est account=
ing for DELAY_DEQUEUE". [2]
> >>>
> >>> Peter sent another patch to add accounting for sched_delayed tasks [3=
]. Though the patch was
> >>> mostly correct, under some circumstances [4] we spotted imbalances in=
 the sched_delayed
> >>> accounting that slowly drove frequencies up again.
> >>>
> >>> If I recall correctly, Peter has pulled that particular patch from th=
e tree, but we should
> >>> definitely revisit it with a proper fix for the imbalance. Suggestion=
 in [5].
> >>>
> >>> [1] https://lore.kernel.org/lkml/20240727105029.315205425@infradead.o=
rg/
> >>> [2] https://lore.kernel.org/lkml/c49ef5fe-a909-43f1-b02f-a765ab9cedbf=
@arm.com/
> >>> [3] https://lore.kernel.org/lkml/172595576232.2215.180277041251346912=
19.tip-bot2@tip-bot2/
> >>> [4] https://lore.kernel.org/lkml/6df12fde-1e0d-445f-8f8a-736d11f9ee41=
@arm.com/
> >>> [5] https://lore.kernel.org/lkml/6df12fde-1e0d-445f-8f8a-736d11f9ee41=
@arm.com/
> >>
> >> Thanks for the replies. We are trying to disable DELAY_DEQUEUE and
> >> recollect the data to see if that's the cause. We'll get back to this
> >> thread once we have some data.
> >>
> >> -Saravana
> >
> > The test data is back to pre-EEVDF state with DELAY_DEQUEUE disabled.
> >
> > Same test example from before, when thread is affined to the big cluste=
r:
> > +----------------------------------+
> > | Data            | Enabled | Disabled |
> > |-----------------------+----------|
> > | 5th percentile  | 96     | 143    |
> > |-----------------------+----------|
> > | Median          | 144    | 147   |
> > |-----------------------+----------|
> > | Mean            | 134    | 147   |
> > |-----------------------+----------|
> > | 95th percentile | 150    | 150   |
> > +----------------------------------+
> >
> > What are the next steps to bring this behavior back? Will DELAY_DEQUEUE=
 always
> > be enabled by default and/or is there a fix coming for 6.12?
>
> DELAY_DEQUEUE should be enabled by default from v6.12 but there are a
> few fixes for the same in-flight. Could try running with the changes
> from [1] and [2] and see if you could reproduce the behavior and if
> you can, is it equally bad?
>
> Both changes apply cleanly for me on top of current
>
>      git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
>
> at commit fe9beaaa802d ("sched: No PREEMPT_RT=3Dy for all{yes,mod}config"=
)
> when applied in that order.
>
> [1] https://lore.kernel.org/lkml/172595576232.2215.18027704125134691219.t=
ip-bot2@tip-bot2/
> [2] https://lore.kernel.org/lkml/750542452c4f852831e601e1b8de40df4b108d9a=
.camel@gmx.de/

Have these changes landed in 6.12? Or will these in 6.13?

We tested 6.12 and the issue we reported is still present. What should
we do for any products we want to ship on 6.12? Disable Delayed
Dequeue or backport any fixes to 6.12 LTS?

Peter/Vincent, do you plan on backporting the future fixes to the 6.12
LTS kernel? Anything else we can do to help with making sure this is
fixed on the LTS kernel?

-Saravana

