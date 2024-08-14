Return-Path: <linux-kernel+bounces-286050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4289515E7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05416B283EF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 07:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94178143C6A;
	Wed, 14 Aug 2024 07:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkLgkpHD"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8C2143C4C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723621731; cv=none; b=smI2hu3WEs3GW9QnZ/O/rMSF2tne4p2E6q6su4ybqRKHpRPKsobhb/dJtxqrrg6FKrl/6wKxrXmrM5mP5lZcCyAluKUHTPhmKGH/mf4utVNqGZWDU9Xqg9xtkUN6Fw1lVuyCCqiuC4omCgm9ngAEDsVDszpkLk9eU5sKZT2oRqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723621731; c=relaxed/simple;
	bh=5C1j6ezwQ5/mbJIAbQ5bmsAW+tFyXZnIyXCzdEb7NrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUaZm/R0HBi+KgnRqdbw1K/dO0gz5LOcv58ww8FVs2T2HM8bIHbXXfnBoi/LPjUawYujzk88IGSGh7BhvbPwQVsW0m27l3EhVBQjZmPT+MS/vYnt1uU5mtZDKQrHLzzdHwsWXqgzhgOcDSIt+RekdpwIIFeAvnbwEWLsAVTCj8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkLgkpHD; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4f51981b1beso2290904e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 00:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723621729; x=1724226529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/wdavvpDC6LcqHnopC8nbqO8FTC/ahoEI/o+/GeLiI=;
        b=kkLgkpHDMlEaYlPYwJSnQciPAoID6xhBcchMQYRppWuYBbxndTOMLbdPuD1D6RC/e9
         2FngKzqs5jQyzb5bI19DRKs29BHkxk2MzwqVSRp48VltNYR6iG5rlHqr7fQ0W7Gl022g
         9YKS4tdBKGXeLVgMsx7xPe201yi9G1iMx80/LDwEyD3utg03ShFSrp2I6LCyVMSyXRzb
         46v0a/QCrUCgDH9u7d67HmjPIL17PuUmEjozy6jOI7TUKMCqHoAphlxiQb3Rp4RN0Q8P
         O2OhIs+97DQqfoC1KqrMul/RYnfTfPholLcsGl7nLieFuWiUMbJ33idKl1DHWaCI1XCQ
         Q8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723621729; x=1724226529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/wdavvpDC6LcqHnopC8nbqO8FTC/ahoEI/o+/GeLiI=;
        b=vfVEdAG12a11ziBMsBSFD5T4cXVVgAMrXVkA1G3FNuCVvkaKLziOH3vBAfTnfZKvdT
         BQLG6R1XXzTA4DAETjmmOx7b7gR2EbmDg2c5j2aH00FhIa11XQGdSpohJBX1KQaivmOo
         wapoJxcD3L4Z3Ci5k1RrIctSbXFIFzgZlrjSCM3TCGUMORz4vOjJyeG0WLFf2oZBbic8
         0THmr2sgLkY/n4816aBqQ640mYgweypLDAaiRPbzTcphRx0FCNSrQE1tu8egjhTF5uIc
         f4NE7UIT4ONfMibAf0mabfkfcKzeTJrSPED1g1CdsI0mI0PxHrmnbWust7rypesE8wEe
         9ofg==
X-Gm-Message-State: AOJu0YywhG1tMCgNZ4g+EhQnP28mK724LL44jrDoY3LtZ7+mfJEzaSSq
	C3MZy4UMCW1eO1ue8ksOdmPv2Ngy+eyg9rBzoqsvBbQMVpUNReb+3lUVbwxnc7y4hNJSWtzkM+r
	ytdb2/CYP9a+k/XDCzvSR+pDEQvQ=
X-Google-Smtp-Source: AGHT+IEd3u4Se6fhBEJdd+aYxIvEQnUcxk3LNnsHSN+HNVOu12kUacMSFGxoST5ZwSx72QX0tMd0YsxEaFAmyfuOAxs=
X-Received: by 2002:a05:6122:411e:b0:4f5:2960:6ca6 with SMTP id
 71dfb90a1353d-4fad1c2e388mr2546780e0c.2.1723621728923; Wed, 14 Aug 2024
 00:48:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814062830.26833-1-kanchana.p.sridhar@intel.com> <20240814062830.26833-3-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240814062830.26833-3-kanchana.p.sridhar@intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 14 Aug 2024 19:48:37 +1200
