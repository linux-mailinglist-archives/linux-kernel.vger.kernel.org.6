Return-Path: <linux-kernel+bounces-362276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C27B199B2E8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 12:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365AB1F22BFC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 10:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A017153828;
	Sat, 12 Oct 2024 10:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kdV0GKgr"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D068922334
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728728298; cv=none; b=EJM27laOhawwYb6rEeVzXiCOn0qff3fSF7t/5Wwj5waHVg395p0nxzLXsly//HqLmsBNKxnXSGmSnBaM3RLbqaec4sdPMMrDT7yQ9OmvReDqCHV2vu/3KFa1T5HhEnQjRrU9wq1OFzOSF45Uf24BgnbjqNYWmQqiqNSmYagPFZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728728298; c=relaxed/simple;
	bh=suB/gvK3RVIdTIVj3t4mfWLPv0ww9krbFp7E65wTf2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D9JdaR/SJBIWmOWvz7EHQGe0qdhB1JX5YzLju7xZTClVr8QKboX/kGjLa/9222CzWhIXT8g5AZ8cBBdtvnqZXysPpggv+yiRVIDT8B5wIzZivADMS1i89rbRGlU5eQs6FouX1VxoS5caa+OG/1MxXKf9/yZBOo8o/FQPTNjYOMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kdV0GKgr; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so3431316e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 03:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728728293; x=1729333093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TqMjcC1AHeZ0rlGgmH16x4sW7vgPdZLOnPDdmB4aH0c=;
        b=kdV0GKgrkR6OTSbiSAd35ytNLVLJsxnzi5wlfbMBSTZ2HLCbTFssYLg59F9OaX8cYi
         nDmAjfMc7CTEKh+kzrGEx0LVXbp7H7VICrYslyxzSVjN9aBFbEfpD72cyuKtOS1GZ0/o
         BZ7YDh6LFbqNFn0y3c69dguQ3ed9AzlBnC0rlnar3Q0wvZA7jRr5DcJHgDKyOagSbUTm
         tb9V/HHYzhUCeOJmqIsI3fUOgEN7/UEJEzT4IUv11Vmzp746mW/FXFm4raxaDQmWvwvV
         qyL4FU2g6mZWOFJ/E3ZZBmgHMHJyqZlGfkyF8sm6UYlp5cahi0vlrXyNEw5DqvZPf43+
         NWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728728293; x=1729333093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TqMjcC1AHeZ0rlGgmH16x4sW7vgPdZLOnPDdmB4aH0c=;
        b=glIFWdgYqf+HiBCmBZD7axOtfwixKqZt+fTWC2nfU8knWnLGqZnQX7tJjzBSYZtk5d
         bqSNqsJdIX3JANunAzfFtghixofurhAc4DNHgrCeY6b+dhLRO9DdXLFwfDapqEe5CVmA
         uERGc1Cd9b2P++zroZSPqBixzO7wYE+TlLl59jpVUGNnWv8xo6pIYIjlgqftX6uqxofO
         v/EPpBsNNG0jbCuUd6EFmV88u5vHnRvRAkbHO/8YZ+lIclTfD4ZwM9X6kBRzWKGwg/0r
         MW5I/jOQ4eL426fwntPLfh6qpAwprLnBghMUTzqsBKXAsRPZV7Ze7s4x9lsLdmFiKjl8
         8yOw==
X-Forwarded-Encrypted: i=1; AJvYcCXmXoKVvel1Or0EZZl7NVHwzDIYK3ydAwINAvtXINCa2t62vTyDQtHH6wdXHqkx2m1YnZIWVyF8h4TwiD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxekTarSYcNG0ftyirsfLp67UyKFZ7LtgEAj4KeN0QHsz18MqJW
	b4lFmJFBquWFjt5dh0doXi3ESGJGhkT9wfs4F8JCwyPcsOk1o+O1++y/eDbB9nsF6oMTczOCuta
	sQbu4ed3W2iNEkuAjIqdj2l1QhlaSFy30P1LaPQ==
X-Google-Smtp-Source: AGHT+IGKwx5nKYmIdfK4265lwZmlfRajEDE6ymLUhhDbGn/6VtvHNpCQcZb2C0Db73mm6sCx/G3nlJDjNP9fje8CkFg=
X-Received: by 2002:a05:6512:b9e:b0:52e:fa6b:e54a with SMTP id
 2adb3069b0e04-539da4d53femr2076954e87.30.1728728292983; Sat, 12 Oct 2024
 03:18:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728491453.git.nicolinc@nvidia.com> <88114b5c725bb3300a9599d3eeebded221a0b1f9.1728491453.git.nicolinc@nvidia.com>
 <CABQgh9Eaj_vy1=sS2Pf7RC7Vy5PopDfwoshECULEU-jK3JF_sQ@mail.gmail.com> <Zwn/4m8Ac0xEiJi8@Asurada-Nvidia>
In-Reply-To: <Zwn/4m8Ac0xEiJi8@Asurada-Nvidia>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Sat, 12 Oct 2024 18:18:01 +0800
Message-ID: <CABQgh9Ft=xxJK-bjS6wCZ5BN4AiKtF9fzdBkevA3x2yb_4O4Kg@mail.gmail.com>
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

On Sat, 12 Oct 2024 at 12:49, Nicolin Chen <nicolinc@nvidia.com> wrote:
>
> On Sat, Oct 12, 2024 at 11:23:07AM +0800, Zhangfei Gao wrote:
>
> > > diff --git a/drivers/iommu/iommufd/viommu_api.c b/drivers/iommu/iommufd/viommu_api.c
> > > new file mode 100644
> > > index 000000000000..c1731f080d6b
> > > --- /dev/null
> > > +++ b/drivers/iommu/iommufd/viommu_api.c
> > > @@ -0,0 +1,57 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
> > > + */
> > > +
> > > +#include "iommufd_private.h"
> > > +
> > > +struct iommufd_object *iommufd_object_alloc_elm(struct iommufd_ctx *ictx,
> > > +                                               size_t size,
> > > +                                               enum iommufd_object_type type)
> > > +{
> > > +       struct iommufd_object *obj;
> > > +       int rc;
> > > +
> > > +       obj = kzalloc(size, GFP_KERNEL_ACCOUNT);
> > > +       if (!obj)
> > > +               return ERR_PTR(-ENOMEM);
> > > +       obj->type = type;
> > > +       /* Starts out bias'd by 1 until it is removed from the xarray */
> > > +       refcount_set(&obj->shortterm_users, 1);
> > > +       refcount_set(&obj->users, 1);
> >
> > here set refcont 1
> >
> > iommufd_device_bind -> iommufd_object_alloc(ictx, idev,
> > IOMMUFD_OBJ_DEVICE): refcont -> 1
> > refcount_inc(&idev->obj.users); refcount -> 2
> > will cause iommufd_device_unbind fail.
> >
> > May remove refcount_inc(&idev->obj.users) in iommufd_device_bind
>
> Hmm, why would it fail? Or is it failing on your system?

Not sure, still in check, it may only be on my platform.

it hit
iommufd_object_remove:
if (WARN_ON(obj != to_destroy))

iommufd_device_bind refcount=2
iommufd_device_attach refcount=3
//still not sure which operation inc the count?
iommufd_device_detach refcount=4

Thanks



>
> This patch doesn't change the function but only moved it..
>
> Thanks
> Nicolin

