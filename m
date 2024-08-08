Return-Path: <linux-kernel+bounces-279933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7858994C390
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F33291F28B34
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFDA191487;
	Thu,  8 Aug 2024 17:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t1PmqmKN"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898C1189B8D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723137699; cv=none; b=gETw8xdNtjgFqn0MQ8JoPYTari9XY4HJanbdPSe7iSJhDxJ44ugB+24hAAEiEMlzUrm159X9HJtftQ3gR99An/qSXjKXQESQkzS9bwvz7boE6k3crwGzXLsLnXGUqZQXwdcuyjgIgrGTbFEnf+vfe2dpIbAU3Iok/O3H2P740yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723137699; c=relaxed/simple;
	bh=6rccBjYrdDcCBh+uD78jedJaES1tCnAgVwi+tZqYrEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oHiOpIV8YIkHW2RWSWh8PyAfHLRSDtaktUV6l4bq/YN2JKBBeiIi2ZggkOSdyydJfdx30iW93pJykdM5Ve9WdrwGZao14+SRVHpVL15dGPKHFFC1aqkv5Rk0zi96WkrjMshfM1mYqZ5AiD+iB0iGskc+QbkmvMcz0NMBmwBNfvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t1PmqmKN; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5d5af743b8fso690814eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 10:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723137695; x=1723742495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykejiShmlIyH6GSki6xazKbyZJHJvCh1LR7fy8y1lyQ=;
        b=t1PmqmKN47r1mVB1Dyf9DKhOVYmm3k2MLs8mjKFlDhtM++ua1vPYG4ZQ70wTvtxhMG
         XXsJ09/qEF9axsaz7qcfUS6HtN9VVp90Ab8gfK5GWiAM9OOw9/aHFdb8oT8ogzoi3pTS
         E3HRo7upHWQ+jDYMFiGUHrlCdbi9GF7PaXiFPR7QwYNbWlJnvTZcdnqhpvhfxx+hwQVm
         Dz0Q9+2wnCSyB8bWSQPhrKqM8Yk3NWpt6nKfUaGdK0u6KwKEDX5hjr15EJVUzUV3TZEo
         T3GMC3uMdgZ20qKJ/e2eRcE8K0GJwfG+Eg3xLN44Z9S2JPCZRWsxCBITXnhaTmdPl0RG
         TLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723137695; x=1723742495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykejiShmlIyH6GSki6xazKbyZJHJvCh1LR7fy8y1lyQ=;
        b=IlXDgQP5Su8BgECnWFUZggV7A5nfbOxd9fxOkl8rIew1LxbJ3/IpIxRTs9cpAD/gYV
         vpPpmvKf27VY/n0iZvVID5HDBIbQ/vX0XKcbmFpaV8xNKly2QF4mM+obMbxmimYDXcDV
         fgzT05w9k5tToi+IWXP3a0Qn6dpzU5HYIN6jZ+9l4f7GjjZX2JLQn8wIMVUcpRqiXjUQ
         9TpqF1idXg6YmKqxH2ZmiUHWx+4ni4pf6My9PaZoJRyeJXUxP7iyw5ROdcdTXZM3HPG/
         wdNFP8nZ5+CKI3uZU7F7+PlL2027r0Udxv5WYxz3E4WlY7NOm2ynj7ONKZuy/nTJQgPp
         +2zw==
X-Forwarded-Encrypted: i=1; AJvYcCVdmF028Ey8YvWyhjalzQ+S1sxKlbPmDSqI7hGfHohIyjspCOssABrWgtYzsaC8fgYLWI8TdNJqUHQNqJEzFJ/cw/qQu88CZmXS9AYU
X-Gm-Message-State: AOJu0YwvKG2vlbr/uxWpyaik8yAjgTRtvN+G7Om8Z6fy1jF5El6HM/Lw
	XSAH9UZW8F70qJsIwjmcI3/XADYJo/DG+D0/oDoNQT4YKsl6KuZJxsjYOiTfHOWaA3Ot/S9xp4+
	cmd49DO7NEre92gu9TPQH0xs7mDDSAaLqY7ZX
