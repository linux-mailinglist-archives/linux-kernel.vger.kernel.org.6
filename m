Return-Path: <linux-kernel+bounces-392520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD719B9524
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911061C21EDB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D011AA781;
	Fri,  1 Nov 2024 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LimuEWCM"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2DE1DA53
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730478010; cv=none; b=PpDIRx/35/nS4w1kWiooAn3qiigtc2c1Zz/QIcWemfJm3zCD8ZlcXiuq2mJBNleo+LkB3lQLP8IQp4NWUoz8Z28RyUUxN4vXQMWjt3VNswDAUN/z+CazNMjnu/gmYIFoQ8FqK+2iWd9NuEI1GxXebeMTVvDp1Pksjf4N/C6a0t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730478010; c=relaxed/simple;
	bh=kzD2a27V77qIxC/6jhVhpMe7gYnDKJQE6NVJmDQHMdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KnFMvqSzQi/3EGMx3HjVhNAG62j0waXbXp5s3hze9DIlRV65aaLZ6+F0RjzaeKmmR1c6xdd+85fG8XY8u513baddlmqVwqDPWFpcY4xNag/KR8J2we7iIR4KMMlXzBHc62CB67alvxvGLeIN1T/kPPO5UCkm/LEWgn/19zWNbUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LimuEWCM; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cb82317809so13234976d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 09:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730478006; x=1731082806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkKqGXDlNbeSSlin5gkAN7W+FYm3Ggd7tjtMkJva0DI=;
        b=LimuEWCMEfmM16FAgEz93iMvV56fw+Ji+vV/gX06wa3flsJQe0GJjE73jrIAAYZBDk
         1QmIDF5pFGYaUUWpxM5GFSVe504x6nXno8Pbli04i/Rya5xtIlxNY5ctZYfCnxp2QR6Z
         LH4ja6YrnLkW4CeevlJTlnR8Z12M8BzFCVcfKX0F9rko7jxttlZT5ojnMhvvzZK/0N5u
         wzKawk9//aw3uE18qvNQNF12WaZJylybgrL15bDTZIezqpvSaUz4QS+ZXEgPzwXxE9fY
         1/HZUvVZNaUaTQUhWAVuywlmaP5l8SF7Jz1FFE7ABlwLvvi1L+R7DRGFoiDMsiEWZWNJ
         7+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730478006; x=1731082806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkKqGXDlNbeSSlin5gkAN7W+FYm3Ggd7tjtMkJva0DI=;
        b=OqFW/OQMdw8Tmzu+5ACAGtrYongfbLIlQs38rAm6qS+CaT5Ez069N2gpZnJlt/mRLe
         5TEtb2f650X7XTcp0C3Sc/NZFJiCNhsmK0ZBMe+5opscThi5dL5aGK+cZv6jE7ubIkOj
         4N11IuGso6gj1WUzzH0MRpvyU9aTql04UoXw0Rhu7KlYOGiKUnGH45pUUtxqSf8eXIRT
         7rlpHz85To7NztsWRiYaL43D+dWXGi+XvnEgutZ9n1Am78J5utnDkm+G+G+yzNND2AWW
         Qw/vTIJidu/V8iO07cCnT39iodHlJ4qSh6fGvGJWeeiY259bXUUf94vmx3wc0GH1JdxL
         xodQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhchdALs6Ut9M8NTxd9V75bAU8U5u7AWD8LqYh/08LohUrQbs5xH7NnCThIi++wcXHheWXY6thPNwVqCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTHTC4KOk06SfDmdVWdarochfjLqr14E0Y5XNpX3A2BHhlfw0R
	C/pvaOY+gmY1FRtb6zIBV7sAWnbdb2UGZUX31pPjw+BUfTG2K4IAFRS8UnwrEoh2H6gD39rkje5
	nGYbXIj8WNX/+T2Qm8LsRZDaPaQT7DrVg1RJ+
