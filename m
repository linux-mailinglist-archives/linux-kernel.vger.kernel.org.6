Return-Path: <linux-kernel+bounces-233570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4489091B9AB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1EA01F21EEF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 08:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79856145354;
	Fri, 28 Jun 2024 08:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dXaG6OAi"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131CA14389A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 08:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719562782; cv=none; b=KWyVI7UnV7YLVTLwAEDlPL8py9DaZ4BEyECFrdXLjxPA7TWclv+uolfHWrvCZP4dn2KBaNyveWq8/hJLGt4k3pwMXHj5CcXV48kKK2UKHdEKVn8r/ObGaIRhZF0tyzp+kCDSP+y7KrcVNq0tsClHB+wprQEC1P9+a2dJqKEApS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719562782; c=relaxed/simple;
	bh=s56WFNCfVR9NR2a4mjgRyVAOJGxNrIS6iWxfdXLw8AA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jop4MreZmesAQOdKCZxjIB+GGQOC23h1Krb4mt9Qa73iyyCWH6gwB+CZkpxS13VrzOuFcrcqFpm0YXb1qYNduDnqGSOXOs+PpxCh6CJRqcAvkho81vix1mfNhEZPJ8obrSxfj7lIVao9O1gJtqZoefea4zA6M0OOIM+72Ha4e2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=dXaG6OAi; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7f3d884e70bso13727139f.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 01:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1719562780; x=1720167580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/qO9FkT/vVabsz0HBj+1khfm42T6GUcPufAI2E8LYM=;
        b=dXaG6OAiketJ5bjpaElPXloGKvMrx19YdLTokLu5ThpHgWBJAbY7a323klqJmLH1B4
         JK0XJ4NsLT0HRYTqjh6CkpxyksuGaCEAI1ThAvVf6o8R+mqyjFsFOTHjt3VA8mz3EvIk
         rpvZRDXXANFJ8Fp0jRMk8ULszi07GcvIobH3lSUqkmUaBxq6hCzZDjRG2hAr9IHFbBSf
         wimut+NI+95TSWdSkiAL0zbtAajdQlqBayMU2YpQbD0/lqOoCOWmPPwDaFyxJw84pXZE
         ayzZJyaA1U3C6kgGrGWGAnZ5xYOhejoq14xbPISPk0CFmqW/HwCH4zZ7l1xRRUXWygfv
         k4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719562780; x=1720167580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/qO9FkT/vVabsz0HBj+1khfm42T6GUcPufAI2E8LYM=;
        b=SZxcUCLOF08YdZ160SeVQxyL6Dl6THd/3Yn3M8eWozYAfj3o4yUmJmWdLrpSHhTbEx
         sxo2fdqXUTl/q8SwiW3swtpKxboednFxmDUJYqZ+TBvpv6ITr++Q0tkE/+UAtZ9bNMcF
         So06wgrhNx+j49ASF7mcXRIzoye+WU6ko32DiPhMU34NXJHA4QfwI0803uYjLvoC94Rt
         jWM3KaOrNtlLlVl11Yi8A47NCcbAyg419x1VU8/x46y7NWhB+m3ycs89awT/XwaTUQ/2
         00KNBS8jOFDLKzhSqsBwXMe6YMMNhfDmTRXDoFiygMC2+WvpzNSKrgMib77SyhifpJfn
         miNw==
X-Forwarded-Encrypted: i=1; AJvYcCUeHwTBc68IQMg4R7KMTqFK1PuvdXpsbxD0naxukQnjt2JR4IZPON5n+XanMvlRosGO6Bz3ZDbNJFcPEVP0RM7oy2Cd3WEL530Ha+YF
X-Gm-Message-State: AOJu0YykBOkVQmAz2wZhpghxcswSLHqxlHtqdAhavK0AcTW448E5Ftcq
	vxv5p5nZMKqqXK7OYPHFYr48LyERIaBrLOg/CB+oQt/WnejTfOPIZmRF1CIRe4XBUAnBd29C7fb
	kLVYwaOFSbZXBdUSwgP5Dl2bvcJRKCiu9dgzQaA==
X-Google-Smtp-Source: AGHT+IHn2evgOJLaaJiRgXsD5cceTO6G9y4KoRv5dNvVpAYoPqBKVn2PGWboQ5lMNsbOksImkAt4wfLp1T5FCVkhq0I=
X-Received: by 2002:a05:6602:2cd5:b0:7f3:d2d5:f06a with SMTP id
 ca18e2360f4ac-7f3d2d5f2acmr952657739f.13.1719562779958; Fri, 28 Jun 2024
 01:19:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614142156.29420-1-zong.li@sifive.com> <20240614142156.29420-9-zong.li@sifive.com>
 <20240619161740.GP1091770@ziepe.ca>
