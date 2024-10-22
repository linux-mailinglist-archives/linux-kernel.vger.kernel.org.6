Return-Path: <linux-kernel+bounces-375380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8E19A9543
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4DCC282ECE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E918063C;
	Tue, 22 Oct 2024 01:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Tz7ikGwr"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D3213FF5;
	Tue, 22 Oct 2024 01:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729559420; cv=none; b=nZo7esLLFBMhLiwajw5JROfpmUlDlbryiwE3ne1RN3cmmjwo3W9VvgkFkBJVWDrYDn60xnxqt2cg5uIW1SW8iU1sg9t7YZZWEzcJgi5+RUezzWI1G98YRU8EI3NSNXVW/KObOP7jb25hfT3fxgugq+/r+Kfu8no0KUP296i2kh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729559420; c=relaxed/simple;
	bh=ibj3h7uU1sdJL+wHMspk7cWzqnWpMrRzWC/HrPMNItg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEYtEtFvhC1g41CHgAYJTa6e/a1ILzIgkDs9yUWFIPNbWcMzL84i3NFc/9s7IEeBaGaZFSboXPgjDc34XU2tNN/o2KB01ZO9pMFZl32QfaWTX+nZXsHCjE8tJFVD1Y5A0LWop9SoGmFJyxe3bwOzlCwNNGahNax9u/vrABxO6TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Tz7ikGwr; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=yny7DH00g8qimPwt52mB/AR4FqZsA3NDX0M5M5+ipOo=;
	b=Tz7ikGwrudkRr0lF23LZocqwgFFQvRxIV6CBGxtqvtTdpqbDyekqYSSQRbg5fW
	3nVj+xjxVpnIUj29IluDzBKypzDFjQdiZFU0OLxFqM6dUj5tdiE3RRCUD+gjt4Al
	DJVYdXIuIKJFLl9Ei+a+dD2j3SL+itxzKyFZhZoYyinnk=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgBHv4H6+hZnE8qUAA--.5293S3;
	Tue, 22 Oct 2024 09:08:13 +0800 (CST)
Date: Tue, 22 Oct 2024 09:08:10 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frieder Schrempf <frieder@fris.de>
Cc: Conor Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Parthiban Nallathambi <parthiban@linumiz.com>,
	Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Subject: Re: [PATCH v3 0/4] arm64: dts: imx8mm-kontron: Add HDMI and LVDS
 display support
Message-ID: <Zxb6+iG7Lcrt5No1@dragon>
References: <20241008143804.126795-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008143804.126795-1-frieder@fris.de>
X-CM-TRANSID:Ms8vCgBHv4H6+hZnE8qUAA--.5293S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUOtCzUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAhKAZWcW3kZBnQAAsA

On Tue, Oct 08, 2024 at 04:37:42PM +0200, Frieder Schrempf wrote:
> Frieder Schrempf (4):
...
>   arm64: dts: imx8mm-kontron: Add support for display bridges on BL
>     i.MX8MM
>   arm64: dts: imx8mm-kontron: Add DL (Display-Line) overlay with LVDS
>     support

Applied both, thanks!


