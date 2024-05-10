Return-Path: <linux-kernel+bounces-175519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7E08C20BE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0274A286F28
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1714516132C;
	Fri, 10 May 2024 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0nWqcO1"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D71115ECFC
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332768; cv=none; b=KlTnHuVdKQSE+MAUOROJGOgdCKcijsqppF3zN7PgI9P3X+YMeg9PYH2yEtBkJtZYQ5wf0LL86UggaITziDGCG5MHBC76gmwdiVZSo10Yp1T4ZvTpzAfnbSWo5LWyO++P9m8hZ0h/+Wgef+H9/4D6hG0w2cujXHCnT8dbp5lfqac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332768; c=relaxed/simple;
	bh=4ikwhSOG2kr9jeHmsF3QaKrCUASm16FF8rgh+Txf5Gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgOJ1nJ55UEanke7vp8qDI51O73KQD/dfn2KcxHXYAvOjy73oGYYW5wgOvR+/YYYBAY33HWQwVmDMLtN5jxeCABZpmfM5WkmK5M2Q6pN9zAwTd88n+XOL5/6qFTn5IRYmH/mLnKuHqErx8DPycA876zQ+UODhORtpq6OB09R0jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0nWqcO1; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51f74fa2a82so2117984e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 02:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715332764; x=1715937564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fwcye2cmMvVkzOb2RmQWM8DhgejhAa5fax0EB+I/fqo=;
        b=a0nWqcO1hTV7cwpTIaAk65+Laf8M4/VJjB8vbUkl24eBGhWmtfCSYZ7W9eWFSVLNxp
         aQGiVrtskSvDO1JqRxMnnemszidQdogw4OAewJytPV7aIG+bdemEAL2oA5n93AgZcl5L
         b6gteTuc1RnkPW31nF/cReT8BTJf4k54WfQ7SLsl2QBCtxXZ5fnRP8nl1V4KYwVncne7
         q2girEYEOpUS0MDFTP4f/gZLsXXZaUDkmOIyOYwI4VFHzlS/0omdcFO3dyi7+GP1Fnsw
         REBzHOc0bXPq+b/2iGhimk+GcjxM2rr0Ikq86NXyxhl1rI933SEJxqkL4LIOF1EVuolj
         gdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715332764; x=1715937564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fwcye2cmMvVkzOb2RmQWM8DhgejhAa5fax0EB+I/fqo=;
        b=BRcbYYpGf806qAxTkRGNnqFAJBJ+R860zCarPoCEXKjKchZp7/WTa63BIwpj9/cxsp
         fn7A3MvCxnrgU7ccbCbGASY+NKx6cx/yW2C68ZK9DMlEB6c4+LTFjIm3zADjxFI2c9SD
         YcT1LTjW3fAOAiIzcTTKmF7C3jwk9qcm7q3gMV15o8xSCeU/Ita2iGl45nL+ZO59WEQD
         st09K9BY682DoaC4Uc2E/PReNrAoTSvqXXwD1Qs3/wwoUzsvY+GvOvx3nRDvMTJGtuZe
         XgIfTP1kZSSxkfFM+b2oARztGqUSavTdg2SDFqwtILYMDMsxW6SPPCX2AcQRX/vrUxRS
         jDGw==
X-Forwarded-Encrypted: i=1; AJvYcCWVZKXZhNfrU97CS+9fXcK3Yva6Z0kSb3HJ2Y1qc5wQn9CTVDvm0ZyrP+6GElEO92X2PbxXpvSai0l8qx1/FUK+GX+5eS0NtCu7OWV2
X-Gm-Message-State: AOJu0YxRoNbVd5GCdv8ybf9P048BynoEq3dwUOHJMHJNUctP0JnPhpWt
	Jb2zxsy3q9qL19310PT4WFLT2J+8eKpl+TNq+hPYHLNYi48bN9Yut4/PqGN4q4rsoUhNANdQD7X
	ktL842v04i4tDo4gvk7uaG87vF1o=
