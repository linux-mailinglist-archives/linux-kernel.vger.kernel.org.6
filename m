Return-Path: <linux-kernel+bounces-313511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AB696A667
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 20:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75D32816C6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FB119047A;
	Tue,  3 Sep 2024 18:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeiBvnrL"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D32188936
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725387902; cv=none; b=SPpQ7N60t2+OHKVo2sdYLOJHAiFnKiAhZMQjSuhqqcbpIJTYsNAt7S35jkfKd9i4fA39fnQY3V0oESLKWyB3PzAAiv1w9ZbMyeAtx3T0N/j8WpNIy84c82FstBVBER0es368Iq5PLLaJx+ZkUFLRfOkANLLo6Ryr0KjYaKcstwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725387902; c=relaxed/simple;
	bh=wdGbeLBuRWzgdtS2ucnsgnmc4e+QJZhY1gKTX94pFf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fw/yQvk0Tq+xnkDccQBE5w/5zXHtoM/Isz8vfyxVzgyoz7/kEQ7M2xE23bLT0ylGfHP9orLSk+1igkocLfUL54Bb0ulFD04h/oNFrFxWVdbsrk+CmdzkVweQ37XzWSvHVwYMYRnD+bWdqzkhRTBqmqxOzpJR3FmAw5L9Q6tgftg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LeiBvnrL; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f4f8742138so64475331fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 11:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725387897; x=1725992697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncA6gP+76zL35HCt4+Ds/Kp0TruK3dmKCnAyY9bgkS8=;
        b=LeiBvnrLQ//GvBo137K7Q77zVIT//CFeWSQYXbQIYjOFBwROZFi8K11pCD7JMg0vqi
         pxoGEeNPyOcODNnQ13hr6tf7QLP9UFAEnEpxwioqr6iFFBVRIjwSLoxuns3QN1XONnZ8
         xuOAySsXNGlu53sWaU4dV2tYbNXW0COE95+dqUybcUVTwoScsXaUPqKkrsDJmcnKEXy+
         bp+NN+2JYIa64z+Igbh1G341CHOO+uHHyPxtfsxRivGKaZ/5W8/JJSwZ9NhaqOEiIkQF
         01d/dYDEBhEC6XRJ0URbAuG50XOsfhR38C7c7EA0+d3/cthE3QkB7p87Q3W4U95gluxX
         zBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725387897; x=1725992697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncA6gP+76zL35HCt4+Ds/Kp0TruK3dmKCnAyY9bgkS8=;
        b=C3L0UFm3B79kn9TmaqDGl1c3G7p0xu4gZkpjnnzdlHVCoS7UgHc5X/H3ypPcybJ+yS
         dQu2H8T0FpW/MlhmDa/hkBjbtTy+786pxslgM1zWyhV9OH0/JnTB6HCNlMxO7Ep94VCs
         k+eJgXDsUQgC146nXFDpF1BlCxLyFJd7bNrk/xSO64YbN9epAZWtQhd3polbXdgojySV
         43jI7pkzBtOpandIn8/qOjrXRuwctnhTUPPPFsJeFfE4i8X5J2dNqolCWEVEBcxpXFYp
         uHg23KpYMe0K0LLWusE2UK7ebOItHzDUz8qN+YiH+RbWfF84nTuUoojKcYzylFMXcYAe
         c8eQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+a6BaWN1YBJ4Q3WLQ4HbtmtkHw6MHHdxEUlMMw6E9MWgW/ZTMTrJNGk1YgklMKcuG5H9I5QfHQd8yb2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtQRPv+yBUEWyvyHgm5YK8T+m8uucILmsc5KxDr4zb6tGBety8
	YBQRHxRDDusDJyosBuWoMmdqxFc1CZPye2chbGIFzrur3EbmYnSQWmLw/rsxC59rE/sKw/R71JI
	3XaZaIk2CS7brMulrnMxS9gFdlEk=
X-Google-Smtp-Source: AGHT+IGBcaiRetcGA1tcldlqoEIwfej527nUHbpm6xJtMeEQ+MNIoinZ/nNv7KjHy8Z0coQMoAxOWdOhvdjFeuhhrFE=
X-Received: by 2002:a2e:a586:0:b0:2f3:f4e2:869c with SMTP id
 38308e7fff4ca-2f64d570e98mr13690921fa.44.1725387896474; Tue, 03 Sep 2024
 11:24:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821074541.516249-1-hanchuanhua@oppo.com> <20240821074541.516249-3-hanchuanhua@oppo.com>
