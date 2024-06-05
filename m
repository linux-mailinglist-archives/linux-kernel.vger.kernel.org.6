Return-Path: <linux-kernel+bounces-203404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F5A8FDA63
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53FD71F2220A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003CC167DAE;
	Wed,  5 Jun 2024 23:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGZZ8HD8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D8B16D336;
	Wed,  5 Jun 2024 23:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717629730; cv=none; b=uF27DR1hgb+sZnU+7sNYQ49wgzEl3Rgr7L1WU8/adrDAnRDzJNWjVZMux6s9fvJHr4/ybK8fQf4RuRHqsNHooqSg7f5EQEpgsPmeS624gZujTIHm5qJQ/0alg+EimlBKlFbuoSZJN0xa6jjMfy0t+yk3aCkw+2nqisWOMvxmjaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717629730; c=relaxed/simple;
	bh=XPL0NllaL6Uk5BD+SwKrbhuEPF/y1e3rhDVOFvsQHDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qx1X4mXYL+4/lJ6rJQuycQgJmRY9v/9aq/EtulrtDyT9jFyqYUXLASoC73yZ9DnWBO0Scje9blbm40ZkxH4m1dX6q4c+RAN/HTXAjEjz3LC0jIEZXR3NeRzymc7stQvckfeK40dfC5T8fBhbtn3Zko8Rd5XxSoBruI1cO5lhcFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGZZ8HD8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C6EC2BD11;
	Wed,  5 Jun 2024 23:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717629729;
	bh=XPL0NllaL6Uk5BD+SwKrbhuEPF/y1e3rhDVOFvsQHDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bGZZ8HD8FzultabdV9ttkxSlLITCB/QG9WzPaX++/yLnA77h+G+615QE2Wdt66b48
	 Pxft1zXv5mYubfihiQkrhajbx7IgMspSqSD8zpZ0E5T9NyDUxIIWixWCmfSbFQQAOB
	 PNxnV7mc+knvx5GBCZ250i7RdJDJiDBCUoldzdGpGv5Rqp1A12OJfINdghMfEzlAJW
	 hrsxDwBxYGUrjISiB62yk6v9IXzQR/9WbD8/KeCNCjjZEwLFgQvzG+kQmb9uo04YHr
	 8hYralA8y1witEvspIpNIjJYemqgA8FYigJzBLOm09h8OvY5I6HP2DVqHkfpDd9GP0
	 LMt0DSVKLePgQ==
Date: Wed, 5 Jun 2024 17:22:06 -0600
From: Rob Herring <robh@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Sandy Huang <hjc@rock-chips.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Yao <markyao0591@gmail.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	kernel@collabora.com, Alexandre ARNOUD <aarnoud@me.com>,
	Luis de Arquer <ldearquer@gmail.com>
Subject: Re: [PATCH 12/14] dt-bindings: display: rockchip,dw-hdmi: Add
 compatible for RK3588
Message-ID: <20240605232206.GA3345910-robh@kernel.org>
References: <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
 <20240601-b4-rk3588-bridge-upstream-v1-12-f6203753232b@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240601-b4-rk3588-bridge-upstream-v1-12-f6203753232b@collabora.com>

