Return-Path: <linux-kernel+bounces-248031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D981692D787
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08AAF1C227FE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC09F194C79;
	Wed, 10 Jul 2024 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dhG+n51C"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A605194C74
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720632784; cv=none; b=TJ0O5JnJCZqmXZ0G3RdpFFNZgqjO8ta0VqIs+VHOxCQIPLNYWEavVknkWASnGzhAV4SF+jX4ApMIR0EUW9jsk7+F5yHbPKnbvxbCKTxPSxvwz8IB0tXy+aX8N9Ae6wMnCx8E+s4r9TA7aPP2EfWyu2swa4pjIH3zwakZkLX95CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720632784; c=relaxed/simple;
	bh=w5L3J45UVuMZGyUksnsqYOMKJS7SXFkN4agIORLKAGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gCLqz+ePBDbrqHIrImOSPsZNkD5GhRXq6yXvUFWPmPgVT8PpM+BR0U/yrDJ9E3LYe9SEFdMIlOZNV4TGHJ7cmWR+AbnxSNyFaYoErcZ3OxWIlW20c1uzx8lvPnX6yGhxbwTQ6U1nIIq5uvT2htAS0UBdFz7Cfd6tTf1mt9SLBRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dhG+n51C; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-654cf0a069eso48521167b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720632781; x=1721237581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvVDDEmpFZaMdI2FUKr1cZ22MakUZTGbQ7PWvtblDNs=;
        b=dhG+n51CdF48D0tHYP4JAnaSwV70jLqYsHP0rNA6WXABSLDR79lFoLR9lC95SKkk0s
         F0m+msaOmdmMFo5/iZO61Z7OcHF+pBalfYVh503qDnuiDMPRHeG/0+gtmo2tljvIRY3r
         YWpGhDDO0nv/4aXZ2/ocu9zNlf0ZscfFkui02Egdr/HctzEiIjaoxe0Sx9jhWqjmVubX
         sRr8XDgjLBfxuIH8romiFqxeWgFRCw7X5N0OAsUH4o0jOy7gZ/RcGt1Ggwmw7VrDZNZy
         J2bwtneWWnDjZXdK2ugdBWDYPzGNsDaECp3dxMSzH41hbHcRDbEBJH9vOzDQvQdJW2B6
         Qvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720632781; x=1721237581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvVDDEmpFZaMdI2FUKr1cZ22MakUZTGbQ7PWvtblDNs=;
        b=IIVRhgVMdrR9w2nYmMO9uc9DP297X0CsHVOocU+7BobmlcDzSYn2fETU/v9Ttvc0/X
         V60kI2OABzMc5Zo9R0r5YIhvjQCq75UV9yampQ+Dhg8qXe56a1GZS2WyHh4xNjSEFSeh
         RtjPIxXfDf5w4E+D3w9AOI4Xdm/pjkzIfb6JlcIAcc9RIyPcYGFhYxJAg6/NAmA0LXNn
         iY2aytlUMF8Kq16T3kx3hS4h73M2OSKovdJn/93+WuTnPrGtSYeERsUWsjNsWUyz9xKP
         /SzCYdrq6hL0NsXgMByQsj5RnFO5BOOqR9TB/chhkz3SNFc7ygWDsz24pWjFYLJdBsNU
         zUSA==
X-Forwarded-Encrypted: i=1; AJvYcCXd7NbdE21cHAL7MeKdsDo/5rE3zaxcF5zJ38q+sDe6xZh70n4YTbBL7Gg+lg+nVfUIZZXtNP55my9BnNVmaKbQ+bL+RiozidYqZiSY
X-Gm-Message-State: AOJu0Yyv8G1byub4XphE/Hj2UKOiN6zHRATbVtNpHH1vTDkkESEBKD0u
	LseMf3/x6trr0emBbD9s9D+9B7+ODT0kl3twDR4wM+LZmd7IswmqrMkacL/cN59TNtMSdXMvGjI
	0kzb9lhWTAdRAkn4NRMGLogeJTLb2m2ZTC+i4
