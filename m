Return-Path: <linux-kernel+bounces-391987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F349B8E3A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 022BA1C21100
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 09:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEFD15B111;
	Fri,  1 Nov 2024 09:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="DIUCuVzO"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985F015A84E;
	Fri,  1 Nov 2024 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730454979; cv=none; b=iOiZhOADQJ5lKS7chkK7v6XulPuFXwlQIfLJF43qJ0VpIm/mWTVOBAP2b39oYSj/aUhLxb9Ewv/ESbU8gl1Y/zWtJJlQIV21FKXXondlw9N5EUFnC217FR+I/gj4mXCifXyHh0ChZMKkW68EUZLpumkeCFTlKWJokbktm2BJWpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730454979; c=relaxed/simple;
	bh=hcdrHvBdSayh20IlsZd2/zMiEOuiRDwG6vj9+sFNh+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0rcii+UeIWgQfO4Xo0dOE7cuWhw8Dvhep9iAD+K9bx/sCLYroqRoZQ21n6VHZhzBhI8FueW+5punHjTDvRU/9H42VSXG7afdlkbCMCyetOSi+uZDaJ89sdEhVoh7vOyuHqJLEv4X8Ayh1j4FM7IrlAlDp2WxD5bZKj5ouSuI1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=DIUCuVzO; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=fD3ToTjQf4BqeyTCfHtwZ8RgkZVabkJNf3RDZfdMhXI=;
	b=DIUCuVzObRcn55/bgNdO5lV3W+fQPBj8gf7ig2mHznWlQhyJ3tjJ9eypWVMUjg
	u81wid9DJrVfSV3OV1/KTp7/TLPlhq24KGIFrGYyX+oSI3dO0LRIBBiQlKd79zfi
	tND3QrQQshxTXoHGVfjxDqhBiySb7WY6DggSQR010gPVw=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDXXy9cpSRnohlpAQ--.37559S3;
	Fri, 01 Nov 2024 17:54:38 +0800 (CST)
Date: Fri, 1 Nov 2024 17:54:36 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
Cc: shawnguo@kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Michael Walle <mwalle@kernel.org>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Parthiban Nallathambi <parthiban@linumiz.com>,
	Max Merchel <Max.Merchel@ew.tq-group.com>,
	Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/2] Add support Boundary Device Nitrogen8MP Universal
 SMARC Carrier Board
Message-ID: <ZySlXDDG7jRxl0n9@dragon>
References: <20241023091231.10050-1-bhavin.sharma@siliconsignals.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023091231.10050-1-bhavin.sharma@siliconsignals.io>
X-CM-TRANSID:Ms8vCgDXXy9cpSRnohlpAQ--.37559S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4VWlDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAhqKZWckfBh4iAABsh

On Wed, Oct 23, 2024 at 02:41:13PM +0530, Bhavin Sharma wrote:
> Add initial support for Nitrogen8MP Universal SMARC Carrier Board with
> Nitrogen8MP SMARC System on Module.
> 
> Change in V2:
> 
> in patch 1/2:
>         - Drop Unneeded line
>         - Correct the indentation
> 
> in patch 2/2:
>         - Add Acked-by tag
> 
> CHange in V3:
> 
> in patch 1/2:
> 	- In version 2, I forgot to add the Makefile. Adding it now.
> 
> Bhavin Sharma (2):
>   arm64: dts: imx8mp: Add Boundary Device Nitrogen8MP Universal SMARC
>     Carrier Board
>   dt-bindings: arm: fsl: Add Boundary Device Nitrogen8MP Universal SMARC
>     Carrier Board

Applied both, thanks!


