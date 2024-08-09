Return-Path: <linux-kernel+bounces-280585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB20194CC74
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68A8B1F23B0D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F9418E03F;
	Fri,  9 Aug 2024 08:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h08vZr7L"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B5612FB34
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 08:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192862; cv=none; b=WazaOFB8P0UTQakOQHhGff7uZHAVglDPQBT4rhDNZTvnfw/puuqB7kFky3ByAhPikHgPGHq3NN220QkYmMr0F0GPCXszjCB0yo6LZQVnpGo34UEHOaiM7btY5w1jHbZUju59g0bIDhI4kwJF4MuK+fOR2SGR7DMm29limme5FJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192862; c=relaxed/simple;
	bh=UN7ixbZhRlDBmb6HTMbkMAQYkQQhhK0A/IkamTzrHTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fDLweNZGXeBEQqGdH8XR2ps5DrpcSbizwjp/dc79jyvnO57TtMWvQF+SHNQe5AztVGc70TIFprjvcGu70J3E8+i5+i/l8lgvZceBWtIzeKlpKLEETeI8LM5qqU5rmTKofBsRvqlAwJ0yZO/cLIHja3lFYAYA2rv2w4mdvtXN/oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h08vZr7L; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-822eb80f6e4so643035241.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 01:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723192860; x=1723797660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyhhln8LdxGbaSUipVO6QkS3X9KbQAWUVQTlCes9cL8=;
        b=h08vZr7Ltw9cbghQ6O4DWiGkxkJpJctOUv64qpyIAfKYp7/9cUQyqTBfhpByehRqo9
         OWrHlGOctgHRvl27sG7vZRzcNP9g030m0VLMyrxeA7+arytlVOuQqFBjBOyT27oRJsp0
         qPhk+2o8yZQ8AQrs0syoBEJmaomoxFWgdqBldW32uqGqXy807aVwaBY/CVXeo8Kn7WnX
         9+CCj+JjMfLxW81g7PcmzUBxxcrx3PHnDub++q0WePp6gB2stDaQavWdHCdoJ+D1FZgW
         7s3bWznpOg8SPki0W4mILN39ATHIGKOBNWamNrE3drTTO2DmFYd0qiPxbl8lo3McAS2A
         eMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723192860; x=1723797660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyhhln8LdxGbaSUipVO6QkS3X9KbQAWUVQTlCes9cL8=;
        b=dX+rzwsZ7TUVBPPKXs0XRHTLO+reyo0m69WmMnez4AZ6e58JZGeqmr5+u+FX/MZHoQ
         7C0isHh8CDx1Y+tnDC1HzhE86gwZf7qvDWgxvquT3BJc3tW6MmoUJRglwK94uUF+vwY1
         PuNiPjZQcpTTGNoNoMUdEztkZsV5/pWuuwfN9xq6AzYNJFYSYpaL7TRonwch/4F/mH9t
         2ZHBRqqKFkxv+S5AUI8kq2bjAOtqpwUzAf4qmyKR4GOIcqjNajuZFCU1EHWjGzbSeqgV
         65N7Qs7yf1GLqrnQBuOA3tl/GMiLBFzyfajyPVOYRqHneTUAF8d5qy6Fm+aSoDr7LmU8
         hUyg==
X-Forwarded-Encrypted: i=1; AJvYcCUyqaM0GHqk/9kyMfpe9pVJmsRXIipLIiITQ/N9nRxBJ9KBdCnSMTDaPHMnJLqvl4knt9XVOjpfqS/I9wgzNaJcb02w1iIldDY30QL9
X-Gm-Message-State: AOJu0Yx/LibisywYdch3gOnUcPBWwwTpcpXSEbz+tO1hZ2mZo0DMRQgl
	BBUKlcvSp4IXuDD4mM7qz7aqgNZK8XkNcjsr1dVhFmBPQgwwDE//OmE5uK70WagUQF5OKlDvwXL
	6EcGjwEk/mXDwJSovTksKdz+J/S8=
