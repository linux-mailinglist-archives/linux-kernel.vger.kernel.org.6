Return-Path: <linux-kernel+bounces-261567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F30DA93B91F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 00:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6959D1F23339
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4937513C9CB;
	Wed, 24 Jul 2024 22:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M27iGQcw"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0488D13C9B3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 22:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721859838; cv=none; b=MeNALLUva0JsroxtkwIoUWx091QI/B1UiBCF780GnmNlYvlUOF0alauepFLXE35ZsEJPKgT3NwDXrWwLg/aahQQgnF2h6NozwJnHH9VMiRMC6rSc889+f11KE8ZnOxptaL9drHpb2ZT4TwSCdTStEMFG15gw7CUaZ2bS2WmNnw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721859838; c=relaxed/simple;
	bh=b9JSOycFG4+7w2ohl/swdPdTrncxhXijcCaKC74z9gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=og/2+XwxmFNXg3qBJrn/vLLYWQCm7prMZ7vY+i9oZyay9cgiKkdVSSeYlBLmY6suZfkWJZtAOd7rau3I8FVqSBwT4t3vllkEGTsX+0jSUJHss3nm/m5AUjQlonAk6zp0RUK/VYhroNgDkJ8mWnCs17B5oxF5i8CxkSRwWKlStD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M27iGQcw; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-492a8333cb1so96503137.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 15:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721859836; x=1722464636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m61mAVKn3AwPDI9CWB/tPJk6iX/A6Vv9n5L4Vxpml84=;
        b=M27iGQcw72gmqViRBZSidtVeSjpCZUAllpfJZ57t1mtw1S4qaYQr2t2vXOuucuDnTv
         V2YucScXWGw8fHVlLeSwrx/rI3oLjwYriWWvtsbiCiatYxWHI2d8gV7abnCIZLtQigz5
         7PPpYZ9Rs3nDOHzp2Qg1uLrHF61UCYA04rxIgfqhMrEjxl56+SOTlntptfaHy4B224lm
         eS/2uGvebGbUcNLPd+MpwHFhIvfdXMEdScM74BrkATUgZqsaS3eF39etcNHsE1KZvZGw
         ExV1nfxH3VjhcSl1WGmB22hmeib78eRuDAmpto1FnnGvCFh76A2ud7ZLbP4nPcX42R+b
         +GXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721859836; x=1722464636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m61mAVKn3AwPDI9CWB/tPJk6iX/A6Vv9n5L4Vxpml84=;
        b=FPSvkabqPJ6lEXoOgV4Ukp0zdKnzsiXLQNBDQOia7alzXbT377X6NJeYD0+2Dj1wvC
         uwlnfBUXUUUdiLs5vuj2hvxfBF0uihKaIsJGyLWQeRFttz7be7K2IwqUZnBD0NIMd5U1
         q+WpOyn4Agz6PsW3vWai2gqpbah7tvD1wiBpSEFpb/wCJVZosWtRvWAJYN8R8pOHX1Y/
         h1snwZ7rekeqY4/GYy8yuAhodFvJnttTN2Q18O3IjNe0AL56UDnnPYoWwoGUt2ocov+B
         HluV8e/p/7or1bYQWwfUyLY3Nhh+BCJNVrE6a9qX5DviXYC8tejdIC6WJV8NeJ3/yRa+
         H4CA==
X-Forwarded-Encrypted: i=1; AJvYcCUo2tyhvtDQwrhymrjbxP/JZnDeVrNj3GG8l2Q2Qj5LZERvCtDYIn0QaBAEWB1tfewiDIccTT+6qqmAw7UFNqImxaimeXDGwYEDQ5vE
X-Gm-Message-State: AOJu0Yz4a6chp1qvXOVbuQS2Lzi7lDTQlNpi7L3V4kOk7i+bYlxfhR2C
	V0vE/uaQE/XULnxlarqmcu9XORZnXk/stDpRkhH3aRS8Gpzn3+hGgeoCigXr0RtgLjTiqPmyY5G
	OImhZ/e/hqbR/wMq7SrYaYbSSiF4=
X-Google-Smtp-Source: AGHT+IHPCHTpD67fhU8YeC5g3nuqpNf6O1JJeWUgRPDiBoOEgIIpIiA912pdlAJJQA2+7B4D1/pQuPvbWliiRPjqA7g=
X-Received: by 2002:a05:6102:15ab:b0:493:bcc9:b03b with SMTP id
 ada2fe7eead31-493d6400969mr1817114137.3.1721859835650; Wed, 24 Jul 2024
 15:23:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724181916.31776-1-hailong.liu@oppo.com>
