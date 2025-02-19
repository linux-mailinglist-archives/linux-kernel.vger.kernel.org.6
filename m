Return-Path: <linux-kernel+bounces-521852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B38EA3C327
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A88164957
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7871F3FDC;
	Wed, 19 Feb 2025 15:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DR65f3vj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618DF1F37C3
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739977698; cv=none; b=XVhZiOAG9Kif/7p9HOjxOkU1B0/Rvt+G/GilmhzGXcCMKGsMnjcMtq+VYq0CuRbyuJvxwY+eeVFaY+SIXPyxu7V6OXxtlywRUkVscgKA6AKNwWqy2S+bqU25Rq901M9aOoIcBmlEU6GXa6+fpFkVrHnQE1xjSN65G+DCsDWnBeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739977698; c=relaxed/simple;
	bh=nIlzcWPCpNDHeGWJ1Tv8gxxOpW0FShbKAlaQ3tpaGjo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GcM1ECukiMr0umY4Z8bAwglRsW7KglgrIWPiY/oedt1sKPnDKsAzPJ0tNM8/Hdpvj8ujvLONdZR07QxxsjZmnjh2YqD6Rmy3f/rFi2YnXRZte8g2RC4xozgWaczSMdIzQH5x9osXIArNqSMiWlqDJugF7yNi0ISLH9kBYWPEQfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DR65f3vj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739977695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h0i0ytHqma4RDTIEIdZzYRA/ktw8J09sr28RqE6ASb0=;
	b=DR65f3vjWAsFAXNiRHmbvwqhcqjv+lGT1I0oEcFG0whmdE31bezQIk9kMs/UqCUJwtQM0K
	G27/5aLO/TB3X3z1vbW01C2SApN4t8fo7POGeyS5AbPo3FEINJIM3X6NmZ97bEE0MeuYky
	7Jwm1nTJtLS3K08UyRNr6B9R+/OSBsw=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-TWdQj8WuMJ2Xb9gsKSPUHQ-1; Wed, 19 Feb 2025 10:08:14 -0500
X-MC-Unique: TWdQj8WuMJ2Xb9gsKSPUHQ-1
X-Mimecast-MFC-AGG-ID: TWdQj8WuMJ2Xb9gsKSPUHQ_1739977693
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d2a939f01bso1708345ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 07:08:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739977693; x=1740582493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0i0ytHqma4RDTIEIdZzYRA/ktw8J09sr28RqE6ASb0=;
        b=SL/ohiKVVMfpasF09unQ6/Yj9vfF9quq1uHsB+vx+UAO6Y/G2ZY0V1oGSZuTpECT+F
         6R3GpKOS3dt4AY/UUqaKxe44u4MzMazAC8X5UEG3iUZqT4OIwVnP+6c7kumhgoO/NXvz
         wEkWbgptHnotoQ5Rg8EZRECHJmsREWIoSj+asvoYgCuOOEAod4hh9eZEuqP2D37UzwDc
         W9wPXaYNQ2GXb5h50mG8H/TpzjWxzNgS0iU6Q0/7xzDzDoAqvwWxRI/aQmfw+XHDlJqg
         GGvxMnf4+h3L5Vnw+VzN6Cw6hZEi/T2aoQV8OQV7uGteaxSOpd6adMGnJReoZniaDmQD
         K/JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSpHATsHGWBaEaSSFo5t1iAMcV8xsFjVCPwaYonFro8qtPSv6h7ACrAxsgzw1JQlPRrQmdd5DtC38amik=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJrl/PGbYURc4mjioVPwl96782W4QJkcvQhrN9eDpDOijQ0Eh1
	IZsbhRRZ0bJSbWspvWGGADWH8j9WoTX1h8KpBZPneQYZN3bcOnS7tKGO/z0JfY8Wc3OCz+iqirR
	pNd043uxWOCgoAVBlwaiu4wi5UGbRKMHg5zPX4fYz8zC0CsBmFHtRnM8c2AdJWQ==