X-Google-Smtp-Source: AGHT+IH/PjpVOgaurrZku4yroPYgH0aUSlgZSBJCHBBnT+awGDYLpvy48+rB/QrEdWv7nteIAriYF9GQNGA3/4JhK9M=
X-Received: by 2002:a05:6102:442b:b0:493:c95b:4c15 with SMTP id
 ada2fe7eead31-495d821662cmr923877137.0.1723192859270; Fri, 09 Aug 2024
 01:40:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808010457.228753-1-21cnbao@gmail.com> <20240808010457.228753-2-21cnbao@gmail.com>
 <e9f82fd8-e1da-49ea-a735-b174575c02bc@arm.com> <1222cd76-e732-4238-9413-61843249c1e8@arm.com>
In-Reply-To: <1222cd76-e732-4238-9413-61843249c1e8@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 9 Aug 2024 16:40:47 +0800
Message-ID: <CAGsJ_4x9MB2yrs2zbZz3TpAjAzD-jzbmHY6+nGEy-uOE4y9jFw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] mm: collect the number of anon large folios
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, chrisl@kernel.org, 
	david@redhat.com, kaleshsingh@google.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, ioworker0@gmail.com, 
	baolin.wang@linux.alibaba.com, ziy@nvidia.com, hanchuanhua@oppo.com, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 4:27=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 09/08/2024 09:13, Ryan Roberts wrote:
