Return-Path: <linux-kernel+bounces-398884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0FC9BF78F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 643971F2202B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B22212D3A;
	Wed,  6 Nov 2024 19:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WYEA0Len"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C7A212D35
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 19:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730922329; cv=none; b=bUpxPvwlm41J3/gKZaDLif4qF3bMPMRmZS6Ryjg9g5fOge+7YZJ5b8J/pkZGguFJIln2zV6tQ5uGZW69yuP7GXTvlQlRkuCOMm2QsxF+7SrxtPNwygXBXkAKQ4UN/uXoRYRKa+w6o4skSrEPlOM4W3GL4wS26sjtTAiAPSaZ/2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730922329; c=relaxed/simple;
	bh=RgdYcgCBQAaQ1bP3d0JPDapEPac8uo3Pcaz65neb70A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4oYUdSFdnqSJEf0Ps7OR4UvJgjRnzcy5yVUd4Z4Nwo4auxBzirmfIFEZSefARhZLVcURUq08tYw6z9LAUWWYZWJ3KY+zel1qyb6aTFM7hvehFYNx9+WQt2x+7qC9cYIhtjz6ejbusFKddIiyupQ6g8egoETVopbK9PKhvhtKBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=WYEA0Len; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-83ac05206f6so6694239f.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 11:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1730922325; x=1731527125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l+a2o7Ai/OLZodimKUqsQYFRlYX3rzr6bNlDYl2/9c4=;
        b=WYEA0Lenm/wwmjm7lS0GQapSHWW8AqiGS/Qgo0UxecnyHbxf0tPlj0Hy3dwSuncq2a
         Ds1LB3ZoJkynvX3zY50IquevPtjZgMslOIqxxQy/Eec3+laf70k1zFfeqZo1hfQnw69/
         YRQ/NxaD1V/W/ern2G791RKUTDhAitL2ZGUl3gR3eB+o55U3uNr59HsolujnRYxDNzC9
         zdd/DZ9/bmMZBRxiZdoBTN0j1rG5hEgslOYarHUgv+K5oq9Y1AJzmMpYSlr5Dxc71LZH
         hMU3Ztihi1D5AO6fewu3dKyGdzxa0BtnGBAhVsbGTGQMbsrNwLDxDtWQTopd9VY2JmA5
         QsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730922325; x=1731527125;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+a2o7Ai/OLZodimKUqsQYFRlYX3rzr6bNlDYl2/9c4=;
        b=E8dVNNneH/bFfdY+hgxqLgNIf1F8extqzRNPHsXEP0AEiRcTTmjViIx2fiOIo1uobG
         DXblCuC80hs+eZnb+YK2nab+2gjYz1HquktPiK9gcZtmdee5SbdI4wpRB/tzA/6I19TW
         4L3Pni1WywX1Mu4nVQwOH0TWkoNTe4ja2s3hDCRBqazNO/QEh2O8p2ct6/AHMibVoDv5
         ZmQr7YfYrOUOtmHeKAIql4HfzpuY3T0Q6J8JaU+Qg+hmqUchGHsiYhIOu3/EMXFzBCt7
         QLcfxjzsbGqralSIlqdJgiOZI6F8EUTv8L5OURp5ExUJWgD7zFc/s38qiBg9uYZSqi0Y
         azfg==
X-Forwarded-Encrypted: i=1; AJvYcCVM4U5UxeDLbbHMRi0G3Q9ij01v2rN0eOso+Z2jrne1FHElFiEwBCQtQ/Uo9g/+bkTDUtd+nhQblT9nJCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Ki10jft3R2Ge0qIAofUILRydPpnZ1ftu6O693f0F/DqRF/F2
	suaWEqFZEzDB1jH14hWJTAuwgmVVykwo+x+bjq3naE3JIw3d49gD1d22hKW7oDg=