On Sat, Jun 01, 2024 at 04:12:34PM +0300, Cristian Ciocaltea wrote:
> Document the Synopsys DesignWare HDMI 2.1 Quad-Pixel (QP) TX controller
> found on Rockchip RK3588 SoC family.
> 
> Since RK3588 uses different clocks than previous Rockchip SoCs and also
> requires a couple of reset lines and some additional properties, provide
> the required changes in the binding to accommodate all variants.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  .../display/rockchip/rockchip,dw-hdmi.yaml         | 127 +++++++++++++++------
>  1 file changed, 90 insertions(+), 37 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
> index 2aac62219ff6..60d6b815227f 100644
> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
> @@ -10,12 +10,10 @@ maintainers:
>    - Mark Yao <markyao0591@gmail.com>
>  
>  description: |
> -  The HDMI transmitter is a Synopsys DesignWare HDMI 1.4 TX controller IP
> -  with a companion PHY IP.
> -
> -allOf:
> -  - $ref: ../bridge/synopsys,dw-hdmi.yaml#
> -  - $ref: /schemas/sound/dai-common.yaml#
> +  For SoCs up to RK3568, the HDMI transmitter is a Synopsys DesignWare
> +  HDMI 1.4 TX controller IP with a companion PHY IP.
> +  The RK3588 SoC integrates the Synopsys DesignWare HDMI 2.1 Quad-Pixel (QP)
> +  TX controller IP and a HDMI/eDP TX Combo PHY based on a Samsung IP block.
>  
>  properties:
>    compatible:
> @@ -25,6 +23,7 @@ properties:
>        - rockchip,rk3328-dw-hdmi
>        - rockchip,rk3399-dw-hdmi
>        - rockchip,rk3568-dw-hdmi
> +      - rockchip,rk3588-dw-hdmi
>  
>    reg-io-width:
>      const: 4
> @@ -40,36 +39,6 @@ properties:
>        A 1.8V supply that powers up the SoC internal circuitry. The pin name on the
>        SoC usually is HDMI_TX_AVDD_1V8.
>  
> -  clocks:
> -    minItems: 2
> -    items:
> -      - {}
> -      - {}
> -      # The next three clocks are all optional, but shall be specified in this
> -      # order when present.
> -      - description: The HDMI CEC controller main clock
> -      - description: Power for GRF IO
> -      - description: External clock for some HDMI PHY (old clock name, deprecated)
> -      - description: External clock for some HDMI PHY (new name)
> -
> -  clock-names:
> -    minItems: 2
> -    items:
> -      - {}
> -      - {}
> -      - enum:
> -          - cec
> -          - grf
> -          - vpll
> -          - ref
> -      - enum:
> -          - grf
> -          - vpll
> -          - ref
> -      - enum:
> -          - vpll
> -          - ref
> -
>    ddc-i2c-bus:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
> @@ -131,13 +100,97 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - reg-io-width
>    - clocks
>    - clock-names
>    - interrupts
>    - ports
>    - rockchip,grf
>  
> +allOf:
> +  - $ref: /schemas/sound/dai-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rockchip,rk3588-dw-hdmi
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 1
> +
> +        clocks:
> +          minItems: 1
> +          items:
> +            - description: APB system interface clock
> +            # The next clocks are optional, but shall be specified in this
> +            # order when present.
> +            - description: TMDS/FRL link clock
> +            - description: EARC RX biphase clock
> +            - description: Reference clock
> +            - description: Audio interface clock
> +            - description: Video datapath clock
> +
> +        clock-names:
> +          minItems: 1
> +          items:
> +            - const: pclk
> +            - enum: [hdp, earc, ref, aud, hclk_vo1]
> +            - enum: [earc, ref, aud, hclk_vo1]
> +            - enum: [ref, aud, hclk_vo1]
> +            - enum: [aud, hclk_vo1]
> +            - const: hclk_vo1
> +
> +        resets:
> +          minItems: 2
> +          maxItems: 2
> +
> +        reset-names:
> +          items:
> +            - const: ref
> +            - const: hdp
> +
> +        interrupts:
> +          minItems: 1
> +          maxItems: 5
> +
> +        rockchip,vo1_grf:
> +          $ref: /schemas/types.yaml#/definitions/phandle
> +          description: Some QP related data is accessed through VO1 GRF regs
> +
> +      required:
> +        - resets
> +        - reset-names
> +        - rockchip,vo1_grf
> +
> +    else:
> +      $ref: ../bridge/synopsys,dw-hdmi.yaml#

This is odd... With this plus the amount of conditional schema, I think 
this should be a new schema doc. Doesn't have to have a common 
schema. You can let the 2nd user of this IP block do that. Though if you 
have the Synopsys spec, then it would be good to use it and be sure the 
binding corresponds to it.

Rob

