Return-Path: <linux-kernel+bounces-520822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E49A3AFAB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 03:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B87188C5D9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E34E188938;
	Wed, 19 Feb 2025 02:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="qktJbkdw"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB54322EE4
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 02:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739932600; cv=none; b=J1wzz519TPUe6kawMo00opug3ZRtmjc/RAF3IrIRZ2TpeNr3GMN9QopAvOX2UPLdyU6Kp/TXcgcAv1SK/OvLSTpIOLU9o7rdRhFlwUnXkUFBOVQ3iJ5ZRIBmjKxYFDzIXgE29rR6ewztrWYM7wN0Y5xcw7gZm+lX6ASDfUPWdNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739932600; c=relaxed/simple;
	bh=rveXvfpNgj3V/3uXAGCU7hGmO4dBjIcMbwqqZkqK26s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZN3/OOVORVmnm1IlhyBS6yuzSItlRflx5AXCoUiKlfMkB3mzJYEzMTycFboKxQWWyP5Kb/jkbtbhzOuVMnVg1QVzLh9xM1FDBOOqi+dX7BePD+IECtuDkczq0ziK2oP1G5yIIwORjQsbd3QN9PxZ6oN6Q9Gyqj6sQv3VibVWDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=qktJbkdw; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9DC223F87A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 02:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739932595;
	bh=vf1qvK2by+jGV65Pqs0eS1MS94gVUz7y9vFh+Qb3c+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=qktJbkdwNbeRr6cAwvD0TgeJ8Ykk0sx1wwLgfc8mWoPMKVnnoG65HDUml6STTMloT
	 ZGTWmzzythbINA8stwbDdGFG5DGQYxZWAWVQRVSgPqE6FxeGvO6BT0pKvZq7qfuLWK
	 TFHDh2g3O4POoj2KkHkaDX9ZnZGp/3qWknyD9yjVkA89+vc0HplZQGP3EBPJ5hckNR
	 iBfHo++OxXGo4ytqzUMaVsS6YCeTznY+2tPvwer7sgBtG5PDz9VCDU6oNzCKQpDDb6
	 soaRBYIgN0utILRzxzyVnjLaYJXs3Fb652y/UeOWGX1ONrc90vzm0prMgO6tfNAFi7
	 xEhzFajBgiCmw==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5dec9d39295so6141766a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:36:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739932594; x=1740537394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vf1qvK2by+jGV65Pqs0eS1MS94gVUz7y9vFh+Qb3c+8=;
        b=P3PoCs01PQ4QjaM4uhe43cZ4Bx1nitqX8jRVcJsBtX0LBRgCxJgVnSWl9/RlV1B1R2
         LP6KyRv3WE5/gXcUzgkoVt1s2zTcjqtG16/mRsAjqify9YkvbDBEmulnoafTBR9b2hMf
         7Hufn9qfDR3Q5tVFH4h32fMLMNKgQRac8Ta4/lz6Ivs2Z4/qs7zevSk39Yrsw28VTD4o
         KZpZpSC21sQ/Rp+uvacusS7qXaqgBRK1VSFmSO5IzirKFTEgXwe2F0QjcN0513Q6okkM
         dDrN+PmrV10OEljDnThiP+9mVkEj5wKXGh/YBHDr8F66Oc6Bvkonc6V5f4Ko1ejN06KU
         fVyw==
X-Forwarded-Encrypted: i=1; AJvYcCUDirwHmbeDY7nxAwRKa71OfXYma95An93PzQHml7vZYOK12p0BoW7r8XHLEKkTSQhajqXmAj0FWGfbdrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXl2Ff1r8xGnCjbPk96EdXkLZUGVApRiu/kKv/IuPF0UvkYcEF
	oP3fLmuzIfV/4ezoh6NplV+Pta6wi3ReQEjEKBKjdtxlcZrHDwlEIUrNB4ISkQ7COf8XwMcb9+C
	VvVeU06kMLtjjHamndPIELqZrFh+9qSlISVKVnpEVGFz8Mo2q47PIDxM/sv55OGDAZKDR7qC3X6
	IZdjN0whjGwQvoEv/XlyGDWbMYT0wdO/tUMbou3TInc39g9hwyimwO
X-Gm-Gg: ASbGncshWhWsivr5mZpbMAhyBAcNaxwZ6BMtDaaSPTuHYdebbYylg9W9Q632DGkpxet
	RTzbx5XohDGlWdcM/KPNB0XAHC4wxJ/3NhBp4KG445onDJgK8jyxavP0Tgpuc
X-Received: by 2002:a05:6402:520e:b0:5dc:7fbe:72ff with SMTP id 4fb4d7f45d1cf-5e0894f7a93mr1494025a12.2.1739932594170;
        Tue, 18 Feb 2025 18:36:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoq/ug3HpCJUOAUDpRyTkhBQF1qeEo0BUuVH4+X+SQxLUDIiWnGDZ38SmRisv8NVYqjTO25htXjWKz7FVPjZg=
X-Received: by 2002:a05:6402:520e:b0:5dc:7fbe:72ff with SMTP id
 4fb4d7f45d1cf-5e0894f7a93mr1494002a12.2.1739932593834; Tue, 18 Feb 2025
 18:36:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218222209.1382449-1-alex.williamson@redhat.com>
 <20250218222209.1382449-7-alex.williamson@redhat.com> <Z7UOEpgH5pdTBcJP@x1.local>
 <20250218161407.6ae2b082.alex.williamson@redhat.com>
