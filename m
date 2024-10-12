Return-Path: <linux-kernel+bounces-362057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BC799B067
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 05:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42962B2373C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 03:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D6786250;
	Sat, 12 Oct 2024 03:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FH1/99Js"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC4025760
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 03:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728703402; cv=none; b=NO4m2nwMoR8Yv66oDxOOiDahGutzDURTcv038uIlQYUWz6kIc96cxfVOW89F9wwYrYvTWOzO4XklJ1xaSY7SJZwCSDDskF2SFHIMf6hi1m/e8QjMq8dARAfVTGjiy9AasNJpi1JxFRa5yKT8y38MNe9Zm2rhOK/0OR3FlU2fz+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728703402; c=relaxed/simple;
	bh=wsSaBgBTeHtBghO0cfqVgH243fy8Pa2RXxN/pZupV6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGBQvOo3ZF/orPPBlYO5rYXdrnQgIkoZrZhr/rgdckcw7EhKkGZ10+YqsrGWtRARBV64iWlGuEHawbP6L8sGGENj+oCx/xOen0nJ9qz/Yxjcoz7dDbHPlsMV85hfbwmcMkjHbaaiwQQxgOVcfAVCwD2gLgP8d72oosqxCn8KilM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FH1/99Js; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5398df2c871so3492995e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 20:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728703399; x=1729308199; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QlglIBEouENDM99FxQmO+xYhesFmMYXUSPi6sZycxFs=;
        b=FH1/99JsGDWEPDo4/pWv3bMv0S6KN2f5ohS4D6i7LZ6PPtNCLDFouc8y/6VcAGPRNa
         3JCom9TfAVeYldiuENdueoi0+msF81SpBNWgRe+dCop6C+LoKMgPYpbIxZiJyYwHX7ke
         aVOP+6xJWG9UMtSJ/+6mXDU7O5pbTcfGYFDpJd+WUMsKRN/XeLpWJqZCq2OtYFQHk8Rv
         D9Vh3MvIcfHVggd/uTWR3JUNvT3ptCMXmHvewW+eYWoHIgsSvuhMW++FD/u3W4C6M/uI
         5kwtrYNUbPl7IQyrFTUe+sSS7dTZh80kv8dTrv+55SGVHsHRYMZy3W3x4h25xN57FNOF
         Qtaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728703399; x=1729308199;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QlglIBEouENDM99FxQmO+xYhesFmMYXUSPi6sZycxFs=;
        b=CjnWWawZ4QE5ndNWzy1mDsPozQr0Ou6nhcTG+BzWFuHDZnZ5r7lw9HUidyW80Ib99T
         PtI78ogNK1phTfq/MCfKXKvRHAccqxbcYq2oSIJ2l4OF+fl/s/kSzipt8pJEB05vLs1Z
         eqSXMpMwKFOf80/yls+CZon9EVZEvYpxGiiXudU8A0X2YrGHkOSlWl9AMIU0sNQAOIbs
         w1LQh2Ym79O+WtnCcvSJt8c+w8aTvbiy8aaOOIsAKnYOgoP12eVk0Db7uvFpaeylUzLh
         T2i+sKFp5BZHpTQZPi8c7fBEeDkXsKSkTfkh2Gwy9qGCfviAetqVsG2ND8U4dERFPqCC
         TAVg==
X-Forwarded-Encrypted: i=1; AJvYcCVZGTyVeDFRd0EWTO6adwvwTzNML8AuXIFy4eTv0K9U0gAU0r/tV+zVdGJgvqLXJFo0HxzELX17JYumQxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YykO7Tmj6+Hu9WGUxfgz9GV2mC8QB7W0zWpGDgYXwnFlM8W30PL
	XzYtbVEYd5LGzxMA8G0AW2GKRjB2IxacgQqG+c+3fYMV9tTrbodDS4d2K9BhAuZdYfqQrcopCnR
	+5eyBmFNI6zIPI37CJeOZg+rWsTl8uIA8/zIe4g==
