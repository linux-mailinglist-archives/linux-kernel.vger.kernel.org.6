Return-Path: <linux-kernel+bounces-252969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77ADE931AAD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B261C21842
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6798565E;
	Mon, 15 Jul 2024 19:14:01 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2DB78C6C;
	Mon, 15 Jul 2024 19:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721070841; cv=none; b=uB8e2exSefJSzCzlIchwxxoS1O6SlDOYuMthXJOsWWo7ccVIVo7DMwk25tiBHsCLIsnxGio9ttLRRCQHyu75odhRTXwvkMkTldgiAU21RBgB2MwlwhqF4+VRfoFS6zqlbvK8LfmoxG15EONviIKbs+jM79DtDkHAqlPePQMIX8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721070841; c=relaxed/simple;
	bh=fIQ+ACZGPZuT+kNfAz7akNBEp4VxODJSdVsR/V97H90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o8T8osHMFMgqteXKWXhfQFI/tzJ3ML4e9SHEoMhGSWrCCM02G07JhWFSgL/MDkILVoSH04Bm1CvyjekAaV9hIkbqo3Av7cM+xp7pZriqHMPzVZe2UfbdiAwVWLgk8SSTJZ5FQBe/KLMBH275AdIspWIl3x0M+FV7xz79a3dRmPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860d09.versanet.de ([94.134.13.9] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sTR8s-0001wA-Fu; Mon, 15 Jul 2024 21:13:46 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Dragan Simic <dsimic@manjaro.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject:
 Re: [PATCH v2 1/3] dt-bindings: clocks: add binding for
 voltage-controlled-oscillators
Date: Mon, 15 Jul 2024 21:13:45 +0200
Message-ID: <2186398.KiezcSG77Q@diego>
In-Reply-To: <3f0c241d39c5fedb674d7f9808d0be8f@manjaro.org>
References:
 <20240715110251.261844-1-heiko@sntech.de> <2832997.XrmoMso0CX@diego>
 <3f0c241d39c5fedb674d7f9808d0be8f@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Montag, 15. Juli 2024, 20:01:35 CEST schrieb Dragan Simic:
> On 2024-07-15 19:46, Heiko St=FCbner wrote:
> > Am Montag, 15. Juli 2024, 17:15:45 CEST schrieb Dragan Simic:
> >> On 2024-07-15 13:02, Heiko Stuebner wrote:
> >> > In contrast to fixed clocks that are described as ungateable, boards
> >> > sometimes use additional oscillators for things like PCIe reference
> >> > clocks, that need actual supplies to get enabled and enable-gpios to=
 be
> >> > toggled for them to work.
> >> >
> >> > This adds a binding for such oscillators that are not configurable
> >> > themself, but need to handle supplies for them to work.
> >> >
> >> > In schematics they often can be seen as
> >> >
> >> >          ----------------
> >> > Enable - | 100MHz,3.3V, | - VDD
> >> >          |    3225      |
> >> >    GND - |              | - OUT
> >> >          ----------------
> >> >
> >> > or similar. The enable pin might be separate but can also just be ti=
ed
> >> > to the vdd supply, hence it is optional in the binding.
> >> >
> >> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> >> > ---
> >> >  .../bindings/clock/voltage-oscillator.yaml    | 49 ++++++++++++++++=
+++
> >> >  1 file changed, 49 insertions(+)
> >> >  create mode 100644
> >> > Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
> >> >
> >> > diff --git
> >> > a/Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
> >> > b/Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
> >> > new file mode 100644
> >> > index 0000000000000..8bff6b0fd582e
> >> > --- /dev/null
> >> > +++ b/Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
> >> > @@ -0,0 +1,49 @@
> >> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> > +%YAML 1.2
> >> > +---
> >> > +$id: http://devicetree.org/schemas/clock/voltage-oscillator.yaml#
> >> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> > +
> >> > +title: Voltage controlled oscillator
> >>=20
> >> Frankly, I find the "voltage-oscillator" and "voltage controlled
> >> oscillator" names awkward.  In general, "clock" is used throughout
> >> the entire kernel, when it comes to naming files and defining
> >> "compatible" strings.  Thus, I'd suggest that "clock" is used here
> >> instead of "oscillator", because it's consistent and shorter.
> >>=20
> >> How about using "gated-clock" for the "compatible" string, and
> >> "Simple gated clock generator" instead of "voltage controlled
> >> oscillator"?  Besides sounding awkward, "voltage controlled
> >> oscillator" may suggest that the clock generator can be adjusted
> >> or programmed somehow by applying the voltage, while it can only
> >> be enabled or disabled that way, which is by definition clock
> >> gating.  Thus, "gated-clock" and "Simple gated clock generator"
> >> would fit very well.
> >=20
> > The naming came from Stephen - one of the clock maintainers ;-)
> > See discussion in v1. Who also described these things as
> > "voltage-controlled-oscillators".
> >=20
> > And from that discussion I also got the impression we should aim for
> > more specific naming - especially when talking about dt-bindings, for=20
> > this
> > "usage in the Linux kernel" actually isn't a suitable metric and
> > "gated-clock" is probably way too generic I think.
>=20
> I see, thanks for the clarification.  Though, the generic nature of
> "gated-clock" as the name may actually make this driver a bit more
> future-proof, by allowing some other features to be added to it at
> some point in the future, avoiding that way the need for yet another
> kernel driver.

you're talking about the driver ... we're in the hardware-binding here.
Those are two completely different topics ;-) .

Devicetree is always about describing the hardware as best as possible,
so you don't want too many "generics" there, because we're always talking
about specific ICs soldered to some board.

I also "violated" that in my v1 by grouping in the the Diodes parts, which
as Stephen pointed out are quite different afterall.


Heiko



