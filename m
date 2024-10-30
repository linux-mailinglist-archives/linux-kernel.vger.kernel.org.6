Return-Path: <linux-kernel+bounces-389551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7209B6E50
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA571F22486
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161C71E1A23;
	Wed, 30 Oct 2024 21:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1nWw3bj4"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1761D2144CE
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730322111; cv=none; b=THozX2PxQNciIHdi68Hk+bRMLXmn+/1pbR1Ee4EqZlrTk/BP21uYSqicTxcxos4Gp+hLkbU7WcyTAuIQIBu9wLb5uDky/P2sL0iIfXCVkMALml920R2EIklTpYDA1rPpc/toy2v6n1u6EMVSDvTwCAjzkZO803Pd+0eWsQ7Cx2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730322111; c=relaxed/simple;
	bh=axLOkjhp2NA97AoqZBLACLZH4GWUZ65ZB1fxcIjMBDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TE/Sdhl8omRsRY7k9xcesKALYfgDpPF9tpn45nw5Yl0FvxWIuDrld0ncALsG5Ow0GZuo9Xx6ZOqGXAkTF6SHDxJM4umSHdH0oLJfRiEjH4o3dpRghyTp4ngP+gILM5BMr0Tlx2rmmdapmeVjDiXwRJCUaEsWgkIeVksj9PWwNCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1nWw3bj4; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6d18dff41cdso1874696d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730322108; x=1730926908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGxACa+63xvZPYViyYnCsJYtCoEinv2eYdTUf7ev3EA=;
        b=1nWw3bj4Y4mOpmLocfgGoB9S230XdNHICPjgmpwuJ+Se4q+o3aGmz+3uy49lZP0HI7
         8LX9/lM2nHOsRBVM60Bzbh9/6Ns0jLr/bcaGnb0IQkPlNgZrkURo3E1JB2GI6pBuXlJG
         QYsCdeIbO5ucq+P+9NSckEZHryOa/bjqEwsy7tLHXZcNUpGSSFjdP4DAO4PhF32l5qYc
         oRx3/3rHwPNFoc28G2QVOOEpFPg6vwinY42bGXrHTSJyGxmERzWRfLIrdUjCiL4PSLvK
         U1I6ZPqGayj70pP5CY043Ni0gI6HIIjQPcYzT/hfOFtZDIat4ujPiwHIP7T3mqk2IpuX
         eQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730322108; x=1730926908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGxACa+63xvZPYViyYnCsJYtCoEinv2eYdTUf7ev3EA=;
        b=dWv4y/OCZ+M25Cddyj2DaQ3LLpn/t3IZpdQ1gddQ/WxYlGIJh3ranWP+5tnw1z2J6v
         KpKILvReMBBd2xenYge2n+6QtRhGXeTXbU5Dnl4iUIcnD/tOtx3N6Vgznsbz/KCg4fNe
         6tpnkh+d24Rg6SK25J30OZlYJaVT99FFUGahzcissOxHLJPZLYyM0SpODoiA8SUrHwf/
         X44Ye+LFyTMqrguMZLq08Rzg7fH6sQL0BRAphWuK6fUNApnVySjV56+5A7e411JHF9vb
         h6B1LpXZGR1u6+FQJHphUcBN2ztoQNdOPjYI3NohuC3qETpBmLmYfTzANg3oJLoYcq21
         qqDg==
X-Forwarded-Encrypted: i=1; AJvYcCUOwWBun4XkRHnTi0VqjufjOz+Uq3zlufLGlNWyqiGqYSGFBZQFHDOuPAWYnFUEkrDpbzi6EHhY5gpEMLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhRksKMwT/H0hIVaiw+j16wCcppVWp9Qoiwl7Uh7QwJe0nNCYS
	hDQky1GH3GwiZqFMVOErMyJqSNkZTvKN3ndnSPsH8uMxriM9clVlRNK/ClbLNqwMR9usv3ybR6b
	0XU3B0oJuVbrtIImysItKEijA5N73u08I1esL
X-Google-Smtp-Source: AGHT+IHC7F99QDfKE3T8gIdLTca0twuukJg5DJ7WOAp4mqV+/Kb/DUCNeGxo8uvCDS8B44leoJurfVv0tsKAurSnVzQ=
X-Received: by 2002:a05:6214:598e:b0:6cc:598:67a8 with SMTP id
 6a1803df08f44-6d185838a0emr276556896d6.38.1730322107629; Wed, 30 Oct 2024
 14:01:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027001444.3233-1-21cnbao@gmail.com> <33c5d5ca-7bc4-49dc-b1c7-39f814962ae0@gmail.com>
 <CAGsJ_4wdgptMK0dDTC5g66OE9WDxFDt7ixDQaFCjuHdTyTEGiA@mail.gmail.com>
 <e8c6d46c-b8cf-4369-aa61-9e1b36b83fe3@gmail.com> <CAJD7tkZ60ROeHek92jgO0z7LsEfgPbfXN9naUC5j7QjRQxpoKw@mail.gmail.com>
 <852211c6-0b55-4bdd-8799-90e1f0c002c1@gmail.com>
