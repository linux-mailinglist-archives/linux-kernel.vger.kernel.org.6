Return-Path: <linux-kernel+bounces-318863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24BB96F446
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E47284D30
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62FC13AA38;
	Fri,  6 Sep 2024 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UtdHbkxU"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664E71CCB31;
	Fri,  6 Sep 2024 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725625574; cv=none; b=siDJvgOeyPAw/pBNIwGiWGyl+Uy5qGvRVXHckWJU6qP3At++4tsMT3f9Kzmh9FVNSpSaxxkIfqM1QyDS57eUA0aPqtNAKLrXcK/VtusY9nqofmx7qegThwS3c9KTVoVrZLyQ4AGAC82J2qd38HVOcYLSyWK3GGDp6QtvXIr7vgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725625574; c=relaxed/simple;
	bh=wg2DEOUPOH5mY7dbLVlCDoKEcqp7ii0rKBprLLEbrus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLgtWhwBBTxIn1ehOGlIJyb3st1qLjVcI/OwRx5nQC1DMO+VcH4q5VNya0S/qKXDLcINCat+cYqzMEAGkmyQkBDyjiMer8ZRzropmOPwOSG3nI/nBJ7FHoMwezYDIdLEV2hh+2hUNjSxuzfs/qNZX6MwZc9xxwt3JbAaNpPKt9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UtdHbkxU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mvDngWb2sOxmPJKf6A6lqeBxp2PnJryygTWVHyPedRU=; b=UtdHbkxUAHe6Z3qZz/kpYTToW8
	hH/b60BHEplFgWgppGWdEdqPNsrcdAgoyNhHdkR5x2/DnamJyDc8g7WWATHNRwHWjerm03DYKcwLU
	QRblUPzEhQH3AmoPV6w4s2Nk9681R5OVlR7sMIHmF4P/SMpT8qZbLgFwujVogaBJpJyg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1smY2J-006o08-1q; Fri, 06 Sep 2024 14:25:59 +0200
Date: Fri, 6 Sep 2024 14:25:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: saikrishnag@marvell.com, robh@kernel.org, jan.kiszka@siemens.com,
	dan.carpenter@linaro.org, diogo.ivo@siemens.com,
	kory.maincent@bootlin.com, hkallweit1@gmail.com, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next v2] net: ti: icssg-prueth: Make pa_stats optional
Message-ID: <47e80a78-58b7-481a-9b54-615a14eb104f@lunn.ch>
References: <20240906093649.870883-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906093649.870883-1-danishanwar@ti.com>

On Fri, Sep 06, 2024 at 03:06:49PM +0530, MD Danish Anwar wrote:
> pa_stats is optional in dt bindings, make it optional in driver as well.
> Currently if pa_stats syscon regmap is not found driver returns -ENODEV.
> Fix this by not returning an error in case pa_stats is not found and
> continue generating ethtool stats without pa_stats.
> 
> Fixes: 550ee90ac61c ("net: ti: icssg-prueth: Add support for PA Stats")
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

