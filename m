Return-Path: <linux-kernel+bounces-419236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C119D6B2D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 20:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A021161D2D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 19:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B14F17BB16;
	Sat, 23 Nov 2024 19:40:19 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F4919ABDE
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 19:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732390818; cv=none; b=Xyl9f2RBcGhhNa9WUiqNAutFwv0l2c5Q25P4x8dmEia4/KRuuMhzsaP4nYj7uLne5Sds4Nq8FDA4TcxXltcDqd29fiqBsvlrFWqhdFgIOn9lxIJ29L5TUMbKBzy7+wO7PhUBytUVD/4kAjlNzmaQBqv8Hnmt/NyIjwh51PKkYhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732390818; c=relaxed/simple;
	bh=tGySL+pnLhkfRyCkkOyfazm2HL3pcZogECrnTG3uD6A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtlJuv6V3vaZVWsMg239//1TFpNJ8HeGZIcEE+fvBlotMk59MvMCEhj4jyPs4CwCOzCyJwGt91MlH26k/9FIxrbcPxj2/pheLal2SuSRRwBwwRWsaU3OOJfPUJkJCkQw9js5zhgJrU4tH+p0pvbVbD0uHmqPrTuKCbQJ45/MlME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-143.elisa-laajakaista.fi [88.113.25.143])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id bd3dc34a-a9d2-11ef-a0f6-005056bdfda7;
	Sat, 23 Nov 2024 21:40:06 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 23 Nov 2024 21:40:05 +0200
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
Subject: Re: [PATCH 16/18] leds: tca6507: switch to
 device_for_each_child_node_scoped()
Message-ID: <Z0IvleO2ag1ktM4c@surfacebook.localdomain>
References: <20240927-leds_device_for_each_child_node_scoped-v1-0-95c0614b38c8@gmail.com>
 <20240927-leds_device_for_each_child_node_scoped-v1-16-95c0614b38c8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927-leds_device_for_each_child_node_scoped-v1-16-95c0614b38c8@gmail.com>

Fri, Sep 27, 2024 at 01:21:07AM +0200, Javier Carrasco kirjoitti:
> Switch to device_for_each_child_node_scoped() to simplify the code by
> removing the need for calls to fwnode_handle_put() in the error path.
> 
> This also prevents possible memory leaks if new error paths are added
> without the required call to fwnode_handle_put().

...

>  		ret = fwnode_property_read_u32(child, "reg", &reg);
> -		if (ret || reg >= NUM_LEDS) {
> -			fwnode_handle_put(child);
> +		if (ret || reg >= NUM_LEDS)
>  			return ERR_PTR(ret ? : -EINVAL);
> -		}

It's now two nested conditionals instead of two independent ones:

		if (ret)
			return ERR_PTR(ret);
		if (reg >= NUM_LEDS)
			return ERR_PTR(-EINVAL);

I believe my wariant is much better to read, understand, and maintain.

-- 
With Best Regards,
Andy Shevchenko



