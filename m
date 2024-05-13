Return-Path: <linux-kernel+bounces-177402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6918C3E0F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3531E1F22801
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958A61487E4;
	Mon, 13 May 2024 09:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j63hniXV"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BA61474CF
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715592269; cv=none; b=glhZnmQlzEkfGvr39Dr4rStfi+6rdTd6Yrz45B37OEfy2rElHMHVBIVrxMPhJX9jgMNl1mDsvJud3KYHjkbTVV+q7JXkJzIFNpL6fb73kOr1+/9YdrOxBFNYZQMng3MZSda6UovlnCvorSCxMYRFv+ZX1pbZcz7AqDtKGJunJ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715592269; c=relaxed/simple;
	bh=G3P8pKBkUxtHn6+xxLznaAcPcfOwh3sOpF/PZNDuXmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nYW1zea/214SiD2rewT3d/FATfT22j4mJPwbSFDactyEsQrc6HRBV+LnR/DCoRFgrnug5Tx6ZtA5vM220g4SY8BM1wYPeCTEi7hc94CD9ksS/GsF0EyMeyEcQPJo9dYas2Oqlle9ywSvIaC5E+Q5s+BCVKGJnKGeG1+lNHYS3SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j63hniXV; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7f18331b308so1564016241.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 02:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715592267; x=1716197067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HStxf7GkUt0sV5NStZS4CtVmqRThp9porzrMQBFZ7hI=;
        b=j63hniXV1MS2bhK7HMLM9byxBpUrGF0OCZnC2aFB/uEqKrqDbLZBtvBaZKGMjE53Qb
         N1TLKN6+wEyaNMpIsGpuppy0dyEImdgvuAfAvqfeXQFnt8AD9kbMAoloXn7kZHUETEK4
         /mrsY+4lczIaAqzBQ4vr+XVcmzWVwjjyzMxRT1k+XFYfsYFEbbJ6pZf/wH+py7fhfj3W
         V5Wvx9enqprfrPZBC3p67VSrtqdxbCB+LTfZuFGx/Jo4YqLbcP4r87aHznT1gb7b3hHD
         mxgSmh4XFs9Z0673PhJBhmyOmGFomH8Ex3+wI9ReF33dc6B8h4q/N5stgSvF/ETiQVLO
         ZhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715592267; x=1716197067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HStxf7GkUt0sV5NStZS4CtVmqRThp9porzrMQBFZ7hI=;
        b=hFT5lJfYSjkHAvuBS0/ENPKqsgaqyTvtN8BlBYl8f4+sMhLz71qRjAX/+fEfmfZcV9
         hn1bAZ45La5JIHClmAZqXpOoC5cgf7gYu+XHMHyLoad0aQt3YrmKvXg24l2q+CPXDHJs
         wIETGoBpls7XSOioNsXUP28MK/10xRaoaSjZS+NIWHdU7g3lUs8ugyKGCwnn04n6lmDY
         JyS80sgTIb7T/fFgxQyInWPzKZaKTEnmnP2RwNr+KcIh+iKnCtXtl4kAIPqOP+gilZXO
         7o2RQN/GH4n/lSOLhxzyADPEdC6vzOgBu5aTH3lVFslEokeeiwPldNtAv1ysn8BVl3SV
         8STw==
X-Forwarded-Encrypted: i=1; AJvYcCWNNoiPiCWj6u+gtIjK0cU+YwPFFYAj/OmC6FoaPU/XGiTTp7x28NpHEhsCADN1+ugSvIUqGO3ZjsFiy2+JBiDcTr0t0W1g32L0QHcJ
X-Gm-Message-State: AOJu0YxrOD9jwURSV/TN5CtcqqLeVfL+7vqpfq3GlfTXu4i+l5fYub4E
	V1u1h962q6ugCYZXioCQevUUi6YqFcx3U6x6htAnS1bAzi5IKLxKTXE25TDMQQ8w8H1FEcFK854
	J9ZmtpW/X1eEovEf9ECJeig9vKaQ=
