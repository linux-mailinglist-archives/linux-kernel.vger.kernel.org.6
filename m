Return-Path: <linux-kernel+bounces-176986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED188C383C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 21:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0155B1F21E81
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 19:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6F652F9E;
	Sun, 12 May 2024 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="mPUneHSs"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311541E49B;
	Sun, 12 May 2024 19:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715542512; cv=none; b=P5r++pYMyIpdob6hFNiVA4ahrPKpJgu5GrCuQa4vWTsh/crsqXZM2AS+QQkfihperp1cwjQKEDMrDUdi3DJmUMPtQ8sUrcrHzAZ3LtcsM+LNEP2G9+2lxXKfKGOsUEo8ebFUiC+iIHRptNqWj4FtJHsL+/0pDeyQQxxo2knOGxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715542512; c=relaxed/simple;
	bh=Uvp4c9PzSzl2dbXGTaNaX4y79zqXzrLQBohz5lqtVZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVxF4uLhAm8jAg51VDPF/v++B5FkQXrNE5wr2XHMRrzgXvvOm3JPbuna4pnOqZtB2g7SgQo+KkiuQMNbsngVPby6g5snThiZVmQZXadvPWhwjFYOUf+znl72r9e/2PFc/RYJsD/1C/e31YR8BwKZCSNZq/Zgmu0XWAoMZkrB4rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=mPUneHSs; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 465DA564;
	Sun, 12 May 2024 21:35:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1715542502;
	bh=Uvp4c9PzSzl2dbXGTaNaX4y79zqXzrLQBohz5lqtVZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mPUneHSs8tQCzr3IMbVN9drNZ3xlxy/xYRdQKZEbjfY11lW6fxnTXGCr2qJ4GG+xh
	 3pyUOY7pidyg1rgQQd68v4AFbbj2PQd8Ngt5qFjSscCUV0GG9U30IjXm2Amff826Tc
	 1m6mHyEr5Tbovlx/Wichn5RjldZV6D1tn7Zlfp8g=
Date: Sun, 12 May 2024 22:34:59 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Aradhya Bhatia <a-bhatia1@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Jyri Sarha <jyri.sarha@iki.fi>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	DRI Development List <dri-devel@lists.freedesktop.org>,
	Devicetree List <devicetree@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Randolph Sapp <rs@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
	Jayesh Choudhary <j-choudhary@ti.com>, Jai Luthra <j-luthra@ti.com>
Subject: Re: [PATCH 2/4] dt-bindings: display: ti: Add schema for AM625 OLDI
 Transmitter
Message-ID: <20240512193459.GF17158@pendragon.ideasonboard.com>
References: <20240511193055.1686149-1-a-bhatia1@ti.com>
 <20240511193055.1686149-3-a-bhatia1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240511193055.1686149-3-a-bhatia1@ti.com>

Hi Aradhya,

Thank you for the patch.

On Sun, May 12, 2024 at 01:00:53AM +0530, Aradhya Bhatia wrote:
> Add devicetree binding schema for AM625 OLDI Transmitters.
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>  .../bindings/display/ti/ti,am625-oldi.yaml    | 153 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 154 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/ti/ti,am625-oldi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/ti/ti,am625-oldi.yaml b/Documentation/devicetree/bindings/display/ti/ti,am625-oldi.yaml
> new file mode 100644
> index 000000000000..0a96e600bc0b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/ti/ti,am625-oldi.yaml
> @@ -0,0 +1,153 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/ti/ti,am625-oldi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments AM625 OLDI Transmitter
> +
> +maintainers:
> +  - Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> +  - Aradhya Bhatia <a-bhatia1@ti.com>
> +
> +description: |
> +  The AM625 TI Keystone OpenLDI transmitter (OLDI TX) supports serialized RGB
> +  pixel data transmission between host and flat panel display over LVDS (Low
> +  Voltage Differential Sampling) interface. The OLDI TX consists of 7-to-1 data
> +  serializers, and 4-data and 1-clock LVDS outputs. It supports the LVDS output
> +  formats "jeida-18", "jeida-24" and "vesa-18", and can accept 24-bit RGB or
> +  padded and un-padded 18-bit RGB bus formats as input.
> +
> +properties:
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: serial clock input for the OLDI transmitters
> +
> +  clock-names:
> +    const: s_clk
> +
> +  ti,companion-oldi:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to companion OLDI transmitter. This property is mandatory for the
> +      primarty OLDI TX if the OLDI TXes are expected to work either in dual-lvds
> +      mode or in clone mode. This property should point to the secondary OLDI
> +      TX.
> +
> +  ti,secondary-oldi:
> +    type: boolean
> +    description: Boolean property to mark an OLDI TX as secondary node.
> +
> +  ti,oldi-io-ctrl:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to syscon device node mapping OLDI IO_CTRL registers found in the
> +      control MMR region. This property is needed for OLDI interface to work.
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Parallel RGB input port
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: LVDS output port
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +allOf:
> +  - if:
> +      properties:
> +        ti,secondary-oldi: true
> +    then:
> +      properties:
> +        ti,companion-oldi: false
> +        ti,oldi-io-ctrl: false
> +        clocks: false
> +        clock-names: false
> +
> +    else:
> +      required:
> +        - ti,oldi-io-ctrl
> +        - clocks
> +        - clock-names
> +
> +required:
> +  - reg
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> +
> +    oldi_txes {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        oldi: oldi@0 {
> +            reg = <0>;
> +            clocks = <&k3_clks 186 0>;
> +            clock-names = "s_clk";
> +            ti,oldi-io-ctrl = <&dss_oldi_io_ctrl>;

What bus does this device live on ? Couldn't the I/O register space be
referenced by the reg property ?

> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                port@0 {
> +                    reg = <0>;
> +                    oldi_in: endpoint {
> +                        remote-endpoint = <&dpi0_out>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> +
> +  - |
> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> +
> +    oldi_txes {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        oldi0: oldi@0 {
> +            reg = <0>;
> +            clocks = <&k3_clks 186 0>;
> +            clock-names = "s_clk";
> +            ti,companion-oldi = <&oldi1>;
> +            ti,oldi-io-ctrl = <&dss_oldi_io_ctrl>;
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                port@0 {
> +                    reg = <0>;
> +                    oldi0_in: endpoint {
> +                        remote-endpoint = <&dpi0_out0>;
> +                    };
> +                };
> +            };
> +        };
> +        oldi1: oldi@1 {
> +            reg = <1>;
> +            ti,secondary-oldi;
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                port@0 {
> +                    reg = <0>;
> +                    oldi1_in: endpoint {
> +                        remote-endpoint = <&dpi0_out1>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c675fc296b19..4426c4d41a7f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7480,6 +7480,7 @@ M:	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Maintained
>  T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
> +F:	Documentation/devicetree/bindings/display/ti/ti,am625-oldi.yaml
>  F:	Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
>  F:	Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml
>  F:	Documentation/devicetree/bindings/display/ti/ti,k2g-dss.yaml

-- 
Regards,

Laurent Pinchart

