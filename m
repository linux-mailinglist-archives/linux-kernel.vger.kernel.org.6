Return-Path: <linux-kernel+bounces-512593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 095DFA33B4E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93D261887ED0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A52720D519;
	Thu, 13 Feb 2025 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaPSrG40"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619352054EF;
	Thu, 13 Feb 2025 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739439378; cv=none; b=piaQ6nAEgCNwmbfED0JIi9GtAdqtNrToRWsu8xQrM60QCBJrddYx0SUGJqnyLOFtwne87RfC9MNSyTwd/eurPTwu7GiZdJGecN+XxLi1V6wkLsly8F3Tjn/neJJQOaQwGtJujDpsVFbnaTWG7rLS8C70A7rs7BUSR5vhdThaH1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739439378; c=relaxed/simple;
	bh=7cEt5u5kQjq4ePsUu3Q9YuiaW7v/yXvzIyRh97OcetA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDN65k6Qw45aGRrCE+iUGTUTitANus6obubccJsolb1DTZ39/ivneJfu292Wf2OnapDGsTUQSDQ4Az+9wCmwmA/KRtblTlKNzR0du0nSaf8RUAKiSETZ++iaFgxnq4cjw5/T7cF/Ks8y1XH0Ap43SYWRlIW0J9TULZF6bAn3mnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uaPSrG40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497EBC4CED1;
	Thu, 13 Feb 2025 09:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739439376;
	bh=7cEt5u5kQjq4ePsUu3Q9YuiaW7v/yXvzIyRh97OcetA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uaPSrG404MU1KSC/rKlprzaUBOy9BQ/Y2JiMy1lD8Etp/L4qWmJWc1u8ZnZ0Hgxnk
	 9+Il+7BKOZMzZVBWKXTV61uHAXbhQYbFToWhrooxRZBXqhSShy17oJ/0eK+1EjRZMc
	 bNq1zD5tEp9pnpY8yIqvokfE2/9hXpXszrhYKJFBmVxZc/dnIwkGWOMaRvrVF5M0lt
	 VnyXNeIEwhDW7VIhAE5QMuWZsVWKn3YmBVimAVpCmofBVsJaeBjThzxzfcMiXkwH29
	 /okxu89LC4UI7aY6NvboXLtWxzg/w2PyuRRrCqp8v2og39G2zK8/QL1fSlOngGXFHl
	 Boo7gHYmINS+A==
Date: Thu, 13 Feb 2025 10:36:14 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 2/4] reset: simple: add support generic reset-simple
 device
Message-ID: <20250213-laughing-oarfish-of-opportunity-a575c5@krzk-bin>
References: <20250213020900.745551-1-inochiama@gmail.com>
 <20250213020900.745551-3-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250213020900.745551-3-inochiama@gmail.com>

On Thu, Feb 13, 2025 at 10:08:55AM +0800, Inochi Amaoto wrote:
> Add support for generic bit reset device.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  drivers/reset/reset-simple.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
> index 276067839830..a24f8fcc6a06 100644
> --- a/drivers/reset/reset-simple.c
> +++ b/drivers/reset/reset-simple.c
> @@ -148,6 +148,9 @@ static const struct of_device_id reset_simple_dt_ids[] = {
>  		.data = &reset_simple_active_low },
>  	{ .compatible = "brcm,bcm4908-misc-pcie-reset",
>  		.data = &reset_simple_active_low },
> +	{ .compatible = "reset-simple-high" },
> +	{ .compatible = "reset-simple-low",
> +		.data = &reset_simple_active_low },

So what is the point of the binding?

Best regards,
Krzysztof


