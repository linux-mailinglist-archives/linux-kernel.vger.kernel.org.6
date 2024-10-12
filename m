Return-Path: <linux-kernel+bounces-362080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B9299B0C0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 06:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F6A9B22D93
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 04:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA430126C00;
	Sat, 12 Oct 2024 04:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jd1k3IAW"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4822126C15
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 04:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728706404; cv=none; b=Uyw0mEEVBYuzt0pdcAUshWMsY3+yLBCzwS7rQt1IXTUJo6bwKAFvGqZhhZQqzrz+CuQocVd9/4xj+mPFxH7Mim3xOnPEGaOCDfQJ7atTaBRAP9/KT9Ga2y/maIHAiskzG1UP7oKhdqUiNlsV/MQdnyv6X91tGbd09A229Vr/m0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728706404; c=relaxed/simple;
	bh=Cjqq2VsIvnOWJtSBSmaGd8a62UyC2iakIp8Y/CTbhIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+EDQ7owyIi5Z91DE8iNJw3wObsbyQXPcNVCo0ps3xPXSwmO5NHVqXxfUGeab7RTm6X934DesdjLjPS+DDJBoX2qeCyHlTAKZOiqFAXASu226qR2my4xK8tMkXQyeqsl8zRbosqBqDmyPaiBrhReGur6nskSFGc/b3nazeY2ivA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jd1k3IAW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c7edf2872so21150915ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 21:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728706402; x=1729311202; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vB16VpCDewcAwoYN49nbK+yIU/0PlYPRJKRICrTJZE8=;
        b=Jd1k3IAWmY0PgAXQ4gbzhO2ai8ebqQG+CAtiHzXMFaKynnRTE5Pcb5jovpxvUzwsOD
         kU/LLDfaCmTRvYTXdgvGK2pBAAQ2/cRBNovkkpD44zdAUQeSeyz+eVrQh5/1hfOHZk4v
         zf4gnP0/DSfvKHaTV33/ukzoQQnAguh9RUQAT3Lri6wWINcloBgoxcX+fi+JZsITWm3+
         xNi/uXgvUPbBLOjTYDK8HfanzuZarkxNJb6kWRvIAiRUATYHe3EYC8/qUEdHfQvQdKQr
         dsMWvFs/o3os+6IS7fHbetEkN2J8PcEMDAxvAdQRaIP5CP+LicC8ZMFGmaXUyBKD3MG4
         JO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728706402; x=1729311202;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vB16VpCDewcAwoYN49nbK+yIU/0PlYPRJKRICrTJZE8=;
        b=DW8oRvbmGWrgQHl+v/1IKYE9Wb/lKRNTVMZEIM8ZgLxa1oZXX73e44sW/U2vpGrr2g
         DXhe5Hcj+LjVPPfHWHRCcwk3FP4PeOQoRjuDDvpZGrN7ZEJrwnzlwm0Wtf3rLj/VLoq3
         oxJ0pIiUb+Q8Vk4sqNWW8SxXTHAVAgVSOszf03u0d7UvAqA0qp7ZzgCQ4XI6AwGzuwlF
         2DgfVafnyGSRtwBUNH1Ybe3Z6Z8wY5RITl5uicNW3Ubl6FisCDUTLb63GvRe12kRdSSI
         gjg/wqQZCYw9pPhDh3TlgKV5HCeTCxF7XO3IEoUPJG39Fx/bC/kon9CqU+UQbBmL39I8
         alQg==
X-Forwarded-Encrypted: i=1; AJvYcCVhpInEEY8M0sgVmhXUhrMoI3pQ5FEP/yzjE+MawmYeyuN5vx0o6THUxQvCrE7lsX3ZqCSf88cyRWDlwTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsxppEMY3a501r054lAmmO/ehmASDyKaU13t77pT6V7nP4UWW/
	XB8Pq0jVwzWBKK2nkcCnpyW9KYr4ueSeS/DbnWiE5c5YcLa7DDQsZEtIbpuEyw==
X-Google-Smtp-Source: AGHT+IEUBN4nc8fDzuF7ww7X5ksu78JTjsuqiB3sE0EdJOBGzVs3tTuontBwHvcsi4XzGJlZlVJueQ==
X-Received: by 2002:a17:902:f70c:b0:20c:c482:1d72 with SMTP id d9443c01a7336-20cc4821f28mr10112675ad.20.1728706401976;
        Fri, 11 Oct 2024 21:13:21 -0700 (PDT)