X-Google-Smtp-Source: AGHT+IFFkPdTuW3O6B5Kfs6P93ZzsRHCf7tesqNJ7oxewkCWmsZQaCiwBqj8i0a19PKZV/2UTcPUCQ==
X-Received: by 2002:a05:6602:6c17:b0:83b:4c:5f70 with SMTP id ca18e2360f4ac-83b650372a9mr2467672639f.12.1730922325433;
        Wed, 06 Nov 2024 11:45:25 -0800 (PST)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83b67ba907esm329811139f.25.2024.11.06.11.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 11:45:24 -0800 (PST)
Message-ID: <d92ab280-bd1f-4145-8164-cebab1980f20@sifive.com>
Date: Wed, 6 Nov 2024 13:45:23 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/riscv: Add support for platform msi
To: Andrew Jones <ajones@ventanamicro.com>, iommu@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu
References: <20241106175102.219923-4-ajones@ventanamicro.com>
 <20241106175102.219923-6-ajones@ventanamicro.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20241106175102.219923-6-ajones@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Drew,

On 2024-11-06 11:51 AM, Andrew Jones wrote:
> Apply platform_device_msi_init_and_alloc_irqs() to add support for
> MSIs when the IOMMU is a platform device.
> 
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  drivers/iommu/riscv/iommu-platform.c | 102 ++++++++++++++++++++++-----
>  1 file changed, 84 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iommu-platform.c
> index da336863f152..89aa622bcbde 100644
> --- a/drivers/iommu/riscv/iommu-platform.c
> +++ b/drivers/iommu/riscv/iommu-platform.c
> @@ -11,18 +11,41 @@
>   */
>  
>  #include <linux/kernel.h>
> +#include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/msi.h>

If you respin, please keep these sorted.

