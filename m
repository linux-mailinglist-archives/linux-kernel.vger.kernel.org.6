Return-Path: <linux-kernel+bounces-178760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB178C5744
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 15:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650A6284204
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 13:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41FB14431F;
	Tue, 14 May 2024 13:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/OMav6M"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34F11448E7
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715693830; cv=none; b=ecfOR7Ze6ZonvK3Uy86mDQICmW+b3/A97tgsuEHHS2jtvMyisenqSjlP3ZbKfy2FvCNOZCdrlE9NShA8s+7kmVzMXC2sIzN4OxsAEYb+xGrSoJoawoe0daPQqqz2E0hEqaMLQLktiESG83mhWrQkrOqPh66lGXD1isPzE37K62c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715693830; c=relaxed/simple;
	bh=U1/3a8wkeJhq52hA9ggAUfzavSHJ51MpVjZMPgFo0VE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udbB/A7PQ4XhFEAYDo/ISl8X5cvnK6ZNJnsL0MLXeA6zUW49uNGkRWvQvX7L50SVBaAVHGzKOKae39bbPdq10rqZ6uttOq7fd+R5rG6ULxLMGL/XM8NBNuOOpGbufedZX3Kar2NfeCMT7xZDh/0L4SugBNm/wlhI7opkmEk3BIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/OMav6M; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51f99f9e0faso6392149e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 06:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715693827; x=1716298627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSwlcl5A7t5dZkersoBLZCtBRGcBBDn7uAz7P806bdw=;
        b=P/OMav6MKVnit9j2EBOObadOodwltQDfRIPYtzv3ws+FGkS8lvCdwfFwm7I5naE3qI
         qkZc+IliODaYnext5Tujktztl9JZ5Ot1ysrSyt0UUQDpfzEcYvtDt2w6V+BC/x8PcEQP
         Co7gusU+BV8SNj9GBmKw2CZMXQJVyig8lJY8CFcR+DJh+vhy2bv2uirKeEvpQeKlGJfg
         coT9SrosUue+RIwkpB+gbYE9wlEcQoBdQLYCBM0Haa4wdEN38hLEaBUw/92A3W6nZVFf
         q7n4Pdd5lAeUtfop0nIn+cSVn1OvFfnMtltX4F0Ojg3QbQ3oPDcD9W70xJpCjsuVPJk1
         n1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715693827; x=1716298627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vSwlcl5A7t5dZkersoBLZCtBRGcBBDn7uAz7P806bdw=;
        b=O804EZHJERxoDRFLCjNPyVUUZzuMya3FpJ2KqrSS8E9QeL/FkrpIfyJFePjC+EKitM
         Y0TdkRpSU3cElCOxFTf6hl7cVFBKAmaSJJTeEr+KJY5KnEDmxacV7qOzdEXyhy+qzrsf
         LtJOj+0ilKA58rNCvMfDa1+TQDb54M0vvHia/pPCIa2Ekd+gGTDhwnNQYuRpU+Vqv12v
         E7TG8/L45Pw5R3ZDlJMBAJW5K7jWyIfEn6eTzsVrAJT1Xigk02hN2+LvFXlBYkk2dptK
         oJJQ8mKrQ2aKuSqgiSdlvu6zgRY9q6UJH6a16PfYv9tsyhVBqOMrgeVHmySIs9gowHdg
         KRMw==
X-Forwarded-Encrypted: i=1; AJvYcCXWBI33hBrtHnb0WO5V9ZSQYo//E7IVLb4uTaCo166HXfW9zwwHhzYOcDuaaK9Mt395xtNy+lKfAWw3+1GjG60liHG5H+69UftAtofl
X-Gm-Message-State: AOJu0YwOhdnV/wAhiJugoubRhyZmXv1ldNkuQi+gaOte4g1XHlZBaN7W
	O8CLO/EPmDFjUDlIIIYXVR2WwYdScKPQTXsB9QcMw+nUVeDInz93mdupgCcfJ+L31U2MwT1rKPW
	1gyYEqdLrhImTx2+gRPTRwMC8xwgN+9NXPBw=
X-Google-Smtp-Source: AGHT+IGW6w40iSKvPDTilgJ0kydoh/zKR2ywlYAygxMp+AHRTVdLUy/g2jCTFZIimeCHtPLVDFYraE2FBdg1AYa121w=
X-Received: by 2002:a05:6512:3c9f:b0:518:dae6:d0ec with SMTP id
 2adb3069b0e04-5220ff71cf6mr11426096e87.4.1715693805820; Tue, 14 May 2024
 06:36:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1715571279.git.baolin.wang@linux.alibaba.com> <bc354692695d443e00b8c5e2106868a7f365e078.1715571279.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <bc354692695d443e00b8c5e2106868a7f365e078.1715571279.git.baolin.wang@linux.alibaba.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 14 May 2024 21:36:34 +0800
