Return-Path: <linux-kernel+bounces-285294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A945950BCE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88DFEB22FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7865D1A38DB;
	Tue, 13 Aug 2024 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwDCyGb6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3C837E;
	Tue, 13 Aug 2024 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723571941; cv=none; b=l58ubUXqCt6NJs30R2aoSiGZzrnTwPFYUgno+e5DJv5a/ycYPRyXOm3r3k7CyXVrztYMvyb/DpRVozoRnPanLbtFox7Z/S8rgKSB70U5woxEuvkSnvTIq0YINrPGe6+O18gt89XvVHFfooitHXnGDtgQaQQqOdWt0M/13yW01zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723571941; c=relaxed/simple;
	bh=Udh93aatepcn0N17vUvPrrHSs078UxAKq9paEPu2A5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mb2gCtN4Y/HZ2eq1OPsIn1YPWl2pG9CzspbsKvg5dRRYawfUUCdyzbroriGDGvicMy3Zxtc/vL3SRZUCwz/TivaXuRlZgD5w6q8FzRxV8sr2ry0lSn3f6WLGu6kzzR3be79tnias2Ug4QcHXUb+0813PWCoLxfsXPLL+c79zCmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwDCyGb6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77EDC32782;
	Tue, 13 Aug 2024 17:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723571941;
	bh=Udh93aatepcn0N17vUvPrrHSs078UxAKq9paEPu2A5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZwDCyGb6ESpAiWDw4I308wrMi6IOTwHGwFGfY5esWLUgJYkXthW4SMWzvWqFcj8vk
	 /I4QDNzP3K1ZegzoYJu3oQGzUMsZ/Jqq3atk8HecHUIxUe/8yAL0VPq4JsfBMiGqwN
	 ogtKbNzXakaii7goxXBJ2W+bdXMTWLB3S82PAyalkGfG5wX/u8xTdyDlr3RDNxlg3H
	 RcFE143uOXbrfPabZagQWw3gjTrblLj1TwGIvpHRhsVeY/kQIcOsH6uQrcerZHfbUe
	 ymHPssfV7j+vKiXWOSw3+vpzYtq7kAAYGXFIYgHfyCRBq04KyMJy5pxkMbEtKel5YR
	 i8y5i62e3OHwg==
Date: Tue, 13 Aug 2024 11:58:59 -0600
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
	Mark Yao <markyao0591@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	kernel@collabora.com, Alexandre ARNOUD <aarnoud@me.com>,
	Luis de Arquer <ldearquer@gmail.com>
Subject: Re: [PATCH v3 3/5] dt-bindings: display: rockchip: Add schema for
 RK3588 HDMI TX Controller
Message-ID: <20240813175859.GA1415670-robh@kernel.org>
References: <20240807-b4-rk3588-bridge-upstream-v3-0-60d6bab0dc7c@collabora.com>
 <20240807-b4-rk3588-bridge-upstream-v3-3-60d6bab0dc7c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807-b4-rk3588-bridge-upstream-v3-3-60d6bab0dc7c@collabora.com>

On Wed, Aug 07, 2024 at 02:07:25PM +0300, Cristian Ciocaltea wrote:
> Rockchip RK3588 SoC integrates the Synopsys DesignWare HDMI 2.1
> Quad-Pixel (QP) TX controller IP.
> 
> Since this is a new IP block, quite different from those used in the
> previous generations of Rockchip SoCs, add a dedicated binding file.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  .../display/rockchip/rockchip,dw-hdmi-qp.yaml      | 188 +++++++++++++++++++++
>  1 file changed, 188 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi-qp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi-qp.yaml
> new file mode 100644
> index 000000000000..33572c88a589
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi-qp.yaml
> @@ -0,0 +1,188 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi-qp.yaml#
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
> +  - $ref: ../bridge/synopsys,dw-hdmi-qp.yaml#

Use full path: /schemas/display/bridge/...

> +  - $ref: /schemas/sound/dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk3588-dw-hdmi-qp
> +
> +  clocks:
> +    minItems: 4
> +    items:
> +      - {}
> +      - {}
> +      - {}
> +      - {}
> +      # The next clocks are optional, but shall be specified in this
> +      # order when present.
> +      - description: TMDS/FRL link clock
> +      - description: Video datapath clock
> +
> +  clock-names:
> +    minItems: 4
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
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Port node with one endpoint connected to a vop node.
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Port node with one endpoint connected to a hdmi-connector node.

ports can go in the common schema. The description should be what the 
data and direction are for the ports. What the connection is can vary 
and is outside the scope of this binding.

> +
> +    required:
> +      - port@0
> +      - port@1
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
> +      Most HDMI QP related data is accessed through SYS GRF regs.
> +
> +  rockchip,vo1_grf:

rockchip,vo1-grf

