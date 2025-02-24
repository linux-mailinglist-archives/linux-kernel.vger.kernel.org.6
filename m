Return-Path: <linux-kernel+bounces-528144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4913BA41419
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 04:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E17216E86F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 03:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E931A9B3F;
	Mon, 24 Feb 2025 03:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Qnsup52z"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C785619F48D;
	Mon, 24 Feb 2025 03:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740368220; cv=none; b=seuMsiq8EhIuWEGQCiOwzbpVmrL9xifc2vjUJi7/UOikYZ70Em5tMTfJV/dIHt+CcmkUOsyo3ACro5N0zs9Nuw0fXgFdhgXK8w/SOxzCevVNYmyM0png6Blv9QP5XCBFT56Hq+XlWU+igLqzfzXhm9MvoWqYCsu85RKywJN11gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740368220; c=relaxed/simple;
	bh=2MghzfEybTbaDT4h1UamnJYUFiO/it1dwZvswctKrog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mz0QefHZLIuC708q3oZdPLxibB1Rczek2TQ1/7qeUA2x68k6LX2uY3vay/OhEIDQo4ghyuq5Wh9vksjppePtwzR0uHezdh8xL4P0RcSKZjo75KO8TwJMIV26ER8EhRYJ6SAUIUJashH6VncQwKGB6qnml1uhFWGRfP7/zCi6ssY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Qnsup52z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YpNO+c6fto5jPuYraaG0BE3x8Zo7nWvaRTcmjs1cjT4=; b=Qnsup52zYs7E/uQUFhfzcvWcHU
	y06TZe1GmAzZudryWxeREUkDQmBTHVX1IkECBHazLH5ivrukhyAlF/vMPFiVjQXGQq+NUMFRUgjuN
	1peD8ni1drEoz4ibG1hHU7MQ924FovjnCH6nsOrUmshuEZM75RFLNJS3vpU8mpm75qDU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tmPGz-00H1nK-MA; Mon, 24 Feb 2025 04:36:49 +0100
Date: Mon, 24 Feb 2025 04:36:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Antoine Tenart <atenart@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH net-next 2/2] net: mdio: mdio-i2c: Add support for
 single-byte SMBus operations
Message-ID: <4ff4113d-f97d-4d40-bd7e-cdba6f30b6ee@lunn.ch>
References: <20250223172848.1098621-1-maxime.chevallier@bootlin.com>
 <20250223172848.1098621-3-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250223172848.1098621-3-maxime.chevallier@bootlin.com>

> This was only tested on Copper SFP modules that embed a Marvell 88e1111
> PHY.

Does the Marvell PHY datasheet say what happens when you perform 8 bit
accesses to 16 bit registers, such at the BMSR?

	Andrew

