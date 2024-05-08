Return-Path: <linux-kernel+bounces-173792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BCC8C0569
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2761C20F66
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB20E130E3B;
	Wed,  8 May 2024 20:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GisnZyBt"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F39130ADD
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 20:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715199298; cv=none; b=O2s89jDlKK7thSuZI2rtcWfEuoDDfmXoQQDqVtt/fxsawNbFgq9HUAIgZdZBaFasiIZpALXQF5gP8auDZ3lvNMt7b6PwKypXVyZh1gizcCjWOdDX8T6Qc4QbBEasA3Fw0uOFyBznvGKJwhhvzbWs1bkJX5/qYapu8ZQHSNQk8FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715199298; c=relaxed/simple;
	bh=7Br4vDTEN5HJ2NdZBnitM2Ve143bHdbrsYP9mVP1WYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Do0t7o4n8rqbqAIjdvdHEZWK8a34d+51lA6W68YXgNOY9xSlmoluM4BteyYak1z/FIb79BLBafAQCzpzs176AGg07cqi3oUYAVipHnW7WgbNlcVvqfv3orDAVUrFazi9z678cJiJLu5E1fCbIqpoMsw3x0DXea1xw9C24PP3FNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GisnZyBt; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-de5ea7edb90so198378276.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 13:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715199293; x=1715804093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6GGfbxbSHf7A/lN3rMwiGSY9v5luUQzNgxUc7c9bjY=;
        b=GisnZyBt6MyGYOEhvc/FBNs45nOGkjUJeOpR5A9zAQUttOC1kexGQd93EXWcyNDthl
         HFcwvnNOwB/mWH0Q+sVk5Wx01MERUoREQRhJgMmC8TrDOp6gDvsRNEYWI4bcU0OXnLZ+
         pQMuPyJ9oT/PjPYNl8UH3H6Wr0w2cpeJ6iHkr1JNTE5xtphZuZ+H/JsI2jfJXnfnrawD
         lOnGGaU/SGbCpXpoxI0kBQDCr6T8aVX+PROY3PGqPSuqI+fQp7sw67SvCTsNVQNORuiJ
         xqsMr76ZUplvfZEjGrT2Il+tvAhH/T3XP6eAFyDZ474L/XMA/iUbFRzV6siNzcFzk4wJ
         7BMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715199293; x=1715804093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6GGfbxbSHf7A/lN3rMwiGSY9v5luUQzNgxUc7c9bjY=;
        b=Wa/qJqurwfatXhVrkHF9+D4APJGORsP54mXenyKy1Dgsf5xHrwS7eyzkq4R4HEucAK
         Aq805/X/FMTvfUZ/IZbMw5siQgFSzD8RZ6s4DdkHswiQtGElCiAoK9fA5dkaSWT415ZE
         R/ZllEAGFiYbqWfPBFI3BDFRLc/qg6XQbM0Wxecd5HH5F6BWzt94RbK88ZtjLU7bGWTa
         IyL/qEVqjhf6uMoXLNwgURcacm8+NetM31hYLfgt9iSGDLUoZRG717gReKbUl1ZS9RAl
         v8jzaJtkixUdFHBWsjbrRIQ31ND2WoG4+8g017+nJf3ChCdZYHrJbJzavAY6W3xJQcQ4
         Jh2w==
X-Forwarded-Encrypted: i=1; AJvYcCWUDkqcMxLsaMeCBJefTnndU0drnsPk67587eatveqoJJw3SacFaszLPyBxEHjhS5Gf/0DKF2CwMCXjUXPQ+/JxGUrKff/hrKP2N3ul
X-Gm-Message-State: AOJu0YygUohOrBwNy1uFg8Vp1EANsp4kp9XJqlN7L9jQPrgGCmTo5766
	nNKrmrRY00pKRvUjbix4nRAgwAXAsay5ojA+zuHuSZPYSpUEzl/K0cXta2yfQZLOZ01NWW339XU
	GNW3IJYgQdMvsilnwMmlD+UvcmexwZrgrYpha
