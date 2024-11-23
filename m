Return-Path: <linux-kernel+bounces-419243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380939D6B43
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 20:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF50E1619E4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 19:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3855B176251;
	Sat, 23 Nov 2024 19:47:47 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B756F099
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 19:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732391266; cv=none; b=p6pHGVlMI97j46OaloKdIMlR2aLXkNFb0kNWGu62Y6gXyvQuyBatgISaXjTvIsbDwK3Sjz/BBNqpZEAKQnZve388AOs2SNTm+7vOzTj0Jj5FsoN6EWjXKV8+DVa40bCW/6YcoIdxIUsF1HUXSmpmxbjI7RvGYfJHKZBnrzW1GTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732391266; c=relaxed/simple;
	bh=m2qLnqDWjiQs3VDlXncJpshue+oltGe7BCDFQj8lFzc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5pzOOx1nte+ifQLyFiAGw3UIcac30qp6HutyxgmUHMrMZxNQJXXDcDPr2bMOVYBaSJQvjkEOTeL3FZ/gGfUiXpWqfju+r7wBmKOt5wYna0DB1J2Gm+YEZRxxFqxbs+9qtj+X7Jz5/kLgsrjEMTqDO/hBRQ5r7IUgpmdAh9KbOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-143.elisa-laajakaista.fi [88.113.25.143])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id cada6636-a9d3-11ef-a0f6-005056bdfda7;
	Sat, 23 Nov 2024 21:47:38 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 23 Nov 2024 21:47:37 +0200
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
Subject: Re: [PATCH 11/18] leds: max77650: switch to
 device_for_each_child_node_scoped()
Message-ID: <Z0IxWdV8ZWhJ5Pp4@surfacebook.localdomain>
References: <20240927-leds_device_for_each_child_node_scoped-v1-0-95c0614b38c8@gmail.com>
 <20240927-leds_device_for_each_child_node_scoped-v1-11-95c0614b38c8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927-leds_device_for_each_child_node_scoped-v1-11-95c0614b38c8@gmail.com>

Fri, Sep 27, 2024 at 01:21:02AM +0200, Javier Carrasco kirjoitti:
> Switch to device_for_each_child_node_scoped() to simplify the code by
> removing the need for calls to fwnode_handle_put() in the error paths.
> 
> This also prevents possible memory leaks if new error paths are added
> without the required call to fwnode_handle_put().
> 
> After switching to the scoped variant, there is no longer need for a
> jump to 'err_node_out', as an immediate return is possible.

...

>  		rv = fwnode_property_read_u32(child, "reg", &reg);
> -		if (rv || reg >= MAX77650_LED_NUM_LEDS) {
> -			rv = -EINVAL;
> -			goto err_node_put;
> -		}
> +		if (rv || reg >= MAX77650_LED_NUM_LEDS)
> +			return -EINVAL;

Again (yes, I know that is original issue, but with your series applied
it may be nicely resolved), shadowing error code. Should be

		if (rv)
			return rv;
		if (reg >= MAX77650_LED_NUM_LEDS)
			return -EINVAL;

-- 
With Best Regards,
Andy Shevchenko



