Return-Path: <linux-kernel+bounces-522412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 175A9A3CA01
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76B7F179805
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1E723CEE5;
	Wed, 19 Feb 2025 20:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="VjhdojLL"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD4123C393
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 20:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997179; cv=none; b=cAOT8F8LR1MBwYXlDFT8khkC4C8rhHywPbbTTBg5Q1T9CyROZm35JQv5hjDyF5sZqZwhrV9bRta+SQ2EKEP7g+JHlYne38OUp+L9Jshhwu5txP9A2VFI0aPkf+M0dTMNvvawTX8RvcA2ZsATp9O+2L95bv8UHIft9x5VN8dPXuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997179; c=relaxed/simple;
	bh=vvk+AdM4vt9tKMhqg5D0XuqAML5DgtxedDKIhoqmiro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfIcRHVP2kd6m4SF3BdBXnlOWWs6EGOPEWoMCms+nIaaEje6G/lxrxkXmSnIBO2155MoQcgtOxHiE19i6ZFZZxm4ewTu1E/QGXvVbP/WV2E3colqfnpap0X+fLvpvP+NvXrBEum5SBkyxN6NFYzuV4Qi3qOMbS1igigbPHbH440=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=VjhdojLL; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DF3D3403EB
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 20:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739997167;
	bh=xFP8oLpfyz9SCRbb3oTVySdSbCN+UfrmsGZ/3z62Kgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=VjhdojLL1HIzHxO9900aJ/k1ik5vxVkTblziizp4DkuIA1nZ1Kys1xoHlLHV7iDRz
	 E2tX6dD3jV7sVX7P8N9tiKjDaqk2MmdY/8TPRwWj/sw+kKn15GyJMzQx/ocSHgFfnA
	 0A+U4F5cUVJAJdXP5NuzjL9bM0eiwlft4gKYirGEJ3ioyY+k4zKbSNIMfVaPzLCrfG
	 6vu4D3eUnUmQeKurzPppU/dKsJmiu7hK715IJQgG7lEEM//Qd2n20SlACC6DVWX5RQ
	 d+GLt1V2/VXv2VFt2e+uOROgn56Mby4lsVMOf9dq78BZwQg/c+cdPeyjS9KApEJgNS
	 fN9LMw/vYXcTg==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5e08dfe235fso151236a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:32:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739997167; x=1740601967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFP8oLpfyz9SCRbb3oTVySdSbCN+UfrmsGZ/3z62Kgg=;
        b=uTte3ldXpll8EtSevwGd6G65QhgN7u+BQn5PUoRER0iG3mD2JwZNIvobrHdq2RXwrD
         dKbI2GoRONIA2/PtPzkDKgh5OBvZuic3eRD7//5jftA3s+DzqJSvd1azuFEDR1sVyIlH
         bs1/ImZjkP44JPBhNoII5Y457wg/y3kwhgiT4k9MfbA0QHG0hPR+T01OadTiVagNswcN
         ZtgCaz5/GGjSW6OA3TRyPh2svpmmbkCpTJpVCH+rl4lqx1GYl3nPlbz7gDC+DQJjSpO1
         FDAbZkKX481ya0Mtg2Na2IznZFHmr7a1f1XpINXCHEWkJTli62g2Av4yu3wkyDuIpTdn
         aWLg==
X-Forwarded-Encrypted: i=1; AJvYcCU85f5KSm+4YhlsF0zq4kYZ9KQsBIWrwoCv0g5OOUJiMLHSbXxuYo1kdrFk9iEKHk1xySCsWie6Q6UiwCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcsI0GbXLXJhU54Uo7OuTNuOByiqI1T/5EW5xr1KUK85qtBP9k
	s5cHrTC2NxgLZowWrJe11Epxm8pSlZ/pPWBuO6lz5/GBUVgNIDdmDb9TDSN8fJnbukXlJdA+Tb0
	r/GHyEIMcaYwZd8D2gxRotVHCpDf6DfMZmCJdwXeIep+vGbhdxmgDgnGFFhj45mAOgJs7AFci7u
	XyUFCAbEnJvlookrfK0ipFp2E9m0uwWLDfPjbQOFyII0941OjNy/1jsChVwhgcnUw=
X-Gm-Gg: ASbGncv6sNbP2QzT5TJdzHiznvjCuAkni/0Wz5ZdUimezDXdksbh68stsGgHmoiLb/e
	J2zxzPqYKA2gTnEV5l7iwkjKhSFVEkpkKjARWOyYqv2+Qo6sMkgO8SyrcyJAP
