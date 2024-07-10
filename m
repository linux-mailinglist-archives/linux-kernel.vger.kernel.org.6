Return-Path: <linux-kernel+bounces-247176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 108CB92CC33
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FCA7B23CCB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843B382485;
	Wed, 10 Jul 2024 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xTn0X7RS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C825C2CCB4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720597675; cv=none; b=TeWuS7xFqw75ErUfx1/nLdpsCCGlUNF46I0Uuip9l7VIH99zy7oYVkWlh60cZb6tgyr7fJZI9i+8XADywk+01YBlAa1M94rrOJG5ibi2K0MOMNDSqAFC1JojDyKTKzEziIa1TWY2BdCO1W08EHRLFx/R61hRwsjCiBw7UVO83Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720597675; c=relaxed/simple;
	bh=TIvUtgmoWgcsFjzGNk+ZdKfpPrUG9ENNoElEgGE3iAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FclbVPAwOU2NPuj+eZY9LzPzUaaWCNFohlT9hLl1jH60iSCCMeSdXnkcxKzUghWLkAG5ksgNU7FqUZuqwcTcNwH4jUfEqt4sM7yiLGMSkTUzopZns6acQ/5KymiySmagXNXPXsl1C2mkbFAkWPir1S+cO14c72QW6zwPlz3mMvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xTn0X7RS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0496AC32781;
	Wed, 10 Jul 2024 07:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720597675;
	bh=TIvUtgmoWgcsFjzGNk+ZdKfpPrUG9ENNoElEgGE3iAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xTn0X7RSsphH5elglUjYeJkk5xJL2mvIfmaMMJP95pytlHSmFcq2eoHFTKcuQH1fj
	 ayhxgWAIFNLs8+W5iC+1bFMPyJj42ssZQpvQ8i59WY8+RvMcaMTeCeI7b2tK5djFIF
	 r5w+BF4m+uC2skAEDRPMchY0zO9oHPVAKBURh4fc=
Date: Wed, 10 Jul 2024 09:47:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dio: Have dio_bus_match() callback take a const *
Message-ID: <2024071031-afterglow-porridge-de26@gregkh>
References: <20240710074452.2841173-1-geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240710074452.2841173-1-geert@linux-m68k.org>

On Wed, Jul 10, 2024 at 09:44:52AM +0200, Geert Uytterhoeven wrote:
> drivers/dio/dio-driver.c:128:11: error: initialization of ‘int (*)(struct device *, const struct device_driver *)’ from incompatible pointer type ‘int (*)(struct device *, struct device_driver *)’ [-Werror=incompatible-pointer-types]
>   128 |  .match = dio_bus_match,
>       |           ^~~~~~~~~~~~~
> drivers/dio/dio-driver.c:128:11: note: (near initialization for ‘dio_bus_type.match’)
> 
> Reported-by: noreply@ellerman.id.au
> Fixes: d69d804845985c29 ("driver core: have match() callback in struct bus_type take a const *")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/dio/dio-driver.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dio/dio-driver.c b/drivers/dio/dio-driver.c
> index 2d9fa6011945d88b..12fa2d209dab9d3c 100644
> --- a/drivers/dio/dio-driver.c
> +++ b/drivers/dio/dio-driver.c
> @@ -110,10 +110,10 @@ void dio_unregister_driver(struct dio_driver *drv)
>   *  and 0 if there is no match.
>   */
>  
> -static int dio_bus_match(struct device *dev, struct device_driver *drv)
> +static int dio_bus_match(struct device *dev, const struct device_driver *drv)
>  {
>  	struct dio_dev *d = to_dio_dev(dev);
> -	struct dio_driver *dio_drv = to_dio_driver(drv);
> +	const struct dio_driver *dio_drv = to_dio_driver(drv);

Same here, to_dio_driver() should be changed to use container_of_const()

thanks,

greg k-h

