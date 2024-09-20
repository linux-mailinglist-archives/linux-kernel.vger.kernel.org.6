Return-Path: <linux-kernel+bounces-334686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E7497DAA9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 00:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D55A1C21254
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 22:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70EE18D65F;
	Fri, 20 Sep 2024 22:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MStdv8VB"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D43518733D
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 22:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726873093; cv=none; b=o9E3EcdJRpc34lng5zmI+ccu1ZktnjZSadZBhhseYe5NvgihJAxh8MnfDXJnFQ/5AlWDZYMJoP6sAfUsEsbAVomsIboM2SIXkp/LlRDwGwxAZ/tFdM1NcfEzno6KByt7SUULeO/DWXhCrAuJFg8OV6rNe6dtQXgGoBDJ0C2H4bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726873093; c=relaxed/simple;
	bh=2zTHEWx4+jhd15hfHsUv576gjZB143yv9TfrGEYJLKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbItIY84TUrNR1mn1TtMtXcLzcpB8ldFu8Rg41FqqN88ctBs/o/Jx7aW6gudF3yBO1Z6gSNgeFI0tD+Zf9ffP2t+PkY1PSwqzCCgpZl74PEvU4+evwBB7KuK7x3Qb4MrOsWsUira6T4ZGZ3i0jy0AQXT377I/B3/vm2r+Ouu1bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MStdv8VB; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c42f406e29so3510518a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 15:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726873090; x=1727477890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mq/voqlf4mL8U2+m8aQ6n/5tyrYP8g1KxZiW0+DAj0=;
        b=MStdv8VBM6AgZaevE2xg2h7gosMiGJFZJBMYvDRDMmHKzIC90j4g6g3jIKcbBSyoyH
         zVnkxF6uXRBFhKotwtmT/GPz2PkBdEO02xHaDNgghdf51fkId0E9juT+QZd1WSVy70qf
         P4GnzL3hcC8lIeIMjMJ33yXdjSlTb73/bh9t4bbiAHGavtUux6wpEO5Ug3cK9AAOFRO+
         by2Sp0a6lRuOxIF8B6BadVQjbyRABfWSyM1CuyJAl+vOCm0+Ij2HLkGpWs3BvHsycz1l
         sF4MptWu9uitSPXNhmSiBUWxDjFsJr6oHbxK11aAAHn9CGizmXidCyL75Yu/k0Lyv+4U
         uc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726873090; x=1727477890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mq/voqlf4mL8U2+m8aQ6n/5tyrYP8g1KxZiW0+DAj0=;
        b=c/Ku7CioEOGMnyHSxELq88mDTKajBZZ7UhgYSBwFVyMW9GAHvH6g27Ae//aMjOOUWx
         GJlvsPK3k0Gk7D3oSGlYiAkfZb95k2sM/Map24PXXCVghwCq/EUbVtbXn93mNDYpdIck
         94CzJW45t9DHPeO0xzJ5hyDe9IEPcCehqq2eE54flYBc950uiA+cu+yQh5QTym/21Gby
         ozavPIxsdYex7DPc/FRrI9o2smeh9NzQscGZqZdWQtAqrSp8CWFP2qv+xSbx3mXPgSvX
         0cVCpgVXNKeu4hYjErgmgkkaLtdJN3V53hOn6BRwYKrWpXkxraDxqEisE6/h/jk9O3mc
         Kf8A==
X-Gm-Message-State: AOJu0YzrFLhgAqy7iUMEdk2p4SEOqFf3nWRpHD0snzTFkg8O1o9OgwjD
	DTj4IaQcZm5OR9mTrAlAdQQeHdnIN91rVmP0aWTAeNyO3NRjYKG8/apdmiJxoHzu7V0kgQws02C
	FB7STFLp+qO9ibXrujyVP68NyBXxzQx4xhK+t
X-Google-Smtp-Source: AGHT+IFgOADyf7UwM0IofIFAmjZTYO18vRoUZkATcenZKxqoRQbjdfO9DfNK1fcrQLf/7R1cAkotJ4ynbbCIaOA9TG0=
X-Received: by 2002:a17:906:6a24:b0:a8a:9207:c4c1 with SMTP id
 a640c23a62f3a-a90d5167dafmr409646966b.58.1726873089625; Fri, 20 Sep 2024
 15:58:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829212705.6714-1-kanchana.p.sridhar@intel.com> <20240829212705.6714-4-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240829212705.6714-4-kanchana.p.sridhar@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 20 Sep 2024 15:57:31 -0700
