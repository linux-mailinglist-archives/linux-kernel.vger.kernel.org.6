Return-Path: <linux-kernel+bounces-395750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AEE9BC260
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 02:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C3F7B21EC3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 01:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95AC1862A;
	Tue,  5 Nov 2024 01:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBKGXLYa"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BE0DDDC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 01:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730769230; cv=none; b=GGc4gDCQ2oqYDfEp5OYhHbdRsmy0YwklsalDsy+Jhj+aCnGXJRb+GqM4IlhvafynuNhv1WjtWJg4nPccR6ndjAnYkBSs4x22L5FTPkFRDDhcKgoRSvo93btrnKmGmzD0pqliNUqxLXQ+Yl1MF69OdwDU57duMwubsXvzlN6LQcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730769230; c=relaxed/simple;
	bh=SpAswgFJ5LiL6ME80bW907UvVATW5Ismr/h3OlTPWDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PgqNrCUaMtbacxeYlAPXDogw1xg9imrrTcf+BWOZG8GnDH476jzkcFgt1MeJfrfWnFakpUYHfSd793v+kGj2KRYUHiXaGGhKIPjrqI/C1AgJ2hi0iwQRQUZYjVV6lVddDY2AZkwbUn8SZv8DNCot6lpCYM++Hoc3eiqRZ8j1nzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBKGXLYa; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-50d4797098dso1804750e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 17:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730769227; x=1731374027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ek6t4hazbXE+8xpf80XM+MGpyF7OQ4zR6rOhy8KI6Is=;
        b=OBKGXLYafenT81nc/SIbVP8ooP1wMP9zhw4mSahetvtMGJAgRGTbefvQgV6L98IWne
         Chtg2RYOGn+WIFiddBPekBPRRE2HmAANEDiCGM3kE4m1UU45A/R0s1fiMSUuWmpdIj52
         pg98/LXHx9Eb/GD31p/tAC3uV32ng97IJMm8OuCyrsdJ38YUm+Vb/EBOVczCX5VL/bq2
         1BuF66WUYtPoWw6C3jix8mGgLqaSe5xutUWQLeCAZk5TiFRiPEzR6vp6NFg+fuMYjquk
         SxEyYxtbFjAxXMU9XqDmzzuXmpW0Itk6weMDPtsizTzwpn3xS5uFtqDyjFxkEQCnAbRs
         yiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730769227; x=1731374027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ek6t4hazbXE+8xpf80XM+MGpyF7OQ4zR6rOhy8KI6Is=;
        b=NvCoW95q8cX17CXOVZ9zUEbvwK2mFZEf6QzcoUt25kFxcr569K5gMMGpc4LijlMgDm
         Jg9QShY9t9+MMEaqbNNybuq5EjfUNYNuMdzBKMOhfSKaZz2KjnmzEbOBNrDtujee7Jil
         mdS+cKwO8hEZUW4ncorq13KSCRjG7WPEJ+TY0OlLCvWzoXtZeoSa6DkGLqdyS9DIp4aC
         noSgjOceFKmG80r7mWVB/H4lf4Nr3ltw+Za8jJUlOzEVSUUJyOFX6XGAFIvnfLi1nS4j
         GldKFXSVuVFV+ZCjQiDh7SpYH8Cpbr0bE2tzzBeSlFNzMFe3rb/1S9DSGWOC9zr+DyAM
         OvhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhqGTlZkV8xaAHvc5ozzKaKlDQWwGlWQf/JrJR9WbgBWYKrLDrBtWug37PQt+wvux0uhKZYsVbkjv+iP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6MClnlExU+Qe8RC9WLTk/bT9qRJ+E3wRKxony3VE2ebzSJkgA
	qkFj3y2L0xaO+eMxzEL1FYX8niXEm104xYTw4OE/vU4SM3EPhaUwbVS57J4YuPSCeKL/OG+/dQ6
	p4Hv/NK55EhTdDI2K1tPL8YJ2bVE=
