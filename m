Return-Path: <linux-kernel+bounces-523805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D26E8A3DB79
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2342819C243A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD04F1F8F09;
	Thu, 20 Feb 2025 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CYXwOHmy"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A628E1F460D;
	Thu, 20 Feb 2025 13:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740058778; cv=none; b=p3KjyZtUhIe//ARDegUteP6KNcIhSQrjSmKnctyqc6wqJLYeLpYf9YHmLW9Gmj/ApHmaD7J3r5owGOFz41CnysMc9mQRwOjyMizd6xXRn3Je50NE/spdmkFoG/WJGLrYn1I0ttjKp/hk/Nhq6VyNX/t71f3R/+dk0RG2n/4Sflg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740058778; c=relaxed/simple;
	bh=2y5wrvPA3QtP637YQRd8Romn+Qri1JD1V/ToFZNDnFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVlJJB5n7vSGb67B17JOhFHohAaIe0tI9SV6+lAuoSApQdZwqQh73PLfXgLC1U/alzmdmw/8zZjUO9svQgvdg6JJsxrdxjkctwcpzWwNh4Nmzt7Vo2I+clxC652luSmG3marRzV7ghehoaoFlrQ8kPmeJ7JNpthtbVycKMznIwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CYXwOHmy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GQ45r65/eICG0K3oXWSgWL9Ap6Foqy+lEFou18SI24A=; b=CYXwOHmy+1GP64C83m4rlns27N
	pEq8rW4Z/fLtOI8sMzqMjILB5WKu33wuRMYsFEBhwZfet4mFi/4IKt3DyQ/QE0LVwFp3IjaOTrsUw
	doit/kIEHYq1LufuNCHrQevICeHbk6Eoz8AptY65evxvg9+uDhC2Fqofdw2F+VREn0Nc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tl6lw-00FyQq-Nk; Thu, 20 Feb 2025 14:39:24 +0100
Date: Thu, 20 Feb 2025 14:39:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lukasz Majewski <lukma@denx.de>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] arm: clk: Add ETH switch clock description for vf610 SoC
Message-ID: <5a9d9eef-f2ca-4168-aca4-4419dcfcacb6@lunn.ch>
References: <20250219114936.3546530-1-lukma@denx.de>
 <3cebe152-6326-454c-9da6-5cf5a64f71c9@lunn.ch>
 <20250219233802.20ec53e5@wsk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219233802.20ec53e5@wsk>

On Wed, Feb 19, 2025 at 11:38:02PM +0100, Lukasz Majewski wrote:
> Hi Andrew,
> 
> > On Wed, Feb 19, 2025 at 12:49:36PM +0100, Lukasz Majewski wrote:
> > > The NXP's vf610 soc is equipped with L2 switch IP block from More
> > > Than IP (MTIP) vendor.
> > > 
> > > It requires special clock (VF610_CLK_ESW) to be operational.  
> > 
> > So you have a driver for this switch? It has been talked about in the
> > past, but nobody made any progress with it. Ah, it was you in 2020.
> 
> Yes, I'm going to try another time to upstream it.... :-)
> 
> > It
> > will be interesting to see what you came up with in the end, pure
> > switchdev or a DSA driver.
> 
> I think it would be:
> 
> 1. Standalone driver, which would configure the L2 switch from the very
> beginning to work (this is different from FEC on imx28/vf610 where
> switch is bypassed)
> 
> 2. It will use the in-switch registers to have two network interfaces
> separated. As a result - it may be slower than the fec_main.c in this
> use case.

Seems like a reasonable compromise. You would only load this driver if
you intend to make use of the switch...

> 3. When somebody call "bridge ..." on it - then the in-switch
> separation would be disabled. This is the "normal" state of operation
> for L2 switch, which would be a HW accelerator for bridging.
> 
> 4. The switchdev would be used to manage it
> 
> 5. This would be just a very simple driver - just bridging and startup
> of the L2 switch.
> 
> After we would have a consensus (i.e. it would be pulled to mainline) -
> I would proceed further.
> 
> I will try to not touch fec_main.c driver - just write standalone, new
> for MoreThanIP L2 switch driver.

It might make sense to refactor the MDIO code into a helper which both
can share? No point duplicating that.

> If somebody would like to use FEC, then he will insert the proper
> module. If switch, another one can be inserted, depending o the target
> use case.

This all seems like a reasonable way forward.

MoreThanIP is now part of Synopsys. I wounder if this IP now exists in
other SoCs? The press release however suggests Synopsys was
interesting in the high speed interfaces, not a two ports Fast
Ethernet switch.

	Andrew