Message-ID: <CAJD7tkbnZHCPu0Bqs2xNyP6FQviuq6kGSQa840H+sVhiPEbYpA@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] mm: swap: Count successful mTHP ZSWAP stores in
 sysfs mTHP zswpout stats.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	ryan.roberts@arm.com, ying.huang@intel.com, 21cnbao@gmail.com, 
	akpm@linux-foundation.org, nanhai.zou@intel.com, wajdi.k.feghali@intel.com, 
	vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 2:27=E2=80=AFPM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> Add a new MTHP_STAT_ZSWPOUT entry to the sysfs mTHP stats so that
> per-order mTHP folio ZSWAP stores can be accounted.
>
> If zswap_store() successfully swaps out an mTHP, it will be counted under
> the per-order sysfs "zswpout" stats:
>
> /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/zswpout
>
> Other block dev/fs mTHP swap-out events will be counted under
> the existing sysfs "swpout" stats:
>
> /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/swpout
>
> Based on changes made in commit 61e751c01466ffef5dc72cb64349454a691c6bfe
> ("mm: cleanup count_mthp_stat() definition"), this patch also moves
> the call to count_mthp_stat() in count_swpout_vm_event() to be outside
> the "ifdef CONFIG_TRANSPARENT_HUGEPAGE".

This should be in a separate change, it's irrelevant to
MTHP_STAT_ZSWPOUT being added.

>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> ---
>  include/linux/huge_mm.h | 1 +
>  mm/huge_memory.c        | 3 +++
>  mm/page_io.c            | 3 ++-
>  3 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 4da102b74a8c..8b690328e78b 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -118,6 +118,7 @@ enum mthp_stat_item {
>         MTHP_STAT_ANON_FAULT_ALLOC,
>         MTHP_STAT_ANON_FAULT_FALLBACK,
>         MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> +       MTHP_STAT_ZSWPOUT,
>         MTHP_STAT_SWPOUT,
>         MTHP_STAT_SWPOUT_FALLBACK,
>         MTHP_STAT_SHMEM_ALLOC,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 15418ffdd377..ad921c4b2ad8 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -587,6 +587,7 @@ static struct kobj_attribute _name##_attr =3D __ATTR_=
RO(_name)
>  DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK=
);
>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_F=
ALLBACK_CHARGE);
> +DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
>  DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
>  DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
>  #ifdef CONFIG_SHMEM
> @@ -605,6 +606,7 @@ static struct attribute *anon_stats_attrs[] =3D {
>         &anon_fault_fallback_attr.attr,
>         &anon_fault_fallback_charge_attr.attr,
>  #ifndef CONFIG_SHMEM
> +       &zswpout_attr.attr,
>         &swpout_attr.attr,
>         &swpout_fallback_attr.attr,
>  #endif
> @@ -637,6 +639,7 @@ static struct attribute_group file_stats_attr_grp =3D=
 {
>
>  static struct attribute *any_stats_attrs[] =3D {
>  #ifdef CONFIG_SHMEM
> +       &zswpout_attr.attr,
>         &swpout_attr.attr,
>         &swpout_fallback_attr.attr,
>  #endif
> diff --git a/mm/page_io.c b/mm/page_io.c
> index b6f1519d63b0..26106e745d73 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -289,6 +289,7 @@ int swap_writepage(struct page *page, struct writebac=
k_control *wbc)
>                 swap_zeromap_folio_clear(folio);
>         }
>         if (zswap_store(folio)) {
> +               count_mthp_stat(folio_order(folio), MTHP_STAT_ZSWPOUT);
>                 folio_unlock(folio);
>                 return 0;
>         }
> @@ -308,8 +309,8 @@ static inline void count_swpout_vm_event(struct folio=
 *folio)
>                 count_memcg_folio_events(folio, THP_SWPOUT, 1);
>                 count_vm_event(THP_SWPOUT);
>         }
> -       count_mthp_stat(folio_order(folio), MTHP_STAT_SWPOUT);
>  #endif
> +       count_mthp_stat(folio_order(folio), MTHP_STAT_SWPOUT);
>         count_vm_events(PSWPOUT, folio_nr_pages(folio));
>  }
>
> --
> 2.27.0
>

