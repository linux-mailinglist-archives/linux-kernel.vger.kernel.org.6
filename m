Return-Path: <linux-kernel+bounces-218541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AC290C1AB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A81F51F23341
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71DD1C2A8;
	Tue, 18 Jun 2024 01:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMWmskBQ"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2691AAC4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 01:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718675826; cv=none; b=aQ+qbpmeB8s8lulKhspXGYXWQuWbEMVMGJmiucnO5ZfA/LoyZ0TjQCLpnyocjNnmrHIp2YWVirjMiszk+5kLp7ZTKjiyIoOX3lKggpiEczKS284qWE4A3P/cjV65KvSQOA/i0xw4Dj7dwDJJmJIZz7pyWdbJ8ZCPYr+kwMcUdHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718675826; c=relaxed/simple;
	bh=odAnsVgnE7y15a0UvI6TvSybOS6OLblSm+qtLSwK3QE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HewKe0hZureA9zW69DZhkJCuDoaJINELhA2KxWBjDtTTONJQn1bqQpGfritJsfZqjTNIpVvzGYc5C0kB85gUBjCgE3HTUD4ITrCyHe+BOr1TToSu4A3/hD5UUMO2xo+9x+cX2x0ot+a5Kjw9BwnF3Fa+ODt6yXuKtWb55+hk6es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMWmskBQ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57c75464e77so5975098a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 18:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718675823; x=1719280623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wae8M8t+Wn0YykTgf7N/e/0Ifm2hpdV8ttPW81oP2Ak=;
        b=PMWmskBQumqJp6aayGfJh+f1Y/WWqByxBFoKZgRZd6//OCAEiWdtPixz04vX2E2Dgi
         otdD9oTdA5c9186WPZxJl4rWDyMCsYHdFd99gDdfQ1Gp1reEUUIhLlQJrR4Bcmum2NNO
         mbKucim7EqXq3gjqKd/6WVMyebvw0o9OyBVplcAWqgd2ON+JEHJV9XJDgnYUi7xtGXyi
         NthUE8P057Ec6fm5ftuo4W0GzLfGELfWMThMsQOp4EAIu3HxxS1IzG4VTSI0WjanyhjL
         jWP2k9Sox8CeIG1UMSkjS9IakUtkMcBfEEfwzunnK2HHiu8sS9Knq66u60dPeRuK4DvC
         PzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718675823; x=1719280623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wae8M8t+Wn0YykTgf7N/e/0Ifm2hpdV8ttPW81oP2Ak=;
        b=jkzdJ3LvEH5+LrLxB9cSfO8+5XFso+ZkHc2wCGPwyMTD40rg4huo/Wz+3k01OBe/gQ
         xNP0IHgHEivIPxd9f3Kw72Pm4dS5i/VTZkNUOUC3rlkBNnFAURPPSQAmbEW0yzycU5Xa
         cSx/t2LmHkUZ5zn33OZLNauHz2TbzLQ9OsD0zxqHSC1gE55L4jKSsuvlJ8aM2byK59PJ
         L8APzKIc4/L4USWa69sw5cWkARcDZ5qsk/bwLvoH1RnGxGkvK0+o8Zxa1IJRbHB+5i+m
         Tp+USRIJpynGJQ8JufaX0A49AwGCzq19YQuZQTMIBFElSXX8MqmOeYucvdEV1bJ2yGNK
         Q7SA==
X-Forwarded-Encrypted: i=1; AJvYcCUjG7uovIDuTcVDdsMWAQbE6o1fj3470VRWWNpfv8gwAUsZiL7Gfdy40ZKUI6cPTQrGWWviNA6/uR0IZa8Txj3YUV4CWoMAq7ad9Q7d
X-Gm-Message-State: AOJu0YzL0fwqNIACg5/yZe4gsgYOMRBUB9o7by2Brb2wxcErDAPzoJ9/
	iKWt1mjR++MWtb9GSiyvwbfUph/WTOVre2X3CyhS2WSBH+vW1Eb4KjOf6n5NYgiiFtgiek+mGWe
	ozbx/8vE5ziKdSduLkJkKn9wov68=
