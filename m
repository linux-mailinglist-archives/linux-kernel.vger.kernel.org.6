Return-Path: <linux-kernel+bounces-431402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B20079E3DF5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A33FB33692
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A29120A5D8;
	Wed,  4 Dec 2024 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sEGo/kEC"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0951B4157
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733323076; cv=none; b=nwi8K7ooEf4lgCpeKwCo1HBYAO/u/XiriEjhWaNTORetBc+9ZF6KEl9kCyUyGTCKtCY65mH7rQJXOXQZeMZs2prNiLAsuzchuemEcaHf3/HGwYZZccmmOAaDOfWELmkWBJewDkmySJ791YSmQ3U9vBqTqCRh4z4SHeWWwY27hJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733323076; c=relaxed/simple;
	bh=s86lN6cvDjgoA9E72DlvvsWXpwCvHlaBiIElBQNYILc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsFRfB8aAeH7zzAGvUAsF6zXB+ONsKKnAcayl/0WNfIQPoZi9picXeKlfhRnLAdeU38WVx709vlsKCRbQjwR6JbPHK1DuszQN7MKQ0BfNhhb06rj/H5CNekDdFb+PneIWh+wda1XxmvRnuqhd2IRJtS7G/E2ZbAaKOFle5tFhkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sEGo/kEC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=d0UI9RVYI7CpiaDoEdpIIrcx8Tm046GiLKGNeURsScg=; b=sEGo/kECC6aoG5eXWn7eeUIOsc
	AzbwoOVjUPAmNtvIqYUFbbuprKBUU0ZCyUf6nPTck/DdLE5+kJol5HFD6oCaPopl5UqUNh/W/emu0
	rXQDCogwbrkAuuUGONWArPIt+iBIK9NiWf2l2d/CU2bhnow9npq2iHfRUsifZBG7mYkY3YVymEVCe
	1y+nAK7QhlucUYcRU4Kz1Wx77FpkQy1dyyUNp1nSk7L5+cavG3b30wCrgFRldT6v+YVtwGWOC81o3
	+GPgguCPdoHA6XMJ7ZujAezSJBRc78U6BD4wC990HDvlP4UzTmrcJFeSl36qRufaGtnT1AjS85ASI
	PBQpdnQw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52040)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tIqVd-0003Ow-1h;
	Wed, 04 Dec 2024 14:37:46 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tIqVZ-0005bq-2F;
	Wed, 04 Dec 2024 14:37:41 +0000
Date: Wed, 4 Dec 2024 14:37:41 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Marc Zyngier <maz@kernel.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andrew Lunn <andrew@lunn.ch>, Ard Biesheuvel <ardb@kernel.org>,
	Daniel Mack <daniel@zonque.org>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	"Jeremy J. Peper" <jeremy@jeremypeper.com>,
	Kristoffer Ericson <kristoffer.ericson@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Ralph Siemsen <ralph.siemsen@linaro.org>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 15/15] ARM: mark footbridge as deprecated
Message-ID: <Z1BpNQjWwxEKFbg0@shell.armlinux.org.uk>
References: <20241204102904.1863796-1-arnd@kernel.org>
 <20241204102904.1863796-16-arnd@kernel.org>
 <CACRpkdahQhj5u9ATghszi-N2OYhFbvHF_W_eAMDAU+vhmvdrJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdahQhj5u9ATghszi-N2OYhFbvHF_W_eAMDAU+vhmvdrJA@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 04, 2024 at 03:29:09PM +0100, Linus Walleij wrote:
> On Wed, Dec 4, 2024 at 11:30 AM Arnd Bergmann <arnd@kernel.org> wrote:
> 
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Along with RiscPC and SA1100, these are the last remaining Intel StrongARM
> > machines. The Corel NetWinder used to be particular popular in the late
> > 1990s, but was discontinued during the bankruptcy of rebel.com in 2001.
> > The other machine is the DEC (later Intel) EBSA285 evaluation board that
> > was made in small numbers in 1997 for software developers.
> 
> IIRC David Rusling at DEC was sending this board out to interested
> developers.
> 
> > The footbridge/netwinder platform was the main target for the first Debian
> > 2.0 "Hamm" release on the Arm architecture back in 1998, but was dropped
> > in Debian 6.0 "Squeeze" in 2011, which only supported ARMv4T and higher
> > with the EABI based ports as ARMv4 hardware had fallen already out of
> > use by that time.
> >
> > Link: http://netwinder.org/
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> I am booting it occasionally, last time to test my KCFI patches.
> But admittedly that is only to test it for other SA110 users. I remember
> that Christoph had problems consolidating the DMA used in this
> machine as well so it is standing in the way of useful work.

What problems with DMA? The fact that it uses an offset between
physical and PCI bus space should be nothing that causes a problem
for the kernel. As maintainer for Footbridge, I've heard nothing
about there being any issue.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

