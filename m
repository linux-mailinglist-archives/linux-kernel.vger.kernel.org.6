Return-Path: <linux-kernel+bounces-420874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267ED9D83DE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E158428A7EE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB79F194137;
	Mon, 25 Nov 2024 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="ZYfrj838"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B3E192B7F;
	Mon, 25 Nov 2024 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732531988; cv=none; b=LL014ecsm0RxFp2j6JTA1aRtZ9xZbuyeHRUxHDBWmOFLe412SSrY/RAjZPAX5RD3SuBoDmieejcCWZafeFrUcsVo0nb5laoTTlSwUPC7PG4XGQtMNL4CJVBKBsy40uqIMaS6vqGlm3GyYRkuroc5nYYnXp7AvuRTxzdgjsGnt3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732531988; c=relaxed/simple;
	bh=3jcBf0eL6Gi2Rg6poX5bDC7FF84+Wlh4gqM+ewFsiIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYvaKV1DcopHj1cuWcO07QHiYEa48InQTHdm/X5+kAwTYTKYIDzStXooseAr8+xyIk2HcGv8YqmncUfVftm/ODkR5Lu43Z0knjzNaaYUlfOSpmo0CJXNSg+wJ7ozjGNc0ISpqX7tgiFCgNmEV1T0gO72XuQPWs7EWnX0CRXat1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=ZYfrj838; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 1E756262A7;
	Mon, 25 Nov 2024 11:52:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1732531978;
	bh=hmQWA+nwpDDcGMMWDzj5b5llGkioHK+B9GAwscWHsf8=;
	h=Received:From:To:Subject;
	b=ZYfrj838yqQBq+MD5xjL1RdFq/zTs84dqXtTqrLEVI0BvgjI7PabTQ+4t8f3ceZx1
	 +bgbcTJZG7kJm4sOAnseL56ApNbSwEcXv/OEmNp6qXqdzdEkw1FK5JlaHxMKxaFuzT
	 Mvi8WDOvCkgBqs6ZuhRkXzc0NC56CBxP7xMrpBfZ4ltng4O+6hYdQvaxyo0xd/x+aK
	 a7I2mVi6aU8U9duQei/4IcijBLyfFagIRTjS5R4R4qCxTPaulnhlTbOLpex4GQvrdX
	 d86c5tDbtN75uV2MqQ/fauaRApXM9BOtbWOQmhUhhqHd8TNHTBcouEc1vNdB8K8C75
	 8VrGTNu6GvA9g==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id ADFCE7F996; Mon, 25 Nov 2024 11:52:57 +0100 (CET)
Date: Mon, 25 Nov 2024 11:52:57 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	p.zabel@pengutronix.de, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, glx@linutronix.de,
	vkoul@kernel.org, kishon@kernel.org, aisheng.dong@nxp.com,
	agx@sigxcpu.org, francesco@dolcini.it, frank.li@nxp.com,
	dmitry.baryshkov@linaro.org
Subject: Re: [DO NOT MERGE PATCH v4 16/19] arm64: dts: imx8qxp: Add display
 controller subsystem
Message-ID: <Z0RXCYZ_7fBvpcvd@gaggiata.pivistrello.it>
References: <20241125093316.2357162-1-victor.liu@nxp.com>
 <20241125093316.2357162-17-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125093316.2357162-17-victor.liu@nxp.com>

On Mon, Nov 25, 2024 at 05:33:13PM +0800, Liu Ying wrote:
> Add display controller subsystem in i.MX8qxp SoC.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

...

> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index 05138326f0a5..35cc82cbbcd1 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -20,6 +20,27 @@ / {
>  	#size-cells = <2>;
>  
>  	aliases {
> +		dc0 = &dc0;
> +		dc0-constframe0 = &dc0_constframe0;
> +		dc0-constframe1 = &dc0_constframe1;
> +		dc0-constframe4 = &dc0_constframe4;
> +		dc0-constframe5 = &dc0_constframe5;
> +		dc0-display-engine0 = &dc0_display_engine0;
> +		dc0-display-engine1 = &dc0_display_engine1;
> +		dc0-extdst0 = &dc0_extdst0;
> +		dc0-extdst1 = &dc0_extdst1;
> +		dc0-extdst4 = &dc0_extdst4;
> +		dc0-extdst5 = &dc0_extdst5;
> +		dc0-fetchlayer0 = &dc0_fetchlayer0;
> +		dc0-fetchwarp2 = &dc0_fetchwarp2;
> +		dc0-framegen0 = &dc0_framegen0;
> +		dc0-framegen1 = &dc0_framegen1;
> +		dc0-layerblend0 = &dc0_layerblend0;
> +		dc0-layerblend1 = &dc0_layerblend1;
> +		dc0-layerblend2 = &dc0_layerblend2;
> +		dc0-layerblend3 = &dc0_layerblend3;
> +		dc0-tcon0 = &dc0_tcon0;
> +		dc0-tcon1 = &dc0_tcon1;

what would you use those aliases for?

Francesco


