Return-Path: <linux-kernel+bounces-322873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5579731A9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60464B26463
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE771922E3;
	Tue, 10 Sep 2024 10:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OW4KUb3p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBD7190667
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962960; cv=none; b=rUW8US/DC2K/x494pD5fXZb6Ovckg+g0+rKRsznxzrobbIitxSm68Mys750mcJStvSpiGVGOgosUMEHfxXsco/3ZE5Z1XEtSDkjQFAtcEiehGJHAKHSLRfloTDL/URIkAOQaNorUnfIS20ffpbo9OdeM3eSiT35DOKjM6USEXLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962960; c=relaxed/simple;
	bh=vh9X+aZEci2stofDosAXVc8TqeitADcTacuKTe+bOuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZUR+qbkQ/40oQTc4JkbIGNb9hRu/sFN9YKBopOpivrLueflCkwWsRkfCe1BbEyH+HrqjJ0y2ecpRXqkxiLqh0XMI7kRfJ/W4QNQxO3CLT82CbXfNjl5g8OmWOhqvzrx0xVPfJNdYB4+KSGvt0Hd4OiFutclBtsgW8w8UKampi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OW4KUb3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00E1C4CEC6;
	Tue, 10 Sep 2024 10:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725962959;
	bh=vh9X+aZEci2stofDosAXVc8TqeitADcTacuKTe+bOuM=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:From;
	b=OW4KUb3pEqFwoNKYYRSRjeHn6ca34C3rPL0JAByf3Xg6QdffcFGhk8Q3RKKfLjUsQ
	 XBO+PComwNF6vr+JK9MZVNY2mHPBmfUorGXw62fDBQbyONdWcFqL9HBcifit0HQQZu
	 lnYMpyX53rURASJWvMun39LDOsxMu1h/1NA/GbUaC+0XjlLCNI0p+NvtEE4gkJWjEq
	 8eqaAlYQazdvjPb4FGTlTYzj0Uolls8gdiQK7K9mhN7ZdNgBPjtMWKaI/hU4JV8Msb
	 D1UipNXRUw2xZdonA5ll/eZX+Q4ZVSWj2fVxG2hReSEdsjiA9GlKOgTe3tamiEScGK
	 XhuXtNp8y9VPQ==
Date: Tue, 10 Sep 2024 12:09:15 +0200
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: soc@kernel.org, Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Andy Shevchenko <andy@kernel.org>, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform: cznic: turris-omnia-mcu: fix HW_RANDOM
 dependency
Message-ID: <nby5jsvn5mkj2jubbhvlxris7vxh7lwzey466atthhyq6k2gpq@qtpu4vu67q57>
References: <20240909110417.247453-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240909110417.247453-1-arnd@kernel.org>

Reviewed-by: Marek Behún <kabel@kernel.org>

On Mon, Sep 09, 2024 at 11:04:09AM +0000, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There is still a build failure when the rwrng support is in a loadable
> module but the mcu driver is built-in:
> 
> arm-linux-gnueabi-ld: drivers/platform/cznic/turris-omnia-mcu-trng.o: in function `omnia_mcu_register_trng':
> turris-omnia-mcu-trng.c:(.text.omnia_mcu_register_trng+0x11c): undefined reference to `devm_hwrng_register'
> 
> Change the dependency to explicitly disallow the broken
> configuration.
> 
> Fixes: 41bb142a4028 ("platform: cznic: turris-omnia-mcu: Add support for MCU provided TRNG")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/platform/cznic/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/cznic/Kconfig b/drivers/platform/cznic/Kconfig
> index a111eca8ff57..49c383eb6785 100644
> --- a/drivers/platform/cznic/Kconfig
> +++ b/drivers/platform/cznic/Kconfig
> @@ -70,7 +70,7 @@ config TURRIS_OMNIA_MCU_TRNG
>  	bool "Turris Omnia MCU true random number generator"
>  	default y
>  	depends on TURRIS_OMNIA_MCU_GPIO
> -	depends on HW_RANDOM
> +	depends on HW_RANDOM=y || HW_RANDOM=TURRIS_OMNIA_MCU
>  	help
>  	  Say Y here to add support for the true random number generator
>  	  provided by CZ.NIC's Turris Omnia MCU.
> -- 
> 2.39.2
> 

