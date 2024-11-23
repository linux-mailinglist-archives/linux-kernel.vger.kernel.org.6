Return-Path: <linux-kernel+bounces-419229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846809D6B1D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 20:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 167E2B21883
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 19:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80072158DB1;
	Sat, 23 Nov 2024 19:31:20 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D80234545
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 19:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732390280; cv=none; b=LFLWIgVrUfPBT0zarMVX1iVlC9Dl/39Hb/kaJ+Whz2dbeKbB149nWUriVBtDBpUrbI7d+lif652wsHS1XyXnVOoHm42wh7aWYr187F4gaRqv7G09VvLbPtasV54Owg4Sl+ZQJfrtnEtg33ndV2F/u3leEL3545Z6n3rJ9Xo3vNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732390280; c=relaxed/simple;
	bh=P1KP/fPFkvXX93KvT9oa5A3AdRz2S6c4UvfDgvXUOI4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRKQ+/f5qE34+gn9Bjsvcm+T9LXIOgaAJVJue4k4al7Khl2+GtC2ngNqjtDIIqt3j+wmpDxoK3BP2Tjjaf8ohDP2NpVugjgeKBDsXOzlrzv9CWMmMbS2hFugP2ARnsaKzxY/wWhKBxcPCueehk8fZZN+Dct352RQkuGw5AEVrHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-143.elisa-laajakaista.fi [88.113.25.143])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 79edaa06-a9d1-11ef-a0f6-005056bdfda7;
	Sat, 23 Nov 2024 21:31:05 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 23 Nov 2024 21:31:02 +0200
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
Subject: Re: [PATCH 05/18] leds: cr0014114: switch to
 device_for_each_child_node_scoped()
Message-ID: <Z0ItdptZujS97zKl@surfacebook.localdomain>
References: <20240927-leds_device_for_each_child_node_scoped-v1-0-95c0614b38c8@gmail.com>
 <20240927-leds_device_for_each_child_node_scoped-v1-5-95c0614b38c8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927-leds_device_for_each_child_node_scoped-v1-5-95c0614b38c8@gmail.com>

Fri, Sep 27, 2024 at 01:20:56AM +0200, Javier Carrasco kirjoitti:
> Switch to device_for_each_child_node_scoped() to simplify the code by
> removing the need for calls to fwnode_handle_put() in the error paths.
> 
> This also prevents possible memory leaks if new error paths are added
> without the required call to fwnode_handle_put().

...

>  		if (ret) {
>  			dev_err(priv->dev,
>  				"failed to register LED device, err %d", ret);
> -			fwnode_handle_put(child);
>  			return ret;

Now it can be
			return dev_err_probe(..., ret, "failed to register LED device");

>  		}

-- 
With Best Regards,
Andy Shevchenko



