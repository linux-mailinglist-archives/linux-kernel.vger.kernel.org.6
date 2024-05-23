Return-Path: <linux-kernel+bounces-187582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CF78CD4CE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13626B2037E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8015214A4F4;
	Thu, 23 May 2024 13:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCyWey+H"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61C413C66A
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716471279; cv=none; b=hIEfRBi7PnVPArEeUSIbIKFRnkMsNvxa+0O/DhH9zdoEydcAcmScoHTnuPQr0khBjwrTasrxK8gyajpDJp75IE0TEJlqYSMiFVP1FWmn9gBT96D8qfniRIGQBxUfiiS5tGMJCfZPtCLk+iz0Re5HuubEPVtHeL46T88JMgPgORQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716471279; c=relaxed/simple;
	bh=RSPz/BgK+60ML+64zy8oGk8LjuwU4cNCx7CrZFAbWKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egw7UnMTu9TVLE0+YUectZHsWe+9rOCw4Qxr7ZsOpODZkpHqC59LpZgjS2l8guZ3WrAAekxj9iNyUfQLeulLagLEE/wBVKO4ReQB8iQbUWTXw+RNsW3wnZyw1v9T0mYPCABneQS0Ty0EDRLMplAgu5dcZWJGtHwqSMPt4+ethSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCyWey+H; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e3b1b6e9d1so90110411fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 06:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716471275; x=1717076075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtbQQajEFybjK9HptnFVriGEZVc+zK1/sxZYJMckKQ0=;
        b=XCyWey+Hk7CZl3QddtYt4cxPeEvsOs8htgV7CBcTXZAY2sL806AKeKJnBi/vqmtxot
         fVNKV+9AWYlfjZmqnipTfqrJ+zHXauLFDajZfJXUVR3c9HCr75dcI/QGzp6FbJIPPTy+
         MCeZXAUMJ6G23c9XousKpZztSPGKb6G1M2EBIwuQGU8WgoDtAUcbgxVnrgoe5AKAhbQe
         dVF/4TeRHdo25v/vBmzqz9CR9Q+m0SWNP9DxF6r6vEmEfTCUR7TQx52PM9meuFeYYS3i
         RM+UJRCz1rhjMfSMAoV1EqrNLOx6DHHDqxBMCwoV6HF2gLAo4mbhcqX4MqP4eVS18fIS
         7Y2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716471275; x=1717076075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtbQQajEFybjK9HptnFVriGEZVc+zK1/sxZYJMckKQ0=;
        b=GbXaaI1+u1/V8IBW956G1yTaaNMD0+AWpejbUIRS5QzAWcXuPlTDtNGGxQRsuDQ7AQ
         ZqHKpf4F1CezLxuvN8eqY8+LBv/85NK5JHBsyO5OLyDyn3hLEb8GcgDuBly/B/8J1BHd
         ztjHFkWINz97FlFevDNj/ttJXYPMcBYxhkvDTmrGGP97I4xJ/GB6H9Zkp1/yDjBpVf9n
         e7aDNOy9h91TwonFnB3EqMEvRLph3YSINQYUnTNlUQNxX5Hpy8JnGmpeZTc7/J2FnxeK
         aA3c2q8tfJbXMXReNx5NHRF+XI24SdHhujitcGZdibOuBGfAX8ALoJ3EuUrc5BLZ9+xN
         oojg==
X-Forwarded-Encrypted: i=1; AJvYcCVEFdzdcW2v7ElT4fV5KqStpUYTutJd8GitAHB3NLACQzLPbdEraYSel/XOkWi/ePCDmuLYeAsBLCCWEQoGvizum9uV/1zMo2gPDlLJ
X-Gm-Message-State: AOJu0YyC6yHX0bM/8Nk4Hhzd0FAQA8sAxoaPh1keBDjKXJ6eoPLi71mM
	tEBMtwFPqJfszZ5jDXzalcyJN9tv5/iFE1hIY6Mv+Mh8gbUWJ0LmFdRECNKXlBrpSCHeBtrMLDj
	MZMXvNPDPKdEtHvRDYQYbeRpJ51oSS0ss
