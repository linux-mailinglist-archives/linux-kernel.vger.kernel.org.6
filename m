Return-Path: <linux-kernel+bounces-287307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B6395262E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 01:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CCF2282B59
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18AC14D71A;
	Wed, 14 Aug 2024 23:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJ9l51GT"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B2B14389F
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 23:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723677903; cv=none; b=Uvjxb5F4kHaGs/r429rHra6+jCDQ0u5L5P4dwS3+CodmXGnvl9vtQSrbz7wUuUskqfB/hH8+5rZQCCZ2yE1abiWheNNDg2YqUjGMvzHk1aHXiJtrZtHovR0dtN8LlMOR0bqLhK1O3rvES9TaTmx2XTRES8A0DDofUCsL6+9H36E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723677903; c=relaxed/simple;
	bh=zvWbXSuJfGAR6jvQ8RXpTit3hms41FLriYXXNK/qpyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbX8wcc91akijgKBb8Zi5Bt0KRLTkWDmCS/aed6NLYko7DuVrSQor7k0AbiD52M9/U7WTc4rpHz6uGMnWF5vv29eLrzUp+02T/md4GpSWp+uejJC2Gk+v8y/jCpTvOTC6Cj+clllko3Hk3fHsw3pI5eRJWAN7iyDXo0gVoeoMyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJ9l51GT; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4f8c50440e6so149463e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723677900; x=1724282700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5ecmjJfcT0FCCG8RwUU6alXyHI9eWN1URTy75OZxMk=;
        b=RJ9l51GTa2V72CU+y5OEFUAgf5kUBNpevgfMhV4cTEkz2Da02iNWdJVA4DJ/5KFonR
         vhfcNbn58CEosYp1Kni3bblAMWzTI6rOWItIoK4f7CmAP+qF6x5oPEB2i76xiN9KjvDn
         aEP04PC1vDKD2QDTHcl7dgBfaxhCzuaAQktGIXXfJBuPcLM2IcOe/OL/CZF8ENfokUrU
         La3nchdFKJbI1zZ2feD/G85S9Xum2nzxcTxYKgoyzfPb1j69ur83kVW2KU6RRl3xyCQE
         RHlHC6zuq5fWnOZhAmOKodiJeNxykU3gnWEMX1JwYWruet3dkuDnvExBIly1mCvWNk+m
         jBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723677900; x=1724282700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5ecmjJfcT0FCCG8RwUU6alXyHI9eWN1URTy75OZxMk=;
        b=g9v2mQMoDmq4FcKRk5WXNSiXRMr4Bjg62oNNMylGl97BeyGffFwkoZGu7V6VoWWaWg
         /kENP64KhUkX2bEkSFiP+qb1XAmcejWcHjn57OTQTiL4V6ElY3Gn3lJOZz+4+NEf3GQJ
         LzFOPMMZMRmt0XczDgG/Z/Iq5S0bSNDnBBvhxO56fVhX/H7UZi5iplrabNXl0TAYz11y
         z7xxfTQtiaw3rdvxXD2SQeQ3t/HHtXvZviz2wdvGUwpWsg26MUY4mUaHnzYaGatmztQX
         5k6rg6ySCD1pCMCZpGjiwybrqtl5fEsZlHY+0lCbxuruThbpn+3HTjW7VWP/6i8oV8+1
         Sttw==
X-Gm-Message-State: AOJu0YydVb/LUpCg1JhJVPHEKbXFzIGNuBFELi6GLXcrZH2Xhc/mu9fO
	FSeMZ/IBPUTsIKXDnkPimvdu5y6vZ8ekY0PyDegVIQUQuNlABj+cHCh93sD8GKZehv/1nQQLYJ2
	UC8N3833U30kkbl2cl2/XR2CFLx0=
