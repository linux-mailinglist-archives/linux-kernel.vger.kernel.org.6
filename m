Return-Path: <linux-kernel+bounces-390875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 683399B7F81
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E176A1F2552F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DD21A38C2;
	Thu, 31 Oct 2024 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OTIATky3"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173DF137905
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730390426; cv=none; b=W/+VHiVgTnklQFLlNjrr78bdUJIp6ZMHu8YLTTj5luA7SSlG8ri9Y960+oxhFtbs0G+rGTgjNJKKc8Yej0+wqWjZa+QvQTb2CnJu1EiGkDScMPL+atgn6xFfveuacB1vPHEfmhQyy42m/bte1IMs8bJtEoGY5+uzBC2ULzunV58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730390426; c=relaxed/simple;
	bh=N037QPcNODAt+T6LQFiIHYByKbWxv8lhGI5bnvDi5rU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYG58jMRB7iyG/jtjz0zBRlCZPobu/U6xcU6MOrOuH+xNgpHQQHH+Gyo84kJOCibRG128vfxxWdcUYHwFDlXACaJMc2fBKGjixBQkwzQADxfpPtzTduc+oEzCiQaC28gNmlOUtl4zHq/ebbelhA1VOJU8+6PuIOWsILqygqyYqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OTIATky3; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6cc03b649f2so7429436d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730390423; x=1730995223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N037QPcNODAt+T6LQFiIHYByKbWxv8lhGI5bnvDi5rU=;
        b=OTIATky3HzU2vMSlE20ODaV8aQyBXXMk+YSIBByBZ69sVGZI3qRBJ5TuS4DhEdZOS7
         p/UKDlUvq/K2as2UvQJ8DXCAk1DsSlmBUQuIgrtyvwOrLxSCinnpM8+W7j/Jv4VPygzz
         NdtOZzvwSrfQg4P3HjGa0ntDZ4lk7JHYEOA9IbX7BXEWvmkI7NIQ2IkOpKLmtjE3uKvz
         wD+np0OZc+vMX6MG7wXUIoFOem4KIesCg42kL3WnTNJFilsF6YXsl2Vvs1D0xfixzJzc
         oLXeEQdWC8eR+QQ9Dr5DTmyX6PHKU6ielD1g6a8MfTOI8WQpb2ztiDmXhNgKttpmedcL
         uutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730390423; x=1730995223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N037QPcNODAt+T6LQFiIHYByKbWxv8lhGI5bnvDi5rU=;
        b=Fu7/3VnDW82lMH2VSmm65+fufFFrc1A/rkCoQcHJbat0jOKjqneoEQhoS1l/5O3+5v
         DNqYdg2XFPUnQWv5dxoV7rse/4H0oe0fNLw8sFn4G1KVRZ9pKIj3h1EpsdnIRrzMJjRy
         nJuVNd+W5L7knBK/79RJqqRpy3OUMmMtFpAhUujCGv1iqXqVqeNVxd9Dplm7ak8xduhh
         9tcRxKFy08oJoioXzpvkgXnI5D3vpybj+8pdzfqxZVHKI9plJJV/bA0GNDfw6gqTJk/b
         RwLQvWNTYYdsROS1fdEEMkYLWUY7TV+tIu9L9i6ypmChILr1BHE8SDRPmcfmxid9j1yY
         L3KQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSUoFELxvzIIzBZBZd40y17o0kOhptkRANn9bGDnQM/Z5LCAFdnzd7oOJX8C//amjswwLuVioWV1V2DUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwStuyiQPynaOZm5NTgcl61nd1T31cxDYdBp5/HL5l9z3Do+xtP
	03LfEKnEtLSebbojkbY4k2kJ5ahdxlLlz9MTdvZERZVGW88cloyKbwL5xQugOJBQwDFrzZ7jhNI
	/Hs3v0No7Kr4FGyMXck0ZKGeRHKKqEY0/ed6q
X-Google-Smtp-Source: AGHT+IFOamOItuF+r4b4reM3jE9mjWoU9TWypbyuHHQFG7gxgXonzt2LCi2MPyQTtx6nlN+Wun2ISIW3fyLX+bI78hc=
X-Received: by 2002:a05:6214:3f88:b0:6c7:5e6d:3f79 with SMTP id
 6a1803df08f44-6d351b2fb6dmr49677566d6.48.1730390422509; Thu, 31 Oct 2024
 09:00:22 -0700 (PDT)
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
 <20241031153830.GA799903@cmpxchg.org>
In-Reply-To: <20241031153830.GA799903@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 31 Oct 2024 08:59:46 -0700
Message-ID: <CAJD7tkZ_xQHMoze_w3yBHgjPhQeDynJ+vWddbYKFzi2c63sT7w@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: mitigate large folios usage and swap thrashing
 for nearly full memcg
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Usama Arif <usamaarif642@gmail.com>, Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, 
	David Hildenbrand <david@redhat.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 8:38=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Wed, Oct 30, 2024 at 02:18:09PM -0700, Yosry Ahmed wrote:
> > On Wed, Oct 30, 2024 at 2:13=E2=80=AFPM Usama Arif <usamaarif642@gmail.=
com> wrote:
> > > On 30/10/2024 21:01, Yosry Ahmed wrote:
> > > > On Wed, Oct 30, 2024 at 1:25=E2=80=AFPM Usama Arif <usamaarif642@gm=
ail.com> wrote:
> > > >>>> I am not sure that the approach we are trying in this patch is t=
he right way:
> > > >>>> - This patch makes it a memcg issue, but you could have memcg di=
sabled and
> > > >>>> then the mitigation being tried here wont apply.
> > > >>>
> > > >>> Is the problem reproducible without memcg? I imagine only if the
> > > >>> entire system is under memory pressure. I guess we would want the=
 same
> > > >>> "mitigation" either way.
> > > >>>
> > > >> What would be a good open source benchmark/workload to test withou=
t limiting memory
> > > >> in memcg?
> > > >> For the kernel build test, I can only get zswap activity to happen=
 if I build
> > > >> in cgroup and limit memory.max.
> > > >
> > > > You mean a benchmark that puts the entire system under memory
> > > > pressure? I am not sure, it ultimately depends on the size of memor=
y
> > > > you have, among other factors.
> > > >
> > > > What if you run the kernel build test in a VM? Then you can limit i=
s
> > > > size like a memcg, although you'd probably need to leave more room
> > > > because the entire guest OS will also subject to the same limit.
> > > >
> > >
> > > I had tried this, but the variance in time/zswap numbers was very hig=
h.
> > > Much higher than the AMD numbers I posted in reply to Barry. So found
> > > it very difficult to make comparison.
> >
> > Hmm yeah maybe more factors come into play with global memory
> > pressure. I am honestly not sure how to test this scenario, and I
> > suspect variance will be high anyway.
> >
> > We can just try to use whatever technique we use for the memcg limit
> > though, if possible, right?
>
> You can boot a physical machine with mem=3D1G on the commandline, which
> restricts the physical range of memory that will be initialized.
> Double check /proc/meminfo after boot, because part of that physical
> range might not be usable RAM.
>
> I do this quite often to test physical memory pressure with workloads
> that don't scale up easily, like kernel builds.
>
> > > >>>> - Instead of this being a large folio swapin issue, is it more o=
f a readahead
> > > >>>> issue? If we zswap (without the large folio swapin series) and c=
hange the window
> > > >>>> to 1 in swap_vma_readahead, we might see an improvement in linux=
 kernel build time
> > > >>>> when cgroup memory is limited as readahead would probably cause =
swap thrashing as
> > > >>>> well.
>
> +1
>
> I also think there is too much focus on cgroup alone. The bigger issue
> seems to be how much optimistic volume we swap in when we're under
> pressure already. This applies to large folios and readahead; global
> memory availability and cgroup limits.

Agreed, although the characteristics of large folios and readahead are
different. But yeah, different flavors of the same problem.

>
> It happens to manifest with THP in cgroups because that's what you
> guys are testing. But IMO, any solution to this problem should
> consider the wider scope.

+1, and I really think this should be addressed separately, not just
rely on large block compression/decompression to offset the cost. It's
probably not just a zswap/zram problem anyway, it just happens to be
what we support large folio swapin for.

>
> > > >>> I think large folio swapin would make the problem worse anyway. I=
 am
> > > >>> also not sure if the readahead window adjusts on memory pressure =
or
> > > >>> not.
> > > >>>
> > > >> readahead window doesnt look at memory pressure. So maybe the same=
 thing is being
> > > >> seen here as there would be in swapin_readahead?
> > > >
> > > > Maybe readahead is not as aggressive in general as large folio
> > > > swapins? Looking at swap_vma_ra_win(), it seems like the maximum or=
der
> > > > of the window is the smaller of page_cluster (2 or 3) and
> > > > SWAP_RA_ORDER_CEILING (5).
> > > Yes, I was seeing 8 pages swapin (order 3) when testing. So might
> > > be similar to enabling 32K mTHP?
> >
> > Not quite.
>
> Actually, I would expect it to be...
>
> > > > Also readahead will swapin 4k folios AFAICT, so we don't need a
> > > > contiguous allocation like large folio swapin. So that could be
> > > > another factor why readahead may not reproduce the problem.
> >
> > Because of this ^.
>
> ...this matters for the physical allocation, which might require more
> reclaim and compaction to produce the 32k. But an earlier version of
> Barry's patch did the cgroup margin fallback after the THP was already
> physically allocated, and it still helped.
>
> So the issue in this test scenario seems to be mostly about cgroup
> volume. And then 8 4k charges should be equivalent to a singular 32k
> charge when it comes to cgroup pressure.

In this test scenario, yes, because it's only exercising cgroup
pressure. But if we want a general solution that also addresses global
pressure, I expect large folios to be worse because of the contiguity
and the size (compared to default readahead window sizes). So I think
we shouldn't only test with readahead, as it won't cover some of the
large folio cases.