X-Google-Smtp-Source: AGHT+IG10wiBsZhBV7O3UiGw66TRilPB4518JYdv2HdxSr/9COnl7l72Ih4bmf9Ba8TlKillRQS5OMI0KE3flvweyn0=
X-Received: by 2002:a05:6214:2f0f:b0:6cc:51f:6c31 with SMTP id
 6a1803df08f44-6d35c09c2d3mr62590276d6.5.1730478006210; Fri, 01 Nov 2024
 09:20:06 -0700 (PDT)
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
 <20241031153830.GA799903@cmpxchg.org> <CAJD7tkZ_xQHMoze_w3yBHgjPhQeDynJ+vWddbYKFzi2c63sT7w@mail.gmail.com>
 <CAGsJ_4yTuQMH2MMUnXRiSMbstOuoC2-fvNBsmb2noK9Axte5Gg@mail.gmail.com>
In-Reply-To: <CAGsJ_4yTuQMH2MMUnXRiSMbstOuoC2-fvNBsmb2noK9Axte5Gg@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 1 Nov 2024 09:19:29 -0700
Message-ID: <CAJD7tkaYAB2LPEUP_3CxxE7CNnzbabc0YUU-BnupJrBt2iM10g@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: mitigate large folios usage and swap thrashing
 for nearly full memcg
To: Barry Song <21cnbao@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Usama Arif <usamaarif642@gmail.com>, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, 
	David Hildenbrand <david@redhat.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 2:00=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Fri, Nov 1, 2024 at 5:00=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
> >
> > On Thu, Oct 31, 2024 at 8:38=E2=80=AFAM Johannes Weiner <hannes@cmpxchg=
.org> wrote:
> > >
> > > On Wed, Oct 30, 2024 at 02:18:09PM -0700, Yosry Ahmed wrote:
> > > > On Wed, Oct 30, 2024 at 2:13=E2=80=AFPM Usama Arif <usamaarif642@gm=
ail.com> wrote:
> > > > > On 30/10/2024 21:01, Yosry Ahmed wrote:
> > > > > > On Wed, Oct 30, 2024 at 1:25=E2=80=AFPM Usama Arif <usamaarif64=
2@gmail.com> wrote:
> > > > > >>>> I am not sure that the approach we are trying in this patch =
is the right way:
> > > > > >>>> - This patch makes it a memcg issue, but you could have memc=
g disabled and
> > > > > >>>> then the mitigation being tried here wont apply.
> > > > > >>>
> > > > > >>> Is the problem reproducible without memcg? I imagine only if =
the
> > > > > >>> entire system is under memory pressure. I guess we would want=
 the same
> > > > > >>> "mitigation" either way.
> > > > > >>>
> > > > > >> What would be a good open source benchmark/workload to test wi=
thout limiting memory
> > > > > >> in memcg?
> > > > > >> For the kernel build test, I can only get zswap activity to ha=
ppen if I build
> > > > > >> in cgroup and limit memory.max.
> > > > > >
> > > > > > You mean a benchmark that puts the entire system under memory
> > > > > > pressure? I am not sure, it ultimately depends on the size of m=
emory
> > > > > > you have, among other factors.
> > > > > >
> > > > > > What if you run the kernel build test in a VM? Then you can lim=
it is
> > > > > > size like a memcg, although you'd probably need to leave more r=
oom
> > > > > > because the entire guest OS will also subject to the same limit=
.
> > > > > >
> > > > >
> > > > > I had tried this, but the variance in time/zswap numbers was very=
 high.
