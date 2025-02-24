Return-Path: <linux-kernel+bounces-528644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9264A41A2F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DCE116C434
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4102580E7;
	Mon, 24 Feb 2025 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fXgfXy+L"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5F724BC11
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391218; cv=none; b=WmYOzey/t7G07wvD6mTY4y8Efql/S/evhm0dyXu2dsfc/kmc54Hy0toPGruRoI+zYCELJ+QZkEDvmW9MxF62ZplpmBN+bOq8VaU5UXativp/w26+NvjY22fx5RR+7IRo0T6ctJk6fw7YakSmR9braE/vV+hvUcARSfotKkwJdsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391218; c=relaxed/simple;
	bh=L1CsTylPKpbe7mHhb0x/X+ZtkC9C5FKlAWnDYpGi04Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CII8MKg7mB3ZKFXk0fmTlvqcA4zwkdhQKY7h1MafIfMkgXerLbIJ3OrM7AVGVMGXJJ7fWd61Y0NifkmHcOLwbCXTzNOSYNUnHzkmzxJOKAC/vI7ZDe51qbh9lAq6sQCSG/gX0pXRUEcbI+8/M8GreMuSz86NqC2Dn3VB5rFpYn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fXgfXy+L; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-309311e7b39so38009751fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 02:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740391215; x=1740996015; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e/af6Nf4pYTXjW+k5FHuuUBRQ1ISjrcs1BZad7L7cbM=;
        b=fXgfXy+Lyvncc7TbLBMjXZe+5rFvdePGhHAr3XgVpCRVIZBLQBI0ZxsHYOUUVxLl9y
         FFf1vD7RAdmgDziCljaBZ1p1v2DpVlpFARh0t7UkBELh0I62jsq8DtWiPPSAU2c6uaBE
         jmjo8P08sMsUQikTK9vcYv8CuvQGRpwogJUMZuYknihJzj3O5wgT9XgjpDsMR/adlZu8
         rVL1IYFdKRzmYE/nr380i4OUSUDBC3WLmt7rjbhXwKbf4vvsW3mlzef8NHjP0JvRDQ9Z
         0ZYz+3Pg93tdRuVCz21O8z2tOKfBOil2TlASPKMuS8EvmUsBhpHOCq1Jv5m2TtTbSpI6
         MbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740391215; x=1740996015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/af6Nf4pYTXjW+k5FHuuUBRQ1ISjrcs1BZad7L7cbM=;
        b=S2DGuDUmmalLshZZxLv+cU2y5Tdj1d6ckB1U/zYT0UZRVSbEHtC1LSGWc7q9fwp/Nd
         t4m85KBuFCdAFBsFFbbyJktI52f8U6XHoPQ5AYaWBd+NhbIvOb+/jT7eTLGbaYtMb8NK
         d29ZV6YXMsO5h5yezOqU8Q15N3OMOSb9UQ00qKpF3jBfxcFEhThCC20TZEH1XKB+dGJ8
         kBYmn9/Xp9lTEu3Rbati7jd3rZs10By/Bd2Ugk3/Ef1iX3qa1yVxREUZBaMHZiSm7LxX
         5ulYfNsyc4w9NmOOMOtbCT7V2MZj6kw5kLLmmjMrWI8PxwHO/xEl+m/OLBIn0uZWZaXw
         7rRg==
X-Forwarded-Encrypted: i=1; AJvYcCWhmUqEcY8b9sooflJW1AqruPoBzcMR21G2tIySYWN8qLpkCOoR5MYRbyRIdcrEH6Q1Qe6qWPiL0OjEiMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygtvz0pBk9A+clmFFub7+KlYfAnfvP86JDuqhP0mMZhM2Yp+OK
	ZyR4qnoKEFr+wILn2yKk/mOYhmVb9FDy0RRyt6L6XbF5wlELesBSs7ILuti6vybhRRnouN+aSdY
	O/Q/Mdzn273XcFxpPKdzV+OoYPcv0SPnD8VyZNJ3jLy7Tb+1pAuThfg==
