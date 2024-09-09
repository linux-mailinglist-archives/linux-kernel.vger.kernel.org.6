Return-Path: <linux-kernel+bounces-321603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF647971CB2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBA931C2311C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4CA1BAED7;
	Mon,  9 Sep 2024 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="j8HPmSac"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0B41BAEC1;
	Mon,  9 Sep 2024 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725892501; cv=none; b=SYwcpdh/s/7Kjz4mp4Cy8w+j88e9129dbq8DGrgOMHDhhmXdz+h/7uzkLRfxob1lQ1E1ixmuTUGulSbaK7pozo9z5sspovZPxWgPxTU60QaZb5YgHCp1BP6NpufpE5GrRuMfgI2ZBWsAWjM4axX8VVyiqtDDYl9XRyxksNcgDfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725892501; c=relaxed/simple;
	bh=JR7mVuP/HLm7Uxy2wFy1TzevZ/dAqqHKAUjEqc2b6j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCPwvuDm4Klk/usyELh2EJpca3daiL0qk9KxMzKPQSMw5pOVRT7pEYxDRwrjx6y8DX/STm0XzEKru3b5CAMCPHxMvSCAMHrym/xGTyMn3PEntK+6sFvjxCLaV3yrvAiI8u8911wu2VTLKjpUbChXTeZI/EoVHw1+xLAfZ1aktA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=j8HPmSac; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=aCGuW+FLeCS4jRJkgI3ipLVWMvNbMAX+bDvwRPIh/Ss=; b=j8
	HPmSacW3Hlxlti6Go5MfIz3s6Za7ZoRY/0+9owFmV8T6A4eu36cKs28VFcfIxa2eO8Kad6bu9R03n
	N0Y+hA/wMFSzpI30/Uy3wJGvKbisRE6FZUtLBKaQfDI3J1UyLlRUiFM2eROhLTaYWTUtM/P/kH3qa
	kKmIkKjRGHw7GPM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1snfTe-007179-TA; Mon, 09 Sep 2024 16:34:50 +0200
Date: Mon, 9 Sep 2024 16:34:50 +0200
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
Message-ID: <884103b1-e373-4446-b9fd-1cb06cd75360@lunn.ch>
References: <20240909133807.19403-1-adiupina@astralinux.ru>
 <e2d1e181-f094-4d6d-b77e-8d7c0ecd8270@lunn.ch>
 <6a563471-2268-40a3-9c95-2761bcea5e3c@astralinux.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a563471-2268-40a3-9c95-2761bcea5e3c@astralinux.ru>

On Mon, Sep 09, 2024 at 05:17:08PM +0300, Alexandra Diupina wrote:
> Hello, Andrew!
> 
> 
> 09/09/24 17:02, Andrew Lunn пишет:
> > On Mon, Sep 09, 2024 at 04:38:07PM +0300, Alexandra Diupina wrote:
> > > get_div() may return zero, so it is necessary to check
> > > before calling DIV_ROUND_UP_ULL().
> > > 
> > > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > > 
> > > Fixes: 8ca4746a78ab ("clk: mvebu: Add the peripheral clock driver for Armada 3700")
> > > Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
> > > ---
> > >   drivers/clk/mvebu/armada-37xx-periph.c | 5 ++++-
> > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
> > > index 8701a58a5804..d0e1d591e4f2 100644
> > > --- a/drivers/clk/mvebu/armada-37xx-periph.c
> > > +++ b/drivers/clk/mvebu/armada-37xx-periph.c
> > > @@ -343,7 +343,10 @@ static unsigned long clk_double_div_recalc_rate(struct clk_hw *hw,
> > >   	div = get_div(double_div->reg1, double_div->shift1);
> > >   	div *= get_div(double_div->reg2, double_div->shift2);
> > > -	return DIV_ROUND_UP_ULL((u64)parent_rate, div);
> > > +	if (!div)
> > > +		return 0;
> > Looking at this code, it seems to me some fundamental assumption has
> > gone wrong here, if the dividers are 0. We want to know about this,
> > and a kernel taking a / 0 exception would be a good way to indicate
> > something is very wrong. Won't returning 0 just hide the problem, not
> > make it obvious?
> > 
> > Checking for a /0 on user input makes a lot of sense, but here, i
> > think you are just hiding bugs. Please consider this when making
> > similar changes in other parts of the kernel. Why has a /0 happened?
> > 
> > Tools like SVACE just point at possible problems. You then need to
> > look at them in detail, understand the context, and decide on the
> > proper fix, which might actually be, a /0 is good.
> > 
> > 	Andrew
> 
> The value of div depends on double_div->reg1, double_div->reg2,
> double_div->shift1, double_div->shift2.
> The fields reg1, reg2, shift1, shift2 in the clk_double_div structure
> are filled using the PERIPH_DOUBLEDIV macro, which is called from the
> PERIPH_CLK_FULL_DD and PERIPH_CLK_MUX_DD macros (the last 4 arguments).
> 
> It is not clear what values can be contained in the registers at the
> addresses DIV_SEL0, DIV_SEL1, DIV_SEL2 (can readl() and some bit
> operations give a value > 6 in get_div()), so the final value of div can be
> zero.
> 
> I used just return 0, since the recalc_rate field in the clk_ops structure
> has a comment "If the driver cannot figure out a rate for this clock,
> it must return 0.".

This is the sort of explanation what should be placed into the commit
message. It explains the 'Why?' of the change you made, which you
cannot determine from looking at the change itself.

> I'll fix it to kernel exception, thanks for the tip.

So giving your explanation, i can see why you went for return 0. But i
guess that comment is actually about not being able to ask the
hardware what it is doing. In this case, we can ask it, but we are
getting non-sensible values from it. So i think we should be reporting
this somehow.

	Andrew

