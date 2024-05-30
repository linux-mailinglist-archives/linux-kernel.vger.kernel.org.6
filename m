Return-Path: <linux-kernel+bounces-195947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 879B98D54B9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B891C22533
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 21:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED043182D37;
	Thu, 30 May 2024 21:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owt5AtDP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0CD1DFE8
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 21:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717105487; cv=none; b=nnBoKtdBXsBqlQ5tIojqeyM/7aoABACXtfNbaGNwozaZI/3G3adG9sGWWTXfYC1Q1TSY+vwmydjJ8L6a7cyVQ96ZEd++Y/029NZFTKKN7gVQJouAIw+W2Ee6R5c3iGUpU21TaYDMAFa7v2Lh3TQsyGaJK6FwuA9NUGhP5n8bXIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717105487; c=relaxed/simple;
	bh=xTexikey00ziqD7XJK4HEWwkPAY00DaKANovgGshqUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mntq4V1KplicdVbyi/CVF7fFxhFbTCDNtxSlMKF518tkMJqnraaSbYOEPRDrXDnN5qmASyhEtf1GXh5vm33dzD5cvM2A9R/XZP3Qms7HA1zDl8Y3DFjW6HNjsd/KpJLnLTieEa8kYFQ0k1RqtY8cXTe/POfTfYNGVjZvvuTOzlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owt5AtDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3C5C4AF08
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 21:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717105486;
	bh=xTexikey00ziqD7XJK4HEWwkPAY00DaKANovgGshqUU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=owt5AtDP0wNSjgi0Zswu5c21HOigfQTehcqvsSECcuIOuIkDD2cMFKxfXWjkaWtgz
	 wFd4mYXKZndr9kFTRCO3Rmis+oPLxjjFf3HcYrDSoRz6l1GrI40gPjb7rd5ZVj11Jj
	 zxWHNxgSdYSEHjLuV7+gLb5f93iRLLMW6SGl/fVrAadpDBdJqc5rN4LbG9LvIPUREM
	 m9UXSgOkEqeuprILJrQlChLpEmyuaRbyzLKrP0gJyudDvWibpzaHiE7VQT0NQLvrRO
	 zwjeeFYN3Lp6xvFY6s3wo4UxSNDHbvKp9ZEVjrDKHXLFrzR+x7lhpe2daVHM4bFxnK
	 AXO4GmqlB8v9w==
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7e238fa7b10so59271039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 14:44:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6UClrdw6k5c1NWwPu3T1TSNAEFJERmPI5RUXyre8d6zDkvPxJFfPkFpgbQO9G407MgIykLJdVGO8hruWvFMwydzEEZfPp2KBZHAiJ
X-Gm-Message-State: AOJu0YxAGTpuMVn6fg9vZVO1v9jEsRycqKNOyaY/RRgU3ESBio4ZAfUP
	Yn7oedazy0z+NnWWPpNuCFz8PvUfCqfcvk2CrIRjYNNb+bfx8nbrlcgrhctZjRujiuDqOu0AIkP
	8Kydtw/W9gdc63aHEI4JuDmm36AtEn9elv8eb
X-Google-Smtp-Source: AGHT+IFgh/hCmDagsMpqF5f3V6G+qeag0qBtPz0QRClQj3b89J2Y6GBYeekuWfw5IEO0MFd1gKKTizXvAz9poDtU3rU=
X-Received: by 2002:a05:6602:14c5:b0:7e6:eb37:173c with SMTP id
 ca18e2360f4ac-7eafff2d9d0mr22681139f.14.1717105485912; Thu, 30 May 2024
 14:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
 <CANeU7QkmQ+bJoFnr-ca-xp_dP1XgEKNSwb489MYVqynP_Q8Ddw@mail.gmail.com>
 <87cyp5575y.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAF8kJuN8HWLpv7=abVM2=M247KGZ92HLDxfgxWZD6JS47iZwZA@mail.gmail.com>
 <875xuw1062.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <875xuw1062.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 30 May 2024 14:44:33 -0700
