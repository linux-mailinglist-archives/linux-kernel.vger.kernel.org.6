Return-Path: <linux-kernel+bounces-419231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B749D6B21
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 20:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D31CCB214FC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 19:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED946158DB1;
	Sat, 23 Nov 2024 19:34:26 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1198717C2
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732390466; cv=none; b=thAOAowbkspAFKzw58uMAlkkvG3nYsfnYQ236pV3lHZPn8vWC/FlKdYEsKhAkXro5hJX53Vzco6VZ8bBWhNtq9FCqiGHfQ8g6W9ebouGQwe6XH5SfN9IaPiwCw6aAaAHqzp/eaC4R6iq8KrqRICksKGKJOKc/pTaa2KKn9FKrF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732390466; c=relaxed/simple;
	bh=Bkz/cNpEJ9t9QnwiuZfv7m6p4TlZpRbwPIxkTGiaAMs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4WEJKPJHqDZJhJtVP8HIWPjW3h0zZJIxK3RNCde2ByVFpbo8r+rEZLsm5kY2B+HZNXoWh2UL4S8erWOyUMFELkl6VXf2OiqZPRzKnHQwvqeMg474B2PP/SAHzOBZJbFdxuGhFD30RKIriJGCZz0SywN4aTRGb8GRmUBK3tjVN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-143.elisa-laajakaista.fi [88.113.25.143])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id eb92df3f-a9d1-11ef-9b92-005056bd6ce9;
	Sat, 23 Nov 2024 21:34:14 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 23 Nov 2024 21:34:13 +0200
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
Subject: Re: [PATCH 06/18] leds: el15203000: switch to
 device_for_each_child_node_scoped()
Message-ID: <Z0IuNZq3g_0q0TkU@surfacebook.localdomain>
References: <20240927-leds_device_for_each_child_node_scoped-v1-0-95c0614b38c8@gmail.com>
 <20240927-leds_device_for_each_child_node_scoped-v1-6-95c0614b38c8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927-leds_device_for_each_child_node_scoped-v1-6-95c0614b38c8@gmail.com>

Fri, Sep 27, 2024 at 01:20:57AM +0200, Javier Carrasco kirjoitti:
> Switch to device_for_each_child_node_scoped() to simplify the code by
> removing the need for calls to fwnode_handle_put() in the error paths.
> 
> This also prevents possible memory leaks if new error paths are added
> without the required call to fwnode_handle_put().
> 
> After switching to the scoped variant, there is no longer need for a
> jump to 'err_child_out', as an immediate return is possible.

...

>  		if (ret) {
>  			dev_err(priv->dev, "LED without ID number");
> -			goto err_child_out;
> +			return ret;

Now

			return dev_err_probe(...);

>  		}
>  
>  		if (led->reg > U8_MAX) {
>  			dev_err(priv->dev, "LED value %d is invalid", led->reg);
> -			ret = -EINVAL;
> -			goto err_child_out;
> +			return -EINVAL;

Ditto.

>  		}

>  			dev_err(priv->dev,
>  				"failed to register LED device %s, err %d",
>  				led->ldev.name, ret);
> -			goto err_child_out;
> +			return ret;

Ditto.

			return dev_err_probe(priv->dev, ret, "failed to register LED device %s\n",
				led->ldev.name);

...

Also notice missed '\n' at the end of the strings (and yes, I know
that it's not a problem for dev_*() macros, but still...).

-- 
With Best Regards,
Andy Shevchenko



