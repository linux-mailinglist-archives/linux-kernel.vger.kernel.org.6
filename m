Return-Path: <linux-kernel+bounces-391292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A029B84CF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89661C22057
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1339B1CC8B3;
	Thu, 31 Oct 2024 21:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpXbOC6P"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BCC45BE3
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 21:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730408413; cv=none; b=baBkWXo+B3O8lrypCjk3JHfQ33QTxK+KJsJo9DDXznbMS9djtrM3ALEQO+UJtQEROQWmm8qloSwGoCKt+Xjp/pO6//A0DGu7lsDZ+skuVw5LZsFlPvrtrpEC0CRTFhhq2t9itudzfXNxNAYN3sRAQpus34uzDsmeBsCCRniJbLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730408413; c=relaxed/simple;
	bh=R0mM4eVJAHQ6yAQOVfa42KZ0TT+rHuIWWRPrkqlRgIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gIlQJy168OuN+DPykpQbCAG0L2Je1+e986/ugJQT2vfZHM6QOFipq7iFkYHCEMQn51d/kyUgovLgEKY5b/YYftbAQkKwmyKqQG/+2E6ZPN4xmKUmegdBic4GSC8SkpASiFZFEOAu3+Ai55J/lWcHtrnmh7j0oFp+Oz6Ql4BO/uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpXbOC6P; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-50d3998923dso526646e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 14:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730408406; x=1731013206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9km22R6VbIz/XP5lzm/qJwR2jWzEfYA7dERxsxLJjyg=;
        b=YpXbOC6PS5WLcZ5ImcbhIh/g39koh7U5J7aj+S2o022icWlq7dvY10IRRXDQwT+vgf
         1XXI3lCQnObnV9cPSUx+qkXiN8t79JHdk5ZIgs1iu4eP1B9Y4+LkiXE9TjfjIa/hOX2x
         DKw2XtcAbZyn7UC0jQMqzfZYG2fbPW3cepmKi+YpCNwIhgms9u3BK2GqDJUy3CVR2Zmz
         tZJESyQT7d3wB656r/tMqfBqCqFhyagWfaVS+p+Q3VVpuq0wUYebBNlPYsTm8Ym+Dcju
         UzRznueO3yUtOdB5rvYH11B7Mta6bbCxy4FPJOHV5m69KOWYo5vTiV2zHwp+SHuC6x0o
         tEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730408406; x=1731013206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9km22R6VbIz/XP5lzm/qJwR2jWzEfYA7dERxsxLJjyg=;
        b=PtU//s4Se5GKAOaa0142KTHpMqJRnrhvBhojyei7eWL8GDkc00G8SxSmK3pqU9q0jk
         f5X7uGZ+QIWgo69gm90Z6++tN7jDatFmbEH0a/Xh7HBH4jzXQUqP6Pvc4oseVBsPjPrV
         HL7YnQycciTO9bdIjFMMINpWyBYqo7lFDXiLMTIqbCZi/XtqBuICgoLHVN5Z2TLUlZRf
         noAmEfAWaZJAenFo0kbineVHgvKEKwzqXM1ClWa5GHuj39GbdYNQAONj9JvURja9f/fw
         PPGVhLg6rU9JYHgyxjI7fvFSl0eLUSbh2+r/1Ij0yTT4/MCt2AOHW6A9xntX798E5hII
         rKFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAhSCTe0GG2+8DOSbIzdoIAvIbiO3HBt0GIkvvppgYAmYhLTE3YDT9oqLkYeW9VoF83n/s9r6Bs1ijMPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKkZ+ebGx/aUR640ou/VdNayCyxoLX97BE2PK4ynoDsaVU9Ryz
	+yrdW4BRPQLV738B0arsELBBqLILEJeJ9qF6XAqI5JGsxGoSsqBv2KTth4qTKIG/WoofBNDiz5l
	lmZeTXJ52WYXQ5jbIOP/u+6SRoCA=
