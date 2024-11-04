Return-Path: <linux-kernel+bounces-394345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE96B9BADAB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BF69B20EAC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 08:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A691A0BD8;
	Mon,  4 Nov 2024 08:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d061tkIw"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4584C19D8B2
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 08:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730707621; cv=none; b=icY/6PxcUP+OGBtD+mGU9KtARXLh8v1RpB7g0DHaAy4vDh8824MpYnXtcRbvkSnc8ctoWhKhT+6w7ujvNUXJf+hghgXrnG8CNWyMAC1dXnIUyP7dUjva/6kqjDdLScjaciA7FgMaNpb6LxdsslnNcta+YM5P3c3LmlNwkUKwFwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730707621; c=relaxed/simple;
	bh=LVEGeiTwHx28ZFBeJ0YTO/MA8h15F3SGXaSlXaecb2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7StlwJFuzLxoeqznsA9SbhupNCR1xCp7cmRDloFcSWfoMQqoBHnK/rsyPrEZO/RRxAwWAwd5Etla34F7ljBNzQwTZDGJYZ9SHAaNROWFIra+3lUQnAbIwlBwWA9s8LLhfoWQ8wFO70RyKtFqqTElIRcjIhGYDn6uHkJIpsYdVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d061tkIw; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-50d399891d6so1096384e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 00:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730707618; x=1731312418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/8mDEDTeSvNL26YQTk80QGTDhA3l2OBXppNz2Bi18s=;
        b=d061tkIwEcbtQJhWucdCzU33K9S2VJ5dYtUo+HGJcNsOLahbrSoXbxv9jI+9FVZebR
         B+UN4OM9khkn/sxrBpoVrnoIjTdC+iGyVxb6LaBzykW5tg5yLs1+lXY/aeWHdyOSnPLN
         o+xr3fMKw9Cix5JsO32NAFFvDvpuR8H8vGFd+L8svm512X3pIAuV+PQBkAMJdqr3tgJQ
         g80iCMEj8JuJcuzqjJWcMSpHqfUMaNIvIbKUKmq3R0iIBjuw5ZvAZ9TmxF0HVRLRnFac
         zurYhAVSvv1Pptp4ozRls3jDiipZkSOHF/JYm7YRb1mFzyCEVWKfnPL7qy3dRBZpETQh
         68BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730707618; x=1731312418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/8mDEDTeSvNL26YQTk80QGTDhA3l2OBXppNz2Bi18s=;
        b=VVpbi53bKa2nfhnnBQBHfZRn3RqJnSJ8lZKCgkxYTzJskdv/KfZSx0K5YHxkGHvhbb
         j7eVMF7LM78NvRd77OIFAo7IBQwl0H0eHc7PDYkMihjB+IQ53JDJtTnIEZPB5rLLxE5a
         ENb9ZSoq/eB2YDqRb7ek4+MDszanpnNXAOASy73uxho0W3RVNHo0r6NOj9Z6RsCEferf
         Jox132q3wZLUluATrVsuLsJ1o6r5jbqb5LZ3Vgb1RCBFVl0E/54tJuUtnTiIPUoHcSb2
         YWVxw9XHXhIqaOBUJyWf177VBXKCIuOvQ8sIoMO4omlygmjNWDmwAcDFuI34MheVP96M
         oLkg==
X-Forwarded-Encrypted: i=1; AJvYcCX3j5ZVQwCUITSEItxAnmNT9/Uym5PhCXdLdl76LnYCYltYzvNTGwCAyzw5lq1KJecIMMd52OL86smBGoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFquvltw2X5Ac891kqgWdWDKKjz1HWlxB3XIovl1CPXtucdZgQ
	/zqRslXZqmeIvjr7bwCqa5b1c4fjRtNEkUDHolXs2eKh4zvXoc+Btec3DvHLw9HxF5+fIxr225J
	TEThllv/iPsbsBPPr6QZUL2IPxXQ=