In-Reply-To: <852211c6-0b55-4bdd-8799-90e1f0c002c1@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 30 Oct 2024 14:01:11 -0700
Message-ID: <CAJD7tkaXL_vMsgYET9yjYQW5pM2c60fD_7r_z4vkMPcqferS8A@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: mitigate large folios usage and swap thrashing
 for nearly full memcg
To: Usama Arif <usamaarif642@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, David Hildenbrand <david@redhat.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Kairui Song <kasong@tencent.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 1:25=E2=80=AFPM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 30/10/2024 19:51, Yosry Ahmed wrote:
> > [..]
> >>> My second point about the mitigation is as follows: For a system (or
> >>> memcg) under severe memory pressure, especially one without hardware =
TLB
> >>> optimization, is enabling mTHP always the right choice? Since mTHP op=
erates at
> >>> a larger granularity, some internal fragmentation is unavoidable, reg=
ardless
> >>> of optimization. Could the mitigation code help in automatically tuni=
ng
> >>> this fragmentation?
> >>>
> >>
> >> I agree with the point that enabling mTHP always is not the right thin=
g to do
> >> on all platforms. I also think it might be the case that enabling mTHP
> >> might be a good thing for some workloads, but enabling mTHP swapin alo=
ng with
> >> it might not.
> >>
> >> As you said when you have apps switching between foreground and backgr=
ound
> >> in android, it probably makes sense to have large folio swapping, as y=
ou
> >> want to bringin all the pages from background app as quickly as possib=
le.
> >> And also all the TLB optimizations and smaller lru overhead you get af=
ter
> >> you have brought in all the pages.
> >> Linux kernel build test doesnt really get to benefit from the TLB opti=
mization
> >> and smaller lru overhead, as probably the pages are very short lived. =
So I
> >> think it doesnt show the benefit of large folio swapin properly and
> >> large folio swapin should probably be disabled for this kind of worklo=
ad,
> >> eventhough mTHP should be enabled.
> >>
> >> I am not sure that the approach we are trying in this patch is the rig=
ht way:
> >> - This patch makes it a memcg issue, but you could have memcg disabled=
 and
> >> then the mitigation being tried here wont apply.
> >
> > Is the problem reproducible without memcg? I imagine only if the
> > entire system is under memory pressure. I guess we would want the same
> > "mitigation" either way.
> >
> What would be a good open source benchmark/workload to test without limit=
ing memory
> in memcg?
> For the kernel build test, I can only get zswap activity to happen if I b=
uild
> in cgroup and limit memory.max.

You mean a benchmark that puts the entire system under memory
pressure? I am not sure, it ultimately depends on the size of memory
you have, among other factors.

What if you run the kernel build test in a VM? Then you can limit is
size like a memcg, although you'd probably need to leave more room
because the entire guest OS will also subject to the same limit.

>
> I can just run zswap large folio zswapin in production and see, but that =
will take me a few
> days. tbh, running in prod is a much better test, and if there isn't any =
sort of thrashing,
> then maybe its not really an issue? I believe Barry doesnt see an issue i=
n android
> phones (but please correct me if I am wrong), and if there isnt an issue =
in Meta
> production as well, its a good data point for servers as well. And maybe
> kernel build in 4G memcg is not a good test.

If there is a regression in the kernel build, this means some
workloads may be affected, even if Meta's prod isn't. I understand
that the benchmark is not very representative of real world workloads,
but in this instance I think the thrashing problem surfaced by the
benchmark is real.

>
> >> - Instead of this being a large folio swapin issue, is it more of a re=
adahead
> >> issue? If we zswap (without the large folio swapin series) and change =
the window
> >> to 1 in swap_vma_readahead, we might see an improvement in linux kerne=
l build time
> >> when cgroup memory is limited as readahead would probably cause swap t=
hrashing as
> >> well.
> >
> > I think large folio swapin would make the problem worse anyway. I am
> > also not sure if the readahead window adjusts on memory pressure or
> > not.
> >
> readahead window doesnt look at memory pressure. So maybe the same thing =
is being
> seen here as there would be in swapin_readahead?

Maybe readahead is not as aggressive in general as large folio
swapins? Looking at swap_vma_ra_win(), it seems like the maximum order
of the window is the smaller of page_cluster (2 or 3) and
SWAP_RA_ORDER_CEILING (5).

Also readahead will swapin 4k folios AFAICT, so we don't need a
contiguous allocation like large folio swapin. So that could be
another factor why readahead may not reproduce the problem.

> Maybe if we check kernel build test
> performance in 4G memcg with below diff, it might get better?

I think you can use the page_cluster tunable to do this at runtime.

>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 4669f29cf555..9e196e1e6885 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -809,7 +809,7 @@ static struct folio *swap_vma_readahead(swp_entry_t t=
arg_entry, gfp_t gfp_mask,
>         pgoff_t ilx;
>         bool page_allocated;
>
> -       win =3D swap_vma_ra_win(vmf, &start, &end);
> +       win =3D 1;
>         if (win =3D=3D 1)
>                 goto skip;
>