X-Google-Smtp-Source: AGHT+IF89eolPsfts3qy2/EjarAboO3hZ4pNJUESm4UV8/gfglnPZ0qDVPx2WZEJSIzeu7IrzAhCHA+w7WAZbkf3z9I=
X-Received: by 2002:a05:6122:3196:b0:50c:4efb:835a with SMTP id
 71dfb90a1353d-51014ff7a57mr29750349e0c.1.1730769227058; Mon, 04 Nov 2024
 17:13:47 -0800 (PST)
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
 <3f684183-c6df-4f2f-9e33-91ce43c791eb@gmail.com> <87ses67b0b.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87ses67b0b.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 5 Nov 2024 14:13:35 +1300
Message-ID: <CAGsJ_4z-zFESVpK2hDSs3EwHa2Ra3fYJFeQwH74LMHw3wVmB0g@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: mitigate large folios usage and swap thrashing
 for nearly full memcg
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Usama Arif <usamaarif642@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, David Hildenbrand <david@redhat.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 2:01=E2=80=AFPM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> Usama Arif <usamaarif642@gmail.com> writes:
>
> > On 04/11/2024 06:42, Huang, Ying wrote:
> >> Johannes Weiner <hannes@cmpxchg.org> writes:
> >>
> >>> On Wed, Oct 30, 2024 at 02:18:09PM -0700, Yosry Ahmed wrote:
> >>>> On Wed, Oct 30, 2024 at 2:13=E2=80=AFPM Usama Arif <usamaarif642@gma=
il.com> wrote:
> >>>>> On 30/10/2024 21:01, Yosry Ahmed wrote:
> >>>>>> On Wed, Oct 30, 2024 at 1:25=E2=80=AFPM Usama Arif <usamaarif642@g=
mail.com> wrote:
> >>>>>>>>> I am not sure that the approach we are trying in this patch is =
the right way:
> >>>>>>>>> - This patch makes it a memcg issue, but you could have memcg d=
isabled and
> >>>>>>>>> then the mitigation being tried here wont apply.
> >>>>>>>>
> >>>>>>>> Is the problem reproducible without memcg? I imagine only if the
> >>>>>>>> entire system is under memory pressure. I guess we would want th=
e same
> >>>>>>>> "mitigation" either way.
> >>>>>>>>
> >>>>>>> What would be a good open source benchmark/workload to test witho=
ut limiting memory
> >>>>>>> in memcg?
> >>>>>>> For the kernel build test, I can only get zswap activity to happe=
n if I build
> >>>>>>> in cgroup and limit memory.max.
> >>>>>>
> >>>>>> You mean a benchmark that puts the entire system under memory
> >>>>>> pressure? I am not sure, it ultimately depends on the size of memo=
ry
> >>>>>> you have, among other factors.
> >>>>>>
> >>>>>> What if you run the kernel build test in a VM? Then you can limit =
is
> >>>>>> size like a memcg, although you'd probably need to leave more room
> >>>>>> because the entire guest OS will also subject to the same limit.
> >>>>>>
> >>>>>
> >>>>> I had tried this, but the variance in time/zswap numbers was very h=
igh.
> >>>>> Much higher than the AMD numbers I posted in reply to Barry. So fou=
nd
> >>>>> it very difficult to make comparison.
> >>>>
> >>>> Hmm yeah maybe more factors come into play with global memory
> >>>> pressure. I am honestly not sure how to test this scenario, and I
> >>>> suspect variance will be high anyway.
> >>>>
> >>>> We can just try to use whatever technique we use for the memcg limit
> >>>> though, if possible, right?
> >>>
> >>> You can boot a physical machine with mem=3D1G on the commandline, whi=
ch
> >>> restricts the physical range of memory that will be initialized.
> >>> Double check /proc/meminfo after boot, because part of that physical
> >>> range might not be usable RAM.
> >>>
> >>> I do this quite often to test physical memory pressure with workloads
> >>> that don't scale up easily, like kernel builds.
> >>>
> >>>>>>>>> - Instead of this being a large folio swapin issue, is it more =
of a readahead
> >>>>>>>>> issue? If we zswap (without the large folio swapin series) and =
change the window
> >>>>>>>>> to 1 in swap_vma_readahead, we might see an improvement in linu=
x kernel build time
> >>>>>>>>> when cgroup memory is limited as readahead would probably cause=
 swap thrashing as
