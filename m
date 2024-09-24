Return-Path: <linux-kernel+bounces-337246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AFB98478A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73231C20B65
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EF11A76CF;
	Tue, 24 Sep 2024 14:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UBjOzDNI"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD49B1E481
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727187693; cv=none; b=kFHM/CS7/Pe2RNkVod0Tca6GKCT9n2xeGWfYaQhPW016gRUusOjp4egDMDLpkh2IXcDi2+2Vdl8dxMP5KBR2O0wMKnLiJT5BXWo1P9xhvE2+o3RNF4L/Z2gEK/FzVv/WTk0fk3Z/RG8MB6RudKeD1MmyF3kcL/5f8XNRDsPC8r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727187693; c=relaxed/simple;
	bh=WSwBBqzTC3NDF4Ogil3IXiO0I1yb9/J/2kDQS+4T3VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTkw6QvsIt25TjXU5Jw9xvYrnkdSwqeJI4DLDFLxuzNgeLSubw1mO6QYUZ7tMGgewt5TLurBorH9lo7/GTMzl+skmqR8fMYjvKxNcuQWnbJdQmbTEeP97Lmqbh7KG+eVgSzsXSNVoBvFsWISPN879dA3URxTZFEdSoowY9Bv8vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UBjOzDNI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb806623eso48297705e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727187689; x=1727792489; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dfQTsP0vA/xZ7wbPE4mzCRWLqRMSRVWs8MpYHZmYO04=;
        b=UBjOzDNIdrCrnlY4R04KrDZrnIiAlOUoQrT27j4dNZFnMemxoq80QlhpOdmwCyITAy
         ECr7zzYJ3rnJ6wk7oVqNoR1nP4pOL1Nxqq/uPo+tHNa9lRQ16HYg5kn6ReLRSd0wRA47
         lv6U62ZkQhKO8AwTWzGDjRq2YATy7FO5Ua58lKzpn/zCTbIAOm8FgHZAgA5MeweevVc2
         f/owcPCRCQNLlYaRmNV4LksSokToq7yAYnVFDcyNkPuzGUSkua0sqM7g1KlNSISpCpDG
         BYb/caFETyAx2PC5pJtq4iQM7PMO2TMAMwn9gA8d3txxQGvh2G1XzKo5ogP+BbLuCWSe
         MJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727187689; x=1727792489;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dfQTsP0vA/xZ7wbPE4mzCRWLqRMSRVWs8MpYHZmYO04=;
        b=VCjTbLEoXU+Ox704R7zDGIwxugm33Hv0W/sG9DJyRg7/F2kGeSrn62YMxF9EZEWFgg
         SwlyRKrAiEnz7aqs3+Mq8k7g+02OLVcUnbRbhhiumNvshFCL29KfiVZUf5y+vS5OH0ER
         bmj2X6rjc/lOJgo+BJLmSoGqfwdmp7RTHnh0usV75wnmcMFRUxOk38Rz7WvrUJXSVeqx
         O3MJBzatQOSS6js6EtqmFBLZZpfYmmzBlIv4DW274wLzT8bLlUS5nPhh4akg+6DHzj+D
         QZxmxCGDC5xywipSEnKIbhzFrX+NoRE7vaMn3PpVfCT4lYKuO+vHzJWuxvs6WXNSl8M3
         z6LQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNN8J8fbdug/NA6XRsY37UeLM/d4OxO4cjHK6yjlSR18C4td1sfOoADxZwPp7cvIqA2JAFveuvKPSsKWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx88kFUQfkKPmyYPjw5UlqHdPC2sXvriDNroTHCr8xZw9hnlJCM
	RMhWTPDnP/f6v5Pk3cyP/SIpq3Fby/o5nqLHpnc+bKLWeA9pwvBJipzBuy5e2A==
X-Google-Smtp-Source: AGHT+IHvYi5sE75KftIebO9vedcos5Z0ukc1YN0ZeK6gW61izK+suGuxOSBkOiwHtcrUCyrBSyEIZQ==
X-Received: by 2002:a05:600c:1d29:b0:42c:b309:8d18 with SMTP id 5b1f17b1804b1-42e7ac23136mr108548925e9.19.1727187689466;
        Tue, 24 Sep 2024 07:21:29 -0700 (PDT)
Received: from thinkpad ([62.67.186.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75450ec6sm158091485e9.21.2024.09.24.07.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 07:21:28 -0700 (PDT)
Date: Tue, 24 Sep 2024 16:21:27 +0200
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, heiko@sntech.de, cassel@kernel.org,
	ukleinek@debian.org, dlemoal@kernel.org,
	yoshihiro.shimoda.uh@renesas.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dw-rockchip: Remove redundant dev_err()
Message-ID: <20240924142127.4wi7rsndl76vtffk@thinkpad>
References: <20240918074401.2221146-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240918074401.2221146-1-nichen@iscas.ac.cn>

On Wed, Sep 18, 2024 at 03:44:01PM +0800, Chen Ni wrote:
> There is no need to call the dev_err() function directly to print a
> custom message when handling an error from platform_get_irq_byname()
> function as it is going to display an appropriate error message in case
> of a failure.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 1170e1107508..3770e566b597 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -450,10 +450,8 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
>  		return -ENODEV;
>  
>  	irq = platform_get_irq_byname(pdev, "sys");
> -	if (irq < 0) {
> -		dev_err(dev, "missing sys IRQ resource\n");
> +	if (irq < 0)
>  		return irq;
> -	}
>  
>  	ret = devm_request_threaded_irq(dev, irq, NULL,
>  					rockchip_pcie_ep_sys_irq_thread,
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

