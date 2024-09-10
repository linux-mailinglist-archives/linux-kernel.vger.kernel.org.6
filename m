Return-Path: <linux-kernel+bounces-323019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 811029736AC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41821C24C82
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190B419066B;
	Tue, 10 Sep 2024 12:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KXHM8/bF"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF97190046;
	Tue, 10 Sep 2024 12:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725969685; cv=none; b=U279YyReVLIIYqEYanWniKAgZLt8mprEeNUQI7FnsYsUd2D/PiSziDA+vtaSGqqvEz6gt8yYE0Frv6DSHKhEb8yFAmrLfms7FcQgjkxiS6uXlrEt7VTSOwNdiFAI/GkII31liELRDeWQuCRarPGsrjFCl/xDFM0GuBkhjda1RXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725969685; c=relaxed/simple;
	bh=tRc3HNQSk4dnZvREjyJkU/sVgaoKm6Hs9/EOfrxrsRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WToG08u9GUTPEjqEdctnCQc08kGP4TS5gVnsuNlD1I6pJ6z5FJ7Byk/VgpMMzcn+iXG14lRr7KXFtbW+COQMyuHGRyYv5jPfCKgYKUERI4r4lzS1/102zqaTfG0BcAspmKJpXx6b1v4LEhKeCfxuzHT/IbLQnX27AjBo01HfYOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KXHM8/bF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Pr67wimXRlCn7ssW8wiFuG82ga+Fx5MUu4X2sAMM3M4=; b=KXHM8/bFkWS6UfP48k4E9jqS4p
	eIAjB/Jo76p2/qPrzUri6Jny43M3lbcCQR+V07qijjRqiwRA2bGvsYF2dMc4wtvDO7TKb/H0pNVVV
	bhCAlMwCwynWYG8WWuIN5nbgcJNhxK5CmwHbTILi2vlvirmh9BIF/K8uw78Ydhb4VkqM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1snzYR-0076U0-10; Tue, 10 Sep 2024 14:01:07 +0200
Date: Tue, 10 Sep 2024 14:01:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tarun Alle <tarun.alle@microchip.com>
Cc: arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next V2] net: phy: microchip_t1: SQI support for
 LAN887x
Message-ID: <67481e1d-e0bd-4629-bbe9-4fe03fb1920d@lunn.ch>
References: <20240909161005.185122-1-tarun.alle@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909161005.185122-1-tarun.alle@microchip.com>

> +	/* Keep inliers and discard outliers */
> +	for (int i = 40; i < 160; i++)
> +		sqiavg += rawtable[i];

	for (int i = ARRAY_SIZE(rawtable) / 5 ; i < ARRAY_SIZE(rawtable) / 5 * 4; i++) {

You don't want to hard code the size of the array anywhere except for
when actually declaring it. It then becomes easy to change the size of
it.

	Andrew

