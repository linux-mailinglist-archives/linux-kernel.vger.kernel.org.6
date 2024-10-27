Return-Path: <linux-kernel+bounces-383683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 491289B1F08
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 16:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8BB21F2175D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C6E16DEA9;
	Sun, 27 Oct 2024 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ok+Mo1Xd"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493772570
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730041367; cv=none; b=MQ73mrK+AJiShO4waOfQhyDL4ddNIWCXF1mGtXz8vDQFx2tCbBgljMy9/RzU7hu2COiXQabatC15IAVCV3K/8zGpmt/Vx93RIzoGkiLwXiPF65OH1QrUsoZn/PL6Q/wIe5Mu5IbB8qJ0u+hiky7eSqoMO3i1FF4XNPV2byYcdTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730041367; c=relaxed/simple;
	bh=YN5uOcCVqLCrU2rPWl/pSKH8JOoi5g+jhmSQm5uMpRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0T+HzgbSx5mBAz7qS1DI5R2mYEYMYeJIoBdb6GYVzzIm0OPZMczmUfgdvUORrCs/NwdQA+LSs2tgG1oDp96sCzc9R1OwOPaOA6mXnhxASvLR1FR8YAMvOiB3VDXBZRXlokl1xqPb0VyPu6RKnv+uJ0f+1EQgbdkzI3I5i3SguU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ok+Mo1Xd; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so30899341fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 08:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730041363; x=1730646163; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x4R7lu/kAshlAJXnNL3llyVtKBCbHq8h1Es4W4nUkAU=;
        b=Ok+Mo1XdMSmBfukwMK/1uL2Oi3DUXB7nSgxv53QmRrtpU19kHBV6YSCq1dxceYcf1V
         cizcgK1PgSsV3NL0mgNrSYEza9F/L1fQUrq9bKsMhVpm3NWmWdjoa35cIHKqnEL4dP/Z
         u0alj15/4lTPHq2XcHObxUKUrGgRvi0HYN+IIlYaCvwgHxDSiHaeL3WHrK40bJIX0+F+
         vD0T54/kAz/FCoxcb4Q0CU9FksGQpOwAU/nVOXtqORQgzwJVbYwm/tYpxqODampAWei6
         a9AlRPJeLn0A7TGiDbpb3Yr1PQgZSKIZI8+8csqEFQ2kHWiSupbH4jx0viXP5RSnCSaV
         80BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730041363; x=1730646163;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x4R7lu/kAshlAJXnNL3llyVtKBCbHq8h1Es4W4nUkAU=;
        b=PfKDk/a8My2zfuhAr+6mY62BIeZfnNQjk+fUOVAlXzoAF0NlqvZtyDQgclaivwED84
         W5GnxCrZAGdLPn7ufEGiNTk0JsF9EDk3JU5QbXJ7MMQc4+gfS5KNGOrUUdZ7R9N4m2He
         tO5xQesXiXUS53q0EGEfPdZi8CPqlA28KppAbUEYUiFikLTzrTV7KW2kQcNLXc9YUvTK
         EVexIFbqxRKI5drxS12TAhFp3AQwAqOm7jpfPjW1WtxsNonWaea4tHjrIVLgeptTdCK+
         umMWZB5BiuTuhM4iU1qS9nvijdfC+UHia1VzKD89Oijd9SulwwxiBlN8oqVfc6dUJ8ox
         mdwg==
X-Forwarded-Encrypted: i=1; AJvYcCW4TfY4S3FgqeUmoNYPw0k8Dx6aGFBALyYyzIf5T3naPB25UvBVcuq0Fb179LKYIuULdxjRe29+x9IXsP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRYTypNg7oHyfeG6O9CNt9OLQYu5qnNCoa9o6zvYB05wIiNa3P
	JWQv4KpQBmdgAZjTFEkPPBgsInpvdULLBXIWX/80346f8fCuocDccvSgExwNOvMBU9vA0y/Hgah
	lc1+tK90vqCRZn1xxgsuc9corBJN8kNFtrdQH+Q==