X-Google-Smtp-Source: AGHT+IFVmBvGCi+oAM6+tUxDJgD4IsOcRaciEwYU8u3LzR6qQF6sa9yT2hd/T+0oQajyARE/NgoYNEJ0wyw8dxnCbww=
X-Received: by 2002:a25:bb12:0:b0:de4:627e:b556 with SMTP id
 3f1490d57ef6-debb9d89584mr3933851276.16.1715199293284; Wed, 08 May 2024
 13:14:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503183713.1557480-1-tjmercier@google.com>
 <20240506052955.GA4923@lst.de> <CABdmKX1XNTtoPTvfsJRobim8pHdDjPsKx=qVovVZDh5GEbKCfQ@mail.gmail.com>
 <20240506160244.GA16248@lst.de> <CABdmKX1n98+bw+1kewz=wdqq2Nbpaxao_Lx-Gq8oKGNUEP4ytQ@mail.gmail.com>
 <20240506161906.GA17237@lst.de> <CABdmKX3s_HnxciDA3XGM8Qj0kLY8OWENg+ifexrON4VYVbuLsA@mail.gmail.com>
 <20240507054314.GA31814@lst.de> <CABdmKX3PgcXaRUH3L7OV+POMiMd5L6pEF4fLXYPgfmQUNu_trg@mail.gmail.com>
 <Zju0JOx_ij1qH-34@arm.com>
In-Reply-To: <Zju0JOx_ij1qH-34@arm.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 8 May 2024 13:14:41 -0700
Message-ID: <CABdmKX3LANk-0ThrQ86ay5EnToM38gVH3oddBUnXq=9cmS0gCQ@mail.gmail.com>
Subject: Re: [PATCH] dma-direct: Set SG_DMA_SWIOTLB flag for dma-direct
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, isaacmanjarres@google.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 10:19=E2=80=AFAM Catalin Marinas <catalin.marinas@ar=
m.com> wrote:
>
> On Tue, May 07, 2024 at 01:07:25PM -0700, T.J. Mercier wrote:
> > On Mon, May 6, 2024 at 10:43=E2=80=AFPM Christoph Hellwig <hch@lst.de> =
wrote:
> > > On Mon, May 06, 2024 at 09:39:53AM -0700, T.J. Mercier wrote:
> > > > > You should not check, you simply must handle it by doing the prop=
er
> > > > > DMA API based ownership management.
> > > >
> > > > That doesn't really work for uncached buffers.
> > >
> > > What uncached buffers?
> >
> > For example these ones:
> > https://android.googlesource.com/kernel/common/+/refs/heads/android-mai=
nline/drivers/dma-buf/heaps/system_heap.c#141
> >
> > Vendors have their own drivers that also export uncached buffers in a
> > similar way.
>
> IIUC, you have an uncached dma buffer and you want to pass those pages
> to dma_map_sgtable() with DMA_ATTR_SKIP_CPU_SYNC since the buffer has
> already been made coherent via other means (the CPU mapping is
> uncached). The small kmalloc() bouncing gets in the way as it copies the
> data to a cached buffer but it also skips the cache maintenance because
> of DMA_ATTR_SKIP_CPU_SYNC.

Yes, that's a problem at the time of the mapping. It's also a problem
for dma_buf_{begin,end}_cpu_access calls because implementing an
uncached buffer means we want to skip dma_sync_sgtable_for_*, but that
also skips the swiotlb copy. The goal is to only let the mapping
succeed if the cache maintenance can always be skipped while also
ensuring all users have a correct view of the memory, and that doesn't
seem possible where swiotlb is involved.

> I assume Android carries these patches:

> https://lore.kernel.org/r/20201110034934.70898-8-john.stultz@linaro.org/

Correct.

