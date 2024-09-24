Return-Path: <linux-kernel+bounces-337601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEB7984C36
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1491C22ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB0E13B284;
	Tue, 24 Sep 2024 20:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bodrovcq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154C026AD0;
	Tue, 24 Sep 2024 20:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727209996; cv=none; b=bGtpKS8o69UowtsUdYQPNyU15xHqvVoYoy53ScUMN2p6Dv5hTDuFAU6T/gKt+Nq+HDLRj6tO+a4bIJ2zlsRmF8NLTAy1pLIyFVwo6kWTZJIIkSXZ9sN2AE5sUct7voke/2OfIGAy+pBRnyVL+KX1dCB/z2UPt5NVpfk9zAtglNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727209996; c=relaxed/simple;
	bh=McE1ehFOOaO9ZsLkHofB1vea/POcgDPEQ4Svju5Kh8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6VlWjlW/+s1z0BMQrhJKNZe0pXQAX2VCJ9rHYAmNtDASA05G50uI9PNI+YuV1WrJvn8h5UoBRt0Z1OQOh+vBPjqcZJdaoS1s4FyGeDCWuSywkFnYWrQVA1cw4GAGR5Ud3B8lhk1QY8tAYymmZZvWDeJMrciT8JAX8Enma42XGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bodrovcq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CB2C4CEC4;
	Tue, 24 Sep 2024 20:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727209995;
	bh=McE1ehFOOaO9ZsLkHofB1vea/POcgDPEQ4Svju5Kh8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bodrovcqo2at7klVob1pQ8dfshpDN3ftJaleaWJhqKX0QyftgtY0HZBhdiSUEnQOj
	 NRDpHVdnC4XJB+AfXU/uqU3dVQosPVr7u/SE+x6LOyY0m5vpBCFVR8h8gr1rifkNkn
	 9WfOZp2Q4p4/MoWfLZTvJSsHgbuAwjwNweWvNTgsTwyKUPiiZmq1BYC6mLETTLwKV5
	 EXtHoYpgZJqalgyxmGMYDstfj2SkYzOWwGqissDa2154PZuGHbYlOvkI31Iouoh3Eh
	 J9EBYeakfhnX6EGA+KyXAQQJPum4vuSkO7UNUQNn/9kGmFzfcVL/i5sD3fvgdd1G4W
	 4L0lF1Ti8X/7g==
Date: Tue, 24 Sep 2024 15:33:15 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	linux-mtd@lists.infradead.org, Fabio Estevam <festevam@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-kernel@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: mtd: jedec,spi-nor: add optional
 vcc-supply
Message-ID: <172720999440.288956.7630447926663790865.robh@kernel.org>
References: <20240920-spi-v1-0-97f220c2e10c@nxp.com>
 <20240920-spi-v1-1-97f220c2e10c@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920-spi-v1-1-97f220c2e10c@nxp.com>


On Fri, 20 Sep 2024 16:54:06 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Introduce optional vcc-supply property, spi nor flash needs power supply
> to work properly. The power supply maybe software controlable per board
> design.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


