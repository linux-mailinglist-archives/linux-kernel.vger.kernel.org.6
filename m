Return-Path: <linux-kernel+bounces-312488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543E096975E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC828B2388C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9C82139D2;
	Tue,  3 Sep 2024 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="NeA4af1n"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB2D1A265F;
	Tue,  3 Sep 2024 08:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725352792; cv=none; b=krNSPZuRGyHehAh7OKam83S4hMqSro1CI0t1isKzRLrAn92tU1ZJ27zsuQUVcRruWMzax/R29c2p0h0ksGbxtiQsaVpFmQAfqWdzbmCTJOMYdT3QOAbgG86l9F99H8dpCULjvZIHjKUQl/Q0u2GUdGKdDIDmlcoEC/sbiwxAQNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725352792; c=relaxed/simple;
	bh=mrBrZeX3pZ9wRZJbHHpcB1Uzkac+lynRVTT+L9xIkqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpAqFlWUUTmieSQuHG7RFyojCBGINCYr01XK1IR6BNnIXlujdEvvRm7AjCl7IzpQB5zUVx6Bl6852HxsCuKK9+7RYV6/qE64mIX17WFdSN5+05JjBuEwLpVxYqm/lSV9ZN2OC+FH6CCsDZiMS4pClEx8Sq4nTrLcLM03TVvhzbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=NeA4af1n; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=klQLUQYC0Iq8lFRsov9BQeOh3b0gq2reax6p5YSo9Vk=;
	b=NeA4af1n22V1F9gf2uVQenRVUtjTYVj0yOrWD0nIRujqxhaUKCogrZFgpyK3gF
	i4MxonZMIbVWr9BOJLEiPPFYiCwflyi2cJ4iOxUqIxYYb2C6OsICWl2COdlxYQqq
	fgBLcaSNE02VpjY5g9I3+asjcd93vAIg/W9NwtY+IBlUM=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgD3XzwGy9ZmaWpdAA--.52316S3;
	Tue, 03 Sep 2024 16:38:32 +0800 (CST)
Date: Tue, 3 Sep 2024 16:38:30 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Tarang Raval <tarang.raval@siliconsignals.io>
Cc: shawnguo@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	festevam@gmail.com, Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Parthiban Nallathambi <parthiban@linumiz.com>,
	Yannic Moog <y.moog@phytec.de>, Josua Mayer <josua@solid-run.com>,
	Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/2] Add support for Variscite Symphony board and
 VAR-SOM-MX8MP SoM
Message-ID: <ZtbLBt/RhGim78uH@dragon>
References: <20240902134512.16717-1-tarang.raval@siliconsignals.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902134512.16717-1-tarang.raval@siliconsignals.io>
X-CM-TRANSID:Ms8vCgD3XzwGy9ZmaWpdAA--.52316S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU-4SoDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEQNPZWbWyfkEBAAAs4

On Mon, Sep 02, 2024 at 07:15:06PM +0530, Tarang Raval wrote:
> Tarang Raval (2):
>   arm64: dts: imx8mp-var-som-symphony: Add Variscite Symphony board and
>     VAR-SOM-MX8MP SoM
>   dt-bindings: arm: fsl: Add Variscite Symphony board and VAR-SOM-MX8MP
>     SoM

Applied both, thanks!


