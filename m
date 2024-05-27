Return-Path: <linux-kernel+bounces-190683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5F58D0157
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64FE1F214CD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF18815EFA6;
	Mon, 27 May 2024 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jz69g/WA"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0109015ECEE;
	Mon, 27 May 2024 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816284; cv=none; b=qrrBLG+8I5cMotipy34rv3/UFb+901rA0UNhsSYXb4ekysXtDTAS3hlZYwiCugHi70Dw+66oUowQPiCC7LYHATPQ9YgJk5yxjeoyEb1Ub4jPlFeFWceA48KbPuPR1/rCS2aGfX9jo5s5nXqK1toQVQfXsWoCYfo5JgfyKw42acw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816284; c=relaxed/simple;
	bh=D6M0PlOsQaPe3TXGh+uEF0R7S6txV/OPg4LUJTirjEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4saaYY59UdvcTING0hS6w4TqoykKMaHDAfUgDOrzyl1UCyiNzF3EkldBeTVpbskDgoJOGONT5GaJqNYkoiJgZQhy1JOW+GMnW0iWNyvHjwFqOWmpjMOdyno1OUg3AK0kFx/KOTMoD5am8GKaegHoDH1gZ+qeQadN7hD4gsYn1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jz69g/WA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=n1ipnm3Y455WZMPj6tDeABCvoBv8BPrn9gR9rhHmizM=; b=jz69g/WAk1zi5MWpS5PjDaExwf
	uCZ84JlHFB4CH01TKTRVdNHLxv16w42RpemLfu3aMB3CI7ZW7g9qYV6kmdKAOT0pmPPdPMG3SKIMC
	GOL4GD3F7ovWTPlZ1mkaV8LII52QiAXAOQJIFY1tlAAM8A9kDtcXSQVA6Y9vx+/BEsbo9FJb53wOi
	0jbkyx6j9vOdahtbDwupatB+H3WApVG4/94vpCEQIsmR1QIKup4/6O+MgMtOWu5K7FWnv8CkpS53u
	wD5bWiN31mGgQlXukQovhHf+Cp+00ir8lJL4caLN7CA6E7r1QRpxq1dxW7ajg7ofUZxnSLVaczyUv
	C13xaDKQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44934)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sBaL0-0003ZN-0N;
	Mon, 27 May 2024 14:24:30 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sBaL2-0002M3-CW; Mon, 27 May 2024 14:24:32 +0100
Date: Mon, 27 May 2024 14:24:32 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Ron Economos <re@w6rz.net>
Cc: Guenter Roeck <linux@roeck-us.net>, regressions@lists.linux.dev,
	linux-clk@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] clkdev: report over-sized strings when creating clkdev
Message-ID: <ZlSJkCtx6eYPCQwG@shell.armlinux.org.uk>
References: <28114882-f8d7-21bf-4536-a186e8d7a22a@w6rz.net>
 <ZlSIH1/etwPQe+bQ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZlSIH1/etwPQe+bQ@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, May 27, 2024 at 02:18:23PM +0100, Russell King (Oracle) wrote:
> On Mon, May 27, 2024 at 03:45:15AM -0700, Ron Economos wrote:
> > On Fri, May 17, 2024 at 03:09:14PM -0700, Guenter Roeck wrote:
> > > Hi,
> > >
> > > On Fri, Mar 15, 2024 at 11:47:55AM +0000, Russell King (Oracle) wrote:
> > > > Report an error when an attempt to register a clkdev entry results in a
> > > > truncated string so the problem can be easily spotted.
> > > >
> > > > Reported by: Duanqiang Wen <duanqiangwen@net-swift.com>
> > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > >
> > > With this patch in the mainline kernel, I get
> > >
> > > 10000000.clock-controller:corepll: device ID is greater than 24
> > > sifive-clk-prci 10000000.clock-controller: Failed to register clkdev for
> > corepll: -12
> > > sifive-clk-prci 10000000.clock-controller: could not register clocks: -12
> > > sifive-clk-prci 10000000.clock-controller: probe with driver
> > sifive-clk-prci failed with error -12
> > > ...
> > > platform 10060000.gpio: deferred probe pending: platform: supplier
> > 10000000.clock-controller not ready
> > > platform 10010000.serial: deferred probe pending: platform: supplier
> > 10000000.clock-controller not ready
> > > platform 10011000.serial: deferred probe pending: platform: supplier
> > 10000000.clock-controller not ready
> > > platform 10040000.spi: deferred probe pending: platform: supplier
> > 10000000.clock-controller not ready
> > > platform 10050000.spi: deferred probe pending: platform: supplier
> > 10000000.clock-controller not ready
> > > platform 10090000.ethernet: deferred probe pending: platform: supplier
> > 10000000.clock-controller not ready
> > >
> > > when trying to boot sifive_u in qemu.
> > >
> > > Apparently, "10000000.clock-controller" is too long. Any suggestion on
> > > how to solve the problem ? I guess using dev_name(dev) as dev_id parameter
> > > for clk_hw_register_clkdev() is not or no longer a good idea.
> > > What else should be used instead ?
> > 
> > This issue causes a complete boot failure on real hardware (SiFive
> > Unmatched). The boot only gets as far as "Starting kernel ..." with no other
> > indication of what's going on.
> > 
> > Guenter's suggested patch solves the issue.
> > 
> > diff --git a/drivers/clk/sifive/sifive-prci.c
> > b/drivers/clk/sifive/sifive-prci.c
> > index 25b8e1a80ddc..20cc8f42d9eb 100644
> > --- a/drivers/clk/sifive/sifive-prci.c
> > +++ b/drivers/clk/sifive/sifive-prci.c
> > @@ -537,7 +537,7 @@ static int __prci_register_clocks(struct device *dev,
> > struct __prci_data *pd,
> >                          return r;
> >                  }
> > 
> > -               r = clk_hw_register_clkdev(&pic->hw, pic->name,
> > dev_name(dev));
> > +               r = clk_hw_register_clkdev(&pic->hw, pic->name, "prci");
> 
> How about just changing this to:
> 
> 		r = clk_hw_register(dev, &pic->hw);
> 
> ?
> 
> Since, if the device name is over-sized and thus truncated in the clk
> lookup array that clkdev maintains, *nothing* will be able to match
> the entry. Hence, I suspect all those clkdev registrations are
> completely redundant for this driver (and do nothing other than
> waste memory!)

Note that I mentioned *exactly* this point in my first reply to the
report of the regression in:

https://lore.kernel.org/r/ZkfYqj+OcAxd9O2t@shell.armlinux.org.uk

"We need to think about (a) whether your use of clk_hw_register_clkdev()
is still appropriate, and (b) whether we need to increase the size of
the strings."

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