> > On 08/08/2024 02:04, Barry Song wrote:
> >> From: Barry Song <v-songbaohua@oppo.com>
> >>
> >> When a new anonymous mTHP is added to the rmap, we increase the count.
> >> We reduce the count whenever an mTHP is completely unmapped.
> >>
> >> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >> ---
> >>  Documentation/admin-guide/mm/transhuge.rst |  5 +++++
> >>  include/linux/huge_mm.h                    | 15 +++++++++++++--
> >>  mm/huge_memory.c                           |  2 ++
> >>  mm/rmap.c                                  |  3 +++
> >>  4 files changed, 23 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentatio=
n/admin-guide/mm/transhuge.rst
> >> index 058485daf186..715f181543f6 100644
> >> --- a/Documentation/admin-guide/mm/transhuge.rst
> >> +++ b/Documentation/admin-guide/mm/transhuge.rst
> >> @@ -527,6 +527,11 @@ split_deferred
> >>          it would free up some memory. Pages on split queue are going =
to
> >>          be split under memory pressure, if splitting is possible.
> >>
> >> +anon_num
> >> +       the number of anon huge pages we have in the whole system.
> >> +       These huge pages could be still entirely mapped and have parti=
ally
> >> +       unmapped and unused subpages.
> >
> > nit: "entirely mapped and have partially unmapped and unused subpages" =
->
> > "entirely mapped or have partially unmapped/unused subpages"
> >
> >> +
> >>  As the system ages, allocating huge pages may be expensive as the
> >>  system uses memory compaction to copy data around memory to free a
> >>  huge page for use. There are some counters in ``/proc/vmstat`` to hel=
p
> >> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >> index e25d9ebfdf89..294c348fe3cc 100644
> >> --- a/include/linux/huge_mm.h
> >> +++ b/include/linux/huge_mm.h
> >> @@ -281,6 +281,7 @@ enum mthp_stat_item {
> >>      MTHP_STAT_SPLIT,
> >>      MTHP_STAT_SPLIT_FAILED,
> >>      MTHP_STAT_SPLIT_DEFERRED,
> >> +    MTHP_STAT_NR_ANON,
> >>      __MTHP_STAT_COUNT
> >>  };
> >>
> >> @@ -291,14 +292,24 @@ struct mthp_stat {
> >>  #ifdef CONFIG_SYSFS
> >>  DECLARE_PER_CPU(struct mthp_stat, mthp_stats);
> >>
> >> -static inline void count_mthp_stat(int order, enum mthp_stat_item ite=
m)
> >> +static inline void mod_mthp_stat(int order, enum mthp_stat_item item,=
 int delta)
> >>  {
> >>      if (order <=3D 0 || order > PMD_ORDER)
> >>              return;
> >>
> >> -    this_cpu_inc(mthp_stats.stats[order][item]);
> >> +    this_cpu_add(mthp_stats.stats[order][item], delta);
> >> +}
> >> +
> >> +static inline void count_mthp_stat(int order, enum mthp_stat_item ite=
m)
> >> +{
> >> +    mod_mthp_stat(order, item, 1);
> >>  }
> >> +
> >>  #else
> >> +static inline void mod_mthp_stat(int order, enum mthp_stat_item item,=
 int delta)
> >> +{
> >> +}
> >> +
> >>  static inline void count_mthp_stat(int order, enum mthp_stat_item ite=
m)
> >>  {
> >>  }
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index 697fcf89f975..b6bc2a3791e3 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -578,6 +578,7 @@ DEFINE_MTHP_STAT_ATTR(shmem_fallback_charge, MTHP_=
STAT_SHMEM_FALLBACK_CHARGE);
> >>  DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
> >>  DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
> >>  DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
> >> +DEFINE_MTHP_STAT_ATTR(anon_num, MTHP_STAT_NR_ANON);
>
> Why are the user-facing and internal names different? Perhaps it would be
> clearer to call this nr_anon in sysfs?
>
> >>
> >>  static struct attribute *stats_attrs[] =3D {
> >>      &anon_fault_alloc_attr.attr,
> >> @@ -591,6 +592,7 @@ static struct attribute *stats_attrs[] =3D {
> >>      &split_attr.attr,
> >>      &split_failed_attr.attr,
> >>      &split_deferred_attr.attr,
> >> +    &anon_num_attr.attr,
> >>      NULL,
> >>  };
> >>
> >> diff --git a/mm/rmap.c b/mm/rmap.c
> >> index 901950200957..2b722f26224c 100644
> >> --- a/mm/rmap.c
> >> +++ b/mm/rmap.c
> >> @@ -1467,6 +1467,7 @@ void folio_add_new_anon_rmap(struct folio *folio=
, struct vm_area_struct *vma,
> >>      }
> >>
> >>      __folio_mod_stat(folio, nr, nr_pmdmapped);
> >> +    mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
> >>  }
> >>
> >>  static __always_inline void __folio_add_file_rmap(struct folio *folio=
,
> >> @@ -1582,6 +1583,8 @@ static __always_inline void __folio_remove_rmap(=
struct folio *folio,
> >>          list_empty(&folio->_deferred_list))
> >>              deferred_split_folio(folio);
> >>      __folio_mod_stat(folio, -nr, -nr_pmdmapped);
> >> +    if (folio_test_anon(folio) && !atomic_read(mapped))
> >
> > Agree that atomic_read() is dodgy here.
> >
> > Not sure I fully understand why David prefers to do the unaccounting at
> > free-time though? It feels unbalanced to me to increment when first map=
ped but
> > decrement when freed. Surely its safer to either use alloc/free or use =
first
> > map/last map?

As long as we can account for mTHP when clearing the Anon flag for the foli=
o,
we should be safe. It=E2=80=99s challenging to add +1 when allocating a lar=
ge folio
because we don=E2=80=99t know its intended use=E2=80=94it could be for file=
, anon, or shmem.

> >
> > If using alloc/free isn't there a THP constructor/destructor that prepa=
res the
> > deferred list? (My memory may be failing me). Could we use that?
>
> Additionally, if we wanted to extend (eventually) to track the number of =
shmem
> and file mthps in additional counters, could we also account using simila=
r folio
> free-time hooks? If not, it might be an argument to account in rmap_unmap=
 to be
> consistent for all?

I've been struggling quite a bit with rmap. Despite trying various
approaches, I=E2=80=99m
still occasionally seeing a negative mTHP counter after running it some hou=
rs
on phones. It seems that rmap is really tricky to handle.  I admit that I h=
ave
failed on rmap :-)

On the other hand, for anon folios, we have cases where they are split from
order M to order N. So, we add +1 when a new anon folio is added to rmap
and subtract -1 when we either split it or free it. This approach seems cle=
arer
to me. When we split from order M to order N, we can add 1 << (M - N) for
order N.

>
>
> >
> >> +            mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, -1);
> >>
> >>      /*
> >>       * It would be tidy to reset folio_test_anon mapping when fully

Thanks
Barry

