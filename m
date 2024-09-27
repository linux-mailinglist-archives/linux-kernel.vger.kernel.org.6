Return-Path: <linux-kernel+bounces-341567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6099881C3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1690A28580C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E373719F467;
	Fri, 27 Sep 2024 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJU3nTSl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C4218756A;
	Fri, 27 Sep 2024 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727430420; cv=none; b=M95T8RQ6RlVsbpS8GHwn9BXUY5ekMFz7AGFEzUQ/M1SGXWb97XipTxQ4KVvB26h6Svkk77zsqrxFsRsT4yJ7QQOp5Io3DCVed5wAl7hlh7QyVSnhjCMB44nyGTLMq521QP1muSB8OFXlhLm8WnUVYI0zOnbOmap6Zb+RNtPhaBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727430420; c=relaxed/simple;
	bh=bX37R5ZLSZqTwnDOVmSnI1kKRm7LKRBsIvjfkpf7tP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBfbRs7U7Hs9mbPtwe7O0WfqBRiZCv+VUlPwjFIeKUFIA+MpGSZQiI4oAHtcwUhhbRB6XaI8iKtrmkUfWRuzahNbLl4e91oQJx97BOhfqM0s5WvTYVHEA2mw05dF+DFcVlp1X0CNIakJOO1mn8wE/JmB4jDjIq9L28UXJEpjgO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJU3nTSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B645C4CEC9;
	Fri, 27 Sep 2024 09:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727430419;
	bh=bX37R5ZLSZqTwnDOVmSnI1kKRm7LKRBsIvjfkpf7tP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gJU3nTSlFool2P3OOwD/cgEZg6cbWR2XzD314ACL0uOYuxoaGu3sYs1TWnI19jKJh
	 KMD8pbfpjMltSmRDsTycGc8E82a7KWx1+VVncdBxVG14Jz9k9m0mYtpm5pwtKkyozX
	 kXV8Gbpf937JyUszVk6QVHD7iRYXd2k8PNpIKMeUBP1fIIejBDxdXOjtJJUOK0Q8R/
	 J2yxOZXmwVx45E5ZfyQnJS87jO1Sb1T07x6eLaHjNzEMrD7K7shutwssK4v7CXQFGN
	 FLukl2B8ROlIAm3j1PxDzNC7DadOrXh9aV0j2CB126/lN+Re56hdWIrsooOpLU0oiH
	 bNcT7LINNCXZw==
Date: Fri, 27 Sep 2024 11:46:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michael Wu <michael@allwinnertech.com>
Cc: gregkh@linuxfoundation.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, Thinh.Nguyen@synopsys.com, balbi@kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: dwc3: core: add Gen2 polarity detection support
Message-ID: <5gxoahmmyhzl2ruai6nvmdodhi5r5xq4cwpgaw3td7b23xyfb6@ucjqoxitosnd>
References: <20240927072557.74194-1-michael@allwinnertech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240927072557.74194-1-michael@allwinnertech.com>

On Fri, Sep 27, 2024 at 03:25:56PM +0800, Michael Wu wrote:
> According to the DWC31 Enhanced SuperSpeed USB3.1 Controller Programming
> Guide, for Gen2 polarity detection, link uses data block (0011b) sync
> header for SYNC OS instead of control block (1100b).
> 
> Added 'snps,inv-sync-hdr-quirk' a DT property to set this bit 30 of
> LLUCTL if the third-party PHY doesn't correct the sync header of the
> SYNC OS in the case of inverse polarity.
> 
> Signed-off-by: Michael Wu <michael@allwinnertech.com>
> ---
>  drivers/usb/dwc3/core.c | 24 ++++++++++++++++--------
>  drivers/usb/dwc3/core.h |  6 ++++++
>  2 files changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 734de2a8bd212..72fddfcbdd0c3 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1434,15 +1434,20 @@ static int dwc3_core_init(struct dwc3 *dwc)
>  
>  	dwc3_config_threshold(dwc);
>  
> -	/*
> -	 * Modify this for all supported Super Speed ports when
> -	 * multiport support is added.
> -	 */
> -	if (hw_mode != DWC3_GHWPARAMS0_MODE_GADGET &&
> -	    (DWC3_IP_IS(DWC31)) &&
> -	    dwc->maximum_speed == USB_SPEED_SUPER) {
> +	if (DWC3_IP_IS(DWC31)) {
>  		reg = dwc3_readl(dwc->regs, DWC3_LLUCTL);
> -		reg |= DWC3_LLUCTL_FORCE_GEN1;
> +
> +		/*
> +		 * Modify this for all supported Super Speed ports when
> +		 * multiport support is added.
> +		 */
> +		if (hw_mode != DWC3_GHWPARAMS0_MODE_GADGET &&
> +		    dwc->maximum_speed == USB_SPEED_SUPER)
> +			reg |= DWC3_LLUCTL_FORCE_GEN1;
> +
> +		if (dwc->inv_sync_hdr_quirk)
> +			reg |= DWC3_LLUCTL_INV_SYNC_HDR;
> +
>  		dwc3_writel(dwc->regs, DWC3_LLUCTL, reg);
>  	}
>  
> @@ -1774,6 +1779,9 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>  	dwc->dis_split_quirk = device_property_read_bool(dev,
>  				"snps,dis-split-quirk");
>  
> +	dwc->inv_sync_hdr_quirk = device_property_read_bool(dev,
> +				"snps,inv-sync-hdr-quirk");

Bindings are *always* before their users.

Best regards,
Krzysztof


