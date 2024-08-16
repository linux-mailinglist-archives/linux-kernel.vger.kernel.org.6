Return-Path: <linux-kernel+bounces-290092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 050E7954F4C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739D71F23165
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D702C1BE241;
	Fri, 16 Aug 2024 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AF+FxcVK"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53FD179A3
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723827021; cv=none; b=EEBR/q89aTVnFLXD/co4I+7WywJnN16ygnGzTM+zesHMtcGXgroGZZ1o/lqqYfKq7R060/2b8OnqkfToziMV477TtA4JlcgfuJDxi7W/pU03DCOmfNhUD7WO2++NjQknNnUnScRpSA7mnxt1XOEU2gnSvFT49DkuwPTHUMLbbEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723827021; c=relaxed/simple;
	bh=MaCUBDAHpAGmloySeDLFgOlPe5DwvJ+9qS9Sgh81xGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cIwr/a4w9ZrnD664eKz6f/q/NhPYVsRF2xjHjflYweECq4QssJmLYh8QXgjwUpfYsLG1Zq6bm649YwL0DQnNg7S4SiuE4yV2/gFR46yjYdPrqAnoIz/utOoUaveXfkvrPE1T/r4+SaHhdyXl3lUhkrIuTVtGhAfwjeAaaYZbP8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AF+FxcVK; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f025b94e07so24647761fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723827018; x=1724431818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zulkl78vUfEpDmCfMVVTaarojiyuM5236F7awC7fIZE=;
        b=AF+FxcVKazIGLpD03RqDN7fZtB4kLJrKqdaqJtwip9wLdmMIYE3bQaOfLYmjFpGLAx
         gbKE8RVNSJhbfZFWBCfflVOU+hDL3PfAWSYCZofYOp94SbG+iCIq0xZZeCjwpPawQ1ah
         EDJbThkl6AvYRWHR9R4sgbyMiL5aCIFYBWIwJz7c0Sc1UR1VJk1vEkXwg8AeBffd7UM8
         nMwdWGCYf6OXMr3ENIk56+9O/CVAy8ApFhVXGdtuAUbBsiuRWscvIs895ggCzFAuGj5P
         eT772QeIEJYKymZsVR9beD3TkMEX7FYdsdk8AGeYnHqDPsiRty0rwcWn5cBC98TbFvT3
         PMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723827018; x=1724431818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zulkl78vUfEpDmCfMVVTaarojiyuM5236F7awC7fIZE=;
        b=EHR1zB45mQK2NNd8Q4lmHhascPX3IXSFjsT+5HGTkK1nR+wVRoMzXsT3dToyztDtGI
         eGVPZjaFzVU48FTA+yqNB8KJm0OiADl8jeAjiE2BLESXLyg+8nIh8Hst/t0MWsSSik1g
         3VyZtn3yRX//RhGFia36MQ85ywuyQZ4adj6YjdJGM3rwEQYh35mod5zF2pdIFxy3l5UZ
         oNJjBaB3c25ysLIcZ9bfKziwr5IFXndcy3AkWEl9K/5d+z7UDuhnemBgVjKiyLbjHHyS
         3TAN7Wjp3P+SR5jzdZlR4fGw7boNcnaxOQMzhAQ+txRp2LnoV60LsrenwSEdCoVhGiI+
         wfog==
X-Forwarded-Encrypted: i=1; AJvYcCXveuVym2cqdJv2vgLKDdeJiFrhiX6U+pqQrRDkfyhImmWnAQ6xZLVTWmWYffPW5kg121gxHcQhIN01Idl/2l5Adyu/CM6V2V394ggw
X-Gm-Message-State: AOJu0Yz9FQdJVYHyjEIukcEyFLpb7ZgaeRLm/8bBuGo7yoOj7+9ONAMc
	ApCIR1WI1c49Gy1VnnCyRgGpMmvndTtm6SOAnY0x0joc6JZ7Js5R2ss4fKRgYGITn/osO+WG8mi
	u76Z0c5CETuCZjlVmtAg3kA4oOLs=