X-Google-Smtp-Source: AGHT+IFL88mjWQ2Zggrwbd607XFMRGP1XRGTL3dSoaDAXad6oVRymc9qOzsbgGNM2EuGuB6XKcuRs75CW9Ih+Pzinbg=
X-Received: by 2002:a05:6359:4c91:b0:1ac:f668:9920 with SMTP id
 e5c5f4694b2df-1b15cfe3845mr285813155d.19.1723137695238; Thu, 08 Aug 2024
 10:21:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808154237.220029-1-pasha.tatashin@soleen.com>
 <20240808154237.220029-2-pasha.tatashin@soleen.com> <CAJD7tkazuUKaSv_S+wQ_PGSJML=0-kw1VKFmnqsDjVenBoO--g@mail.gmail.com>
In-Reply-To: <CAJD7tkazuUKaSv_S+wQ_PGSJML=0-kw1VKFmnqsDjVenBoO--g@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 8 Aug 2024 10:20:54 -0700
Message-ID: <CAJD7tkZarKQ5kN26r3hUQUvj-mWZ0fDMw+yPuSdrUU+XtTxAWw@mail.gmail.com>
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

On Thu, Aug 8, 2024 at 10:17=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Thu, Aug 8, 2024 at 8:42=E2=80=AFAM Pasha Tatashin <pasha.tatashin@sol=
een.com> wrote:
> >
> > It is more logical to update the stat before the page is freed, to avoi=
d
> > use after free scenarios.
> >
> > Fixes: 15995a352474 ("mm: report per-page metadata information")
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

Actually although I think this patch is correct, it shouldn't be
needed after patch 4 because we no longer use the page or pgdat to
update the stats.

>
> > ---
> >  mm/hugetlb_vmemmap.c | 4 ++--
> >  mm/page_ext.c        | 8 ++++----
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index 829112b0a914..fa83a7b38199 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -185,11 +185,11 @@ static int vmemmap_remap_range(unsigned long star=
t, unsigned long end,
> >  static inline void free_vmemmap_page(struct page *page)
> >  {
> >         if (PageReserved(page)) {
> > -               free_bootmem_page(page);
> >                 mod_node_page_state(page_pgdat(page), NR_MEMMAP_BOOT, -=
1);
> > +               free_bootmem_page(page);
> >         } else {
> > -               __free_page(page);
> >                 mod_node_page_state(page_pgdat(page), NR_MEMMAP, -1);
> > +               __free_page(page);
> >         }
> >  }
> >
> > diff --git a/mm/page_ext.c b/mm/page_ext.c
> > index c191e490c401..962d45eee1f8 100644
> > --- a/mm/page_ext.c
> > +++ b/mm/page_ext.c
> > @@ -330,18 +330,18 @@ static void free_page_ext(void *addr)
> >         if (is_vmalloc_addr(addr)) {
> >                 page =3D vmalloc_to_page(addr);
> >                 pgdat =3D page_pgdat(page);
> > +               mod_node_page_state(pgdat, NR_MEMMAP,
> > +                                   -1L * (DIV_ROUND_UP(table_size, PAG=
E_SIZE)));
> >                 vfree(addr);
> >         } else {
> >                 page =3D virt_to_page(addr);
> >                 pgdat =3D page_pgdat(page);
> > +               mod_node_page_state(pgdat, NR_MEMMAP,
> > +                                   -1L * (DIV_ROUND_UP(table_size, PAG=
E_SIZE)));
> >                 BUG_ON(PageReserved(page));
> >                 kmemleak_free(addr);
> >                 free_pages_exact(addr, table_size);
> >         }
> > -
> > -       mod_node_page_state(pgdat, NR_MEMMAP,
> > -                           -1L * (DIV_ROUND_UP(table_size, PAGE_SIZE))=
);
> > -
> >  }
> >
> >  static void __free_page_ext(unsigned long pfn)
> > --
> > 2.46.0.76.ge559c4bf1a-goog
> >

