Return-Path: <linux-kernel+bounces-289708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1986E954AC8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C081F225CB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145841B8EA0;
	Fri, 16 Aug 2024 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MKYD2vZH"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D6D12AAC6;
	Fri, 16 Aug 2024 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723813851; cv=none; b=Rw0G7KoGQYmp/0xc4t7/sGnoIGccH1Y0LwwoUWbBvgyWWQrfw4P/3Agj0sM73L3WvT9x2GSULk42Q0nEOjWDZscddjdw19fd4UCPb2Ae4GR0QMOC7hxhaH98xiR79KYPDPcJ4ZGIZ3nAHQxXmA/Qk1BdtrLOF9NjBesBBjuSAXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723813851; c=relaxed/simple;
	bh=pbgA3KL+XhjxfWJ/9CjC6yU2g73BBG0ouhZfPWCwDWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPXDLTBn2haedoJrFN7HfBDRBAcr/AN+iLTGF5fnD1NSa27BPsKfHBQ5mEPm2OSGFhTeKKfPrjoWO9q3adIzcyYNSC34LUN4P2ojDS6wSg3JgB03m+FG4uYC1GvrcITInuswQ2U0Fck5xgfYsNczzN3De9/uIUxzKOyUbyp4Boc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MKYD2vZH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Jj8EgdpePe+zRquT125ObojMr7sTNJrCzWSzYx66IcU=; b=MKYD2vZHQ6JDxRn9ykefuic2ao
	ItrJKyfV5xYa+23F4FQV1sLbzTBSnxJ1XuEoQbMSLcyyXyt3jocu93Q5T/wWDHVzD5hvtxzRn38vm
	bVxcEP+26MMf0tLOmZgVBvZUhGjvi4tiHZWNycaag3QVGFQElUkxpFHRZu/aN9mrnE2o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sewix-004vr4-PV; Fri, 16 Aug 2024 15:10:35 +0200
Date: Fri, 16 Aug 2024 15:10:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] phy: dp83td510: Utilize ALCD for cable
 length measurement when link is active
Message-ID: <f026cabc-76d3-474c-90a1-47c355a7d673@lunn.ch>
References: <20240816105155.1850795-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816105155.1850795-1-o.rempel@pengutronix.de>

> The DP83TD510 PHY provides an alternative through ALCD (Active Link
> Cable Diagnostics), which allows for cable length measurement without
> disrupting an active link. Since a live link indicates no short or open
> cable states, ALCD can be used effectively to gather cable length
> information.

Is this specific to TI?

Did you compare ALCD to TDR length measurement? Are they about the
same? I'm just thinking about if we want to include an additional
attribute in ethnl_cable_test_fault_length() to indicate how the
measurement was performed.

	Andrew

