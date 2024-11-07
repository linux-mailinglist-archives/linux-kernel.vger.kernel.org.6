Return-Path: <linux-kernel+bounces-399321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA98F9BFD6A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 05:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779EA282C3E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 04:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8B018E35D;
	Thu,  7 Nov 2024 04:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PvFPJMiV"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D461C16F84F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 04:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730954429; cv=none; b=d0V+o+d9iti3riBzSGdUzk0mYbSJQXLu6LUG9YcfHkkUq+Tq1okYAD8NMWNxR5iaBfzyZm995SGvQavvVusQN0TWWoWNerIuaTzxz5GsAoWSxqY+RcxWpQEM94HqU27eqbUaypTil9wYRz14BoqPi79HQar05w4B9RLo01THrb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730954429; c=relaxed/simple;
	bh=C8T98Sa2leDE2aVBOiD4LYqi1ctZER7DeoVbj0OUT30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cze+R2W8MTx0TkPHw+QpGNDQPeL+WfRQdLNIfyl3jbxWVB+bZni1DqdUJB++AQgtYdKHNuQQ4ofq6+Ra6tAc28YvhmR3yUtZ3npoJT81IuABvic+DlopoffAFamzhn0HfSql660zT31Ak4rt/ACsLGdCwPFMANuAdHhnaTNSJF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PvFPJMiV; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f7606199so423400e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 20:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730954426; x=1731559226; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kS3PhzgV8hPWd3Nz2X4ljMHj7vMg0QaN6Lo6Vk67xTw=;
        b=PvFPJMiVJrkV09j9H1MGmKBOzCmaX7ra8RLYOpaOfG3SaruL4LfoUd2vIz9gLbhj4P
         L6jTbu+eKPvUAXnVNszwz4XACU3OHBBPU7hhphAWYvql9xksdtfXuz9crvpwZyWTfSzq
         VVLnz+qAYASc98vsJNtx1W6g0WgYR5WFvozGvppBNnK36MyK4OLdiYJxdF+P2+WfXq5A
         SBEjsqN1yA59U8J2IlPQ8QFb9w3rTjciJwpEGBGnIaKGjcVy0X2u5sJLTkKkwqZv5xkp
         ZC9UJis0TxDC8DZ50wqPe6gxqDGAYJSWCA1c7T+dFgLuKWoWKdyssY2FhHR54qi65nCk
         dclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730954426; x=1731559226;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kS3PhzgV8hPWd3Nz2X4ljMHj7vMg0QaN6Lo6Vk67xTw=;
        b=C341FSSLuYpNgn3CTxUUNPJnTAPG6Im+iHeYERl+eQevgvqdV83RaqAwuGs0Fzmzs9
         6igtHmeQHgbXCV8Iq5hDRdruOwz6Kn1B6G9MgiNfO5pqY5d59JT29/GKzzB1KtkFk/Mn
         g8CmNqH7XD9kKM+falhCMnYDlCXYM6R4kb2FIAsqUFClnxsdLrpT2tRsHGMOsaTUEuJ7
         QfI1lwPmClM58wPwOnexgXQw+eYD1lv4e3ofD5uyRcpScKcgvebytXmEM/pkkygRHJQM
         tMdLpIoy2x6NMXyyvxBgqdmf5YT2B+Oa1prW2qqF/AdSmmiZGcYjGcFvU131WSRyOgkG
         4J6g==
X-Forwarded-Encrypted: i=1; AJvYcCX7t59yhnTEQ2CUWHW+ogB8SdhRNbRdCO0McoVk5i06wCYSk/V41DNpgoyEetxrKbMteOxa2Z6zrmG9yKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt2nLw4UITE9lwxWjv0AwHz9cxyemrGf6WJxdzyvDCyQZYuyXZ
	tWw5t4x9zIxtDUrbH3n1V5CaEnrpj9E290+1cqd4hh0fsLyX/p1zigNQ+X0AHdgyuB0JXgy9lqS
	Fr2Sk+BuSQYEmLNXNBra+zUI1e5VxoBdawXoaew==