> >>>>>>>>> well.
> >>>
> >>> +1
> >>>
> >>> I also think there is too much focus on cgroup alone. The bigger issu=
e
> >>> seems to be how much optimistic volume we swap in when we're under
> >>> pressure already. This applies to large folios and readahead; global
> >>> memory availability and cgroup limits.
> >>
> >> The current swap readahead logic is something like,
> >>
> >> 1. try readahead some pages for sequential access pattern, mark them a=
s
> >>    readahead
> >>
> >> 2. if these readahead pages get accessed before swapped out again,
> >>    increase 'hits' counter
> >>
> >> 3. for next swap in, try readahead 'hits' pages and clear 'hits'.
> >>
> >> So, if there's heavy memory pressure, the readaheaded pages will not b=
e
> >> accessed before being swapped out again (in 2 above), the readahead
> >> pages will be minimal.
> >>
> >> IMHO, mTHP swap-in is kind of swap readahead in effect.  That is, in
> >> addition to the pages accessed are swapped in, the adjacent pages are
> >> swapped in (swap readahead) too.  If these readahead pages are not
> >> accessed before swapped out again, system runs into more severe
> >> thrashing.  This is because we lack the swap readahead window scaling
> >> mechanism as above.  And, this is why I suggested to combine the swap
> >> readahead mechanism and mTHP swap-in by default before.  That is, when
> >> kernel swaps in a page, it checks current swap readahead window, and
> >> decides mTHP order according to window size.  So, if there are heavy
> >> memory pressure, so that the nearby pages will not be accessed before
> >> being swapped out again, the mTHP swap-in order can be adjusted
> >> automatically.
> >
> > This is a good idea to do, but I think the issue is that readahead
> > is a folio flag and not a page flag, so only works when folio size is 1=
.
> >
> > In the swapin_readahead swapcache path, the current implementation deci=
des
> > the ra_window based on hits, which is incremented in swap_cache_get_fol=
io
> > if it has not been gotten from swapcache before.
> > The problem would be that we need information on how many distinct page=
s in
> > a large folio that has been swapped in have been accessed to decide the
> > hits/window size, which I don't think is possible. As once the entire l=
arge
> > folio has been swapped in, we won't get a fault.
> >
>
> To do that, we need to move readahead flag to per-page from per-folio.
> And we need to map only the accessed page of the folio in page fault
> handler.  This may impact performance.  So, we may only do that for
> sampled folios only, for example, every 100 folios.

I'm not entirely sure there's a chance to gain traction on this, as the cur=
rent
trend clearly leans toward moving flags from page to folio, not from folio =
to
page :-)

>
> >>
> >>> It happens to manifest with THP in cgroups because that's what you
> >>> guys are testing. But IMO, any solution to this problem should
> >>> consider the wider scope.
> >>>
> >>>>>>>> I think large folio swapin would make the problem worse anyway. =
I am
> >>>>>>>> also not sure if the readahead window adjusts on memory pressure=
 or
> >>>>>>>> not.
> >>>>>>>>
> >>>>>>> readahead window doesnt look at memory pressure. So maybe the sam=
e thing is being
> >>>>>>> seen here as there would be in swapin_readahead?
> >>>>>>
> >>>>>> Maybe readahead is not as aggressive in general as large folio
> >>>>>> swapins? Looking at swap_vma_ra_win(), it seems like the maximum o=
rder
> >>>>>> of the window is the smaller of page_cluster (2 or 3) and
> >>>>>> SWAP_RA_ORDER_CEILING (5).
> >>>>> Yes, I was seeing 8 pages swapin (order 3) when testing. So might
> >>>>> be similar to enabling 32K mTHP?
> >>>>
> >>>> Not quite.
> >>>
> >>> Actually, I would expect it to be...
> >>
> >> Me too.
> >>
> >>>>>> Also readahead will swapin 4k folios AFAICT, so we don't need a
> >>>>>> contiguous allocation like large folio swapin. So that could be
> >>>>>> another factor why readahead may not reproduce the problem.
> >>>>
> >>>> Because of this ^.
> >>>
> >>> ...this matters for the physical allocation, which might require more
> >>> reclaim and compaction to produce the 32k. But an earlier version of
> >>> Barry's patch did the cgroup margin fallback after the THP was alread=
y
> >>> physically allocated, and it still helped.
> >>>
> >>> So the issue in this test scenario seems to be mostly about cgroup
> >>> volume. And then 8 4k charges should be equivalent to a singular 32k
> >>> charge when it comes to cgroup pressure.
>
> --
> Best Regards,
> Huang, Ying

