Return-Path: <linux-kernel+bounces-179324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CD58C5ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 03:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD8C282372
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 01:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20E553AC;
	Wed, 15 May 2024 01:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PM92oEmu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CF7A21;
	Wed, 15 May 2024 01:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715737128; cv=none; b=OLYY3rlkONriYJD1j7Mnj0yGtV9V+6bsyxHBBZYeyJ1INYm880wUMvwOx9o2hnrVAklurBWEB3Z7VXq+25ctRWN/9XSjAavVsRb12HRAk0j85mCIKg7rYU3ybNjQXklDZiqknLJIIOWK4TT0RiZuT5ibrA1prR24a6ZLkRmIUto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715737128; c=relaxed/simple;
	bh=tiVin0UW1OpsohyBFE7sZPj3xkCRa3M6BQp9OCqePW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/zLlt64RYjIBeYl1FdVNTdBl1R+xMHADdY84nbLJFM2U7AZ7g27Jq7GoajKbhZ0lTwVpotcwV8pSythduJVIS4XxwU2dm3K4qxpa4H1DG8tPrGVH4mrEfE2A3tSCNDcoixJc1zNzG7yDfkRUaC2NUni0kRTdNLqVHvUOUfLm6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PM92oEmu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2FBC2BD10;
	Wed, 15 May 2024 01:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715737127;
	bh=tiVin0UW1OpsohyBFE7sZPj3xkCRa3M6BQp9OCqePW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PM92oEmuIUgmqnb0Rr9A9cK9VcuZB/46SuumS+G4JXgipFG7KAYdF0xG9Qv2tkMMV
	 o3JMdO3883TvwAQyWXoyBbXCq8ITR4RxCF95ckuVqO6YrfzYezyGB6ClE5Z/WVUSTt
	 MLZW8FZzjeQG884YstdULcPNUCILbYV1do/grZuEKS+fZxR07kNAM5M/fGUjItnOHo
	 pAXShoF/5trV1M9bgFhNomgzAVQ79QrBqT27lbESq73WNvgwRYTPRLBKus49O6UYjK
	 Kd50OzBtVDxGYCxYjrQbHUhMMj71R19sESDf1/bLxvW9ilJb/K94521NXSXHfY/M6k
	 8EZUlDNZzDPCQ==
Date: Wed, 15 May 2024 09:38:38 +0800
From: Peter Chen <peter.chen@kernel.org>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc: pawell@cadence.com, rogerq@kernel.org, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: cdns3: Add quirk flag to enable suspend
 residency
Message-ID: <20240515013838.GA3279984@nchen-desktop>
References: <20240514092421.20897-1-r-gunasekaran@ti.com>
 <20240514092421.20897-2-r-gunasekaran@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514092421.20897-2-r-gunasekaran@ti.com>

On 24-05-14 14:54:20, Ravi Gunasekaran wrote:
> From: Roger Quadros <rogerq@kernel.org>
> 
> Some platforms (e.g. ti,j721e-usb, ti,am64-usb) require
> this bit to be set to workaround a lockup issue with PHY
> short suspend intervals [1]. Add a platform quirk flag
> to indicate if Suspend Residency should be enabled.
> 
> [1] - https://www.ti.com/lit/er/sprz457h/sprz457h.pdf
> i2409 - USB: USB2 PHY locks up due to short suspend
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
>  drivers/usb/cdns3/core.h | 1 +
>  drivers/usb/cdns3/drd.c  | 9 ++++++++-
>  drivers/usb/cdns3/drd.h  | 3 +++
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
> index 81a9c9d6be08..57d47348dc19 100644
> --- a/drivers/usb/cdns3/core.h
> +++ b/drivers/usb/cdns3/core.h
> @@ -44,6 +44,7 @@ struct cdns3_platform_data {
>  			bool suspend, bool wakeup);
>  	unsigned long quirks;
>  #define CDNS3_DEFAULT_PM_RUNTIME_ALLOW	BIT(0)
> +#define CDNS3_DRD_SUSPEND_RESIDENCY_ENABLE	BIT(1)
>  };
>  
>  /**
> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
> index 8b936a2e93a0..de0d25a072b4 100644
> --- a/drivers/usb/cdns3/drd.c
> +++ b/drivers/usb/cdns3/drd.c
> @@ -389,7 +389,7 @@ static irqreturn_t cdns_drd_irq(int irq, void *data)
>  int cdns_drd_init(struct cdns *cdns)
>  {
>  	void __iomem *regs;
> -	u32 state;
> +	u32 state, reg;
>  	int ret;
>  
>  	regs = devm_ioremap_resource(cdns->dev, &cdns->otg_res);
> @@ -439,6 +439,13 @@ int cdns_drd_init(struct cdns *cdns)
>  			return -EINVAL;
>  		}
>  
> +		if (cdns->pdata &&
> +		    (cdns->pdata->quirks & CDNS3_DRD_SUSPEND_RESIDENCY_ENABLE)) {
> +			reg = readl(&cdns->otg_v1_regs->susp_ctrl);
> +			reg |= SUSP_CTRL_SUSPEND_RESIDENCY_ENABLE;
> +			writel(reg, &cdns->otg_v1_regs->susp_ctrl);
> +		}
> +

It is better put this above (just above code cdns->version  =
CDNS3_CONTROLLER_V1;)

Peter
>  		dev_dbg(cdns->dev, "DRD version v1 (ID: %08x, rev: %08x)\n",
>  			 readl(&cdns->otg_v1_regs->did),
>  			 readl(&cdns->otg_v1_regs->rid));
> diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
> index d72370c321d3..1e2aee14d629 100644
> --- a/drivers/usb/cdns3/drd.h
> +++ b/drivers/usb/cdns3/drd.h
> @@ -193,6 +193,9 @@ struct cdns_otg_irq_regs {
>  /* OTGREFCLK - bitmasks */
>  #define OTGREFCLK_STB_CLK_SWITCH_EN	BIT(31)
>  
> +/* SUPS_CTRL - bitmasks */
> +#define SUSP_CTRL_SUSPEND_RESIDENCY_ENABLE	BIT(17)
> +
>  /* OVERRIDE - bitmasks */
>  #define OVERRIDE_IDPULLUP		BIT(0)
>  /* Only for CDNS3_CONTROLLER_V0 version */
> -- 
> 2.17.1
> 

-- 

Thanks,
Peter Chen