X-Google-Smtp-Source: AGHT+IHTB9MOBFF1SVeJM6RLI2586pPtKAOHvz7bsl4p80HAofGQzLo5/TLSZAoKOlZ1GlH3ENrvOlgP85K3q2XSHPI=
X-Received: by 2002:a05:6512:2201:b0:52f:1a0:b49 with SMTP id
 2adb3069b0e04-539da4e2d8bmr2268383e87.31.1728703398750; Fri, 11 Oct 2024
 20:23:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728491453.git.nicolinc@nvidia.com> <88114b5c725bb3300a9599d3eeebded221a0b1f9.1728491453.git.nicolinc@nvidia.com>
In-Reply-To: <88114b5c725bb3300a9599d3eeebded221a0b1f9.1728491453.git.nicolinc@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Sat, 12 Oct 2024 11:23:07 +0800
Message-ID: <CABQgh9Eaj_vy1=sS2Pf7RC7Vy5PopDfwoshECULEU-jK3JF_sQ@mail.gmail.com>
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

On Thu, 10 Oct 2024 at 00:40, Nicolin Chen <nicolinc@nvidia.com> wrote:
>
> Add a new IOMMUFD_OBJ_VIOMMU with an iommufd_viommu structure to represent
> a slice of physical IOMMU device passed to or shared with a user space VM.
> This slice, now a vIOMMU object, is a group of virtualization resources of
> a physical IOMMU's, such as:
>  - Security namespace for guest owned ID, e.g. guest-controlled cache tags
>  - Access to a sharable nesting parent pagetable across physical IOMMUs
>  - Virtualization of various platforms IDs, e.g. RIDs and others
>  - Delivery of paravirtualized invalidation
>  - Direct assigned invalidation queues
>  - Direct assigned interrupts
>  - Non-affiliated event reporting
>
> Add a new viommu_alloc op in iommu_ops, for drivers to allocate their own
> vIOMMU structures. And this allocation also needs a free(), so add struct
> iommufd_viommu_ops.
>
> To simplify a vIOMMU allocation, provide a iommufd_viommu_alloc() helper.
> It's suggested that a driver should embed a core-level viommu structure in
> its driver-level viommu struct and call the iommufd_viommu_alloc() helper,
> meanwhile the driver can also implement a viommu ops:
>     struct my_driver_viommu {
>         struct iommufd_viommu core;
>         /* driver-owned properties/features */
>         ....
>     };
>
>     static const struct iommufd_viommu_ops my_driver_viommu_ops = {
>         .free = my_driver_viommu_free,
>         /* future ops for virtualization features */
>         ....
>     };
>
>     static struct iommufd_viommu my_driver_viommu_alloc(...)
>     {
>         struct my_driver_viommu *my_viommu =
>                 iommufd_viommu_alloc(ictx, my_driver_viommu, core,
>                                      my_driver_viommu_ops);
>         /* Init my_viommu and related HW feature */
>         ....
>         return &my_viommu->core;
>     }
>
>     static struct iommu_domain_ops my_driver_domain_ops = {
>         ....
>         .viommu_alloc = my_driver_viommu_alloc,
>     };
>
> To make the Kernel config work between a driver and the iommufd core, put
> the for-driver allocation helpers into a new viommu_api file building with
> CONFIG_IOMMUFD_DRIVER.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

> diff --git a/drivers/iommu/iommufd/viommu_api.c b/drivers/iommu/iommufd/viommu_api.c
> new file mode 100644
> index 000000000000..c1731f080d6b
> --- /dev/null
> +++ b/drivers/iommu/iommufd/viommu_api.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
> + */
> +
> +#include "iommufd_private.h"
> +
> +struct iommufd_object *iommufd_object_alloc_elm(struct iommufd_ctx *ictx,
> +                                               size_t size,
> +                                               enum iommufd_object_type type)
> +{
> +       struct iommufd_object *obj;
> +       int rc;
> +
> +       obj = kzalloc(size, GFP_KERNEL_ACCOUNT);
> +       if (!obj)
> +               return ERR_PTR(-ENOMEM);
> +       obj->type = type;
> +       /* Starts out bias'd by 1 until it is removed from the xarray */
> +       refcount_set(&obj->shortterm_users, 1);
> +       refcount_set(&obj->users, 1);

here set refcont 1

iommufd_device_bind -> iommufd_object_alloc(ictx, idev,
IOMMUFD_OBJ_DEVICE): refcont -> 1
refcount_inc(&idev->obj.users); refcount -> 2
will cause iommufd_device_unbind fail.

May remove refcount_inc(&idev->obj.users) in iommufd_device_bind

Thanks

