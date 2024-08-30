Return-Path: <linux-kernel+bounces-308953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE34696643B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E17F1C232AC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409391B2EE8;
	Fri, 30 Aug 2024 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8I1REFo"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F53412F59C
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725028338; cv=none; b=aJEcKGbllHKqNhWnxtJyl6Bx1pddq7ko++IkA2BJscgUOrgXVRI5cT9MnEOmyj9750hQ9QNkqg0Rn4OwI6LRBcLfh6KjWJTMtvOWMNiDm8FjbiLyDF4VhsCJ041Auo94AqCIBEQx3RjOndQ7GCDkJswZTxAn8P+I0VUIg0vKgl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725028338; c=relaxed/simple;
	bh=gn1r6Kl82bYEcmmeYzFY7WR8tPd7NOokxC5RStEMEBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbNruWyaX2OpqLkIlMmCq4zEycpISpmEclulUrwc1jrjFe7gU2cYY2LRsTNfKXnVwS22sklDRI29KGThgxGTK9kk5PSdJL+QasTJgeAQ4tc9w3BjPF9Xae0lz0irc4JH2gOvTf8YeUxCchtsZTpA0lEkyTSuYogqh4t9muKtbNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8I1REFo; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-45693d58a19so1782781cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 07:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725028336; x=1725633136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HV9KRMlNGyvcppnTBVsTcozYBeJqYoCFTmaDKQHvbac=;
        b=M8I1REFoZtBMpkZPd96GGf31zxChYu2RO0qNthO/ItDzyy1XWXOFhCIzMK4jcOP6T0
         Vlgh6PtJAkpB47udL/A/CElKC7YS9S2OjiXjNi8fvfpydEo/PVg5qIQR98KvZNRZZCev
         W+iEz/Bua38kPI9unyVjzuTqFObsjRe3vqEMJTZVOLQDIHcfMAFyHC/8/yapviKpC+XI
         ERqTk695Pk2Spm/19qE9S7CIvPZzs5PcW4A15rEGdJHULikMcRW4vH+aLk8GHGHtaBgu
         56LxRqGU3i0CQrDcQ07JwLPQGS3Znd0OseWJ8FfW6wFc4wL2V+CNCJxKwmSmCaADfJ3L
         IcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725028336; x=1725633136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HV9KRMlNGyvcppnTBVsTcozYBeJqYoCFTmaDKQHvbac=;
        b=tob6QZ+kDa/b1jmEiuucc8E4NIeP6a+nh1Jyw843nnYxy4L1j5B2ZJmlJ4wAwLaH8i
         i7gqUtX56VG1xyKRFr99OhQlZLU9rq6DXCwNR/7hcji9i64wrxax8sK5kuZqAD3dja3+
         3hsU9BetiSvE9jZTU1Pu1DFX6w3gkrDxBRaYVw/dT25HKY5wfIupM5JouypHdkwdDn04
         Yps4dXXUDj1kVpjfT15Om1fIn/iCJTU5eMEpCbjQj7eNcNc9qB3qqlmYl0Qdr3n5NTWA
         rbppTrxipubNC9A+n7Y8Hag1tx3sU4OhNMcVCQWNYB5Eae7R9lcJWAilVHRQZoLELmWd
         gQPw==
X-Forwarded-Encrypted: i=1; AJvYcCVayRhWfX3I7IcPZ9FCWBklAy2XsJWnyf5Sr6VKU8Z4rf3MXm2YIdMdyJAbqFqGJuA5VACU3JLcNjhfdoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcNDI7VFxj31D2EC7PktZQ7Ti70Cq/iKQk7Q2w9cEqO1GNTuZO
	DMNOP0/mwG14nJClifwKv2lgeZAPFmFrRxzEqWNve8E39x0mSNfK/FpYDXJ9FrKdoDNFbiWoUhb
	+7SZwSMKYeVcqmyMs1Unoq+2WmYQ=
X-Google-Smtp-Source: AGHT+IEhen+eT2CxbDrVJBf7xHsy41tp3FjD+CISR2JujX0jEK8QsaJcEM0g3oP6DwVm3H8SM9tmPZCR+bAeV3+9Exc=
X-Received: by 2002:a05:622a:114e:b0:456:45d8:2f08 with SMTP id
 d75a77b69052e-4567f6d3c9bmr72722331cf.46.1725028335922; Fri, 30 Aug 2024
 07:32:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827181717.187245-1-robdclark@gmail.com> <20240827181717.187245-4-robdclark@gmail.com>
 <20240830132009.GB8615@willie-the-truck>
In-Reply-To: <20240830132009.GB8615@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 30 Aug 2024 07:32:02 -0700
Message-ID: <CAF6AEGuLFsGtE1LQNge_WRxdYwYnHAgkbcL5Xh4HUxx2XuzNLQ@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] iommu/io-pgtable-arm: Add way to debug pgtable walk
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>, 
	Rob Clark <robdclark@chromium.org>, Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Joao Martins <joao.m.martins@oracle.com>, Kevin Tian <kevin.tian@intel.com>, 
	Steven Price <steven.price@arm.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 6:20=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Tue, Aug 27, 2024 at 11:17:11AM -0700, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Add an io-pgtable method to walk the pgtable returning the raw PTEs tha=
t
> > would be traversed for a given iova access.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/iommu/io-pgtable-arm.c | 25 +++++++++++++++++++++++++
> >  include/linux/io-pgtable.h     | 15 +++++++++++++++
> >  2 files changed, 40 insertions(+)
> >
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-=
arm.c
> > index efed8e519111..11af49119f37 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -759,6 +759,30 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io=
_pgtable_ops *ops,
> >       return iopte_to_paddr(d.pte, data) | iova;
> >  }
> >
> > +static int visit_pgtable_walk(struct io_pgtable_walk_data *walk_data, =
int lvl,
> > +                           arm_lpae_iopte *ptep, size_t size)
> > +{
> > +     struct arm_lpae_io_pgtable_walk_data *data =3D walk_data->data;
> > +     data->ptes[data->level++] =3D *ptep;
> > +     return 0;
> > +}
>
> I'm struggling to see how this works given that the ->visit() callback
> is only called for leaf entries in the page-table. What am I missing?

Yeah, we should just go back to my v6 before I tried to re-use the
arm_lpae_read_and_clear_dirty() walker.. addressing review comments is
just making it worse since then

BR,
-R