In-Reply-To: <20250218161407.6ae2b082.alex.williamson@redhat.com>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Tue, 18 Feb 2025 20:36:22 -0600
X-Gm-Features: AWEUYZkz1cZnARvZskS0-aLz8NUwEBuzeFL49ZTvzIP2huZXOoCnDbKLjmz8aDk
Message-ID: <CAHTA-ua8mTgNkDs0g=_8gMyT1NkgZqCE0J7QjOU=+cmZ2xqd7Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] vfio/type1: Use mapping page mask for pfnmaps
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	clg@redhat.com, jgg@nvidia.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

/s/follow_pfnmap_args.pgmask/follow_pfnmap_args.addr_mask/ in v2
commit log. Aside from that, it works as expected.

Reviewed-by: "Mitchell Augustin" <mitchell.augustin@canonical.com>
Tested-by: "Mitchell Augustin" <mitchell.augustin@canonical.com>


On Tue, Feb 18, 2025 at 5:14=E2=80=AFPM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Tue, 18 Feb 2025 17:47:46 -0500
> Peter Xu <peterx@redhat.com> wrote:
>
> > On Tue, Feb 18, 2025 at 03:22:06PM -0700, Alex Williamson wrote:
> > > vfio-pci supports huge_fault for PCI MMIO BARs and will insert pud an=
d
> > > pmd mappings for well aligned mappings.  follow_pfnmap_start() walks =
the
> > > page table and therefore knows the page mask of the level where the
> > > address is found and returns this through follow_pfnmap_args.pgmask.
> > > Subsequent pfns from this address until the end of the mapping page a=
re
> > > necessarily consecutive.  Use this information to retrieve a range of
> > > pfnmap pfns in a single pass.
> > >
> > > With optimal mappings and alignment on systems with 1GB pud and 4KB
> > > page size, this reduces iterations for DMA mapping PCI BARs by a
> > > factor of 256K.  In real world testing, the overhead of iterating
> > > pfns for a VM DMA mapping a 32GB PCI BAR is reduced from ~1s to
> > > sub-millisecond overhead.
> > >
> > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > ---
> > >  drivers/vfio/vfio_iommu_type1.c | 23 ++++++++++++++++-------
> > >  1 file changed, 16 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iomm=
u_type1.c
> > > index ce661f03f139..0ac56072af9f 100644
> > > --- a/drivers/vfio/vfio_iommu_type1.c
> > > +++ b/drivers/vfio/vfio_iommu_type1.c
> > > @@ -520,7 +520,7 @@ static void vfio_batch_fini(struct vfio_batch *ba=
tch)
> > >
> > >  static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_st=
ruct *mm,
> > >                         unsigned long vaddr, unsigned long *pfn,
> > > -                       bool write_fault)
> > > +                       unsigned long *addr_mask, bool write_fault)
> > >  {
> > >     struct follow_pfnmap_args args =3D { .vma =3D vma, .address =3D v=
addr };
> > >     int ret;
> > > @@ -544,10 +544,12 @@ static int follow_fault_pfn(struct vm_area_stru=
ct *vma, struct mm_struct *mm,
> > >                     return ret;
> > >     }
> > >
> > > -   if (write_fault && !args.writable)
> > > +   if (write_fault && !args.writable) {
> > >             ret =3D -EFAULT;
> > > -   else
> > > +   } else {
> > >             *pfn =3D args.pfn;
> > > +           *addr_mask =3D args.addr_mask;
> > > +   }
> > >
> > >     follow_pfnmap_end(&args);
> > >     return ret;
> > > @@ -590,15 +592,22 @@ static long vaddr_get_pfns(struct mm_struct *mm=
, unsigned long vaddr,
> > >     vma =3D vma_lookup(mm, vaddr);
> > >
> > >     if (vma && vma->vm_flags & VM_PFNMAP) {
> > > -           ret =3D follow_fault_pfn(vma, mm, vaddr, pfn, prot & IOMM=
U_WRITE);
> > > +           unsigned long addr_mask;
> > > +
> > > +           ret =3D follow_fault_pfn(vma, mm, vaddr, pfn, &addr_mask,
> > > +                                  prot & IOMMU_WRITE);
> > >             if (ret =3D=3D -EAGAIN)
> > >                     goto retry;
> > >
> > >             if (!ret) {
> > > -                   if (is_invalid_reserved_pfn(*pfn))
> > > -                           ret =3D 1;
> > > -                   else
> > > +                   if (is_invalid_reserved_pfn(*pfn)) {
> > > +                           unsigned long epfn;
> > > +
> > > +                           epfn =3D (*pfn | (~addr_mask >> PAGE_SHIF=
T)) + 1;
> > > +                           ret =3D min_t(long, npages, epfn - *pfn);
> >
> > s/long/unsigned long/?
>
> ret is signed long since it's the function return and needs to be able
> to return -errno, so long was the intention here.  Thanks,
>
> Alex
>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> >
> > > +                   } else {
> > >                             ret =3D -EFAULT;
> > > +                   }
> > >             }
> > >     }
> > >  done:
> > > --
> > > 2.48.1
> > >
> >
>


--
Mitchell Augustin
Software Engineer - Ubuntu Partner Engineering

