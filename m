Return-Path: <linux-kernel+bounces-572059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC07EA6C607
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E333B7D22
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CE7232379;
	Fri, 21 Mar 2025 22:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/b5e3Xw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707B04A0C;
	Fri, 21 Mar 2025 22:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742596656; cv=none; b=CnHy5cxcQs2DpQCUKmTZ+qOiKzpt6YUR7hDr5bJBkmwjU//GmnYK9nqwd8TNgelNMRXI/0Q6wjMaoGMISQv2tMNx8KXL8MYxuwiIxwN3i5ffgI5PJz/u8PxfHD3m1SsBECH4cI2QUOG//oip/tlfRK6hXTP2qa+Jcj5GmbmNAHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742596656; c=relaxed/simple;
	bh=ramSATIM6Gfyw9DQk/rIg5hUgUc4Aq61YIxEdbWpWAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbhvrZ1heUvoJRqXueUHhxPyAg18caQg5qoIe2QP6yJe+sGehLySt5eISC1KBqUzNKao1eufYh24Lp1qaUH8HWhEjHFJJfVsyv725SP6/Fgx2tp9Pr/eCLkzEJrK3qH9/RdxtbVAQ3zzgWb1sjExzTH5uqieiJOfKeVKLroZdes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/b5e3Xw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD08C4CEE3;
	Fri, 21 Mar 2025 22:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742596655;
	bh=ramSATIM6Gfyw9DQk/rIg5hUgUc4Aq61YIxEdbWpWAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u/b5e3XwA10wQ0+gzZsAmrh+PYEPBTqOTPwQCOEJmGQ72ZsBAs4AUVs6sGkyH/oCm
	 OWh72S7LLTL5DxzFvdSVgJM05lo4MiYSGkdaANNFI7HR/8FtIQh08BqBmmYhZP/ldO
	 U3oL9HVf6BXs+eapmm7aKRLfGJQhcMI2zTLB7ahA4kLIvR71WujKLPNXhhxJ09PWNH
	 dLlWWMcr/3JOadEK6bvLKreEPEgWRHTlPVHQKyqypBDzcPN1PYgvavIhgMIqlbIe4a
	 Y26LDPTZ5wsqjo3Tn2S6/fmAZ82NZi6oHL8CNGEyRnkbS2KBvmAFiFSMTSn7PLiEhS
	 6vAgxK49Xc4wA==
Date: Fri, 21 Mar 2025 17:37:34 -0500
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
Subject: Re: [PATCH v2 03/11] dt-bindings: clock: en7523: add Documentation
 for Airoha AN7581 SCU SSR
Message-ID: <20250321223734.GA6837-robh@kernel.org>
References: <20250320130054.4804-1-ansuelsmth@gmail.com>
 <20250320130054.4804-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320130054.4804-4-ansuelsmth@gmail.com>

On Thu, Mar 20, 2025 at 02:00:26PM +0100, Christian Marangi wrote:
> The Airoha AN7581 SoC have in the SCU register space particular
> address that control how some peripheral are configured.
> 
> These are toggeled in the System Status Register and are used to
> toggle Serdes port for USB 3.0 mode or HSGMII, USB 3.0 mode or PCIe2
> or setup port for PCIe mode or Ethrnet mode (HSGMII/USXGMII).
> 
> Modes are mutually exclusive and selecting one mode cause the
> other feature to not work (example a mode in USB 3.0 cause PCIe
> port 2 to not work) This depends also on what is physically
> connected to the Hardware and needs to correctly reflect the
> System Status Register bits.
> 
> Special care is needed for PCIe port 0 in 2 line mode that
> requires both WiFi1 and WiFi2 Serdes port set to PCIe0 2 Line
> mode.
> 
> Expose these configuration as an enum of strings in the SCU node and
> also add dt-bindings header to reference each serdes port in DT.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/clock/airoha,en7523-scu.yaml     | 101 ++++++++++++++++--
>  MAINTAINERS                                   |   7 ++
>  include/dt-bindings/soc/airoha,scu-ssr.h      |  11 ++
>  3 files changed, 110 insertions(+), 9 deletions(-)
>  create mode 100644 include/dt-bindings/soc/airoha,scu-ssr.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml b/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
> index fe2c5c1baf43..637ce0e06619 100644
> --- a/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
> +++ b/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
> @@ -9,6 +9,7 @@ title: EN7523 Clock
>  maintainers:
>    - Felix Fietkau <nbd@nbd.name>
>    - John Crispin <nbd@nbd.name>
> +  - Christian Marangi <ansuelsmth@gmail.com>
>  
>  description: |
>    This node defines the System Control Unit of the EN7523 SoC,
> @@ -26,6 +27,23 @@ description: |
>  
>    The clocks are provided inside a system controller node.
>  
> +  The System Control Unit may also set different mode for the Serdes ports
> +  present on the SoC.
> +
> +  These are toggeled in the System Status Register and are used to
> +  toggle Serdes port for USB 3.0 mode or HSGMII, USB 3.0 mode or PCIe2
> +  or setup port for PCIe mode or Ethernet mode (HSGMII/USXGMII).
> +
> +  Modes are mutually exclusive and selecting one mode cause the
> +  other feature to not work (example a mode in USB 3.0 cause PCIe
> +  port 2 to not work) This depends also on what is physically
> +  connected to the Hardware and needs to correctly reflect the
> +  System Status Register bits.
> +
> +  Special care is needed for PCIe port 0 in 2 line mode that
> +  requires both WiFi1 and WiFi2 Serdes port set to PCIe0 2 Line
> +  mode.
> +
>  properties:
>    compatible:
>      items:
> @@ -49,6 +67,40 @@ properties:
>      description: ID of the controller reset line
>      const: 1
>  
> +  airoha,serdes-wifi1:
> +    description: Configure the WiFi1 Serdes port
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum:
> +      - pcie0_x2
> +      - pcie0_x1
> +      - ethernet
> +    default: pcie0_x1
> +
> +  airoha,serdes-wifi2:
> +    description: Configure the WiFi2 Serdes port
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum:
> +      - pcie0_x2
> +      - pcie1_x1
> +      - ethernet
> +    default: pcie1_x1
> +
> +  airoha,serdes-usb1:
> +    description: Configure the USB1 Serdes port
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum:
> +      - usb3
> +      - ethernet
> +    default: usb3
> +
> +  airoha,serdes-usb2:
> +    description: Configure the USB2 Serdes port
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum:
> +      - usb3
> +      - pcie2_x1
> +    default: usb3

Couldn't you make this a phy provider and use the mode flags in the 
phy cells?

> +
>  required:
>    - compatible
>    - reg
> @@ -64,6 +116,12 @@ allOf:
>          reg:
>            minItems: 2
>  
> +        airoha,serdes-wifi1: false
> +        airoha,serdes-wifi2: false
> +
> +        airoha,serdes-usb1: false
> +        airoha,serdes-usb2: false
> +
>          '#reset-cells': false
>  
>    - if:
> @@ -75,6 +133,24 @@ allOf:
>          reg:
>            maxItems: 1
>  
> +  - if:
> +      properties:
> +        airoha,serdes-wifi1:
> +          const: pcie0_x2

This is also true if airoha,serdes-wifi1 is not present. Probably not 
what you intended.

> +    then:
> +      properties:
> +        airoha,serdes-wifi2:
> +          const: pcie0_x2
> +
> +  - if:
> +      properties:
> +        airoha,serdes-wifi2:
> +          const: pcie0_x2
> +    then:
> +      properties:
> +        airoha,serdes-wifi1:
> +          const: pcie0_x2
> +
>  additionalProperties: false

