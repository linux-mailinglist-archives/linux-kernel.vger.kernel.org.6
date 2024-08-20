Return-Path: <linux-kernel+bounces-294046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4EF958838
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCA9EB2161B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E61B1917D7;
	Tue, 20 Aug 2024 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="PAMGYst3"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD92191476
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724161618; cv=none; b=XuPGbWdNjCxX5iZ1b8wG4xFwXg7SHmPqshNqSMI4LROElovL4ElFCuqJSLYk7TQ0cmxCOxNOX4fHWabCrRZf7IbqwCSDiyujnDIBAugsRPR0/+yCAKVpdcXgT5Kkav0Z7V+cK3VNaiivo+cx8yijgzECRvKDuIchJRZzgPEc/ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724161618; c=relaxed/simple;
	bh=DGs+YQ/MemHzCI0cJ+pHenoa+Ft3gJVm3OGIx/wVAbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwNxbQpF6AJmO9dhFfQwM38rvIRSNW6Qj9b5X3pDarUesXIazhur87SnhrdqUR9JQ5IUyMHBwUi/6BFao6PZVGRw6oDre6In/oWlZhE0y52vve8RBrHyEOdAI2Zbm9TeYuRuMlowS0jgdv1AYugrafU+l3+isKRzerar0Vgeyp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=PAMGYst3; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a1df0a9281so14639085a.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1724161616; x=1724766416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I830akbhhKKwI8d91ZRK8IKM+grDVk/w+Lt2TLToceE=;
        b=PAMGYst3Nj/JhGJ71MXqkUV/SIynbVvumC+1lXIwIt2QPhKYPAol+A+gfYYfnuTK/I
         FAFFw/UIONRPTxfPbw1oGNS2HV0gdVljp7R13dgbBUtQvMTmckNPdp17iXzp7gG3WgN0
         ca45ayelOQKnKlf7l/+Kq+2qUjmv1oqwsxi0WLn+IpSOKl5X8yw+L+OS8ASnP47wIYIA
         fdTYkbj0Q6Eg7pV2DPXo/F7iYE9FkBy/C2jY5niDtmOvLtH3EgGlnxtQPXYHtMoDig96
         lKNR+ggoa0DerzY/ZV6jw4+IyGUj5q6HpJaRKtZYHHKhUqPoXstb+fSFMQQibYbxFylI
         kLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724161616; x=1724766416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I830akbhhKKwI8d91ZRK8IKM+grDVk/w+Lt2TLToceE=;
        b=PRqBvHx9sJg69+5EiXnDd3KgiN8eHmQB85KglZTCcPok21JRttUmbke7/drkdOeilo
         QhAz6KLlueasVEbLVX1LZE4pr/mOxyYY13VqyFlWy5SIt+Ey+30ODBqjjyY9S97boFAe
         892tyxz6sw0PVjDyWE02O/tD8pqMmyO92Uw100kwI94TwX1iVmsr3Y1yU6gea/bDeUaP
         5uJWL7fzM6mCv8pw3rgJFJguZUf7uDMiDb3eE4rwXP8j1uwHCu6TGfHB7e3q3G8R8w4n
         Giyge76M2uQdma/h4EdMaAVA0EAzwUlT5NzSG3I+eh7+C8WQpVUX9ED0u2aYqWZh+x1a
         8C7A==
X-Forwarded-Encrypted: i=1; AJvYcCXTUYI5T8arGUGZDFjE08q2aCWwPGWoq8KOfpM4JKNEd1aiB9XQr0cj0B6KC7qYQJ3OrtbCQJKFwpXg/xPR9y0SIFctHPXzqphKb9y+
X-Gm-Message-State: AOJu0YyfHlrJSGE+Lg7xZgEDh+19AUulc/IKHvMLG0u9gg/4qrLs/fNG
	q/ZSWavw1f2vK1vyHBZAN/KB7c6B68ba6L47DCFDfaRuY2u5lRJXng9D8MYH1g==
X-Google-Smtp-Source: AGHT+IEI4p59YOvtEm63+a/jQKuInzhxdbxB8AjFcSMqvIayjz8ztlKu6vsDqXATlGHaKRjS/mRyUQ==
X-Received: by 2002:a05:620a:1a12:b0:7a6:6b98:8e36 with SMTP id af79cd13be357-7a66b988f33mr163494185a.16.1724161615865;
        Tue, 20 Aug 2024 06:46:55 -0700 (PDT)
Received: from rowland.harvard.edu (wrls-249-137-8.wrls-client.fas.harvard.edu. [140.247.12.8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff112b45sm527883485a.125.2024.08.20.06.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 06:46:55 -0700 (PDT)
Date: Tue, 20 Aug 2024 09:46:53 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: gregkh@linuxfoundation.org, krzk@kernel.org, alim.akhtar@samsung.com,
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next RESEND] usb: xhci: Simplify with scoped for each OF
 child loop
Message-ID: <435bde54-aa08-47d1-8fe0-980bcc577803@rowland.harvard.edu>
References: <20240820065635.560427-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820065635.560427-1-ruanjinjie@huawei.com>

On Tue, Aug 20, 2024 at 02:56:35PM +0800, Jinjie Ruan wrote:
> Use scoped for_each_available_child_of_node_scoped() when iterating over
> device nodes to make code a bit simpler.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/usb/host/ehci-exynos.c | 9 ++-------
>  drivers/usb/host/ohci-exynos.c | 9 ++-------
>  2 files changed, 4 insertions(+), 14 deletions(-)

The patch changes ehci-exynos.c and ohci-exynos.c.  So then why does the 
Subject: line say "xhci"?

The contents of the patch look okay.

Alan Stern

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
> diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
> index bfa2eba4e3a7..1379e03644b2 100644
> --- a/drivers/usb/host/ohci-exynos.c
> +++ b/drivers/usb/host/ohci-exynos.c
> @@ -37,7 +37,6 @@ struct exynos_ohci_hcd {
>  static int exynos_ohci_get_phy(struct device *dev,
>  				struct exynos_ohci_hcd *exynos_ohci)
>  {
> -	struct device_node *child;
>  	struct phy *phy;
>  	int phy_number, num_phys;
>  	int ret;
> @@ -55,26 +54,22 @@ static int exynos_ohci_get_phy(struct device *dev,
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
>  		exynos_ohci->phy[phy_number] = phy;
> -		if (IS_ERR(phy)) {
> -			of_node_put(child);
> +		if (IS_ERR(phy))
>  			return PTR_ERR(phy);
> -		}
>  	}
>  
>  	exynos_ohci->legacy_phy = true;
> -- 
> 2.34.1
> 

