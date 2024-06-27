Return-Path: <linux-kernel+bounces-232408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EF391A863
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B7AF1F22686
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37377195395;
	Thu, 27 Jun 2024 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r9jhzmtF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC14194AEE
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719496486; cv=none; b=bYJy/PCEZzcrj1E6HzC6yV4mcHxLIkHIdm6Zg6nUrT6iONgwf5LJUQpWzuJPcaNW5DgsGhfq/fNsqgyoVnFjcqU2ZSJQB799BnwkS72K7vyIfESNuZ/TZGgF9TXmoINwCIT4pql2F+M3btBP883unxX2+hJE0X2GUhOmuS79Dls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719496486; c=relaxed/simple;
	bh=+BKKW+diW26k2SuRMotX2YG0vx1D8Z9XZEB8356eb4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XU7+bLHSSL5LSNiTPncsx8+n+l0hElNrOJ/X0e0zMk9MlmS3OWKyBjUQJWpfZg6UK5VFuykIEmltvwXSbU8cC00AXnAJx+DomfmtDnVHSLbjerGyXRVso2ffDnGazAQgMBROA9YAzOZBkHldUmr9hlS3ll5a6vvgKSryB+hJAdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r9jhzmtF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EDEC2BBFC;
	Thu, 27 Jun 2024 13:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719496486;
	bh=+BKKW+diW26k2SuRMotX2YG0vx1D8Z9XZEB8356eb4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r9jhzmtFc/Pkx+cX7hAPLJF7+c6/67MNIJOCv3Ihyvn9tBMgagXTjrPMbayGElP+s
	 O8n+qzkMmSMmI6JQGyHynhqu9eBp900qkjHCeM32lIs4mwVHqrc/tFpjXi7mut+1s5
	 S1ktoYcj3NkheyEB/NfSgENwSIHHgugccpeRPd5g=
Date: Thu, 27 Jun 2024 15:54:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devres: Simple code optimization
Message-ID: <2024062750-hubcap-parish-7bda@gregkh>
References: <d029d754-aeb7-493a-8e48-6acaa53fee1e@quicinc.com>
 <1719496036-24642-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1719496036-24642-1-git-send-email-quic_zijuhu@quicinc.com>

On Thu, Jun 27, 2024 at 09:47:16PM +0800, Zijun Hu wrote:
> Initialize an uninitialized struct member for devres_open_group()
> and simplify devm_percpu_match() implementation.

Huge hint, when you say "and" or "also" in a patch, it's a good idea to
split it up into different commits, right?

> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> This change is intend to replace below one:
> https://lore.kernel.org/lkml/1718629765-32720-1-git-send-email-quic_zijuhu@quicinc.com/#t

Why?  SHouldn't this be v2 instead?

>  drivers/base/devres.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index 3df0025d12aa..5b1d498e83ab 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -567,6 +567,7 @@ void * devres_open_group(struct device *dev, void *id, gfp_t gfp)
>  	grp->id = grp;
>  	if (id)
>  		grp->id = id;
> +	grp->color = 0;
>  
>  	spin_lock_irqsave(&dev->devres_lock, flags);
>  	add_dr(dev, &grp->node[0]);
> @@ -1172,9 +1173,9 @@ static void devm_percpu_release(struct device *dev, void *pdata)
>  
>  static int devm_percpu_match(struct device *dev, void *data, void *p)
>  {
> -	struct devres *devr = container_of(data, struct devres, data);
> +	void __percpu *ptr = *(void __percpu **)data;
>  
> -	return *(void **)devr->data == p;
> +	return ptr == (void __percpu *)p;

What exactly is being "optimized" here?

And where did the container_of go?  You just lost all type-safeness.

thanks,

greg k-h