X-Google-Smtp-Source: AGHT+IF75sPalUePJwA4s9srnEf6OaVwVv/+ZRszkXP2keldbLUTIdhmHDwB7fEMt/PwKK1/GGubep5KLtiyfb8sFkI=
X-Received: by 2002:a50:8d45:0:b0:57c:713c:cdbf with SMTP id
 4fb4d7f45d1cf-57cbd8b9828mr7320014a12.38.1718675822477; Mon, 17 Jun 2024
 18:57:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614015138.31461-1-ioworker0@gmail.com> <20240614015138.31461-4-ioworker0@gmail.com>
 <e7c0aff1-b690-4926-9a34-4e32c9f3faaa@redhat.com>
In-Reply-To: <e7c0aff1-b690-4926-9a34-4e32c9f3faaa@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 18 Jun 2024 09:56:51 +0800
Message-ID: <CAK1f24kaGo3PJSd83=-t_uAFTTJiSsZvJTmsX9co4ueFDiPneA@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] mm/vmscan: avoid split lazyfree THP during shrink_folio_list()
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org, 
	baolin.wang@linux.alibaba.com, maskray@google.com, ziy@nvidia.com, 
	ryan.roberts@arm.com, 21cnbao@gmail.com, mhocko@suse.com, 
	fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com, 
	xiehuan09@gmail.com, libang.li@antgroup.com, wangkefeng.wang@huawei.com, 
	songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 2:04=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> Sorry for taking so long to review ... getting there. Mostly nits.

No worries at all :)

Thanks for taking time to review!