Message-ID: <CAGsJ_4yWjjY_GqcaJsma9vPsuV29-WFK5Ho9DFZBx=HnL9=nPQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/4] mm: vmstat: Per mTHP-size zswap_store vmstat
 event counters.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, nphamcs@gmail.com, ryan.roberts@arm.com, 
	ying.huang@intel.com, akpm@linux-foundation.org, nanhai.zou@intel.com, 
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 6:28=E2=80=AFPM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> Added vmstat event counters per mTHP-size that can be used to account
> for folios of different sizes being successfully stored in ZSWAP.
>
> For this RFC, it is not clear if these zswpout counters should instead
> be added as part of the existing mTHP stats in
> /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats.
>
> The following is also a viable option, should it make better sense,
> for instance, as:
>
> /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/zswpout.
>
> If so, we would be able to distinguish between mTHP zswap and
> non-zswap swapouts through:
>
> /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/zswpout
>
> and
>
> /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/swpout
>
> respectively.
>
> Comments would be appreciated as to which approach is preferable.

Even though swapout might go through zswap, from the perspective of
the mm core, it shouldn't be aware of that. Shouldn't zswpout be part
of swpout? Why are they separate? no matter if a mTHP has been
put in zswap, it has been swapped-out to mm-core? No?


>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> ---
>  include/linux/vm_event_item.h | 15 +++++++++++++++
>  mm/vmstat.c                   | 15 +++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.=
h
> index 747943bc8cc2..2451bcfcf05c 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -114,6 +114,9 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT=
,
>                 THP_ZERO_PAGE_ALLOC,
>                 THP_ZERO_PAGE_ALLOC_FAILED,
>                 THP_SWPOUT,
> +#ifdef CONFIG_ZSWAP
> +               ZSWPOUT_PMD_THP_FOLIO,
> +#endif
>                 THP_SWPOUT_FALLBACK,
>  #endif
>  #ifdef CONFIG_MEMORY_BALLOON
> @@ -143,6 +146,18 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOU=
T,
>                 ZSWPIN,
>                 ZSWPOUT,
>                 ZSWPWB,
> +               ZSWPOUT_4KB_FOLIO,
> +#ifdef CONFIG_THP_SWAP
> +               mTHP_ZSWPOUT_8kB,
> +               mTHP_ZSWPOUT_16kB,
> +               mTHP_ZSWPOUT_32kB,
> +               mTHP_ZSWPOUT_64kB,
> +               mTHP_ZSWPOUT_128kB,
> +               mTHP_ZSWPOUT_256kB,
> +               mTHP_ZSWPOUT_512kB,
> +               mTHP_ZSWPOUT_1024kB,
> +               mTHP_ZSWPOUT_2048kB,
> +#endif

This implementation hardcodes assumptions about the page size being 4KB,
but page sizes can vary, and so can the THP orders?

>  #endif
>  #ifdef CONFIG_X86
>                 DIRECT_MAP_LEVEL2_SPLIT,
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 8507c497218b..0e66c8b0c486 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1375,6 +1375,9 @@ const char * const vmstat_text[] =3D {
>         "thp_zero_page_alloc",
>         "thp_zero_page_alloc_failed",
>         "thp_swpout",
> +#ifdef CONFIG_ZSWAP
> +       "zswpout_pmd_thp_folio",
> +#endif
>         "thp_swpout_fallback",
>  #endif
>  #ifdef CONFIG_MEMORY_BALLOON
> @@ -1405,6 +1408,18 @@ const char * const vmstat_text[] =3D {
>         "zswpin",
>         "zswpout",
>         "zswpwb",
> +       "zswpout_4kb_folio",
> +#ifdef CONFIG_THP_SWAP
> +       "mthp_zswpout_8kb",
> +       "mthp_zswpout_16kb",
> +       "mthp_zswpout_32kb",
> +       "mthp_zswpout_64kb",
> +       "mthp_zswpout_128kb",
> +       "mthp_zswpout_256kb",
> +       "mthp_zswpout_512kb",
> +       "mthp_zswpout_1024kb",
> +       "mthp_zswpout_2048kb",
> +#endif

The issue here is that the number of THP orders
can vary across different platforms.

>  #endif
>  #ifdef CONFIG_X86
>         "direct_map_level2_splits",
> --
> 2.27.0
>

Thanks
Barry