> Arguably this is abusing the DMA API since DMA_ATTR_SKIP_CPU_SYNC should
> be used for subsequent mappings of buffers already mapped to device by a
> prior dma_map_*() operation. In the above patchset, the buffer is
> vmap'ed by the dma-buf heap code and DMA_ATTR_SKIP_CPU_SYNC is used on
> the first dma_map_*().
>
> Ignoring the above hacks, I think we can get in a similar situation even
> with more complex uses of the DMA API. Let's say some buffers are
> initially mapped to device with dma_map_page(), some of them being
> bounced but cache maintenance completed. A subsequent dma_map_*()
> on those pages may force a bouncing again but DMA_ATTR_SKIP_CPU_SYNC
> will avoid the cache maintenance. You are not actually sharing the
> original buffers but create separate (bounced) copies no longer coherent
> with the device.

Right, no good. The inverse of the dma_buf_begin_cpu_access problem.

> I think in general buffer sharing with multiple dma_map_*() calls on the
> same buffer and DMA_ATTR_SKIP_CPU_SYNC is incompatible with bouncing,
> irrespective of the kmalloc() minalign series. If you do this for a
> 32-bit device and one of the pages is outside the ZONE_DMA32 range,
> you'd get a similar behaviour.
>
> From the kmalloc() minumum alignment perspective, it makes sense to skip
> the bouncing if DMA_ATTR_SKIP_CPU_SYNC is passed. We also skip the
> bouncing if the direction is DMA_TO_DEVICE or the device is fully
> coherent.
>
> A completely untested patch below. It doesn't solve other problems with
> bouncing you may have with your out of tree patches and, as Christoph
> said, checking in your driver whether the DMA address is a swiotlb
> buffer is completely wrong.

This is where I must be missing something. Is the main opposition that
the *driver* is checking for swiotlb use (instead of inside the DMA
API)? Because it sounds like we agree it's a bad idea to attempt
bouncing + DMA_ATTR_SKIP_CPU_SYNC.

This code looks like it almost gets there, but it'd still reach
swiotlb_map (instead of DMA_MAPPING_ERROR) with DMA_ATTR_SKIP_CPU_SYNC
set for force_bounce or if the dma_capable check fails.

