Return-Path: <linux-kernel+bounces-573966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AA8A6DEFD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24E0F7A2DD1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D5326156D;
	Mon, 24 Mar 2025 15:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wxhn0Z9z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61FA1DDE9;
	Mon, 24 Mar 2025 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742831360; cv=none; b=V5bOMAYFq6oOVmqQ2FA98bjO9lGKkYfHSvoeR3S70fu0gYhaMqeGk+hPhUnA9SOfgN/t6Nca40bTqnJfQ57BqKPC78ckOzAwSo05OAbFKOInqkhE0FiOPSrOYPOgZJ/d5KlNusEkH6UMkIsmrlVsO9iMe77S1ZVmbyVcAtZ/ca4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742831360; c=relaxed/simple;
	bh=mTbzGdF585SBjs9qPph8XaC8lrk++6aRMnH/YTASE/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsUW/vUKbLe6RHJBjakcpO5lEjHYWKZm1mO9DflfyrYAoWGczUf4Rg3UfDgFpO6aUDD04ilMAehGRtVV6q8mWI3DqNIJJikeim3HFHZk10eJzAqxJRhyosdpsc51Yobif2L33kQIEqmpSgeeYiuZp9eoZE1UDCPw3I6K46CZ65A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wxhn0Z9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D86C4CEDD;
	Mon, 24 Mar 2025 15:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742831360;
	bh=mTbzGdF585SBjs9qPph8XaC8lrk++6aRMnH/YTASE/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wxhn0Z9z3nh/2wuc6gVgU5ZwFdAmyHEABI9c/8nJRe+t6Dq7cGxBiYHE2vOpYwF7r
	 kRU5ydtcI91sDHKqlW/e6G6qPs9OwF8Cclr3X3CexKDR8Tv7ddkISF3S4aAKEs4GXL
	 f52tEdkI/RTCG1iQ9jcKj2ThSWq1sxi1qITtC0eDbbXOmdLqnEG18WXxJEoHaEaQMr
	 Aaz8RHgWJ3PvYJayX1I4CULlm5YHWjJ3aeb5GtJNMhhyknUdv5xVlYF67UN6nluWcQ
	 JNi5Dy/1JWSwgOK1gXUo/kEC/u9tmXqoaUxhqdZi5PokB5tDeg+yUfqJlHS8zCbHkX
	 j1WFmI+6TM55A==
Date: Mon, 24 Mar 2025 10:49:19 -0500
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Danzberger <dd@embedd.com>, Arnd Bergmann <arnd@arndb.de>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Linus Walleij <linus.walleij@linaro.org>,
	Yangyu Chen <cyy@cyyself.name>, Ben Hutchings <ben@decadent.org.uk>,
	Felix Fietkau <nbd@nbd.name>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH v2 07/11] dt-bindings: phy: Add documentation for Airoha
 AN7581 USB PHY
Message-ID: <20250324154919.GA101272-robh@kernel.org>
References: <20250320130054.4804-1-ansuelsmth@gmail.com>
 <20250320130054.4804-8-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320130054.4804-8-ansuelsmth@gmail.com>

On Thu, Mar 20, 2025 at 02:00:30PM +0100, Christian Marangi wrote:
> Add documentation for Airoha AN7581 USB PHY that describe the USB PHY
> for the USB controller.
> 
> Airoha AN7581 SoC support a maximum of 2 USB port. The USB 2.0 mode is
> always supported. The USB 3.0 mode is optional and depends on the Serdes
> mode currently configured on the system for the USB port.
> 
> If the airoha,serdes-port property is not declared, it's assumed USB 3.0
> mode is not supported, as the Serdes mode can't be validated.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/phy/airoha,an7581-usb-phy.yaml   | 83 +++++++++++++++++++
>  MAINTAINERS                                   |  7 ++
>  .../dt-bindings/phy/airoha,an7581-usb-phy.h   | 11 +++
>  3 files changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
>  create mode 100644 include/dt-bindings/phy/airoha,an7581-usb-phy.h
> 
> diff --git a/Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml b/Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
> new file mode 100644
> index 000000000000..39ceaded5d0e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/airoha,an7581-usb-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha AN7581 SoC USB PHY
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description: >
> +  The Airoha AN7581 SoC USB PHY describes the USB PHY for the USB controller.
> +
> +  Airoha AN7581 SoC support a maximum of 2 USB port. The USB 2.0 mode is
> +  always supported. The USB 3.0 mode is optional and depends on the Serdes
> +  mode currently configured on the system for the USB port.
> +
> +  If the airoha,serdes-port property is not declared, it's assumed USB 3.0
> +  mode is not supported, as the Serdes mode can't be validated.
> +
> +properties:
> +  compatible:
> +    const: airoha,an7581-usb-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +
> +  airoha,usb2-monitor-clk-sel:
> +    description: Describe what oscillator across the available 4
> +      should be selected for USB 2.0 Slew Rate calibration.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]
> +
> +  airoha,serdes-port:
> +    description: Describe what Serdes Port is attached to the USB 3.0 port.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]

Since you only have a single value here, does that mean only only one of 
the 2 ports/phys supports USB3?

> +
> +  airoha,scu:
> +    description: Phandle to the SCU node for USB 3.0 Serdes mode validation.
> +    $ref: /schemas/types.yaml#/definitions/phandle

A bit unusual, but you could use the phys binding here instead of these 
2 properties. The phy for the phy...

> +
> +  '#phy-cells':
> +    const: 1

Please add a description of what's in the cell.

> +
> +required:
> +  - compatible
> +  - reg
> +  - airoha,usb2-monitor-clk-sel
> +  - '#phy-cells'
> +
> +dependentRequired:
> +  airoha,serdes-port: [ 'airoha,scu' ]
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/phy/airoha,an7581-usb-phy.h>
> +    #include <dt-bindings/soc/airoha,scu-ssr.h>
> +
> +    phy@1fac0000 {
> +        compatible = "airoha,an7581-usb-phy";
> +        reg = <0x1fac0000 0x10000>;
> +
> +        airoha,usb2-monitor-clk-sel = <AIROHA_USB2_MONCLK_SEL1>;
> +        airoha,scu = <&scu>;
> +        airoha,serdes-port = <AIROHA_SCU_SERDES_USB1>;
> +
> +        #phy-cells = <1>;
> +    };
> +
> +    phy@1fae0000 {
> +        compatible = "airoha,an7581-usb-phy";
> +        reg = <0x1fae0000 0x10000>;
> +
> +        airoha,usb2-monitor-clk-sel = <AIROHA_USB2_MONCLK_SEL2>;
> +
> +        #phy-cells = <1>;
> +    };

Drop the 2nd example.

Rob