X-Gm-Gg: ASbGncvO/CnK+LyKO+Y7vCJIRtOhyZ0QD6RNH9sicuM8qD7TyfOD9AXSaj+qz65Zllp
	dFrEjje4GAOrc1pZf3oZQ29X//IQplDfls+bhEwE99yYvMliji7NK0Pu9RQfH430AWSLM0mKPUR
	hJVb/HKNwGYfmDVGHlKAGZ111jNiqswTTnhWmiFEiRwAg9En5lvQRErcmPF0fmHjOqpjgZYUUkS
	iA9UD3SDoE2hd0B+wxqP3/2nvlXM9FyDenk96ah36mQWwdbI5r3fRwLFQdzPmDh7aHEuDnG4/ee
	pomKZGmw
X-Received: by 2002:a05:6602:2dd2:b0:855:a047:5f01 with SMTP id ca18e2360f4ac-855a0477cdfmr292673339f.3.1739977693172;
        Wed, 19 Feb 2025 07:08:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFewhjDw5FMQQv2E37ZGUyKeodB2Szx8gB5YrE4eo4YClIcD42Wt2wzkfld876dn+j1QGOjWQ==
X-Received: by 2002:a05:6602:2dd2:b0:855:a047:5f01 with SMTP id ca18e2360f4ac-855a0477cdfmr292671039f.3.1739977692599;
        Wed, 19 Feb 2025 07:08:12 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8559c37b07fsm108826239f.0.2025.02.19.07.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 07:08:10 -0800 (PST)
Date: Wed, 19 Feb 2025 08:08:08 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Mitchell Augustin <mitchell.augustin@canonical.com>
Cc: Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, clg@redhat.com, jgg@nvidia.com,
 willy@infradead.org
Subject: Re: [PATCH v2 6/6] vfio/type1: Use mapping page mask for pfnmaps
Message-ID: <20250219080808.0e22215c.alex.williamson@redhat.com>
In-Reply-To: <CAHTA-ua8mTgNkDs0g=_8gMyT1NkgZqCE0J7QjOU=+cmZ2xqd7Q@mail.gmail.com>
References: <20250218222209.1382449-1-alex.williamson@redhat.com>
	<20250218222209.1382449-7-alex.williamson@redhat.com>
	<Z7UOEpgH5pdTBcJP@x1.local>
	<20250218161407.6ae2b082.alex.williamson@redhat.com>
	<CAHTA-ua8mTgNkDs0g=_8gMyT1NkgZqCE0J7QjOU=+cmZ2xqd7Q@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Feb 2025 20:36:22 -0600
Mitchell Augustin <mitchell.augustin@canonical.com> wrote:

> /s/follow_pfnmap_args.pgmask/follow_pfnmap_args.addr_mask/ in v2
> commit log.

Thanks for spotting that, if there's no other cause for a re-spin I'll
fix that on commit.  Thanks for the review and testing!

Alex

> Aside from that, it works as expected.
>=20
> Reviewed-by: "Mitchell Augustin" <mitchell.augustin@canonical.com>
> Tested-by: "Mitchell Augustin" <mitchell.augustin@canonical.com>
>=20
>=20
> On Tue, Feb 18, 2025 at 5:14=E2=80=AFPM Alex Williamson
> <alex.williamson@redhat.com> wrote:
> >
> > On Tue, 18 Feb 2025 17:47:46 -0500
> > Peter Xu <peterx@redhat.com> wrote:
> > =20
> > > On Tue, Feb 18, 2025 at 03:22:06PM -0700, Alex Williamson wrote: =20
> > > > vfio-pci supports huge_fault for PCI MMIO BARs and will insert pud =
and
> > > > pmd mappings for well aligned mappings.  follow_pfnmap_start() walk=
s the
> > > > page table and therefore knows the page mask of the level where the
> > > > address is found and returns this through follow_pfnmap_args.pgmask.
> > > > Subsequent pfns from this address until the end of the mapping page=
 are