X-Google-Smtp-Source: AGHT+IED8hPZTJb8P1QRSqkns/pKY/I89SSXSvc1CKAfEKjbTCef9CGAIfOivZGi5daILAAkpfOrkuiGvT9xwNrbCAE=
X-Received: by 2002:a05:6102:2921:b0:4a3:d215:427f with SMTP id
 ada2fe7eead31-4a962f7cbc8mr7867737137.23.1730707617970; Mon, 04 Nov 2024
 00:06:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027001444.3233-1-21cnbao@gmail.com> <33c5d5ca-7bc4-49dc-b1c7-39f814962ae0@gmail.com>
 <CAGsJ_4wdgptMK0dDTC5g66OE9WDxFDt7ixDQaFCjuHdTyTEGiA@mail.gmail.com>
 <e8c6d46c-b8cf-4369-aa61-9e1b36b83fe3@gmail.com> <CAJD7tkZ60ROeHek92jgO0z7LsEfgPbfXN9naUC5j7QjRQxpoKw@mail.gmail.com>
 <852211c6-0b55-4bdd-8799-90e1f0c002c1@gmail.com> <CAJD7tkaXL_vMsgYET9yjYQW5pM2c60fD_7r_z4vkMPcqferS8A@mail.gmail.com>
 <c76635d7-f382-433a-8900-72bca644cdaa@gmail.com> <CAJD7tkYSRCjtEwP=o_n_ZhdfO8nga-z-a=RirvcKL7AYO76XJw@mail.gmail.com>
 <20241031153830.GA799903@cmpxchg.org> <87a5ef8ppq.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87a5ef8ppq.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 4 Nov 2024 21:06:46 +1300
Message-ID: <CAGsJ_4yALxTVuHOf_y00DbYp=kjEZuL3q6sWfn2Wf-Y+_G5RjA@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: mitigate large folios usage and swap thrashing
 for nearly full memcg
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, David Hildenbrand <david@redhat.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 7:46=E2=80=AFPM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> Johannes Weiner <hannes@cmpxchg.org> writes:
>
> > On Wed, Oct 30, 2024 at 02:18:09PM -0700, Yosry Ahmed wrote:
> >> On Wed, Oct 30, 2024 at 2:13=E2=80=AFPM Usama Arif <usamaarif642@gmail=
.com> wrote:
> >> > On 30/10/2024 21:01, Yosry Ahmed wrote:
> >> > > On Wed, Oct 30, 2024 at 1:25=E2=80=AFPM Usama Arif <usamaarif642@g=
mail.com> wrote:
> >> > >>>> I am not sure that the approach we are trying in this patch is =
the right way:
> >> > >>>> - This patch makes it a memcg issue, but you could have memcg d=
isabled and
> >> > >>>> then the mitigation being tried here wont apply.
> >> > >>>
> >> > >>> Is the problem reproducible without memcg? I imagine only if the
> >> > >>> entire system is under memory pressure. I guess we would want th=
e same
> >> > >>> "mitigation" either way.
> >> > >>>
> >> > >> What would be a good open source benchmark/workload to test witho=
ut limiting memory
> >> > >> in memcg?
> >> > >> For the kernel build test, I can only get zswap activity to happe=
n if I build
> >> > >> in cgroup and limit memory.max.
> >> > >
> >> > > You mean a benchmark that puts the entire system under memory
> >> > > pressure? I am not sure, it ultimately depends on the size of memo=
ry
> >> > > you have, among other factors.
> >> > >
> >> > > What if you run the kernel build test in a VM? Then you can limit =
is
> >> > > size like a memcg, although you'd probably need to leave more room
> >> > > because the entire guest OS will also subject to the same limit.
> >> > >
> >> >
> >> > I had tried this, but the variance in time/zswap numbers was very hi=
gh.
> >> > Much higher than the AMD numbers I posted in reply to Barry. So foun=
d
> >> > it very difficult to make comparison.
> >>
> >> Hmm yeah maybe more factors come into play with global memory
> >> pressure. I am honestly not sure how to test this scenario, and I
> >> suspect variance will be high anyway.
> >>
> >> We can just try to use whatever technique we use for the memcg limit
> >> though, if possible, right?
> >
> > You can boot a physical machine with mem=3D1G on the commandline, which
> > restricts the physical range of memory that will be initialized.
> > Double check /proc/meminfo after boot, because part of that physical
> > range might not be usable RAM.
> >
> > I do this quite often to test physical memory pressure with workloads
> > that don't scale up easily, like kernel builds.
> >
> >> > >>>> - Instead of this being a large folio swapin issue, is it more =
of a readahead
> >> > >>>> issue? If we zswap (without the large folio swapin series) and =
change the window
> >> > >>>> to 1 in swap_vma_readahead, we might see an improvement in linu=
x kernel build time
> >> > >>>> when cgroup memory is limited as readahead would probably cause=
 swap thrashing as
