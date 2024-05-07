Return-Path: <linux-kernel+bounces-171683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F5D8BE744
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C98D31C23EB8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F061635BA;
	Tue,  7 May 2024 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AZpy448d"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C67161327
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715095213; cv=none; b=JtFu5eFzn65bmyR+KJ0sKSJk/bIOu+jCfo11N8izWxpuwKElsoXKzB+rEeyK8RcOxB0NCG1VlyIgCDtveWLoJG04//OWW5xlHojjfdi9pqt6bG/NelNrwU+SIiGu3ZkaxcsZlSSJU6xoOqsCn1z/wtG5+VUWCJx01lLzV0Y3u+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715095213; c=relaxed/simple;
	bh=7wzzu5+Dyb2zQQ/BBHzdLsyJSaQZyO4yWyaBmCt+pjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qa1bnqMKTezV/nVSW+kmIiWIj14oEy5tlRgvj3IbWMh/6LqhfAvsaCBCjZ8qc5M+18a/ApsIn6BeJfgLZMxYjNDCyjI65hglhX0RbQi33SG+j/l7pifKTW5dYv+Iwbjwc4UcoYZxOtaKMCiQEoQhkw7MQw68mdSCcPk0JMt9aqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=AZpy448d; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7d9c2096c29so175748039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 08:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715095211; x=1715700011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3612MOIikzCEeo+mwv3X2VMyaMFpK5mgqqdWHRbusjg=;
        b=AZpy448doK/iK5AlReaECWW6bd//Oaw7EGEdbohJSOqAKh27gKenJwqvtXN9XdI0le
         HgIlnPjfT/Lo3TwaTZs790v7YwUThuNJMbgkFqqHWc9ByBUmQNwOmpa7HrB99UuQdKOO
         Cgj/mW+hrl7x4OwtpeD32neluhU/oep+HYl4ZqwZoHmNOiuNAGvI1QEbfkZRVSIzn/Jd
         oTPEL77Eg6Y4S8pB7Dv4Rw4GAUb1dvTAKjDckx5wu2vwClgIB9yGpZ4sYZFvX79FbVXQ
         eqd2PzeT6z15mK+eHoUPtFsj4U4g7f2aerz9fCdYOMwdc2i09zIovaWP1K7uavdTnGVQ
         bjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715095211; x=1715700011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3612MOIikzCEeo+mwv3X2VMyaMFpK5mgqqdWHRbusjg=;
        b=R6UjG3X95F16LvYOSPb4N9pLGnBjLuFF3bomnqmo/SPkhVpf4lqtG/mKoyMB8+mWej
         wIro/V4y2MWZsvPR9lPfC/8jdK74VlptyEBEKWw0e7JUHaJegtis3Txn+xfHQJ933uHY
         TV5G6HmvLf1k4NKBJZmK/2REWC2Ftfwl/blWKKocKWPG2zq+eBACrq9NPnElIU4BAjfg
         +XuzRRuDgHnetnpaVHtsfs9L4qkR/7AVVresmlQb1ivJ1UX9RLb0vol9DM22XwwwrsBz
         JzjhNkRIaKP+RtHWFxYGJxyw++X8dehq9k5CnGmhrpV+BYPyMcswLjq3Sgo9lyxg2gPv
         6VFw==
X-Forwarded-Encrypted: i=1; AJvYcCVozNFk4z9LcyotIo9dKzI9t5vuKj6Nd/AbUNkroZBGnq6B4AW8kwYYst0M7IRSXFJkGYiyptxXTOJsFzvzrsMcuWnlyC7gqzQ0N6zn
X-Gm-Message-State: AOJu0YxOL4OXiymvVbGP1RRMmL7H6WCp1Fsf7ZErD/QDhrC1105Vs++Q
	acX7dXpNpNXY1nR7WufK8AI6ej03bsGa9RdbMa1ZB50BKydEmQRqWIQPjkVY/IwOFLRwuXdSid4
	CHAvVXPm7jIt3aSpuCtSnEkO6Ib24v6bYXQR2bQ==
X-Google-Smtp-Source: AGHT+IFHKLBV5UyA+nE/FKsONZhELrkveEhHfV9QMKA63cqAy8XVSr7F4OwiQdsFr0lrM8BGsK3l5VTeIv2rndOqxu4=
X-Received: by 2002:a05:6602:f08:b0:7de:ac01:4224 with SMTP id
 hl8-20020a0566020f0800b007deac014224mr15044010iob.1.1715095210897; Tue, 07
 May 2024 08:20:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507142600.23844-1-zong.li@sifive.com> <20240507142600.23844-5-zong.li@sifive.com>
 <20240507145456.GH901876@ziepe.ca>
In-Reply-To: <20240507145456.GH901876@ziepe.ca>
From: Zong Li <zong.li@sifive.com>
Date: Tue, 7 May 2024 23:19:58 +0800
Message-ID: <CANXhq0ptCxyUc==oCG8MgLOCdF7Z=KRW4pct62BCSgsB_9hQkQ@mail.gmail.com>
Subject: Re: [PATCH RFC RESEND 4/6] iommu/riscv: support nested iommu for
 getting iommu hardware information
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, kevin.tian@intel.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 10:54=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, May 07, 2024 at 10:25:58PM +0800, Zong Li wrote:
> > +{
> > +     struct riscv_iommu_device *iommu =3D dev_to_iommu(dev);
> > +     struct iommu_hw_info_riscv_iommu *info;
> > +
> > +     if (!iommu)
> > +             return ERR_PTR(-ENODEV);
>
> This is not possible, don't include impossible checks like this.

Thanks for pointing this out, I will remove it in the next version.

>
> > +     info =3D kzalloc(sizeof(*info), GFP_KERNEL);
> > +     if (!info)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     info->capability =3D iommu->caps;
> > +     info->fctl =3D riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
> > +
> > +     *length =3D sizeof(*info);
> > +     *type =3D IOMMU_HW_INFO_TYPE_RISCV_IOMMU;
> > +
> > +     return info;
> > +}
> > +
> >  static int riscv_iommu_device_domain_type(struct device *dev)
> >  {
> >       return 0;
> > @@ -1560,6 +1582,7 @@ static void riscv_iommu_release_device(struct dev=
ice *dev)
> >  static const struct iommu_ops riscv_iommu_ops =3D {
> >       .pgsize_bitmap =3D SZ_4K,
> >       .of_xlate =3D riscv_iommu_of_xlate,
> > +     .hw_info =3D riscv_iommu_hw_info,
> >       .identity_domain =3D &riscv_iommu_identity_domain,
> >       .blocked_domain =3D &riscv_iommu_blocking_domain,
> >       .release_domain =3D &riscv_iommu_blocking_domain,
> > diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.=
h
> > index 1dfeaa2e649e..ec9aafd7d373 100644
> > --- a/include/uapi/linux/iommufd.h
> > +++ b/include/uapi/linux/iommufd.h
> > @@ -475,15 +475,28 @@ struct iommu_hw_info_vtd {
> >       __aligned_u64 ecap_reg;
> >  };
> >
> > +/**
> > + * struct iommu_hw_info_riscv_iommu - RISCV IOMMU hardware information
> > + *
> > + * @capability: Value of RISC-V IOMMU capability register
> > + * @fctl: Value of RISC-V IOMMU feature control register
> > + */
>
> Please call out explictly what spec these values come from.

Let me add the description for the section that defines them.

>
> > +struct iommu_hw_info_riscv_iommu {
> > +     __aligned_u64 capability;
> > +     __u32 fctl;
> > +};
>
> Add explicit padding here

Add a u32 reserve here in the next version. Thanks

>
> Jason