In-Reply-To: <20240619161740.GP1091770@ziepe.ca>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 28 Jun 2024 16:19:28 +0800
Message-ID: <CANXhq0pgQMHGVv12K0s9ovd0OkOa15QCdH4HMfZGCy5hYXSWMw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/10] iommu/riscv: support nested iommu for
 flushing cache
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, kevin.tian@intel.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 12:17=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Fri, Jun 14, 2024 at 10:21:54PM +0800, Zong Li wrote:
> > This patch implements cache_invalidate_user operation for the userspace
> > to flush the hardware caches for a nested domain through iommufd.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  drivers/iommu/riscv/iommu.c  | 90 ++++++++++++++++++++++++++++++++++--
> >  include/uapi/linux/iommufd.h | 11 +++++
> >  2 files changed, 97 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> > index 410b236e9b24..d08eb0a2939e 100644
> > --- a/drivers/iommu/riscv/iommu.c
> > +++ b/drivers/iommu/riscv/iommu.c
> > @@ -1587,8 +1587,9 @@ static int riscv_iommu_attach_dev_nested(struct i=
ommu_domain *domain, struct dev
> >       if (riscv_iommu_bond_link(riscv_domain, dev))
> >               return -ENOMEM;
> >
> > -     riscv_iommu_iotlb_inval(riscv_domain, 0, ULONG_MAX);
> > -     info->dc_user.ta |=3D RISCV_IOMMU_PC_TA_V;
> > +     if (riscv_iommu_bond_link(info->domain, dev))
> > +             return -ENOMEM;
>
> ?? Is this in the wrong patch then? Confused

Yes, it should be in 7th patch in this series. I will fix it in next versio=
n.

>
> >       riscv_iommu_iodir_update(iommu, dev, &info->dc_user);
> >
> >       info->domain =3D riscv_domain;
> > @@ -1611,13 +1612,92 @@ static void riscv_iommu_domain_free_nested(stru=
ct iommu_domain *domain)
> >       kfree(riscv_domain);
> >  }
> >
> > +static int riscv_iommu_fix_user_cmd(struct riscv_iommu_command *cmd,
> > +                                 unsigned int pscid, unsigned int gsci=
d)
> > +{
> > +     u32 opcode =3D FIELD_GET(RISCV_IOMMU_CMD_OPCODE, cmd->dword0);
> > +
> > +     switch (opcode) {
> > +     case RISCV_IOMMU_CMD_IOTINVAL_OPCODE:
> > +             u32 func =3D FIELD_GET(RISCV_IOMMU_CMD_FUNC, cmd->dword0)=
;
> > +
> > +             if (func !=3D RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA &&
> > +                 func !=3D RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA) {
> > +                     pr_warn("The IOTINVAL function: 0x%x is not suppo=
rted\n",
> > +                             func);
> > +                     return -EOPNOTSUPP;
> > +             }
> > +
> > +             if (func =3D=3D RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA) {
> > +                     cmd->dword0 &=3D ~RISCV_IOMMU_CMD_FUNC;
> > +                     cmd->dword0 |=3D FIELD_PREP(RISCV_IOMMU_CMD_FUNC,
> > +                                               RISCV_IOMMU_CMD_IOTINVA=
L_FUNC_VMA);
> > +             }
> > +
> > +             cmd->dword0 &=3D ~(RISCV_IOMMU_CMD_IOTINVAL_PSCID |
> > +                              RISCV_IOMMU_CMD_IOTINVAL_GSCID);
> > +             riscv_iommu_cmd_inval_set_pscid(cmd, pscid);
> > +             riscv_iommu_cmd_inval_set_gscid(cmd, gscid);
> > +             break;
> > +     case RISCV_IOMMU_CMD_IODIR_OPCODE:
> > +             /*
> > +              * Ensure the device ID is right. We expect that VMM has
> > +              * transferred the device ID to host's from guest's.
> > +              */
>
> I'm not sure what this remark means, but I expect you will need to
> translate any devices IDs from virtual to physical.

I think we need some data structure to map it. I didn't do that here
because our internal implementation translates the right ID in VMM,
but as you mentioned, we can't expect that VMM will do that for
kernel.

>
> >
> >  static int
> > -riscv_iommu_get_dc_user(struct device *dev, struct iommu_hwpt_riscv_io=
mmu *user_arg)
> > +riscv_iommu_get_dc_user(struct device *dev, struct iommu_hwpt_riscv_io=
mmu *user_arg,
> > +                     struct riscv_iommu_domain *s1_domain)
> >  {
> >       struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
> >       struct riscv_iommu_device *iommu =3D dev_to_iommu(dev);
> > @@ -1663,6 +1743,8 @@ riscv_iommu_get_dc_user(struct device *dev, struc=
t iommu_hwpt_riscv_iommu *user_
> >                      riscv_iommu_get_dc(iommu, fwspec->ids[i]),
> >                      sizeof(struct riscv_iommu_dc));
> >               info->dc_user.fsc =3D dc.fsc;
> > +             info->dc_user.ta =3D FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, =
s1_domain->pscid) |
> > +                                           RISCV_IOMMU_PC_TA_V;
> >       }
>
> It is really weird that the s1 domain has any kind of id. What is the
> PSCID? Is it analogous to VMID on ARM?

I think the VMID is closer to the GSCID. The PSCID might be more like
the ASID, as it is used as the address space ID for the process
identified by the first-stage page table.
The GSCID used to tag the G-stage TLB, the PSCID is used to tag the
single stage TLB and the tuple {GSCID, PSCID} is used to tag the
VS-stage TLB. The IOTINVAL.VMA command can flush the mapping by
matching GSCID only, PSCID only or the tuple {GSCID, PSCID}. We can
consider the situation that there are two devices pass through to a
guest, then we will have two s1 domains under the same s2 domain, and
we can flush their mapping by { GSCID, PSCID } and { GSCID, PSCID' }
respectively.

>
> Jason

