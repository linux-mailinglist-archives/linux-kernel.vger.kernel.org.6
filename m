Return-Path: <linux-kernel+bounces-363431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A4899C257
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB69AB24EDD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2F6154C0C;
	Mon, 14 Oct 2024 07:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o9TDCI8u"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925CC15383F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892751; cv=none; b=cUBjz/ScqQuEXeaB12ZlAWRStcyeYs16y/usvj5BQYrVDIjm6Giby3yOl/q2oJnNZaKle3usQ+MiXubQNULxh2aisYl+cp4T70vxtCDBLFPt1lXRwcrrOn+Xtfqcb0sinIzNbPumLAt3gxE1o4iamsDu8EKAgANO/wZDuaTXoRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892751; c=relaxed/simple;
	bh=oFF6VHGttnHusqmr3FN2QG++jdlGO4+8p6CDui+ULbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4OjiFekCZt27T+nePVu74I6DO2az53FvPhjT3GgbkwCl0p/B7Yo4A0TlaKBrFn/Ty4JDs9tBA/+MB3Psygt/pXyffs523cWXU1uBrn1hMCX/vDkNHrGdbBFqpfkl/3Xm3VNxtya9KvzOQQZ6BXMWtUZr/vERtcAopHGgnYgtk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o9TDCI8u; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539f1292a9bso948492e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 00:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728892747; x=1729497547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ScjclWrKfNDFbBysTklj+SJ3rFHMGEWxbh3si/BH/Zk=;
        b=o9TDCI8uYdE8bghe9DJ03+YaGJYMSgN/XTBXs4N/EutsP9/OF7mWXqiDevOdbsrXNZ
         bl+pJjxhSPi8EtW8MQ5hyi3/uXSJUlgEeLXi2Svt0xOJNck6ERBuSFjiZr/v8K7hYWim
         4szAFuZCp89lSx7ZwMG3EWDSDNJtHayHBk3EesPgklFkDQ0a+67YY3RSQtIxfA+xaHks
         clLQLEGTnynb8JzzOrhXn0psy3yArNCfTEFHhsAnXIoTwzZJn0paajQm5NPglrg/0Ciu
         kyht2LBrIhR5M5D+QwZF2IhWa9R1WEZI3zS011z7ZDFCzh6L/Y6t5D1lq3K55CKCGk9L
         Rnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728892747; x=1729497547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ScjclWrKfNDFbBysTklj+SJ3rFHMGEWxbh3si/BH/Zk=;
        b=mwHgdKTL6cZEE8omkdVt8b0k2cqGZvRxDa1gaTl0zYylRh11gP+4nvyFP/D3NLjWYA
         vo/zpUfsiU3Ynm7VPPm7vejYkZVOuJwkSC6sCxqNjsOIbN7dyaCqoUG0+ofTCSFtpLS7
         VCFXvCkQ3ZbDhF4sX0tdxDhkPO0koyHvy6TqyKGUHO+UuY5gnc/UTVMQn3XC2a4gEPYi
         FTf8I7KINie45VnU3mgeCaea9XE57nltMqhy3vDKrPoRTtok3oP7j26++IHwQtwRwOZg
         bU5LaipLreZX3qIVnIpYjuPr1qWEha7ZKOefze5wnEXBjkQE13wKPH+Yw6yLPZufOXiP
         lqIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIVC/f+UuizjeGyPMSze8Gilkbk7ygzzgMqpoOu4fmZvZV2G5MpMxeDYLZlTQDuPWkR1qgT5V8Zb1GGUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw09AgACo4KdGbHgSJTFA5nYdnQpKhZ6k5iV40e8kutl/xV4+d
	d3phyLXHfR2j6UnwApc5LBFh6Ghf14FyMDkxWXIlHPyJV6TKBKG3o8OKLS2ySgldu9C9dLMZwvM
	hf6WHttL6Zvy+Wn0zJhD2YtTkANar0sbgsOeApA==