X-Google-Smtp-Source: AGHT+IHc8ejS+uh+vZ4ONq0UjpSRCAJS/lYZfonb8VrowpLbGOm9rPid8UtfVuCRbn1pG5g/TjPFUolkPn0uDb6PLKo=
X-Received: by 2002:a05:6512:3e01:b0:515:d1a6:1b07 with SMTP id
 2adb3069b0e04-5220fc7bdc8mr2561142e87.15.1715332763829; Fri, 10 May 2024
 02:19:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506155120.83105-1-libang.li@antgroup.com>
 <20240506155120.83105-6-libang.li@antgroup.com> <eb41fcb3-7207-40a8-9b49-0825a2e74e86@arm.com>
In-Reply-To: <eb41fcb3-7207-40a8-9b49-0825a2e74e86@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 10 May 2024 17:19:12 +0800
Message-ID: <CAK1f24mNZ5=HubBNcnuabzWAEqAALnnKVd3N9D5+jNBjxO6p+w@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] mm: Add update_mmu_tlb_range()
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Bang Li <libang.li@antgroup.com>, akpm@linux-foundation.org, 
	chenhuacai@kernel.org, tsbogend@alpha.franken.de, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, loongarch@lists.linux.dev, 
	linux-riscv@lists.infradead.org, david@redhat.com, libang.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 5:05=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 06/05/2024 16:51, Bang Li wrote:
> > After the commit 19eaf44954df ("mm: thp: support allocation of anonymou=
s
> > multi-size THP"), it may need to batch update tlb of an address range
> > through the update_mmu_tlb function. We can simplify this operation by
> > adding the update_mmu_tlb_range function, which may also reduce the
> > execution of some unnecessary code in some architectures.
> >
> > Signed-off-by: Bang Li <libang.li@antgroup.com>
> > ---
> >  include/linux/pgtable.h | 8 ++++++++
> >  mm/memory.c             | 4 +---
> >  2 files changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index 18019f037bae..869bfe6054f1 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -737,6 +737,14 @@ static inline void update_mmu_tlb(struct vm_area_s=
truct *vma,
> >  #define __HAVE_ARCH_UPDATE_MMU_TLB
> >  #endif
>
> Given you are implementing update_mmu_tlb_range() in all the arches that
> currently override update_mmu_tlb() I wonder if it would be cleaner to re=
move
> update_mmu_tlb() from all those arches, and define generically, removing =
the
> ability for arches to override it:

Sounds great! Let's get it done.

>
> static inline void update_mmu_tlb(struct vm_area_struct *vma,
>                                 unsigned long address, pte_t *ptep)
> {
>         update_mmu_tlb_range(vma, address, ptep, 1);
> }
>
> >
> > +#ifndef __HAVE_ARCH_UPDATE_MMU_TLB_RANGE
> > +static inline void update_mmu_tlb_range(struct vm_area_struct *vma,
> > +                             unsigned long address, pte_t *ptep, unsig=
ned int nr)
> > +{
> > +}
> > +#define __HAVE_ARCH_UPDATE_MMU_TLB_RANGE
> > +#endif
>
> Then you could use the modern override scheme as Lance suggested and you =
won't
> have any confusion with __HAVE_ARCH_UPDATE_MMU_TLB because it won't exist=
 anymore.

+1. It might be better to use the modern override scheme :)

Thanks,
Lance

>
> > +
> >  /*
> >   * Some architectures may be able to avoid expensive synchronization
> >   * primitives when modifications are made to PTE's which are already
> > diff --git a/mm/memory.c b/mm/memory.c
> > index eea6e4984eae..2d53e29cf76e 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4421,7 +4421,6 @@ static vm_fault_t do_anonymous_page(struct vm_fau=
lt *vmf)
> >       vm_fault_t ret =3D 0;
> >       int nr_pages =3D 1;
> >       pte_t entry;
> > -     int i;
> >
> >       /* File mapping without ->vm_ops ? */
> >       if (vma->vm_flags & VM_SHARED)
> > @@ -4491,8 +4490,7 @@ static vm_fault_t do_anonymous_page(struct vm_fau=
lt *vmf)
> >               update_mmu_tlb(vma, addr, vmf->pte);
> >               goto release;
> >       } else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
> > -             for (i =3D 0; i < nr_pages; i++)
> > -                     update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pt=
e + i);
> > +             update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
>
> I certainly agree that this will be a useful helper to have. I expect the=
re will
> be more users in future.
>
> >               goto release;
> >       }
> >
>

