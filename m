Return-Path: <linux-kernel+bounces-323748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7319D9742DE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37206286E3C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625FD1A7051;
	Tue, 10 Sep 2024 18:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="s4/P31pr"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C76B1A0708;
	Tue, 10 Sep 2024 18:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994757; cv=none; b=lYGCzaUNL0hlWNvymdQmGYfohqU8xw6/3+p0ceWIo+qCFNJQAQZJVw0q4jiQySoZepsfpejVTeu8Odl/4fj5m2+DqhuMkm2sScvI/tA9x/renxuJZSGEFTOXXtJ3x2y4YAD+JDTZNQ+O/TuL+iGUF10Spg04TBa58Mp4c1mh/U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994757; c=relaxed/simple;
	bh=f2gKhhCaAZOrRih/26d2mAxc09wPg7jwSjHQwbCur1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyyGYomdZL7cPTtay+q+K+dRO/3r8REOo42RQyITa3eTm42A+SbNpdqkEibNF27b83bx8+AEMyHrPHdKI092eDqI2HxMf+Ik3jbeJ8mYOynAbVO5yyvzNOMwAyYo3NyTA4TpyzxUz9ul3i8Hcbx4wB/kR4MYp2O6melIcU6i3gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=s4/P31pr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=faIiyJTdeUZNcnYDzrYg0JikXUSOkAxYS32UaSWmdlE=; b=s4/P31prm7EKsDTXjw1Y8d1/aM
	5f5OUfyiksMzg9/VMCYuTkfiTPc+MB0QV2VCs5X+rH83DbXlVDKkfKc/9lbm0QXT0GBxjceDDJm6w
	UBJVuBOOJ4R2thDbVP+2eOuES8x4isrTOIz9NiiXRWZv/axiEh5YNpTElyoaxgl3wjqE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1so64s-0078Yb-Mc; Tue, 10 Sep 2024 20:59:02 +0200
Date: Tue, 10 Sep 2024 20:59:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexandra Diupina <adiupina@astralinux.ru>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] clk: mvebu: Prevent division by zero in
 clk_double_div_recalc_rate()
Message-ID: <82162974-00b5-44c9-bbb8-701e6c871bb0@lunn.ch>
References: <884103b1-e373-4446-b9fd-1cb06cd75360@lunn.ch>
 <20240910173110.31944-1-adiupina@astralinux.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910173110.31944-1-adiupina@astralinux.ru>

On Tue, Sep 10, 2024 at 08:31:10PM +0300, Alexandra Diupina wrote:
> get_div() may return zero, so it is necessary to check
> before calling DIV_ROUND_UP_ULL().
> 
> Return value of get_div() depends on reg1, reg2, shift1, shift2
> fields of clk_double_div structure which are filled using the
> PERIPH_DOUBLEDIV macro. This macro is called from the
> PERIPH_CLK_FULL_DD and PERIPH_CLK_MUX_DD macros (the last 4 arguments).
> 
> It is not known exactly what values can be contained in the registers
> at the addresses DIV_SEL0, DIV_SEL1, DIV_SEL2, so the final value of
> div can be zero. Print an error message and return 0 in this case.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 8ca4746a78ab ("clk: mvebu: Add the peripheral clock driver for Armada 3700")
> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
> ---
> v2: added explanations to the commit message and printing 
> of an error message when div==0
>  drivers/clk/mvebu/armada-37xx-periph.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
> index 8701a58a5804..8e749a354ffc 100644
> --- a/drivers/clk/mvebu/armada-37xx-periph.c
> +++ b/drivers/clk/mvebu/armada-37xx-periph.c
> @@ -343,7 +343,13 @@ static unsigned long clk_double_div_recalc_rate(struct clk_hw *hw,
>  	div = get_div(double_div->reg1, double_div->shift1);
>  	div *= get_div(double_div->reg2, double_div->shift2);
>  
> -	return DIV_ROUND_UP_ULL((u64)parent_rate, div);
> +	if (!div) {
> +		pr_err("Can't recalculate the rate of clock %s\n",
> +										hw->init->name);

Rather odd indentation!

It is too late for this merge window. Please fix this and repost on
top of 6.12-rc1.

Thanks
	Andrew