X-Gmail-Original-Message-ID: <CAF8kJuMc3sXKarq3hMPYGFfeqyo81Q63HrE0XtztK9uQkcZacA@mail.gmail.com>
Message-ID: <CAF8kJuMc3sXKarq3hMPYGFfeqyo81Q63HrE0XtztK9uQkcZacA@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: swap: mTHP swap allocator base on swap cluster order
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 7:54=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Chris Li <chrisl@kernel.org> writes:
>
> > Hi Ying,
> >
> > On Wed, May 29, 2024 at 1:57=E2=80=AFAM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Chris Li <chrisl@kernel.org> writes:
> >>
> >> > I am spinning a new version for this series to address two issues
> >> > found in this series:
> >> >
> >> > 1) Oppo discovered a bug in the following line:
> >> > +               ci =3D si->cluster_info + tmp;
> >> > Should be "tmp / SWAPFILE_CLUSTER" instead of "tmp".
> >> > That is a serious bug but trivial to fix.
> >> >
> >> > 2) order 0 allocation currently blindly scans swap_map disregarding
> >> > the cluster->order.
> >>
> >> IIUC, now, we only scan swap_map[] only if
> >> !list_empty(&si->free_clusters) && !list_empty(&si->nonfull_clusters[o=
rder]).
> >> That is, if you doesn't run low swap free space, you will not do that.
> >
> > You can still swap space in order 0 clusters while order 4 runs out of
> > free_cluster
> > or nonfull_clusters[order]. For Android that is a common case.
>
> When we fail to allocate order 4, we will fallback to order 0.  Still
> don't need to scan swap_map[].  But after looking at your below reply, I
> realized that the swap space is almost full at most times in your cases.
> Then, it's possible that we run into scanning swap_map[].
> list_empty(&si->free_clusters) &&
> list_empty(&si->nonfull_clusters[order]) will become true, if we put too
> many clusters in si->percpu_cluster.  So, if we want to avoid to scan
> swap_map[], we can stop add clusters in si->percpu_cluster when swap
> space runs low.  And maybe take clusters out of si->percpu_cluster
> sometimes.

One idea after reading your reply. If we run out of the
nonfull_cluster[order], we should be able to use other cpu's
si->percpu_cluster[] as well. That is a very small win for Android,
because android does not have too many cpu. We are talking about a
handful of clusters, which might not justify the code complexity. It
does not change the behavior that order 0 can pollut higher order.

>
> Another issue is nonfull_cluster[order1] cannot be used for
> nonfull_cluster[order2].  In definition, we should not fail order 0
> allocation, we need to steal nonfull_cluster[order>0] for order 0
> allocation.  This can avoid to scan swap_map[] too.  This may be not
> perfect, but it is the simplest first step implementation.  You can
> optimize based on it further.

Yes, that is listed as the limitation of this cluster order approach.
Initially we need to support one order well first. We might choose
what order that is, 16K or 64K folio. 4K pages are too small, 2M pages
are too big. The sweet spot might be some there in between.  If we can
support one order well, we can demonstrate the value of the mTHP. We
can worry about other mix orders later.

Do you have any suggestions for how to prevent the order 0 polluting
the higher order cluster? If we allow that to happen, then it defeats
the goal of being able to allocate higher order swap entries. The
tricky question is we don't know how much swap space we should reserve
for each order. We can always break higher order clusters to lower
order, but can't do the reserves. The current patch series lets the
actual usage determine the percentage of the cluster for each order.
However that seems not enough for the test case Barry has. When the
app gets OOM kill that is where a large swing of order 0 swap will
show up and not enough higher order usage for the brief moment. The
order 0 swap entry will pollute the high order cluster. We are
currently debating a "knob" to be able to reserve a certain % of swap
space for a certain order. Those reservations will be guaranteed and
order 0 swap entry can't pollute them even when it runs out of swap
space. That can make the mTHP at least usable for the Android case.

Do you see another way to protect the high order cluster polluted by
lower order one?

>
> And, I checked your code again.  It appears that si->percpu_cluster may
> be put in si->nonfull_cluster[], then be used by another CPU.  Please
> check it.

Ah, good point. I think it does. Let me take a closer look.

Chris


Chris

