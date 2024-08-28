Return-Path: <linux-kernel+bounces-305333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F643962D13
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B1562829AE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3441A0718;
	Wed, 28 Aug 2024 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sX2n0duJ"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC282172767
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724860605; cv=none; b=LVzmqoI3LND63td3osigH5wwKgL+NvNqGx3o6eklewP6eC9uqvQlu5QO9akmV9wOu3hZN0nXos5qUxFqEzVGI/s9GGOcfTQlDxD8vA7nthybegoZhWieRDu50L/SfgPDBbDrXXCHAk9f50AN2lDwCnSE35LnVcKpdFYygZ26ddY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724860605; c=relaxed/simple;
	bh=Ha443Pq2LngSA20OziuuGQGi6nUNi6iYRZM2MkylOO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z04/Is8KU7xaPv/R9qC6nkq9GwQo4MZ1b6PBHguhQqt9ZiioUboHOvU9Y4hAAm9JuTUtgMrGJuf4uNwrfsv64clkqFDwQ1yXm0K34S3YLMdx0DjB0dg+QPFjFKi2VfiJBUhsb7fVTUklJaAabcz3X3SkRfZih/3EHzz0CTpqUAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sX2n0duJ; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7cd9d408040so4825715a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724860603; x=1725465403; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VzVMjubsXQCh1YcY4QckKt6HfzKqtuiKGKXcXqML8yg=;
        b=sX2n0duJShyRJqm5NGRUuLOd6isUcIr0iLp8Jc3pXBNNK1+fPrsPnbPmnlV9M9DwqY
         1R5z/fS0UMK1QzV3iuNslafeRcFgkL1IEsPeZ2UJF0E9owNEY7tEVdlSNuQkWlfu4D6W
         W05kqFbXhuM8e7EDuh4q80x4jC1Gfit96VEQkZbHKxNO+iThgXMl5+ycSaQum17gXsir
         mZMdeGV4Hk8HsrFLMxw+pLgh4+9gC1oLqu/KPpxLg68njYBGGB3ABna0sPBiuLZQS11e
         abjtMU6gzcC8rXVkfthhtN1OUkAwRJACsP97Iy4ZbNIeZ0sRJdrmN29xbJN6oVs1w6vv
         5Jag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724860603; x=1725465403;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VzVMjubsXQCh1YcY4QckKt6HfzKqtuiKGKXcXqML8yg=;
        b=liE+w2MMFETB7zuyDiqaIWE7kwN9ABfHR1p3xlciLgPcSWGzd2jyy9T9gS51R9DV0i
         CO6cMJBL1ZhwoMl0SmtoHa+jpAIokTVhbasDYBDkeHOdX2kJz9TpSOEzGd6BZ8FVuUat
         BRmtWIOTdRYhEY45GeRitzxEh11rCKdNkkNXcxeoXVz8FfBrcgCBX7V4KAAKK5M34XVq
         iwTMBkJtrW1dwJriC7ljtc9ZP/eA4fiubSKKsLA7/2awNgpGpB1LaXTPpWnSY9oLoug9
         5gkyngjQRR4Fi2BE4db2hCj0q6abxueXjxPql9bOCqeGomYE1PNES7KrsghEbQdys5wC
         pdSA==
X-Forwarded-Encrypted: i=1; AJvYcCWBqvcqqSVUi5oH49EUD1SVAzeOmVEKSSpgcM8tar1F+fuuCqXiwdSBUDxd5BNym0QYrOmjk4mpNHE5yPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrBb6sWgidXLOVSyXi696YkKFbweoqAr74CxsbJLAYv1T/9lI+
	pnmChx/kEHDSpmA/O7sMMdn4neyUyoPrPxAVz6wmb6xdny1z/y/eL1xxt3EXFA==
X-Google-Smtp-Source: AGHT+IHoBh/R3NhFvQxnxjpX4sSKSIInFXQsHDevtRTDsYf9qeMu8m9SSATPa4QNXdhopEzMjpEdFQ==
X-Received: by 2002:a17:90b:378c:b0:2d3:cc31:5fdc with SMTP id 98e67ed59e1d1-2d8440b0a19mr2559107a91.5.1724860603111;
        Wed, 28 Aug 2024 08:56:43 -0700 (PDT)
Received: from thinkpad ([120.56.198.191])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d84462f19asm2042577a91.34.2024.08.28.08.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 08:56:42 -0700 (PDT)
Date: Wed, 28 Aug 2024 21:26:38 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: joyce.ooi@intel.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: altera: Replace TLP_REQ_ID() with macro
 PCI_DEVID()
Message-ID: <20240828155638.y76h73cb4rcbvg36@thinkpad>
References: <20240828104202.3683491-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240828104202.3683491-1-ruanjinjie@huawei.com>

On Wed, Aug 28, 2024 at 06:42:02PM +0800, Jinjie Ruan wrote:
> The TLP_REQ_ID's function is same as current PCI_DEVID()
> macro, replace it.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-altera.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
> index ef73baefaeb9..650b2dd81c48 100644
> --- a/drivers/pci/controller/pcie-altera.c
> +++ b/drivers/pci/controller/pcie-altera.c
> @@ -55,12 +55,11 @@
>  #define TLP_READ_TAG			0x1d
>  #define TLP_WRITE_TAG			0x10
>  #define RP_DEVFN			0
> -#define TLP_REQ_ID(bus, devfn)		(((bus) << 8) | (devfn))
>  #define TLP_CFG_DW0(pcie, cfg)		\
>  		(((cfg) << 24) |	\
>  		  TLP_PAYLOAD_SIZE)
>  #define TLP_CFG_DW1(pcie, tag, be)	\
> -	(((TLP_REQ_ID(pcie->root_bus_nr,  RP_DEVFN)) << 16) | (tag << 8) | (be))
> +	(((PCI_DEVID(pcie->root_bus_nr,  RP_DEVFN)) << 16) | (tag << 8) | (be))
>  #define TLP_CFG_DW2(bus, devfn, offset)	\
>  				(((bus) << 24) | ((devfn) << 16) | (offset))
>  #define TLP_COMP_STATUS(s)		(((s) >> 13) & 7)
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

