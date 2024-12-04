Return-Path: <linux-kernel+bounces-431528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD8D9E3E89
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08B62833AF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636AF20C032;
	Wed,  4 Dec 2024 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="F/EQqap+"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B21020B816
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733326962; cv=none; b=rpEBlAx/qMcjC7usAV3mI0kET1AzZABr7WOaeZk2etsedh6tZ52Inn61Uu3pE2rKNBAcxxZ++OBtZeUYWh0svnFXea80sK5qh87vYLSpzrQoLufTELinIvc3XfkdgD172gzVh8bk4FHw90bmndzgeA5+z1hGX30FoNAaj283cJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733326962; c=relaxed/simple;
	bh=Fu2tSTo683nxjTgu5JnH984Z6LIO5gDx7kswh2pIoBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCfWY33mSxH7TlNmDBWH2MML7WVvAsAa7VqYKHl50vMuLJG+Z+n5UauW3uWoPgQ5YxZMHilgtppoOryLKnD8dNjT+rzLX2/cDlNk6ReEq6R+oYNSai3U7vBO8nyWhc5Oafu3mbqmSmSMBkw4OZDOnjm6nHwZf8UM3R51jHB8IhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=F/EQqap+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WclJIgJsn5/+vqwanDjayXoLrKNWxG2h+QLUlcHYmRQ=; b=F/EQqap+4DoP8zDgpHWkJUx0+A
	Ll7txj0gAs94wtJCbOpIDFMIm/cOz88QFU5EjxODadgZbGzGZraNwPLzxZErR2y7b6xOFEM7Sjkyu
	Y3uqNrg7rf+VKzm11e914QNqYmE0yeX4QC4Y9YH6sEaQraNOUQHD22sC7Xzd4pxqiEMrk/Mpptngt
	OYvZQUi8PZ+ikD2W/cLArd4cyJPY62syzgnGghTKSyTsWAuDoqfnoL5tVkWwuGXyLaC+AKrXiUPt7
	JdeiXeKuj46krz1JFd34qVvFrbYcB8oHF22IzlDs9gCEOwcXKeMaHmsvCIUjfPpv4wfOeoreGXVjZ
	dv1a0J6w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49598)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tIrWP-0003XJ-21;
	Wed, 04 Dec 2024 15:42:38 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tIrWN-0005fA-09;
	Wed, 04 Dec 2024 15:42:35 +0000
Date: Wed, 4 Dec 2024 15:42:34 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andrew Lunn <andrew@lunn.ch>,
	Ard Biesheuvel <ardb@kernel.org>, Daniel Mack <daniel@zonque.org>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	"Jeremy J. Peper" <jeremy@jeremypeper.com>,
	Kristoffer Ericson <kristoffer.ericson@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/15] ARM: limit OABI support to StrongARM CPUs
Message-ID: <Z1B4aqtmfz19VMjv@shell.armlinux.org.uk>
References: <20241204102904.1863796-1-arnd@kernel.org>
 <20241204102904.1863796-3-arnd@kernel.org>
 <CACRpkdY243J4C3A9_13eTN84T2SeOjyoh0bWk6U1mqffUd6urw@mail.gmail.com>
 <CANp-EDb27XE0SMpDFUKm-L3j=rZhugbK20cQZGtAmP5D0r2C6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANp-EDb27XE0SMpDFUKm-L3j=rZhugbK20cQZGtAmP5D0r2C6w@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 04, 2024 at 09:50:57AM -0500, Ralph Siemsen wrote:
> On Wed, Dec 4, 2024 at 8:59 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > Hm why do we need a separate netwinder_defconfig if this defconfig already
> > supports it?
> 
> AFAIK footbridge_defconfig is for the "Compaq Personal Server", which
> is different than NetWinder. They could probably be reconciled by
> using devicetree and converting any platform devices. However testing
> could be a challenge, not sure who has working hardware anymore.

It's entirely possible to build one kernel that supports the EBSA285,
NetWinder and Compaq Personal Server. They're all the same machine at
the end of the day (PCI based SA110.) As long as the boot loaders pass
the correct machine type, the correct board file will be selected to
set things up.

However, if I remember correctly, Compaq seemed to be anti-mainline, so
didn't implement the machine ID and other things. I ended up
implementing a shim around the kernel to make mainline bootable on the
platform to correct the stuff that they couldn't be bothered to
implement. I may be adversely blaming them, as history from back then
is rather fuzzy, but I do remember mainline doesn't work because of all
sorts of weirdness they did.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

