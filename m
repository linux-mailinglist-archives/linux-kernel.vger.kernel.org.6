Return-Path: <linux-kernel+bounces-410283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6059CD7B0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0B51F230AA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 06:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74538188CDB;
	Fri, 15 Nov 2024 06:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kyOdYdH4"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CC61885AA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 06:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653013; cv=none; b=cwCCcFBjeu7Uqna12UYJJGxkH22pbaa8mX8y6ISUGDkVjuchUFP5HgqR8RwYiaajHMGAiwkmi3dwM2gq/sWja+s4zEShRria9gYwj/KmPN01wlV1bIwyLYij4G398UyxUhpx3r+r2H9KpjeC4gwTcRk4MJo5tIX8KZQDoAYi+KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653013; c=relaxed/simple;
	bh=yFaqn0TM8DwaMrQ+sb2LpKFQLJb2yjVSUuadb+2rd5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovi+z5oAreU7uNHlMgxdenZgIS2MvBq7HgkTTTO3ci3R4FZchThaY5znnE1WUx66KWus1zNHfOBiqnnBhmTrslSGlqBRHpOU3de9XrrLlxIZPCnJKpIHeVoaAwMabAUEamZwGXu+5VsRuYPrn5rgxcMNX/z6+HcZOBCG6tOCePU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kyOdYdH4; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-723f37dd76cso403092b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 22:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731653011; x=1732257811; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3MYYRbyHSKnkKj/U1ajnAZh9FgwdbjyrEbwmDmiOJ74=;
        b=kyOdYdH4FVy8vMZ56AMJxMs4RtvvScdwPMENwzkxhZccHSGf//BLvjBa+yu23R4Dc3
         yfOOhIA5Sh1+xV01rwVt3iWmYxUsbRvFVK4beqZTPbknq/y4cOrkRpV+9Ob/mFfTzZyS
         WUp0673qb4kYWaZwl6G05bky3lByzWmbrad8hNajaKRII4vUa9uzAlTR4WYGbf3BYm3H
         fDtycpnE4Xn2v8iwJOAP3/Obq1mTdY2pxmcpmjbDMi71opciRjopHIKhG/mIpIpkWYSo
         2mE/akYEFdYHDVT2x71XBU69QW/q/wX2HIyzt8AX6N32wooRpQE9FLOic7ruJ6t0LTyD
         Poug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731653011; x=1732257811;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3MYYRbyHSKnkKj/U1ajnAZh9FgwdbjyrEbwmDmiOJ74=;
        b=n8btJENF4S2MJTLu4ulcAfWi68awkv0lMTrcLvcLDg0L5l3p7tluicV7YgQIioauB8
         TkcPDv4sY9WDRp2ZDxiF08olCk7nEmOt3WB8+LVbh9TiA3h65tPEs6TU98OyCbXiEp9E
         5U7F8POP5DWgIQO5O70V4tV+voz1dmGfCEYFCDWrj58bZkwlXqDSA4Szbnj9akUUs4JR
         tdGo+MVHFO9EfZTGC8al28TQD7ZhOSCSK+cSYXvsWSd/MjlCGKMmM+dfb4c9grGIRwMh
         ATv2Xz/uqJuYCVv0Yat48rzd7HyfUN1TRntaS0jqoKd3n/87vgJdiVcM/nYDwYjR6eBm
         V1AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSDUvD3bTcp5JH2U3yjg1nB3rdNR7jnF8JygY+w0HCY1PyHNw8YJCimqrM0xWQPeg0em9WRL1KXsJIZU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLYKUgzWwpBEyKEB99xHaDeq8PRi9KSQ04lIC3XfHncUpMUtTJ
	jfyo2+pIF/Wau2nZQogYY0KP8WVbSG4sEhWP8IKX48ZbPQRCS5RV0kI01y1VYgJ2DDxR3uWvUOA
	=
X-Google-Smtp-Source: AGHT+IHY6v9j5fvHwvuygpXSp/ldJste9oxVxyRTDqgsgbIZ7G245t9I6FYAct4vrO9HjSZAZqBz4Q==
X-Received: by 2002:a05:6a00:22c8:b0:71e:4930:162c with SMTP id d2e1a72fcca58-72476b872c4mr2212375b3a.6.1731653011440;
        Thu, 14 Nov 2024 22:43:31 -0800 (PST)
Received: from thinkpad ([117.193.208.47])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724770ee7d3sm673330b3a.38.2024.11.14.22.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 22:43:31 -0800 (PST)
Date: Fri, 15 Nov 2024 12:13:21 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, frank.li@nxp.com,
	s.hauer@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 04/10] PCI: imx6: Correct controller_id generation
 logic for i.MX7D
Message-ID: <20241115064321.3cuqng7bzmphiomw@thinkpad>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
 <20241101070610.1267391-5-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241101070610.1267391-5-hongxing.zhu@nxp.com>

On Fri, Nov 01, 2024 at 03:06:04PM +0800, Richard Zhu wrote:
> i.MX7D only has one PCIe controller, so controller_id should always be 0.
> The previous code is incorrect although yielding the correct result. Fix by
> removing IMX7D from the switch case branch.
> 

Worth adding a fixes tag?

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
> "This is just *wrong*. You cannot hardcode the MMIO address in the driver.
> Even though this code is old, you should fix it instead of building on top
> of it.
> 
> - Mani"
> 
> IMX7D here is wrong athough check IMX8MQ_PCIE2_BASE_ADDR is not good
> method. Previously try to use 'linux,pci-domain' to replace this check
> logic. Need more discussion to improve it and keep old compatiblity.
> Let's fix this code error firstly.

I really hope that you'll fix it asap.

- Mani

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 462decd1d589..996333e9017d 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1342,7 +1342,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	switch (imx_pcie->drvdata->variant) {
>  	case IMX8MQ:
>  	case IMX8MQ_EP:
> -	case IMX7D:
>  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
>  			imx_pcie->controller_id = 1;
>  		break;
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

