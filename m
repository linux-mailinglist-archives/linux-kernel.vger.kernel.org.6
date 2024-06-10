Return-Path: <linux-kernel+bounces-208294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E15E902335
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3427285212
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE185132101;
	Mon, 10 Jun 2024 13:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AyoVZndU"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821AD7A702;
	Mon, 10 Jun 2024 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718027211; cv=none; b=d3RdfIN5DAVplnDKf08nh5WLeCe3kWCRljJoAF3mQPnG7KUYR7aRisFCicPTGm4DaKwgWcCdJ4F/+NBr1Vd02X+EHdCZteg1d7PEBePmMhsl/hYH6pLtF8LrczaLv5VQmDgu8xDPSEFlo5ZiTi0atBEnwmofpfKRHb1zYVS53YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718027211; c=relaxed/simple;
	bh=g/5Lsq36RXklS9o2TtS/yIjiPAe6FbbGCXZi44gE7k8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBJaAgaRqDqNWvP52JiO0y+Ou9WOPm/zz1ku+bWjHHpl+4mPjSVmxXL7yhLZtEWL8j8b3XK3pHGgFnPU9KwD5kR5/4r+ozipLqBuQMspNzgxElQNuihTnX0ETo3Uk0g+zSlcNE679un9xcayEPVNmcn5XexY2lDX82LWBzB0QgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AyoVZndU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=k2bfY9bURGyuauj9Z1BJWbBxRd9HHOxCDFbFWjTnfUg=; b=AyoVZndUcFYK+q90o/VRnVpisW
	YDI7GqfNEusKJHmfeKLReZVB4hfTA8sj7SNt+4MQeUNGjXUguJ3MTfS5pWwDrUtGC3REaXsZBmS/5
	Ilk5dRTanlJGbOLDFxtSrqxwuT5p8y+0AoK8QaAJhssnjy+mqiydf15Zkclsm7zsvyoo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sGfM0-00HIrZ-K8; Mon, 10 Jun 2024 15:46:32 +0200
Date: Mon, 10 Jun 2024 15:46:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andrew Davis <afd@ti.com>
Cc: Andre Przywara <andre.przywara@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 3/6] ARM: orion5x: Switch to new sys-off handler API
Message-ID: <c0e284cf-f3c9-4634-8cfc-9ab0b95cc55f@lunn.ch>
References: <20240610125924.86003-1-afd@ti.com>
 <20240610125924.86003-3-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610125924.86003-3-afd@ti.com>

On Mon, Jun 10, 2024 at 07:59:21AM -0500, Andrew Davis wrote:
> Kernel now supports chained power-off handlers. Use
> register_platform_power_off() that registers a platform level power-off
> handler. Legacy pm_power_off() will be removed once all drivers and archs
> are converted to the new sys-off API.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