X-Google-Smtp-Source: AGHT+IFvpmisqcO91HL15XeFzWURZYYRUwYHM3lSoqrS35PxXofn7CCaVaQEg3qDLh7FezaHL0PD+OhC7LwLemjnvbw=
X-Received: by 2002:a05:651c:1543:b0:2ef:2247:9881 with SMTP id
 38308e7fff4ca-2f3be5fb455mr24819501fa.31.1723827017235; Fri, 16 Aug 2024
 09:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20ed69ad-5dad-446b-9f01-86ad8b1c67fa@huawei.com> <20240815230612.77266-1-21cnbao@gmail.com>
In-Reply-To: <20240815230612.77266-1-21cnbao@gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 17 Aug 2024 00:50:00 +0800
Message-ID: <CAMgjq7AeVkmOiVFa4-iP4nbyX3LHft_5wfvV_raj_N+twdzMKQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] mm: support large folios swap-in for zRAM-like devices
To: Barry Song <21cnbao@gmail.com>
Cc: wangkefeng.wang@huawei.com, akpm@linux-foundation.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hanchuanhua@oppo.com, hannes@cmpxchg.org, hch@infradead.org, hughd@google.com, 
	kaleshsingh@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mhocko@suse.com, minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	senozhatsky@chromium.org, shakeel.butt@linux.dev, shy828301@gmail.com, 
	surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 7:06=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Fri, Aug 16, 2024 at 1:27=E2=80=AFAM Kefeng Wang <wangkefeng.wang@huaw=
ei.com> wrote:
> >
> >
> >
> > On 2024/8/15 17:47, Kairui Song wrote:
> > > On Fri, Aug 2, 2024 at 8:21=E2=80=AFPM Barry Song <21cnbao@gmail.com>=
 wrote:
