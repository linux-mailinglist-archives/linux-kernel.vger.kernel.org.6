Return-Path: <linux-kernel+bounces-431540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612E29E3EAA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18DC128168C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F4820C474;
	Wed,  4 Dec 2024 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Xbi39iYM"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C69768FD
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327345; cv=none; b=uoCK3Q3iPQ9WZOE9RxTYqg2MxD+/GLEnXTFch7OT6tpVc74+tEA1SFxrR8BtD8UuqwkIA6rqH2lPjSz4npUhZpqsryfdexWxsiI0xTe0vRtWK4R6LN9hkz45Pv6kr0hXuSzZAN7q4GSUPL1AwJ5k6WxdxY9IHlvBQ2FG+Ga5Ih4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327345; c=relaxed/simple;
	bh=UUhp5DxeBGSYC0WTytwWVBg4/omvtY6Ga4RVr+XpMDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLLG5X6u/sFph1GVr4mHzEmWfyiT0LN1R/wD7DBp/QCTnATv0NXzwJlmf2hMvttYK+v4jRPaulYLncCIFZkGxMEQNSjs62hzBoGCmbiy0TxbtvJ9bcpGO3iXptf3OqAZDgITuRdZyH4MQkb1xHvIOV4JrxiK4ZthqtaT91zaqj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Xbi39iYM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=E62FsyMAcmSi/iRaaQV/SsddF5jf4yfqk5/NdWw/RL8=; b=Xbi39iYMj6AG15Gq293oTRONvV
	VkHNEUZysnXc2W4Ng5hGEqIUKBdmCxeAEcIZl9arkR3bsb28S+F1dy3re/uIzvgcnCUeTTMCycKF1
	ig+378vztjY9hOxk5Np+rwZ87veFnBUfGi6JGtEpMFvGtBxaGNJ3z+MbUGwZNsNUqNC8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIrcY-00FE37-Pv; Wed, 04 Dec 2024 16:48:58 +0100
Date: Wed, 4 Dec 2024 16:48:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Ard Biesheuvel <ardb@kernel.org>, Daniel Mack <daniel@zonque.org>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	"Jeremy J. Peper" <jeremy@jeremypeper.com>,
	Kristoffer Ericson <kristoffer.ericson@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Ralph Siemsen <ralph.siemsen@linaro.org>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 12/15] ARM: orion5x: mark all board files as deprecated
Message-ID: <11006329-8f7c-4c8d-8754-cd1a068490e2@lunn.ch>
References: <20241204102904.1863796-1-arnd@kernel.org>
 <20241204102904.1863796-13-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204102904.1863796-13-arnd@kernel.org>

On Wed, Dec 04, 2024 at 11:29:01AM +0100, Arnd Bergmann wrote:
61;7801;1c> From: Arnd Bergmann <arnd@arndb.de>
> 
> Conversion of the old orion5x board files to devicetree has
> stalled over the past few years, so it seems better to remove
> the remaining ones in order to allow  cleaning up the device
> drivers.
> 
> Debian has previously removed the orion/kirkwood kernel
> binary from the armel distro, but building custom kernels
> from the Debian source code should keep working, so
> removing the board files after the 6.12 release ensures
> that this remains possible for the Debian Trixie release,
> assuming this will use the 6.12 LTS kernel.
> 
> Jeremy Peper still plans to convert the Terastation 2 Pro
> to devicetree in the future, but that can be done even
> after it is removed.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

