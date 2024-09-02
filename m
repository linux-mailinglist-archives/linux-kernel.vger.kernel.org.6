Return-Path: <linux-kernel+bounces-310749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 198A09680CF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79187B21181
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B57178CCA;
	Mon,  2 Sep 2024 07:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WasXQ86F"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8605314EC7D
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725262860; cv=none; b=jvHdp4BWJmXGUEnIwQm1PafkvRb02M4zOm0sCRYn47MgZWP3ydH+ZKcmB2Xi3WLYpsM32ivgc8E5y5AJV2Jpr3JWO2PHwdWufkq367RFSqrSQ5Cozzozs6Ozwlli6aGSW8hHkjmd8wUv5YTH0c96IPCGV5mlFtoB0/dQ3M0RImc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725262860; c=relaxed/simple;
	bh=WgJme7hGpv0hMY6eb8C4eG1bm+pLXb4XDsw7qdVWsGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qk6swl+WKDW5zD+jjQ4tvcPbiDhsZjRqXse2NiYvvawfl6+QiefE9yQFn2gA09D+PFHu6Y4p/liMoi2wMQdbnNLrm6DYSnLKalD+m2jn942FvBCzAllLj9BhSermZSjUSLgUJa39hLhw5eMeo5U7sbs6sfESmqGzSMe/V72W7MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WasXQ86F; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2055136b612so12840715ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 00:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725262858; x=1725867658; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yttwNUw7d3dDFgywga8u4jHUr7TP2Q6BQGVJkPnT8/Y=;
        b=WasXQ86FZcvvm+3Y+y3HG4gWgZ9z91MOTHNqsdXEkC5E9ecnDaqYSDWu/Tny7BdvTK
         fLQWbHvJpmwoAIFlrM6lsTv311Z2l/21TQy6Zc5jUCffTKaJm1p8T1xG1Qot5l703f47
         GeDgztLNa2I3UQy0jYaVdCll+6VN60JnEPvJRXiyIrj2FaHUrLAwmg/hUk666fJjl50c
         oT9EWczUrx3Y63zVKXdSFcrHw/hzFIUTCwplas9u7VmX98VSBXtk0HNwbRzBljoOQbgv
         WWR9iThq/w/zRHp8cbkEOpWJESp1N1mcyO5a/DFac3BxC74aEKe6unrl2mIxfVrb7F05
         qrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725262858; x=1725867658;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yttwNUw7d3dDFgywga8u4jHUr7TP2Q6BQGVJkPnT8/Y=;
        b=LcRKlYnb3nfcKZB9N+eD+YFHDRErNqqmPAkKapPRrWW/UcOEVQzY28TnQEpl+yLDSu
         jn0fYDvjCB49QIx6831W3ZvUglGMG5feqKY6PP/x8okWgEo0Vc0hRpI0Lyp2Pz9AtRg4
         F3wwgMeOM19pqvcxl5QXjbyYnbDj/bXXeTXn5M6pvIxvf4u/ZRkXpPUVV+hRiijP+Lid
         TQQoc5BsFIsY1VWK/LXNEc9lm++hWPnIt2dwqWiQsQ4UwondDUbeZsLOxz7UU/GxbU5H
         cEceDQ3HzB6o8ZB0xFbkWVnOul3o6W7OoycVgKHvUdbb/0T17DkNzaOu5tDQ4qa/S3gl
         lvqA==
X-Forwarded-Encrypted: i=1; AJvYcCWi6DNG96E3Y2vaCBbY5faVqu0/XvXQ14pcUkcXzvlLsSKY/suaKgjNPyFNRAHeMslDaMzzmpxmzB0R/JQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWdOt2EZosoj4CD33x3a/zrj+gTerfimueKD5ayLqPMfIqHPis
	jB9r5hhS9fA0/0eXB+dUOZmmvBl887fnIyJ9HAFhihQWahzbQL9kM8IEUmxz9w==
X-Google-Smtp-Source: AGHT+IEQIMeGcVOrgzVo/cb19D0ZFZOM5enF/X/Dx2AucrfaI9oErKrbz2WEP3NOKD3AcRxNn08Tcg==
X-Received: by 2002:a17:903:2348:b0:202:3469:2c78 with SMTP id d9443c01a7336-2054660159amr69405725ad.28.1725262857758;
        Mon, 02 Sep 2024 00:40:57 -0700 (PDT)
Received: from thinkpad ([120.60.58.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205155673a2sm61188095ad.303.2024.09.02.00.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 00:40:57 -0700 (PDT)
Date: Mon, 2 Sep 2024 13:10:51 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, vigneshr@ti.com, kishon@kernel.org,
	j-keerthy@ti.com, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
	u-kumar1@ti.com, srk@ti.com
Subject: Re: [PATCH 2/2] PCI: dra7xx: Fix error handling when IRQ request
 fails in probe
Message-ID: <20240902074051.h7miwo6gazhjrgri@thinkpad>
References: <20240827122422.985547-1-s-vadapalli@ti.com>
 <20240827122422.985547-3-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240827122422.985547-3-s-vadapalli@ti.com>

On Tue, Aug 27, 2024 at 05:54:22PM +0530, Siddharth Vadapalli wrote:
> Commit d4c7d1a089d6 ("PCI: dwc: dra7xx: Push request_irq() call to the
> bottom of probe") moved the IRQ request for "dra7xx-pcie-main" towards
> the end of dra7xx_pcie_probe(). However, the error handling does not take
> into account the initialization performed by either dra7xx_add_pcie_port()
> or dra7xx_add_pcie_ep(), depending on the mode of operation. Fix the error
> handling to address this.
> 
> Fixes: d4c7d1a089d6 ("PCI: dwc: dra7xx: Push request_irq() call to the bottom of probe")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index 20fb50741f3d..5c62e1a3ba52 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -854,11 +854,17 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
>  					"dra7xx-pcie-main", dra7xx);
>  	if (ret) {
>  		dev_err(dev, "failed to request irq\n");
> -		goto err_gpio;
> +		goto err_deinit;
>  	}
>  
>  	return 0;
>  
> +err_deinit:
> +	if (dra7xx->mode == DW_PCIE_RC_TYPE)
> +		dw_pcie_host_deinit(&dra7xx->pci->pp);
> +	else
> +		dw_pcie_ep_deinit(&dra7xx->pci->ep);
> +
>  err_gpio:
>  err_get_sync:
>  	pm_runtime_put(dev);
> -- 
> 2.40.1
> 

-- 
மணிவண்ணன் சதாசிவம்