X-Received: by 2002:a05:6402:3506:b0:5e0:8b68:94a2 with SMTP id 4fb4d7f45d1cf-5e08b689680mr3713938a12.14.1739997166760;
        Wed, 19 Feb 2025 12:32:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKtH6+f6L2nxcMslXOaM66izZ0LxjlrBRHiN0KiuAZdxw04Ao9z+jcqOIKrM1PHM0hMJHtmwlLcqptaNiDRKA=
X-Received: by 2002:a05:6402:3506:b0:5e0:8b68:94a2 with SMTP id
 4fb4d7f45d1cf-5e08b689680mr3713914a12.14.1739997166395; Wed, 19 Feb 2025
 12:32:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218222209.1382449-1-alex.williamson@redhat.com>
 <20250218222209.1382449-7-alex.williamson@redhat.com> <Z7UOEpgH5pdTBcJP@x1.local>
 <20250218161407.6ae2b082.alex.williamson@redhat.com> <CAHTA-ua8mTgNkDs0g=_8gMyT1NkgZqCE0J7QjOU=+cmZ2xqd7Q@mail.gmail.com>
 <20250219080808.0e22215c.alex.williamson@redhat.com>
In-Reply-To: <20250219080808.0e22215c.alex.williamson@redhat.com>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Wed, 19 Feb 2025 14:32:35 -0600
X-Gm-Features: AWEUYZkNrqeSRPk2dMwchTS7IsyHy1tjCAS0voQFiVDUY9YB0_CFzqovwj_O_Fs
Message-ID: <CAHTA-ubiguHnrQQH7uML30LsVc+wk-b=zTCioVTs3368eWkmeg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] vfio/type1: Use mapping page mask for pfnmaps
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	clg@redhat.com, jgg@nvidia.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Thanks for the review and testing!

Sure thing, thanks for the patch set!

If you happen to have a few minutes, I'm struggling to understand the
epfn computation and would appreciate some insight.

My current understanding (very possibly incorrect):
- epfn is intended to be the last page frame number that can be
represented at the mapping level corresponding to addr_mask. (so, if
addr_mask =3D=3D PUD_MASK, epfn would be the highest pfn still in PUD
level).
- ret should be =3D=3D npages if all pfns in the requested vma are within
the memory hierarchy level denoted by addr_mask. If npages is more
than can be represented at that level, ret =3D=3D the max number of page
frames representable at addr_mask level.
- - (if the second case is true, that means we were not able to obtain
all requested pages due to running out of PFNs at the current mapping
level)

If the above is all correct, what is confusing me is where the "(*pfn)
| " comes into this equation. If epfn is meant to be the last pfn
representable at addr_mask level of the hierarchy, wouldn't that be
represented by (~pgmask >> PAGE_SHIFT) alone?

Thanks in advance,
Mitchell Augustin

On Wed, Feb 19, 2025 at 9:08=E2=80=AFAM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Tue, 18 Feb 2025 20:36:22 -0600
> Mitchell Augustin <mitchell.augustin@canonical.com> wrote:
>
> > /s/follow_pfnmap_args.pgmask/follow_pfnmap_args.addr_mask/ in v2
> > commit log.
>
> Thanks for spotting that, if there's no other cause for a re-spin I'll
> fix that on commit.  Thanks for the review and testing!
>
> Alex
>
> > Aside from that, it works as expected.
> >
> > Reviewed-by: "Mitchell Augustin" <mitchell.augustin@canonical.com>
> > Tested-by: "Mitchell Augustin" <mitchell.augustin@canonical.com>
> >
> >
> > On Tue, Feb 18, 2025 at 5:14=E2=80=AFPM Alex Williamson
> > <alex.williamson@redhat.com> wrote:
> > >
> > > On Tue, 18 Feb 2025 17:47:46 -0500
> > > Peter Xu <peterx@redhat.com> wrote:
> > >
> > > > On Tue, Feb 18, 2025 at 03:22:06PM -0700, Alex Williamson wrote:
> > > > > vfio-pci supports huge_fault for PCI MMIO BARs and will insert pu=
d and
> > > > > pmd mappings for well aligned mappings.  follow_pfnmap_start() wa=
lks the
> > > > > page table and therefore knows the page mask of the level where t=
he
> > > > > address is found and returns this through follow_pfnmap_args.pgma=
sk.
> > > > > Subsequent pfns from this address until the end of the mapping pa=
ge are
> > > > > necessarily consecutive.  Use this information to retrieve a rang=
e of
> > > > > pfnmap pfns in a single pass.
> > > > >
> > > > > With optimal mappings and alignment on systems with 1GB pud and 4=
KB
> > > > > page size, this reduces iterations for DMA mapping PCI BARs by a
> > > > > factor of 256K.  In real world testing, the overhead of iterating
> > > > > pfns for a VM DMA mapping a 32GB PCI BAR is reduced from ~1s to
> > > > > sub-millisecond overhead.
> > > > >
> > > > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > > > ---
> > > > >  drivers/vfio/vfio_iommu_type1.c | 23 ++++++++++++++++-------
> > > > >  1 file changed, 16 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_=
iommu_type1.c
> > > > > index ce661f03f139..0ac56072af9f 100644
> > > > > --- a/drivers/vfio/vfio_iommu_type1.c
> > > > > +++ b/drivers/vfio/vfio_iommu_type1.c
> > > > > @@ -520,7 +520,7 @@ static void vfio_batch_fini(struct vfio_batch=
 *batch)
