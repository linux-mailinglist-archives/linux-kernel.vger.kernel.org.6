Return-Path: <linux-kernel+bounces-186628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 537A68CC697
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 20:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01306282D40
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081FC146582;
	Wed, 22 May 2024 18:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqZcOV9F"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B0E1420C6;
	Wed, 22 May 2024 18:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716404067; cv=none; b=YKeCTJLPOjMIF7B6GM85n3/QcjmGMvbwL+d/S+B+FAJBj/nYf1zN9TAJcD75kX50xD51Qxf5bwq23i+BsFeLFuJeGWwPyieGdSDm7PLQy2RyiryspFXMsAwz18CnFwcjmncM33mlMj3Zn72IlyRyWBhso1DgTHob49a9hG0muPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716404067; c=relaxed/simple;
	bh=zG6DmFSvOlwxNqFRYCCoNVfO0/oFcnar3wPos47WTUg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNWw73OFeXQXwVN6zIGk4IibDcuzuj9Dqe6CXdfY+VE/gYW+K/83bP8/sTAgftV6qEM+yUNeYuh2uVOgwmw8283iTrBfjlLBSAph3Uh8ehcUTjXayb/z/oC93X4uAt5LdbWQJ64PRXvoMOR46w+EChrMrJOYyApm2vZDU+LjeEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqZcOV9F; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-23dd94111cfso3230736fac.2;
        Wed, 22 May 2024 11:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716404065; x=1717008865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tA1Sbti/zXxCiItQT/p43hpVbiyvW9x3fEN/x9VummA=;
        b=ZqZcOV9FE0wb6bhtVBX1cDPvHGQ9ySQsdSOV6Tn0g5t0M+8LGN2tCiY4Sq9TIf6Xfj
         rdV1k6B8Xdvac4ffNB2lQQjMqr63HSIoa1xyG+4DzNWf+rfVOTgzZCudEpetvaCpqOb5
         RvXfXj+Y6MOnHe4tC5BXGC7y/g6wSzcyCeCNyPp1LODSQ7hvrll+8FVHOK2JUviwbfx1
         yIzmsbLfOqncwdeIqOClG3TPu9u27FH7+i9OicSwnekBiqKYyTanWnpy3tFCO+rcXESf
         fP1nx+CcG6Tf+qf0Q9XQeuAGDydMrxTyZMClHu2srXWns7bgzV+uOZRCCkWC01z6g4fD
         mvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716404065; x=1717008865;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tA1Sbti/zXxCiItQT/p43hpVbiyvW9x3fEN/x9VummA=;
        b=D9Lytqp5VQLEju34Bb5QcbYI9ZCtZfsfJFQg/VCHT9VLUEoCydaU4jCD8xv9CzihJ+
         Gc4MojzS0JgyawUD2ewDR058uf8rCtXoghFTEZv179zAwWX3EGO74lpaULcwLkXekI+S
         SA9x1eTFH3wcrBGy6loHt2adA697GLW64MQOHexEPMXrvAaw7JIo9RtvO0rtXyD8Nfvx
         FaDYn8xDDa8lfcGj4LdWNpZVvFKf1SjgAh1LjJ3RKlSbViZ6yH/GXz1R54rhdL16TmgT
         hwVcvp9yM+Xt1LVwSXr3Ud5+tzgDv7EqNc9XVMjEwGLKdJZhpHP4Y5ejAVfr6ZlpACyS
         6y2A==
X-Forwarded-Encrypted: i=1; AJvYcCXfKaaJEpKNUYJwkaFlMQaaSIJ+sQ9G1RkDqfMtzjUAbSM3iHA4OBHewrTIXfWvVeftfWsOXxO18sDGpOgt3BoC/kCmk0a4NMsDWdqa5TvU9APMmwqzpphXtPi6ghV5EjcMlagncqTHug==
X-Gm-Message-State: AOJu0YzGiTONGuzDmGon/luJhYN69ZObbqSeEEijyQ/izbTkRDYu9Oi4
	aLpb9gkNKh9i1EZT/4ArekIgfaH6Bhd4gX0ZPKnXNO/hRQBU7TsV
X-Google-Smtp-Source: AGHT+IH7JgZdAZmLwabI70Yi9CqaHBGi7W8WOVJdXpnbIcGSDoJHNF9GVVWCI9iFTCJBiWCAtrSgiQ==
X-Received: by 2002:a05:6871:581e:b0:23c:2cf7:9ff9 with SMTP id 586e51a60fabf-24c68aeeeb5mr3242325fac.7.1716404063187;
        Wed, 22 May 2024 11:54:23 -0700 (PDT)
Received: from neuromancer. ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-24c8227e303sm44531fac.30.2024.05.22.11.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 11:54:22 -0700 (PDT)
Message-ID: <664e3f5e.050a0220.ae493.07d7@mx.google.com>
X-Google-Original-Message-ID: <Zk4/Xcjv/KKYwuHu@neuromancer.>
Date: Wed, 22 May 2024 13:54:21 -0500
From: Chris Morgan <macroalpha82@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Ryan Walklin <ryan@testtoast.com>
Subject: Re: [PATCH v2 4/5] mfd: axp20x: AXP717: Add support for boost
 regulator
References: <20240418000736.24338-1-andre.przywara@arm.com>
 <20240418000736.24338-5-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418000736.24338-5-andre.przywara@arm.com>

On Thu, Apr 18, 2024 at 01:07:35AM +0100, Andre Przywara wrote:
> The AXP717 also contains a boost regulator, to provide the 5V USB VBUS
> rail when running on battery.
> 
> Add the registers to the MFD description to be able to use them from the
> regulator driver.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: John Watts <contact@jookia.org>
> ---
>  drivers/mfd/axp20x.c       | 2 ++
>  include/linux/mfd/axp20x.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index d8ad4e120d379..02513b1eff2e8 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -209,6 +209,8 @@ static const struct regmap_access_table axp313a_volatile_table = {
>  };
>  
>  static const struct regmap_range axp717_writeable_ranges[] = {
> +	regmap_reg_range(AXP717_MODULE_EN_CONTROL, AXP717_MODULE_EN_CONTROL),
> +	regmap_reg_range(AXP717_BOOST_CONTROL, AXP717_BOOST_CONTROL),
>  	regmap_reg_range(AXP717_IRQ0_EN, AXP717_IRQ4_EN),
>  	regmap_reg_range(AXP717_IRQ0_STATE, AXP717_IRQ4_STATE),
>  	regmap_reg_range(AXP717_DCDC_OUTPUT_CONTROL, AXP717_CPUSLDO_CONTROL),
> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> index 8c0a33a2e9ce2..4dad54fdf67ee 100644
> --- a/include/linux/mfd/axp20x.h
> +++ b/include/linux/mfd/axp20x.h
> @@ -115,6 +115,8 @@ enum axp20x_variants {
>  #define AXP313A_IRQ_STATE		0x21
>  
>  #define AXP717_ON_INDICATE		0x00
> +#define AXP717_MODULE_EN_CONTROL	0x19

Could we name this register something like "AXP717_MODULE_EN_CONTROL_2"?
We're going to need register 0x0b later for usb and battery, and that's
also marked as a control register (control_1 per the datasheet).

Thank you,
Chris

> +#define AXP717_BOOST_CONTROL		0x1e
>  #define AXP717_IRQ0_EN			0x40
>  #define AXP717_IRQ1_EN			0x41
>  #define AXP717_IRQ2_EN			0x42
> -- 
> 2.35.8
> 

