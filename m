Return-Path: <linux-kernel+bounces-233993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F4391C082
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3FEA28548E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991B01BF329;
	Fri, 28 Jun 2024 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ahnfd0qh"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7308619B5A2;
	Fri, 28 Jun 2024 14:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719583800; cv=none; b=h2ffSy3fu+QKMcZqyipBw7r8VNyHn9WzQq+ji7XiSJenhGk+H8VdvCwlVOQR8Z4JdyHmKdmOU2m/dYh9GsfavLllKwVKNvtSoDvu9XucZLFnyQQ02WkrjtCLJ3AvabPO8zInsIYnLh415fsdyj7ZsAev9dVQPfBAHdSXsiwrpbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719583800; c=relaxed/simple;
	bh=uOtQMuL1X1bCXgLRk8CEj7G6Dj5LK1iiftQXY+Rv9Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1omIVBGRdVtnLPTrt8BKY8z2/S214iMGylhI6a2nK5V/scEPFa+dZDWkKN5sWOlvuitvd3MyOlZYviK1wRYtDVOzSH88mGM/Q++G+ONQ23nFZNubvaaGjPnPfjhdRP1Sqcrl1wNNpQn+sKg0w4Gt3JuG0JabTQuxbck87X42uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ahnfd0qh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=p9/TdaF6sDe7VwbrSuMbzC40JZtDM24SJtp78alf1DY=; b=Ahnfd0qh/15hFWKLitt7TYAlxC
	qlfisPoWXjQK5TrxnqMA34GdmjB78L1VZufe8mes3tP3D0HqwL8NsJB8dQLCd6xaTNwebKYge8dhQ
	9VtTKjAP/uETAaHtjbITw3pVgalTT1z0gQD8yL7eB0DQEhh4eaSCQlFFbreP826Nmops=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sNCIS-001HzG-5N; Fri, 28 Jun 2024 16:09:52 +0200
Date: Fri, 28 Jun 2024 16:09:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Peng Fan <peng.fan@nxp.com>
Cc: Marek Vasut <marex@denx.de>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@dh-electronics.com" <kernel@dh-electronics.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: imx8mp: Update Fast ethernet PHY MDIO
 addresses to match DH i.MX8MP DHCOM rev.200
Message-ID: <6687963b-1cbf-4093-aa8d-b90ce9ba7c0b@lunn.ch>
References: <20240627233045.80551-1-marex@denx.de>
 <AM6PR04MB5941804BFE1CC6F72E776F9588D02@AM6PR04MB5941.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB5941804BFE1CC6F72E776F9588D02@AM6PR04MB5941.eurprd04.prod.outlook.com>

On Fri, Jun 28, 2024 at 01:01:49AM +0000, Peng Fan wrote:
> > Subject: [PATCH v2] arm64: dts: imx8mp: Update Fast ethernet PHY
> > MDIO addresses to match DH i.MX8MP DHCOM rev.200
> > 
> > The production DH i.MX8MP DHCOM SoM rev.200 uses updated PHY
> > MDIO addresses for the Fast ethernet PHYs. Update the base SoM DT
> > to cater for this change.
> > Prototype rev.100 SoM was never publicly available and was
> > manufactured in limited series, anything currently available is rev.200
> > or newer, so it is safe to update the DT this way.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > ---
> 
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