X-Google-Smtp-Source: AGHT+IGmpx1+Idub9F1goSZv6lGJvb6f5I03FVYBQVmDWes7dy0EfLBUgZB8gjKOYRNMHum3C+QdIlw3gXuGBzA8AS8=
X-Received: by 2002:a81:8d0a:0:b0:646:49de:5dfd with SMTP id
 00721157ae682-658ef4431ecmr55886377b3.25.1720632781111; Wed, 10 Jul 2024
 10:33:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-15-Liam.Howlett@oracle.com> <7a0350b3-ea23-42d4-b2f7-4680d761c969@lucifer.local>
In-Reply-To: <7a0350b3-ea23-42d4-b2f7-4680d761c969@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 10 Jul 2024 10:32:50 -0700
Message-ID: <CAJuCfpHvno-XJRxkaDUFaFt0fokLioM-ChTOfSihNvfSb9d77A@mail.gmail.com>
Subject: Re: [PATCH v3 14/16] mm/mmap: Use PHYS_PFN in mmap_region()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>, 
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 5:21=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Jul 04, 2024 at 02:27:16PM GMT, Liam R. Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > Instead of shifting the length by PAGE_SIZE, use PHYS_PFN.  Also use th=
e
> > existing local variable everywhere instead of some of the time.
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  mm/mmap.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 0c334eeae8cd..b14da6bd257f 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2935,7 +2935,7 @@ unsigned long mmap_region(struct file *file, unsi=
gned long addr,
> >       struct mm_struct *mm =3D current->mm;
> >       struct vm_area_struct *vma =3D NULL;
> >       struct vm_area_struct *next, *prev, *merge;
> > -     pgoff_t pglen =3D len >> PAGE_SHIFT;
> > +     pgoff_t pglen =3D PHYS_PFN(len);
> >       unsigned long charged =3D 0;
> >       struct vma_munmap_struct vms;
> >       struct ma_state mas_detach;
> > @@ -2955,7 +2955,7 @@ unsigned long mmap_region(struct file *file, unsi=
gned long addr,
> >        * MAP_FIXED may remove pages of mappings that intersects with re=
quested
> >        * mapping. Account for the pages it would unmap.
> >        */
> > -     if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - nr_pages))
> > +     if (!may_expand_vm(mm, vm_flags, pglen - nr_pages))
> >               return -ENOMEM;
> >
> >       if (unlikely(!can_modify_mm(mm, addr, end)))
> > @@ -2990,7 +2990,7 @@ unsigned long mmap_region(struct file *file, unsi=
gned long addr,
> >        * Private writable mapping: check memory availability
> >        */
> >       if (accountable_mapping(file, vm_flags)) {
> > -             charged =3D len >> PAGE_SHIFT;
> > +             charged =3D pglen;
> >               charged -=3D nr_accounted;
> >               if (security_vm_enough_memory_mm(mm, charged))
> >                       goto abort_munmap;
> > @@ -3149,14 +3149,14 @@ unsigned long mmap_region(struct file *file, un=
signed long addr,
> >       if (vms.nr_pages)
> >               vms_complete_munmap_vmas(&vms, &mas_detach);
> >
> > -     vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
> > +     vm_stat_account(mm, vm_flags, pglen);
> >       if (vm_flags & VM_LOCKED) {
> >               if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
> >                                       is_vm_hugetlb_page(vma) ||
> >                                       vma =3D=3D get_gate_vma(current->=
mm))
> >                       vm_flags_clear(vma, VM_LOCKED_MASK);
> >               else
> > -                     mm->locked_vm +=3D (len >> PAGE_SHIFT);
> > +                     mm->locked_vm +=3D pglen;
> >       }
> >
> >       if (file)
> > --
> > 2.43.0
> >
>
> Maybe I should literally look ahead before making comments :)) thanks for
> reading my mind and doing what I asked though! ;)
>
> However I don't think you've fixed the duplication of PHYS_PFN(vm_end -
> vm_start) in count_vma_pages_range() - still worth doing I think.
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