X-Google-Smtp-Source: AGHT+IFKiKEE53VEDcXDHyv6tp/prlHPl31FvqnxoqblM6+nwxnRktgJEn05e9ZchnKt5bIk1zysg5Y2yP9J/JQcXlY=
X-Received: by 2002:a05:6122:2a01:b0:50c:99da:4f70 with SMTP id
 71dfb90a1353d-512270c6c20mr1511401e0c.2.1730408405717; Thu, 31 Oct 2024
 14:00:05 -0700 (PDT)
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
In-Reply-To: <CAJD7tkZ_xQHMoze_w3yBHgjPhQeDynJ+vWddbYKFzi2c63sT7w@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 1 Nov 2024 09:59:54 +1300
Message-ID: <CAGsJ_4yTuQMH2MMUnXRiSMbstOuoC2-fvNBsmb2noK9Axte5Gg@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: mitigate large folios usage and swap thrashing
 for nearly full memcg
To: Yosry Ahmed <yosryahmed@google.com>
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

On Fri, Nov 1, 2024 at 5:00=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Thu, Oct 31, 2024 at 8:38=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> >
> > On Wed, Oct 30, 2024 at 02:18:09PM -0700, Yosry Ahmed wrote:
> > > On Wed, Oct 30, 2024 at 2:13=E2=80=AFPM Usama Arif <usamaarif642@gmai=
l.com> wrote:
> > > > On 30/10/2024 21:01, Yosry Ahmed wrote:
> > > > > On Wed, Oct 30, 2024 at 1:25=E2=80=AFPM Usama Arif <usamaarif642@=
gmail.com> wrote:
> > > > >>>> I am not sure that the approach we are trying in this patch is=
 the right way:
> > > > >>>> - This patch makes it a memcg issue, but you could have memcg =
disabled and
> > > > >>>> then the mitigation being tried here wont apply.
> > > > >>>
> > > > >>> Is the problem reproducible without memcg? I imagine only if th=
e
> > > > >>> entire system is under memory pressure. I guess we would want t=
he same
> > > > >>> "mitigation" either way.
> > > > >>>
> > > > >> What would be a good open source benchmark/workload to test with=
out limiting memory
> > > > >> in memcg?
> > > > >> For the kernel build test, I can only get zswap activity to happ=
en if I build
> > > > >> in cgroup and limit memory.max.
> > > > >
> > > > > You mean a benchmark that puts the entire system under memory
> > > > > pressure? I am not sure, it ultimately depends on the size of mem=
ory
> > > > > you have, among other factors.
> > > > >
> > > > > What if you run the kernel build test in a VM? Then you can limit=
 is
> > > > > size like a memcg, although you'd probably need to leave more roo=
m
> > > > > because the entire guest OS will also subject to the same limit.
> > > > >
> > > >
> > > > I had tried this, but the variance in time/zswap numbers was very h=
igh.
> > > > Much higher than the AMD numbers I posted in reply to Barry. So fou=
nd
> > > > it very difficult to make comparison.
> > >
> > > Hmm yeah maybe more factors come into play with global memory
> > > pressure. I am honestly not sure how to test this scenario, and I
> > > suspect variance will be high anyway.
> > >
> > > We can just try to use whatever technique we use for the memcg limit
> > > though, if possible, right?
> >
> > You can boot a physical machine with mem=3D1G on the commandline, which
> > restricts the physical range of memory that will be initialized.
> > Double check /proc/meminfo after boot, because part of that physical
> > range might not be usable RAM.
> >
> > I do this quite often to test physical memory pressure with workloads
> > that don't scale up easily, like kernel builds.
> >
> > > > >>>> - Instead of this being a large folio swapin issue, is it more=
 of a readahead
> > > > >>>> issue? If we zswap (without the large folio swapin series) and=
 change the window
