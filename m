Return-Path: <linux-kernel+bounces-287764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37903952C53
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B397B27DA4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C2219FA91;
	Thu, 15 Aug 2024 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7dbB48J"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D8417BEA1
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723715295; cv=none; b=mbjvm0EjnDuVGaQtryP7FU8QMHdcFe73pgrSJjaWto7Y23gXSoFNSctBxnem3aFpi6AwPecgEkunn2ceS6+YPmxxJ2Zhx0UjINMKcPrDpSWl+X59RhFDMZ3MkC0JXRxfs3Aj9Mk4HxcZOlOEULZ4rjkBsgmPwuUGS1ShhiG3Mvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723715295; c=relaxed/simple;
	bh=iBgv6ccgpuFDkhkULZn4uBTY9Ymb003jdC0RjpcwTHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EnTmgLl/dKRxs2XsYlXDYd9NCozCeONdAqpi39CQTUcl0BUDEDFMBNv6x+JX3N7QdOs9Ym94ZZB1xgAvUde9al8xnVnm3cskNEzu/wqBBWS2eUN/ERnbyyk3B/7lkISQMqXF/rFlpzoaR6L1E2oJSLTGDYigZ24JHRWSehELooE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7dbB48J; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f3b8eb3df5so4451441fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 02:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723715291; x=1724320091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBU9gcRzJhq05mlSIqu8MY8RtcWNzr2r4VgvifmoQxc=;
        b=d7dbB48JuNelqkeP5dXdRK4ci29VWrfcsgNsxH5mxYIZw/w1FP4MT3NjY2XEizstEa
         7r3clFaShYweJ6ktPBzvM1wpLWvIKRgdWq2YICYFutTuPUIMOADXQVN1FWWHeWTVnoXK
         hDsGmEFCqzUuSvry20Add4aV+BomE/oBhNQ43ahaBuUXoLmwEGrhBU9w/LJicZaUJmmQ
         +SJ1L4rickQJhzJpsYu72o4MW8/7385cSNaCxAqL4VbVpcJeINEkk3/Aq41HnS2PBPQX
         +dOEucfRXrptJXqqDafPuvHZFt7lH2mLZC/on3cTPfbqA/I6HCbzp3FH0WCc8NhDYYNZ
         Fa0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723715291; x=1724320091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBU9gcRzJhq05mlSIqu8MY8RtcWNzr2r4VgvifmoQxc=;
        b=cPfq+0X1reHH/0hJticOm3G60raUbwSA/0Ovv+DejsQ7LWTngmN/P8VvWOdyFRpgrH
         R8Tv9o5GgDnHnw0iUz62FtlbuQ/jfz5BgQ4Rx8TzVBBjEQBQTBqI4bmJQXjwUHR+BwiW
         pDQl4jTs9QAkBGAL14oFcJ9CRMTqt7i6nBDxxsFRUQVvmTT11tSuxrmYNADcC0SBXT/p
         x8IXEIbBKt+eOOayJvn9w2FlxRVkffH/31q23eSMAXBS3fsJnZOX4k+CFCDlqgL8eg0N
         OEt9k1R2uB2StrXUcosurf0Kckgjr/ohzYMLr3X4Fn/Qef2j2ezKlaCp2dJyY9g6PrM9
         dekg==
X-Forwarded-Encrypted: i=1; AJvYcCXugmAEvhRqvqmFE2j1kfO93oKEpMS6czGblqkcqNgYvDt5lEFa9eLVCM146IE5DaMV+3f6qVd/izrJogeN1D64I4a615bO/zKH3zcx
X-Gm-Message-State: AOJu0YzkY9r8FIOv9/yTotxQr83jKs1EsUgLgy2t30qN8Tu9+8+dRIc+
	2Qw0OaGE0ZZ7r57L7zuVKvFLlm+id2Kw6kwEuyAfoprz10nqQRlWquTpMDBih4ziAqzffgfd59X
	X4K7XscdLT23/ToMoihD9IIXl+dA=
X-Google-Smtp-Source: AGHT+IE58/Mr7wDVI4uAMXRhw/2I5yoUa8PDiGl0foezg8nNIi9xCPvHDcxyhrYiiJdqIaEHEo8Lr6NSdXni8vs9QUM=
X-Received: by 2002:a2e:6101:0:b0:2f1:5c89:c875 with SMTP id
 38308e7fff4ca-2f3aa1f00e3mr29782381fa.26.1723715290841; Thu, 15 Aug 2024
 02:48:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726094618.401593-1-21cnbao@gmail.com> <20240802122031.117548-1-21cnbao@gmail.com>
 <20240802122031.117548-3-21cnbao@gmail.com>
