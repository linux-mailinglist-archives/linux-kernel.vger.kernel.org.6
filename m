Return-Path: <linux-kernel+bounces-367212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5795E99FFD4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAE59B21AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAE4186287;
	Wed, 16 Oct 2024 03:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="To5K0PkP"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF89F15C147;
	Wed, 16 Oct 2024 03:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729051085; cv=none; b=XxWPi+u2SxxnXlk42CrPIvpokDvPBfbwlPFUj6argoeoYTOl3SNoXmUQ+EP4dGCwMh1TSHcZl712lbYt1UpUjD6eGZavmTUVTAg8yD1whKkC2MEM+ePAJue+g5gFJxyalZZ/PK/fdiQPcMPmlwLPSwcI0st8Rz798nJ4UO4nyMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729051085; c=relaxed/simple;
	bh=AUrvuR2ymd8Mej9q1LGhcoC/J9ZSPaVJkk7ksDlHK94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dA80XHVzynmniqy+bCuwcuNO/cYmGhDLBBRxwboYTtvutUx4uURCUI3zVFIv4fd5WlvsJybKoMnwIjghIV4sMK5LdIHVs5rfBU6kZ567UhinMMnbuMon16c54CAUfhSWTvaEPlwAiW3zNKTnzNyHj0gM9AnFaIq0lxvs27clAa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=To5K0PkP; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=DOiS8h2BdFO/CzAOb+ly1+17VkRnItoKFb4CSNHU7/4=;
	b=To5K0PkP+aAh0eS8cUaZESBOEvL5b/GVvuoxymfP6rdRIlaTV8mt6J9xvHsREx
	W8Kf+DJz4jkPabb0Tr1LogxrkdI1bvR1Z/6Ya50oL/6+9s8kt2mEbGJXsoGt2hIo
	p/wgtfGfQaPAtpZaftySRQ+XA0qMVeAjnQ5sMw5Cgz5eQ=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgC3fqhQOQ9nq_UVAA--.261S3;
	Wed, 16 Oct 2024 11:56:03 +0800 (CST)
Date: Wed, 16 Oct 2024 11:56:00 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frieder Schrempf <frieder@fris.de>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Josua Mayer <josua@solid-run.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Michael Walle <mwalle@kernel.org>,
	Parthiban Nallathambi <parthiban@linumiz.com>,
	Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v3 0/3] Add support for Kontron OSM-S i.MX8MP SoM and
 carrier boards
Message-ID: <Zw85UEd7R5bU/S6P@dragon>
References: <20240904085415.645031-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904085415.645031-1-frieder@fris.de>
X-CM-TRANSID:Ms8vCgC3fqhQOQ9nq_UVAA--.261S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU7fHUDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiERV6ZWcPEbaO3AAAsG

On Wed, Sep 04, 2024 at 10:53:18AM +0200, Frieder Schrempf wrote:
> Frieder Schrempf (3):
>   dt-bindings: arm: fsl: Add Kontron i.MX8MP OSM-S based boards
>   arm64: dts: Add support for Kontron OSM-S i.MX8MP SoM and BL carrier
>     board
>   arm64: dts: Add support for Kontron i.MX8MP SMARC module and eval
>     carrier

Applied all, thanks!


