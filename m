Return-Path: <linux-kernel+bounces-555342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3486A5B5F1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 02:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D86D188B790
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 01:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22101E0E0C;
	Tue, 11 Mar 2025 01:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="O8Iu6ebB"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F601DF25D;
	Tue, 11 Mar 2025 01:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741657190; cv=none; b=PKupW26hw/t/D6U1vTtfjcAzwkgNvn3yxSmGLyGKfWsBft420mrdhc6vnmWpftFZmQOQ+uEqgP/5s8oRFfOTNQdSlEEW1KF+++ejIB1FQlQzRm5FWzkfJ7+dGZAgAOHR0adp3MxxcWFKTja7YVIIDjyKwWO25dQwG7B/gxIKsp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741657190; c=relaxed/simple;
	bh=RqPfnh/4IjE+WtsfZvkx6YqNHsgX5Uso7lCYLf0mcyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyLkmoKJw3lYzFLdW6vcLJGeBAIKyzlw2TD1wV6yOryNgTVgq6uWOJwxDTHl4qZERmZkSmlPeBR3xW71jVpDysOO1QikvbBsy/kSSJZYWP0pwj5B+6dPcmMy4CeVqlVpK39tRFVj/EYK/pMpSegVotrRgB68n0rHMKeWSdEZXMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=O8Iu6ebB; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=VJT4xsqbCeKyk7dx2NmpkzCo8Yb5OL/Hrsp+1j5RBYs=;
	b=O8Iu6ebBGznucoDxC+RfhL7A/nGyaoT5hck34WWzMoW1onI5FYl7g5NiF746J/
	N5u/1QGZY9Zo3xcmxvwI5uph9f5XMBH1TKcCkJ/kmU4Xg2qY/0c70+cq2mBhSnBa
	coN6uxisRc7hTlX1LziCcQNsBLPbsy4grYM2ZiULjj7o8=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgD3H27uk89ng7SzAA--.51122S3;
	Tue, 11 Mar 2025 09:37:52 +0800 (CST)
Date: Tue, 11 Mar 2025 09:37:50 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Frank Li <Frank.li@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Abel Vesa <abel.vesa@linaro.org>, Marek Vasut <marex@denx.de>,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 0/6] arm64: dts: freescale: imx8mp-skov: switch to
 nominal drive mode
Message-ID: <Z8+T7sdtIsvkJ1i2@dragon>
References: <20250218-imx8m-clk-v4-0-b7697dc2dcd0@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218-imx8m-clk-v4-0-b7697dc2dcd0@pengutronix.de>
X-CM-TRANSID:Ms8vCgD3H27uk89ng7SzAA--.51122S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVNeODUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEh0NZWfPVKmw0gAAsQ

On Tue, Feb 18, 2025 at 07:26:40PM +0100, Ahmad Fatoum wrote:
> Ahmad Fatoum (6):
>       dt-bindings: clock: imx8m: document nominal/overdrive properties
>       arm64: dts: imx8mp: Add optional nominal drive mode DTSI
>       arm64: dts: imx8mp: add fsl,nominal-mode property into nominal.dtsi
>       arm64: dts: freescale: imx8mp-skov: configure LDB clock automatically
>       arm64: dts: freescale: imx8mp-skov: operate SoC in nominal mode

Applied 4 DTS changes, thanks!

>       clk: imx8mp: inform CCF of maximum frequency of clocks