> > >>
> > >> From: Chuanhua Han <hanchuanhua@oppo.com>
> > >
> > > Hi Chuanhua,
> > >
> > >>
> > ...
> >
> > >> +
> > >> +static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> > >> +{
> > >> +       struct vm_area_struct *vma =3D vmf->vma;
> > >> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > >> +       unsigned long orders;
> > >> +       struct folio *folio;
> > >> +       unsigned long addr;
> > >> +       swp_entry_t entry;
> > >> +       spinlock_t *ptl;
> > >> +       pte_t *pte;
> > >> +       gfp_t gfp;
> > >> +       int order;
> > >> +
> > >> +       /*
> > >> +        * If uffd is active for the vma we need per-page fault fide=
lity to
> > >> +        * maintain the uffd semantics.
> > >> +        */
> > >> +       if (unlikely(userfaultfd_armed(vma)))
> > >> +               goto fallback;
> > >> +
> > >> +       /*
> > >> +        * A large swapped out folio could be partially or fully in =
zswap. We
> > >> +        * lack handling for such cases, so fallback to swapping in =
order-0
> > >> +        * folio.
> > >> +        */
> > >> +       if (!zswap_never_enabled())
> > >> +               goto fallback;
> > >> +
> > >> +       entry =3D pte_to_swp_entry(vmf->orig_pte);
> > >> +       /*
> > >> +        * Get a list of all the (large) orders below PMD_ORDER that=
 are enabled
> > >> +        * and suitable for swapping THP.
> > >> +        */
> > >> +       orders =3D thp_vma_allowable_orders(vma, vma->vm_flags,
> > >> +                       TVA_IN_PF | TVA_ENFORCE_SYSFS, BIT(PMD_ORDER=
) - 1);
> > >> +       orders =3D thp_vma_suitable_orders(vma, vmf->address, orders=
);
> > >> +       orders =3D thp_swap_suitable_orders(swp_offset(entry), vmf->=
address, orders);
> > >> +
> > >> +       if (!orders)
> > >> +               goto fallback;
> > >> +
> > >> +       pte =3D pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd, vmf->=
address & PMD_MASK, &ptl);
> > >> +       if (unlikely(!pte))
> > >> +               goto fallback;
> > >> +
> > >> +       /*
> > >> +        * For do_swap_page, find the highest order where the aligne=
d range is
> > >> +        * completely swap entries with contiguous swap offsets.
> > >> +        */
> > >> +       order =3D highest_order(orders);
> > >> +       while (orders) {
> > >> +               addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order=
);
> > >> +               if (can_swapin_thp(vmf, pte + pte_index(addr), 1 << =
order))
> > >> +                       break;
> > >> +               order =3D next_order(&orders, order);
> > >> +       }
> > >> +
> > >> +       pte_unmap_unlock(pte, ptl);
> > >> +
> > >> +       /* Try allocating the highest of the remaining orders. */
> > >> +       gfp =3D vma_thp_gfp_mask(vma);
> > >> +       while (orders) {
> > >> +               addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order=
);
> > >> +               folio =3D vma_alloc_folio(gfp, order, vma, addr, tru=
e);
> > >> +               if (folio)
> > >> +                       return folio;
> > >> +               order =3D next_order(&orders, order);
> > >> +       }
> > >> +
> > >> +fallback:
> > >> +#endif
> > >> +       return vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vmf->ad=
dress, false);
> > >> +}
> > >> +
> > >> +
> > >>   /*
> > >>    * We enter with non-exclusive mmap_lock (to exclude vma changes,
> > >>    * but allow concurrent faults), and pte mapped but not yet locked=
.
> > >> @@ -4074,35 +4220,37 @@ vm_fault_t do_swap_page(struct vm_fault *vmf=
)
> > >>          if (!folio) {
> > >>                  if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> > >>                      __swap_count(entry) =3D=3D 1) {
> > >> -                       /*
> > >> -                        * Prevent parallel swapin from proceeding w=
ith
> > >> -                        * the cache flag. Otherwise, another thread=
 may
> > >> -                        * finish swapin first, free the entry, and =
swapout
> > >> -                        * reusing the same entry. It's undetectable=
 as
> > >> -                        * pte_same() returns true due to entry reus=
e.
> > >> -                        */
> > >> -                       if (swapcache_prepare(entry, 1)) {
> > >> -                               /* Relax a bit to prevent rapid repe=
ated page faults */
> > >> -                               schedule_timeout_uninterruptible(1);
> > >> -                               goto out;
> > >> -                       }
> > >> -                       need_clear_cache =3D true;
> > >> -
> > >>                          /* skip swapcache */
> > >> -                       folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVAB=
LE, 0,
> > >> -                                               vma, vmf->address, f=
alse);
> > >> +                       folio =3D alloc_swap_folio(vmf);
> > >>                          page =3D &folio->page;
> > >>                          if (folio) {
> > >>                                  __folio_set_locked(folio);
> > >>                                  __folio_set_swapbacked(folio);
> > >>
> > >> +                               nr_pages =3D folio_nr_pages(folio);
> > >> +                               if (folio_test_large(folio))
> > >> +                                       entry.val =3D ALIGN_DOWN(ent=
ry.val, nr_pages);
> > >> +                               /*
> > >> +                                * Prevent parallel swapin from proc=
eeding with
> > >> +                                * the cache flag. Otherwise, anothe=
r thread may
> > >> +                                * finish swapin first, free the ent=
ry, and swapout
> > >> +                                * reusing the same entry. It's unde=
tectable as
> > >> +                                * pte_same() returns true due to en=
try reuse.
> > >> +                                */
> > >> +                               if (swapcache_prepare(entry, nr_page=
s)) {
> > >> +                                       /* Relax a bit to prevent ra=
pid repeated page faults */
> > >> +                                       schedule_timeout_uninterrupt=
ible(1);
> > >> +                                       goto out_page;
> > >> +                               }
> > >> +                               need_clear_cache =3D true;
> > >> +
> > >>                                  if (mem_cgroup_swapin_charge_folio(=
folio,
> > >>                                                          vma->vm_mm,=
 GFP_KERNEL,
> > >>                                                          entry)) {
> > >>                                          ret =3D VM_FAULT_OOM;
> > >>                                          goto out_page;
> > >>                                  }
> > >
> > > After your patch, with build kernel test, I'm seeing kernel log
> > > spamming like this:
> > > [  101.048594] pagefault_out_of_memory: 95 callbacks suppressed
> > > [  101.048599] Huh VM_FAULT_OOM leaked out to the #PF handler. Retryi=
ng PF
> > > [  101.059416] Huh VM_FAULT_OOM leaked out to the #PF handler. Retryi=
ng PF
> > > [  101.118575] Huh VM_FAULT_OOM leaked out to the #PF handler. Retryi=
ng PF
> > > [  101.125585] Huh VM_FAULT_OOM leaked out to the #PF handler. Retryi=
ng PF
> > > [  101.182501] Huh VM_FAULT_OOM leaked out to the #PF handler. Retryi=
ng PF
> > > [  101.215351] Huh VM_FAULT_OOM leaked out to the #PF handler. Retryi=
ng PF
> > > [  101.272822] Huh VM_FAULT_OOM leaked out to the #PF handler. Retryi=
ng PF
> > > [  101.403195] Huh VM_FAULT_OOM leaked out to the #PF handler. Retryi=
ng PF
> > > ............
> > >
> > > And heavy performance loss with workloads limited by memcg, mTHP enab=
led.
> > >
> > > After some debugging, the problematic part is the
> > > mem_cgroup_swapin_charge_folio call above.
> > > When under pressure, cgroup charge fails easily for mTHP. One 64k
> > > swapin will require a much more aggressive reclaim to success.
> > >
> > > If I change MAX_RECLAIM_RETRIES from 16 to 512, the spamming log is
> > > gone and mTHP swapin should have a much higher swapin success rate.
> > > But this might not be the right way.
> > >
> > > For this particular issue, maybe you can change the charge order, try
> > > charging first, if successful, use mTHP. if failed, fallback to 4k?
> >
> > This is what we did in alloc_anon_folio(), see 085ff35e7636
> > ("mm: memory: move mem_cgroup_charge() into alloc_anon_folio()"),
> > 1) fallback earlier
> > 2) using same GFP flags for allocation and charge
> >
> > but it seems that there is a little complicated for swapin charge
>
> Kefeng, thanks! I guess we can continue using the same approach and
> it's not too complicated.
>
> Kairui, sorry for the trouble and thanks for the report! could you
> check if the solution below resolves the issue? On phones, we don't
> encounter the scenarios you=E2=80=99re facing.
>
> From 2daaf91077705a8fa26a3a428117f158f05375b0 Mon Sep 17 00:00:00 2001
> From: Barry Song <v-songbaohua@oppo.com>
> Date: Fri, 16 Aug 2024 10:51:48 +1200
> Subject: [PATCH] mm: fallback to next_order if charing mTHP fails
>
> When memcg approaches its limit, charging mTHP becomes difficult.
> At this point, when the charge fails, we fallback to the next order
> to avoid repeatedly retrying larger orders.
>
> Reported-by: Kairui Song <ryncsn@gmail.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/memory.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 0ed3603aaf31..6cba28ef91e7 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4121,8 +4121,12 @@ static struct folio *alloc_swap_folio(struct vm_fa=
ult *vmf)
>         while (orders) {
>                 addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
>                 folio =3D vma_alloc_folio(gfp, order, vma, addr, true);
> -               if (folio)
> -                       return folio;
> +               if (folio) {
> +                       if (!mem_cgroup_swapin_charge_folio(folio,
> +                                       vma->vm_mm, gfp, entry))
> +                               return folio;
> +                       folio_put(folio);
> +               }
>                 order =3D next_order(&orders, order);
>         }
>
> @@ -4244,7 +4248,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                                 }
>                                 need_clear_cache =3D true;
>
> -                               if (mem_cgroup_swapin_charge_folio(folio,
> +                               if (nr_pages =3D=3D 1 && mem_cgroup_swapi=
n_charge_folio(folio,
>                                                         vma->vm_mm, GFP_K=
ERNEL,
>                                                         entry)) {
>                                         ret =3D VM_FAULT_OOM;
> --
> 2.34.1
>

Hi Barry

After the fix the spamming log is gone, thanks for the fix.

>
> Thanks
> Barry
>

