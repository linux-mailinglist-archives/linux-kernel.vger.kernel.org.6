Return-Path: <linux-kernel+bounces-397639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0EB9BDE5E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 06:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B8CA1C224DB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 05:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DF21917C0;
	Wed,  6 Nov 2024 05:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tJDSJq/3"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A629618FDDA
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 05:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730872044; cv=none; b=H8z8aQsDzTOrp+SurRTENwK3Oq0HTT3oPgojqUJqMMR21aju0h9k4GUctHatq3kXmXfbFiwOx0e8nalVr7LzeFxxDnNbvtPU0Sn0or5YKUc3BpE3k2akQB6FLhtsO/NDiXL1RgD/KFXO/Ir2BcDlAwT9HaOMR3BdLtxJNRfL45E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730872044; c=relaxed/simple;
	bh=dYSK4OvUsOnyLQSwnFtsKalpN2mQMKz+nYSsrdB416E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UWjsVMgOss0vCc3EDlwJAz3o/Y7DymzpHbEEQtXjI9rcyU7U8bs34XxWRo1puoKRvyVZBtOKOlZ6NWkjZ+xxYdPd+uY5QlR+275kFzLK6iAgS/pBti75qLrd/QTdpzNd18iAc+CFtUZm0WOky8+1zrdNfG3hHu2cIYcKpVvs+nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tJDSJq/3; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539d9fffea1so6445916e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 21:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730872041; x=1731476841; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4wlFtruNqQoercRi+1WD7cjSp20+NvrYGVk9jN7SiPQ=;
        b=tJDSJq/3XaRsaxYUcA7IdSZaXu2Yqa6z7XjSJnJ+HNaH8azxvAXzyXaFAT51WhUY5M
         /cIc7l5GdKaSTLc6/HwMr3xJYOw6LE5PyrFjgZ6KnzGdSLUjqiHhE8wel7Bhzp+rGbI+
         LR1vMyLrGI/XjQofNpuc18QyMTPFoRzmiaeOn6lpLcFaqSaMKavBLgH6bUJEYaOWswGA
         JaYb5ZRmY2VkQZlf1QnTjt57457C5wqJJcZkQow25+c0p1rrVMKkPWB/z1Tae7SmgXKD
         zewqvG7ZHjm+Uv6aKTpALx3Yb5REJK1osa9yIGWAnFBa87zFXK0XtYBmL+cKpATcWh46
         YLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730872041; x=1731476841;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4wlFtruNqQoercRi+1WD7cjSp20+NvrYGVk9jN7SiPQ=;
        b=Ebzjwxqt0lQ9GQnhKCnoRXx6ta26lTASwnHSUeIzoB6QDd7X/IMRyRHWF7MEjSgAIH
         aPGaNy7zTl9IOeZ0bi3ZBMRdh8jlgUll44ZffGF76lq6BLW6dIiS9QNZXGyUaRu5RAKe
         syniKWsM4q/CMoavVRyoNuHjmn8EHR1QB3y2rMH7cQWzSw0+5zlEFkmnQruOdcU8srGa
         +xOay8DWUE/oWlLoGqQtHaCikY71iPfbSshHN5h6ub8kfTSE2i28PA4cPIE6pGunIV96
         cETdfSVDh0qW/zvgh9vn6TeGIOfUI3L2k6TF93ZFH+7vbmVg8oyr4r+ktI6miUt0zknW
         JZXA==
X-Forwarded-Encrypted: i=1; AJvYcCXMLXhLlKE9FHNpMyQFOHah3Ki8kxugBCjfUHf4TY7JOmXpAhSKK467dAcyaj4LOwOkhU+C03VQ+RxWd0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSPd6fS/drTlrzCZA58EuTD9a/o75Yuh+OrwOcVt48f6318Bts
	8JLYzmL3ycqXwsM8YeMH1/Q8WSkKqczqvVOP1JSLma7X3qwaklS9Ah6aXTRKWQsUaPatL9AFUTC
	Cma7ISvpt173UsoVx1TNu4usmYW1JOYTJfphJPw==
X-Google-Smtp-Source: AGHT+IEnLs5oHn+wd5p8lCC2M2Tssn5RakwYm8btDcDudbYQW7dLKT6AmkZYIPaEtOX+HUdGXJaNRoHMRaMkwx6uano=
X-Received: by 2002:a05:6512:3f0c:b0:53b:1369:fcf8 with SMTP id
 2adb3069b0e04-53b348f96e8mr19139399e87.15.1730872040707; Tue, 05 Nov 2024
 21:47:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028113209.123-1-zhangfei.gao@linaro.org>
In-Reply-To: <20241028113209.123-1-zhangfei.gao@linaro.org>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 6 Nov 2024 05:47:09 +0000
Message-ID: <CABQgh9H9HWaKRP=rFvXf90PjfVP1M6YpwfLcYTZH1hWET6GPsw@mail.gmail.com>
Subject: Re: [PATCH] iommufd: modify iommufd_fault_iopf_enable limitation
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	jean-philippe <jean-philippe@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>, baolu.lu@linux.intel.com, 
	shamiali2008@gmail.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Oct 2024 at 11:32, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>
> iommufd_fault_iopf_enable has limitation to PRI on PCI/SRIOV VFs
> because the PRI might be a shared resource and current iommu
> subsystem is not ready to support enabling/disabling PRI on a VF
> without any impact on others.
>
> However, we have devices that appear as PCI but are actually on the
> AMBA bus. These fake PCI devices have PASID capability, support
> stall as well as SRIOV, so remove the limitation for these devices.
>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommufd/fault.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
> index bca956d496bd..8b3e34250dae 100644
> --- a/drivers/iommu/iommufd/fault.c
> +++ b/drivers/iommu/iommufd/fault.c
> @@ -10,6 +10,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/pci.h>
> +#include <linux/pci-ats.h>
>  #include <linux/poll.h>
>  #include <uapi/linux/iommufd.h>
>
> @@ -27,8 +28,12 @@ static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
>          * resource between PF and VFs. There is no coordination for this
>          * shared capability. This waits for a vPRI reset to recover.
>          */
> -       if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> -               return -EINVAL;
> +       if (dev_is_pci(dev)) {
> +               struct pci_dev *pdev = to_pci_dev(dev);
> +
> +               if (pdev->is_virtfn && pci_pri_supported(pdev))
> +                       return -EINVAL;
> +       }
>
>         mutex_lock(&idev->iopf_lock);
>         /* Device iopf has already been on. */
> --
> 2.25.1
>

Hi, Jason

Would you mind also taking a look at this.

Thanks