Message-ID: <CAK1f24m1LAK-+GKeTSGANXXfk3KahmpN7KvO8FCkA+2cdNtfzw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] mm: shmem: add mTHP support for anonymous shmem
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org, 
	david@redhat.com, wangkefeng.wang@huawei.com, ying.huang@intel.com, 
	21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com, ziy@nvidia.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Baolin,

On Mon, May 13, 2024 at 1:08=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> Commit 19eaf44954df adds multi-size THP (mTHP) for anonymous pages, that
> can allow THP to be configured through the sysfs interface located at
> '/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled'.
>
> However, the anonymous share pages will ignore the anonymous mTHP rule
> configured through the sysfs interface, and can only use the PMD-mapped
> THP, that is not reasonable. Users expect to apply the mTHP rule for
> all anonymous pages, including the anonymous share pages, in order to
> enjoy the benefits of mTHP. For example, lower latency than PMD-mapped TH=
P,
> smaller memory bloat than PMD-mapped THP, contiguous PTEs on ARM architec=
ture
> to reduce TLB miss etc.
>
> The primary strategy is similar to supporting anonymous mTHP. Introduce
> a new interface '/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled',
> which can have all the same values as the top-level
> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', with adding a new
> additional "inherit" option. By default all sizes will be set to "never"
> except PMD size, which is set to "inherit". This ensures backward compati=
bility
> with the anonymous shmem enabled of the top level, meanwhile also allows
> independent control of anonymous shmem enabled for each mTHP.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  include/linux/huge_mm.h |  10 +++
>  mm/shmem.c              | 179 +++++++++++++++++++++++++++++++++-------
>  2 files changed, 161 insertions(+), 28 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 1fce6fee7766..b5339210268d 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -583,6 +583,16 @@ static inline bool thp_migration_supported(void)
>  {
>         return false;
>  }
> +
> +static inline int highest_order(unsigned long orders)
> +{
> +       return 0;
> +}
> +
> +static inline int next_order(unsigned long *orders, int prev)
> +{
> +       return 0;
> +}
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>
>  static inline int split_folio_to_list_to_order(struct folio *folio,
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 59cc26d44344..b50ddf013e37 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1611,6 +1611,106 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t=
 limit_gfp)
