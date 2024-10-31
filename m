Return-Path: <linux-kernel+bounces-390720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2279B7DBF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7A21B22B41
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132AB1BC9E5;
	Thu, 31 Oct 2024 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rc4NufGu"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7502519F406;
	Thu, 31 Oct 2024 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730387014; cv=none; b=slh057xARfC4NeYzEwYTlK6NjfWZym4pS6g3pMjYDCYlQSEluJVPEWIUkHl82zLqwqDk8eOXvQPIEBafAur5HaR2UowuvSfjMJA5a2PiPSsIoGEzTzFQNXyHmOFy9ZtNCi5ojmWf+4DTQZkLjRVHqiWukKO9/vOHfZNbiON9iK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730387014; c=relaxed/simple;
	bh=KV/t0i3CRGXochMmWaFDtVDx7+mJcxlVD4Ipji8k1ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPFLehCM/g5iTu3ExxvHzzQM9K3bO7AGGyPf8lNKeGZx93ZaEjenuOoi2R2FQ99ubTJ71vJVp+BsrC1kGESuFST+7Ngk8stZk57iMqdASMbwqrPVPOz61ZRo2KH9ZjAkIp0cZqzSl/bn1M4H+LVtQNdwRU5793U2zaapHp7UopU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rc4NufGu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3CYEngcINh3YznzU5GG7+Z6paSZSCs5bVmStIlkx+/U=; b=rc4NufGuoGCNzo1emNKloaPtTl
	RnqRqVGPJrF8i4rlyw/MO1cy7zYdQo2CvWc9459VI33q2XoehubNv+67F8aw8NL0xy/TnHe97V55s
	eYPbES3obNDPiw9TrCtqZ2uyhuj0I8GIrBXwcJjN1jVHirckHnZcfcr7b4hjCGa7HtQA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t6Whp-00BnPZ-2z; Thu, 31 Oct 2024 16:03:25 +0100
Date: Thu, 31 Oct 2024 16:03:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCk=?= <SkyLake.Huang@mediatek.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"horms@kernel.org" <horms@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	Steven Liu =?utf-8?B?KOWKieS6uuixqik=?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next 2/5] net: phy: mediatek: Move LED helper
 functions into mtk phy lib
Message-ID: <1b9e9b1a-cc12-44b8-bbdd-6e6777adfb13@lunn.ch>
References: <20241030103554.29218-1-SkyLake.Huang@mediatek.com>
 <20241030103554.29218-3-SkyLake.Huang@mediatek.com>
 <7cb014a6-ec64-4482-b85c-44f29760d186@lunn.ch>
 <29352dda1b5c647c30e48fbb31e7781fdab43d9f.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29352dda1b5c647c30e48fbb31e7781fdab43d9f.camel@mediatek.com>

> I think I got your point. In a follow up patch, I'll do the following
> change:
> 
> [Psuedo code]
> /* Currently */
> mtk_phy_led_hw_ctrl_get() {
> 	get_led_hw_settings(); //on & blink
> 
> 	set/clear &priv->led_state according to led_hw_settings
> 
> 	get *rules according to led_hw_settings
> }
> 
> /* Change into */
> get_led_hw_settings()
> 
> mtk_phy_leds_state_init() { /* Actual led_state init code */
> 	get_led_hw_settings(); //on & blink
> 
> 	set/clear &priv->led_state according to led_hw_settings
> }
> 
> mtk_phy_led_hw_ctrl_get() {
> 	get_led_hw_settings() in register; //on & blink
> 
> 	get *rules according to led_hw_settings
> }

This looks about right. I will review the real patch when it is sent.

	Andrew

