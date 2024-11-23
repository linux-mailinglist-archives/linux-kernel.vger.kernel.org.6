Return-Path: <linux-kernel+bounces-419241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FB19D6B3E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 20:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61FF2161D5B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 19:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E4819F13C;
	Sat, 23 Nov 2024 19:46:02 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3D619E961
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 19:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732391162; cv=none; b=GNQChaSa2N2BdUi7gW2SU/8uGtNGZ0cAVKtdPHoxuIEry5P8CrQQ1oZ3M/cLziHoWrGkjDL+WtKkQ+Xe+pfSyXmUIwKcbmQU+7Q48uVtFUrJmGg0wTsm1jUfO6pyzplaEw3WyrXR1xTOTIMUYXCiRnq4MqWtD3jblMonFeQZRQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732391162; c=relaxed/simple;
	bh=JGbbr/jKwz0H0T6gVm+rr13HbI3X/GF/QKdo2VRJGx0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1hKQ7nB+YG+2oscs7ACh1lfAoALMzPol5lqwZywZ/InSMJ8C4jjtyaCHoZ7wIzsgCaA5h4gxGlUwLpd+mc0KBBokrNmqM9QhPR+lFujmEjAiOzJmHKk+KwJ/e+3tTqTjrQecMCz1eVnLAq3Jow76QK2hQubWcBfqRFWpHRqDDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-143.elisa-laajakaista.fi [88.113.25.143])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 8b65e59b-a9d3-11ef-8881-005056bdd08f;
	Sat, 23 Nov 2024 21:45:53 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 23 Nov 2024 21:45:51 +0200
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
Subject: Re: [PATCH 13/18] leds: pca963x: switch to
 device_for_each_child_node_scoped()
Message-ID: <Z0Iw77gpGgIE6fLT@surfacebook.localdomain>
References: <20240927-leds_device_for_each_child_node_scoped-v1-0-95c0614b38c8@gmail.com>
 <20240927-leds_device_for_each_child_node_scoped-v1-13-95c0614b38c8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927-leds_device_for_each_child_node_scoped-v1-13-95c0614b38c8@gmail.com>

Fri, Sep 27, 2024 at 01:21:04AM +0200, Javier Carrasco kirjoitti:
> Switch to device_for_each_child_node_scoped() to simplify the code by
> removing the need for calls to fwnode_handle_put() in the error paths.
> 
> This also prevents possible memory leaks if new error paths are added
> without the required call to fwnode_handle_put().
> 
> After switching to the scoped variant, there is no longer need for a
> jump to 'err', as an immediate return is possible.

...

>  		if (ret || reg >= chipdef->n_leds) {
>  			dev_err(dev, "Invalid 'reg' property for node %pfw\n",
>  				child);
> -			ret = -EINVAL;
> -			goto err;
> +			return -EINVAL;
>  		}

I'm not sure how interpret this message, but the problem here is the shadowing
of the original error code. Hence I would split this:

		if (ret)
			return ret; // possibly return dev_err_probe() with another message
		if (reg >= chipdef->n_leds)
			return dev_err_probe(dev, -EINVAL, "Invalid 'reg' property for node %pfw\n",
					     child);

...

>  		if (ret) {
>  			dev_err(dev, "Failed to register LED for node %pfw\n",
>  				child);
> -			goto err;
> +			return ret;

			return dev_err_probe(...);

>  		}

-- 
With Best Regards,
Andy Shevchenko



