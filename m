Return-Path: <linux-kernel+bounces-346856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5507198C9BD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 02:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133D9284014
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 00:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58C6DF60;
	Wed,  2 Oct 2024 00:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLB6VJzc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB618F58;
	Wed,  2 Oct 2024 00:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727827336; cv=none; b=R1ez0Iyk9RFq75h2AxFuE/70H1gdJkAP9yhyseQXrL27LjdYJRIvnlANFlMtyi/gHRojXYBcBRHCkqwe7GWRnPP0v3dYMu0y83CpBfbvjpqrqesFB7OzNXaWzTueXfpnRIZN22dJwbzmfWtawc7zr0S5pnbmofEwVAbO4qLfeHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727827336; c=relaxed/simple;
	bh=aRIaCvZg7k4Uu4zwamCQXdJnCx+yZ1ZoA82VwpA4DfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYIsDu9lejlInBMwsX7Op5tkQUcHB5RFaWObAGH//iPrwmbEibVbhO/E9skxP89GhcH+8uyYYgayoW8jjEp1tsgNHWvwnkrWWC2wndZpxpdIxPqhOMrY9OvWFg+0ZtvsGRNzGjkHb6TKrz+3XOzEquTJB4PnGLaESmElq+cekxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLB6VJzc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8791DC4CEC6;
	Wed,  2 Oct 2024 00:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727827335;
	bh=aRIaCvZg7k4Uu4zwamCQXdJnCx+yZ1ZoA82VwpA4DfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SLB6VJzcQ/yk6aTq7LT3xVeCCstO2cJNt15ECPPUZb+VNlEO3s2eSWnFExwlpqMWb
	 +5TZWHri6YxUk5rfmJ0tJqT4nE/NqygCvY16SSlHx9oKXMBzi1wSK2Z5xaV/AdYTU2
	 KJPcCThorV0XHCXdLCJV8a2ItYFZ3j1EorGuGg0Xy+phJydxFKGzPZNdXa+kWS8ycz
	 bEYU70pAUJitnESJ9dsah1VfzEjsmT5JIqtHPof8jJeZuSADKEP0qeTBmypfdC1Bh4
	 qbOeZeTrWC0DANOKSlHNQxpAXwICbc7oj8A0/spvQ1J6kR9B+20salw+E7ipBL9zzw
	 vm4BPNrsCSgFQ==
Date: Tue, 1 Oct 2024 19:02:14 -0500
From: Rob Herring <robh@kernel.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, catalin.marinas@arm.com, will@kernel.org,
	quic_bjorande@quicinc.com, geert+renesas@glider.be,
	dmitry.baryshkov@linaro.org, arnd@arndb.de, nfraprado@collabora.com,
	o.rempel@pengutronix.de, y.moog@phytec.de
Subject: Re: [PATCH 5/8] dt-bindings: display: bridge: Add ITE IT6263 LVDS to
 HDMI converter
Message-ID: <20241002000214.GA49657-robh@kernel.org>
References: <20240930052903.168881-1-victor.liu@nxp.com>
 <20240930052903.168881-6-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930052903.168881-6-victor.liu@nxp.com>

On Mon, Sep 30, 2024 at 01:29:00PM +0800, Liu Ying wrote:
> Document ITE IT6263 LVDS to HDMI converter.
> 
> Product link:
> https://www.ite.com.tw/en/product/cate1/IT6263
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  .../bindings/display/bridge/ite,it6263.yaml   | 310 ++++++++++++++++++
>  1 file changed, 310 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ite,it6263.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6263.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6263.yaml
> new file mode 100644
> index 000000000000..97fb81e5bc4a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6263.yaml
> @@ -0,0 +1,310 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/ite,it6263.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ITE IT6263 LVDS to HDMI converter
> +
> +maintainers:
> +  - Liu Ying <victor.liu@nxp.com>
> +
> +description: |
> +  The IT6263 is a high-performance single-chip De-SSC(De-Spread Spectrum) LVDS
> +  to HDMI converter.  Combined with LVDS receiver and HDMI 1.4a transmitter,
> +  the IT6263 supports LVDS input and HDMI 1.4 output by conversion function.
> +  The built-in LVDS receiver can support single-link and dual-link LVDS inputs,
> +  and the built-in HDMI transmitter is fully compliant with HDMI 1.4a/3D, HDCP
> +  1.2 and backward compatible with DVI 1.0 specification.
> +
> +  The IT6263 also encodes and transmits up to 8 channels of I2S digital audio,
> +  with sampling rate up to 192KHz and sample size up to 24 bits. In addition,
> +  an S/PDIF input port takes in compressed audio of up to 192KHz frame rate.
> +
> +  The newly supported High-Bit Rate(HBR) audio by HDMI specifications v1.3 is
> +  provided by the IT6263 in two interfaces: the four I2S input ports or the
> +  S/PDIF input port.  With both interfaces the highest possible HBR frame rate
> +  is supported at up to 768KHz.
> +
> +properties:
> +  compatible:
> +    const: ite,it6263
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: audio master clock
> +
> +  clock-names:
> +    const: mclk
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  ivdd-supply:
> +    description: 1.8V digital logic power
> +
> +  ovdd-supply:
> +    description: 3.3V I/O pin power
> +
> +  txavcc18-supply:
> +    description: 1.8V HDMI analog frontend power
> +
> +  txavcc33-supply:
> +    description: 3.3V HDMI analog frontend power
> +
> +  pvcc1-supply:
> +    description: 1.8V HDMI frontend core PLL power
> +
> +  pvcc2-supply:
> +    description: 1.8V HDMI frontend filter PLL power
> +
> +  avcc-supply:
> +    description: 3.3V LVDS frontend power
> +
> +  anvdd-supply:
> +    description: 1.8V LVDS frontend analog power
> +
> +  apvdd-supply:
> +    description: 1.8V LVDS frontend PLL power
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  ite,i2s-audio-fifo-sources:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 4
> +    items:
> +      enum: [0, 1, 2, 3]
> +    description:
> +      Each array element indicates the pin number of an I2S serial data input
> +      line which is connected to an audio FIFO, from audio FIFO0 to FIFO3.
> +
> +  ite,rl-channel-swap-audio-sources:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 4
> +    uniqueItems: true
> +    items:
> +      enum: [0, 1, 2, 3]
> +    description:
> +      Each array element indicates an audio source whose right channel and left
> +      channel are swapped by this converter. For I2S, the element is the pin
> +      number of an I2S serial data input line. For S/PDIF, the element is always
> +      0.
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports

Test your bindings. You need 'additionalProperties: false' here. Though 
I can't remember if that can 'see' properties under the oneOf. So it may 
have to be unevaluatedProperties instead.

> +
> +    oneOf:

I think you can get rid of this. If port@1 requires the dual link 
properties and then properties on port@0, then the only way you can have 
a single link is removing port@1 from the DT. 

> +      - properties:
> +          port@0:
> +            $ref: /schemas/graph.yaml#/properties/port
> +            description: the first LVDS input link
> +
> +          port@1: false
> +
> +          port@2:
> +            $ref: /schemas/graph.yaml#/properties/port
> +            description: video port for the HDMI output
> +
> +          port@3:
> +            $ref: /schemas/graph.yaml#/properties/port
> +            description: sound input port
> +
> +        required:
> +          - port@0
> +          - port@2
> +
> +      - properties:
> +          port@0:
> +            $ref: /schemas/graph.yaml#/$defs/port-base
> +            unevaluatedProperties: false
> +            description: the first LVDS input link
> +
> +            properties:
> +              dual-lvds-odd-pixels:
> +                type: boolean
> +                description: the first sink port for odd pixels
> +
> +              dual-lvds-even-pixels:
> +                type: boolean
> +                description: the first sink port for even pixels
> +
> +            oneOf:
> +              - required: [dual-lvds-odd-pixels]
> +              - required: [dual-lvds-even-pixels]
> +
> +          port@1:
> +            $ref: /schemas/graph.yaml#/$defs/port-base
> +            unevaluatedProperties: false
> +            description: the second LVDS input link
> +
> +            properties:
> +              dual-lvds-even-pixels:
> +                type: boolean
> +                description: the second sink port for even pixels
> +
> +              dual-lvds-odd-pixels:
> +                type: boolean
> +                description: the second sink port for odd pixels
> +
> +            oneOf:
> +              - required: [dual-lvds-even-pixels]
> +              - required: [dual-lvds-odd-pixels]
> +
> +          port@2:
> +            $ref: /schemas/graph.yaml#/properties/port
> +            description: video port for the HDMI output
> +
> +          port@3:
> +            $ref: /schemas/graph.yaml#/properties/port
> +            description: sound input port
> +
> +        required:
> +          - port@0
> +          - port@1
> +          - port@2
> +
> +        allOf:
> +          - if:
> +              properties:
> +                port@0:
> +                  required:
> +                    - dual-lvds-odd-pixels
> +            then:
> +              properties:
> +                port@1:
> +                  properties:
> +                    dual-lvds-odd-pixels: false
> +
> +          - if:
> +              properties:
> +                port@0:
> +                  required:
> +                    - dual-lvds-even-pixels
> +            then:
> +              properties:
> +                port@1:
> +                  properties:
> +                    dual-lvds-even-pixels: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - ivdd-supply
> +  - ovdd-supply
> +  - txavcc18-supply
> +  - txavcc33-supply
> +  - pvcc1-supply
> +  - pvcc2-supply
> +  - avcc-supply
> +  - anvdd-supply
> +  - apvdd-supply
> +  - ports
> +
> +additionalProperties: false
> +