X-Google-Smtp-Source: AGHT+IE+yqsMTXX2EMGjcI5YDI2FitTMU+9sTKfPOY8NtOV2hE7cHar2lJU2iNvDQpw72fDS70BofFf5VQ9IgpWqxH0=
X-Received: by 2002:a05:6122:2524:b0:4f5:199b:2a61 with SMTP id
 71dfb90a1353d-4fad23165a6mr5381411e0c.9.1723677900129; Wed, 14 Aug 2024
 16:25:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814062830.26833-1-kanchana.p.sridhar@intel.com>
 <20240814062830.26833-3-kanchana.p.sridhar@intel.com> <CAGsJ_4yWjjY_GqcaJsma9vPsuV29-WFK5Ho9DFZBx=HnL9=nPQ@mail.gmail.com>
 <SJ0PR11MB5678048AA2B4C654E41082D8C9872@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB5678048AA2B4C654E41082D8C9872@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 15 Aug 2024 11:24:49 +1200
Message-ID: <CAGsJ_4wuoWKSnzeJ-2Xoc=_du3ZL3Ms8s6K58w8En3_h8-q_ng@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/4] mm: vmstat: Per mTHP-size zswap_store vmstat
 event counters.
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>, 
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>, 
	"Huang, Ying" <ying.huang@intel.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Zou, Nanhai" <nanhai.zou@intel.com>, 
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 5:40=E2=80=AFAM Sridhar, Kanchana P
<kanchana.p.sridhar@intel.com> wrote:
>
> Hi Barry,
>
> > -----Original Message-----
> > From: Barry Song <21cnbao@gmail.com>
> > Sent: Wednesday, August 14, 2024 12:49 AM
> > To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> > Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> > hannes@cmpxchg.org; yosryahmed@google.com; nphamcs@gmail.com;
> > ryan.roberts@arm.com; Huang, Ying <ying.huang@intel.com>; akpm@linux-
> > foundation.org; Zou, Nanhai <nanhai.zou@intel.com>; Feghali, Wajdi K
> > <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
> > Subject: Re: [RFC PATCH v1 2/4] mm: vmstat: Per mTHP-size zswap_store
> > vmstat event counters.
> >
> > On Wed, Aug 14, 2024 at 6:28=E2=80=AFPM Kanchana P Sridhar
> > <kanchana.p.sridhar@intel.com> wrote:
> > >
> > > Added vmstat event counters per mTHP-size that can be used to account
> > > for folios of different sizes being successfully stored in ZSWAP.
> > >
> > > For this RFC, it is not clear if these zswpout counters should instea=
d
> > > be added as part of the existing mTHP stats in
> > > /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats.
> > >
> > > The following is also a viable option, should it make better sense,
> > > for instance, as:
> > >
> > > /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/zswpout.
> > >
> > > If so, we would be able to distinguish between mTHP zswap and
> > > non-zswap swapouts through:
> > >
> > > /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/zswpout
> > >
> > > and
> > >
> > > /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/swpout
> > >
> > > respectively.
> > >
> > > Comments would be appreciated as to which approach is preferable.
> >
> > Even though swapout might go through zswap, from the perspective of
> > the mm core, it shouldn't be aware of that. Shouldn't zswpout be part
> > of swpout? Why are they separate? no matter if a mTHP has been
> > put in zswap, it has been swapped-out to mm-core? No?
>
> Thanks for the code review comments. This is a good point. I was keeping =
in
> mind the convention used by existing vmstat event counters that distingui=
sh
> zswpout/zswpin from pswpout/pswpin events.
>
> If we want to keep the distinction in mTHP swapouts, would adding a
> separate MTHP_STAT_ZSWPOUT to "enum mthp_stat_item" be Ok?
>

I'm not entirely sure how important the zswpout counter is. To me, it doesn=
't
seem as critical as swpout and swpout_fallback, which are more useful for
system profiling. zswapout feels more like an internal detail related to
how the swap-out process is handled? If this is the case, we might not
need this per-size counter.

Otherwise, I believe sysfs is a better place to avoid all the chaos in vmst=
at
to handle various orders and sizes. So the question is, per-size zswpout
counter is really important or just for debugging purposes?

