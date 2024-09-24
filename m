Return-Path: <linux-kernel+bounces-337769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 601BC984EA7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9102B26A1A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564C31865F0;
	Tue, 24 Sep 2024 23:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtCfff1R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C66313C8F0;
	Tue, 24 Sep 2024 23:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727219011; cv=none; b=KU/J+EC8adOKEwckQ+gv9kLi8DvAkkXl11smbwBqJr3Gw+6Q3+h6kvT9QmPJVWvkqfTNtjOQmVC+5heAuZs2lGbILmv8rybM+dkGCMxlFDhhK+vLB6NlW3ru3pUvAUQNYo0e//XEnXdIfnYwghNZjosFzKGUTmapnZ1TQRZFdcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727219011; c=relaxed/simple;
	bh=gYYRhZD3rvvtpnrdcL4upxJCTxcxrqykk7cJXG94c74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUuqTzMgtttXpHkQCfvlHNxVon+xZ3PfuGQYdNOlCwxXmzoBmpuM/UYR8ZbDsO6k0pEmlSSn9iHFeEtXcKr74OylvYIZQ+25ZgSh842wqm4ekWYdEHwNeqkYVVneFxXFovl2BqA5e14Ox61Ba96RB9uHcDQiZyG+rqYzlK70Qpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtCfff1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EEDC4CEC4;
	Tue, 24 Sep 2024 23:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727219011;
	bh=gYYRhZD3rvvtpnrdcL4upxJCTxcxrqykk7cJXG94c74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PtCfff1RO6YZh019eDvWMs7A2ST59pNEh7OgksLQonGnY/lqjFhr+za1Vkuhz/M10
	 VSnjXlpsbw+qMWzrSO7inHzf4jhbf50hkVF8wCGMrE/Ld1tE6qbxrL9r1GcBT4l4TE
	 OBgVQdFrORhmBMFcNaC51WgYOZYruTL9Z6HnNwCvgtDiSOZpj9Zjv2X+dJR3zXqEZV
	 NwBdtpxqfYxtpPz3WG7a2AyMDtuABcN7Y5uSeHAU6ufxzYCm/NuMFsGAUbKKx3oyon
	 SfEYUMMbk2PrDSoXXcUuEjSku/aaIrXDQ25FJZJkk4YonlZHy1AcAOC+KCulU3oYvh
	 O42LuoJvm+qMA==
Date: Tue, 24 Sep 2024 18:03:30 -0500
From: Rob Herring <robh@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
	Stefan Agner <stefan@agner.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Fabio Estevam <festevam@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: lcdif: Add support for specifying display
 with timings
Message-ID: <20240924230330.GB441530-robh@kernel.org>
References: <20240923135744.2813712-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923135744.2813712-1-lukma@denx.de>

On Mon, Sep 23, 2024 at 03:57:44PM +0200, Lukasz Majewski wrote:
> Up till now the fsl,lcdif.yaml was requiring the "port" property as a
> must have to specify the display interface on iMX devices.
> 
> However, it shall also be possible to specify the display only with
> passing its timing parameters (h* and v* ones) via "display" property:
> (as in
> Documentation/devicetree/bindings/display/panel/display-timings.yaml).
> 
> Such approach has already been used (also in the mainline) with several
> imx28, imx5x and imx6q devices.
> 
> This change allows them to pass the DT_SCHEMA check without issues.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  .../bindings/display/fsl,lcdif.yaml           | 51 ++++++++++++++++++-
>  1 file changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> index 8e3a98aeec32..14bb64b5b72d 100644
> --- a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> +++ b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> @@ -50,6 +50,10 @@ properties:
>        - const: disp_axi
>      minItems: 1
>  
> +  display:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle for display timing information
> +
>    dmas:
>      items:
>        - description: DMA specifier for the RX DMA channel.
> @@ -64,6 +68,9 @@ properties:
>        - description: LCDIF Error interrupt
>      minItems: 1
>  
> +  lcd-supply:
> +    description: Regulator for LCD supply voltage.
> +
>    power-domains:
>      maxItems: 1
>  
> @@ -76,7 +83,10 @@ required:
>    - reg
>    - clocks
>    - interrupts
> -  - port
> +
> +patternProperties:
> +  'display([0-9])':

This allows for 'foodisplay0bar'. You need start and end anchors.

And it doesn't even have to be a node because there are no contraints 
here. You need 'type: object' and then to define what's in the node.


> +    description: Node with display timing parameters
>  
>  additionalProperties: false
>  
> @@ -197,5 +207,42 @@ examples:
>              };
>          };
>      };
> -
> +  - |
> +    lcdif: lcdif@80030000 {
> +        compatible = "fsl,imx28-lcdif";
> +        reg = <0x80030000 0x2000>;
> +        interrupts = <38>;
> +        clocks = <&clks 55>;
> +        dmas = <&dma_apbh 13>;
> +        dma-names = "rx";
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&lcdif_24bit_pins_a>, <&lcdif_sync_pins_bttc>,
> +                 <&lcdif_reset_pins_bttc>;
> +        lcd-supply = <&reg_3v3>;
> +        display = <&display0>;
> +        status = "okay";

Don't need status in the examples.

> +
> +                bits-per-pixel = <32>;
> +                bus-width = <24>;
> +                display-timings {
> +                        native-mode = <&timing0>;
> +                        timing0: timing0 {
> +                                clock-frequency = <6500000>;
> +                                hactive = <320>;
> +                                vactive = <240>;
> +                                hfront-porch = <20>;
> +                                hback-porch = <38>;
> +                                hsync-len = <30>;
> +                                vfront-porch = <4>;
> +                                vback-porch = <14>;
> +                                vsync-len = <4>;
> +                                hsync-active = <0>;
> +                                vsync-active = <0>;
> +                                de-active = <0>;
> +                                pixelclk-active = <1>;
> +                        };
> +                };
> +        };
> +    };
>  ...
> -- 
> 2.39.2
> 

