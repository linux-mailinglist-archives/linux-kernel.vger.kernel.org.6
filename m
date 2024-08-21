Return-Path: <linux-kernel+bounces-295687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E320295A018
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97B1528583B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDFC1B253A;
	Wed, 21 Aug 2024 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="NRoVT830"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF84B1AF4FB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251077; cv=none; b=Qa58XIz+zrL5Jlo4Zwsqq1Cbv7QcT9AdutpESZB7TssELep+AuEOSeJDKxMHfCB1II5XgyaHAkF/JMVTOFoF9u+hXOASYD3cVI/+lqoyPyf5CsxfQ/rVcmB7vbekvk856EZYrnXQIrey58YjQ42eJpKdsayoxME74DedRCXMc/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251077; c=relaxed/simple;
	bh=FVsYbPAvgMgCGwds8h/Wi00szbGFYrxetnC7hv6av3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyynZJr/AkqxfwV+ups5zWaKqTA3xTLg4+s1I73CmspcQ++QHwDv1VKrwDvAcnFvGFBo7Uv64PzYF8Bzk9dXBlOjWV4ZB1TuFNdBCuAiNbC14QzmD/w2kzT/8zJOh/0dhh30N2qRbsOCQ2qp5KgDc5mthhf5BJyyBVFYe8Z2HrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=NRoVT830; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.harvard.edu
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5dcad91e64bso163897eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1724251075; x=1724855875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eeL7Rd+axk/Z65jpbD90HZ1f75grRQAJLvS6IO1HwSQ=;
        b=NRoVT830iciUuRsuW02ZFmmFWt9yGbe0e+uD7Bs4GmhHmF4WSlJfW4C6hZ9dmwyH4D
         nrcQtEL3no8kEGaXquxsRCgQYGxXjWcLlG8e2VBjGLGVYgHL9RYKnc6l27XQdx3t3yR6
         JaPvY8b6QKl82nYxje0IPFSV+zhNt5mx5tmwRNLa2pyyF37fKUfsGn2X5YOysBoxYpCE
         U6EcWCaI2JEx42wsaKop1Nnpmu6e8+R0qyEF1QME7HYDU2X9/nYuD9L+kRCUH86UT4io
         3Z22/UmLxrG3Q8cunF6ySq5eej3hrtvR5GUUGMPm4SqEzBBP9pee0DTiaj2IQnjPE2rO
         HVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724251075; x=1724855875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeL7Rd+axk/Z65jpbD90HZ1f75grRQAJLvS6IO1HwSQ=;
        b=ShYZdC2IA5ysHpz4L5Yy8ELBDmKSYNAHdPEjNCVtVbKTh1cNZjy/QK+ZwYwiCgqyOT
         pceR33I1x6VYE4rfXnR2qtCQatV2ZklVska3q2z4hM0ogwOl9DtG3A/j66deFstfQFJR
         IfNrQSxhRc3N4nt5vbfdgPiilzpsnmiYxVcB0q26/uhH60hIIy6tZrmlsXR2d0W55IZQ
         nxha5Op5OMZB/iVYvIHXjDvrPi8O6VUC6/RVTkMZW7GXExm5nI0z9p1fmZhHmOs5gXqM
         Q68zOcRLnHbSE3hWVzijQ2XgELNWzGpwCpUdN3zaSSCJhhEOmSQ1Y9do5Aq2OiVpUb2B
         1y0w==
X-Forwarded-Encrypted: i=1; AJvYcCUVeU58FbdjbIwcxZg8eZ/Du+Qg70KnWAYpX4ru0xC0ivUG9OfzW1Bmakb6JFc1cYm3TzxyvrRIPeyrlrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA77NXCGef0QX1TQARgrtq0xoMwoPQDacSKtVhLkRpsiDZclhd
	7se03xvBZVlh9pWRoVBdtupFLAZ17UrBhQJSsDMUE3r8o6iFmJF86aOQd0Mm5Q==
X-Google-Smtp-Source: AGHT+IHKVXgXnNh7Vl7MHFbNLldyo3rr8hecTtlHKuooYloN/lFestiTEiQL1vaPhuibzDM+/2G0Ow==
X-Received: by 2002:a05:6820:1ac6:b0:5c9:d9db:6a51 with SMTP id 006d021491bc7-5dca34e2eb9mr2653269eaf.0.1724251075012;
        Wed, 21 Aug 2024 07:37:55 -0700 (PDT)
Received: from rowland.harvard.edu (wrls-249-137-8.wrls-client.fas.harvard.edu. [140.247.12.8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fe25970sm61342326d6.60.2024.08.21.07.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 07:37:54 -0700 (PDT)
Date: Wed, 21 Aug 2024 10:37:52 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: gregkh@linuxfoundation.org, krzk@kernel.org, alim.akhtar@samsung.com,
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] usb: ehci-exynos: Simplify with scoped for each
 OF child loop
Message-ID: <a3ec2bbd-9f0a-4378-a3fa-8e0a82c8b808@rowland.harvard.edu>
References: <20240821071856.2335529-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821071856.2335529-1-ruanjinjie@huawei.com>

On Wed, Aug 21, 2024 at 03:18:56PM +0800, Jinjie Ruan wrote:
> Use scoped for_each_available_child_of_node_scoped() when iterating over
> device nodes to make code a bit simpler.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

> v2:
> - Update the commit subject.
> - Spilit into 2 patches.
> - Add Reviewed-by.
> ---
>  drivers/usb/host/ehci-exynos.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
> index f40bc2a7a124..e3a961d3f5fc 100644
> --- a/drivers/usb/host/ehci-exynos.c
> +++ b/drivers/usb/host/ehci-exynos.c
> @@ -48,7 +48,6 @@ struct exynos_ehci_hcd {
>  static int exynos_ehci_get_phy(struct device *dev,
>  				struct exynos_ehci_hcd *exynos_ehci)
>  {
> -	struct device_node *child;
>  	struct phy *phy;
>  	int phy_number, num_phys;
>  	int ret;
> @@ -66,26 +65,22 @@ static int exynos_ehci_get_phy(struct device *dev,
>  		return 0;
>  
>  	/* Get PHYs using legacy bindings */
> -	for_each_available_child_of_node(dev->of_node, child) {
> +	for_each_available_child_of_node_scoped(dev->of_node, child) {
>  		ret = of_property_read_u32(child, "reg", &phy_number);
>  		if (ret) {
>  			dev_err(dev, "Failed to parse device tree\n");
> -			of_node_put(child);
>  			return ret;
>  		}
>  
>  		if (phy_number >= PHY_NUMBER) {
>  			dev_err(dev, "Invalid number of PHYs\n");
> -			of_node_put(child);
>  			return -EINVAL;
>  		}
>  
>  		phy = devm_of_phy_optional_get(dev, child, NULL);
>  		exynos_ehci->phy[phy_number] = phy;
> -		if (IS_ERR(phy)) {
> -			of_node_put(child);
> +		if (IS_ERR(phy))
>  			return PTR_ERR(phy);
> -		}
>  	}
>  
>  	exynos_ehci->legacy_phy = true;
> -- 
> 2.34.1
> 