X-Google-Smtp-Source: AGHT+IE6mu02yFj3cbKRiS8rNaWfTch6NvNc8XHMgEPjm27a3mfwdePPbwFloVV4AAmL3acydHk3/qanmVOZP5ve+pE=
X-Received: by 2002:a05:6512:110e:b0:539:f2f6:c70f with SMTP id
 2adb3069b0e04-53d828e3da4mr206716e87.8.1730954425978; Wed, 06 Nov 2024
 20:40:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028113209.123-1-zhangfei.gao@linaro.org> <CABQgh9H9HWaKRP=rFvXf90PjfVP1M6YpwfLcYTZH1hWET6GPsw@mail.gmail.com>
 <20241106135944.GP458827@nvidia.com> <fcef9cb1-797a-496a-9ef5-1e2f530dc8f6@linux.intel.com>
In-Reply-To: <fcef9cb1-797a-496a-9ef5-1e2f530dc8f6@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Thu, 7 Nov 2024 04:40:15 +0000
Message-ID: <CABQgh9E=AKgN=QqewH+HPyHEk8bYzABnEuj3UiWwpHMYUNFrhg@mail.gmail.com>
Subject: Re: [PATCH] iommufd: modify iommufd_fault_iopf_enable limitation
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	jean-philippe <jean-philippe@linaro.org>, shamiali2008@gmail.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Nov 2024 at 01:52, Baolu Lu <baolu.lu@linux.intel.com> wrote:
>
> On 11/6/24 21:59, Jason Gunthorpe wrote:
> > On Wed, Nov 06, 2024 at 05:47:09AM +0000, Zhangfei Gao wrote:
> >> On Mon, 28 Oct 2024 at 11:32, Zhangfei Gao<zhangfei.gao@linaro.org> wrote:
> >>> iommufd_fault_iopf_enable has limitation to PRI on PCI/SRIOV VFs
> >>> because the PRI might be a shared resource and current iommu
> >>> subsystem is not ready to support enabling/disabling PRI on a VF
> >>> without any impact on others.
> >>>
> >>> However, we have devices that appear as PCI but are actually on the
> >>> AMBA bus. These fake PCI devices have PASID capability, support
> >>> stall as well as SRIOV, so remove the limitation for these devices.
> >>>
> >>> Signed-off-by: Zhangfei Gao<zhangfei.gao@linaro.org>
> >>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> >>> ---
> >>>   drivers/iommu/iommufd/fault.c | 9 +++++++--
> >>>   1 file changed, 7 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
> >>> index bca956d496bd..8b3e34250dae 100644
> >>> --- a/drivers/iommu/iommufd/fault.c
> >>> +++ b/drivers/iommu/iommufd/fault.c
> >>> @@ -10,6 +10,7 @@
> >>>   #include <linux/module.h>
> >>>   #include <linux/mutex.h>
> >>>   #include <linux/pci.h>
> >>> +#include <linux/pci-ats.h>
> >>>   #include <linux/poll.h>
> >>>   #include <uapi/linux/iommufd.h>
> >>>
> >>> @@ -27,8 +28,12 @@ static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> >>>           * resource between PF and VFs. There is no coordination for this
> >>>           * shared capability. This waits for a vPRI reset to recover.
> >>>           */
> >>> -       if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> >>> -               return -EINVAL;
> >>> +       if (dev_is_pci(dev)) {
> >>> +               struct pci_dev *pdev = to_pci_dev(dev);
> >>> +
> >>> +               if (pdev->is_virtfn && pci_pri_supported(pdev))
> >>> +                       return -EINVAL;
> >>> +       }
> >>>
> >>>          mutex_lock(&idev->iopf_lock);
> >>>          /* Device iopf has already been on. */
> >>>
> >> Hi, Jason
> >>
> >> Would you mind also taking a look at this.
> > Lu? Are you OK with this?
>
> This change looks good to me. But the s-o-b chain would make more sense
> if we can make it like this,
>
> Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Zhangfei Gao<zhangfei.gao@linaro.org>
>
> With this addressed,
>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks Baolu,
Have fixed it.

Thanks