X-Gm-Gg: ASbGncu/17mcex5pZ+wxGS3nvZraDm9OS1sJ95h+GC1ld+u09rpYQ1eg8Cff4lSP392
	Wrjc/1DX2irNgdZRiuht/4ZD4tKcpZz7sZv3/TD+pPQZWF1K5B1u0fiqo8enq/kRFwiXOAkwKBI
	bjqOTXCWQ=
X-Google-Smtp-Source: AGHT+IFvhQ2d0kjawpOA6ae+ZD8D05Wtfz/zZq525EqV3G+li0jFar6Ns4sZTBNcqdZ5o6Ta+CQUR8CvSaROXGWj1Ug=
X-Received: by 2002:a2e:9098:0:b0:308:ec25:9004 with SMTP id
 38308e7fff4ca-30a59994167mr42426711fa.35.1740391215090; Mon, 24 Feb 2025
 02:00:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com> <20250224051627.2956304-11-baolu.lu@linux.intel.com>
In-Reply-To: <20250224051627.2956304-11-baolu.lu@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 24 Feb 2025 18:00:03 +0800
X-Gm-Features: AWEUYZm_Vmy5gXLhP7OjFIo5QaYCXcBq4-MGlly3CV5_Yb7KKQuhKpAi4xpH3T0
Message-ID: <CABQgh9E2N35pJ5Ehmhq0JydKjWqswypOH9qepu+9QmHmVzdvBw@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] uacce: Remove unnecessary IOMMU_DEV_FEAT_IOPF
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
	Fenghua Yu <fenghuay@nvidia.com>, Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 13:16, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> None of the drivers implement anything for IOMMU_DEV_FEAT_IOPF anymore,
> remove it to avoid dead code.
>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>

> ---
>  drivers/misc/uacce/uacce.c | 31 -------------------------------
>  1 file changed, 31 deletions(-)
>
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index 2a1db2abeeca..42e7d2a2a90c 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -465,31 +465,6 @@ static void uacce_release(struct device *dev)
>         kfree(uacce);
>  }
>
> -static unsigned int uacce_enable_sva(struct device *parent, unsigned int flags)
> -{
> -       int ret;
> -
> -       if (!(flags & UACCE_DEV_SVA))
> -               return flags;
> -
> -       flags &= ~UACCE_DEV_SVA;
> -
> -       ret = iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_IOPF);
> -       if (ret) {
> -               dev_err(parent, "failed to enable IOPF feature! ret = %pe\n", ERR_PTR(ret));
> -               return flags;
> -       }
> -       return flags | UACCE_DEV_SVA;
> -}
> -
> -static void uacce_disable_sva(struct uacce_device *uacce)
> -{
> -       if (!(uacce->flags & UACCE_DEV_SVA))
> -               return;
> -
> -       iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_IOPF);
> -}
> -
>  /**
>   * uacce_alloc() - alloc an accelerator
>   * @parent: pointer of uacce parent device
> @@ -509,8 +484,6 @@ struct uacce_device *uacce_alloc(struct device *parent,
>         if (!uacce)
>                 return ERR_PTR(-ENOMEM);
>
> -       flags = uacce_enable_sva(parent, flags);
> -
>         uacce->parent = parent;
>         uacce->flags = flags;
>         uacce->ops = interface->ops;
> @@ -533,7 +506,6 @@ struct uacce_device *uacce_alloc(struct device *parent,
>         return uacce;
>
>  err_with_uacce:
> -       uacce_disable_sva(uacce);
>         kfree(uacce);
>         return ERR_PTR(ret);
>  }
> @@ -596,9 +568,6 @@ void uacce_remove(struct uacce_device *uacce)
>                 unmap_mapping_range(q->mapping, 0, 0, 1);
>         }
>
> -       /* disable sva now since no opened queues */
> -       uacce_disable_sva(uacce);
> -
>         if (uacce->cdev)
>                 cdev_device_del(uacce->cdev, &uacce->dev);
>         xa_erase(&uacce_xa, uacce->dev_id);
> --
> 2.43.0
>