X-Google-Smtp-Source: AGHT+IGrjPkj92rK8az8Rkwh6Nfn/LwvOSJYNgQY53BW8Pi/H1c5xfUnkRbo7lpLDaw+HBzmKK+OQ4b+H4MVPxAdlf8=
X-Received: by 2002:a2e:7302:0:b0:2e7:102f:7aeb with SMTP id
 38308e7fff4ca-2e949540b29mr32685201fa.40.1716471274703; Thu, 23 May 2024
 06:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522082729.971123-1-ubizjak@gmail.com> <20240522082729.971123-2-ubizjak@gmail.com>
 <c1892ba9-4eae-40fc-b3ab-73d0f82a74ea@linux.intel.com>
In-Reply-To: <c1892ba9-4eae-40fc-b3ab-73d0f82a74ea@linux.intel.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 23 May 2024 15:34:23 +0200
Message-ID: <CAFULd4Z=YkV1Hbs4DikPBwO-6rg8tfDLGeacSCnfbC02E5y+Cg@mail.gmail.com>
Subject: Re: [PATCH 2/3] iommu/vt-d: Use try_cmpxchg64() in intel_pasid_get_entry()
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 3:24=E2=80=AFPM Baolu Lu <baolu.lu@linux.intel.com>=
 wrote:
>
> On 2024/5/22 16:26, Uros Bizjak wrote:
> > Use try_cmpxchg64() instead of cmpxchg64 (*ptr, old, new) !=3D old in
> > intel_pasid_get_entry().  cmpxchg returns success in ZF flag, so
> > this change saves a compare after cmpxchg (and related move
> > instruction in front of cmpxchg).
> >
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Cc: David Woodhouse <dwmw2@infradead.org>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > ---
> >   drivers/iommu/intel/pasid.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> > index abce19e2ad6f..9bf45bc4b967 100644
> > --- a/drivers/iommu/intel/pasid.c
> > +++ b/drivers/iommu/intel/pasid.c
> > @@ -146,6 +146,8 @@ static struct pasid_entry *intel_pasid_get_entry(st=
ruct device *dev, u32 pasid)
> >   retry:
> >       entries =3D get_pasid_table_from_pde(&dir[dir_index]);
> >       if (!entries) {
> > +             u64 tmp;
> > +
> >               entries =3D iommu_alloc_page_node(info->iommu->node, GFP_=
ATOMIC);
> >               if (!entries)
> >                       return NULL;
> > @@ -156,8 +158,9 @@ static struct pasid_entry *intel_pasid_get_entry(st=
ruct device *dev, u32 pasid)
> >                * clear. However, this entry might be populated by other=
s
> >                * while we are preparing it. Use theirs with a retry.
> >                */
> > -             if (cmpxchg64(&dir[dir_index].val, 0ULL,
> > -                           (u64)virt_to_phys(entries) | PASID_PTE_PRES=
ENT)) {
> > +             tmp =3D 0ULL;
>
> nit: can this simply be
>                 tmp =3D 0;
> ?

I just took the same suffix as it was in the original code, but for
zero literal, it does not make any change. I can change it, it
preferred.

> > +             if (!try_cmpxchg64(&dir[dir_index].val, &tmp,
> > +                                (u64)virt_to_phys(entries) | PASID_PTE=
_PRESENT)) {
>
> Above change will cause a dead loop during boot. It should be

No, it is correct as written:

if (cmpxchg64(*ptr, 0, new))

can be written as:

if (cmpxchg64(*ptr, 0, new) !=3D 0)

this is equivalent to:

tmp =3D 0ULL;
if (!try_cmpxchg64(*ptr, &tmp, new))

Thanks,
Uros.

