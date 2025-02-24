Return-Path: <linux-kernel+bounces-529115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D81A41FE2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 315A17A5B52
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377DD23BCF6;
	Mon, 24 Feb 2025 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PooO8ZJY"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E402571CF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402297; cv=none; b=BvqvGY4Hv4vSxgLhWYOjsFzsHW4hnrx524jsK+fYPzMG5l0w0kSHG6r/c2Gws0xc+N6WXI9LnSQiJ7i869NY2lF/wAvob71tiaaKgYGbu7xjo8DNjQBYU+OuJJZcIT0y3xSFj3tdEHoEHRC78SjxyfT6T8ylhiz9euoLfvcU+j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402297; c=relaxed/simple;
	bh=aeJbpP93Y1z8MpbpEP69V+iXq6AGICxRhPz7Ucg8Se0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cFfW8xivtVmsCZMzy88NTwgmI/TLHzlyt0TVB3rMPCKYuQGyMXA0RvJHEGAY+bNQXQ+d4KuIJ8wXsPYHLphd9ODjMBjeWjK/QoclNYFliar9GffxBFxMb7q4uPZzCrIOZS3QT0irlcpQkAqR1n4ewOyr4On0wRIySSGouszYQKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PooO8ZJY; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3CE27442EE;
	Mon, 24 Feb 2025 13:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740402287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=roBH9oWEkyQyfNMu8ulIneLH8h7glRlD90iBFS/SXQU=;
	b=PooO8ZJYZ6z54HybfXhdt+nkx3hfoR41ANZDDPF62QwZ7rSa7AXfj4B4Fc6XWaEwPQwk6E
	lx943O9bT5ao1YQNdVk4kVPWeOFhEoZqUqfsXwdTeGHfmLipz0JJc4mQqsy2/AB1N4eyVh
	sV972Hqb2leXt+tgooxyCaKha9tZqf4YDj3+lfl9NHEZg4fFPpBYRQF98A4ZvS8+drxWhm
	jZYl/bwMVRAKjb6JV2xwSoHFYyWJWC8YyIOAOT7SZxJRZG9Yut/v0IfF2KwkRZejexCLef
	MkTR3mLrRqsd+caL8hGg3r2h7kgCN+sOmubPrUuWKpIkPHCPxy3WRwIC93f3Jw==
Date: Mon, 24 Feb 2025 14:04:43 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: <p.zabel@pengutronix.de>, <Steen.Hegelund@microchip.com>,
 <daniel.machon@microchip.com>, <UNGLinuxDriver@microchip.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] reset: mchp: sparx5: Fix for lan966x
Message-ID: <20250224140443.42ddc57c@bootlin.com>
In-Reply-To: <20250224092923.2648680-1-horatiu.vultur@microchip.com>
References: <20250224092923.2648680-1-horatiu.vultur@microchip.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeekhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthekredtredtjeenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeviefffeegiedtleelieeghfejleeuueevkeevteegffehledtkeegudeigffgvdenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepjedprhgtphhtthhopehhohhrrghtihhurdhvuhhlthhurhesmhhitghrohgthhhiphdrtghomhdprhgtphhtthhopehprdiirggsvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopefuthgvvghnrdfjvghgvghluhhnugesmhhitghrohgthhhiphdrtghomhdprhgtphhtthhopegurghnihgvlhdrmhgrtghhohhnsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtohepfgfpiffnihhnuhigf
 fhrihhvvghrsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: herve.codina@bootlin.com

Hi Horatiu,

On Mon, 24 Feb 2025 10:29:23 +0100
Horatiu Vultur <horatiu.vultur@microchip.com> wrote:

> With the blamed commit it seems that lan966x doesn't seem to boot
> anymore when the internal CPU is used.
> The reason seems to be the usage of the devm_of_iomap, if we replace
> this with of_iomap, this seems to fix the issue as we use the same
> region also for other devices.
> 
> Fixes: 0426a920d6269c ("reset: mchp: sparx5: Map cpu-syscon locally in case of LAN966x")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  drivers/reset/reset-microchip-sparx5.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset-microchip-sparx5.c
> index aa5464be7053b..5a75f9833a91a 100644
> --- a/drivers/reset/reset-microchip-sparx5.c
> +++ b/drivers/reset/reset-microchip-sparx5.c
> @@ -8,6 +8,7 @@
>   */
>  #include <linux/mfd/syscon.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
> @@ -72,14 +73,17 @@ static struct regmap *mchp_lan966x_syscon_to_regmap(struct device *dev,
>  						    struct device_node *syscon_np)
>  {
>  	struct regmap_config regmap_config = mchp_lan966x_syscon_regmap_config;
> -	resource_size_t size;
> +	struct resource res;
>  	void __iomem *base;
>  
> -	base = devm_of_iomap(dev, syscon_np, 0, &size);
> -	if (IS_ERR(base))
> -		return ERR_CAST(base);
> +	if (of_address_to_resource(syscon_np, 0, &res))
> +		return ERR_PTR(-ENOMEM);
>  
> -	regmap_config.max_register = size - 4;
> +	base = of_iomap(syscon_np, 0);
> +	if (!base)
> +		return ERR_PTR(-ENOMEM);
> +
> +	regmap_config.max_register =  resource_size(&res) - 4;
>  
>  	return devm_regmap_init_mmio(dev, base, &regmap_config);
>  }

In the Lan966x PCI device use case, the reset driver can be loaded, unloaded
and re-loaded.

When the driver is unloaded, resources have to be released and so with a
call to of_iomap(), a call to iounmap() is needed.

Maybe .remove() function in this driver should handle the needed iounmap()
call.

Best regards,
Hervé

