Return-Path: <linux-kernel+bounces-224078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CCE911CEA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 438DFB25F73
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595DA16C688;
	Fri, 21 Jun 2024 07:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="O1M2IHSt"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5127616B3B4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955259; cv=none; b=nE21Hhw2Cxr3X56YSRW6+ptx+jklm8J2ArsZswnXnayWseVHCc8bQ35ZdAFcT8P7dyErG5JkkbZOqLe/H8jGpHlJimV33hqJq+svA1o1GIwRjTSXGX3UsSAE1Ew6syW8L/Hrd7VzTuqLPRrfARBEu3j/Dy9AaIAY6BlwgfqgBRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955259; c=relaxed/simple;
	bh=TJ/fM4/Bdi4zpe5sQdT9e9LS7r9y4uTQdY+a7ddRtPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ariqXBfTqIsz+ZbbbgPJNFeGtTjJTk6JsjxN4R6CpWjNAPRqXXZmYfnJkf3K7DMsIvG4uKLq7VnYQzxZWPtQw/fuYoMLhIxCkrY312edUq07Tflr33PLphHmornjHiP3AV8bkFTLz8XighkpQ6/QW3EYVqxOwG8lXe9d3Z12TMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=O1M2IHSt; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7eb895539e3so63771339f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 00:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718955257; x=1719560057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YJB5WMsYvwJwIsrILucvgKQ+tYLfCsBglnam11pazM=;
        b=O1M2IHStQMAcUikkwL6hVg1TuDGpq+GmY+nUDR7fM1ZWslcB2ukn23s+PWTgIH+X8f
         R7eCO7jqkk25sugHV/F2LTxqvbPSRDGWFg1G39VT+8ipsSJ2dMyqIHWuKhDL+kCe9Bs0
         +/BNuEzerHMXB823Wj7YS7i9wROJwyHyPAe5Z/mvAvKoy6IPaJok0VnKdeMwNNYLR7Pr
         rRqnSOr8AkV3GXEWHCbIsPlpX4OQQIfLJr5C+rkTjZ/ZQQ+mVVusxfw7kRy1DKwL0Wfb
         AowB8Jvjd3KxER8zKgv9P9j2wcRrz3fW+/rVlLePYQZ65keVD13AWbPeqtY6DNeuQG9a
         N6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718955257; x=1719560057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YJB5WMsYvwJwIsrILucvgKQ+tYLfCsBglnam11pazM=;
        b=kKDBjgFCmhksPrQG2UhBSmYWfk3+4K+41XuQg3pj03HlkUIbGIKXwYF6SsPMCWNdI3
         0XJY8yl0SVi0gd9wIkulXJikX/qgyr0al5nhcr4WYx5pTeSGnEBqS4qvtOzikItA6YS3
         GfZZUEp8YdDlbvByKSW2wFKPNnU+QbSlg94fwtIegWJVmWDEMxODtbECZM4zpKV1nK2V
         wMF/zJLcPUiYR+TVGFabyGRDiV6JOM7DL6fo5s6+5eGF2DwtgohdZBT8HIIoYPpNr7YP
         5II0YbzOPK4Oeul3IBULE/Eo/ZngUZAbOPUVcWU9zCEJo/k1fyy8kKkXoNqPDXzMrezb
         K2Vw==
X-Forwarded-Encrypted: i=1; AJvYcCW0t5q6bqjGgo2oD5ythWQkSyTs7F8ki8/7VIVYTzNFKBPhAt8X4vtS2jZbEzqX4zzk8x+qwGC5R6aD+jXHIBcxXDo52iNS7t44OxRZ
X-Gm-Message-State: AOJu0Yy70ELOmBB6bywgcNgJzXrNdFBEwZDmbF01H7t9Ai2XaBNl4PLI
	uIG4soQ8i4/1VNekrqQnI6CeGh8L/yRXTDdrSn4gXt09Z6hwrJ/7lc4Z+bRh09YRe3Ozj5zSfSO
	NYRWnu1cYzDSlu2KURsAEL+m9hg4yfKX3TP/bfw==
X-Google-Smtp-Source: AGHT+IH2z2ENNh/7avn9eIUE25VrvT6mYZ65u1+C3Qlt1wQc1RVUMHzbx3/IqLBD6fvxFHk4VEe0NCBvO94Vf6OBfD8=
X-Received: by 2002:a05:6602:2c86:b0:7eb:85f7:5f5 with SMTP id
 ca18e2360f4ac-7f13ee7bca3mr913038139f.14.1718955257262; Fri, 21 Jun 2024
 00:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614142156.29420-1-zong.li@sifive.com> <20240614142156.29420-8-zong.li@sifive.com>
 <d003f916-28ca-451a-a2e1-e58c66fc3459@oracle.com>
In-Reply-To: <d003f916-28ca-451a-a2e1-e58c66fc3459@oracle.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 21 Jun 2024 15:34:06 +0800
Message-ID: <CANXhq0q8P+n52PhOc5Uu+oTBSY9bukMPXz=n909TcoXooXS8PA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 07/10] iommu/riscv: support nested iommu for
 creating domains owned by userspace
To: Joao Martins <joao.m.martins@oracle.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, jgg@ziepe.ca, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 12:34=E2=80=AFAM Joao Martins <joao.m.martins@oracl=
e.com> wrote:
>
> On 14/06/2024 15:21, Zong Li wrote:
> > +static struct iommu_domain *
> > +riscv_iommu_domain_alloc_user(struct device *dev, u32 flags,
> > +                           struct iommu_domain *parent,
> > +                           const struct iommu_user_data *user_data)
> > +{
> > +     struct iommu_domain *domain;
> > +     struct riscv_iommu_domain *riscv_domain;
> > +
> > +     /* Allocate stage-1 domain if it has stage-2 parent domain */
> > +     if (parent)
> > +             return riscv_iommu_domain_alloc_nested(dev, parent, user_=
data);
> > +
> > +     if (flags & ~((IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DI=
RTY_TRACKING)))
> > +             return ERR_PTR(-EOPNOTSUPP);
> > +
>
> IOMMU_HWPT_ALLOC_DIRTY_TRACKING flag check should be dropped if it's not
> supported in code (which looks to be the case in your series) e.g.

Thanks for your tips, I will remove it in the next version.

>
>         if (flags & ~((IOMMU_HWPT_ALLOC_NEST_PARENT)))
>                 return ERR_PTR(-EOPNOTSUPP);