>         return result;
>  }
>
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static unsigned long anon_shmem_allowable_huge_orders(struct inode *inod=
e,
> +                               struct vm_area_struct *vma, pgoff_t index=
,
> +                               bool global_huge)
> +{
> +       unsigned long mask =3D READ_ONCE(huge_anon_shmem_orders_always);
> +       unsigned long within_size_orders =3D READ_ONCE(huge_anon_shmem_or=
ders_within_size);
> +       unsigned long vm_flags =3D vma->vm_flags;
> +       /*
> +        * Check all the (large) orders below HPAGE_PMD_ORDER + 1 that
> +        * are enabled for this vma.
> +        */
> +       unsigned long orders =3D BIT(PMD_ORDER + 1) - 1;
> +       loff_t i_size;
> +       int order;
> +
> +       if ((vm_flags & VM_NOHUGEPAGE) ||
> +           test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> +               return 0;
> +
> +       /* If the hardware/firmware marked hugepage support disabled. */
> +       if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUP=
PORTED))
> +               return 0;
> +
> +       /*
> +        * Following the 'deny' semantics of the top level, force the hug=
e
> +        * option off from all mounts.
> +        */
> +       if (shmem_huge =3D=3D SHMEM_HUGE_DENY)
> +               return 0;
> +       /*
> +        * Only allow inherit orders if the top-level value is 'force', w=
hich
> +        * means non-PMD sized THP can not override 'huge' mount option n=
ow.
> +        */
> +       if (shmem_huge =3D=3D SHMEM_HUGE_FORCE)
> +               return READ_ONCE(huge_anon_shmem_orders_inherit);
> +
> +       /* Allow mTHP that will be fully within i_size. */
> +       order =3D highest_order(within_size_orders);
> +       while (within_size_orders) {
> +               index =3D round_up(index + 1, order);
> +               i_size =3D round_up(i_size_read(inode), PAGE_SIZE);
> +               if (i_size >> PAGE_SHIFT >=3D index) {
> +                       mask |=3D within_size_orders;
> +                       break;
> +               }
> +
> +               order =3D next_order(&within_size_orders, order);
> +       }
> +
> +       if (vm_flags & VM_HUGEPAGE)
> +               mask |=3D READ_ONCE(huge_anon_shmem_orders_madvise);
> +
> +       if (global_huge)
> +               mask |=3D READ_ONCE(huge_anon_shmem_orders_inherit);
> +
> +       return orders & mask;
> +}
> +
> +static unsigned long anon_shmem_suitable_orders(struct inode *inode, str=
uct vm_fault *vmf,
> +                                       struct address_space *mapping, pg=
off_t index,
> +                                       unsigned long orders)
> +{
> +       struct vm_area_struct *vma =3D vmf->vma;
> +       unsigned long pages;
> +       int order;
> +
> +       orders =3D thp_vma_suitable_orders(vma, vmf->address, orders);
> +       if (!orders)
> +               return 0;
> +
> +       /* Find the highest order that can add into the page cache */
> +       order =3D highest_order(orders);
> +       while (orders) {
> +               pages =3D 1UL << order;
> +               index =3D round_down(index, pages);
> +               if (!xa_find(&mapping->i_pages, &index,
> +                            index + pages - 1, XA_PRESENT))
> +                       break;
> +               order =3D next_order(&orders, order);
> +       }
> +
> +       return orders;
> +}
> +#else
> +static unsigned long anon_shmem_allowable_huge_orders(struct inode *inod=
e,
> +                               struct vm_area_struct *vma, pgoff_t index=
,
> +                               bool global_huge)
> +{
> +       return 0;
> +}
> +
> +static unsigned long anon_shmem_suitable_orders(struct inode *inode, str=
uct vm_fault *vmf,
> +                                       struct address_space *mapping, pg=
off_t index,
> +                                       unsigned long orders)
> +{
> +       return 0;
> +}
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +
>  static struct folio *shmem_alloc_hugefolio(gfp_t gfp,
>                 struct shmem_inode_info *info, pgoff_t index, int order)
>  {
> @@ -1639,38 +1739,55 @@ static struct folio *shmem_alloc_folio(gfp_t gfp,
>         return (struct folio *)page;
>  }
>
> -static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
> -               struct inode *inode, pgoff_t index,
> -               struct mm_struct *fault_mm, bool huge)
> +static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
> +               gfp_t gfp, struct inode *inode, pgoff_t index,
> +               struct mm_struct *fault_mm, bool huge, unsigned long orde=
rs)

IMO, it might be cleaner to drop the huge parameter and just set 'orders' a=
s
BIT(HPAGE_PMD_ORDER), then we only do the 'orders' check :)

Likely:

if (orders > 0) {
       if (vma && vma_is_anon_shmem(vma)) {
              ...
       } else if (orders & BIT(HPAGE_PMD_ORDER)) {
              ...
       }
}

>  {
>         struct address_space *mapping =3D inode->i_mapping;
>         struct shmem_inode_info *info =3D SHMEM_I(inode);
> -       struct folio *folio;
> +       struct vm_area_struct *vma =3D vmf ? vmf->vma : NULL;
> +       unsigned long suitable_orders;
> +       struct folio *folio =3D NULL;
>         long pages;
> -       int error;
> +       int error, order;
>
>         if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
>                 huge =3D false;

Currently, if THP is disabled, 'huge' will fall back to order-0, but 'order=
s'
does not, IIUC. How about we make both consistent if THP is disabled?

if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
        huge =3D false;
        orders =3D 0;
}

Thanks,
Lance

