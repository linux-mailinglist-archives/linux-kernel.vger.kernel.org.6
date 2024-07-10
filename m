Return-Path: <linux-kernel+bounces-247200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4859B92CC70
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C9F01C23230
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF7F85628;
	Wed, 10 Jul 2024 08:03:07 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE5E84A32;
	Wed, 10 Jul 2024 08:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720598586; cv=none; b=FVm9Co1T+7Utt1rQyWnHHs560ERRmEXLAMuv24tZvObsJBnSgNRKeQX1BL6Im+WT32XDPcTzdcKzk64ulQIFsy+6AFkd7n8veRfoIlfkRN/I0X4jS10/mW2ugXBBOx/1R6hFoSCkganTEXLm8r6t7mEpAsPdBB5XVTqD8gc73Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720598586; c=relaxed/simple;
	bh=iFeVLiw/azQMmEn8Sn1e8xF5y/X3PlVSkCCZesMwLok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPf6RhLXQQ3YZecR0g8AaveeXMJxdyvNAbAVJA//zcNFIjmZVHcq+c1SZuGWgUJOTUrGCgUXpl2gPpulPPi1INzILmChFncOGbwkRUHNx1l+qgYoJCes76R2RQdeIwAykqtw3n1uRm9QBZ577/obLC1E5GNE0UdLqOqCDrBK1p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860d18.versanet.de ([94.134.13.24] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sRSHy-0005Wq-Iy; Wed, 10 Jul 2024 10:02:58 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: mturquette@baylibre.com, Stephen Boyd <sboyd@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 quentin.schulz@cherry.de, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject:
 Re: [PATCH 1/6] dt-bindings: clocks: add binding for generic clock-generators
Date: Wed, 10 Jul 2024 10:02:57 +0200
Message-ID: <1903511.1xdlsreqCQ@diego>
In-Reply-To: <2e5852b9e94b9a8d0261ce7ad79f4329.sboyd@kernel.org>
References:
 <20240709123121.1452394-1-heiko@sntech.de>
 <20240709123121.1452394-2-heiko@sntech.de>
 <2e5852b9e94b9a8d0261ce7ad79f4329.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Stephen,

Am Dienstag, 9. Juli 2024, 23:45:20 CEST schrieb Stephen Boyd:
> Quoting Heiko Stuebner (2024-07-09 05:31:16)
> > In contrast to fixed clocks that are described as ungateable, boards
> > sometimes use additional clock generators for things like PCIe reference
> > clocks, that need actual supplies to get enabled and enable-gpios to be
> > toggled for them to work.
> > 
> > This adds a binding for such clock generators that are not configurable
> > themself, but need to handle supplies for them to work.
> 
> Sounds like vdd-supply is required?

yeah, I guess this could move to required

> > 
> > While in a lot of cases the type of the IC used is described in board
> > schematics, in some cases just a generic type description like
> > "100MHz, 3.3V" might also be used. The binding therefore allows both
> > cases. Specifying the type is of course preferred.
> > 
> > The clock-frequency is set in devicetree, because while some clock
> > generators have pins to decide between multipls output rates, those
> > are generally set statically on the board-layout-level.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  .../bindings/clock/clock-generator.yaml       | 62 +++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/clock-generator.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/clock-generator.yaml b/Documentation/devicetree/bindings/clock/clock-generator.yaml
> > new file mode 100644
> > index 0000000000000..f44e61e414e89
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/clock-generator.yaml
> > @@ -0,0 +1,62 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/clock-generator.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Simple clock generators
> > +
> > +maintainers:
> > +  - Heiko Stuebner <heiko@sntech.de>
> > +
> > +properties:
> > +  $nodename:
> > +    anyOf:
> > +      - description:
> > +          Preferred name is 'clock-<freq>' with <freq> being the output
> > +          frequency as defined in the 'clock-frequency' property.
> > +        pattern: "^clock-([0-9]+|[a-z0-9-]+)$"
> > +      - description: Any name allowed
> > +        deprecated: true
> 
> Drop the deprecated stuff from the fixed-clock binding?

ok

> 
> > +
> > +  compatible:
> > +    oneOf:
> > +      - const: clock-generator
> > +      - items:
> > +          - enum:
> > +              - diodes,pi6c557-03b
> 
> I see this datasheet[1]. Can that link be included somewhere? That shows
> there's a clock input pin, which means I expect a 'clocks' property.

ok, I guess we could add a clock property and make it mandatory for the
Diodes compatibles.


> Maybe instead of creating a generic binding just make a binding for
> these diodes parts? It certainly looks like a generic binding could come
> later when another vendor supports the same binding.

I was actually primarily aiming at solving the Rock 5 ITX clock generator
issue described in patch 5, where the 100 MHz clock generator is just
described as "100MHz,3.3V,3225" in the schematics, but definitly needs
the supply regulator to be enabled [1].

The Theobroma boards were addons because I felt they could also describe
the hardware better instead of lumping together 2 existing bindings.


> > +              - diodes,pi6c557-05b
> > +          - const: clock-generator
> > +
> > +  "#clock-cells":
> > +    const: 0
> > +
> > +  clock-frequency: true
> > +
> > +  clock-output-names:
> > +    maxItems: 1
> > +
> > +  enable-gpios:
> > +    description:
> > +      Contains a single GPIO specifier for the GPIO that enables and disables
> > +      the clock generator.
> > +    maxItems: 1
> > +
> > +  vdd-supply:
> > +    description: handle of the regulator that provides the supply voltage
> > +
> > +required:
> > +  - compatible
> > +  - "#clock-cells"
> > +  - clock-frequency
> 
> This is the same required properties as fixed rate clocks. I'd guess
> that at least 'enable-gpios' or 'vdd-supply' should also be required, or
> the node would simply use fixed-clock compatible.

ok, as said above, having the vdd-supply as requirement does make sense.


Heiko


[1] https://dl.radxa.com/rock5/5itx/radxa_rock_5_itx_X1100_schematic.pdf
page 35, bottom left, to the left of the big Au5426 "clock buffer".



