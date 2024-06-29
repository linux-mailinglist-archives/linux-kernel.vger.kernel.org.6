Return-Path: <linux-kernel+bounces-234932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075F891CCEC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 15:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9801C21127
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 13:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A54877107;
	Sat, 29 Jun 2024 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fvx13+dx"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CFE4205D
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719666335; cv=none; b=NaZQJg7xovq6yM3xJ0HzZtQuEVf7FgL3aunjyR3xvXgywJYvRXVxc2HmuUCbXlvnC60FiUu5lyy4abgyZn23tP7Xp6XVVdUZWT4pPKae4iR++15NfcYRpSlfGdLU0jYtovhva0ssPLHIFCkGhTnPk3WRUnciAJkaDIcxSU2j/0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719666335; c=relaxed/simple;
	bh=+GloaJVSprqCGpULiUI/O36iec3Yuequ8ZLM2WLDhNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s82XfQfVU6JJR8nuhPo1KgSs1mBYkGNCdKrC16dIkHL2FN8ml0AK/CBnwy9UFnmFeP1l6fQPpyBV+lfi5gCkqV0+B9fKsLHihCs6aSL9H4M7VfpZwA2v6Hbqne64vx+dbkHdeCgUBwJMxgK1bkhMmAYgpA1v68oECwbxNV+tRso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fvx13+dx; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f9c6e59d34so11413325ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 06:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719666333; x=1720271133; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hr41jn7CS+JV7JYEOXmHYOhJrr4EACp9o9fXqaxlvEQ=;
        b=Fvx13+dxBbvCO9u8msJoUvEAv1quxljn6PMdinzrtSpow4qFafKr1PgzG9K3+VrK8V
         hx2F1y4oMyaOD/vGaJ/y+uzBBt2w9adBd1UyDtCnvVS4eJEqkqcgrllFGXXTckZj59Ot
         kAM023AAI+GyaE2Ve701KoAEZKJZHJgPi2IOOEhrByPd9MNwZSGjyMNqO6KvKWk/I+sY
         OoAAQ6d+KhFi7pBONQ/5OZ02OZjQA0/aVA7IoFXWA2OpbJIRVvRswRLiNGdZfzCDmBpg
         69oum7A7SHU62W8wWgt0zOlUGPJd1PUq1SufyMQwnZf+ysbOcgRERDd/Q8165ePRjzgG
         RdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719666333; x=1720271133;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hr41jn7CS+JV7JYEOXmHYOhJrr4EACp9o9fXqaxlvEQ=;
        b=mYR1k1QvpjfLZDzbTrtzvosKJhywHEFmxjPyNwul8n1LuaBbNTo8YHrUUtTISIJ/1/
         e0YBhjCWJLBr7LtNdAFhbRBwxnZE61wALWmOfFOUFKDpBeSPL1d+VnqEekKjllkegR+p
         +jlRr+9I84NwiUlR5px9i3JHIfu2CAV8egCnkUEwVOQqckVqLbaBOXmX9wOKtlIWPtU1
         rcK4fPUXHLacVMmPGq4mJlnBQWsOdsbnP67y5AvMqJHwB8M5FtzE5FxsD991QaccjpEY
         WzZ/yKoQIEz3y2VKw1AD0cTxPgONmCbw1e4fM+6192scgAwRBvK6FSAVSHSLnyZcEn9q
         LvmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN6/AgffImLPzScaKSBNWPBGLF6BhwRUyHUGINUdDBEUArF0av4mk7FRr787Ke48ql4dUz9GHSDkmzfAFM4b7PdfRo67qTzSrTsow8
X-Gm-Message-State: AOJu0YyD0NmFbJa3nPfN+1fZZyqjpivrQ+fLO5MwpjZnsHMXdbDD1OWF
	veVdzW8du5l+mf6572U9Owd2Y9JwCeNab8b/uHAcsUS+850URg3RaTaRTPxiYg==
X-Google-Smtp-Source: AGHT+IE5aU4sW0gZNOnsBZmQhd5QPQlm2dJswEqAC+AISCYfDs6s10N0soFFT4U1SUdqSjSMRwrfaA==
X-Received: by 2002:a17:903:2349:b0:1f7:23ee:d496 with SMTP id d9443c01a7336-1fadbcb2064mr6324365ad.30.1719666333190;
        Sat, 29 Jun 2024 06:05:33 -0700 (PDT)
Received: from thinkpad ([220.158.156.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1598576sm31531345ad.278.2024.06.29.06.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 06:05:32 -0700 (PDT)
Date: Sat, 29 Jun 2024 18:35:25 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org, Jason Liu <jason.hui.liu@nxp.com>
Subject: Re: [PATCH v6 02/10] PCI: imx6: Fix i.MX8MP PCIe EP's occasional
 failure to trigger MSI
Message-ID: <20240629130525.GC5608@thinkpad>
References: <20240617-pci2_upstream-v6-0-e0821238f997@nxp.com>
 <20240617-pci2_upstream-v6-2-e0821238f997@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240617-pci2_upstream-v6-2-e0821238f997@nxp.com>

On Mon, Jun 17, 2024 at 04:16:38PM -0400, Frank Li wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Correct occasional MSI triggering failures in i.MX8MP PCIe EP by apply 64KB
> hardware alignment requirement.
> 
> MSI triggering fail if the outbound MSI memory region (ep->msi_mem) is not
> aligned to 64KB.
> 
> In dw_pcie_ep_init():
> 
> ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
> 				     epc->mem->window.page_size);
> 

So this is an alignment restriction w.r.t iATU. In that case, we should be
passing 'pci_epc_features::align' instead?

- Mani

> Set ep->page_size to match drvdata::epc_features::align since different
> SOCs have different alignment requirements.
> 
> Fixes: 1bd0d43dcf3b ("PCI: imx6: Clean up addr_space retrieval code")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Acked-by: Jason Liu <jason.hui.liu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 9a71b8aa09b3c..ca9a000c9a96d 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1118,6 +1118,8 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
>  	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_SUPPORT_64BIT))
>  		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
>  
> +	ep->page_size = imx6_pcie->drvdata->epc_features->align;
> +
>  	ret = dw_pcie_ep_init(ep);
>  	if (ret) {
>  		dev_err(dev, "failed to initialize endpoint\n");
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

