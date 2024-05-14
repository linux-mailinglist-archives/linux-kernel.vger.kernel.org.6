Return-Path: <linux-kernel+bounces-178412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6D18C4D3D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 09:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8BE8B21A60
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 07:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46A314A85;
	Tue, 14 May 2024 07:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToKtV0wL"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDEC1CFBE
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715672616; cv=none; b=sWhAKkCOK05edmJ6h2Ri9qnCj14/sPwamVG/rp6db1tklMtpKTLe3xAwidWo49Tmnfp0ftAkZTSNeA+8BWX20a8A2KsETdd02GPd2JaFnyv+BDX1B5Ou09XBNEbfeIZJW5edgb6hzYz967ElVvsqWXKpgFUxngE+xwsB5sYrSKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715672616; c=relaxed/simple;
	bh=0jkJlR9ATeBDrDLZcOfKD2f312tTo0MhL9TABgmCgvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AXSz5YcEqOquLxrR0TXq9Qwo3pMTN3tk7s4RyUd/JEjfIFDKdfUX6cIRG0f4yok1vxO8sefZ9qwbdB9/MHoEFo1/eh/Q+A4jbeSR0uqg0Tb6G+lj/nvlKjYk+zS7LxK6Y1zeyvJ4uKiGlC1vaDnmT1KmwWcGAUYCX+5b2QYCfFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToKtV0wL; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5231efd80f2so2577905e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 00:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715672613; x=1716277413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/VccQWyT8Bx973VMOtP8EZFRmihEF3ZYyQtstggVOo=;
        b=ToKtV0wLuYnHzZAFt4k82RwVrY3jyk6lGpkAc0R+130f03bCNyPkSTpD+HMWooDumc
         rSsWyXn9xTzQmhuavkzgokYVylo5rCd+fe/DUbZSNIZR13ItnBm4SJvHTA5wgX3tOMTh
         nBbrQbaGuuNfm85trcuH/lcNayZmqZ5MybTrPzWa3JlMshswGua5libdk26aVj7f3AbK
         cGo3Yv0Bl3YCmobaPbOxI0CRpGzATQFxEGRaXJyrq+ywAoPhFMu2bUrAB9alQI2a/zPh
         jQ/+ofLFYnApjIGNuTuefyUwd7WUKUq7yZahAlntEa6GDGsYoFXFwG3oipX7qQlN7ADg
         2XBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715672613; x=1716277413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/VccQWyT8Bx973VMOtP8EZFRmihEF3ZYyQtstggVOo=;
        b=TCbxyU7SYBJ2Rh3P627kG95qRDhjTdRjopJc/VYzduPJhnlEgJRsotOyGto7sTPOVr
         kimaOmhx0+F/E/bl8wXq029F3hzxPnk0Q2oXnhEMGvCO1LxyNKt0pZnKIdLFsh7fP9gU
         EV9mM/L41ePjr8Dm2t/jFgWF9H6JyiQEjuDhJrpolvp0Hkt2x5j2f71b2+Im+WEsxokk
         a8mCQyaPNMRDo2o5swJnz5es8Sxdwv6JKSV55fMMA63/1XMZk5tqXS25FQNwpEqB0bDT
         2DenZK2TGi9WYn8c0uemGkTRjtDG+cNBXzTBLy8I9PGEn9tDuPiTSOB5cMD6kUzhlPXd
         ikKA==
X-Forwarded-Encrypted: i=1; AJvYcCX+v7CMkTDdUliGg7jdYJYBiadxHh/q93ss1Qc19HchgpmzeXxuvJUitFAMbFNWqRARQEdUjOg/eH/PXMxWmuanGDgBRoLgKNdlLNT5
X-Gm-Message-State: AOJu0YxHEolgZ42gGoPC9fxvL+moIS0a1fp+OdOO292QXxiSBkMQeGnP
	W75ErGuXIu6Cxi8Tug33cO++hdJXDveOmLDXXFx+0SXcevJrFsM0y0IIKgY3se/jNVtO/M/UUWz
	40PPoA0FN4bHREiBxUwSpmm/qzJY=
X-Google-Smtp-Source: AGHT+IHt/JG/ZmyYJllBadnZEpOgJdbG23o910zsW8NOLQGvVoLctHNUu6CNAiEUCuUCPRMHRWRrw2hAWvJKHZ/NG1A=
X-Received: by 2002:a05:6512:158d:b0:519:5df9:d945 with SMTP id
 2adb3069b0e04-5220fb77429mr10837058e87.4.1715672613267; Tue, 14 May 2024
 00:43:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513074712.7608-1-ioworker0@gmail.com> <20240513074712.7608-2-ioworker0@gmail.com>
 <2ec286a2-4620-4e6d-ad3d-9b4c0d9e1394@linux.alibaba.com>
In-Reply-To: <2ec286a2-4620-4e6d-ad3d-9b4c0d9e1394@linux.alibaba.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 14 May 2024 15:43:21 +0800
Message-ID: <CAK1f24maLXzb012QOiVitcb-+7gi=64scCtW4H3LLFvbZs7QGw@mail.gmail.com>
Subject: Re: [PATCH RESEND v5 1/4] mm/rmap: remove duplicated exit code in
 pagewalk loop
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org, 
	maskray@google.com, ziy@nvidia.com, ryan.roberts@arm.com, david@redhat.com, 
	21cnbao@gmail.com, mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com, 
	shy828301@gmail.com, xiehuan09@gmail.com, libang.li@antgroup.com, 
	wangkefeng.wang@huawei.com, songmuchun@bytedance.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Baolin,

