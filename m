Return-Path: <linux-kernel+bounces-279923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 440A394C37B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1E31B21C3A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0E4190698;
	Thu,  8 Aug 2024 17:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HUcoNlov"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766E118FC9C
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 17:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723137497; cv=none; b=oFsihDYcP5UO7olxTkwL7G1vaZMt4PwhQb0nxKNV/FBDN20MYtF5GouDLaaQ19FDcjPqiXA+TtJk6e5LCCgvsQemWfkZ91z6RaAwQtVCGNOQQfq9hXwzG6Q4/g2Gg2KkpNNr8AQogOoVtnyejgiIbPdMwCBDupPna9ZRXckdyb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723137497; c=relaxed/simple;
	bh=7MU0StU7kuvB8c+SueIW/gnyRc1Y/xMLCb7sZfJiiFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPxKmJ7DkTfnKvEz2QfoXw80JK+qwBO7nyoij9AJKjEI5InRVZ8QI2V/mtEhL8mKWdNCHFDgd0Prw7BHJjK1LbVaBVs+3k94O/X+3Mdt3B+DAGGMIZP92yqj1MLiDig07Pw9dpHgRx5ncZBo0J5vmMYuhMaxfCRxYSeppKHxY6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HUcoNlov; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52efbb55d24so2208849e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 10:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723137493; x=1723742293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bm+7EpRnlnQ2hj516+ZMFRLx/ir/OPRTVmLMCWHFcSM=;
        b=HUcoNlovxNa3978ABqscxU8f533VlumVQ1ySHOvaidvLBwnG8ZKZjcauh2x9dhFdHw
         25P/uEbyoozme1BcOEFVIZRFX46/uCiuEV3IacOTeAtXOTbJYhUYOp1aUqS/EpFRn97a
         mdPOALHrWbw+478dXbYkPwYGbr+Q+lWlUFdG2mN1KhXB7U5m+xR/n8RcLoKSvdJ0Grgg
         nwM0b8ZPQ+Xd4ZGQNk/3wKUx3JtTjvSOeN65FtxtECQ6MShMltsSKnMPVvCm27nai1dG
         RRQ4/g1cCmgbSJtv7BpnMiQPKmlSowPn/6zhrne4DffDDvCH2dmNq8h4mdmf4e5XtoYw
         sLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723137493; x=1723742293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bm+7EpRnlnQ2hj516+ZMFRLx/ir/OPRTVmLMCWHFcSM=;
        b=kxG6HCd8R0TOM2l7koKqA8xppjoCDatiSbSdHRfi9GBa6yxuWhAEvFZ2sNrA+ON7bp
         u2dzW5Ba63rUgnjkUoo36LoSzWe0zH9UFWrka60ykZHiRFW6kxW3M8hOSzXj+4efRKp+
         C6JulwQlm+7PRekiPdCKV69mNTcBkI4gXkPt3ExoHNpnQID91zPmiQPgawPDxSAdUXaE
         t1ov3le9+T3fv1p7KSrjT7I4HRbSK74PLIrBV2FllzJfN7PVxx0Ob35KlzxpRxfWRPwr
         bgwRlsuXvBwDKpPs8zm6kTJmWIHn8Dt0mAKtKeodf53cdFnFbGlRfh4PcuUWa/AHfPzb
         8vFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmPJnimCKi95H8efDimWD58fY2JISmBECoLVSFAMFZhzz5AQKsUohn06F9rJHI71QPsLAIq9IHWJqgrvYvwly7cw46E8Z8k1L3rh9/
X-Gm-Message-State: AOJu0YwjOMba3lUufwrFFVgog4ijQPcT4j44S9SnKj8pXZ+trmfCVqZ5
	WFOVleJYe1Pjhflgx5G/SveOytVlxFsUAcQ5F2T+rTuNKBGO7ordzvAQ9npXXYx/OPnDUNVeie0
	o8/lHrpf2R8vraM1aWb7QOcNbWoUFLMlSgnki
X-Google-Smtp-Source: AGHT+IFX49a2OF/Tc9efpcO9wHBlC2TllxQpsOJeLgpePzN2WzsXhYz7AipyJBG+1Flp5wutlQjnl3zlIsiZq3pi7Mc=
X-Received: by 2002:a05:6512:1113:b0:52f:cd03:a84a with SMTP id
 2adb3069b0e04-530e58768c7mr2426138e87.39.1723137492346; Thu, 08 Aug 2024
 10:18:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808154237.220029-1-pasha.tatashin@soleen.com> <20240808154237.220029-2-pasha.tatashin@soleen.com>
In-Reply-To: <20240808154237.220029-2-pasha.tatashin@soleen.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 8 Aug 2024 10:17:34 -0700
Message-ID: <CAJD7tkazuUKaSv_S+wQ_PGSJML=0-kw1VKFmnqsDjVenBoO--g@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] mm: update the memmap stat before page is freed
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-cxl@vger.kernel.org, cerasuolodomenico@gmail.com, 
	hannes@cmpxchg.org, j.granados@samsung.com, lizhijian@fujitsu.com, 
	muchun.song@linux.dev, nphamcs@gmail.com, rientjes@google.com, 
	rppt@kernel.org, souravpanda@google.com, vbabka@suse.cz, willy@infradead.org, 
	dan.j.williams@intel.com, yi.zhang@redhat.com, alison.schofield@intel.com, 
	david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 8:42=E2=80=AFAM Pasha Tatashin <pasha.tatashin@solee=
n.com> wrote:
>
> It is more logical to update the stat before the page is freed, to avoid
> use after free scenarios.
>
> Fixes: 15995a352474 ("mm: report per-page metadata information")
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  mm/hugetlb_vmemmap.c | 4 ++--
>  mm/page_ext.c        | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 829112b0a914..fa83a7b38199 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -185,11 +185,11 @@ static int vmemmap_remap_range(unsigned long start,=
 unsigned long end,
>  static inline void free_vmemmap_page(struct page *page)
>  {
>         if (PageReserved(page)) {
> -               free_bootmem_page(page);
>                 mod_node_page_state(page_pgdat(page), NR_MEMMAP_BOOT, -1)=
;
> +               free_bootmem_page(page);
>         } else {
> -               __free_page(page);
>                 mod_node_page_state(page_pgdat(page), NR_MEMMAP, -1);
> +               __free_page(page);
>         }
>  }
>
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index c191e490c401..962d45eee1f8 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -330,18 +330,18 @@ static void free_page_ext(void *addr)
>         if (is_vmalloc_addr(addr)) {
>                 page =3D vmalloc_to_page(addr);
>                 pgdat =3D page_pgdat(page);
> +               mod_node_page_state(pgdat, NR_MEMMAP,
> +                                   -1L * (DIV_ROUND_UP(table_size, PAGE_=
SIZE)));
>                 vfree(addr);
>         } else {
>                 page =3D virt_to_page(addr);
>                 pgdat =3D page_pgdat(page);
> +               mod_node_page_state(pgdat, NR_MEMMAP,
> +                                   -1L * (DIV_ROUND_UP(table_size, PAGE_=
SIZE)));
>                 BUG_ON(PageReserved(page));
>                 kmemleak_free(addr);
>                 free_pages_exact(addr, table_size);
>         }
> -
> -       mod_node_page_state(pgdat, NR_MEMMAP,
> -                           -1L * (DIV_ROUND_UP(table_size, PAGE_SIZE)));
> -
>  }
>
>  static void __free_page_ext(unsigned long pfn)
> --
> 2.46.0.76.ge559c4bf1a-goog
>