>
> > @@ -497,6 +499,13 @@ static inline void split_huge_pmd_locked(struct vm=
_area_struct *vma,
> >                                        unsigned long address, pmd_t *pm=
d,
> >                                        bool freeze, struct folio *folio=
) {}
> >
> > +static inline bool unmap_huge_pmd_locked(struct vm_area_struct *vma,
> > +                                      unsigned long addr, pmd_t *pmdp,
> > +                                      struct folio *folio)
> > +{
> > +     return false;
> > +}
> > +
> >   #define split_huge_pud(__vma, __pmd, __address)     \
> >       do { } while (0)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index e766d3f3a302..425374ae06ed 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2688,6 +2688,82 @@ static void unmap_folio(struct folio *folio)
> >       try_to_unmap_flush();
> >   }
> >
> > +static bool __discard_anon_folio_pmd_locked(struct vm_area_struct *vma=
,
> > +                                         unsigned long addr, pmd_t *pm=
dp,
> > +                                         struct folio *folio)
> > +{
> > +     VM_WARN_ON_FOLIO(folio_test_swapbacked(folio), folio);
> > +     VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
>
> I would drop these (that's exactly what the single caller checks). In

Agreed. I will drop these.

> any case don't place them above the variable declaration ;)

Yep, I see.

>
> > +
> > +     struct mm_struct *mm =3D vma->vm_mm;
> > +     int ref_count, map_count;
> > +     pmd_t orig_pmd =3D *pmdp;
> > +     struct page *page;
> > +
> > +     if (unlikely(!pmd_present(orig_pmd) || !pmd_trans_huge(orig_pmd))=
)
> > +             return false;
> > +
> > +     page =3D pmd_page(orig_pmd);
> > +     if (unlikely(page_folio(page) !=3D folio))
> > +             return false;
>
> I'm curious, how could that happen? And how could it happen that we have
> !pmd_trans_huge() ? Didn't rmap walking code make sure that this PMD
> maps the folio already, and we are holding the PTL?

Makes sense to me. I was adding these just in case, but it's probably too m=
uch.

Let's drop them ;)

>
> > +
> > +     if (folio_test_dirty(folio) || pmd_dirty(orig_pmd))
> > +             return false;
> > +
> > +     orig_pmd =3D pmdp_huge_clear_flush(vma, addr, pmdp);
> > +
> > +     /*
> > +      * Syncing against concurrent GUP-fast:
> > +      * - clear PMD; barrier; read refcount
> > +      * - inc refcount; barrier; read PMD
> > +      */
> > +     smp_mb();
> > +
> > +     ref_count =3D folio_ref_count(folio);
> > +     map_count =3D folio_mapcount(folio);
> > +
> > +     /*
> > +      * Order reads for folio refcount and dirty flag
> > +      * (see comments in __remove_mapping()).
> > +      */
> > +     smp_rmb();
> > +
> > +     /*
> > +      * If the folio or its PMD is redirtied at this point, or if ther=
e
> > +      * are unexpected references, we will give up to discard this fol=
io
> > +      * and remap it.
> > +      *
> > +      * The only folio refs must be one from isolation plus the rmap(s=
).
> > +      */
> > +     if (folio_test_dirty(folio) || pmd_dirty(orig_pmd) ||
> > +         ref_count !=3D map_count + 1) {
> > +             set_pmd_at(mm, addr, pmdp, orig_pmd);
> > +             return false;
> > +     }
> > +
> > +     folio_remove_rmap_pmd(folio, page, vma);
> > +     zap_deposited_table(mm, pmdp);
> > +     add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
> > +     if (vma->vm_flags & VM_LOCKED)
> > +             mlock_drain_local();
> > +     folio_put(folio);
> > +
> > +     return true;
> > +}
> > +
> > +bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long a=
ddr,
> > +                        pmd_t *pmdp, struct folio *folio)
> > +{
> > +     VM_WARN_ON_FOLIO(!folio_test_pmd_mappable(folio), folio);
> > +     VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
> > +     VM_WARN_ON_ONCE(!IS_ALIGNED(addr, HPAGE_PMD_SIZE));
> > +
> > +     if (folio_test_anon(folio) && !folio_test_swapbacked(folio))
> > +             return __discard_anon_folio_pmd_locked(vma, addr, pmdp, f=
olio);
> > +
> > +     return false;
> > +}
> > +
> >   static void remap_page(struct folio *folio, unsigned long nr)
> >   {
> >       int i =3D 0;
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index dacf24bc82f0..7d97806f74cd 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1678,16 +1678,23 @@ static bool try_to_unmap_one(struct folio *foli=
o, struct vm_area_struct *vma,
> >                       goto walk_abort;
> >               }
> >
> > -             if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
> > -                     /*
> > -                      * We temporarily have to drop the PTL and start =
once
> > -                      * again from that now-PTE-mapped page table.
> > -                      */
> > -                     split_huge_pmd_locked(vma, pvmw.address, pvmw.pmd=
,
> > -                                           false, folio);
> > -                     flags &=3D ~TTU_SPLIT_HUGE_PMD;
> > -                     page_vma_mapped_walk_restart(&pvmw);
> > -                     continue;
> > +             if (!pvmw.pte) {
> > +                     if (unmap_huge_pmd_locked(vma, pvmw.address, pvmw=
.pmd,
> > +                                               folio))
> > +                             goto walk_done;
> > +
> > +                     if (flags & TTU_SPLIT_HUGE_PMD) {
> > +                             /*
> > +                              * We temporarily have to drop the PTL an=
d start
> > +                              * once again from that now-PTE-mapped pa=
ge
> > +                              * table.
>
> Nit: it's not a PTE-mapped page table.
>
> Maybe
>
> "... restart so we can process the PTE-mapped THP."

Nice. Will adjust as you suggested.

>
>
>
> >               }
> >
> >               /* Unexpected PMD-mapped THP? */
>
> Nothing else jumped at me :)

Thanks again for your time!
Lance

>
> --
> Cheers,
>
> David / dhildenb
>

