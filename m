Return-Path: <linux-kernel+bounces-551940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 739EDA57329
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB533176124
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFA0257AC1;
	Fri,  7 Mar 2025 20:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdyTEp5t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB782571DD;
	Fri,  7 Mar 2025 20:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741381001; cv=none; b=sN4nL05DF3q88OaF40US/ezl1n7fateFw2z4BqTTRvV8NyGch+1SCxkH2pu7kXGPpRQfLXz9FlgRX95IicT4ff7WCH8DJvsdYeLPscpy2IPmpjSAyiAu9thg2LL1Z0Xi6DdHy1TtUcgUpi4qkAq4dfiLmEBL19LYzDgLodPC3fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741381001; c=relaxed/simple;
	bh=UAckJF2HilOwP3ulwN2y9cDVYluwjNJxb5hgmlPbQNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvXt274/yyH5LJ1jOk/ePibo5qRShg1URfIy32rJ+aFwIOvCaY/IcHjCozv49qRTibzdTycl5Bwc9t8yg0RrTNGXErTn1pmc6INdifJTWUG83DjFPRcysZctTOVzhC40su2hIjbi/sLPin+szs8L0qM9f8XE1CrAqRLA7qiFoeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdyTEp5t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BD1C4CED1;
	Fri,  7 Mar 2025 20:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741381000;
	bh=UAckJF2HilOwP3ulwN2y9cDVYluwjNJxb5hgmlPbQNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NdyTEp5tVfRsF5XrBIraoKeIZVFoJJHn5Soc2r4VTWIrLUyQ/6TDXxiJSU/NsycTD
	 m2+G6Xmt8M3vzIkZm1H4eCfU1EAamcmn/TNMg6QZrAj1iUOG1Ix/Rn2PaSNG/CToXl
	 Tlqr7T/yfOqitnuCvvq7Umt4ZsLRPtzpWrVntH2d0at20Rqji3ahwtCtX4kUM4Ik/9
	 JzjuXSCB074GTNlIcJCn40Fp0t98h9y5znmRMKBUnXp42smm+Llmj3LghgHEFybXeE
	 ta0zndbOeSAFhfY3/o+oaWsDco/F0GXng6UXW6/QTVzhkhQ24qehrFaWCf5KKjAApu
	 +mlSejzy/1gLQ==
Date: Fri, 7 Mar 2025 14:56:38 -0600
From: Rob Herring <robh@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Sugar Zhang <sugar.zhang@rock-chips.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH 3/7] ASoC: dt-bindings: add schema for rockchip SAI
 controllers
Message-ID: <20250307205638.GA595584-robh@kernel.org>
References: <20250305-rk3576-sai-v1-0-64e6cf863e9a@collabora.com>
 <20250305-rk3576-sai-v1-3-64e6cf863e9a@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305-rk3576-sai-v1-3-64e6cf863e9a@collabora.com>

On Wed, Mar 05, 2025 at 10:24:23PM +0100, Nicolas Frattaroli wrote:
> Rockchip introduced a new audio controller called the "Serial Audio
> Interface", or "SAI" for short, on some of their newer SoCs. In
> particular, this controller is used several times on the RK3576 SoC.
> 
> Add a schema for it, with only an RK3576 compatible for now. Other SoCs
> may follow as mainline support for them lands.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  .../devicetree/bindings/sound/rockchip,sai.yaml    | 151 +++++++++++++++++++++
>  MAINTAINERS                                        |   6 +
>  2 files changed, 157 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/rockchip,sai.yaml b/Documentation/devicetree/bindings/sound/rockchip,sai.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..8f5a292a7f2a6c737d983d00cbe40ec45bfa6249
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/rockchip,sai.yaml
> @@ -0,0 +1,151 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/rockchip,sai.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip Serial Audio Interface Controller
> +
> +description:
> +  The Rockchip Serial Audio Interface (SAI) controller is a flexible audio
> +  controller that implements the I2S, I2S/TDM and the PDM standards.
> +
> +maintainers:
> +  - Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: rockchip,rk3576-sai
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  dmas:
> +    minItems: 1
> +    maxItems: 2
> +
> +  dma-names:
> +    minItems: 1
> +    maxItems: 2
> +    oneOf:
> +      - const: tx
> +      - const: rx
> +      - items:
> +          - const: tx
> +          - const: rx

You can simplify this to:

minItems: 1
items:
  - enum: [tx, rx]
  - const: rx

(By default, we require unique items, so '"rx", "rx"' won't be allowed.

Rob