>  
>  #include "iommu-bits.h"
>  #include "iommu.h"
>  
> +static void riscv_iommu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> +{
> +	struct device *dev = msi_desc_to_dev(desc);
> +	struct riscv_iommu_device *iommu = dev_get_drvdata(dev);
> +	u16 idx = desc->msi_index;
> +	u64 addr;
> +
> +	addr = ((u64)msg->address_hi << 32) | msg->address_lo;
> +
> +	if (addr != (addr & RISCV_IOMMU_MSI_CFG_TBL_ADDR))
> +		pr_warn_once("uh oh, the IOMMU can't send MSIs to 0x%llx, sending to 0x%llx instead\n",
> +			     addr, addr & RISCV_IOMMU_MSI_CFG_TBL_ADDR);

Can this use dev_warn_once()? And should it really be only a warning?
Configuring the IOMMU to write to some other address seems dangerous. I guess
there's no clean way to handle this error, since this function cannot fail, and
irq_chip_compose_msi_msg() isn't supposed to fail either.

> +
> +	addr &= RISCV_IOMMU_MSI_CFG_TBL_ADDR;
> +
> +	riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_MSI_CFG_TBL_ADDR(idx), addr);
> +	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_MSI_CFG_TBL_DATA(idx), msg->data);
> +	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_MSI_CFG_TBL_CTRL(idx), 0);
> +}
> +
>  static int riscv_iommu_platform_probe(struct platform_device *pdev)
>  {
> +	enum riscv_iommu_igs_settings igs;
>  	struct device *dev = &pdev->dev;
>  	struct riscv_iommu_device *iommu = NULL;
>  	struct resource *res = NULL;
> -	int vec;
> +	int vec, ret;
>  
>  	iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
>  	if (!iommu)
> @@ -40,16 +63,6 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
>  	iommu->caps = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_CAPABILITIES);
>  	iommu->fctl = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
>  
> -	/* For now we only support WSI */
> -	switch (FIELD_GET(RISCV_IOMMU_CAPABILITIES_IGS, iommu->caps)) {
> -	case RISCV_IOMMU_CAPABILITIES_IGS_WSI:
> -	case RISCV_IOMMU_CAPABILITIES_IGS_BOTH:
> -		break;
> -	default:
> -		return dev_err_probe(dev, -ENODEV,
> -				     "unable to use wire-signaled interrupts\n");
> -	}
> -
>  	iommu->irqs_count = platform_irq_count(pdev);
>  	if (iommu->irqs_count <= 0)
>  		return dev_err_probe(dev, -ENODEV,
> @@ -57,13 +70,60 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
>  	if (iommu->irqs_count > RISCV_IOMMU_INTR_COUNT)
>  		iommu->irqs_count = RISCV_IOMMU_INTR_COUNT;
>  
> -	for (vec = 0; vec < iommu->irqs_count; vec++)
> -		iommu->irqs[vec] = platform_get_irq(pdev, vec);
> +	igs = FIELD_GET(RISCV_IOMMU_CAPABILITIES_IGS, iommu->caps);
> +	switch (igs) {
> +	case RISCV_IOMMU_CAPABILITIES_IGS_BOTH:
> +	case RISCV_IOMMU_CAPABILITIES_IGS_MSI:
> +		if (is_of_node(dev->fwnode))
> +			of_msi_configure(dev, to_of_node(dev->fwnode));
> +
> +		if (!dev_get_msi_domain(dev)) {
> +			dev_warn(dev, "failed to find an MSI domain");
> +			goto msi_fail;
> +		}
> +
> +		ret = platform_device_msi_init_and_alloc_irqs(dev, iommu->irqs_count,
> +							      riscv_iommu_write_msi_msg);
> +		if (ret) {
> +			dev_warn(dev, "failed to allocate MSIs");
> +			goto msi_fail;
> +		}
> +
> +		for (vec = 0; vec < iommu->irqs_count; vec++)
> +			iommu->irqs[vec] = msi_get_virq(dev, vec);
> +
> +		/* Enable message-signaled interrupts, fctl.WSI */
> +		if (iommu->fctl & RISCV_IOMMU_FCTL_WSI) {
> +			iommu->fctl ^= RISCV_IOMMU_FCTL_WSI;
> +			riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, iommu->fctl);
> +		}
> +
> +		dev_info(dev, "using MSIs\n");
> +		break;
> +
> +msi_fail:
> +		if (igs != RISCV_IOMMU_CAPABILITIES_IGS_BOTH) {
> +			dev_warn(dev, "\n");
> +			return dev_err_probe(dev, -ENODEV,
> +					     "unable to use wire-signaled interrupts\n");

Is the dev_warn() just to call attention to the following error? There's no
guarantee that these two messages will be printed adjacently.

> +		}
> +
> +		dev_warn(dev, " - falling back to wired irqs\n");

No need for the extra hyphen here.

Regards,
Samuel

> +		fallthrough;
>  
> -	/* Enable wire-signaled interrupts, fctl.WSI */
> -	if (!(iommu->fctl & RISCV_IOMMU_FCTL_WSI)) {
> -		iommu->fctl |= RISCV_IOMMU_FCTL_WSI;
> -		riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, iommu->fctl);
> +	case RISCV_IOMMU_CAPABILITIES_IGS_WSI:
> +		for (vec = 0; vec < iommu->irqs_count; vec++)
> +			iommu->irqs[vec] = platform_get_irq(pdev, vec);
> +
> +		/* Enable wire-signaled interrupts, fctl.WSI */
> +		if (!(iommu->fctl & RISCV_IOMMU_FCTL_WSI)) {
> +			iommu->fctl |= RISCV_IOMMU_FCTL_WSI;
> +			riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, iommu->fctl);
> +		}
> +		dev_info(dev, "using wire-signaled interrupts\n");
> +		break;
> +	default:
> +		return dev_err_probe(dev, -ENODEV, "invalid IGS\n");
>  	}
>  
>  	return riscv_iommu_init(iommu);
> @@ -71,7 +131,13 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
>  
>  static void riscv_iommu_platform_remove(struct platform_device *pdev)
>  {
> -	riscv_iommu_remove(dev_get_drvdata(&pdev->dev));
> +	struct riscv_iommu_device *iommu = dev_get_drvdata(&pdev->dev);
> +	bool msi = !(iommu->fctl & RISCV_IOMMU_FCTL_WSI);
> +
> +	riscv_iommu_remove(iommu);
> +
> +	if (msi)
> +		platform_device_msi_free_irqs_all(&pdev->dev);
>  };
>  
>  static const struct of_device_id riscv_iommu_of_match[] = {