In-Reply-To: <20240724181916.31776-1-hailong.liu@oppo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 25 Jul 2024 10:23:44 +1200
Message-ID: <CAGsJ_4xNuDroYRydFj6MFey2q6WG=bCp-d8fBOXb47srYZJfRg@mail.gmail.com>
Subject: Re: [RFC PATCH v1] mm/vmalloc: fix incorrect __vmap_pages_range_noflush()
 if vm_area_alloc_pages() from high order fallback to order0
To: hailong.liu@oppo.com
Cc: Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes <lstoakes@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Michal Hocko <mhocko@suse.com>, "Tangquan . Zheng" <zhengtangquan@oppo.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 6:19=E2=80=AFAM <hailong.liu@oppo.com> wrote:
>
> From: "Hailong.Liu" <hailong.liu@oppo.com>
>
> The scenario where the issue occurs is as follows:
> CONFIG: vmap_allow_huge =3D true && 2M is for PMD_SIZE
> kvmalloc(2M)
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
> Fix it by introducing VM_AREA_ALLOC_PAGES_FALLBACK in page->private if fa=
llback to 0.
> Fixes: e9c3cda4d86e ("mm, vmalloc: fix high order __GFP_NOFAIL allocation=
s")
>
> CC: Barry Song <21cnbao@gmail.com>
> Reported-by: Tangquan.Zheng <zhengtangquan@oppo.com>
> Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
> ---
>  mm/vmalloc.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 03c78fae06f3..b35dfd3eeee3 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -75,6 +75,8 @@ early_param("nohugevmalloc", set_nohugevmalloc);
>  static const bool vmap_allow_huge =3D false;
>  #endif /* CONFIG_HAVE_ARCH_HUGE_VMALLOC */
>
> +#define VM_AREA_ALLOC_PAGES_FALLBACK 0x1
> +
>  bool is_vmalloc_addr(const void *x)
>  {
>         unsigned long addr =3D (unsigned long)kasan_reset_tag(x);
> @@ -604,8 +606,13 @@ int __vmap_pages_range_noflush(unsigned long addr, u=
nsigned long end,
>         WARN_ON(page_shift < PAGE_SHIFT);
>
>         if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC) ||
> -                       page_shift =3D=3D PAGE_SHIFT)
> -               return vmap_small_pages_range_noflush(addr, end, prot, pa=
ges);
> +                       page_shift =3D=3D PAGE_SHIFT ||
> +                       page_private(pages[0]) =3D=3D VM_AREA_ALLOC_PAGES=
_FALLBACK) {
> +               int ret =3D vmap_small_pages_range_noflush(addr, end, pro=
t, pages);
> +
> +               set_page_private(pages[0], 0);
> +               return ret;
> +       }

we could have more than one *serious* bug here? do we also need the below
if ((end -  start) % PMD_SIZE) !=3D 0)  ? no ?

int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
                pgprot_t prot, struct page **pages, unsigned int page_shift=
)
{
        unsigned int i, nr =3D (end - addr) >> PAGE_SHIFT;

        WARN_ON(page_shift < PAGE_SHIFT);

        if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC) ||
                        page_shift =3D=3D PAGE_SHIFT)
                return vmap_small_pages_range_noflush(addr, end, prot, page=
s);

        for (i =3D 0; i < nr; i +=3D 1U << (page_shift - PAGE_SHIFT)) {
                int err;

                err =3D vmap_range_noflush(addr, addr + (1UL << page_shift)=
,
                                        page_to_phys(pages[i]), prot,
                                        page_shift);
                if (err)
                        return err;

                addr +=3D 1UL << page_shift;
        }

+        if (addr < end)
+                return vmap_small_pages_range_noflush(addr, end,
prot, pages + i);

        return 0;
}

>
>         for (i =3D 0; i < nr; i +=3D 1U << (page_shift - PAGE_SHIFT)) {
>                 int err;
> @@ -3583,6 +3590,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>
>                         /* fall back to the zero order allocations */
>                         alloc_gfp |=3D __GFP_NOFAIL;
> +                       fallback =3D true;
>                         order =3D 0;
>                         continue;
>                 }
> @@ -3608,6 +3616,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>                 cond_resched();
>                 nr_allocated +=3D 1U << order;
>         }
> +       if (nr_allocated && fallback)
> +               set_page_private(pages[0], VM_AREA_ALLOC_PAGES_FALLBACK);
>
>         return nr_allocated;
>  }
> --
> 2.34.1
>