> >> > >>>> well.
> >
> > +1
> >
> > I also think there is too much focus on cgroup alone. The bigger issue
> > seems to be how much optimistic volume we swap in when we're under
> > pressure already. This applies to large folios and readahead; global
> > memory availability and cgroup limits.
>
> The current swap readahead logic is something like,
>
> 1. try readahead some pages for sequential access pattern, mark them as
>    readahead
>
> 2. if these readahead pages get accessed before swapped out again,
>    increase 'hits' counter
>
> 3. for next swap in, try readahead 'hits' pages and clear 'hits'.
>
> So, if there's heavy memory pressure, the readaheaded pages will not be
> accessed before being swapped out again (in 2 above), the readahead
> pages will be minimal.
>
> IMHO, mTHP swap-in is kind of swap readahead in effect.  That is, in
> addition to the pages accessed are swapped in, the adjacent pages are
> swapped in (swap readahead) too.  If these readahead pages are not
> accessed before swapped out again, system runs into more severe
> thrashing.  This is because we lack the swap readahead window scaling
> mechanism as above.  And, this is why I suggested to combine the swap
> readahead mechanism and mTHP swap-in by default before.  That is, when
> kernel swaps in a page, it checks current swap readahead window, and
> decides mTHP order according to window size.  So, if there are heavy
> memory pressure, so that the nearby pages will not be accessed before
> being swapped out again, the mTHP swap-in order can be adjusted
> automatically.

This might help reduce memory reclamation thrashing for kernel build
workload running in a memory limited memcg which might not benefit
from mTHP that much. But this mechanism has clear disadvantages:

1. Loss of large folios: For example, if you're using app A and then switch
to app B, a significant portion (around 60%) of A's memory might be swapped
out as it moves to the background. When you switch back to app A, a large
portion of the memory originally in mTHP could be lost while swapping
in small folios.

Essentially, systems with a user interface operate quite differently from k=
ernel
build workloads running under a memory-limited memcg, as they switch
applications between the foreground and background.

2. Fragmentation of swap slots: This fragmentation increases the likelihood=
 of
mTHP swapout failures, as it makes it harder to maintain contiguous memory
blocks in swap.

3. Prevent the implementation of large block compression and decompression
to achieve higher compression ratios and significantly lower CPU consumptio=
n,
as small folio swap-ins may still remain the predominant approach.

Memory-limited systems often face challenges with larger page sizes. Even o=
n
systems that support various base page sizes, such as 4KB, 16KB, and 64KB
on ARM64, using 16KB or 64KB as the base page size is not always the best
choice.  With mTHP, we have already enabled per-size settings. For this ker=
nel
build workload operating within a limited memcg, enabling only 16kB is like=
ly
the best option for optimizing performance and minimizing thrashing.
/sys/kernel/mm/transparent_hugepage/hugepages-16kB/enabled

We could focus on mTHP and seek strategies to minimize thrashing when free
memory is severely limited :-)

>
> > It happens to manifest with THP in cgroups because that's what you
> > guys are testing. But IMO, any solution to this problem should
> > consider the wider scope.
> >
> >> > >>> I think large folio swapin would make the problem worse anyway. =
I am
> >> > >>> also not sure if the readahead window adjusts on memory pressure=
 or
> >> > >>> not.
> >> > >>>
> >> > >> readahead window doesnt look at memory pressure. So maybe the sam=
e thing is being
> >> > >> seen here as there would be in swapin_readahead?
> >> > >
> >> > > Maybe readahead is not as aggressive in general as large folio
> >> > > swapins? Looking at swap_vma_ra_win(), it seems like the maximum o=
rder
> >> > > of the window is the smaller of page_cluster (2 or 3) and
> >> > > SWAP_RA_ORDER_CEILING (5).
> >> > Yes, I was seeing 8 pages swapin (order 3) when testing. So might
> >> > be similar to enabling 32K mTHP?
> >>
> >> Not quite.
> >
> > Actually, I would expect it to be...
>
> Me too.
>
> >> > > Also readahead will swapin 4k folios AFAICT, so we don't need a
> >> > > contiguous allocation like large folio swapin. So that could be
> >> > > another factor why readahead may not reproduce the problem.
> >>
> >> Because of this ^.
> >
> > ...this matters for the physical allocation, which might require more
> > reclaim and compaction to produce the 32k. But an earlier version of
> > Barry's patch did the cgroup margin fallback after the THP was already
> > physically allocated, and it still helped.
> >
> > So the issue in this test scenario seems to be mostly about cgroup
> > volume. And then 8 4k charges should be equivalent to a singular 32k
> > charge when it comes to cgroup pressure.
>
> --
> Best Regards,
> Huang, Ying

Thanks
Barry