X-Google-Smtp-Source: AGHT+IF+YLWYvJCQntdv5In7TQzqfQD8V9aSwtwZZGQO/04OSdnQu3sKywaEmysb1Qve8rDkWol7rLCquzuHrt5TjZM=
X-Received: by 2002:a05:6102:390b:b0:47c:2a80:ac49 with SMTP id
 ada2fe7eead31-48077e71426mr8368102137.26.1715592266796; Mon, 13 May 2024
 02:24:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408183946.2991168-1-ryan.roberts@arm.com>
 <20240408183946.2991168-6-ryan.roberts@arm.com> <CAGsJ_4zAcJkuW016Cfi6wicRr8N9X+GJJhgMQdSMp+Ah+NSgNQ@mail.gmail.com>
 <17b4f026-d734-4610-8517-d83081f75ed4@arm.com>
In-Reply-To: <17b4f026-d734-4610-8517-d83081f75ed4@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 13 May 2024 21:24:13 +1200
Message-ID: <CAGsJ_4zEbqkEwzG0p-svwBA8obY0fSGqqthH7guc5qcxodM8hg@mail.gmail.com>
Subject: Re: [PATCH v7 5/7] mm: swap: Allow storage of all mTHP orders
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>, 
	Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Chris Li <chrisl@kernel.org>, 
	Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 8:43=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 13/05/2024 08:30, Barry Song wrote:
