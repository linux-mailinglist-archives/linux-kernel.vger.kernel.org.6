Return-Path: <linux-kernel+bounces-309721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C1E966FB4
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 08:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B3828451D
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 06:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD12F1537B5;
	Sat, 31 Aug 2024 06:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0uy46Xh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC4613C68E;
	Sat, 31 Aug 2024 06:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725084807; cv=none; b=fXRzz2GCgWaL/eqcq0JJd8q2wEymdJ6bogRTLarH7A7bWeIf02LezV+WFKkZ2/e04IaCubwsIcqwVdykiShs83iZS4jLoO3rxBB3O1Yhk6WIawVUyhfUs2BuB9wWfkmzonUI48tg+2Xj6eK5fsqetm5yBWOdWUC4CgzpX9UWZ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725084807; c=relaxed/simple;
	bh=r4QcLe2zH5VCVWMbpDB30H66Ja6ioSiSEKZ4BH0YNE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8PRvWGAWOqAz/FeuzR0HUjwb8AgCNtlGCpZOVdrMvPonJ4ElWPJm7c7dVGiQ6vXCgDRSBwE9ut/QUEISDQB2TuJWuhMmc1hKSu5Z8581p9GFYQ5ErPiA1OcGy73M3bH20b3yzpRXhbIrcBA4mF0P68xpmzWkS4InKpRTqHgxLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0uy46Xh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72E7C4CEC0;
	Sat, 31 Aug 2024 06:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725084806;
	bh=r4QcLe2zH5VCVWMbpDB30H66Ja6ioSiSEKZ4BH0YNE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U0uy46Xh9Dzs7TOtOcbQpb78Pkdp7Atwx8vMJ1nIG42WYLPgcPW+n2J32NY2T8ITM
	 O8EOaPsm0CpweassR8aSvWl2/se/Eo4kgi3tbbzGKoc3PvM3fhG/el+qYfjzHPiSWC
	 NAYLEoKSG4Ta3IzbGCN3shWzyL/ckl9KRt++QBU96zF28BDeWtqfkuej6C+Xz0q1kz
	 p6tOXTeTdHTOo6RZrTivrL+0Zgg+8MBaCv4do+SKNsg0gG9b6O10sjsQasN7w47c45
	 4CbXoaP5wC+XN+nW5vc+BzAmv5+CPXYA8iZXj8YB5wwTw035sUGc2xq9EQwDQKIc4l
	 Om8BKaHM7uutw==
Date: Sat, 31 Aug 2024 08:13:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sandy Huang <hjc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
	Andy Yan <andy.yan@rock-chips.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mark Yao <markyao0591@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	kernel@collabora.com, Alexandre ARNOUD <aarnoud@me.com>, 
	Luis de Arquer <ldearquer@gmail.com>
Subject: Re: [PATCH v5 3/4] dt-bindings: display: rockchip: Add schema for
 RK3588 HDMI TX Controller
Message-ID: <myiu2nmyzysjnuvy4jnahket2go5kq4qs7pdhb7rznrp5pwilj@d55nh7qdenhj>
References: <20240831-b4-rk3588-bridge-upstream-v5-0-9503bece0136@collabora.com>
 <20240831-b4-rk3588-bridge-upstream-v5-3-9503bece0136@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240831-b4-rk3588-bridge-upstream-v5-3-9503bece0136@collabora.com>

On Sat, Aug 31, 2024 at 12:55:31AM +0300, Cristian Ciocaltea wrote:
> Rockchip RK3588 SoC integrates the Synopsys DesignWare HDMI 2.1
> Quad-Pixel (QP) TX controller IP.
> 
> Since this is a new IP block, quite different from those used in the
> previous generations of Rockchip SoCs, add a dedicated binding file.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  .../rockchip/rockchip,rk3588-dw-hdmi-qp.yaml       | 166 +++++++++++++++++++++
>  1 file changed, 166 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml
> new file mode 100644
> index 000000000000..d2919ff6aa23
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml
> @@ -0,0 +1,166 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip DW HDMI QP TX Encoder
> +
> +maintainers:
> +  - Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> +
> +description:
> +  Rockchip RK3588 SoC integrates the Synopsys DesignWare HDMI QP TX controller
> +  IP and a HDMI/eDP TX Combo PHY based on a Samsung IP block.
> +
> +allOf:
> +  - $ref: /schemas/display/bridge/synopsys,dw-hdmi-qp.yaml#
> +  - $ref: /schemas/sound/dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk3588-dw-hdmi-qp
> +
> +  clocks:
> +    items:
> +      - {}
> +      - {}
> +      - {}
> +      - {}
> +      - description: TMDS/FRL link clock
> +      - description: Video datapath clock

Please define all clocks.

> +
> +  clock-names:
> +    items:
> +      - {}
> +      - {}
> +      - {}
> +      - {}
> +      - enum: [hdp, hclk_vo1]
> +      - const: hclk_vo1
> +
> +  interrupts:
> +    items:
> +      - {}
> +      - {}
> +      - {}
> +      - {}
> +      - description: HPD interrupt
> +
> +  interrupt-names:
> +    items:
> +      - {}
> +      - {}
> +      - {}
> +      - {}
> +      - const: hpd
> +
> +  phys:
> +    maxItems: 1
> +    description: The HDMI/eDP PHY.
> +
> +  phy-names:
> +    const: hdmi

Drop phy-names, not really useful if it copies the name of the block.

> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    minItems: 2
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: ref
> +      - const: hdp
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  rockchip,grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Some HDMI QP related data is accessed through SYS GRF regs.
> +
> +  rockchip,vo-grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Additional HDMI QP related data is accessed through VO GRF regs.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - interrupt-names
> +  - phys
> +  - phy-names
> +  - ports
> +  - resets
> +  - reset-names
> +  - rockchip,grf
> +  - rockchip,vo-grf
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rockchip,rk3588-cru.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/power/rk3588-power.h>
> +    #include <dt-bindings/reset/rockchip,rk3588-cru.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      hdmi@fde80000 {
> +        compatible = "rockchip,rk3588-dw-hdmi-qp";
> +        reg = <0x0 0xfde80000 0x0 0x20000>;
> +        clocks = <&cru PCLK_HDMITX0>,
> +                 <&cru CLK_HDMITX0_EARC>,
> +                 <&cru CLK_HDMITX0_REF>,
> +                 <&cru MCLK_I2S5_8CH_TX>,
> +                 <&cru CLK_HDMIHDP0>,
> +                 <&cru HCLK_VO1>;
> +        clock-names = "pclk", "earc", "ref", "aud", "hdp", "hclk_vo1";
> +        interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>,
> +                     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>,
> +                     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH 0>,
> +                     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH 0>,
> +                     <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH 0>;
> +        interrupt-names = "avp", "cec", "earc", "main", "hpd";
> +        phys = <&hdptxphy_hdmi0>;
> +        phy-names = "hdmi";
> +        power-domains = <&power RK3588_PD_VO1>;
> +        resets = <&cru SRST_HDMITX0_REF>, <&cru SRST_HDMIHDP0>;
> +        reset-names = "ref", "hdp";
> +        rockchip,grf = <&sys_grf>;
> +        rockchip,vo-grf = <&vo1_grf>;
> +        #sound-dai-cells = <0>;
> +
> +        ports {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          port@0 {
> +            reg = <0>;
> +
> +            hdmi0_in_vp0: endpoint {
> +                remote-endpoint = <&vp0_out_hdmi0>;

Messed indentation.

Best regards,
Krzysztof


