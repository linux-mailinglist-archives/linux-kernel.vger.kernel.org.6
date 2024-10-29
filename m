Return-Path: <linux-kernel+bounces-386677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 321349B46C9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA891F21C2D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27A2204F84;
	Tue, 29 Oct 2024 10:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l7ztNarw"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967A520493E;
	Tue, 29 Oct 2024 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730197533; cv=none; b=dcpYDdPElBsyLVjkY3hhQrtOuDJ13sGVyd8oi+VWwbCP/uEEDrF/i9TEXRRbSj0pGGb/cnsKn1YB3IfisIzF+p8J7m+dsKDPeE0EyLU2O1kvBPFpUnPA8kUefTd2RjODsdscaDoK1j+SxAyJvS+WqMEka8D7zVO9hUjFfVKXVs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730197533; c=relaxed/simple;
	bh=y9NumT39ftBDSQuti8WYEfIhUghcFJ6KxtciHYnMAWk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o3bNV2srxY6c652tcUDb/uSfkbTTPGifiRqoKCHcCGxcmb4QWYk8o5JZ8Ulm1J2o3/qSr40UZEiW007QLuU0lgxQVDgcEc0RNZhIHUzjHOZk4iOy0I2SLaTCEfW+rRHdVV9ndaMT3AskxUiO2eK3hldJl1YI9i/8NCX3QVLKDfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l7ztNarw; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DB8794000A;
	Tue, 29 Oct 2024 10:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730197527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eUH/rpUCPGOSk8YLeW4XbiRH5XfXa3Tcsoj64v3K+ko=;
	b=l7ztNarw6Olae9y03XSNGT6NuOTvnLXgSjsvasgyAVvwdLNliuiwu7cI+mDPhDiqK/9nzd
	XH5pUsIItxtEdoSzaSOswy8lej4ARU3m1bmjE0z3oObD9TTG4CPEbz4P8bRIrEmMkQsA+D
	J8FFye+ETWgxJEqMWBTHtguSoRFdTADi7DpisIBivWERpRDKLasuV5tn7MteFzCzQbE7Tc
	vpdcKL8MseN+lSqtLFZIoUD89wTaFt1WFVsLRZxYQahGPEqJDBiG1q0n6aPXcU97BFm33h
	QtVPsR9lCJRy4jEihJyst+Zsp9QteKZxqhvqlZ3PBXR9s9vODELGkJvfhTQw3w==
Date: Tue, 29 Oct 2024 11:25:25 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Dmitry Yashin <dmt.yashin@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: rockchip,rk3308-codec: add port
 property
Message-ID: <20241029112525.50c15b60@booty>
In-Reply-To: <20241028213314.476776-2-dmt.yashin@gmail.com>
References: <20241028213314.476776-1-dmt.yashin@gmail.com>
	<20241028213314.476776-2-dmt.yashin@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Dmitry,

On Tue, 29 Oct 2024 02:33:12 +0500
Dmitry Yashin <dmt.yashin@gmail.com> wrote:

> Fix DTB warnings when rk3308-codec used with audio-graph-card by
> documenting port property:
> 
> codec@ff560000: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Dmitry Yashin <dmt.yashin@gmail.com>
> ---
>  .../devicetree/bindings/sound/rockchip,rk3308-codec.yaml      | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3308-codec.yaml b/Documentation/devicetree/bindings/sound/rockchip,rk3308-codec.yaml
> index ecf3d7d968c8..2cf229a076f0 100644
> --- a/Documentation/devicetree/bindings/sound/rockchip,rk3308-codec.yaml
> +++ b/Documentation/devicetree/bindings/sound/rockchip,rk3308-codec.yaml
> @@ -48,6 +48,10 @@ properties:
>        - const: mclk_rx
>        - const: hclk
>  
> +  port:
> +    $ref: audio-graph-port.yaml#
> +    unevaluatedProperties: false

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Also, why not adding a 'port' node to the example below? Can be done in
v2 in case you send one.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

