Return-Path: <linux-kernel+bounces-410280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F559CD773
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C50DBB25DAD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 06:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6B218A921;
	Fri, 15 Nov 2024 06:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="El6KvHKm"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C1C188926
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 06:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731652879; cv=none; b=IPZCFOQtK6F6WOw5FURCSuAxK/g+elRvcNziFsTQWE4u2AxsQluEJ93EBgPyfH67lqa8uHbHVqwSfyjPJND0p5yaT1uwpHnRQMu2R1+guY1d+9XT9xIQoIfbyGDDWELNFhN7V4HbglVPn5wdUmtM8mMLqqeoa64Ge96tKPoIGRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731652879; c=relaxed/simple;
	bh=+YWto08nAzQlfP7Roih16Ol20t5fEagbMxHoY96FEVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iD9eztYv4vPxLjxV2bCKB+y1GeS7JjGQsnnsSwTXmtKhTzAh6/65K3MNNBNVPdWJIAcZNe6u4rG9yCCrlEpE+IzSbVjongsaHjUgW88O0McvPfvIVYbxigJp1uKcpCPuSSKQIPUkoZaxuaXPkfXIm+fvxhRMTHJeaVdEZEJ8Xck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=El6KvHKm; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2110a622d76so13038985ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 22:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731652877; x=1732257677; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+9X/wxgCiPevQR8azxljXcXglwxyvUBHBH4k0NcW95s=;
        b=El6KvHKmsxwVaz6fEUkDRNTQgVCXlc2uUgVliom5qc6cPNIQL7l8xdFeoZmz2hcD24
         g7AL7pehyZ4bIVtRW9PVsG3BoXMzmwbqQkp6Olce1co9AezU8ap/2dHXzQZ3fKql6/gt
         CZguZ5Y9ohKfuo5sKCnfprwukC0k6UoQO5GlBW0kxn6AEdnraLt6dAKsm+wwSXc8DnlZ
         bolLElMLa7Y8yw7mBhgNd/FTFlnfxSRL1PWTR+fM+/OwI+N3jDz3LbwF04eM0QzqFfVO
         fDZzEDPG209L0V1yPfjdJtKNQdpHNQpft8KKlnjKsNPp4h37XhKNF66sd1pNdWW8JWAl
         C06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731652877; x=1732257677;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+9X/wxgCiPevQR8azxljXcXglwxyvUBHBH4k0NcW95s=;
        b=dGoksuvFeugDWixq6ixbMg47NhwdkDI93mjAsCNyQrVr+wnfbCRDVq0jDI3vZtCw/J
         RTxcy8DHCp/5pNTYI+ObTbc1G1WnzGLVDweNVIQ+gm1C93rTxXbMkCjnWT3N6q+mHMku
         7Xz3LXp4VXdRPgfNXBzClmiGQgqvPHV44N+lkanuiHmSQCb1X7GeQhYT8EDwDrFqGeBU
         gl+mST2Ntb9EdV6/CFIPK/IGhF0lLdM33RH6/hvfpYrhtwR8F+BbkYRsXIRtre3PpfbW
         6ab6TN/gkzuTeMoDrHIpT5fNGYtCLLZk6DzW4lTvTw9RlrpXtYD04Jrq0B8XeEwKk7u9
         GQ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXO0z2T0Q7dWeqvgvH9WmCnJF23fNgPPye4zuzpy5Hgje2YxUsqQwWh30CdQovBwv91pBbVwvFocZ41yt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYioCcPjspsig2WSiY7aaBkRaPCI7V0mtAXLE3fvguYkaYLqNs
	hbHklto8EtHrYXk5Fb3jbd0kBtVrDvGHISlflVubq5KtloJpQPOWFOM18hssfg==
X-Google-Smtp-Source: AGHT+IGabkTqfzJ7F61xnkcjI95zLPKfJGfkK+pvHWTH/TvMDmJ1L9QNKaKVIJTm7qh/u3tDNf6Mrw==
X-Received: by 2002:a17:902:f544:b0:20c:f27f:fbf with SMTP id d9443c01a7336-211d0d7687fmr23670135ad.25.1731652877101;
        Thu, 14 Nov 2024 22:41:17 -0800 (PST)
Received: from thinkpad ([117.193.208.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f56e10sm6129835ad.242.2024.11.14.22.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 22:41:16 -0800 (PST)
Date: Fri, 15 Nov 2024 12:11:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, frank.li@nxp.com,
	s.hauer@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 03/10] PCI: imx6: Fetch dbi2 and iATU base addesses
 from DT
Message-ID: <20241115064106.iwrorgimt6yenalx@thinkpad>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
 <20241101070610.1267391-4-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241101070610.1267391-4-hongxing.zhu@nxp.com>

On Fri, Nov 01, 2024 at 03:06:03PM +0800, Richard Zhu wrote:
> Since dbi2 and atu regs are added for i.MX8M PCIes. Fetch the dbi2 and
> iATU base addresses from DT directly, and remove the useless codes.
> 

It'd be useful to mention where the base addresses were extraced. Like by the
DWC common driver.

> Upsteam dts's have not enabled EP function. So no function broken for
> old upsteam's dtb.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 20 --------------------
>  1 file changed, 20 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index bc8567677a67..462decd1d589 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1115,7 +1115,6 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
>  			   struct platform_device *pdev)
>  {
>  	int ret;
> -	unsigned int pcie_dbi2_offset;
>  	struct dw_pcie_ep *ep;
>  	struct dw_pcie *pci = imx_pcie->pci;
>  	struct dw_pcie_rp *pp = &pci->pp;
> @@ -1125,25 +1124,6 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
>  	ep = &pci->ep;
>  	ep->ops = &pcie_ep_ops;
>  
> -	switch (imx_pcie->drvdata->variant) {
> -	case IMX8MQ_EP:
> -	case IMX8MM_EP:
> -	case IMX8MP_EP:
> -		pcie_dbi2_offset = SZ_1M;
> -		break;
> -	default:
> -		pcie_dbi2_offset = SZ_4K;
> -		break;
> -	}
> -
> -	pci->dbi_base2 = pci->dbi_base + pcie_dbi2_offset;
> -
> -	/*
> -	 * FIXME: Ideally, dbi2 base address should come from DT. But since only IMX95 is defining
> -	 * "dbi2" in DT, "dbi_base2" is set to NULL here for that platform alone so that the DWC
> -	 * core code can fetch that from DT. But once all platform DTs were fixed, this and the
> -	 * above "dbi_base2" setting should be removed.
> -	 */
>  	if (device_property_match_string(dev, "reg-names", "dbi2") >= 0)
>  		pci->dbi_base2 = NULL;
>  
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

