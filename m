Return-Path: <linux-kernel+bounces-266544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5AD94016D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 00:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87561F22861
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3A618D4CA;
	Mon, 29 Jul 2024 22:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ojG4afQh"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1067713B780;
	Mon, 29 Jul 2024 22:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722293707; cv=none; b=bm3GXqa0Y7Fzn4gJCmbN5OL8AmwLZdDBAtAXKRW4OnNsEqIrwNhDL/MevV1IvQ0kWdEoGOz0FiwGu4SEYZYES29PmRYkwz477JItTYxa4C1+pgPUDy2bYQOLWXRuxswf3J+Ja7ahMQGMH2Gx2s3745byC7YLxGws38j7YuhJLxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722293707; c=relaxed/simple;
	bh=dSDcNnyn2P5W2M7mJgKYx3HhNlha+FEI9L0zhstmc2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkrX5vKI7L7d72QUZKvIaLSrmFOz6Hd5kVxuDxxN8TrpWr3HInO3ennpAm/zYXg0Y+OZ4+L5085h1k0qc2GGx0zJvd9YHOxP6BnGyqHs9fNJCS110195N9yQcU/VmmHMe4X3fSLDV8QtOCTM0Xi/udG/WUtMmIy6rvRrtlzZ6yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ojG4afQh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ES2uAFpPjEvAAvxEA8uKU8pYODrCakcBezkTkt9OKBU=; b=ojG4afQhPSZUwebmCb9RGDFHLm
	jHmCwKCt+2N9Bbrbf6k7hJ6aTlX2+nhoxHUtZPWg8VTMbwiNgACm5ny+B9+v4wtcGwesTGVLrY6Tw
	OUgGuhFbmnyQLmy0qt91U1drsD7L804jdXpkb/Gs6lgpSqygihjkCG7UYNyJX4BnyWsc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sYZGa-003W0f-Uf; Tue, 30 Jul 2024 00:54:56 +0200
Date: Tue, 30 Jul 2024 00:54:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/9] net: dsa: vsc73xx: fix phylink capabilities
Message-ID: <7dbc4c09-af3f-4e54-8f83-dca6d6d79361@lunn.ch>
References: <20240729210615.279952-1-paweldembicki@gmail.com>
 <20240729210615.279952-2-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729210615.279952-2-paweldembicki@gmail.com>

On Mon, Jul 29, 2024 at 11:06:07PM +0200, Pawel Dembicki wrote:
> According datasheet, VSC73XX family switches supports symmetric and
> asymmetric pause and 1000BASE in FD only.
> 
> This patch fix it.
> 
> Fixes: a026809c261b ("net: dsa: vsc73xx: add phylink capabilities")
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

No blank line between tags please.

   Andrew

