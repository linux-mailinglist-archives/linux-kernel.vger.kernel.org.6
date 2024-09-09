Return-Path: <linux-kernel+bounces-321562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A1C971C0C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BB81C2312F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16A81BA268;
	Mon,  9 Sep 2024 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UBzoAhqW"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707F822095;
	Mon,  9 Sep 2024 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725890539; cv=none; b=Y9nD3VuC+IjlHjDI0lmL+sZHFjk4FbmV9up3VGxq8ASrD21H28SFSHzSN9yp1YCmt74OOJ2nJK3ZtNLLRdhg316L8+unXkXdA6LpObIqJR50NFCZYJEwpTecSXx1acuiIJkfaGLO0AlXGG+ENfNdbnEKDex9CX1w80W5H37L7UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725890539; c=relaxed/simple;
	bh=xum1qOjhia15louJx6W5b4NX406RjIXWWRyiJhR8ls8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJSzYdfQu6oy0lJ7AfWk59t+wDwGUFNHIsoC2RKzEswQCytymXqbpR6w7T9wqE3WRnUDvkVX/8AUfrruLsppiOVAA94Oe9gius6+H4odXzXGo9tDIeYFe20V28UzAdWYm6rinzJJr8Q82FvyR0stz6uPPa2rcflvULs4G4pjFIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UBzoAhqW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=12agmP5MPf/vordx5z3gGnxZlErbDBTiMxQw78nVX/Y=; b=UBzoAhqWincIFyUxJgKzrUfjcg
	ZU+AMbT4Vx0J5Vo31ZK1f+b3uFLa2Z+3OnQVlAC0CTyf5wjjA7F5sBKwLRkeaHOEh2VRC7mDHLc67
	hf4GK7fEhnq8/yiGnSTSaReRJ/gZp2458BfydvtFe1JjMRR9UqDQaFr1QtaIeF51g1Zw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1snexy-0070sm-7q; Mon, 09 Sep 2024 16:02:06 +0200
Date: Mon, 9 Sep 2024 16:02:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexandra Diupina <adiupina@astralinux.ru>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] clk: mvebu: Prevent division by zero in
 clk_double_div_recalc_rate()
Message-ID: <e2d1e181-f094-4d6d-b77e-8d7c0ecd8270@lunn.ch>
References: <20240909133807.19403-1-adiupina@astralinux.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909133807.19403-1-adiupina@astralinux.ru>

On Mon, Sep 09, 2024 at 04:38:07PM +0300, Alexandra Diupina wrote:
> get_div() may return zero, so it is necessary to check
> before calling DIV_ROUND_UP_ULL().
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 8ca4746a78ab ("clk: mvebu: Add the peripheral clock driver for Armada 3700")
> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
> ---
>  drivers/clk/mvebu/armada-37xx-periph.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
> index 8701a58a5804..d0e1d591e4f2 100644
> --- a/drivers/clk/mvebu/armada-37xx-periph.c
> +++ b/drivers/clk/mvebu/armada-37xx-periph.c
> @@ -343,7 +343,10 @@ static unsigned long clk_double_div_recalc_rate(struct clk_hw *hw,
>  	div = get_div(double_div->reg1, double_div->shift1);
>  	div *= get_div(double_div->reg2, double_div->shift2);
>  
> -	return DIV_ROUND_UP_ULL((u64)parent_rate, div);
> +	if (!div)
> +		return 0;

Looking at this code, it seems to me some fundamental assumption has
gone wrong here, if the dividers are 0. We want to know about this,
and a kernel taking a / 0 exception would be a good way to indicate
something is very wrong. Won't returning 0 just hide the problem, not
make it obvious?

Checking for a /0 on user input makes a lot of sense, but here, i
think you are just hiding bugs. Please consider this when making
similar changes in other parts of the kernel. Why has a /0 happened?

Tools like SVACE just point at possible problems. You then need to
look at them in detail, understand the context, and decide on the
proper fix, which might actually be, a /0 is good.

	Andrew