Thanks for taking time to review!

Best,
Lance

On Tue, May 14, 2024 at 2:26=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2024/5/13 15:47, Lance Yang wrote:
> > Introduce the labels walk_done and walk_done_err as exit points to
> > eliminate duplicated exit code in the pagewalk loop.
> >
> > Reviewed-by: Zi Yan <ziy@nvidia.com>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
>
> LGTM.
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>
> > ---
> >   mm/rmap.c | 40 +++++++++++++++-------------------------
> >   1 file changed, 15 insertions(+), 25 deletions(-)
> >
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index e8fc5ecb59b2..ddffa30c79fb 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1679,9 +1679,7 @@ static bool try_to_unmap_one(struct folio *folio,=
 struct vm_area_struct *vma,
> >                       /* Restore the mlock which got missed */
> >                       if (!folio_test_large(folio))
> >                               mlock_vma_folio(folio, vma);
> > -                     page_vma_mapped_walk_done(&pvmw);
> > -                     ret =3D false;
> > -                     break;
> > +                     goto walk_done_err;
> >               }
> >
> >               pfn =3D pte_pfn(ptep_get(pvmw.pte));
> > @@ -1719,11 +1717,8 @@ static bool try_to_unmap_one(struct folio *folio=
, struct vm_area_struct *vma,
> >                        */
> >                       if (!anon) {
> >                               VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
> > -                             if (!hugetlb_vma_trylock_write(vma)) {
> > -                                     page_vma_mapped_walk_done(&pvmw);
> > -                                     ret =3D false;
> > -                                     break;
> > -                             }
> > +                             if (!hugetlb_vma_trylock_write(vma))
> > +                                     goto walk_done_err;
> >                               if (huge_pmd_unshare(mm, vma, address, pv=
mw.pte)) {
> >                                       hugetlb_vma_unlock_write(vma);
> >                                       flush_tlb_range(vma,
> > @@ -1738,8 +1733,7 @@ static bool try_to_unmap_one(struct folio *folio,=
 struct vm_area_struct *vma,
> >                                        * actual page and drop map count
> >                                        * to zero.
> >                                        */
> > -                                     page_vma_mapped_walk_done(&pvmw);
> > -                                     break;
> > +                                     goto walk_done;
> >                               }
> >                               hugetlb_vma_unlock_write(vma);
> >                       }
> > @@ -1811,9 +1805,7 @@ static bool try_to_unmap_one(struct folio *folio,=
 struct vm_area_struct *vma,
> >                       if (unlikely(folio_test_swapbacked(folio) !=3D
> >                                       folio_test_swapcache(folio))) {
> >                               WARN_ON_ONCE(1);
> > -                             ret =3D false;
> > -                             page_vma_mapped_walk_done(&pvmw);
> > -                             break;
> > +                             goto walk_done_err;
> >                       }
> >
> >                       /* MADV_FREE page check */
> > @@ -1852,23 +1844,17 @@ static bool try_to_unmap_one(struct folio *foli=
o, struct vm_area_struct *vma,
> >                                */
> >                               set_pte_at(mm, address, pvmw.pte, pteval)=
;
> >                               folio_set_swapbacked(folio);
> > -                             ret =3D false;
> > -                             page_vma_mapped_walk_done(&pvmw);
> > -                             break;
> > +                             goto walk_done_err;
> >                       }
> >
> >                       if (swap_duplicate(entry) < 0) {
> >                               set_pte_at(mm, address, pvmw.pte, pteval)=
;
> > -                             ret =3D false;
> > -                             page_vma_mapped_walk_done(&pvmw);
> > -                             break;
> > +                             goto walk_done_err;
> >                       }
> >                       if (arch_unmap_one(mm, vma, address, pteval) < 0)=
 {
> >                               swap_free(entry);
> >                               set_pte_at(mm, address, pvmw.pte, pteval)=
;
> > -                             ret =3D false;
> > -                             page_vma_mapped_walk_done(&pvmw);
> > -                             break;
> > +                             goto walk_done_err;
> >                       }
> >
> >                       /* See folio_try_share_anon_rmap(): clear PTE fir=
st. */
> > @@ -1876,9 +1862,7 @@ static bool try_to_unmap_one(struct folio *folio,=
 struct vm_area_struct *vma,
> >                           folio_try_share_anon_rmap_pte(folio, subpage)=
) {
> >                               swap_free(entry);
> >                               set_pte_at(mm, address, pvmw.pte, pteval)=
;
> > -                             ret =3D false;
> > -                             page_vma_mapped_walk_done(&pvmw);
> > -                             break;
> > +                             goto walk_done_err;
> >                       }
> >                       if (list_empty(&mm->mmlist)) {
> >                               spin_lock(&mmlist_lock);
> > @@ -1918,6 +1902,12 @@ static bool try_to_unmap_one(struct folio *folio=
, struct vm_area_struct *vma,
> >               if (vma->vm_flags & VM_LOCKED)
> >                       mlock_drain_local();
> >               folio_put(folio);
> > +             continue;
> > +walk_done_err:
> > +             ret =3D false;
> > +walk_done:
> > +             page_vma_mapped_walk_done(&pvmw);
> > +             break;
> >       }
> >
> >       mmu_notifier_invalidate_range_end(&range);

