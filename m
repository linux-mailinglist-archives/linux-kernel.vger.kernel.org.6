Return-Path: <linux-kernel+bounces-524043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4259CA3DE5B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1533516A418
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DD41FDA8E;
	Thu, 20 Feb 2025 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="C+pbWdUp"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915521D5CFB;
	Thu, 20 Feb 2025 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065010; cv=none; b=Ysnz+SrXwLQIDZ/7I2El8EXJ8gTE+KsIHvrXtzR+mH3KAFN3nFP8jCSYZPeMtB0i4D2NplDBGePgxKEmG8ph5HtDQFKRgZz6dCgtCi7MhcJj9dl4Xi01lGBVPtJF4JILvN58dZSQCqUultmCz2ckUpwrjYz/xnZSjQEI2DWreYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065010; c=relaxed/simple;
	bh=857IyU52xW+51h1kUegUUYCv0nuT4T0ZRmSW+2m+clk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/Em49y9roaULMoWqX/3gxophG5m2EY1Duyrrj1lQAnlinjrMKxcVBJlx0Rs8YjEesMV5fod6ntz8UICC7vBbwtqLv/j4JEp904BmvrBdTv524//X1Hkbz/GlUXEurRN0r3FZmq/ftQwBJg+B/trAp4JednQ5zkMp97OJh4t6s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=C+pbWdUp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QHgJz38bfp6rGW5Vo/Ip3UFCsgToQN+AI1DehaCYgGw=; b=C+pbWdUpusHCcABHrf4mEFpvSl
	Ct2Eo2ufrgz7aCjTc6iX/r9B/1CG2nwXezYc66eyQB+GOzsc+b3q6Sz9E6XyKRX/cJ3Rge6kYIpFx
	ORFt+wE+Q6gzwREeHYpuWEY+sT9QexH1wioDE6+SJTuMZCoLlPrgc/xu0X8LpRDcMBUM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tl8OY-00G0Dd-RG; Thu, 20 Feb 2025 16:23:22 +0100
Date: Thu, 20 Feb 2025 16:23:22 +0100
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
Message-ID: <f68ebe15-69ee-428a-8079-8bb05d7aa21b@lunn.ch>
References: <20250219114936.3546530-1-lukma@denx.de>
 <3cebe152-6326-454c-9da6-5cf5a64f71c9@lunn.ch>
 <20250219233802.20ec53e5@wsk>
 <5a9d9eef-f2ca-4168-aca4-4419dcfcacb6@lunn.ch>
 <20250220154826.3455b15e@wsk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220154826.3455b15e@wsk>

> > Seems like a reasonable compromise. You would only load this driver if
> > you intend to make use of the switch...
> 
> Yes, the main use case would be the switch (after bridge ... command
> called).
> 
> However, until then we shall? have port separation.

Yes. The model Linux uses is that the ports are individual interfaces
to start with. We should keep to that model.

> > MoreThanIP is now part of Synopsys. I wounder if this IP now exists in
> > other SoCs? The press release however suggests Synopsys was
> > interesting in the high speed interfaces, not a two ports Fast
> > Ethernet switch.
> 
> I would need some detailed documentation....

Which is probably not available. You might be able to get some clues
from the Freescale datasheets, if they have kept the address spaces
separated. I don't see it as a strong requirement, given how old this
IP is, and the limited interest in supporting it over the years, My
guess is, nobody else uses it.

	Andrew

