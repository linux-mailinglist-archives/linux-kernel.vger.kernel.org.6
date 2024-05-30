Return-Path: <linux-kernel+bounces-195786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175C98D51D1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 20:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5015AB24C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 18:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723734F8A1;
	Thu, 30 May 2024 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igDC0ATH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A710C4F5E6
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717093917; cv=none; b=f/CJ6vQhf3telJCGJUhwOKJCGrLUFO0M3YhCadF205dpXPPY7wVht8pwEgbugN0DQuTVGBfHO39gtd3xxpGZQPdZv0oNp/9OCjP1odWRjWOErPm1su5N2AMN8cPJt5f74S76LMJkHSqo/Vsxlp5KjNDxJpoKJvVFte44LqHATpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717093917; c=relaxed/simple;
	bh=Exa+Vd5MGJ5Z8QN6/iFZfytwsDyCBIhtpCeeCY1v3eI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OqWArIwwkwNQ24sz6/z8IJvr+wkMfcbeXzFRaJiRBj04G3hP+DnwEPaCxwfG+nFBlbbkqXQmZdDRtB3Zu6CGsJl6mHSOsQmYR0r5SGvPQdD+pclqU5SD/5M6bQTmDtfAZXjRCAUzKdwuBQIyd4igqRxfVz8aAbRgOapqam8RjTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igDC0ATH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9FEC4AF08
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 18:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717093917;
	bh=Exa+Vd5MGJ5Z8QN6/iFZfytwsDyCBIhtpCeeCY1v3eI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=igDC0ATHmElk/YvPxUsp8b7/OXVQmV9chaffZ+IjpIh0Lnjgk8hxN2hhgFZBAinNX
	 q+gwTamGCvmSYt+NtkUragnLvUekb8Bn7bsv0fSb9E6mdv3b5LyY8N+01Gc5b5pSQ7
	 NknIfeypTmRe3rfTdOsqX6Bc/GtLR9oI2p5hwER4T+3+mNZi5AHRw8UGddFi8MKTqA
	 jDmBNkrahy0dB7TcTB0sMRCooA73bCqcdUG2fxVtJmAZjNbl2r1aO8jKodVe8QcqV2
	 RbPN9WQyUNziE18nvTvcNuQEwUs4VFL+Mt6lbaBotJydThEx5pVusZxFMnq4ssKyh7
	 1iKhmPe8ZHnlg==
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3747e9f7cceso982125ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 11:31:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXTb+IQYUiT/IV4wiAAApGllFAzsOd4FPLb6hdUWBxaurxvrH/3gkHA0n5fsFs6LZjqzOXKj2tyJXEOUuMC+OLUDJSuf8FYyJO7RRJv
X-Gm-Message-State: AOJu0YwZbgoNSrhQ7iKqKgZdNwruHpdEbHS0e9rb4J5ulbPViZzjDLfy
	OpdqF9PoQ74HfVFrQ0nyBVqY5/+hExVDhSFqAlJeUtqTw+Pued5qe9pLBmsBcAAAM/vMt4rriXd
	dY4nx2fGxRFFsFJfoFYyKw2+Cwc0fBb4RyAC+
X-Google-Smtp-Source: AGHT+IFyhiXVZVJOvERxK1XEwIiQ/eCHWljMIp7VcDvDaSucBm6NPDO9l14qN/4XrsE2buGE40WywlDeGncp8QKLPWk=
X-Received: by 2002:a05:6e02:b26:b0:374:61ee:57c1 with SMTP id
 e9e14a558f8ab-3747df634a6mr33671855ab.10.1717093916396; Thu, 30 May 2024
 11:31:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
 <CANeU7QkmQ+bJoFnr-ca-xp_dP1XgEKNSwb489MYVqynP_Q8Ddw@mail.gmail.com>
 <87cyp5575y.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAF8kJuN8HWLpv7=abVM2=M247KGZ92HLDxfgxWZD6JS47iZwZA@mail.gmail.com>
 <875xuw1062.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAMgjq7AoCL3yqBiys+ksoKQVZW_AopzhuXk7xzQzSwBxHZumeQ@mail.gmail.com>
