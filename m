Return-Path: <linux-kernel+bounces-419431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F5F9D6E09
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 12:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DA44B2114E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 11:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CDF188714;
	Sun, 24 Nov 2024 11:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="FcQwNb1N"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F967CF16;
	Sun, 24 Nov 2024 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732448424; cv=none; b=toyM+1UrOPdiXjajNz6o+eMxuP1VzXyHhwwiGhcxo3+Gdja6JuxIvgxwcKHtp+hacjHlx/8XWyZiUQJ9XpQtKCO2HgOa2zrAyvvZSvxeSibb793Oub1vQL59nbTvVyyuj/u9OYc3SPR+cj5L9zrdjo6NKJ0R5syxGZVI+l3GNyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732448424; c=relaxed/simple;
	bh=1bhDdSxVvYJHrSbY9Pm9YLToIwNMuQRQ/r+JsdA9se0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=as6Wm7pV1SF1V145uiAZ9fiq/79Tjfoo0w1ewLlcidCT6xiTKgnYIE5fZ28NpZLe/h7+DIuwIPJvMZO5BIJKuiIwc8jMmPDoP5b6dSMhmFtUmszmjQDGTvN+Mf4P0B6JzV8kn5OuVBSonNloFuAiN8woTck+EWRNBD+phrosQqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=FcQwNb1N; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=J3BQnHmMzJvRzOGoxvKw6fbWVPHb009ceAjCw5kM6Qk=; b=FcQwNb1Nxc86U2alMAKKQijXNV
	5BVPN2Tp0UqXl5qkKq7DIEA9jHHTZucMj98AqTokHXNRwUyIYA8rM24FF58r/vPu+ZYbRoW2jUbRl
	h7dyNgeBbYFl5ytnPtVTFb5TOMurDcszoejPbvXlSH3IDz/1rhecHcctN4oSqyJSxx1KQkiHYRabV
	R3lNBZcleSSsxMWX6EP2N66v1A0ZuQbbPNe5hE9Exqdhe/igS7mIls5fVDaWtfOL7AbPq3EuTaLm6
	cNM67DvtSyO7z0aytWmPPOYY1Euod7ueersLrJYo2CMRdXIK5kD/BhUcsfPqzXHFMMB78ZsAzpwYl
	vHoAjocQ==;
Received: from i5e86190f.versanet.de ([94.134.25.15] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tFAyF-00047c-Or; Sun, 24 Nov 2024 12:40:07 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, quentin.schulz@cherry.de, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject:
 Re: [PATCH v3 1/2] dt-bindings: phy: Add Rockchip MIPI CSI/DSI PHY schema
Date: Sun, 24 Nov 2024 12:40:06 +0100
Message-ID: <8454190.T7Z3S40VBb@diego>
In-Reply-To: <udad4qf3o7kt45nuz6gxsvsmprh4rnyfxfogopmih6ucznizih@7oj2jrnlfonz>
References:
 <20241113221018.62150-1-heiko@sntech.de>
 <20241113221018.62150-2-heiko@sntech.de>
 <udad4qf3o7kt45nuz6gxsvsmprh4rnyfxfogopmih6ucznizih@7oj2jrnlfonz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 22. November 2024, 19:49:20 CET schrieb Sebastian Reichel:
> Hi,
> 
> On Wed, Nov 13, 2024 at 11:10:17PM +0100, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@cherry.de>
> > 
> > Add dt-binding schema for the MIPI CSI/DSI PHY found on
> > Rockchip RK3588 SoCs.
> > 
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> > ---
> >  .../phy/rockchip,rk3588-mipi-dcphy.yaml       | 82 +++++++++++++++++++
> >  1 file changed, 82 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.yaml
> > new file mode 100644
> > index 000000000000..5ee8d7246fa0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.yaml
> > @@ -0,0 +1,82 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/phy/rockchip,rk3588-mipi-dcphy.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Rockchip MIPI CSI/DSI PHY with Samsung IP block
> > +
> > +maintainers:
> > +  - Guochun Huang <hero.huang@rock-chips.com>
> > +  - Heiko Stuebner <heiko@sntech.de>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - rockchip,rk3576-mipi-dcphy
> > +      - rockchip,rk3588-mipi-dcphy
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#phy-cells":
> > +    const: 0
> 
> I would expect an argument to select between D-PHY and C-PHY mode,
> so that the binding is ready for it even when the driver does not
> yet support it. E.g. something like
> 
>   '#phy-cells':
>     const: 1
>     description: |
>       Supported modes are:
>         - PHY_TYPE_DPHY
>         - PHY_TYPE_CPHY
>       See include/dt-bindings/phy/phy.h for constants.
> 
> This would match how it works for the naneng Combo PHY to switch
> between PCIe/SATA/USB3. Also Mediatek CSI DC-PHY handles it that
> way upstream (with just D-PHY being supported). I see that the
> driver stack you send upstream expects, that the PHY user (e.g.
> the DSI controller) instead manually calls phy_set_mode(phy, <mode>).
> To me it seems more sensible to just get this automaically from DT.

The mode-selection for the phy is definitly tied to the hardware-design.
Depending on how the board is designed, it'll always do either D-PHY
or C-PHY mode.

I guess it mostly just feels strange when so far the parameter was
used to identify say an individual clock from the clock controller.

But reading the Medietek discussion (up to [0]) it looks like that is
a nice way to do this, so I'll adapt things in the next version.


Heiko


[0] https://lore.kernel.org/all/20230608200552.GA3303349-robh@kernel.org/


> Otherwise the whole series LGTM.
> 
> Greetings,
> 
> -- Sebastian
> 
> > +  clocks:
> > +    maxItems: 2
> > +
> > +  clock-names:
> > +    items:
> > +      - const: pclk
> > +      - const: ref
> > +
> > +  resets:
> > +    maxItems: 4
> > +
> > +  reset-names:
> > +    items:
> > +      - const: m_phy
> > +      - const: apb
> > +      - const: grf
> > +      - const: s_phy
> > +
> > +  rockchip,grf:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Phandle to the syscon managing the 'mipi dcphy general register files'.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - resets
> > +  - reset-names
> > +  - "#phy-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/rockchip,rk3588-cru.h>
> > +    #include <dt-bindings/reset/rockchip,rk3588-cru.h>
> > +
> > +    soc {
> > +      #address-cells = <2>;
> > +      #size-cells = <2>;
> > +
> > +      phy@feda0000 {
> > +        compatible = "rockchip,rk3588-mipi-dcphy";
> > +        reg = <0x0 0xfeda0000 0x0 0x10000>;
> > +        clocks = <&cru PCLK_MIPI_DCPHY0>,
> > +                 <&cru CLK_USBDPPHY_MIPIDCPPHY_REF>;
> > +        clock-names = "pclk", "ref";
> > +        resets = <&cru SRST_M_MIPI_DCPHY0>,
> > +                 <&cru SRST_P_MIPI_DCPHY0>,
> > +                 <&cru SRST_P_MIPI_DCPHY0_GRF>,
> > +                 <&cru SRST_S_MIPI_DCPHY0>;
> > +        reset-names = "m_phy", "apb", "grf", "s_phy";
> > +        rockchip,grf = <&mipidcphy0_grf>;
> > +        #phy-cells = <0>;
> > +      };
> > +    };
> 





