Return-Path: <linux-kernel+bounces-419228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FF39D6B1B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 20:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85D4EB21814
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 19:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDA216130C;
	Sat, 23 Nov 2024 19:30:52 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1979534545
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732390251; cv=none; b=tt+Wes/uWQqOoAtkn+A/UQrXExiLw5Pv2h/jU1Lz6wyHkDLyoNYIGFUxMfcf3bj0fBf7Bo8Mup7fTeRVNK5binwbfaDfzYpHii5q+VazANfnAa8GxeaBXjqgAmeXJb4yGIjD9GFR0cqUyZ6AAvu+CaR8ceV6vzP1uby1bOXf7a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732390251; c=relaxed/simple;
	bh=JC17rw+Hom8wSugYzI6RuOxpLgvkttMfUDPyeAFCHIE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sj0941J5uU3/hxBBZLxPxTnp+uWusc4k3dCws1nu0KAIV0vMprIo0sKojvKjozjM6wOBQ1QuIKvKeZzu00KGUkSRj3G9ViLTErqNPPExsjqE9YCA6NFyLR0yk4gIMEMp1WmYX2/oJ7Zfpfu+wUZ7Gqv848Y491OkKK0OadO63Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-143.elisa-laajakaista.fi [88.113.25.143])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 470d06ed-a9d1-11ef-9b92-005056bd6ce9;
	Sat, 23 Nov 2024 21:29:39 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 23 Nov 2024 21:29:37 +0200
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
	linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH 00/18] leds: switch to device_for_each_child_node_scoped()
Message-ID: <Z0ItIQWHOGL-GTi8@surfacebook.localdomain>
References: <20240927-leds_device_for_each_child_node_scoped-v1-0-95c0614b38c8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927-leds_device_for_each_child_node_scoped-v1-0-95c0614b38c8@gmail.com>

Fri, Sep 27, 2024 at 01:20:51AM +0200, Javier Carrasco kirjoitti:
> This series switches from the device_for_each_child_node() macro to its
> scoped variant, which in general makes the code more robust if new early
> exits are added to the loops, because there is no need for explicit
> calls to fwnode_handle_put(). Depending on the complexity of the loop
> and its error handling, the code gets simplified and it gets easier to
> follow.
> 
> The non-scoped variant of the macro is error-prone, and it has been the
> source of multiple bugs where the child node refcount was not
> decremented accordingly in error paths within the loops. The first patch
> of this series is a good example, which fixes that kind of bug that is
> regularly found in node iterators.
> 
> The uses of device_for_each_child_node() with no early exits have been
> left untouched because their simpilicty justifies the non-scoped
> variant.
> 
> Note that the child node is now declared in the macro, and therefore the
> explicit declaration is no longer required.
> 
> The general functionality should not be affected by this modification.
> If functional changes are found, please report them back as errors.


Thank you for this series. It may now benefit from the next steps:

1) converting to return dev_err_probe() or dev_warn_probe() directly since
   the goto had been replaced by direct return, hence saving even more LoCs;

2) dropping or refactoring the complex conditions due to your nice series
   being applied.

I'll comment individually on some to show what I meant by the above.

-- 
With Best Regards,
Andy Shevchenko



