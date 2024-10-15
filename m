Return-Path: <linux-kernel+bounces-365044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2880499DCA8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 05:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9827A1F23489
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EA416EB7C;
	Tue, 15 Oct 2024 03:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PuvRhReM"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560E4535DC
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 03:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728962390; cv=none; b=D6iBnviNwDp0YTlVcO3EsN3iXAlPgrAPxr4uI9B4GYUqlmTxqQtoBdPQnwkCnc4SDWTJcE0beVBhEWLjh8N6ef2Ff6jroOowqtUrz2ORTXWfj3cei7dE4x6OoZEdoE9hvf0qulDejerxc2jey4mAztTnDNs90Wr4FjfEq0e6jpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728962390; c=relaxed/simple;
	bh=syw8l1KwjEBWtLU1JH5AK1kULW2THayjgvY12VC2Tx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUyMePjVR+vZTk14svQPeDmPHV06x11TsJm/CDWHVMcbuvKsLU9zkXYJYyV81kOmo/5q5cJxXgSDLtJUqufy+DSrqJMvFzin+cY3gzfH589Kou+rh7wyVox7Xbtt1/o9gBZ8GAEAtl0JSajzEpZQAVkt1jCgJrhIHI2LF/0xEtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PuvRhReM; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539d9fffea1so3630724e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 20:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728962385; x=1729567185; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QZJ30zy3Y9wI3Z0YkhEC9QUrXIWOd4xHS/wNqEUb/eU=;
        b=PuvRhReMUuqGced7JmOJbr5fQ3Dyme+Y87qVpzZ96Zfj8ljW6bFlP+bVc6YAx787t0
         FVHiwnZgVtRfhF9WjDQVoLjnYCfG/agnJxioWO2ot0b2dB+WMGUcd0Xs3SO/RURhmV6I
         sMyFsfx150V7Qc2dIGQ/VHvsvWkgbHKAzE3zAMWU5gPFDP+Q5CXzLdO54ldawKXSvLyA
         XSpwAGOyA7yF/CJ5I/1OwoufGpPe1qDXqMKcdkaGrkqrUe0FbjYicjpxj3WvhaSVtBYd
         shxMhDzTtVVVvsRnXyk4h/l/VPo3idbHpj16tqYChmgPE7iFkj7eZJAtz0hAVmVpvWlx
         Bs1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728962385; x=1729567185;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZJ30zy3Y9wI3Z0YkhEC9QUrXIWOd4xHS/wNqEUb/eU=;
        b=pNcAcmivsgSnEtae8DUC8rtCqD3b9HHlFaom25pJYsvFxppQUO0/wkcS0ntIZms6DB
         X74WrnNKES/Hoqb3uJfMpSQf9gjv5bVCMw354o5d7lx9k+0wdK9ZZUKZ4eGkhC/4j1Kq
         c6MapzJfpSnsoNQAvd+eX55iR+zk/MooqNJ6esgedQ8jc+lzf8k3tyIexU2e234iVgVn
         WvOk2wPapI9dtGLzW05wRO9QUddb4vjEzInXekp/QxdnggS6kTjxYzoeHw5zk93vXpr9
         8qgAkDQuWhwsQgiKvMDxY7gjmJs+jOK7uNEYPOVffxUA6abpmrZIl4Py1xr6Hh0JDVY8
         jttw==
X-Forwarded-Encrypted: i=1; AJvYcCWqt0IR8b1NfjEWCIFfvNCUcr5qvhRVq06BogcMVQTatAwVGypKpeJyaJmONsJvRoa+8guu1pzTMsBWtxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/I71m7oCwAoPY9SiRILdvp+y0Zf8M3MuXpvZXMI7xSYKy+TVL
	cY83WGYAuaHWANpQGIaUm98rvWFbIVChLbdCgQkxjh/aox+kggIFpR593APsXqhZSYO9VNldYtE
	Xm9/z59jN/WNc3n39JfbT2hiGvwd/BfykLxcVnQ==
X-Google-Smtp-Source: AGHT+IF2l+l9aIjC2cv2bCp01lbBm8QlrtKCARf+AmZ684Kp2buFC5VFNgRnQSqkTeJHMQUtLY2v5L1TykBuAKg0PM4=
X-Received: by 2002:a05:6512:baa:b0:539:e94d:b490 with SMTP id
 2adb3069b0e04-539e94dbcd1mr3817040e87.43.1728962385314; Mon, 14 Oct 2024
 20:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702063444.105814-1-baolu.lu@linux.intel.com> <20240702063444.105814-8-baolu.lu@linux.intel.com>
In-Reply-To: <20240702063444.105814-8-baolu.lu@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Tue, 15 Oct 2024 11:19:33 +0800
Message-ID: <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt attach/detach/replace
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi, Baolu

On Tue, 2 Jul 2024 at 14:39, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> Add iopf-capable hw page table attach/detach/replace helpers. The pointer
> to iommufd_device is stored in the domain attachment handle, so that it
> can be echo'ed back in the iopf_group.
>
> The iopf-capable hw page tables can only be attached to devices that
> support the IOMMU_DEV_FEAT_IOPF feature. On the first attachment of an
> iopf-capable hw_pagetable to the device, the IOPF feature is enabled on
> the device. Similarly, after the last iopf-capable hwpt is detached from
> the device, the IOPF feature is disabled on the device.
>
> The current implementation allows a replacement between iopf-capable and
> non-iopf-capable hw page tables. This matches the nested translation use
> case, where a parent domain is attached by default and can then be
> replaced with a nested user domain with iopf support.
>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---
>  drivers/iommu/iommufd/iommufd_private.h |  41 +++++
>  drivers/iommu/iommufd/device.c          |   7 +-
>  drivers/iommu/iommufd/fault.c           | 190 ++++++++++++++++++++++++
>  3 files changed, 235 insertions(+), 3 deletions(-)
>

> diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
> index 68ff94671d48..4934ae572638 100644
> --- a/drivers/iommu/iommufd/fault.c
> +++ b/drivers/iommu/iommufd/fault.c
> @@ -8,6 +8,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/iommufd.h>
> +#include <linux/pci.h>
>  #include <linux/poll.h>
>  #include <linux/anon_inodes.h>
>  #include <uapi/linux/iommufd.h>
> @@ -15,6 +16,195 @@
>  #include "../iommu-priv.h"
>  #include "iommufd_private.h"
>
> +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> +{
> +       struct device *dev = idev->dev;
> +       int ret;
> +
> +       /*
> +        * Once we turn on PCI/PRI support for VF, the response failure code
> +        * should not be forwarded to the hardware due to PRI being a shared
> +        * resource between PF and VFs. There is no coordination for this
> +        * shared capability. This waits for a vPRI reset to recover.
> +        */
> +       if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> +               return -EINVAL;

I am using the SMMUv3 stall feature, and need to forward this to hardware,
And now I am hacking to comment this check.
Any suggestions?

> +
> +       mutex_lock(&idev->iopf_lock);
> +       /* Device iopf has already been on. */
> +       if (++idev->iopf_enabled > 1) {
> +               mutex_unlock(&idev->iopf_lock);
> +               return 0;
> +       }
> +
> +       ret = iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_IOPF);
> +       if (ret)
> +               --idev->iopf_enabled;
> +       mutex_unlock(&idev->iopf_lock);

Also iommu_dev_enable_feature(idev->dev, IOMMU_DEV_FEAT_SVA); is required
In thinking how to add it properly.

Thanks