> > > > necessarily consecutive.  Use this information to retrieve a range =
of
> > > > pfnmap pfns in a single pass.
> > > >
> > > > With optimal mappings and alignment on systems with 1GB pud and 4KB
> > > > page size, this reduces iterations for DMA mapping PCI BARs by a
> > > > factor of 256K.  In real world testing, the overhead of iterating
> > > > pfns for a VM DMA mapping a 32GB PCI BAR is reduced from ~1s to
> > > > sub-millisecond overhead.
> > > >
> > > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > > ---
> > > >  drivers/vfio/vfio_iommu_type1.c | 23 ++++++++++++++++-------
> > > >  1 file changed, 16 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_io=
mmu_type1.c
> > > > index ce661f03f139..0ac56072af9f 100644
> > > > --- a/drivers/vfio/vfio_iommu_type1.c
> > > > +++ b/drivers/vfio/vfio_iommu_type1.c
> > > > @@ -520,7 +520,7 @@ static void vfio_batch_fini(struct vfio_batch *=
batch)
> > > >
> > > >  static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_=
struct *mm,
> > > >                         unsigned long vaddr, unsigned long *pfn,
> > > > -                       bool write_fault)
> > > > +                       unsigned long *addr_mask, bool write_fault)
> > > >  {
> > > >     struct follow_pfnmap_args args =3D { .vma =3D vma, .address =3D=
 vaddr };
> > > >     int ret;
> > > > @@ -544,10 +544,12 @@ static int follow_fault_pfn(struct vm_area_st=
ruct *vma, struct mm_struct *mm,
> > > >                     return ret;
> > > >     }
> > > >
> > > > -   if (write_fault && !args.writable)
> > > > +   if (write_fault && !args.writable) {
> > > >             ret =3D -EFAULT;
> > > > -   else
> > > > +   } else {
> > > >             *pfn =3D args.pfn;
> > > > +           *addr_mask =3D args.addr_mask;
> > > > +   }
> > > >
> > > >     follow_pfnmap_end(&args);
> > > >     return ret;
> > > > @@ -590,15 +592,22 @@ static long vaddr_get_pfns(struct mm_struct *=
mm, unsigned long vaddr,
> > > >     vma =3D vma_lookup(mm, vaddr);
> > > >
> > > >     if (vma && vma->vm_flags & VM_PFNMAP) {
> > > > -           ret =3D follow_fault_pfn(vma, mm, vaddr, pfn, prot & IO=
MMU_WRITE);
> > > > +           unsigned long addr_mask;
> > > > +
> > > > +           ret =3D follow_fault_pfn(vma, mm, vaddr, pfn, &addr_mas=
k,
> > > > +                                  prot & IOMMU_WRITE);
> > > >             if (ret =3D=3D -EAGAIN)
> > > >                     goto retry;
> > > >
> > > >             if (!ret) {
> > > > -                   if (is_invalid_reserved_pfn(*pfn))
> > > > -                           ret =3D 1;
> > > > -                   else
> > > > +                   if (is_invalid_reserved_pfn(*pfn)) {
> > > > +                           unsigned long epfn;
> > > > +
> > > > +                           epfn =3D (*pfn | (~addr_mask >> PAGE_SH=
IFT)) + 1;
> > > > +                           ret =3D min_t(long, npages, epfn - *pfn=
); =20
> > >
> > > s/long/unsigned long/? =20
> >
> > ret is signed long since it's the function return and needs to be able
> > to return -errno, so long was the intention here.  Thanks,
> >
> > Alex
> > =20
> > > Reviewed-by: Peter Xu <peterx@redhat.com>
> > > =20
> > > > +                   } else {
> > > >                             ret =3D -EFAULT;
> > > > +                   }
> > > >             }
> > > >     }
> > > >  done:
> > > > --
> > > > 2.48.1
> > > > =20
> > > =20
> > =20
>=20
>=20
> --
> Mitchell Augustin
> Software Engineer - Ubuntu Partner Engineering
>=20