>
> -       if (huge) {
> -               pages =3D HPAGE_PMD_NR;
> -               index =3D round_down(index, HPAGE_PMD_NR);
> +       if (huge || orders > 0) {
> +               if (vma && vma_is_anon_shmem(vma) && orders) {
> +                       suitable_orders =3D anon_shmem_suitable_orders(in=
ode, vmf,
> +                                                       mapping, index, o=
rders);
> +               } else {
> +                       pages =3D HPAGE_PMD_NR;
> +                       suitable_orders =3D BIT(HPAGE_PMD_ORDER);
> +                       index =3D round_down(index, HPAGE_PMD_NR);
>
> -               /*
> -                * Check for conflict before waiting on a huge allocation=
.
> -                * Conflict might be that a huge page has just been alloc=
ated
> -                * and added to page cache by a racing thread, or that th=
ere
> -                * is already at least one small page in the huge extent.
> -                * Be careful to retry when appropriate, but not forever!
> -                * Elsewhere -EEXIST would be the right code, but not her=
e.
> -                */
> -               if (xa_find(&mapping->i_pages, &index,
> +                       /*
> +                        * Check for conflict before waiting on a huge al=
location.
> +                        * Conflict might be that a huge page has just be=
en allocated
> +                        * and added to page cache by a racing thread, or=
 that there
> +                        * is already at least one small page in the huge=
 extent.
> +                        * Be careful to retry when appropriate, but not =
forever!
> +                        * Elsewhere -EEXIST would be the right code, but=
 not here.
> +                        */
> +                       if (xa_find(&mapping->i_pages, &index,
>                                 index + HPAGE_PMD_NR - 1, XA_PRESENT))
> -                       return ERR_PTR(-E2BIG);
> +                               return ERR_PTR(-E2BIG);
> +               }
>
> -               folio =3D shmem_alloc_hugefolio(gfp, info, index, HPAGE_P=
MD_ORDER);
> -               if (!folio && pages =3D=3D HPAGE_PMD_NR)
> -                       count_vm_event(THP_FILE_FALLBACK);
> +               order =3D highest_order(suitable_orders);
> +               while (suitable_orders) {
> +                       pages =3D 1 << order;
> +                       index =3D round_down(index, pages);
> +                       folio =3D shmem_alloc_hugefolio(gfp, info, index,=
 order);
> +                       if (folio)
> +                               goto allocated;
> +
> +                       if (pages =3D=3D HPAGE_PMD_NR)
> +                               count_vm_event(THP_FILE_FALLBACK);
> +                       order =3D next_order(&suitable_orders, order);
> +               }
>         } else {
>                 pages =3D 1;
>                 folio =3D shmem_alloc_folio(gfp, info, index);
> @@ -1678,6 +1795,7 @@ static struct folio *shmem_alloc_and_add_folio(gfp_=
t gfp,
>         if (!folio)
>                 return ERR_PTR(-ENOMEM);
>
> +allocated:
>         __folio_set_locked(folio);
>         __folio_set_swapbacked(folio);
>
> @@ -1972,7 +2090,8 @@ static int shmem_get_folio_gfp(struct inode *inode,=
 pgoff_t index,
>         struct mm_struct *fault_mm;
>         struct folio *folio;
>         int error;
> -       bool alloced;
> +       bool alloced, huge;
> +       unsigned long orders =3D 0;
>
>         if (WARN_ON_ONCE(!shmem_mapping(inode->i_mapping)))
>                 return -EINVAL;
> @@ -2044,14 +2163,18 @@ static int shmem_get_folio_gfp(struct inode *inod=
e, pgoff_t index,
>                 return 0;
>         }
>
> -       if (shmem_is_huge(inode, index, false, fault_mm,
> -                         vma ? vma->vm_flags : 0)) {
> +       huge =3D shmem_is_huge(inode, index, false, fault_mm,
> +                            vma ? vma->vm_flags : 0);
> +       /* Find hugepage orders that are allowed for anonymous shmem. */
> +       if (vma && vma_is_anon_shmem(vma))
> +               orders =3D anon_shmem_allowable_huge_orders(inode, vma, i=
ndex, huge);
> +       if (huge || orders > 0) {
>                 gfp_t huge_gfp;
>
>                 huge_gfp =3D vma_thp_gfp_mask(vma);
>                 huge_gfp =3D limit_gfp_mask(huge_gfp, gfp);
> -               folio =3D shmem_alloc_and_add_folio(huge_gfp,
> -                               inode, index, fault_mm, true);
> +               folio =3D shmem_alloc_and_add_folio(vmf, huge_gfp,
> +                               inode, index, fault_mm, true, orders);
>                 if (!IS_ERR(folio)) {
>                         if (folio_test_pmd_mappable(folio))
>                                 count_vm_event(THP_FILE_ALLOC);
> @@ -2061,7 +2184,7 @@ static int shmem_get_folio_gfp(struct inode *inode,=
 pgoff_t index,
>                         goto repeat;
>         }
>
> -       folio =3D shmem_alloc_and_add_folio(gfp, inode, index, fault_mm, =
false);
> +       folio =3D shmem_alloc_and_add_folio(vmf, gfp, inode, index, fault=
_mm, false, 0);
>         if (IS_ERR(folio)) {
>                 error =3D PTR_ERR(folio);
>                 if (error =3D=3D -EEXIST)
> @@ -2072,7 +2195,7 @@ static int shmem_get_folio_gfp(struct inode *inode,=
 pgoff_t index,
>
>  alloced:
>         alloced =3D true;
> -       if (folio_test_pmd_mappable(folio) &&
> +       if (folio_test_large(folio) &&
>             DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE) <
>                                         folio_next_index(folio) - 1) {
>                 struct shmem_sb_info *sbinfo =3D SHMEM_SB(inode->i_sb);
> --
> 2.39.3
>