X-Google-Smtp-Source: AGHT+IEKyEtol/S+SVKZojpSYhC7ViJe62dDg31X0hlm2J4WIW4keP+c77Z9R7yIc1BX887mjL23tAglKwfPJlsZKB8=
X-Received: by 2002:a05:6512:3e21:b0:539:ebb6:7b36 with SMTP id
 2adb3069b0e04-539ebb67d8cmr1600580e87.25.1728892746567; Mon, 14 Oct 2024
 00:59:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728491453.git.nicolinc@nvidia.com> <88114b5c725bb3300a9599d3eeebded221a0b1f9.1728491453.git.nicolinc@nvidia.com>
 <CABQgh9Eaj_vy1=sS2Pf7RC7Vy5PopDfwoshECULEU-jK3JF_sQ@mail.gmail.com>
 <Zwn/4m8Ac0xEiJi8@Asurada-Nvidia> <CABQgh9Ft=xxJK-bjS6wCZ5BN4AiKtF9fzdBkevA3x2yb_4O4Kg@mail.gmail.com>
In-Reply-To: <CABQgh9Ft=xxJK-bjS6wCZ5BN4AiKtF9fzdBkevA3x2yb_4O4Kg@mail.gmail.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 14 Oct 2024 15:58:55 +0800
Message-ID: <CABQgh9HP1M8GAXMwf0ZNn5EpMBAvJU3JLRWcN5H1wfGrqXSe1Q@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its
 related struct
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, will@kernel.org, joro@8bytes.org, 
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com, dwmw2@infradead.org, 
	baolu.lu@linux.intel.com, shuah@kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com, 
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com, 
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com, yi.l.liu@intel.com, 
	aik@amd.com, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi, Nico

On Sat, 12 Oct 2024 at 18:18, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>
> On Sat, 12 Oct 2024 at 12:49, Nicolin Chen <nicolinc@nvidia.com> wrote:
> >
> > On Sat, Oct 12, 2024 at 11:23:07AM +0800, Zhangfei Gao wrote:
> >
> > > > diff --git a/drivers/iommu/iommufd/viommu_api.c b/drivers/iommu/iommufd/viommu_api.c
> > > > new file mode 100644
> > > > index 000000000000..c1731f080d6b
> > > > --- /dev/null
> > > > +++ b/drivers/iommu/iommufd/viommu_api.c
> > > > @@ -0,0 +1,57 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
> > > > + */
> > > > +
> > > > +#include "iommufd_private.h"
> > > > +
> > > > +struct iommufd_object *iommufd_object_alloc_elm(struct iommufd_ctx *ictx,
> > > > +                                               size_t size,
> > > > +                                               enum iommufd_object_type type)
> > > > +{
> > > > +       struct iommufd_object *obj;
> > > > +       int rc;
> > > > +
> > > > +       obj = kzalloc(size, GFP_KERNEL_ACCOUNT);
> > > > +       if (!obj)
> > > > +               return ERR_PTR(-ENOMEM);
> > > > +       obj->type = type;
> > > > +       /* Starts out bias'd by 1 until it is removed from the xarray */
> > > > +       refcount_set(&obj->shortterm_users, 1);
> > > > +       refcount_set(&obj->users, 1);
> > >
> > > here set refcont 1
> > >
> > > iommufd_device_bind -> iommufd_object_alloc(ictx, idev,
> > > IOMMUFD_OBJ_DEVICE): refcont -> 1
> > > refcount_inc(&idev->obj.users); refcount -> 2
> > > will cause iommufd_device_unbind fail.
> > >
> > > May remove refcount_inc(&idev->obj.users) in iommufd_device_bind
> >
> > Hmm, why would it fail? Or is it failing on your system?
>
> Not sure, still in check, it may only be on my platform.
>
> it hit
> iommufd_object_remove:
> if (WARN_ON(obj != to_destroy))
>
> iommufd_device_bind refcount=2
> iommufd_device_attach refcount=3
> //still not sure which operation inc the count?
> iommufd_device_detach refcount=4
>

Have a question,
when should iommufd_vdevice_destroy be called, before or after
iommufd_device_unbind.

Now iommufd_vdevice_destroy (ref--) is after unbind, hits the if
(!refcount_dec_if_one(&obj->users)) check.

iommufd_device_bind
iommufd_device_attach
iommufd_vdevice_alloc_ioctl

iommufd_device_detach
iommufd_device_unbind // refcount check fail
iommufd_vdevice_destroy ref--

Thanks

