Return-Path: <linux-kernel+bounces-256215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E6A934AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8578A2878C3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B1F81AD7;
	Thu, 18 Jul 2024 09:25:45 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B7A28DD1;
	Thu, 18 Jul 2024 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721294744; cv=none; b=px6y1VsNcdLv1dEI5WhC23hMc3z0Ag3WqljUd7a9EiqGguVe/gQgXAZdGcdYIfqUACsvIqZYAlJUGtyfc5DOv8QXHZX7cSCr6p7+6nUPyBYH8Kl2oZW7WAmnrIbvYgJYfMt5vkj4BxE3TtkOcLgHV92hRZyOEU5oKu+mEyc5vzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721294744; c=relaxed/simple;
	bh=sBpRG87XTr+lD5LPwEAV/IC2h5JXbj8qV0PXvNTPR9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4FrZv3S9V7YRtAoUFLUWzqTumi7D36avutDKbZEpLaTv31MZRo18MyzLnQF2B4mKySzhBUNyCNhiOh94AkSNNSl3eMLEuLO+3i4MOa1sSZtF7lg+r05V6cH+sYSyaeedYG17mQEQuTEcuxc5ioDvCE0uB08lVruEykENMHJ0u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860d09.versanet.de ([94.134.13.9] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sUNOD-0003Jt-IN; Thu, 18 Jul 2024 11:25:29 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Conor Dooley <conor@kernel.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject:
 Re: [PATCH v2 1/3] dt-bindings: clocks: add binding for
 voltage-controlled-oscillators
Date: Thu, 18 Jul 2024 11:25:28 +0200
Message-ID: <3178118.zE8UqtGg2D@diego>
In-Reply-To: <20240716-deceiving-saucy-851fb2303c1f@spud>
References:
 <20240715110251.261844-1-heiko@sntech.de>
 <20240715110251.261844-2-heiko@sntech.de>
 <20240716-deceiving-saucy-851fb2303c1f@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Conor,

Am Dienstag, 16. Juli 2024, 18:15:08 CEST schrieb Conor Dooley:
> On Mon, Jul 15, 2024 at 01:02:49PM +0200, Heiko Stuebner wrote:
> > In contrast to fixed clocks that are described as ungateable, boards
> > sometimes use additional oscillators for things like PCIe reference
> > clocks, that need actual supplies to get enabled and enable-gpios to be
> > toggled for them to work.
> > 
> > This adds a binding for such oscillators that are not configurable
> > themself, but need to handle supplies for them to work.
> > 
> > In schematics they often can be seen as
> > 
> >          ----------------
> > Enable - | 100MHz,3.3V, | - VDD
> >          |    3225      |
> >    GND - |              | - OUT
> >          ----------------
> > 
> > or similar. The enable pin might be separate but can also just be tied
> > to the vdd supply, hence it is optional in the binding.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  .../bindings/clock/voltage-oscillator.yaml    | 49 +++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/voltage-oscillator.yaml b/Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
> > new file mode 100644
> > index 0000000000000..8bff6b0fd582e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
> > @@ -0,0 +1,49 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/voltage-oscillator.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Voltage controlled oscillator
> 
> Voltage controlled oscillator? Really? That sounds far too similar to a
> VCO to me, and the input voltage here (according to the description at
> least) does not affect the frequency of oscillation.

That naming was suggested by Stephen in v1 [0] .

Of course the schematics for the board I have only describe it as
"100MHz,3.3V,3225" , thumbing through some mouser parts matching that
only mentions "supply voltage" in their datasheets but not a dependency
between rate and voltage.

[0] https://lore.kernel.org/linux-arm-kernel/b3c450a94bcb4ad0bc5b3c7ee8712cb8.sboyd@kernel.org/

> Why the dedicated binding, rather than adding a supply and enable-gpio
> to the existing "fixed-clock" binding? I suspect that a large portion of
> "fixed-clock"s actually require a supply that is (effectively)
> always-on.

I guess there are three aspects:
- I do remember discussions in the past about not extending generic
  bindings with device-specific stuff. I think generic power-sequences
  were the topic back then, though that might have changed over time?
- There are places that describe "fixed-clock" as
  "basic fixed-rate clock that cannot gate" [1]
- Stephen also suggested a separate binding [2]

With the fixed-clock being sort of the root for everything else on most
systems, I opted to leave it alone. I guess if the consenus really is that
this should go there, I can move it, but discussion in v1 

Interestingly the fixed clock had a gpios property 10 years ago [3] :-) .

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/clk-fixed-rate.c#n18
[2] https://lore.kernel.org/linux-arm-kernel/68f6dc44a8202fd83792e58aea137632.sboyd@kernel.org/
[3] https://lore.kernel.org/linux-kernel//20140515064420.9521.47383@quantum/T/#t


Heiko


> > +
> > +maintainers:
> > +  - Heiko Stuebner <heiko@sntech.de>
> > +
> > +properties:
> > +  compatible:
> > +    const: voltage-oscillator
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
> > +      the oscillator.
> > +    maxItems: 1
> > +
> > +  vdd-supply:
> > +    description: handle of the regulator that provides the supply voltage
> > +
> > +required:
> > +  - compatible
> > +  - "#clock-cells"
> > +  - clock-frequency
> > +  - vdd-supply
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    voltage-oscillator {
> > +      compatible = "voltage-oscillator";
> > +      #clock-cells = <0>;
> > +      clock-frequency = <1000000000>;
> > +      vdd-supply = <&reg_vdd>;
> > +    };
> > +...
> 





