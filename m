Return-Path: <linux-kernel+bounces-261816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4CC93BC7E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A0C28231C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 06:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC9516C69D;
	Thu, 25 Jul 2024 06:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9PFecTf"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441ED29CF7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 06:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721888507; cv=none; b=VV5RzE/MPcynzLItcJLQP29G2JZBaR2ffAj1RRUwo2NSbNUAGehd5Ra7LoAOw6DZaBraU/oBT5Lp7/Lw2+ot18XuuTbcQ6bAwQw0dBuveaIgoT3aG+8NQZSOG/KfSQ2j77Hbp9dajLuCytUzHFIHIn8xnofBi3CWjYnnP6Dc80U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721888507; c=relaxed/simple;
	bh=unE0ruGiBOzaCLLUKL3SbhOOIXj1NOsn9amsLzYlX9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q80p5Q9AAz9/HqMZog/rVoM3YxhBbmp6J65HTJ0gvW4HbIeRQxHOnQNpNe5fT808eTV948JDxvPOLU443TFmn77/SzfGvpjDwRhYnhIR9JTZGV/Kjz3hECmFZZbUSq7s+GXKQHW/LMOGIcsw+vE5QU4ZQ8no4gLWJe2NPFOTFMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9PFecTf; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-823423e3accso156105241.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 23:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721888505; x=1722493305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2La7RJ3KD31zcZCBzxNjyk9Uud9cTzRN8iK2bDflsug=;
        b=a9PFecTfaojsOJcRtInLOqNDZAge1r/fPngTsrWO3WXZqyvKC+oB7l7Q8HDuwl/59t
         0CwB+CVGuI+x1jWQnsdwjBeuQBL17XP5KJ+XMh8cTpz3Ig65pnA1ZNTpM/XC8nPkPM45
         N2Lfu+LfLzzZHxZ64WIs7vaYpX/zx3kWrFFBynPChu4k35jIVwPlldM9t2aT5+5uNmJf
         7AJFw5ynRmUV1ocGYyJlSCkhJnrj2WIchwzvGJDst4KgQPtoZTdiM669pJt2OEUVqRh0
         eIJ0emji8E6OQESiRAlgnyjieJ6U4ydvLL09puAXwjozVQXL5WXsvdnj+TrmvBBODGvj
         gyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721888505; x=1722493305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2La7RJ3KD31zcZCBzxNjyk9Uud9cTzRN8iK2bDflsug=;
        b=do/oY3PWuHuEl6owJb69/j1kx+Lqu/q1gWbXDuwplTLgBVHz+FgWvgx8uRJR0ImiA1
         mQtK9tQRj327xu/VQMvoWsxRMTOMdKsY2jfAiTF/uCiTMeb54QdbUav7j5pWfhrda8wr
         TzGaM6PrTzKfkWXnGY5gW9cGBziRg42kYxY47Y5GVxq54KKfZzMVBxOoQH9FwUoCFDXc
         VKkKhZkNHvZ+MxhLgPztnG9AKSsNvIUYUqg4eVRMGWBEmpSJ731vzvZiUyUIr/59+pv3
         1L67+dsaJVbE5kZvzALfUCU1CQ6eqz1rSsPrsDZBGr23yxsEY7GwKAoK3rbby2nzEAmN
         A33g==
X-Forwarded-Encrypted: i=1; AJvYcCVHc/W5CDN3k+lvh6bZXLjWZ4ygUA2gJrBz0x+NK+WkYzUSeXrRJ5DnUZxP2hvbb9WfWMPO8WYrkqXKmShbiFrphLjVek/LvQhd3lxO
X-Gm-Message-State: AOJu0YznKEHdLJL9u7oK8TWbvZvs/l+C4ofbPDvIOh3TL08w0SFlEetR
	MSPnvMy4TW3v6p1bd786eQ+DpAokNCwYcqcfwoxWSO+p54XbhC7WDoZ/RE3lVgSogHrfG6iyJ+E
	idq2wYSUcuEqXj8lVa/nvF4XS0ww=
X-Google-Smtp-Source: AGHT+IGzG8S0IZ8DeAe68Qj/KPU3jWFfxLBHEh6bC5AJ78nHUFCdhbn2nxYKEiwB9QB5kGDLDQ3vNJ+00vPru+ex/38=
X-Received: by 2002:a05:6102:4b89:b0:493:bf46:7f00 with SMTP id
 ada2fe7eead31-493d6400622mr2942648137.5.1721888504973; Wed, 24 Jul 2024
 23:21:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725035318.471-1-hailong.liu@oppo.com>
In-Reply-To: <20240725035318.471-1-hailong.liu@oppo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 25 Jul 2024 18:21:33 +1200
Message-ID: <CAGsJ_4zWsh50Pzp0ntskT=eyfStALxD5BMNdWFrYJewrrx7V5Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2] mm/vmalloc: fix incorrect __vmap_pages_range_noflush()
 if vm_area_alloc_pages() from high order fallback to order0
