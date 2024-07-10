Return-Path: <linux-kernel+bounces-247175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B5C92CC31
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 449931C21984
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F5E8288F;
	Wed, 10 Jul 2024 07:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aLnx689O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FD837708
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720597640; cv=none; b=NizfEACCInTrBuzMwnoNIda/o91rjOovaafE+IkaP2kARC/G942W2nY04Kg/9vXwChrN6a/nSUY3y5zCco4UjfJ2ZwKerdrPoqKDckHm+DLRqpoZGD/OpLRNUS3eMweRnXU+7qwz5udhz1OkC7ZlRGwxoYDGp+nmzxGAvCqgzL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720597640; c=relaxed/simple;
	bh=IUZn6a0shpNt/0AQJ0P2+QjARg+P1D+QCf11PY3JGVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WO6hSlzVXuW81ZXqopI6ZMjEEuKu4eF7jNKE8Z6cI5a7oppGuVYN0CB/O/TifCWRKF0Ldoms1wEbw3bm3Jm1BRWUwTNpiuvj+XCC+avlSoRVAicbJyrvwCtCH/o+UpeFIwISunOftS1oJySFXxQGEKoijwHLsMGek8D6yYPrJr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aLnx689O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A994C32781;
	Wed, 10 Jul 2024 07:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720597639;
	bh=IUZn6a0shpNt/0AQJ0P2+QjARg+P1D+QCf11PY3JGVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aLnx689OpQvoiLTn5/4d7Q8qSrV5LJ58Jkab9PMs+DJ/5xSe+dH7/Zf8rSHJ+j/zB
	 XPKkF4UzIP8GxwR0f4Fc6JlNtbCMp5pAdP53pxzgoRwu7hL14nox6BlvBnxCoBnleI
	 U65swr1OkSspXaGrXYXxpNqOWQbWc6Iiv7UlwTqQ=
Date: Wed, 10 Jul 2024 09:47:17 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zorro: Have zorro_bus_match() callback take a const *
Message-ID: <2024071034-murmuring-pueblo-4b3d@gregkh>
References: <20240710074500.2841193-1-geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240710074500.2841193-1-geert@linux-m68k.org>

On Wed, Jul 10, 2024 at 09:45:00AM +0200, Geert Uytterhoeven wrote:
> drivers/zorro/zorro-driver.c:157:12: error: initialization of ‘int (*)(struct device *, const struct device_driver *)’ from incompatible pointer type ‘int (*)(struct device *, struct device_driver *)’ [-Werror=incompatible-pointer-types]
>   157 |  .match  = zorro_bus_match,
>       |            ^~~~~~~~~~~~~~~
> drivers/zorro/zorro-driver.c:157:12: note: (near initialization for ‘zorro_bus_type.match’)
> 
> Reported-by: noreply@ellerman.id.au
> Fixes: d69d804845985c29 ("driver core: have match() callback in struct bus_type take a const *")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/zorro/zorro-driver.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/zorro/zorro-driver.c b/drivers/zorro/zorro-driver.c
> index f49d19977e82a718..e7d3af1a223f9abf 100644
> --- a/drivers/zorro/zorro-driver.c
> +++ b/drivers/zorro/zorro-driver.c
> @@ -118,10 +118,10 @@ EXPORT_SYMBOL(zorro_unregister_driver);
>       *  supported, and 0 if there is no match.
>       */
>  
> -static int zorro_bus_match(struct device *dev, struct device_driver *drv)
> +static int zorro_bus_match(struct device *dev, const struct device_driver *drv)
>  {
>  	struct zorro_dev *z = to_zorro_dev(dev);
> -	struct zorro_driver *zorro_drv = to_zorro_driver(drv);
> +	const struct zorro_driver *zorro_drv = to_zorro_driver(drv);

Patches crossed in the mail :)

Look at mine, I also fixed up to_zorro_driver() to properly pass through
the const pointer which would be good here.

thanks,

greg k-h