> In any case, it looks like all that would be needed is a call to
> count_mthp_stat(folio_order(folio), MTHP_STAT_[Z]SWPOUT) in the
> general case.
>
> I will make this change in v2, depending on whether or not the
> separation of zswpout vs. non-zswap swpout is recommended for
> mTHP.
>
> >
> >
> > >
> > > Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> > > ---
> > >  include/linux/vm_event_item.h | 15 +++++++++++++++
> > >  mm/vmstat.c                   | 15 +++++++++++++++
> > >  2 files changed, 30 insertions(+)
> > >
> > > diff --git a/include/linux/vm_event_item.h
> > b/include/linux/vm_event_item.h
> > > index 747943bc8cc2..2451bcfcf05c 100644
> > > --- a/include/linux/vm_event_item.h
> > > +++ b/include/linux/vm_event_item.h
> > > @@ -114,6 +114,9 @@ enum vm_event_item { PGPGIN, PGPGOUT,
> > PSWPIN, PSWPOUT,
> > >                 THP_ZERO_PAGE_ALLOC,
> > >                 THP_ZERO_PAGE_ALLOC_FAILED,
> > >                 THP_SWPOUT,
> > > +#ifdef CONFIG_ZSWAP
> > > +               ZSWPOUT_PMD_THP_FOLIO,
> > > +#endif
> > >                 THP_SWPOUT_FALLBACK,
> > >  #endif
> > >  #ifdef CONFIG_MEMORY_BALLOON
> > > @@ -143,6 +146,18 @@ enum vm_event_item { PGPGIN, PGPGOUT,
> > PSWPIN, PSWPOUT,
> > >                 ZSWPIN,
> > >                 ZSWPOUT,
> > >                 ZSWPWB,
> > > +               ZSWPOUT_4KB_FOLIO,
> > > +#ifdef CONFIG_THP_SWAP
> > > +               mTHP_ZSWPOUT_8kB,
> > > +               mTHP_ZSWPOUT_16kB,
> > > +               mTHP_ZSWPOUT_32kB,
> > > +               mTHP_ZSWPOUT_64kB,
> > > +               mTHP_ZSWPOUT_128kB,
> > > +               mTHP_ZSWPOUT_256kB,
> > > +               mTHP_ZSWPOUT_512kB,
> > > +               mTHP_ZSWPOUT_1024kB,
> > > +               mTHP_ZSWPOUT_2048kB,
> > > +#endif
> >
> > This implementation hardcodes assumptions about the page size being 4KB=
,
> > but page sizes can vary, and so can the THP orders?
>
> Agreed, will address in v2.
>
> >
> > >  #endif
> > >  #ifdef CONFIG_X86
> > >                 DIRECT_MAP_LEVEL2_SPLIT,
> > > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > > index 8507c497218b..0e66c8b0c486 100644
> > > --- a/mm/vmstat.c
> > > +++ b/mm/vmstat.c
> > > @@ -1375,6 +1375,9 @@ const char * const vmstat_text[] =3D {
> > >         "thp_zero_page_alloc",
> > >         "thp_zero_page_alloc_failed",
> > >         "thp_swpout",
> > > +#ifdef CONFIG_ZSWAP
> > > +       "zswpout_pmd_thp_folio",
> > > +#endif
> > >         "thp_swpout_fallback",
> > >  #endif
> > >  #ifdef CONFIG_MEMORY_BALLOON
> > > @@ -1405,6 +1408,18 @@ const char * const vmstat_text[] =3D {
> > >         "zswpin",
> > >         "zswpout",
> > >         "zswpwb",
> > > +       "zswpout_4kb_folio",
> > > +#ifdef CONFIG_THP_SWAP
> > > +       "mthp_zswpout_8kb",
> > > +       "mthp_zswpout_16kb",
> > > +       "mthp_zswpout_32kb",
> > > +       "mthp_zswpout_64kb",
> > > +       "mthp_zswpout_128kb",
> > > +       "mthp_zswpout_256kb",
> > > +       "mthp_zswpout_512kb",
> > > +       "mthp_zswpout_1024kb",
> > > +       "mthp_zswpout_2048kb",
> > > +#endif
> >
> > The issue here is that the number of THP orders
> > can vary across different platforms.
>
> Agreed, will address in v2.
>
> Thanks,
> Kanchana
>
> >
> > >  #endif
> > >  #ifdef CONFIG_X86
> > >         "direct_map_level2_splits",
> > > --
> > > 2.27.0
> > >

Thanks
Barry

