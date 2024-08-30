Return-Path: <linux-kernel+bounces-308915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A042B9663AC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C6D8B2426B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2D21B2EC6;
	Fri, 30 Aug 2024 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OfmCU11d"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F281B2502;
	Fri, 30 Aug 2024 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725026685; cv=none; b=leB59qOsssTVgJHkzBdPIs9QV4JyTPPHVQZlfsXfFncthZIizbrp8gXwqAxFd6KCyRowDIWWG5LGwMgikti1W6KmSHUnf6lCaPfXEw4jhhQFlA2i9ViwU6VN66R/dsP6SKphh7DlmxRzQ6PgfhXblqAUf0ZyiLtJY8SDYZlLhHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725026685; c=relaxed/simple;
	bh=6ffwwo51+lVZaUwGer0tCRr+QGiyxA9GE/Yb5IgrIfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXt1iUT1ODymrrafayqeNU52MRRdC5flyZU5fWiSXDORjkNmSjmY+8EzifxGd5VmbN6MTWgFR9MZ+n8FrPMh/5NE8Ym1kZ7mf2DtYK/UALCY/dmi+NCUH5Xk1WpzZn3+bAQ8/riXCC3JINqjrsi2fk0xl1tE+wC59lnzxFddOBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OfmCU11d; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YUJm+EFsgiY7ytfWC61RaH14IYQ0/ggW0KsSeTobyXw=; b=OfmCU11dWNUN8T7f6MMs6RsTcn
	MLBFQi4y9EAC3RiSO/A9I1fe4pqcRW+R79rIteI/LiVte4Wk0EIMaAqo4LokFivx84uh0cAKCYVeh
	houdLFvUj1f6/eVu+3IC47USge877i74ujIkOdW2+RYwUGDylbkqQjSiAecNxzJ5fod8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sk2Ex-0068GT-CI; Fri, 30 Aug 2024 16:04:39 +0200
Date: Fri, 30 Aug 2024 16:04:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?546L5bu65pS/?= <wangjianzheng@vivo.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"moderated list:ARM/Marvell Kirkwood and Armada 370, 375, 38x,..." <linux-arm-kernel@lists.infradead.org>,
	"open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: [PATCH 3/5] pinctrl: mvebu: Use devm_clk_get_enabled() helpers
Message-ID: <2ec65238-2c91-4c87-bf77-de2c6f5ac2c7@lunn.ch>
References: <KL1PR0601MB4211C193CD204C565F834BB9DE972@KL1PR0601MB4211.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <KL1PR0601MB4211C193CD204C565F834BB9DE972@KL1PR0601MB4211.apcprd06.prod.outlook.com>

> Actually, I add "goto err_probe" in patch2/5 for fix the clock disable error. Based on that,
> I delete them in patch3/5. Because I want to use devm_clk_get_enabled() instead of original
>  devm_clk_get(), and need to remove the disable clock operation. 
> 
> It seems that it is unable to reverse the order of thes two patches. How about combining 
> These two patches into one? 

You should not add code and then delete it. How you achieve that is up
to you.

	Andrew

