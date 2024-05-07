Return-Path: <linux-kernel+bounces-171704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0738BE787
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53EF51F25705
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AC21635DF;
	Tue,  7 May 2024 15:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="i+sZlqOc"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FA8161331
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715096130; cv=none; b=B2hwRx25D9X/6pFD7Ygsguokp+UkcsProsfGGI+9O8OAUYQLSIleylLCyXIEmE4cRlJnJxofey8FsQ4eUilUKuztjieGDBe5HxvXnz9U3vGJwzPOiMRW1q5dbx0lCHIZ6ARCQYeeWu2C7egJ5lpFASyu1x3Iy6CLZsB94rjziR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715096130; c=relaxed/simple;
	bh=AHmd40tFLpuB76nYEEXIiv7NLdIIAMsC68vMChwHn6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPgJzNZN4ziZDD/4FNfQPjHU48G56CjwMjtU7O73FmcmLeJJmSJheFBBN26kA/vUzJknwvXjLGJuLa+6yXe1j5XaYUXfjVCL2kntrReUPjWQZMOJdmaN4j3QjNYkwpcHdPWwakOHwhG+gjPtoIsbTffeAEJZ5M3SuEG+cJCxa10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=i+sZlqOc; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7ded01aa1d2so158264239f.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 08:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715096128; x=1715700928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fZeIxGU7jDZbp8MIAMXuP3cI2fycrTuvDnx0IrbFAQ=;
        b=i+sZlqOc3MkQmSognxggc5n17dDM4kHVWLwrl1hJW7/VpWZUXis/QTIMbVa7zVQvSc
         Ka1xONl22MN2IIhvXLtnxAvobi2+uxT/REqLkBV0Wr93utOiXNQcqfKd+/IDqBtgI3yL
         2eDEGin73/3hYX/nLXGGUwsY85plpOGNAm01Nx8rcqTy2pXYAPCyQ4H6/ZV9KZ1N0poK
         2/V1WZkkAf0rezJL0xSXtIu197XmMqBVrOWn1Z3k4nbbhOGMzLtPehPIEC9O8I24rE6D
         LS1BDMw9+AzS3leaI8HS1GNO+9zUNq49wBbFkhUTu2yr/MqP7wOFg7ImLSNTC8bp6mhl
         ajiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715096128; x=1715700928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fZeIxGU7jDZbp8MIAMXuP3cI2fycrTuvDnx0IrbFAQ=;
        b=uicJ8aCATtHfaHnxPy4G2s3FqTXeZj0fJnUyCR2+mXNCXEqlEpNp6CHHVoy3Q32YRK
         fCcjZkgyy0WKnghAEwcUYjj4oOJVTcBRhyx2w/eKhhOs3QeCRfe6fi6MlIKjOiZNXEtp
         tkufS2ulD0ODf1h5/rTFHtKwS2LFSYRWg4vN+dSHOhiAipYn1frZ9j60mO4dDTscD5+f
         ido+cVeFQO1AI3vcdL+RXp5lVcFn1gXv1WvG9zLpXM7stFjWhR6j42730CkEBMi0rzY9
         O14jehBcnmSDOGSfap+tW1+zy294lXgi0w/LJ2QD6E9Aq7mY/lks5cergwqPdGhmuYeQ
         iqng==
X-Forwarded-Encrypted: i=1; AJvYcCUlnCMaah8nGq5LVrcPI0CalyNaQlnm3rggh1ubZi3q99/M4w6OBRJ+R+XkW0bfF564YOUx1un8nHKh43dIu3ojqapqCBINnOeIjkpn
X-Gm-Message-State: AOJu0YxERYXBMlvPGfanrVMCjAacQHGMISKT1p0A7t8CneBkzV6usiLT
	01TcdVswn1QOI4/lu7fpYZPmWwPZSDrsreXfF+ozAQPTDV2WbcYchr9fTcZBR74DvwJ1boqcJcn
	Bv/dBjTjaIpVK06ABsgSLI6dmzhxAWNO1/5L04A==
X-Google-Smtp-Source: AGHT+IHqhr+YVZAu1ZOtkTbNqavDX8MQUCsFnE/WXIvw3MsduOLxL3dNlYhKHRcJc+TT/v2hNtcpr3nZKzMPIQcSz3I=
X-Received: by 2002:a05:6602:6d12:b0:7e1:7a0b:3091 with SMTP id
 im18-20020a0566026d1200b007e17a0b3091mr5247906iob.15.1715096127791; Tue, 07
 May 2024 08:35:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507142600.23844-1-zong.li@sifive.com> <20240507142600.23844-7-zong.li@sifive.com>
 <20240507150829.GJ901876@ziepe.ca>
In-Reply-To: <20240507150829.GJ901876@ziepe.ca>
From: Zong Li <zong.li@sifive.com>
Date: Tue, 7 May 2024 23:35:16 +0800
Message-ID: <CANXhq0rnWUT4ia-cUoTbSyEQUeCcmC9bC7HHru6Se-1K-PZRDQ@mail.gmail.com>
Subject: Re: [PATCH RFC RESEND 6/6] iommu/riscv: support nested iommu for
 flushing cache
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, kevin.tian@intel.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 11:08=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, May 07, 2024 at 10:26:00PM +0800, Zong Li wrote:
> > This patch implements cache_invalidate_user operation for the userspace
> > to flush the hardware caches for a nested domain through iommufd.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  drivers/iommu/riscv/iommu.c  | 91 ++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/iommufd.h |  9 ++++
> >  2 files changed, 100 insertions(+)
> >
> > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> > index 7eda850df475..4dd58fe2242d 100644
> > --- a/drivers/iommu/riscv/iommu.c
> > +++ b/drivers/iommu/riscv/iommu.c
> > @@ -1522,9 +1522,100 @@ static void riscv_iommu_domain_free_nested(stru=
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
> > +             break;
> > +     default:
> > +             pr_warn("The user command: 0x%x is not supported\n", opco=
de);
> > +             return -EOPNOTSUPP;
>
> No userspace triggerable warnings.

I don't complete understand about this. Could I know whether we should
suppress the message and return the error directly, or if we should
convert the warning to an error (i.e. pr_err)?

>
> > +static int riscv_iommu_cache_invalidate_user(struct iommu_domain *doma=
in,
> > +                                          struct iommu_user_data_array=
 *array)
> > +{
> > +     struct riscv_iommu_domain *riscv_domain =3D iommu_domain_to_riscv=
(domain);
> > +     struct riscv_iommu_device *iommu;
> > +     struct riscv_iommu_bond *bond;
> > +     struct riscv_iommu_command cmd;
> > +     struct iommu_hwpt_riscv_iommu_invalidate inv_info;
> > +     int ret, index;
> > +
> > +     if (!riscv_domain)
> > +             return -EINVAL;
> > +
> > +     /* Assume attached devices in the domain go through the same IOMM=
U device */
>
> No, you can't assume that.

Do you think that it makes sense to add a riscv_iommu_device structure
in riscv_iommu_domain? Or we might need to add some data structure to
build the mapping of the riscv_iommu_device and riscv_iommu_domain,
then we can get the corresponding riscv_iommu_device by
riscv_iommu_domain?
Thanks

>
> Jason