In-Reply-To: <CAMgjq7AoCL3yqBiys+ksoKQVZW_AopzhuXk7xzQzSwBxHZumeQ@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 30 May 2024 11:31:44 -0700
X-Gmail-Original-Message-ID: <CAF8kJuOTR0LVEffLNYxNUp8XK4aBs_1U9erbLJVLveWq+i7L2w@mail.gmail.com>
Message-ID: <CAF8kJuOTR0LVEffLNYxNUp8XK4aBs_1U9erbLJVLveWq+i7L2w@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: swap: mTHP swap allocator base on swap cluster order
To: Kairui Song <ryncsn@gmail.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 1:08=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Thu, May 30, 2024 at 10:54=E2=80=AFAM Huang, Ying <ying.huang@intel.co=
m> wrote:
> >
> > Chris Li <chrisl@kernel.org> writes:
> >
> > > Hi Ying,
> > >
> > > On Wed, May 29, 2024 at 1:57=E2=80=AFAM Huang, Ying <ying.huang@intel=
com> wrote:
> > >>
> > >> Chris Li <chrisl@kernel.org> writes:
> > >>
> > >> > I am spinning a new version for this series to address two issues
> > >> > found in this series:
> > >> >
> > >> > 1) Oppo discovered a bug in the following line:
> > >> > +               ci =3D si->cluster_info + tmp;
> > >> > Should be "tmp / SWAPFILE_CLUSTER" instead of "tmp".
> > >> > That is a serious bug but trivial to fix.
> > >> >
> > >> > 2) order 0 allocation currently blindly scans swap_map disregardin=
g
> > >> > the cluster->order.
> > >>
> > >> IIUC, now, we only scan swap_map[] only if
> > >> !list_empty(&si->free_clusters) && !list_empty(&si->nonfull_clusters=
[order]).
> > >> That is, if you doesn't run low swap free space, you will not do tha=
t.
> > >
> > > You can still swap space in order 0 clusters while order 4 runs out o=
f
> > > free_cluster
> > > or nonfull_clusters[order]. For Android that is a common case.
> >
> > When we fail to allocate order 4, we will fallback to order 0.  Still
> > don't need to scan swap_map[].  But after looking at your below reply, =
I
> > realized that the swap space is almost full at most times in your cases=
.
> > Then, it's possible that we run into scanning swap_map[].
> > list_empty(&si->free_clusters) &&
> > list_empty(&si->nonfull_clusters[order]) will become true, if we put to=
o
> > many clusters in si->percpu_cluster.  So, if we want to avoid to scan
> > swap_map[], we can stop add clusters in si->percpu_cluster when swap
> > space runs low.  And maybe take clusters out of si->percpu_cluster
> > sometimes.
>
> Stop adding when it runs low seems too late, there could still be a
> free cluster stuck on a CPU, and not getting scanned, right?

The free clusters stuck on the CPU are a  small number. Only a handful
of clusters. Preventing low order swap polluting the high order
cluster is more urgent.

>
> > Another issue is nonfull_cluster[order1] cannot be used for
> > nonfull_cluster[order2].  In definition, we should not fail order 0
> > allocation, we need to steal nonfull_cluster[order>0] for order 0
> > allocation.  This can avoid to scan swap_map[] too.  This may be not
> > perfect, but it is the simplest first step implementation.  You can
> > optimize based on it further.
>
> This can be extended to allow any order < MAX_ORDER to steal from
> higher order, which might increase fragmentation though.

Steal from higher order is a bad thing. Because the value of the
allocator is able to allocate from higher order.
High to low is always trivil, the low to high is impossible. See the
other email having a "knob" to reserve some swap space for high order
allocations. That is not perfect but more useful.

>
> So this is looking more and more like a buddy allocator, and that
> should be the long term solution.
>
In Barry's test case, there is a huge swing of order 0 and order 4
allocation caused by the low memory killer. Apps get killed and take a
while for the app to launch and swap out high order entries. The buddy
allocator will have limited help there because once cluster is used
for order 0, the fragmentation will prevent higher order allocation.
Buddy allocator might not be able to help much in this situation. We
do need a way to swap out large folios using discontiguous swap
entries. That is the longer term solution to Barry's usage situation.

Chris