> > > > >
> > > > >  static int follow_fault_pfn(struct vm_area_struct *vma, struct m=
m_struct *mm,
> > > > >                         unsigned long vaddr, unsigned long *pfn,
> > > > > -                       bool write_fault)
> > > > > +                       unsigned long *addr_mask, bool write_faul=
t)
> > > > >  {
> > > > >     struct follow_pfnmap_args args =3D { .vma =3D vma, .address =
=3D vaddr };
> > > > >     int ret;
> > > > > @@ -544,10 +544,12 @@ static int follow_fault_pfn(struct vm_area_=
struct *vma, struct mm_struct *mm,
> > > > >                     return ret;
> > > > >     }
> > > > >
> > > > > -   if (write_fault && !args.writable)
> > > > > +   if (write_fault && !args.writable) {
> > > > >             ret =3D -EFAULT;
> > > > > -   else
> > > > > +   } else {
> > > > >             *pfn =3D args.pfn;
> > > > > +           *addr_mask =3D args.addr_mask;
> > > > > +   }
> > > > >
> > > > >     follow_pfnmap_end(&args);
> > > > >     return ret;
> > > > > @@ -590,15 +592,22 @@ static long vaddr_get_pfns(struct mm_struct=
 *mm, unsigned long vaddr,
> > > > >     vma =3D vma_lookup(mm, vaddr);
> > > > >
> > > > >     if (vma && vma->vm_flags & VM_PFNMAP) {
> > > > > -           ret =3D follow_fault_pfn(vma, mm, vaddr, pfn, prot & =
IOMMU_WRITE);
> > > > > +           unsigned long addr_mask;
> > > > > +
> > > > > +           ret =3D follow_fault_pfn(vma, mm, vaddr, pfn, &addr_m=
ask,
> > > > > +                                  prot & IOMMU_WRITE);
> > > > >             if (ret =3D=3D -EAGAIN)
> > > > >                     goto retry;
> > > > >
> > > > >             if (!ret) {
> > > > > -                   if (is_invalid_reserved_pfn(*pfn))
> > > > > -                           ret =3D 1;
> > > > > -                   else
> > > > > +                   if (is_invalid_reserved_pfn(*pfn)) {
> > > > > +                           unsigned long epfn;
> > > > > +
> > > > > +                           epfn =3D (*pfn | (~addr_mask >> PAGE_=
SHIFT)) + 1;
> > > > > +                           ret =3D min_t(long, npages, epfn - *p=
fn);
> > > >
> > > > s/long/unsigned long/?
> > >
> > > ret is signed long since it's the function return and needs to be abl=
e
> > > to return -errno, so long was the intention here.  Thanks,
> > >
> > > Alex
> > >
> > > > Reviewed-by: Peter Xu <peterx@redhat.com>
> > > >
> > > > > +                   } else {
> > > > >                             ret =3D -EFAULT;
> > > > > +                   }
> > > > >             }
> > > > >     }
> > > > >  done:
> > > > > --
> > > > > 2.48.1
> > > > >
> > > >
> > >
> >
> >
> > --
> > Mitchell Augustin
> > Software Engineer - Ubuntu Partner Engineering
> >
>


--=20
Mitchell Augustin
Software Engineer - Ubuntu Partner Engineering

