Return-Path: <linux-kernel+bounces-277201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABEE949DCC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 04:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA6B5B2314B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 02:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8603157A59;
	Wed,  7 Aug 2024 02:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xddXw/7k"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7413227448
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 02:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722998159; cv=none; b=EbZv94xWZOzEo48T8KLta170CU1/sXyAJzKrZZ90Es1cV8ZyMUf0Y4kgqEtjhEHMCyENbuP9aJ93N/dVywIkBaoa/JuY/kWcNrUbySTqtbMGxWabDOWejesWjtGLs0Q/NPzGU1yII2Igzrno9UqCrXTfX0FygGcJwgAn31tEO3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722998159; c=relaxed/simple;
	bh=zh2iTy0CcMb6WKPPAq4hkouKJbNMokCgfrIQXjHo1ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTKC9gbfAWxbxamXS4wDRvh3h35Bm+fC2XnFciAu07ffvMilpBKjpvSfKisfml4lOCQQLpnUZyvxEJu9pnvjO0sRI+STZP8LXcLwbbJQQotiBpo26ln7XlLK2DNmuOwORJqw3PfvgiBbU2Qr5dVoLFKzrnDsPRap5M+xHqOf4o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xddXw/7k; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-76cb5b6b3e4so929509a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 19:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722998156; x=1723602956; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ffDHoE21UFrijGdJEWSZI39oOBTMlWPLsrBKXErtj70=;
        b=xddXw/7k5NzmfAC/oM9z/BhSlebA0zv+L+GjiMlZ0ECSBIuT5UCPH6MLQ6nTYEusiD
         8DzIhCyz3dMS32U1mhKbMNs3//azHnXAhqCUZqnsHYAybN6IQFSGgkfqG+5IiNL5r2d3
         s+Xhh1WaZlS6ZdMhzElwqN+Bv9AgoKe0gjM/CZ3bRXHJ4fny0mcxjpkdT69hNRNnWGxP
         eqenBNPT6JZLNKf7D42SDtcFpvoHJAB6Ei+MbG6hS0qPT6Nss2VJUjGijD71lhzZLSKk
         Qk1/69gNNcEsJPvTLwr6qTvuN+fTzCPh06tp5oGZyEtLZArMHeszF/oqO3XQHRJlmNyL
         Xd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722998156; x=1723602956;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffDHoE21UFrijGdJEWSZI39oOBTMlWPLsrBKXErtj70=;
        b=bIQNIU0nRi/wnmfrYvUjJlQ+RQ+9KWq+weKUd99PBoURLJI99oAobwbX9opw/r3I2K
         Yz6Dppwb1qeIbn+VBFSnnTE5n0f/b0P+oTJ3MFcT5lVu86m3720+oxPSq4r/OspZ5Qj8
         9W+SANl0WqscrL55+i7IsWB2ajTBoOAQ3pw7uubUSIKpZyXpDXkQOjbjihmIMFTMjNiU
         fJ87q+BZAwTQFcYNrvZVgzL8UzkVgs+EtFvqr4z1KyK82+1rDfC6hhuUrTDGEvCWlOPR
         dRxXvUdyEL+7UBKNE0JbQfL5HXK84IWID1ErIDgefW/NS7398lul6x1fn7GwhA14XyMO
         RtPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRUt5/QZ/5Kvt+0Uv4sgXfOeT6iF1JApRigy/In8iUPs2+2ASTlIgobGiOzscYCK4U7JiXhud4uJSgf0Ibyj/wRGZ2UhUvyTaaenBu
X-Gm-Message-State: AOJu0YzOqLL7b8EWD1lCp4KvIqXb+Sq4vIKtg3IJgO7oqcuJC6oXMDx6
	mjN3ZZNarBH1bMBFh9UavrF0cFhRO++SnxoJm2K2Zp0mKLsX0y3fXcVGotcWeQ==
X-Google-Smtp-Source: AGHT+IH2vKn4nPpW0Jtb/0WJkJAh5kcwt2+tJwY3MLnvhTrlyX71WfH1rzax1jCG900cy7Zo2E1Kyg==
X-Received: by 2002:a05:6a21:3944:b0:1c0:f33e:aaec with SMTP id adf61e73a8af0-1c69964b680mr18265769637.49.1722998155703;
        Tue, 06 Aug 2024 19:35:55 -0700 (PDT)
Received: from thinkpad ([120.60.72.69])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec43944sm7532346b3a.75.2024.08.06.19.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 19:35:55 -0700 (PDT)
Date: Wed, 7 Aug 2024 08:05:44 +0530
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
	devicetree@vger.kernel.org
Subject: Re: [PATCH v8 03/11] PCI: imx6: Fix missing call to phy_power_off()
 in error handling
Message-ID: <20240807023544.GB3412@thinkpad>
References: <20240729-pci2_upstream-v8-0-b68ee5ef2b4d@nxp.com>
 <20240729-pci2_upstream-v8-3-b68ee5ef2b4d@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240729-pci2_upstream-v8-3-b68ee5ef2b4d@nxp.com>

On Mon, Jul 29, 2024 at 04:18:10PM -0400, Frank Li wrote:
> Fix missing call to phy_power_off() in the error path of
> imx6_pcie_host_init(). Remove unnecessary check for imx6_pcie->phy as the
> PHY API already handles NULL pointers.
> 
> Fixes: cbcf8722b523 ("phy: freescale: imx8m-pcie: Fix the wrong order of phy_init() and phy_power_on()")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 3b739aa7c5166..eaec471c46234 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -953,7 +953,7 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
>  		ret = phy_power_on(imx6_pcie->phy);
>  		if (ret) {
>  			dev_err(dev, "waiting for PHY ready timeout!\n");
> -			goto err_phy_off;
> +			goto err_phy_exit;
>  		}
>  	}
>  
> @@ -968,8 +968,9 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
>  	return 0;
>  
>  err_phy_off:
> -	if (imx6_pcie->phy)
> -		phy_exit(imx6_pcie->phy);
> +	phy_power_off(imx6_pcie->phy);
> +err_phy_exit:
> +	phy_exit(imx6_pcie->phy);
>  err_clk_disable:
>  	imx6_pcie_clk_disable(imx6_pcie);
>  err_reg_disable:
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

