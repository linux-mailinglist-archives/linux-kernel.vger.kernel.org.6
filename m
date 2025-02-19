Return-Path: <linux-kernel+bounces-522459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2752CA3CA9B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4319189AD1C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E6C24E4CD;
	Wed, 19 Feb 2025 20:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="D+w2UoGr"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A160124E4AD;
	Wed, 19 Feb 2025 20:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998744; cv=none; b=SefpREr6hhQ8AR2kTEPr7eC8PfznMrl3F9sfQ9+bIEpFR7elWLgPyH+/AvBU0lLYbV5AfHRwodbKvP4zyC8uV5kS78niKEhTte7GCHbz5XeMaVIErRF65jjxQoGRViibRJoMUY7Do80/ziNBGW/8Kr+L7JopAuJrBCHCjfpuSdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998744; c=relaxed/simple;
	bh=ZHSwXiwOw9BSCREBbizXjK3EBY/6MOP6xU3lvA6h0Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/CeYLpo3GvLPhgzYb41kq0k2fNfoGvII+3jt5cWPNygA496EZoainkZc5RaWYje5oV5NiNWQndQtxU+mXG8X+R6S33pLsvCl59+yshBvOWGEmky3IcKU6X5l4IAWDwePWo0LWaqLAwoZeMvWDqvwEdpCQUX6t9mR2touKnMscQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=D+w2UoGr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3/GiwpKUC0VtliLMyFOL/35TN1+gb3/FfpGPJqii808=; b=D+w2UoGrSsMdTv0D3jnY/TU3fF
	l8BcDXVL7eyB5AetYcElVPSTZ1jHbRvSgYSNGpRJ5ywGtuVe2GNHmJx8mY7MQPL/k0uxAqWOcMxIB
	PlMcPegfosEysh5UTLw3fMTMyMlPDNc/JY9RyjQ0MULufZPoXKL68hlcQ96Mrn9aPL/Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tkr9i-00FkMQ-FM; Wed, 19 Feb 2025 21:58:54 +0100
Date: Wed, 19 Feb 2025 21:58:54 +0100
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
Message-ID: <3cebe152-6326-454c-9da6-5cf5a64f71c9@lunn.ch>
References: <20250219114936.3546530-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219114936.3546530-1-lukma@denx.de>

On Wed, Feb 19, 2025 at 12:49:36PM +0100, Lukasz Majewski wrote:
> The NXP's vf610 soc is equipped with L2 switch IP block from More
> Than IP (MTIP) vendor.
> 
> It requires special clock (VF610_CLK_ESW) to be operational.

So you have a driver for this switch? It has been talked about in the
past, but nobody made any progress with it. Ah, it was you in 2020. It
will be interesting to see what you came up with in the end, pure
switchdev or a DSA driver.

	Andrew

