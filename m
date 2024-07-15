Return-Path: <linux-kernel+bounces-253122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD60E931CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 23:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B3C61C21777
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BFB13C9CD;
	Mon, 15 Jul 2024 21:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EO2E4WTb"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F064C7C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 21:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721080079; cv=none; b=vFfYLwkQ6ZiFp/g8QO90BviHf4/dhGbtiZrT5ueW9HYpjWNaPrAX/IuyUqnMoSuB5GLUpTTllUUzYGotqlQAf45fW2QKMYqRRShjLFxNeDrwP+uOWvD89619U2AHwQCYqD1WOGOfDLogxX4KYDE1ypc8kTGl/iqkjnEE1J3ECNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721080079; c=relaxed/simple;
	bh=e8x0AAwagO1VoBCMYHgYP+2/2jtjfDYdJ7BvkEQJca8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4i9bpoi6+lajcPYRGMHLO23mXETygrFa49h+W3tnEjyNG1uYQ+Vx36O9GGPexMTjG5tNqwi30gyjpzmECVXzFtmr4ypRLAfzfEJUp4gLMcADJsztFfOLyBKEqBbQ7HxNKPubkYDCF6PDbXjculg2b3XULfPPNws6v8F+1WvZ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EO2E4WTb; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1A512FF803;
	Mon, 15 Jul 2024 21:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721080075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zZWHkYAhmm9sap+J3m50GOaykeOKhvg1nFAevKjiahE=;
	b=EO2E4WTbupa83xHEnq53afDnng5ZMjRjBt0Fja4Ee/I8H8GQDkax7ZNMYiodBEW3627ytD
	ldADDuGtYQofJIfLimQHDfKQP21dps3igSPrrzRamSzxoX+IFLNZ325+T0AU5xnTBlQyWD
	2PwTiQJayzq9gNOSHF/XJEwhsoJuRWhgcXk0CPAgE8NxfjB+w5zjBDI46EgK0/RQQg/H+0
	dN3gExhzkGY8hMGVqjU8ilqQ72PLy6Iwl24o84EuxeP9wNCiRHplE8aWhkDfBwCcvB2wiF
	nZ1Cwbr7BtyJlDEy493sSxE480atHkOwu1gSb8bHPiIZmMJpzvpCTdcgBTMFAQ==
Date: Mon, 15 Jul 2024 23:47:53 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Aniket <aniketmaurya@google.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	vamshigajjela@google.com
Subject: Re: [PATCH 0/3] i3c: dw: Add support for power management
Message-ID: <172108005329.1453338.15447064873136258175.b4-ty@bootlin.com>
References: <20240708062103.3296587-1-aniketmaurya@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708062103.3296587-1-aniketmaurya@google.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Mon, 08 Jul 2024 06:21:00 +0000, Aniket wrote:
> These patches add pm support for the dw i3c controller.
> Controller registers that can be lost are saved and restored during resume.
> Clocks, resets and pads are put in their relevant state during suspend and resume.
> For runtime pm, power is resumed and later suspended for the xfer/IBI APIs.
> 
> Aniket (3):
>   i3c: dw: Save timing registers and other values
>   i3c: dw: Add some functions for reusability
>   i3c: dw: Add power management support
> 
> [...]

Applied, thanks!

[1/3] i3c: dw: Save timing registers and other values
      https://git.kernel.org/abelloni/c/e88def6d757d
[2/3] i3c: dw: Add some functions for reusability
      https://git.kernel.org/abelloni/c/2ab158e0ab28
[3/3] i3c: dw: Add power management support
      https://git.kernel.org/abelloni/c/56e697d7dc6d

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

