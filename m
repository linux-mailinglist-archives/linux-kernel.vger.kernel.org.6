Return-Path: <linux-kernel+bounces-259196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55566939276
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C073A1F22A46
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F8416E877;
	Mon, 22 Jul 2024 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gUjKeVJU"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123D82907
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 16:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721665512; cv=none; b=OQBae6a9/pXa71HAnR7wyO89Va7n18USrgRX1fItD1uZ5Nodk8Lu8KKBOIAdFADCEbCVzw9tboMVPj3IXpZ9mgBQp9InCgFQZpgCP75Zf+xRaIhtyAfA3u1sf/WvuU7Nx9pw0Tn71tMOuCkyIEZNKcKxmTvSuG/HR21xIIramOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721665512; c=relaxed/simple;
	bh=GBQkE4RpYbJLCxbAR1D+7QxOP5nEcGeUMVdv7XJmYQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+mvDOMGzJIkpIEvqdxhOvlSP971fdOm55P7z77ZDGND2Hf1Dx2HcI90aGbaGUdhuUfhU0lw7a9ss0IZXi7h9dm1rjQex5qnrPoM6no3c9YtltaNxh/7dguycFfOc/6isp6c0NRyurgl4tRok0dvBht34hRPPDGEVlfLCGI65+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gUjKeVJU; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-827113c1fb4so956062241.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721665510; x=1722270310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syTpRGvSO0E4azvLrelw/wgCBe3qkzAwnMtnyLn6YHM=;
        b=gUjKeVJUamm8fyQZIkxNFdHaNkFKlGKa9tZaKpUv88o3yrefcjiw13ykIdyxlw9tcR
         VkPj7hSYUCzvfA/ZbPYwL2Iatx6LQ78ERIClIdq1pnjqUH7QuOGM1nGVxnNi71jAP8kS
         PnkfkbyhJWoO1ivAdvQFGhF867oyi5CA24Q4i9VtlmaCCqaKWOIdaYq4UdOfPfMy75aD
         cSRUbUrsXyueGtQCwIMm+6Mg30jjeRuMzy2bu7fzaYk1oE9kZ3Y1fTUwaUZciODf+oDF
         oATmRLXE9sXvfDZ156Mdl48327g9pHIFZ3FKbLL6gIbVTQDi8Qwgbp0TPuMeaiCYn6K4
         tzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721665510; x=1722270310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=syTpRGvSO0E4azvLrelw/wgCBe3qkzAwnMtnyLn6YHM=;
        b=DE+Ka8f0iOPtF/3EQVGodtVBqxm/xIGA9fT01iFJdwOs39I6Z+lCJ6TS44Vxj0+nRt
         /yMf750w6TE2r33lOEM5F7GNwzxcljYKjZFXuPWYNlycpmFqGWGUBlcga/VS7+Om39c/
         3A3B0fkeb6rWZzAFU5nHhTz6E3D68i0CJzPKUq48WVvzl1HkkIxLyQyEwWdI9019nt0g
         jpbtijykNvmW/GGHjaCX6XkVyCjTqF3E26hSAav5uZYYQyyTAHO3kZ1FgyCLEuM1liZ0
         BIskrmZArRE6BaZG40l7ol/YMx/v1P/4Ii75ZpNejnIy6A3bzYoBstJ3KUipS72fuBzi
         3kQg==
X-Gm-Message-State: AOJu0Yy0Pl/yfYoVQJjETUbB/UYC1+j9dlsAUPdIT8GogaNSGIwwb/C8
	avT09QdxrEZwv+lDWOPZNJ+YQyBm9xf59QWzgUN2gDmMfTkTK7fXWYpQoVoBBqcf1kpw3wVclQK
	1Wut8+xxX6unVVYpR+QrnZ45UpFqQa5L1P7gc
X-Google-Smtp-Source: AGHT+IE5qTN/DY+v/kCbF/fFfo2SFK3A/ptsmkc42cRuZJsEuIo/w7+0qz53Jr5J27nKGsBks8POfvXVBUssVCddGfs=
X-Received: by 2002:a05:6102:2d0c:b0:492:9291:503c with SMTP id
 ada2fe7eead31-49292915de7mr7165973137.7.1721665509414; Mon, 22 Jul 2024
 09:25:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709163053.2514760-1-fvdl@google.com>
