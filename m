Return-Path: <linux-kernel+bounces-345954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5FD98BD5C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C478CB2408B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DEC1C330B;
	Tue,  1 Oct 2024 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eSVyhM2S"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932EE1C4617
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 13:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727788844; cv=none; b=pbRYkw2JuA9dnrxnHrGYMQTNjvefatq6W1iRuPX2eGGDxES0euF7x4vVGkbR6hwJUM8XLteLTFXBpVBLewVoJ7MYUpUUH4teqiBDJu+eGRm+ROcZdCPTvPVRvHaMLstE4UeSUT83JSNSo9gJ95jnlikjMnK48eT5FAChG8M5ioU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727788844; c=relaxed/simple;
	bh=ek94kv3gumVvRixWSSy+YJZM+NHZ70Jmf6O9+X4S4EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9J3TwdFHub/IOjSxpAdfUD4LNEFNr68vHszpaM++wsQPdGL/FWXVaUGangekWeX0FnYhRLt9JdccMj+kMMyFSllAiv8Gn9OetQLd2MIAcfRmDgmx4UboQELdHbmdMHr7Zi0oVlyEFVYifg//Lc6wAoVkNKgcheZcjj9/koPhiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eSVyhM2S; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=7em7z76oYcjR4VzVnG09HWZM9+tXlfqwbXMT66DBZlA=; b=eS
	VyhM2Sq0K2g9pKPymE7v0Nie4p8L5IG3tswCkfNjVMKqRSR3chbqaN+48XZ4WvNPnu63bFXuHxfi/
	I1O3qTfQZePBWHuo3nM52A+nyhBVAPPaiasaiVm4vebJtLs5SCsKpyJhjZKe4rGQtzf3DHYdg2VyD
	hgkCMAbvKts1oD8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svcnr-008jRM-GN; Tue, 01 Oct 2024 15:20:35 +0200
Date: Tue, 1 Oct 2024 15:20:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch: arm: kirkwood: support nvmem mac address
Message-ID: <e58a0b80-7f4a-40eb-a37f-dc5cdd5e32be@lunn.ch>
References: <20240930215934.349238-1-rosenp@gmail.com>
 <e729da5b-3964-4cdc-bdf4-2352be5b093e@lunn.ch>
 <CAKxU2N9sBOnTGDhtxGVvyrSw=_WuJH29tgZXfmK-RD2RRY=ZSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N9sBOnTGDhtxGVvyrSw=_WuJH29tgZXfmK-RD2RRY=ZSQ@mail.gmail.com>

On Mon, Sep 30, 2024 at 07:50:56PM -0700, Rosen Penev wrote:
> On Mon, Sep 30, 2024 at 6:53 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Mon, Sep 30, 2024 at 02:59:34PM -0700, Rosen Penev wrote:
> > > of_get_ethdev_address gets called too early for nvmem. If EPROBE_DEFER
> > > gets called, skip so that the ethernet driver can adjust the MAC address
> > > through nvmem.
> >
> > Is this from code analysis or do you have a board with real issues? Do
> > we want to add a Fixed: so it gets back ported in stable?

> Working with a guy that does. This device has not been upstreamed, so
> not quite valid.

As the MVEBU Maitnainer, i'm always happy to see new kirkwood
boards. It has been a number of years since the last one was
contributed.

> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > ---
> > >  arch/arm/mach-mvebu/kirkwood.c | 11 ++++++++---
> > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-mvebu/kirkwood.c b/arch/arm/mach-mvebu/kirkwood.c
> > > index 73b2a86d6489..da347f66900b 100644
> > > --- a/arch/arm/mach-mvebu/kirkwood.c
> > > +++ b/arch/arm/mach-mvebu/kirkwood.c
> > > @@ -86,13 +86,18 @@ static void __init kirkwood_dt_eth_fixup(void)
> > >               void __iomem *io;
> > >               u8 *macaddr;
> > >               u32 reg;
> > > +             int err;
> > >
> > >               if (!pnp)
> > >                       continue;
> > >
> > > -             /* skip disabled nodes or nodes with valid MAC address*/
> > > -             if (!of_device_is_available(pnp) ||
> > > -                 !of_get_mac_address(np, tmpmac))
> > > +             /* skip disabled nodes */
> > > +             if (!of_device_is_available(pnp))
> > > +                     goto eth_fixup_skip;
> > > +
> > > +             /* skip nodes with valid MAC address*/
> > > +             err = of_get_mac_address(np, tmpmac);
> > > +             if (err == -EPROBE_DEFER || !err)
> > >                       goto eth_fixup_skip;
> >
> > I'm wondering about ordering here. What exactly does EPROBE_DEFER
> > mean? Does it mean we know there is a MAC address in nvmem, but the
> > nvmem has not probed yet? Or can it mean, the nvmem has not probed
> > yet, and maybe there is a MAC address in it, maybe not?

> It only means NVMEM has not loaded. NVMEM loads after MTD, meaning quite late.
> >
> > In the maybe not case, we should still be trying to read the MAC from
> > the hardware and storing it way safe for later use.
> Not sure how to go about that. OTOH it's not very common to have
> CONFIG_NVMEM where not needed.

Yes, it is. Think about openwrt! It will have one kernel configuration
for all kirkwood boards. If one device needs NVMEM, they all get
NVMEM.

> 
> Actually I have no idea what this whole function even does. For these
> devices, uboot usually reads the ethaddr variable and passes it to the
> kernel. Something like that can be handled entirely by nvmem.

Well, no not really. What you say is true for 'modern' systems,
anything which is less than 10 years old. But kirkwood is very old. It
was one of the SoCs which pushed the adaptation of DT. I did a lot of
work adding DT bindings to all the Marvell drivers, so that kirkwood
and orion5x could make use of DT, rather than board files. But back
then u-boot had no support for DT. u-boot had no idea about DT
blobs. The blob was just appended to the end of the kernel
bZimage. u-boot just loaded the 'kernel' into memory, and the kernel
knew to look for it at the end of the image.

As you say, u-boot knows the MAC addresses. But Marvell decided on a
unique way to pass them to Linux. The Marvell u-boot programmed the
MAC addresses into the Ethernet controllers. So when Linux booted, the
MAC addresses are already set.

But part of DT was clock support, using the common clock
framework. Towards the end of the boot, CCF turns off all clocks which
have not been claimed. If the Ethernet driver has not loaded yet, the
clock is not claimed, and so it got turned off. And when the clock is
turned off, the ethernet controller forgets its MAC address :-(

We hacked around this. During early boot, this bit of code looked in
the Ethernet controller and reads out the MAC address, and modifies
the DT blob, adding the MAC addresses in the usual place. When the MAC
driver probes, it then uses the normal API to get the MAC address.

We need to ensure this change does not break this. If we 100% know
there is a MAC address in nvmem, we can skip reading the MAC out of
the hardware. But if there is an nvmem, but not MAC addresses in it,
we need to read the MAC addresses out from the controllers. Hence the
exact meaning of EPRODE_DEFER is important.

	Andrew

