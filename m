Return-Path: <linux-kernel+bounces-181696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 996588C7FD5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 04:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A1C2840B5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 02:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7B87490;
	Fri, 17 May 2024 02:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8hSzw6S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBDD184D;
	Fri, 17 May 2024 02:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715912448; cv=none; b=dlN7RYCz33N2fvjjFLwntnxK8rY0jtXMQyFm7kXGfrRlsPqt8BIvJ2liCKZnBUECM2TcTR14+n+9vsw053Dc+MtygH3hBq/Od5UH+asgPCNsnQlZ3CZids7MiSnuK0QqPiUqRqBgBMNXgZnRYGk14iqWXmOKGaNggtLcwfz5Vpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715912448; c=relaxed/simple;
	bh=J/fHWFP0Q5RYkvE5yyf9muvr1X5zHjrLSKgXeUgVBrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lk1i07zEEjAyi15fUsM/h35QnFzPJmRakp3vcCDwzpXKqRXJiK0ea0BRli46ry9AkAYbswf/in3AhQruThH4DkNAYA5zVv2vpM/Xk0VjWpi9Hi8nYTQVPitArtz6na9reCeClmYjzOwa4kWWYpceg/DADn0I3f9KEIwNk13cBtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8hSzw6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7589BC113CC;
	Fri, 17 May 2024 02:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715912447;
	bh=J/fHWFP0Q5RYkvE5yyf9muvr1X5zHjrLSKgXeUgVBrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G8hSzw6S1uALxMQUkzS27GOxo2QZTOByFuwtmYDKziEr9xBalEk8KoFT/1z3ToKgt
	 +k4tDLqgFeMA7+lqPrbkQo5LT3i8NYzjkL3dXchcqdwJWqJQdftjb8fi+F2YMkf49q
	 y49YWrwYKugadjNfv8x2cKjJRz+Y2v7sZ06HY3yNr/5fT/8hxrhouN0+A3GECd8Tjj
	 2urOFnY0dGCHuerqzS3pUNlJzKLVOANmj2IiDYyuXhWW7hGHAtfXJGU7VPoLWNp2ia
	 YiBN7LebfPbbDA+7ndvZTUfEMpOlom38drwbsAwboFLcTvXL0w4H1jAdldylQxKLgW
	 soG4RDJBCfXUg==
Date: Fri, 17 May 2024 10:20:38 +0800
From: Peter Chen <peter.chen@kernel.org>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc: pawell@cadence.com, rogerq@kernel.org, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, srk@ti.com
Subject: Re: [PATCH v3 1/2] usb: cdns3: Add quirk flag to enable suspend
 residency
Message-ID: <20240517022038.GA3458484@nchen-desktop>
References: <20240516044537.16801-1-r-gunasekaran@ti.com>
 <20240516044537.16801-2-r-gunasekaran@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516044537.16801-2-r-gunasekaran@ti.com>

On 24-05-16 10:15:36, Ravi Gunasekaran wrote:
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
> Change log:
> ----------
> Changes since v2:
> ----------------
> * Fixed the redundant blank line added in v2
> 
> Changes since v1:
> ----------------
> * Grouped the susp_ctrl register update along with
>   existing CDNS3 snippet as suggested by Peter Chen
> 
> v2: https://lore.kernel.org/all/20240516042845.31211-1-r-gunasekaran@ti.com/
> v1: https://lore.kernel.org/all/20240514092421.20897-1-r-gunasekaran@ti.com/#t
> 
>  drivers/usb/cdns3/core.h |  1 +
>  drivers/usb/cdns3/drd.c  | 10 +++++++++-
>  drivers/usb/cdns3/drd.h  |  3 +++
>  3 files changed, 13 insertions(+), 1 deletion(-)
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
> index 8b936a2e93a0..84fb38a5723a 100644
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
> @@ -433,6 +433,14 @@ int cdns_drd_init(struct cdns *cdns)
>  			cdns->otg_irq_regs = (struct cdns_otg_irq_regs __iomem *)
>  					      &cdns->otg_v1_regs->ien;
>  			writel(1, &cdns->otg_v1_regs->simulate);
> +
> +			if (cdns->pdata &&
> +			    (cdns->pdata->quirks & CDNS3_DRD_SUSPEND_RESIDENCY_ENABLE)) {
> +				reg = readl(&cdns->otg_v1_regs->susp_ctrl);
> +				reg |= SUSP_CTRL_SUSPEND_RESIDENCY_ENABLE;
> +				writel(reg, &cdns->otg_v1_regs->susp_ctrl);
> +			}
> +
>  			cdns->version  = CDNS3_CONTROLLER_V1;

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter
>  		} else {
>  			dev_err(cdns->dev, "not supported DID=0x%08x\n", state);
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

