Return-Path: <linux-kernel+bounces-335413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2763E97E536
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 06:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BF341F2174F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 04:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBA6D2FB;
	Mon, 23 Sep 2024 04:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnzQWol6"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732A1184
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 04:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727064435; cv=none; b=OSmeisj6erOmaMHavZZ9lvLVeBq2d9jz2DIgx4U+ty0TG2vf+n+5SMjQot/Xg7/moCUqqMcSgs4wrkBxRnGcTSGEM49tbk8Kqzx5ux5TBacRJIi8dijlJaIbO5m9NG+mhUmPq65d6bFw56MCOnh/+hca3/2VX6ksiviCNH5c37I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727064435; c=relaxed/simple;
	bh=Av2HP2d4DuN93WBim/lcOKrhpB1D2CCO93sIb+MJz28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ralfTQhwBDQMlbx39OhSV93yMh8F5164gB2+3Iet8XPatDIQs6Z5Miu+v9M/GrxljUEZi4xfdm2r32kU0KdlSNC9IouAKT64FPgr+X3TYyZY498J7oUvlUowHTocsHLbcRXX4H85j2xbFheEAiBc5xkIl0TSGlw/IfSbGoHEUcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnzQWol6; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-50108a42fa9so1005885e0c.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 21:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727064433; x=1727669233; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7Fk1em3RkwauI4SHHUi/ClfolM0H5W//ioGctZ2qyuY=;
        b=gnzQWol6FEcZnjnpUMbOMzRMvANk7K9+ce7HpjBby+jq4yA4RyRb1GC78pQ16EQ/st
         McIZ7cwBR4IussC0d/Dmk560I4y1/g7NF2APIvDKhcDmcBkjNGRZKlo12dRDaWtXI3CZ
         5DaCladbazDj18xJLf3GchY1ay7UpR+N5A4oTXJHnbHV83IHqx1wCFcwrvGQ713HAuZ0
         DlERQAodrDCnA/5ISJEPm07HU/PEvf4xd0Klhd47wkMT98+yINgKVU2sA2nAjsMp+mob
         9QXeH/Kuj+L1rEw/pTdbsMVo3FIICUqg+ehA7m4WRoMUQ+9w0x+3zK5gMr7NVjmJbWQh
         KeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727064433; x=1727669233;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Fk1em3RkwauI4SHHUi/ClfolM0H5W//ioGctZ2qyuY=;
        b=bBojsJ5soGuWakuGMZZM4LOWb5BOy0tVkkIFoGRPoXu5vRNoWPGp2383LK9jRXe9EQ
         Y8HH/QE/25b0CuEjAXdwtxTjU3WkLHvhVIdsTms+BWkRWK3hXBf4VHwH9GG2bW4lfirf
         CmCokWcDbaR+rtLAtkYrn6OqCxxPZ15W/muP/yj5NltZc6XbJd+ZW8njkudbQrrwOml/
         VxTsl13ANbdt5ypgxhYJZeYRto0gLZ/Z5+tLPkkTaVw6poVy5z1Mc6/NqO2YY280TIx0
         WqPdgdRmQsSgS7lYELSKEdMXvM96bf6t6WU14MoNbQegDq9OOAqkx0OKJl1uyWHT3yy3
         zxAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRXvDqaE1OQjRDEjn5e8o+CY/PWPFESfYQJ/MYTWQpj4rYrDfHWi0J74PKZu0BcZFP/SMvi44N+ruJJAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkj91C16xve93UUeS0jiJcv8ODjn0loWlpnewHAT85cm688kET
	5NNl8/054S13tBy1gEBHG0Et8wk1YKwN6vIHZ/y5lY1MdjZIqg62ivuQzfhPAC3JSM3qpmL7z9T
	9Gi4P4aGw60HGpCeN6SB1mWyNhWo=
X-Google-Smtp-Source: AGHT+IEM5gItLQ6kZT+yJF478APHV3QMsyQ1g9Rz3IpI/U7uM7hSN+HlUs49wUj4AnjuLNSZ6kuSJG6kiXzwtDHBiZw=
X-Received: by 2002:a05:6122:d8e:b0:4fc:edb4:3386 with SMTP id
 71dfb90a1353d-503e40d23b3mr5333144e0c.6.1727064433277; Sun, 22 Sep 2024
 21:07:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922155621.49432-1-kdipendra88@gmail.com> <ZvDcEFXhpMo3K-Zd@google.com>
In-Reply-To: <ZvDcEFXhpMo3K-Zd@google.com>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Mon, 23 Sep 2024 09:52:02 +0545
Message-ID: <CAEKBCKMqe1_ijAygn4n-oy8=WoaN-CoDBK_wgDJNEMTgJPG7gw@mail.gmail.com>
Subject: Re: [PATCH] Staging: iommu: Replace null pointer check with IS_ERR in arm_smmu_domain_alloc_user()
To: Pranjal Shrivastava <praan@google.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Pranjal,

On Mon, 23 Sept 2024 at 08:55, Pranjal Shrivastava <praan@google.com> wrote:
>
> On Sun, Sep 22, 2024 at 03:56:20PM +0000, Dipendra Khadka wrote:
> > The smatch reported following:
> > '''
> > drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3065 arm_smmu_domain_alloc_user() warn: 'smmu_domain' is an error pointer or valid
> > drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3068 arm_smmu_domain_alloc_user() error: 'smmu_domain' dereferencing possible ERR_PTR()
> > '''
> >
> > The function arm_smmu_domain_alloc() handles the null pointer after
> > kzalloc and returns ERR_PTR(-ENOMEM).
> >
> > Replacing condition check !smmu_domain with IS_ERR(smmu_domain) and
> > returning smmu_domain.
>
> Hi Dipendra,
>
> Thanks for looking into the code. However, I think this was fixed last
> month by Dan's patch [1] and has been merged in the master branch.
> Please pull the latest. :)
>
> [1]
>  https://lore.kernel.org/linux-arm-kernel/172381875518.1794999.1134549433569030700.b4-ty@kernel.org/T/
>

I just checked on the staging-next. I will make sure to check on this
tree as well.

> >
> > Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index a31460f9f3d4..19c53c6f7578 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -3062,8 +3062,8 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
> >               return ERR_PTR(-EOPNOTSUPP);
> >
> >       smmu_domain = arm_smmu_domain_alloc();
> > -     if (!smmu_domain)
> > -             return ERR_PTR(-ENOMEM);
> > +     if (IS_ERR(smmu_domain))
> > +             return smmu_domain;
>
> Quick note, using something like `ERR_CAST` is better in such cases.
>

Thanks a lot for the knowledge.

> >
> >       smmu_domain->domain.type = IOMMU_DOMAIN_UNMANAGED;
> >       smmu_domain->domain.ops = arm_smmu_ops.default_domain_ops;
> > --
> > 2.43.0
> >
> >
>
> Thanks,
> Pranjal

Thanks,
Dipendra Khadka