> > > > >>>> to 1 in swap_vma_readahead, we might see an improvement in lin=
ux kernel build time
> > > > >>>> when cgroup memory is limited as readahead would probably caus=
e swap thrashing as
> > > > >>>> well.
> >
> > +1
> >
> > I also think there is too much focus on cgroup alone. The bigger issue
> > seems to be how much optimistic volume we swap in when we're under
> > pressure already. This applies to large folios and readahead; global
> > memory availability and cgroup limits.
>
> Agreed, although the characteristics of large folios and readahead are
> different. But yeah, different flavors of the same problem.
>
> >
> > It happens to manifest with THP in cgroups because that's what you
> > guys are testing. But IMO, any solution to this problem should
> > consider the wider scope.
>
> +1, and I really think this should be addressed separately, not just
> rely on large block compression/decompression to offset the cost. It's
> probably not just a zswap/zram problem anyway, it just happens to be
> what we support large folio swapin for.

Agreed these are two separate issues and should be both investigated
though 2 can offset the cost of 1.
1. swap thrashing
2. large block compression/decompression

For point 1, we likely want to investigate the following:

1. if we can see the same thrashing if we always perform readahead
(rapidly filling
the memcg to full again after reclamation).

2. Whether there are any issues with balancing file and anon memory
reclamation.

The 'refault feedback loop' in mglru compares refault rates between anon an=
d
file pages to decide which type should be prioritized for reclamation.

type =3D get_type_to_scan(lruvec, swappiness, &tier);

static int get_type_to_scan(struct lruvec *lruvec, int swappiness, int
*tier_idx)
{
        ...
        read_ctrl_pos(lruvec, LRU_GEN_ANON, 0, gain[LRU_GEN_ANON], &sp);
        read_ctrl_pos(lruvec, LRU_GEN_FILE, 0, gain[LRU_GEN_FILE], &pv);
        type =3D positive_ctrl_err(&sp, &pv);

        read_ctrl_pos(lruvec, !type, 0, gain[!type], &sp);
        for (tier =3D 1; tier < MAX_NR_TIERS; tier++) {
                read_ctrl_pos(lruvec, type, tier, gain[type], &pv);
                if (!positive_ctrl_err(&sp, &pv))
                        break;
        }

        *tier_idx =3D tier - 1;
        return type;
}

In this case, we may want to investigate whether reclamation is primarily
targeting anonymous memory due to potential errors in the statistics path
after mTHP is involved.

3. Determine if this is a memcg-specific issue by setting mem=3D1GB and
running the same test on the global system.

Yosry, Johannes, Usama,
Is there anything else that might interest us?

I'll get back to you after completing the investigation mentioned above.

>
> >
> > > > >>> I think large folio swapin would make the problem worse anyway.=
 I am
> > > > >>> also not sure if the readahead window adjusts on memory pressur=
e or
> > > > >>> not.
> > > > >>>
> > > > >> readahead window doesnt look at memory pressure. So maybe the sa=
me thing is being
> > > > >> seen here as there would be in swapin_readahead?
> > > > >
> > > > > Maybe readahead is not as aggressive in general as large folio
> > > > > swapins? Looking at swap_vma_ra_win(), it seems like the maximum =
order
> > > > > of the window is the smaller of page_cluster (2 or 3) and
> > > > > SWAP_RA_ORDER_CEILING (5).
> > > > Yes, I was seeing 8 pages swapin (order 3) when testing. So might
> > > > be similar to enabling 32K mTHP?
> > >
> > > Not quite.
> >
> > Actually, I would expect it to be...
> >
> > > > > Also readahead will swapin 4k folios AFAICT, so we don't need a
> > > > > contiguous allocation like large folio swapin. So that could be
> > > > > another factor why readahead may not reproduce the problem.
> > >
> > > Because of this ^.
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
> In this test scenario, yes, because it's only exercising cgroup
> pressure. But if we want a general solution that also addresses global
> pressure, I expect large folios to be worse because of the contiguity
> and the size (compared to default readahead window sizes). So I think
> we shouldn't only test with readahead, as it won't cover some of the
> large folio cases.

Thanks
barry

