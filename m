Return-Path: <linux-kernel+bounces-419238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 695749D6B32
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 20:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0800FB2282D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 19:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA75C1990D3;
	Sat, 23 Nov 2024 19:42:03 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C356170A37
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 19:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732390923; cv=none; b=JzsacgZ1IGR7BFo7xDhRQ2W4+ej+kFusQ9Jy1aaJHfho42WUwUDql5wb0hWboE+IuOl1M8nwXvx2nvak+eISrHrcUTTIiakbx8pLaIqB43up8OcmQWZMRelDtI3ZooCsGSVltyetW/8SdXZob0po2CE3Hxg8mxVypN+cNrzRdyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732390923; c=relaxed/simple;
	bh=aoQY2AU7Sy7wBQvaEt255nidnwU9PNtGmfIdrAuRdOM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QILgIgDqFUF6Uaa4tMQSfnRQgRFo5Lw5+3xsM/49eTnw0LKppf+myQOv9qges7MBSweZaarezsO98C5oUl6wnVcQ/9CkCiPhYlNn28nmhiWrane/FeMUlH1iPjE2GUBTJK6Kt/tofHwCMyMuNo+5mMtSf8Hqxhs2wJ/4IX78WVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-143.elisa-laajakaista.fi [88.113.25.143])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id fe29a33f-a9d2-11ef-827a-005056bdf889;
	Sat, 23 Nov 2024 21:41:54 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 23 Nov 2024 21:41:54 +0200
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
Subject: Re: [PATCH 15/18] leds: sun50i-a100: switch to
 device_for_each_child_node_scoped()
Message-ID: <Z0IwAug906PT4Db_@surfacebook.localdomain>
References: <20240927-leds_device_for_each_child_node_scoped-v1-0-95c0614b38c8@gmail.com>
 <20240927-leds_device_for_each_child_node_scoped-v1-15-95c0614b38c8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927-leds_device_for_each_child_node_scoped-v1-15-95c0614b38c8@gmail.com>

Fri, Sep 27, 2024 at 01:21:06AM +0200, Javier Carrasco kirjoitti:
> Switch to device_for_each_child_node_scoped() to simplify the code by
> removing the need for calls to fwnode_handle_put() in the error paths.
> 
> This also prevents possible memory leaks if new error paths are added
> without the required call to fwnode_handle_put().
> 
> The error handling after 'err_put_child' has been moved to the only goto
> that jumps to it (second device_for_each_child_node()), and the call to
> fwnode_handle_put() has been removed accordingly.

...

>  		ret = fwnode_property_read_u32(child, "reg", &addr);
> -		if (ret || addr >= LEDC_MAX_LEDS) {
> -			fwnode_handle_put(child);
> +		if (ret || addr >= LEDC_MAX_LEDS)
>  			return dev_err_probe(dev, -EINVAL, "'reg' must be between 0 and %d\n",
>  					     LEDC_MAX_LEDS - 1);
> -		}

This is a misleading message, what should be done is to split them:

		if (ret)
			reutrn ret;
		if (addr >= LEDC_MAX_LEDS)
			return dev_err_probe(dev, -EINVAL, "'reg' must be between 0 and %d\n",
					     LEDC_MAX_LEDS - 1);


>  		ret = fwnode_property_read_u32(child, "color", &color);
> -		if (ret || color != LED_COLOR_ID_RGB) {
> -			fwnode_handle_put(child);
> +		if (ret || color != LED_COLOR_ID_RGB)
>  			return dev_err_probe(dev, -EINVAL, "'color' must be LED_COLOR_ID_RGB\n");
> -		}

Ditto.

-- 
With Best Regards,
Andy Shevchenko



