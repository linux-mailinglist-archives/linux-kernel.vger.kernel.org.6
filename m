Return-Path: <linux-kernel+bounces-309473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8563B966B05
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4282928167E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011011C0DDE;
	Fri, 30 Aug 2024 20:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gmGMHDFE"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E5C15C153;
	Fri, 30 Aug 2024 20:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051377; cv=none; b=JJoUBj2ehAZwlGIFOKRSAqTtrRyp6nVp2WR+0aeq1FPuzjqh6R0TMYddp5QEFlovhyRyRT89EZFiMJBIwMq0yzOwiN8hyYh3/H24Fx3w1Yrr/HpkhLbagWotU9cT02NA6xvQRsdo4VUq3mu85uQjx6Dk38i+CrlOoGaykKmJQl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051377; c=relaxed/simple;
	bh=1tx2x86giGSIv8JiQzXU/mxGEbNA9IFBR5H8EhMpjBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUktF55J+bWy1pS5r2E9SflUnu3uAj2Gzx58GIzlNf4UU0Dmja1X+5tF1VKvI7NzILCe1lIzkObSHbMMRersiozgzzC0jjEvn8nqaQF4V+6kqP3+i3QmaZIo1s2P87IodXQi1AnvRMW35t3BuS7qDeJS1CQ1dd5haAIhjh+E8iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gmGMHDFE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UVZGQRW9Ken7HNme42NE5TCtOSWgwWn4aMTFggNfm8o=; b=gmGMHDFEQNAMv7GhbyEDmEOg66
	2VAQCZWXcEUO52EhEqYUoKTQ+iuLfst/vYC2qnhAQlw3DA6dWXV3vIgPodRHgSpmeCMaTyy1QYMQt
	LDKodTXriAX8VpKwPKvO/KaVyP0BFEbo3AS7EfrLRg9DnSpj3kgQuPZR9eSwxGcTF/ok=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sk8f9-006AD4-C9; Fri, 30 Aug 2024 22:56:07 +0200
Date: Fri, 30 Aug 2024 22:56:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Herve Codina <herve.codina@bootlin.com>,
	Simon Horman <horms@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v2 1/7] net: ethernet: fs_enet: convert to SPDX
Message-ID: <65bccc31-4756-45ea-ae81-a0686c632229@lunn.ch>
References: <20240829161531.610874-1-maxime.chevallier@bootlin.com>
 <20240829161531.610874-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829161531.610874-2-maxime.chevallier@bootlin.com>

On Thu, Aug 29, 2024 at 06:15:24PM +0200, Maxime Chevallier wrote:
> The ENET driver has SPDX tags in the header files, but they were missing
> in the C files. Change the licence information to SPDX format.
> 
> Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