> > On Tue, Apr 9, 2024 at 6:40=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.c=
om> wrote:
> >>
> >> Multi-size THP enables performance improvements by allocating large,
> >> pte-mapped folios for anonymous memory. However I've observed that on =
an
> >> arm64 system running a parallel workload (e.g. kernel compilation)
> >> across many cores, under high memory pressure, the speed regresses. Th=
is
> >> is due to bottlenecking on the increased number of TLBIs added due to
> >> all the extra folio splitting when the large folios are swapped out.
> >>
> >> Therefore, solve this regression by adding support for swapping out mT=
HP
> >> without needing to split the folio, just like is already done for
> >> PMD-sized THP. This change only applies when CONFIG_THP_SWAP is enable=
d,
> >> and when the swap backing store is a non-rotating block device. These
> >> are the same constraints as for the existing PMD-sized THP swap-out
> >> support.
> >>
> >> Note that no attempt is made to swap-in (m)THP here - this is still do=
ne
> >> page-by-page, like for PMD-sized THP. But swapping-out mTHP is a
> >> prerequisite for swapping-in mTHP.
> >>
> >> The main change here is to improve the swap entry allocator so that it
> >> can allocate any power-of-2 number of contiguous entries between [1, (=
1
> >> << PMD_ORDER)]. This is done by allocating a cluster for each distinct
> >> order and allocating sequentially from it until the cluster is full.
> >> This ensures that we don't need to search the map and we get no
> >> fragmentation due to alignment padding for different orders in the
> >> cluster. If there is no current cluster for a given order, we attempt =
to
> >> allocate a free cluster from the list. If there are no free clusters, =
we
> >> fail the allocation and the caller can fall back to splitting the foli=
o
> >> and allocates individual entries (as per existing PMD-sized THP
> >> fallback).
> >>
> >> The per-order current clusters are maintained per-cpu using the existi=
ng
> >> infrastructure. This is done to avoid interleving pages from different
> >> tasks, which would prevent IO being batched. This is already done for
> >> the order-0 allocations so we follow the same pattern.
> >>
> >> As is done for order-0 per-cpu clusters, the scanner now can steal
> >> order-0 entries from any per-cpu-per-order reserved cluster. This
> >> ensures that when the swap file is getting full, space doesn't get tie=
d
> >> up in the per-cpu reserves.
> >>
> >> This change only modifies swap to be able to accept any order mTHP. It
> >> doesn't change the callers to elide doing the actual split. That will =
be
> >> done in separate changes.
>
> [...]
>
> >
> > Hi Ryan,
> >
> > Sorry for bringing up an old thread.
>
> No problem - thanks for the report!
>
> >
> > During the initial hour of utilizing an Android phone with 64KiB mTHP,
> > we noticed that the
> > anon_swpout_fallback rate was less than 10%. However, after several
> > hours of phone
> > usage, we observed a significant increase in the anon_swpout_fallback
> > rate, reaching
> > 100%.
>
> I suspect this is due to fragmentation of the clusters; If there is just =
one
> page left in a cluster then the cluster can't be freed and once the clust=
er free
> list is empty a new cluster allcoation will fail and this will cause fall=
back to
> order-0.
>
> >
> > As I checked the code of scan_swap_map_try_ssd_cluster(),
> >
> > static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
> >         unsigned long *offset, unsigned long *scan_base, int order)
> > {
> >         unsigned int nr_pages =3D 1 << order;
> >         struct percpu_cluster *cluster;
> >         struct swap_cluster_info *ci;
> >         unsigned int tmp, max;
> >
> > new_cluster:
> >         cluster =3D this_cpu_ptr(si->percpu_cluster);
> >         tmp =3D cluster->next[order];
> >         if (tmp =3D=3D SWAP_NEXT_INVALID) {
> >                 if (!cluster_list_empty(&si->free_clusters)) {
> >                         tmp =3D cluster_next(&si->free_clusters.head) *
> >                                         SWAPFILE_CLUSTER;
> >                 } else if (!cluster_list_empty(&si->discard_clusters)) =
{
> >                         /*
> >                          * we don't have free cluster but have some clu=
sters in
> >                          * discarding, do discard now and reclaim them,=
 then
> >                          * reread cluster_next_cpu since we dropped si-=
>lock
> >                          */
> >                         swap_do_scheduled_discard(si);
> >                         *scan_base =3D this_cpu_read(*si->cluster_next_=
cpu);
> >                         *offset =3D *scan_base;
> >                         goto new_cluster;
> >                 } else
> >                         return false;
> >         }
> > ...
> >
> > }
> >
> > Considering the cluster_list_empty() checks, is it necessary to have
> > free_cluster to
> > ensure a continuous allocation of swap slots for large folio swap out?
>
> Yes, currently that is done by design; if we can't allocate a free cluste=
r then
> we only scan for free space in an already allocated cluster for order-0
> allocations. I did this for a couple of reasons;
>
> 1: Simplicity.
>
> 2: Keep behavior the same as PMD-order allocations, which are never scann=
ed
> (although the cluster is the same size as the PMD so scanning would be po=
intless
> there - so perhaps this is not a good argument for not scanning smaller h=
igh
> orders).
>
> 3: If scanning for a high order fails then we would fall back to order-0 =
and
> scan again, so I was trying to avoid the potential for 2 scans (although =
once
> you split the page, you'll end up scanning per-page, so perhaps its not a=
 real
> argument either).
>
> > For instance,
> > if numerous clusters still possess ample free swap slots, could we
> > potentially miss
> > out on them due to a lack of execution of a slow scan?
>
> I think it would definitely be possible to add support for scanning high =
orders
> and from memory, I don't think it would be too difficult. Based on your
> experience, it sounds like this would be valuable.
>
> I'm going to be out on Paternity leave for 3 weeks from end of today, so =
I won't
> personally be able to do this until I get back. I might find some time to=
 review
> if you were to post something though :)

Congratulations on the arrival of your precious little one! Forget
about the swap and
mTHP, enjoy your time with the family :-)

>
> >
> > I'm not saying your patchset has problems, just that I have some questi=
ons.
>
> Let's call it "opportunity for further improvement" rather than problems.=
 :)
>
> I suspect swap-in of large folios may help reduce the fragmentation a bit=
 since
> we are less likely to keep parts of a previously swapped-out mTHP in swap=
.
>
> Also, I understand that Chris Li has been doing some thinking around an
> indirection layer which would remove the requirement for pages of a large=
 folio
> to be stored contiguously in the swap file. I think he is planning to tal=
k about
> that at LSFMM? (which I sadly won't be attending).
>
> Thanks,
> Ryan
>
> >

Thanks
Barry

