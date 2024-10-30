Return-Path: <linux-kernel+bounces-389158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 218419B694C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454EB1C2199D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA5D215005;
	Wed, 30 Oct 2024 16:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aSAPuoDz"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBDA2144CA
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730306194; cv=none; b=T5r9LytCome/imO9DsXAn+m2BGEEGxey2uxzi/rrfhpghrN6BFUnx4TE1htJdFMV0m09oRBbT4emuWslLwhOT2yeOLWqXw4/EnR+gz6rbIhpYyQyitWpuWHtPZWQ8950wkZ/p6axmFrOBZ2sn7OFiZLtjcpXkVuyMb/ka4ahIsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730306194; c=relaxed/simple;
	bh=zCHrmiaT0aQkEzgBzKBRTHVHsnCbnwygmYP/jN0u0D8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PtlHaZrceBHfE3W9Z26x6YO8j4uhX/3OJy9VF3hISx60OJNMoZV9Hz7pWa2avUDOiJVBRqn+FPZtCfhR85o6Ks2b0uPaCM8uL0aZyQhQD5cg9ysPCcGHABGGRM6dC8cQYRZM0D8kWIqAAGyMhzDkGI6YUz+BhLVoi9cMA1KA2l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aSAPuoDz; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-460a8d1a9b7so338511cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 09:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730306191; x=1730910991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ohhnavrPr5+YUgso4iG8u5sjXey4qTkemT4mrkrez4=;
        b=aSAPuoDz0UR0ea5xI1iz5ZFeLgpnhvrv8xfS0PMaYhFKtGzucvKFkyxM30Hv5glE+b
         qrQMC51Hn9aRaGxbfa8jF7zwMwzpgb++DucM7cN9+NZHybf1LujW06SHGmBvV8J45TUG
         REgKSB4b6guIgeHM6LO7Vd5gnvwQ8nIIiYvCYVX6BpGK/5eRyAg1n80IzluKrTDdM4KM
         tFtyyfx+Oq2dnCWv7TMT25zfkhldPSdUE23tntsTBhT75AxI2BfkKU4sLeyjWJMRWg4l
         rGJpYUL/nxGDVjQkw+M7iFlv4vaviS7zJbibSgduVRoBOPNi0I0Ot7VPCF5IGx8gRYOc
         6bwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730306191; x=1730910991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ohhnavrPr5+YUgso4iG8u5sjXey4qTkemT4mrkrez4=;
        b=mNBLTssh0XXWDsuFKrdtuEe/uKqxyawY4HDe2j4CWsgNDuh6fPC8FS3StHa0GcrM9j
         q+YsqfsNONdkkABysHxBO/6Y/nTdOsg82toTqsfuk1W/BRSrK+shSxfxyKjVtZA+2KuK
         OvMpK60qjiuj19rR/dq2xxG5ojyGZjAechQcbQ2GSCHRWQHa3i1CFLbQcecyWM9EKmOn
         lpZfRMgfF8tN2GFL84Fyd/4cy/dFmw7ameYK6g12+djXe4xuCoV60kiv7Lxz9iZpIECP
         h7+E/0S1PrfG7vdA3ftRXXAcUGRBXczrKtdt4tJL5uLC8253N1p1IuY76ek7e8A5wGUP
         h2bw==
X-Forwarded-Encrypted: i=1; AJvYcCVBTE+PSnyh2Xd39Efq1OnDUIG4EhE3nQpWP4UUDD3qZAYP+scZkaTXmKh9J94IvkU0i0Jwp8PY23NB2A8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgXPfzTK8OGJwu6duNKpzRWMzqqjrVrTvx8iUMakvDekzImtwA
	C+zbHr8uzL0vlnfImfELXElMGmYk7z7duTJ1yIJYv6vmYU6nxvUB2OeTTHIQBvckMhz+BjWPreo
	2twOJGheONXAyUlcajZc4if/eOZfzBZUrw/cJ
X-Gm-Gg: ASbGnctZVyd5Ndn3/5wNHlIYm3M2HHD1gfPPGPrLBRNW//ozv0G8zKkRzYy+P9V/cgI
	w57pO3FEzt7Dc4EUtb0a5dJi5tL3OWq8w5z/9RFY7CgLlD+2USHon4yPB/0a6dQ==
