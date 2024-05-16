Return-Path: <linux-kernel+bounces-180550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D988C700D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 03:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7976628282A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 01:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2194715C3;
	Thu, 16 May 2024 01:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzEeaPzk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611EC10E3;
	Thu, 16 May 2024 01:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715823574; cv=none; b=q/JNJw0U3M/gwVSIVFRVRGi0SFnZLO4X0a9XfmKySHsqA2+JgtGZPbPtaP5jL7kOLx6VApmRoIQ98WqAaGJyl3hETQQYzanfsnnCMCE4CCGLLEj0ssotXx3SkP+2gB3drwG5S+12/J5wCWoQTgfHtxOVekRWQOqO6yZCt/jd5iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715823574; c=relaxed/simple;
	bh=FmMtybhZYs1e5AN33E5WpxqtlLbnaIg7KEc6WGebVmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKaOOFirZXGcT08lSinE9MqMCevDEE5WKQaAchLBm1ACDAYFh1znwRbltloAswWC8XVA6GPXvC9wG7+S7VnXI9Vx7i1hZDMxAe0uOe4f58ec1ewqHRXz+bM0smkekpZLmgy7qptzSv1n+vM2O5zPUlZAiLbqLypakfvV2s6udwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzEeaPzk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E91C116B1;
	Thu, 16 May 2024 01:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715823574;
	bh=FmMtybhZYs1e5AN33E5WpxqtlLbnaIg7KEc6WGebVmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gzEeaPzk5KK5Lo3QAapPqzCPdzXzSYw2CCwrjMnDnXXXlWF+6FM/q9VOIIUi2VhbF
	 zvGFriJ6dp9iYzwrhtGVL1ZNOtvZ/fhflDltCRqgTiejz2i5hAVykwmze/g1SFX9dy
	 uAxtmAXmbDfhDbwzL6bT2cnSnfgCOrOjZQOuhecBqEcW2mANy1+0zXdGtzbJE8Rt5V
	 pULG5WaUkcsHCN8JjAY04hmfo3W5ua1WH8usZuKOWoCAiibtYJrUHMNYwaZKbzbz6b
	 jWVRRlf6O2eShqisqYhTyjWyrdL5ETKPzYuEwr7yTPGOM+nCT97XB54a/wIk1Y02Av
	 3gHBYepfLuC0w==
Date: Thu, 16 May 2024 09:39:24 +0800
From: Peter Chen <peter.chen@kernel.org>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc: pawell@cadence.com, rogerq@kernel.org, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: cdns3: Add quirk flag to enable suspend
 residency
Message-ID: <20240516013924.GA3283751@nchen-desktop>
References: <20240514092421.20897-1-r-gunasekaran@ti.com>
 <20240514092421.20897-2-r-gunasekaran@ti.com>
 <20240515013838.GA3279984@nchen-desktop>
 <dde63edb-9057-2d33-032a-8ee25e981c72@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dde63edb-9057-2d33-032a-8ee25e981c72@ti.com>

On 24-05-15 09:52:57, Ravi Gunasekaran wrote:
> 
> 
> On 5/15/24 7:08 AM, Peter Chen wrote:
> > On 24-05-14 14:54:20, Ravi Gunasekaran wrote:
> >> From: Roger Quadros <rogerq@kernel.org>
> >>
> >> Some platforms (e.g. ti,j721e-usb, ti,am64-usb) require
> >> this bit to be set to workaround a lockup issue with PHY
> >> short suspend intervals [1]. Add a platform quirk flag
> >> to indicate if Suspend Residency should be enabled.
> >>
> >> [1] - https://www.ti.com/lit/er/sprz457h/sprz457h.pdf
> >> i2409 - USB: USB2 PHY locks up due to short suspend
> >>
> >> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> >> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> >> ---
> 
> [...]
> 
> >>  	regs = devm_ioremap_resource(cdns->dev, &cdns->otg_res);
> >> @@ -439,6 +439,13 @@ int cdns_drd_init(struct cdns *cdns)
> >>  			return -EINVAL;
> >>  		}
> >>  
> >> +		if (cdns->pdata &&
> >> +		    (cdns->pdata->quirks & CDNS3_DRD_SUSPEND_RESIDENCY_ENABLE)) {
> >> +			reg = readl(&cdns->otg_v1_regs->susp_ctrl);
> >> +			reg |= SUSP_CTRL_SUSPEND_RESIDENCY_ENABLE;
> >> +			writel(reg, &cdns->otg_v1_regs->susp_ctrl);
> >> +		}
> >> +
> > 
> > It is better put this above (just above code cdns->version  =
> > CDNS3_CONTROLLER_V1;)
> > 
> 
> You mean here, to group it with CDNS3 v1?
> 
> else if (OTG_CDNS3_CHECK_DID(state)) {                                               
>       cdns->otg_irq_regs = (struct cdns_otg_irq_regs __iomem *)
>                             &cdns->otg_v1_regs->ien;
>       writel(1, &cdns->otg_v1_regs->simulate);
> 
> +     if (cdns->pdata &&
> +	  (cdns->pdata->quirks & CDNS3_DRD_SUSPEND_RESIDENCY_ENABLE)) {
> +	      reg = readl(&cdns->otg_v1_regs->susp_ctrl);
> +	      reg |= SUSP_CTRL_SUSPEND_RESIDENCY_ENABLE;
> +	      writel(reg, &cdns->otg_v1_regs->susp_ctrl);
> +     }
>       dns->version  = CDNS3_CONTROLLER_V1;

Yes.

Peter

> } else
> 
> > Peter
> >>  		dev_dbg(cdns->dev, "DRD version v1 (ID: %08x, rev: %08x)\n",
> >>  			 readl(&cdns->otg_v1_regs->did),
> >>  			 readl(&cdns->otg_v1_regs->rid));
> >> diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
> >> index d72370c321d3..1e2aee14d629 100644
> >> --- a/drivers/usb/cdns3/drd.h
> >> +++ b/drivers/usb/cdns3/drd.h
> >> @@ -193,6 +193,9 @@ struct cdns_otg_irq_regs {
> >>  /* OTGREFCLK - bitmasks */
> >>  #define OTGREFCLK_STB_CLK_SWITCH_EN	BIT(31)
> >>  
> >> +/* SUPS_CTRL - bitmasks */
> >> +#define SUSP_CTRL_SUSPEND_RESIDENCY_ENABLE	BIT(17)
> >> +
> >>  /* OVERRIDE - bitmasks */
> >>  #define OVERRIDE_IDPULLUP		BIT(0)
> >>  /* Only for CDNS3_CONTROLLER_V0 version */
> >> -- 
> >> 2.17.1
> >>
> > 
> 
> -- 
> Regards,
> Ravi

-- 

Thanks,
Peter Chen