In-Reply-To: <20240821074541.516249-3-hanchuanhua@oppo.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 4 Sep 2024 02:24:39 +0800
Message-ID: <CAMgjq7BpOqgKoeQEPCL9ai3dvVPv7wJe3k_g1hDjAVeCLpZ=7w@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] mm: support large folios swap-in for sync io devices
To: hanchuanhua@oppo.com, Usama Arif <usamaarif642@gmail.com>
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

Hi All,


On Wed, Aug 21, 2024 at 3:46=E2=80=AFPM <hanchuanhua@oppo.com> wrote:
>
> From: Chuanhua Han <hanchuanhua@oppo.com>
>
> Currently, we have mTHP features, but unfortunately, without support for
> large folio swap-ins, once these large folios are swapped out, they are
> lost because mTHP swap is a one-way process. The lack of mTHP swap-in
> functionality prevents mTHP from being used on devices like Android that
> heavily rely on swap.
>
> This patch introduces mTHP swap-in support. It starts from sync devices
> such as zRAM. This is probably the simplest and most common use case,
> benefiting billions of Android phones and similar devices with minimal
> implementation cost. In this straightforward scenario, large folios are
> always exclusive, eliminating the need to handle complex rmap and
> swapcache issues.
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
>  mm/memory.c | 250 ++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 223 insertions(+), 27 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index b9fe2f354878..7aa0358a4160 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3986,6 +3986,184 @@ static vm_fault_t handle_pte_marker(struct vm_fau=
lt *vmf)
>         return VM_FAULT_SIGBUS;
>  }
>
> +static struct folio *__alloc_swap_folio(struct vm_fault *vmf)
> +{
> +       struct vm_area_struct *vma =3D vmf->vma;
> +       struct folio *folio;
> +       swp_entry_t entry;
> +
> +       folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma,
> +                               vmf->address, false);
> +       if (!folio)
> +               return NULL;
> +
> +       entry =3D pte_to_swp_entry(vmf->orig_pte);
> +       if (mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
> +                                          GFP_KERNEL, entry)) {
> +               folio_put(folio);
> +               return NULL;
> +       }
> +
> +       return folio;
> +}
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +/*
> + * Check if the PTEs within a range are contiguous swap entries
> + * and have no cache when check_no_cache is true.
> + */
> +static bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep,
> +                          int nr_pages, bool check_no_cache)
> +{
> +       struct swap_info_struct *si;
> +       unsigned long addr;
> +       swp_entry_t entry;
> +       pgoff_t offset;
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
> +       if (!check_no_cache)
> +               return true;
> +
> +       si =3D swp_swap_info(entry);
> +       /*
> +        * While allocating a large folio and doing swap_read_folio, whic=
h is
> +        * the case the being faulted pte doesn't have swapcache. We need=
 to
> +        * ensure all PTEs have no cache as well, otherwise, we might go =
to
> +        * swap devices while the content is in swapcache.
> +        */
> +       for (i =3D 0; i < nr_pages; i++) {
> +               if ((si->swap_map[offset + i] & SWAP_HAS_CACHE))
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +
> +static inline unsigned long thp_swap_suitable_orders(pgoff_t swp_offset,
> +                                                    unsigned long addr,
> +                                                    unsigned long orders=
)
> +{
> +       int order, nr;
> +
> +       order =3D highest_order(orders);
> +
> +       /*
> +        * To swap in a THP with nr pages, we require that its first swap=
_offset
> +        * is aligned with that number, as it was when the THP was swappe=
d out.
> +        * This helps filter out most invalid entries.
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
> +
> +static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> +{
> +       struct vm_area_struct *vma =3D vmf->vma;
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
> +       orders =3D thp_swap_suitable_orders(swp_offset(entry),
> +                                         vmf->address, orders);
> +
> +       if (!orders)
> +               goto fallback;
> +
> +       pte =3D pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
> +                                 vmf->address & PMD_MASK, &ptl);
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
, true))
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
> +               if (folio) {
> +                       if (!mem_cgroup_swapin_charge_folio(folio, vma->v=
m_mm,
> +                                                           gfp, entry))
> +                               return folio;
> +                       folio_put(folio);
> +               }
> +               order =3D next_order(&orders, order);
> +       }
> +
> +fallback:
> +       return __alloc_swap_folio(vmf);
> +}
> +#else /* !CONFIG_TRANSPARENT_HUGEPAGE */
> +static inline bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep,
> +                                 int nr_pages, bool check_no_cache)
> +{
> +       return false;
> +}
> +
> +static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> +{
> +       return __alloc_swap_folio(vmf);
> +}
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +
>  /*
>   * We enter with non-exclusive mmap_lock (to exclude vma changes,
>   * but allow concurrent faults), and pte mapped but not yet locked.
> @@ -4074,34 +4252,34 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
>                         if (folio) {
>                                 __folio_set_locked(folio);
>                                 __folio_set_swapbacked(folio);
>
> -                               if (mem_cgroup_swapin_charge_folio(folio,
> -                                                       vma->vm_mm, GFP_K=
ERNEL,
> -                                                       entry)) {
> -                                       ret =3D VM_FAULT_OOM;
> +                               nr_pages =3D folio_nr_pages(folio);
> +                               if (folio_test_large(folio))
> +                                       entry.val =3D ALIGN_DOWN(entry.va=
l, nr_pages);
> +                               /*
> +                                * Prevent parallel swapin from proceedin=
g with
> +                                * the cache flag. Otherwise, another thr=
ead
> +                                * may finish swapin first, free the entr=
y, and
> +                                * swapout reusing the same entry. It's
> +                                * undetectable as pte_same() returns tru=
e due
> +                                * to entry reuse.
> +                                */
> +                               if (swapcache_prepare(entry, nr_pages)) {
> +                                       /*
> +                                        * Relax a bit to prevent rapid
> +                                        * repeated page faults.
> +                                        */
> +                                       schedule_timeout_uninterruptible(=
1);
>                                         goto out_page;
>                                 }
> -                               mem_cgroup_swapin_uncharge_swap(entry, 1)=
;
> +                               need_clear_cache =3D true;
> +
> +                               mem_cgroup_swapin_uncharge_swap(entry, nr=
_pages);
>
>                                 shadow =3D get_shadow_from_swap_cache(ent=
ry);
>                                 if (shadow)
> @@ -4207,6 +4385,23 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                 goto out_nomap;
>         }
>
> +       /* allocated large folios for SWP_SYNCHRONOUS_IO */
> +       if (folio_test_large(folio) && !folio_test_swapcache(folio)) {
> +               unsigned long nr =3D folio_nr_pages(folio);
> +               unsigned long folio_start =3D ALIGN_DOWN(vmf->address,
> +                                                      nr * PAGE_SIZE);
> +               unsigned long idx =3D (vmf->address - folio_start) / PAGE=
_SIZE;
> +               pte_t *folio_ptep =3D vmf->pte - idx;
> +
> +               if (!can_swapin_thp(vmf, folio_ptep, nr, false))
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
> @@ -4338,11 +4533,12 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
e
> +                * folios which are fully exclusive. If we ever get large
> +                * folios within swapcache here, we have to be careful.
>                  */
> -               VM_WARN_ON_ONCE(folio_test_large(folio));
> +               VM_WARN_ON_ONCE(folio_test_large(folio) && folio_test_swa=
pcache(folio));
>                 VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
>                 folio_add_new_anon_rmap(folio, vma, address, rmap_flags);
>         } else {
> @@ -4385,7 +4581,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  out:
>         /* Clear the swap cache pin for direct swapin after PTL unlock */
>         if (need_clear_cache)
> -               swapcache_clear(si, entry, 1);
> +               swapcache_clear(si, entry, nr_pages);
>         if (si)
>                 put_swap_device(si);
>         return ret;
> @@ -4401,7 +4597,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                 folio_put(swapcache);
>         }
>         if (need_clear_cache)
> -               swapcache_clear(si, entry, 1);
> +               swapcache_clear(si, entry, nr_pages);
>         if (si)
>                 put_swap_device(si);
>         return ret;
> --
> 2.43.0
>

With latest mm-unstable, I'm seeing following WARN followed by user
space segfaults (multiple mTHP enabled):

[   39.145686] ------------[ cut here ]------------
[   39.145969] WARNING: CPU: 24 PID: 11159 at mm/page_io.c:535
swap_read_folio+0x4db/0x520
[   39.146307] Modules linked in:
[   39.146507] CPU: 24 UID: 1000 PID: 11159 Comm: sh Kdump: loaded Not
tainted 6.11.0-rc6.orig+ #131
[   39.146887] Hardware name: Tencent Cloud CVM, BIOS
seabios-1.9.1-qemu-project.org 04/01/2014
[   39.147206] RIP: 0010:swap_read_folio+0x4db/0x520
[   39.147430] Code: 00 e0 ff ff 09 c1 83 f8 08 0f 42 d1 e9 c4 fe ff
ff 48 63 85 34 02 00 00 48 03 45 08 49 39 c4 0f 85 63 fe ff ff e9 db
fe ff ff <0f> 0b e9 91 fd ff ff 31 d2 e9 9d fe ff ff 48 c7 c6 38 b6 4e
82 48
[   39.148079] RSP: 0000:ffffc900045c3ce0 EFLAGS: 00010202
[   39.148390] RAX: 0017ffffd0020061 RBX: ffffea00064d4c00 RCX: 03fffffffff=
fffff
[   39.148737] RDX: ffffea00064d4c00 RSI: 0000000000000000 RDI: ffffea00064=
d4c00
[   39.149102] RBP: 0000000000000001 R08: ffffea00064d4c00 R09: 00000000000=
00078
[   39.149482] R10: 00000000000000f0 R11: 0000000000000004 R12: 00000000000=
01000
[   39.149832] R13: ffff888102df5c00 R14: ffff888102df5c00 R15: 00000000000=
00003
[   39.150177] FS:  00007f51a56c9540(0000) GS:ffff888fffc00000(0000)
knlGS:0000000000000000
[   39.150623] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   39.150950] CR2: 000055627b13fda0 CR3: 00000001083e2000 CR4: 00000000003=
506b0
[   39.151317] Call Trace:
[   39.151565]  <TASK>
[   39.151778]  ? __warn+0x84/0x130
[   39.152044]  ? swap_read_folio+0x4db/0x520
[   39.152345]  ? report_bug+0xfc/0x1e0
[   39.152614]  ? handle_bug+0x3f/0x70
[   39.152891]  ? exc_invalid_op+0x17/0x70
[   39.153178]  ? asm_exc_invalid_op+0x1a/0x20
[   39.153467]  ? swap_read_folio+0x4db/0x520
[   39.153753]  do_swap_page+0xc6d/0x14f0
[   39.154054]  ? srso_return_thunk+0x5/0x5f
[   39.154361]  __handle_mm_fault+0x758/0x850
[   39.154645]  handle_mm_fault+0x134/0x340
[   39.154945]  do_user_addr_fault+0x2e5/0x760
[   39.155245]  exc_page_fault+0x6a/0x140
[   39.155546]  asm_exc_page_fault+0x26/0x30
[   39.155847] RIP: 0033:0x55627b071446
[   39.156124] Code: f6 7e 19 83 e3 01 74 14 41 83 ee 01 44 89 35 25
72 0c 00 45 85 ed 0f 88 73 02 00 00 8b 05 ea 74 0c 00 85 c0 0f 85 da
03 00 00 <44> 8b 15 53 e9 0c 00 45 85 d2 74 2e 44 8b 0d 37 e3 0c 00 45
85 c9
[   39.156944] RSP: 002b:00007ffd619d54f0 EFLAGS: 00010246
[   39.157237] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f51a44=
f968b
[   39.157594] RDX: 0000000000000000 RSI: 00007ffd619d5518 RDI: 00000000fff=
fffff
[   39.157954] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00007
[   39.158288] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00001
[   39.158634] R13: 0000000000002b9a R14: 0000000000000000 R15: 00007ffd619=
d5518
[   39.158998]  </TASK>
[   39.159226] ---[ end trace 0000000000000000 ]---

After reverting this or Usama's "mm: store zero pages to be swapped
out in a bitmap", the problem is gone. I think these two patches may
have some conflict that needs to be resolved.