> > > > > Much higher than the AMD numbers I posted in reply to Barry. So f=
ound
> > > > > it very difficult to make comparison.
> > > >
> > > > Hmm yeah maybe more factors come into play with global memory
> > > > pressure. I am honestly not sure how to test this scenario, and I
> > > > suspect variance will be high anyway.
> > > >
> > > > We can just try to use whatever technique we use for the memcg limi=
t
> > > > though, if possible, right?
> > >
> > > You can boot a physical machine with mem=3D1G on the commandline, whi=
ch
> > > restricts the physical range of memory that will be initialized.
> > > Double check /proc/meminfo after boot, because part of that physical
> > > range might not be usable RAM.
> > >
> > > I do this quite often to test physical memory pressure with workloads
> > > that don't scale up easily, like kernel builds.
> > >
> > > > > >>>> - Instead of this being a large folio swapin issue, is it mo=
re of a readahead
> > > > > >>>> issue? If we zswap (without the large folio swapin series) a=
nd change the window
> > > > > >>>> to 1 in swap_vma_readahead, we might see an improvement in l=
inux kernel build time
> > > > > >>>> when cgroup memory is limited as readahead would probably ca=
use swap thrashing as
> > > > > >>>> well.
> > >
> > > +1
> > >
> > > I also think there is too much focus on cgroup alone. The bigger issu=
e
> > > seems to be how much optimistic volume we swap in when we're under
> > > pressure already. This applies to large folios and readahead; global
> > > memory availability and cgroup limits.
> >
> > Agreed, although the characteristics of large folios and readahead are
> > different. But yeah, different flavors of the same problem.
> >
> > >
> > > It happens to manifest with THP in cgroups because that's what you
> > > guys are testing. But IMO, any solution to this problem should
> > > consider the wider scope.
> >
> > +1, and I really think this should be addressed separately, not just
> > rely on large block compression/decompression to offset the cost. It's
> > probably not just a zswap/zram problem anyway, it just happens to be
> > what we support large folio swapin for.
>
> Agreed these are two separate issues and should be both investigated
> though 2 can offset the cost of 1.
> 1. swap thrashing
> 2. large block compression/decompression
>
> For point 1, we likely want to investigate the following:
>
> 1. if we can see the same thrashing if we always perform readahead
> (rapidly filling
> the memcg to full again after reclamation).
>
> 2. Whether there are any issues with balancing file and anon memory
> reclamation.
>
> The 'refault feedback loop' in mglru compares refault rates between anon =
and
> file pages to decide which type should be prioritized for reclamation.
>
> type =3D get_type_to_scan(lruvec, swappiness, &tier);
>
> static int get_type_to_scan(struct lruvec *lruvec, int swappiness, int
> *tier_idx)
> {
>         ...
>         read_ctrl_pos(lruvec, LRU_GEN_ANON, 0, gain[LRU_GEN_ANON], &sp);
>         read_ctrl_pos(lruvec, LRU_GEN_FILE, 0, gain[LRU_GEN_FILE], &pv);
>         type =3D positive_ctrl_err(&sp, &pv);
>
>         read_ctrl_pos(lruvec, !type, 0, gain[!type], &sp);
>         for (tier =3D 1; tier < MAX_NR_TIERS; tier++) {
>                 read_ctrl_pos(lruvec, type, tier, gain[type], &pv);
>                 if (!positive_ctrl_err(&sp, &pv))
>                         break;
>         }
>
>         *tier_idx =3D tier - 1;
>         return type;
> }
>
> In this case, we may want to investigate whether reclamation is primarily
> targeting anonymous memory due to potential errors in the statistics path
> after mTHP is involved.
>
> 3. Determine if this is a memcg-specific issue by setting mem=3D1GB and
> running the same test on the global system.
>
> Yosry, Johannes, Usama,
> Is there anything else that might interest us?
>
> I'll get back to you after completing the investigation mentioned above.

Thanks for looking into this.

Perhaps a naive question, but is this only related to swap faults? Can
the same scenario happen with other types of faults allocating large
folios (e.g. faulting in a file page, or a new anon allocation)?

Do swap faults use a different policy for determining the folio order,
or is it just the swap faults are naturally more correlated to memory
pressure, so that's how the issue was surfaced?