X-Google-Smtp-Source: AGHT+IFBqNAhnZpINWYimOajsOUR5Hu7mWheBmruaCmzYI1pEkwMAvJVmKH+JkRRcQ8aMk7aGSnF9I1hvN2lZQ7/bOk=
X-Received: by 2002:a05:622a:cb:b0:461:3083:dbac with SMTP id
 d75a77b69052e-46166cf428fmr8624631cf.5.1730306190820; Wed, 30 Oct 2024
 09:36:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028234533.942542-1-rananta@google.com> <868qu63mdo.wl-maz@kernel.org>
 <CAJHc60x3sGdi2_mg_9uxecPYwZMBR11m1oEKPEH4RTYaF8eHdQ@mail.gmail.com>
 <865xpa3fwe.wl-maz@kernel.org> <CAJHc60xQNeTwSBuPhrKO_JBuikqZ7R=BM5rkWht3YwieVXwkHg@mail.gmail.com>
 <87iktat2y8.wl-maz@kernel.org>
In-Reply-To: <87iktat2y8.wl-maz@kernel.org>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Wed, 30 Oct 2024 09:36:19 -0700
Message-ID: <CAJHc60w7edpTSG2VA52m96BP6Eayg2jEc=9nt_b_kJFnOoQxfw@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: arm64: Get rid of userspace_irqchip_in_use
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 1:22=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Wed, 30 Oct 2024 00:16:48 +0000,
> Raghavendra Rao Ananta <rananta@google.com> wrote:
> >
> > On Tue, Oct 29, 2024 at 11:47=E2=80=AFAM Marc Zyngier <maz@kernel.org> =
wrote:
> > >
> > > On Tue, 29 Oct 2024 17:06:09 +0000,
> > > Raghavendra Rao Ananta <rananta@google.com> wrote:
> > > >
> > > > On Tue, Oct 29, 2024 at 9:27=E2=80=AFAM Marc Zyngier <maz@kernel.or=
g> wrote:
> > > > >
> > > > > On Mon, 28 Oct 2024 23:45:33 +0000,
> > > > > Raghavendra Rao Ananta <rananta@google.com> wrote:
> > > > > >
> > > > > Did you have a chance to check whether this had any negative impa=
ct on
> > > > > actual workloads? Since the entry/exit code is a bit of a hot spo=
t,
> > > > > I'd like to make sure we're not penalising the common case (I onl=
y
> > > > > wrote this patch while waiting in an airport, and didn't test it =
at
> > > > > all).
> > > > >
> > > > I ran the kvm selftests, kvm-unit-tests and booted a linux guest to
> > > > test the change and noticed no failures.
> > > > Any specific test you want to try out?
> > >
> > > My question is not about failures (I didn't expect any), but
> > > specifically about *performance*, and whether checking the flag
> > > without a static key can lead to any performance drop on the hot path=
.
> > >
> > > Can you please run an exit-heavy workload (such as hackbench, for
> > > example), and report any significant delta you could measure?
> >
> > Oh, I see. I ran hackbench and micro-bench from kvm-unit-tests (which
> > also causes a lot of entry/exits), on Ampere Altra with kernel at
> > v6.12-rc1, and see no significant difference in perf.
>
> Thanks for running this stuff.
>
> > timer_10ms                          231040.0                          9=
02.0
> > timer_10ms                         234120.0                            =
914.0
>
> This seems to be the only case were we are adversely affected by this
> change.
Hmm, I'm not sure how much we want to trust this comparison. For
instance, I just ran micro-bench again a few more times and here are
the outcomes of timer_10ms for each try with the patch:

Tries                                             total ns
               avg ns
---------------------------------------------------------------------------=
--------
1_timer_10ms                             231840.0                          =
905.0
2_timer_10ms                             234560.0                          =
916.0
3_timer_10ms                             227440.0                          =
888.0
4_timer_10ms                             236640.0                          =
924.0
5_timer_10ms                             231200.0                          =
903.0

Here's a few on the baseline:

Tries                                             total ns
               avg ns
---------------------------------------------------------------------------=
--------
1_timer_10ms                             231080.0                          =
902.0
2_timer_10ms                             238040.0                          =
929.0
3_timer_10ms                             231680.0                          =
905.0
4_timer_10ms                             229280.0                          =
895.0
5_timer_10ms                             228520.0                          =
892.0


> In the grand scheme of thins, that's noise. But this gives us
> a clear line of sight for the removal of the in-kernel interrupts back
> to userspace.
Sorry, I didn't follow you completely on this part.

Thank you.
Raghavendra

