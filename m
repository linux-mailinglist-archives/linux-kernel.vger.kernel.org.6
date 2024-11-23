Return-Path: <linux-kernel+bounces-419234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6769D6B28
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 20:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E713A161C8E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 19:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55E919F101;
	Sat, 23 Nov 2024 19:37:14 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3B334545
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 19:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732390634; cv=none; b=CSxjdyZsSM3hQ1dqweGRnYO5sDBhClc/HLOz3DYxjJ+74xT0ksnSoscHIQF+BZMYd0PMZhlFXWWyfN01I9bqPjo00LiQZufwS8kQfaGbLDit6F0tzSzAL/a94Ln0j4a89YvL8krH7FIVrad6iI2G36bGn7UD5uMdhEOgSMzlYxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732390634; c=relaxed/simple;
	bh=4InhN3EJV5HAmDBFzgegujCf8BENyWDwohjfcGHHi1M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPmbFxhT3fHwhlFVd1lXh3/lDQsoDmg60/Ha15hSw40H7XQSLYT2smFGOMv0gXfQm0an/ou1uzBRLF+SFHisHBqGjJyVGkOQm8Juqq9wGJlsm6uqc7n2N6P+S97zc7zGWGvQ7tgfBg87kKrQsaOX4ywKJ2lkhZpTl1uzqm5lIlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-143.elisa-laajakaista.fi [88.113.25.143])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 541681c2-a9d2-11ef-9b92-005056bd6ce9;
	Sat, 23 Nov 2024 21:37:09 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 23 Nov 2024 21:37:08 +0200
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Gene Chen <gene_chen@richtek.com>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 08/18] leds: lm3532: switch to
 device_for_each_child_node_scoped()
Message-ID: <Z0Iu5Noc_-hTmNLE@surfacebook.localdomain>
References: <20240927-leds_device_for_each_child_node_scoped-v1-0-95c0614b38c8@gmail.com>
 <20240927-leds_device_for_each_child_node_scoped-v1-8-95c0614b38c8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927-leds_device_for_each_child_node_scoped-v1-8-95c0614b38c8@gmail.com>

Fri, Sep 27, 2024 at 01:20:59AM +0200, Javier Carrasco kirjoitti:
> Switch to device_for_each_child_node_scoped() to simplify the code by
> removing the need for calls to fwnode_handle_put() in the error paths.
> 
> This also prevents possible memory leaks if new error paths are added
> without the required call to fwnode_handle_put().
> 
> After switching to the scoped variant, there is no longer need for a
> jump to 'child_out', as an immediate return is possible.

...

>  		if (ret) {
>  			dev_err(&priv->client->dev, "reg property missing\n");
> -			goto child_out;
> +			return ret;

return dev_err_probe(...);

>  		}

...

>  		if (ret) {
>  			dev_err(&priv->client->dev, "ti,led-mode property missing\n");
> -			goto child_out;
> +			return ret;
>  		}

...

>  		if (ret) {
>  			dev_err(&priv->client->dev, "led-sources property missing\n");
> -			goto child_out;
> +			return ret;
>  		}

...

>  		if (ret) {
>  			dev_err(&priv->client->dev, "led register err: %d\n",
>  				ret);
> -			goto child_out;
> +			return ret;
>  		}
>  
>  		ret = lm3532_init_registers(led);
>  		if (ret) {
>  			dev_err(&priv->client->dev, "register init err: %d\n",
>  				ret);
> -			goto child_out;
> +			return ret;
>  		}

Ditto for all above.

-- 
With Best Regards,
Andy Shevchenko



