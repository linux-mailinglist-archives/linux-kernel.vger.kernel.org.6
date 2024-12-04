Return-Path: <linux-kernel+bounces-430465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2E79E313B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 03:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5B55B244FE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9149939AEB;
	Wed,  4 Dec 2024 02:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pS0cvsX1"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843D533997;
	Wed,  4 Dec 2024 02:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733278374; cv=none; b=YPVpnYH/yAWaCPyiQOBg4Pe43kXzOx2eOGi6zzBWiDRsvxpgE3vAy9eaUz8Se0UI7/AAjPNiObptZAq2HNcIBFgXuPK5u/ivp+wwa/YwVSLcrhzp5hpyseCfzbCWFF8tP89w5EZIDk+7neM0xZLdSzCv869Q7svXdIsDnSLhHQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733278374; c=relaxed/simple;
	bh=nzMIw0KbP3XVmkyQRBJ2Xc5seay5ZA4k2nCkj/vMQCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdcILbY6dIJFHKdDLLUGgYwzbxC2w5d5ESz0yM+9dtTVz7UEdrIxpLLHj2YzmueOBJvtJjcLgNV+jYQSVu4T0OKlzVo6F2WlSBbDyAXzgQm+xAAuhe6NNeVZjijrKlkRKxbLUzftbg8kS+Lta3J/4z8pqnFie2DK3Nyf1pSj9HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pS0cvsX1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pHK0bIhHd1w9mxfIUlOYvQ9+doQOP9AE+twlL5gInvk=; b=pS0cvsX1lotpceJXuCs/uT77rj
	C5Rtl+fE/THt9xXx4N2ok37im8zDIahySax/ZhF3ciuyDoup07npK5JqnQ8AIieZT90BJGu48VEF6
	77ZH177IIsQgvCUsfXd0MHbqcu8n22L387wA2JYYLGFfq3Y+elglJtEI8V3i9reh74Xw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIesf-00F9fr-KT; Wed, 04 Dec 2024 03:12:45 +0100
Date: Wed, 4 Dec 2024 03:12:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Simon Horman <horms@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v3 08/10] net: freescale: ucc_geth: Move the
 serdes configuration around
Message-ID: <38636fbf-f047-4764-bb04-104ecac2481b@lunn.ch>
References: <20241203124323.155866-1-maxime.chevallier@bootlin.com>
 <20241203124323.155866-9-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203124323.155866-9-maxime.chevallier@bootlin.com>

On Tue, Dec 03, 2024 at 01:43:19PM +0100, Maxime Chevallier wrote:
> The uec_configure_serdes() function deals with serialized linkmodes
> settings. It's used during the link bringup sequence. It is planned to
> be used during the phylink conversion for mac configuration, but it
> needs to me moved around in the process. To make the phylink port
> clearer, this commit moves the function without any feature change.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