X-Google-Smtp-Source: AGHT+IFqLjsyKJ5CxjDNJGvvyW3lXMFUulX6UFQluIj2OcmHgocN09ZljnrI5ISQ8+uIxzhs+el7dmiVvKGjST2wbUc=
X-Received: by 2002:a05:6512:1092:b0:53b:20a1:1c4a with SMTP id
 2adb3069b0e04-53b34a19077mr1821924e87.42.1730041363426; Sun, 27 Oct 2024
 08:02:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729897278.git.nicolinc@nvidia.com> <384f7b4333a1f75da09e390902b8f82be21a0dd3.1729897278.git.nicolinc@nvidia.com>
In-Reply-To: <384f7b4333a1f75da09e390902b8f82be21a0dd3.1729897278.git.nicolinc@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Sun, 27 Oct 2024 23:02:31 +0800
Message-ID: <CABQgh9EpGPwdQhv7mepiMGVgR-8NMx5dcXyJ2A92W8ZzQt3bJw@mail.gmail.com>
Subject: Re: [PATCH v5 07/13] iommufd/viommu: Add iommufd_viommu_find_dev helper
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

On Sat, 26 Oct 2024 at 07:51, Nicolin Chen <nicolinc@nvidia.com> wrote:
>
> This avoids a bigger trouble of exposing struct iommufd_device and struct
> iommufd_vdevice in the public header.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommufd.h        |  8 ++++++++
>  drivers/iommu/iommufd/driver.c | 13 +++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> index 0287a6d00192..dc174d02132b 100644
> --- a/include/linux/iommufd.h
> +++ b/include/linux/iommufd.h
> @@ -184,6 +184,8 @@ static inline int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx)
>  struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
>                                              size_t size,
>                                              enum iommufd_object_type type);
> +struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
> +                                      unsigned long vdev_id);
>  #else /* !CONFIG_IOMMUFD_DRIVER */
>  static inline struct iommufd_object *
>  _iommufd_object_alloc(struct iommufd_ctx *ictx, size_t size,
> @@ -191,6 +193,12 @@ _iommufd_object_alloc(struct iommufd_ctx *ictx, size_t size,
>  {
>         return ERR_PTR(-EOPNOTSUPP);
>  }
> +
> +static inline struct device *
> +iommufd_viommu_find_dev(struct iommufd_viommu *viommu, unsigned long vdev_id)
> +{
> +       return NULL;
> +}
>  #endif /* CONFIG_IOMMUFD_DRIVER */
>
>  /*
> diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
> index c0876d3f91c7..3604443f82a1 100644
> --- a/drivers/iommu/iommufd/driver.c
> +++ b/drivers/iommu/iommufd/driver.c
> @@ -36,3 +36,16 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
>         return ERR_PTR(rc);
>  }
>  EXPORT_SYMBOL_NS_GPL(_iommufd_object_alloc, IOMMUFD);
> +
> +/* Caller should xa_lock(&viommu->vdevs) to protect the return value */
> +struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
> +                                      unsigned long vdev_id)
> +{
> +       struct iommufd_vdevice *vdev;
> +
> +       lockdep_is_held(&viommu->vdevs.xa_lock);
> +
> +       vdev = xa_load(&viommu->vdevs, vdev_id);
> +       return vdev ? vdev->idev->dev : NULL;
> +}

Got this error?

ld: Unexpected GOT/PLT entries detected!
ld: Unexpected run-time procedure linkages detected!
ld: drivers/iommu/iommufd/driver.o: in function `iommufd_viommu_find_dev':
linux/drivers/iommu/iommufd/driver.c:47: undefined reference to
`lockdep_is_held'
make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
make[1]: *** [/home/linaro/iommufd/linux/Makefile:1166: vmlinux] Error 2
make: *** [Makefile:224: __sub-make] Error 2