In-Reply-To: <20240802122031.117548-3-21cnbao@gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 15 Aug 2024 17:47:54 +0800
Message-ID: <CAMgjq7DmSok3YYd6dqyyYxkK_wZg7-c2bW8BFfxhs1V86h=niw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] mm: support large folios swap-in for zRAM-like devices
To: Chuanhua Han <hanchuanhua@oppo.com>, Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, minchan@kernel.org, 
	nphamcs@gmail.com, ryan.roberts@arm.com, senozhatsky@chromium.org, 
	shakeel.butt@linux.dev, shy828301@gmail.com, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, yosryahmed@google.com, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 8:21=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> From: Chuanhua Han <hanchuanhua@oppo.com>

Hi Chuanhua,

>
> Currently, we have mTHP features, but unfortunately, without support for =
large
> folio swap-ins, once these large folios are swapped out, they are lost be=
cause
> mTHP swap is a one-way process. The lack of mTHP swap-in functionality pr=
events
> mTHP from being used on devices like Android that heavily rely on swap.
>
> This patch introduces mTHP swap-in support. It starts from sync devices s=
uch
> as zRAM. This is probably the simplest and most common use case, benefiti=
ng
> billions of Android phones and similar devices with minimal implementatio=
n
> cost. In this straightforward scenario, large folios are always exclusive=
,
> eliminating the need to handle complex rmap and swapcache issues.
>
> It offers several benefits:
> 1. Enables bidirectional mTHP swapping, allowing retrieval of mTHP after
>    swap-out and swap-in. Large folios in the buddy system are also
>    preserved as much as possible, rather than being fragmented due
>    to swap-in.
>
> 2. Eliminates fragmentation in swap slots and supports successful
>    THP_SWPOUT.
>
>    w/o this patch (Refer to the data from Chris's and Kairui's latest
>    swap allocator optimization while running ./thp_swap_allocator_test
>    w/o "-a" option [1]):
>
>    ./thp_swap_allocator_test
>    Iteration 1: swpout inc: 233, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>    Iteration 2: swpout inc: 131, swpout fallback inc: 101, Fallback perce=
ntage: 43.53%
>    Iteration 3: swpout inc: 71, swpout fallback inc: 155, Fallback percen=
tage: 68.58%
>    Iteration 4: swpout inc: 55, swpout fallback inc: 168, Fallback percen=
tage: 75.34%
>    Iteration 5: swpout inc: 35, swpout fallback inc: 191, Fallback percen=
tage: 84.51%
>    Iteration 6: swpout inc: 25, swpout fallback inc: 199, Fallback percen=
tage: 88.84%
>    Iteration 7: swpout inc: 23, swpout fallback inc: 205, Fallback percen=
tage: 89.91%
>    Iteration 8: swpout inc: 9, swpout fallback inc: 219, Fallback percent=
age: 96.05%
>    Iteration 9: swpout inc: 13, swpout fallback inc: 213, Fallback percen=
tage: 94.25%
>    Iteration 10: swpout inc: 12, swpout fallback inc: 216, Fallback perce=
ntage: 94.74%
>    Iteration 11: swpout inc: 16, swpout fallback inc: 213, Fallback perce=
ntage: 93.01%
>    Iteration 12: swpout inc: 10, swpout fallback inc: 210, Fallback perce=
ntage: 95.45%
>    Iteration 13: swpout inc: 16, swpout fallback inc: 212, Fallback perce=
ntage: 92.98%
>    Iteration 14: swpout inc: 12, swpout fallback inc: 212, Fallback perce=
ntage: 94.64%
>    Iteration 15: swpout inc: 15, swpout fallback inc: 211, Fallback perce=
ntage: 93.36%
>    Iteration 16: swpout inc: 15, swpout fallback inc: 200, Fallback perce=
ntage: 93.02%
>    Iteration 17: swpout inc: 9, swpout fallback inc: 220, Fallback percen=
tage: 96.07%
>
>    w/ this patch (always 0%):
>    Iteration 1: swpout inc: 948, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>    Iteration 2: swpout inc: 953, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>    Iteration 3: swpout inc: 950, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>    Iteration 4: swpout inc: 952, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>    Iteration 5: swpout inc: 950, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>    Iteration 6: swpout inc: 950, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>    Iteration 7: swpout inc: 947, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>    Iteration 8: swpout inc: 950, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>    Iteration 9: swpout inc: 950, swpout fallback inc: 0, Fallback percent=
age: 0.00%
>    Iteration 10: swpout inc: 945, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
>    Iteration 11: swpout inc: 947, swpout fallback inc: 0, Fallback percen=
tage: 0.00%
>    ...
>
> 3. With both mTHP swap-out and swap-in supported, we offer the option to =
enable
>    zsmalloc compression/decompression with larger granularity[2]. The upc=
oming
>    optimization in zsmalloc will significantly increase swap speed and im=
prove
>    compression efficiency. Tested by running 100 iterations of swapping 1=
00MiB
>    of anon memory, the swap speed improved dramatically:
>                 time consumption of swapin(ms)   time consumption of swap=
out(ms)
>      lz4 4k                  45274                    90540
>      lz4 64k                 22942                    55667
>      zstdn 4k                85035                    186585
>      zstdn 64k               46558                    118533
>
>     The compression ratio also improved, as evaluated with 1 GiB of data:
>      granularity   orig_data_size   compr_data_size
>      4KiB-zstd      1048576000       246876055
>      64KiB-zstd     1048576000       199763892
>
>    Without mTHP swap-in, the potential optimizations in zsmalloc cannot b=
e
>    realized.
>
> 4. Even mTHP swap-in itself can reduce swap-in page faults by a factor
>    of nr_pages. Swapping in content filled with the same data 0x11, w/o
>    and w/ the patch for five rounds (Since the content is the same,
>    decompression will be very fast. This primarily assesses the impact of
>    reduced page faults):
>
>   swp in bandwidth(bytes/ms)    w/o              w/
>    round1                     624152          1127501
>    round2                     631672          1127501
>    round3                     620459          1139756
>    round4                     606113          1139756
>    round5                     624152          1152281
>    avg                        621310          1137359      +83%
>
> [1] https://lore.kernel.org/all/20240730-swap-allocator-v5-0-cb9c148b9297=
@kernel.org/
> [2] https://lore.kernel.org/all/20240327214816.31191-1-21cnbao@gmail.com/
>
> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/memory.c | 211 ++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 188 insertions(+), 23 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 4cf4902db1ec..07029532469a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3986,6 +3986,152 @@ static vm_fault_t handle_pte_marker(struct vm_fau=
lt *vmf)
>         return VM_FAULT_SIGBUS;
>  }
>
> +/*
> + * check a range of PTEs are completely swap entries with
> + * contiguous swap offsets and the same SWAP_HAS_CACHE.
> + * ptep must be first one in the range
> + */
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep, int nr_pag=
es)
> +{
> +       struct swap_info_struct *si;
> +       unsigned long addr;
> +       swp_entry_t entry;
> +       pgoff_t offset;
> +       char has_cache;
> +       int idx, i;
> +       pte_t pte;
> +
> +       addr =3D ALIGN_DOWN(vmf->address, nr_pages * PAGE_SIZE);
> +       idx =3D (vmf->address - addr) / PAGE_SIZE;
> +       pte =3D ptep_get(ptep);
> +
> +       if (!pte_same(pte, pte_move_swp_offset(vmf->orig_pte, -idx)))
> +               return false;
> +       entry =3D pte_to_swp_entry(pte);
> +       offset =3D swp_offset(entry);
> +       if (swap_pte_batch(ptep, nr_pages, pte) !=3D nr_pages)
> +               return false;
> +
> +       si =3D swp_swap_info(entry);
> +       has_cache =3D si->swap_map[offset] & SWAP_HAS_CACHE;
> +       for (i =3D 1; i < nr_pages; i++) {
> +               /*
> +                * while allocating a large folio and doing swap_read_fol=
io for the
> +                * SWP_SYNCHRONOUS_IO path, which is the case the being f=
aulted pte
> +                * doesn't have swapcache. We need to ensure all PTEs hav=
e no cache
> +                * as well, otherwise, we might go to swap devices while =
the content
> +                * is in swapcache
> +                */
> +               if ((si->swap_map[offset + i] & SWAP_HAS_CACHE) !=3D has_=
cache)
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +
> +static inline unsigned long thp_swap_suitable_orders(pgoff_t swp_offset,
> +               unsigned long addr, unsigned long orders)
> +{
> +       int order, nr;
> +
> +       order =3D highest_order(orders);
> +
> +       /*
> +        * To swap-in a THP with nr pages, we require its first swap_offs=
et
> +        * is aligned with nr. This can filter out most invalid entries.
> +        */
> +       while (orders) {
> +               nr =3D 1 << order;
> +               if ((addr >> PAGE_SHIFT) % nr =3D=3D swp_offset % nr)
> +                       break;
> +               order =3D next_order(&orders, order);
> +       }
> +
> +       return orders;
> +}
> +#else
> +static inline bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep, int=
 nr_pages)
> +{
> +       return false;
> +}
> +#endif
> +
> +static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> +{
> +       struct vm_area_struct *vma =3D vmf->vma;
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +       unsigned long orders;
> +       struct folio *folio;
> +       unsigned long addr;
> +       swp_entry_t entry;
> +       spinlock_t *ptl;
> +       pte_t *pte;
> +       gfp_t gfp;
> +       int order;
> +
> +       /*
> +        * If uffd is active for the vma we need per-page fault fidelity =
to
> +        * maintain the uffd semantics.
> +        */
> +       if (unlikely(userfaultfd_armed(vma)))
> +               goto fallback;
> +
> +       /*
> +        * A large swapped out folio could be partially or fully in zswap=
. We
> +        * lack handling for such cases, so fallback to swapping in order=
-0
> +        * folio.
> +        */
> +       if (!zswap_never_enabled())
> +               goto fallback;
> +
> +       entry =3D pte_to_swp_entry(vmf->orig_pte);
> +       /*
> +        * Get a list of all the (large) orders below PMD_ORDER that are =
enabled
> +        * and suitable for swapping THP.
> +        */
> +       orders =3D thp_vma_allowable_orders(vma, vma->vm_flags,
> +                       TVA_IN_PF | TVA_ENFORCE_SYSFS, BIT(PMD_ORDER) - 1=
);
> +       orders =3D thp_vma_suitable_orders(vma, vmf->address, orders);
> +       orders =3D thp_swap_suitable_orders(swp_offset(entry), vmf->addre=
ss, orders);
> +
> +       if (!orders)
> +               goto fallback;
> +
> +       pte =3D pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd, vmf->addre=
ss & PMD_MASK, &ptl);
> +       if (unlikely(!pte))
> +               goto fallback;
> +
> +       /*
> +        * For do_swap_page, find the highest order where the aligned ran=
ge is
> +        * completely swap entries with contiguous swap offsets.
> +        */
> +       order =3D highest_order(orders);
> +       while (orders) {
> +               addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> +               if (can_swapin_thp(vmf, pte + pte_index(addr), 1 << order=
))
> +                       break;
> +               order =3D next_order(&orders, order);
> +       }
> +
> +       pte_unmap_unlock(pte, ptl);
> +
> +       /* Try allocating the highest of the remaining orders. */
> +       gfp =3D vma_thp_gfp_mask(vma);
> +       while (orders) {
> +               addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> +               folio =3D vma_alloc_folio(gfp, order, vma, addr, true);
> +               if (folio)
> +                       return folio;
> +               order =3D next_order(&orders, order);
> +       }
> +
> +fallback:
> +#endif
> +       return vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vmf->address=
, false);
> +}
> +
> +
>  /*
>   * We enter with non-exclusive mmap_lock (to exclude vma changes,
>   * but allow concurrent faults), and pte mapped but not yet locked.
> @@ -4074,35 +4220,37 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         if (!folio) {
>                 if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>                     __swap_count(entry) =3D=3D 1) {
> -                       /*
> -                        * Prevent parallel swapin from proceeding with
> -                        * the cache flag. Otherwise, another thread may
> -                        * finish swapin first, free the entry, and swapo=
ut
> -                        * reusing the same entry. It's undetectable as
> -                        * pte_same() returns true due to entry reuse.
> -                        */
> -                       if (swapcache_prepare(entry, 1)) {
> -                               /* Relax a bit to prevent rapid repeated =
page faults */
> -                               schedule_timeout_uninterruptible(1);
> -                               goto out;
> -                       }
> -                       need_clear_cache =3D true;
> -
>                         /* skip swapcache */
> -                       folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0=
,
> -                                               vma, vmf->address, false)=
;
> +                       folio =3D alloc_swap_folio(vmf);
>                         page =3D &folio->page;
>                         if (folio) {
>                                 __folio_set_locked(folio);
>                                 __folio_set_swapbacked(folio);
>
> +                               nr_pages =3D folio_nr_pages(folio);
> +                               if (folio_test_large(folio))
> +                                       entry.val =3D ALIGN_DOWN(entry.va=
l, nr_pages);
> +                               /*
> +                                * Prevent parallel swapin from proceedin=
g with
> +                                * the cache flag. Otherwise, another thr=
ead may
> +                                * finish swapin first, free the entry, a=
nd swapout
> +                                * reusing the same entry. It's undetecta=
ble as
> +                                * pte_same() returns true due to entry r=
euse.
> +                                */
> +                               if (swapcache_prepare(entry, nr_pages)) {
> +                                       /* Relax a bit to prevent rapid r=
epeated page faults */
> +                                       schedule_timeout_uninterruptible(=
1);
> +                                       goto out_page;
> +                               }
> +                               need_clear_cache =3D true;
> +
>                                 if (mem_cgroup_swapin_charge_folio(folio,
>                                                         vma->vm_mm, GFP_K=
ERNEL,
>                                                         entry)) {
>                                         ret =3D VM_FAULT_OOM;
>                                         goto out_page;
>                                 }

After your patch, with build kernel test, I'm seeing kernel log
spamming like this:
[  101.048594] pagefault_out_of_memory: 95 callbacks suppressed
[  101.048599] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
[  101.059416] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
[  101.118575] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
[  101.125585] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
[  101.182501] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
[  101.215351] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
[  101.272822] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
[  101.403195] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
............

And heavy performance loss with workloads limited by memcg, mTHP enabled.

After some debugging, the problematic part is the
mem_cgroup_swapin_charge_folio call above.
When under pressure, cgroup charge fails easily for mTHP. One 64k
swapin will require a much more aggressive reclaim to success.

If I change MAX_RECLAIM_RETRIES from 16 to 512, the spamming log is
gone and mTHP swapin should have a much higher swapin success rate.
But this might not be the right way.

For this particular issue, maybe you can change the charge order, try
charging first, if successful, use mTHP. if failed, fallback to 4k?

> -                               mem_cgroup_swapin_uncharge_swap(entry, 1)=
;
> +                               mem_cgroup_swapin_uncharge_swap(entry, nr=
_pages);
>
>                                 shadow =3D get_shadow_from_swap_cache(ent=
ry);
>                                 if (shadow)
> @@ -4209,6 +4357,22 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                 goto out_nomap;
>         }
>
> +       /* allocated large folios for SWP_SYNCHRONOUS_IO */
> +       if (folio_test_large(folio) && !folio_test_swapcache(folio)) {
> +               unsigned long nr =3D folio_nr_pages(folio);
> +               unsigned long folio_start =3D ALIGN_DOWN(vmf->address, nr=
 * PAGE_SIZE);
> +               unsigned long idx =3D (vmf->address - folio_start) / PAGE=
_SIZE;
> +               pte_t *folio_ptep =3D vmf->pte - idx;
> +
> +               if (!can_swapin_thp(vmf, folio_ptep, nr))
> +                       goto out_nomap;
> +
> +               page_idx =3D idx;
> +               address =3D folio_start;
> +               ptep =3D folio_ptep;
> +               goto check_folio;
> +       }
> +
>         nr_pages =3D 1;
>         page_idx =3D 0;
>         address =3D vmf->address;
> @@ -4340,11 +4504,12 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                 folio_add_lru_vma(folio, vma);
>         } else if (!folio_test_anon(folio)) {
>                 /*
> -                * We currently only expect small !anon folios, which are=
 either
> -                * fully exclusive or fully shared. If we ever get large =
folios
> -                * here, we have to be careful.
> +                * We currently only expect small !anon folios which are =
either
> +                * fully exclusive or fully shared, or new allocated larg=
e folios
> +                * which are fully exclusive. If we ever get large folios=
 within
> +                * swapcache here, we have to be careful.
>                  */
> -               VM_WARN_ON_ONCE(folio_test_large(folio));
> +               VM_WARN_ON_ONCE(folio_test_large(folio) && folio_test_swa=
pcache(folio));
>                 VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
>                 folio_add_new_anon_rmap(folio, vma, address, rmap_flags);
>         } else {
> @@ -4387,7 +4552,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  out:
>         /* Clear the swap cache pin for direct swapin after PTL unlock */
>         if (need_clear_cache)
> -               swapcache_clear(si, entry, 1);
> +               swapcache_clear(si, entry, nr_pages);
>         if (si)
>                 put_swap_device(si);
>         return ret;
> @@ -4403,7 +4568,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                 folio_put(swapcache);
>         }
>         if (need_clear_cache)
> -               swapcache_clear(si, entry, 1);
> +               swapcache_clear(si, entry, nr_pages);
>         if (si)
>                 put_swap_device(si);
>         return ret;
> --
> 2.34.1
>
>