Received: from thinkpad ([36.255.17.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bad32basm30934345ad.57.2024.10.11.21.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 21:13:21 -0700 (PDT)
Date: Sat, 12 Oct 2024 09:43:15 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, francesco.dolcini@toradex.com, Frank.li@nxp.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v2] PCI: imx6: Add suspend/resume support for i.MX6QDL
Message-ID: <20241012041315.vtmixcxbqwb63kno@thinkpad>
References: <20241009131659.29616-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241009131659.29616-1-eichest@gmail.com>

On Wed, Oct 09, 2024 at 03:14:05PM +0200, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> The suspend/resume support is broken on the i.MX6QDL platform. This

You mean the 'system suspend/resume'?

> patch resets the link upon resuming to recover functionality. It shares
> most of the sequences with other i.MX devices but does not touch the
> critical registers, which might break PCIe. This patch addresses the
> same issue as the following downstream commit:
> https://github.com/nxp-imx/linux-imx/commit/4e92355e1f79d225ea842511fcfd42b343b32995
> In comparison this patch will also reset the device if possible. Without
> this patch suspend/resume will not work if a PCIe device is connected.
> The kernel will hang on resume and print an error:
> ath10k_pci 0000:01:00.0: Unable to change power state from D3hot to D0, device inaccessible

Looks like the device is turned off during suspend.

> 8<--- cut here ---
> Unhandled fault: imprecise external abort (0x1406) at 0x0106f944
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> ---
> v1 -> v2: Share most code with other i.MX platforms and set suspend
> 	  support flag for i.MX6QDL. Version 1 can be found here:
> 	  https://lore.kernel.org/all/20240819090428.17349-1-eichest@gmail.com/
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 44 +++++++++++++++++++++++++--
>  1 file changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 808d1f1054173..f33bef0aa1071 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1238,8 +1238,23 @@ static int imx_pcie_suspend_noirq(struct device *dev)
>  
>  	imx_pcie_msi_save_restore(imx_pcie, true);
>  	imx_pcie_pm_turnoff(imx_pcie);
> -	imx_pcie_stop_link(imx_pcie->pci);
> -	imx_pcie_host_exit(pp);
> +	/*
> +	 * Do not turn off the PCIe controller because of ERR003756, ERR004490, ERR005188,
> +	 * they all document issues with LLTSSM and the PCIe controller which

LTSSM

But LTSSM is for the PCIe link state, not sure how it impacts controller state.
Can you share the link to those erratums?

> +	 * does not come out of reset properly. Therefore, try to keep the controller enabled
> +	 * and only reset the link. However, the reference clock still needs to be turned off,

You are resetting the *device* below, not the link.

> +	 * else the controller will freeze on resume.
> +	 */

Please use 80 columns for comments. Exception is for the code.

> +	if (imx_pcie->drvdata->variant == IMX6Q) {
> +		/* Reset the PCIe device */
> +		gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 1);
> +
> +		if (imx_pcie->drvdata->enable_ref_clk)
> +			imx_pcie->drvdata->enable_ref_clk(imx_pcie, false);
> +	} else {
> +		imx_pcie_stop_link(imx_pcie->pci);
> +		imx_pcie_host_exit(pp);
> +	}
>  
>  	return 0;
>  }
> @@ -1253,6 +1268,28 @@ static int imx_pcie_resume_noirq(struct device *dev)
>  	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
>  		return 0;
>  
> +	/*
> +	 * Even though the i.MX6Q does not support proper suspend/resume, we
> +	 * need to reset the link after resume or the memory mapped PCIe I/O
> +	 * space will be inaccessible. This will cause the system to freeze.
> +	 */

This comment is not really needed.

> +	if (imx_pcie->drvdata->variant == IMX6Q) {
> +		if (imx_pcie->drvdata->enable_ref_clk)
> +			imx_pcie->drvdata->enable_ref_clk(imx_pcie, true);
> +
> +		imx_pcie_deassert_core_reset(imx_pcie);

There is no corresponding imx_pcie_assert_core_reset() in suspend.

> +
> +		/*
> +		 * Setup the root complex again and enable msi. Without this PCIe will
> +		 * not work in msi mode and drivers will crash if they try to access
> +		 * the device memory area
> +		 */

This indicates that the controller state is not preserved. I think we need a bit
more understanding on what is going on during system suspend on this platform.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

