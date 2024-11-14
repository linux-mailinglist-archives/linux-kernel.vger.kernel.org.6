Return-Path: <linux-kernel+bounces-408601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F7C9C80F2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 03:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19791F223D9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A49B1E8847;
	Thu, 14 Nov 2024 02:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TfE4F3bv"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F391F95E;
	Thu, 14 Nov 2024 02:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731552250; cv=none; b=gvqK2Rl0Zm+O6SsYxsV8TadFO39C5JuLohCm4a0iKGT7pHvB8tRklQZ+qSxMAhsVagaXOKob8cBlIYwMWnFECbYYKK1gd9w+nbvozjnuTaqkm/hAOkdxlzEzDuAwy5WnBX3vNZQb3a4rQ8L2NZRevL95IdWk7rU9VSESyPXFoWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731552250; c=relaxed/simple;
	bh=uz4BvHry2OIBxHXKpoYAvuwAW6z/sT0uTHKiAHUVu5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lB40ng8yyXEcqgqE0vAc6Sp/B2CozT3XjGlhX92KFhHokzbyKVkq7lCRgRQLA4owNURAXM0HIsS3QoXpICEs0S1eHzs1YMiXcP0vwAKH8ZCfDxJyx35f5J9tfWLw9wbkzwmsWOadkOxtx0Ydkx3IOKF9sEkLNq15LvEnI+2ZArk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TfE4F3bv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=L/1LctONlRs6ejZ2L1vwCuAoDhET8UPNZjALGIfAqzU=; b=TfE4F3bvXonw4tJC3R7tFonS5w
	FEWiAxcvIqdiCz+oXMnSOkOf5BGa74Nk4aCXjcMl/O1ddNvFcVHnahhkXbwhZAKsU5VgVVRPwSpsC
	9UamXzf2rs1ijyF9JV7AYt1fTo7SbMo6eTOSS4Iov2jQIQgKirn8d7SVu1oMO596nY44=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tBPpp-00DEfS-Ut; Thu, 14 Nov 2024 03:43:53 +0100
Date: Thu, 14 Nov 2024 03:43:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue6KaG?= =?utf-8?Q?=3A?= [net-next 3/3] net:
 ftgmac100: Support for AST2700
Message-ID: <e06668bf-f878-4a81-9f52-8fd047c1921c@lunn.ch>
References: <20241107111500.4066517-1-jacky_chou@aspeedtech.com>
 <20241107111500.4066517-4-jacky_chou@aspeedtech.com>
 <1f8b0258-0d09-4a65-8e1c-46d9569765bf@lunn.ch>
 <SEYPR06MB5134FCCB102F13EA968F81869D5B2@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB5134FCCB102F13EA968F81869D5B2@SEYPR06MB5134.apcprd06.prod.outlook.com>

> > > -	map = le32_to_cpu(rxdes->rxdes3);
> > > +	map = le32_to_cpu(rxdes->rxdes3) | ((rxdes->rxdes2 &
> > > +FTGMAC100_RXDES2_RXBUF_BADR_HI) << 16);
> > 
> > Is this safe? You have to assume older generation of devices will return 42 in
> > rxdes3, since it is not used by the hardware.
> 
> Why does it need to return 42 in rxdes3?
> The packet buffer address of the RX descriptor is used in both software and hardware.

42 is just a random value. The point is, what do older generation of
devices return here? Some random value? Something well defined?

You basically need to convince us that you are not breaking older
systems by accessing registers which they do not have. Describe in the
commit message how you know this is safe, what testing you have done
etc.

	Andrew