> ---------8<------------------------
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index e4cb26f6a943..c7ff464a5f81 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -602,15 +602,16 @@ static bool dev_is_untrusted(struct device *dev)
>  }
>
>  static bool dev_use_swiotlb(struct device *dev, size_t size,
> -                           enum dma_data_direction dir)
> +                           enum dma_data_direction dir, unsigned long at=
trs)
>  {
>         return IS_ENABLED(CONFIG_SWIOTLB) &&
>                 (dev_is_untrusted(dev) ||
> -                dma_kmalloc_needs_bounce(dev, size, dir));
> +                dma_kmalloc_needs_bounce(dev, size, dir, attrs));
>  }
>
>  static bool dev_use_sg_swiotlb(struct device *dev, struct scatterlist *s=
g,
> -                              int nents, enum dma_data_direction dir)
> +                              int nents, enum dma_data_direction dir,
> +                              unsigned long attrs)
>  {
>         struct scatterlist *s;
>         int i;
> @@ -626,7 +627,7 @@ static bool dev_use_sg_swiotlb(struct device *dev, st=
ruct scatterlist *sg,
>          * direction, check the individual lengths in the sg list. If any
>          * element is deemed unsafe, use the swiotlb for bouncing.
>          */
> -       if (!dma_kmalloc_safe(dev, dir)) {
> +       if (!dma_kmalloc_safe(dev, dir, attrs)) {
>                 for_each_sg(sg, s, nents, i)
>                         if (!dma_kmalloc_size_aligned(s->length))
>                                 return true;
> @@ -1076,7 +1077,7 @@ static void iommu_dma_sync_single_for_cpu(struct de=
vice *dev,
>  {
>         phys_addr_t phys;
>
> -       if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev, size, dir))
> +       if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev, size, dir, =
0))
>                 return;
>
>         phys =3D iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle=
);
> @@ -1092,7 +1093,7 @@ static void iommu_dma_sync_single_for_device(struct=
 device *dev,
>  {
>         phys_addr_t phys;
>
> -       if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev, size, dir))
> +       if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev, size, dir, =
0))
>                 return;
>
>         phys =3D iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle=
);
> @@ -1152,7 +1153,7 @@ static dma_addr_t iommu_dma_map_page(struct device =
*dev, struct page *page,
>          * If both the physical buffer start address and size are
>          * page aligned, we don't need to use a bounce page.
>          */
> -       if (dev_use_swiotlb(dev, size, dir) &&
> +       if (dev_use_swiotlb(dev, size, dir, attrs) &&
>             iova_offset(iovad, phys | size)) {
>                 void *padding_start;
>                 size_t padding_size, aligned_size;
> @@ -1369,7 +1370,7 @@ static int iommu_dma_map_sg(struct device *dev, str=
uct scatterlist *sg,
>                         goto out;
>         }
>
> -       if (dev_use_sg_swiotlb(dev, sg, nents, dir))
> +       if (dev_use_sg_swiotlb(dev, sg, nents, dir, attrs))
>                 return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attr=
s);
>
>         if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 4abc60f04209..857a460e40f0 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -277,7 +277,8 @@ static inline bool dev_is_dma_coherent(struct device =
*dev)
>   * Check whether potential kmalloc() buffers are safe for non-coherent D=
MA.
>   */
>  static inline bool dma_kmalloc_safe(struct device *dev,
> -                                   enum dma_data_direction dir)
> +                                   enum dma_data_direction dir,
> +                                   unsigned long attrs)
>  {
>         /*
>          * If DMA bouncing of kmalloc() buffers is disabled, the kmalloc(=
)
> @@ -288,10 +289,12 @@ static inline bool dma_kmalloc_safe(struct device *=
dev,
>
>         /*
>          * kmalloc() buffers are DMA-safe irrespective of size if the dev=
ice
> -        * is coherent or the direction is DMA_TO_DEVICE (non-desctructiv=
e
> -        * cache maintenance and benign cache line evictions).
> +        * is coherent, the direction is DMA_TO_DEVICE (non-desctructive
> +        * cache maintenance and benign cache line evictions) or the
> +        * attributes require no cache maintenance.
>          */
> -       if (dev_is_dma_coherent(dev) || dir =3D=3D DMA_TO_DEVICE)
> +       if (dev_is_dma_coherent(dev) || dir =3D=3D DMA_TO_DEVICE ||
> +           attrs & DMA_ATTR_SKIP_CPU_SYNC)
>                 return true;
>
>         return false;
> @@ -328,9 +331,11 @@ static inline bool dma_kmalloc_size_aligned(size_t s=
ize)
>   * in the kernel.
>   */
>  static inline bool dma_kmalloc_needs_bounce(struct device *dev, size_t s=
ize,
> -                                           enum dma_data_direction dir)
> +                                           enum dma_data_direction dir,
> +                                           unsigned long attrs)
>  {
> -       return !dma_kmalloc_safe(dev, dir) && !dma_kmalloc_size_aligned(s=
ize);
> +       return !dma_kmalloc_safe(dev, dir, attrs) &&
> +               !dma_kmalloc_size_aligned(size);
>  }
>
>  void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_ha=
ndle,
> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> index 18d346118fe8..c2d31a67719e 100644
> --- a/kernel/dma/direct.h
> +++ b/kernel/dma/direct.h
> @@ -96,7 +96,7 @@ static inline dma_addr_t dma_direct_map_page(struct dev=
ice *dev,
>         }
>
>         if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||
> -           dma_kmalloc_needs_bounce(dev, size, dir)) {
> +           dma_kmalloc_needs_bounce(dev, size, dir, attrs)) {
>                 if (is_pci_p2pdma_page(page))
>                         return DMA_MAPPING_ERROR;
>                 if (is_swiotlb_active(dev))
>
> --
> Catalin