In-Reply-To: <20240709163053.2514760-1-fvdl@google.com>
From: Frank van der Linden <fvdl@google.com>
Date: Mon, 22 Jul 2024 09:24:58 -0700
Message-ID: <CAPTztWbF+VLO6g=7VKk-tYHdtZ781Hbj5ucW6i8Gf9TJiiebWg@mail.gmail.com>
Subject: Re: [PATCH] mm/cma: export total and free number of pages for CMA areas
To: linux-mm@kvack.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 9:31=E2=80=AFAM Frank van der Linden <fvdl@google.co=
m> wrote:
>
> In addition to the number of allocations and releases, system
> management software may like to be aware of the size of CMA
> areas, and how many pages are available in it. This information
> is currently not available, so export it in total_page and
> available_pages, respectively.
>
> The name 'available_pages' was picked over 'free_pages' because
> 'free' implies that the pages are unused. But they might not
> be, they just haven't been used by cma_alloc
>
> The number of available pages is tracked regardless of
> CONFIG_CMA_SYSFS, allowing for a few minor shortcuts in
> the code, avoiding bitmap operations.
>
> Signed-off-by: Frank van der Linden <fvdl@google.com>
> ---
>  Documentation/ABI/testing/sysfs-kernel-mm-cma | 13 ++++++++++++
>  mm/cma.c                                      | 18 +++++++++++------
>  mm/cma.h                                      |  1 +
>  mm/cma_debug.c                                |  5 +----
>  mm/cma_sysfs.c                                | 20 +++++++++++++++++++
>  5 files changed, 47 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-cma b/Documentatio=
n/ABI/testing/sysfs-kernel-mm-cma
> index dfd755201142..aaf2a5d8b13b 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-cma
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-cma
> @@ -29,3 +29,16 @@ Date:                Feb 2024
>  Contact:       Anshuman Khandual <anshuman.khandual@arm.com>
>  Description:
>                 the number of pages CMA API succeeded to release
> +
> +What:          /sys/kernel/mm/cma/<cma-heap-name>/total_pages
> +Date:          Jun 2024
> +Contact:       Frank van der Linden <fvdl@google.com>
> +Description:
> +               The size of the CMA area in pages.
> +
> +What:          /sys/kernel/mm/cma/<cma-heap-name>/available_pages
> +Date:          Jun 2024
> +Contact:       Frank van der Linden <fvdl@google.com>
> +Description:
> +               The number of pages in the CMA area that are still
> +               available for CMA allocation.
> diff --git a/mm/cma.c b/mm/cma.c
> index 3e9724716bad..727e8c04d53a 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -86,6 +86,7 @@ static void cma_clear_bitmap(struct cma *cma, unsigned =
long pfn,
>
>         spin_lock_irqsave(&cma->lock, flags);
>         bitmap_clear(cma->bitmap, bitmap_no, bitmap_count);
> +       cma->available_count +=3D count;
>         spin_unlock_irqrestore(&cma->lock, flags);
>  }
>
> @@ -133,7 +134,7 @@ static void __init cma_activate_area(struct cma *cma)
>                         free_reserved_page(pfn_to_page(pfn));
>         }
>         totalcma_pages -=3D cma->count;
> -       cma->count =3D 0;
> +       cma->available_count =3D cma->count =3D 0;
>         pr_err("CMA area %s could not be activated\n", cma->name);
>         return;
>  }
> @@ -198,7 +199,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, ph=
ys_addr_t size,
>                 snprintf(cma->name, CMA_MAX_NAME,  "cma%d\n", cma_area_co=
unt);
>
>         cma->base_pfn =3D PFN_DOWN(base);
> -       cma->count =3D size >> PAGE_SHIFT;
> +       cma->available_count =3D cma->count =3D size >> PAGE_SHIFT;
>         cma->order_per_bit =3D order_per_bit;
>         *res_cma =3D cma;
>         cma_area_count++;
> @@ -382,7 +383,7 @@ static void cma_debug_show_areas(struct cma *cma)
>  {
>         unsigned long next_zero_bit, next_set_bit, nr_zero;
>         unsigned long start =3D 0;
> -       unsigned long nr_part, nr_total =3D 0;
> +       unsigned long nr_part;
>         unsigned long nbits =3D cma_bitmap_maxno(cma);
>
>         spin_lock_irq(&cma->lock);
> @@ -394,12 +395,12 @@ static void cma_debug_show_areas(struct cma *cma)
>                 next_set_bit =3D find_next_bit(cma->bitmap, nbits, next_z=
ero_bit);
>                 nr_zero =3D next_set_bit - next_zero_bit;
>                 nr_part =3D nr_zero << cma->order_per_bit;
> -               pr_cont("%s%lu@%lu", nr_total ? "+" : "", nr_part,
> +               pr_cont("%s%lu@%lu", start ? "+" : "", nr_part,
>                         next_zero_bit);
> -               nr_total +=3D nr_part;
>                 start =3D next_zero_bit + nr_zero;
>         }
> -       pr_cont("=3D> %lu free of %lu total pages\n", nr_total, cma->coun=
t);
> +       pr_cont("=3D> %lu free of %lu total pages\n", cma->available_coun=
t,
> +                       cma->count);
>         spin_unlock_irq(&cma->lock);
>  }
>
> @@ -446,6 +447,10 @@ struct page *cma_alloc(struct cma *cma, unsigned lon=
g count,
>
>         for (;;) {
>                 spin_lock_irq(&cma->lock);
> +               if (count > cma->available_count) {
> +                       spin_unlock_irq(&cma->lock);
> +                       break;
> +               }
>                 bitmap_no =3D bitmap_find_next_zero_area_off(cma->bitmap,
>                                 bitmap_maxno, start, bitmap_count, mask,
>                                 offset);
> @@ -454,6 +459,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long=
 count,
>                         break;
>                 }
>                 bitmap_set(cma->bitmap, bitmap_no, bitmap_count);
> +               cma->available_count -=3D count;
>                 /*
>                  * It's safe to drop the lock here. We've marked this reg=
ion for
>                  * our exclusive use. If the migration fails we will take=
 the
> diff --git a/mm/cma.h b/mm/cma.h
> index ad61cc6dd439..d111f3d51868 100644
> --- a/mm/cma.h
> +++ b/mm/cma.h
> @@ -13,6 +13,7 @@ struct cma_kobject {
>  struct cma {
>         unsigned long   base_pfn;
>         unsigned long   count;
> +       unsigned long   available_count;
>         unsigned long   *bitmap;
>         unsigned int order_per_bit; /* Order of pages represented by one =
bit */
>         spinlock_t      lock;
> diff --git a/mm/cma_debug.c b/mm/cma_debug.c
> index 602fff89b15f..89236f22230a 100644
> --- a/mm/cma_debug.c
> +++ b/mm/cma_debug.c
> @@ -34,13 +34,10 @@ DEFINE_DEBUGFS_ATTRIBUTE(cma_debugfs_fops, cma_debugf=
s_get, NULL, "%llu\n");
>  static int cma_used_get(void *data, u64 *val)
>  {
>         struct cma *cma =3D data;
> -       unsigned long used;
>
>         spin_lock_irq(&cma->lock);
> -       /* pages counter is smaller than sizeof(int) */
> -       used =3D bitmap_weight(cma->bitmap, (int)cma_bitmap_maxno(cma));
> +       *val =3D cma->count - cma->available_count;
>         spin_unlock_irq(&cma->lock);
> -       *val =3D (u64)used << cma->order_per_bit;
>
>         return 0;
>  }
> diff --git a/mm/cma_sysfs.c b/mm/cma_sysfs.c
> index f50db3973171..97acd3e5a6a5 100644
> --- a/mm/cma_sysfs.c
> +++ b/mm/cma_sysfs.c
> @@ -62,6 +62,24 @@ static ssize_t release_pages_success_show(struct kobje=
ct *kobj,
>  }
>  CMA_ATTR_RO(release_pages_success);
>
> +static ssize_t total_pages_show(struct kobject *kobj,
> +                                         struct kobj_attribute *attr, ch=
ar *buf)
> +{
> +       struct cma *cma =3D cma_from_kobj(kobj);
> +
> +       return sysfs_emit(buf, "%lu\n", cma->count);
> +}
> +CMA_ATTR_RO(total_pages);
> +
> +static ssize_t available_pages_show(struct kobject *kobj,
> +                                         struct kobj_attribute *attr, ch=
ar *buf)
> +{
> +       struct cma *cma =3D cma_from_kobj(kobj);
> +
> +       return sysfs_emit(buf, "%lu\n", cma->available_count);
> +}
> +CMA_ATTR_RO(available_pages);
> +
>  static void cma_kobj_release(struct kobject *kobj)
>  {
>         struct cma *cma =3D cma_from_kobj(kobj);
> @@ -75,6 +93,8 @@ static struct attribute *cma_attrs[] =3D {
>         &alloc_pages_success_attr.attr,
>         &alloc_pages_fail_attr.attr,
>         &release_pages_success_attr.attr,
> +       &total_pages_attr.attr,
> +       &available_pages_attr.attr,
>         NULL,
>  };
>  ATTRIBUTE_GROUPS(cma);
> --
> 2.45.2.803.g4e1b14247a-goog
>

I realize that this isn't the most exciting patch, but.. any comments? :)

- Frank