To: hailong.liu@oppo.com
Cc: Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes <lstoakes@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Michal Hocko <mhocko@suse.com>, Baoquan He <bhe@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	"Tangquan . Zheng" <zhengtangquan@oppo.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 3:53=E2=80=AFPM <hailong.liu@oppo.com> wrote:
>
> From: "Hailong.Liu" <hailong.liu@oppo.com>
>
> The scenario where the issue occurs is as follows:
> CONFIG: vmap_allow_huge =3D true && 2M is for PMD_SIZE
> kvmalloc(2M, __GFP_NOFAIL|GFP_XXX)
>     __vmalloc_node_range(vm_flags=3DVM_ALLOW_HUGE_VMAP)
>         vm_area_alloc_pages(order=3D9) --->allocs order9 failed and fallb=
ack to order0
>                                         and phys_addr is aligned with PMD=
_SIZE
>             vmap_pages_range
>                 vmap_pages_range_noflush
>                     __vmap_pages_range_noflush(page_shift =3D 21) ----> i=
ncorrect vmap *huge* here
>
> In fact, as long as page_shift is not equal to PAGE_SHIFT, there
> might be issues with the __vmap_pages_range_noflush().
>
> The patch also remove VM_ALLOW_HUGE_VMAP in kvmalloc_node(), There
> are several reasons for this:
> - This increases memory footprint because ALIGNMENT.
> - This increases the likelihood of kvmalloc allocation failures.
> - Without this it fixes the origin issue of kvmalloc with __GFP_NOFAIL ma=
y return NULL.
> Besides if drivers want to vmap huge, user vmalloc_huge instead.
>
> Fix it by disabling fallback and remove VM_ALLOW_HUGE_VMAP in
> kvmalloc_node().
> Fixes: e9c3cda4d86e ("mm, vmalloc: fix high order __GFP_NOFAIL allocation=
s")
>
> CC: Barry Song <21cnbao@gmail.com>
> CC: Baoquan He <bhe@redhat.com>
> CC: Matthew Wilcox <willy@infradead.org>
> Reported-by: Tangquan.Zheng <zhengtangquan@oppo.com>
> Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>

The implementation of HUGE_VMAP appears to be quite disorganized.
A major change is needed.

1. when allocating 2.1MB kvmalloc, we shouldn't allocate 4MB memory, which
is now done by HUGE_VMAP. This is even worse than PMD-mapped THP for
userspace. We don't even do this for THP. vmap could be done by 1PMD map
+ 0.1MB PTE mapping instead.

2. We need to allow fallback to order-0 pages if we're unable to allocate 2=
MB.
In this case, we should perform PMD/PTE mapping based on how the pages
are acquired, rather than assuming they always form contiguous 2MB blocks.

3. Memory is entirely corrupted after Michael's "mm, vmalloc: fix high orde=
r
__GFP_NOFAIL allocations". but without it, forcing 2MB  allocation was
making OOM.

> ---
>  mm/util.c    | 2 +-
>  mm/vmalloc.c | 9 ---------
>  2 files changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/mm/util.c b/mm/util.c
> index 669397235787..b23133b738cf 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -657,7 +657,7 @@ void *kvmalloc_node(size_t size, gfp_t flags, int nod=
e)
>          * protection games.
>          */
>         return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
> -                       flags, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
> +                       flags, PAGE_KERNEL, 0,
>                         node, __builtin_return_address(0));

I'd vote +1 for this. we don't want to waste memory, for example, wasting
1.9MB memory while allocating 2.1MB kvmalloc. but this should be a separate
patch.

>  }
>  EXPORT_SYMBOL(kvmalloc_node);
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 03c78fae06f3..1914768f473e 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3577,15 +3577,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>                         page =3D alloc_pages(alloc_gfp, order);
>                 else
>                         page =3D alloc_pages_node(nid, alloc_gfp, order);
> -               if (unlikely(!page)) {
> -                       if (!nofail)
> -                               break;
> -
> -                       /* fall back to the zero order allocations */
> -                       alloc_gfp |=3D __GFP_NOFAIL;
> -                       order =3D 0;
> -                       continue;
> -               }
>
>                 /*
>                  * Higher order allocations must be able to be treated as
> --
> After 1) I check the code and I can't find a resonable band-aid to fix
> this. so the v2 patch works but ugly. Glad to hear a better solution :)

This is still incorrect because it undoes Michal's work. We also need to br=
eak
the loop if (!nofail), which you're currently omitting.

To avoid reverting Michal's work, the simplest "fix" would be,

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index caf032f0bd69..0011ca30df1c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3775,7 +3775,7 @@ void *__vmalloc_node_range_noprof(unsigned long
size, unsigned long align,
                return NULL;
        }

-       if (vmap_allow_huge && (vm_flags & VM_ALLOW_HUGE_VMAP)) {
+       if (vmap_allow_huge && (vm_flags & VM_ALLOW_HUGE_VMAP) &
!(gfp_mask & __GFP_NOFAIL)) {
                unsigned long size_per_node;

                /*
>
> [1] https://lore.kernel.org/lkml/20240724182827.nlgdckimtg2gwns5@oppo.com=
/
> 2.34.1

Thanks
Barry

