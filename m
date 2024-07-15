Return-Path: <linux-kernel+bounces-252908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1FC9319C6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF2EB1C21D88
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07A450269;
	Mon, 15 Jul 2024 17:46:43 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2AE125D5;
	Mon, 15 Jul 2024 17:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721065603; cv=none; b=QCeW6dCBdf7S3qsw6pNtcgad3Sy/qG3s16s+rrZ6tW9L4K+Cg5jRqwG/AYB+QEBYPdtDhz7G3yC07DYmGEGSjz40IrvhKclC/0wPHyn91w3QzVYGtun5HOV5bFwBAY3wcuV1is0y1HVgNlnX/s+vXqPlyNpzups5B2BBC5wUgPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721065603; c=relaxed/simple;
	bh=VXVbN9kVctxpCLaC6fuPCB3UIf99V0ng/q0AjorBnUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cS4Hj5xgdnSHYDO9KfM0dX5mKdQ/tS3nOqzWPu8t+H3+hu1JAmkIMBWJzTbNfh4mbMTw9fR7nOJXf8eJG3xKAvNy1et6Dx5Jv4nYnrZGqBghPz/2s/aHoEw5AcHG4TZmJzt9Zb/XPCE3kA7uhzs1MfPqfJfglVaGg6j9tuzXT8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860d09.versanet.de ([94.134.13.9] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sTPmK-0001Bk-MA; Mon, 15 Jul 2024 19:46:24 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Dragan Simic <dsimic@manjaro.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject:
 Re: [PATCH v2 1/3] dt-bindings: clocks: add binding for
 voltage-controlled-oscillators
Date: Mon, 15 Jul 2024 19:46:23 +0200
Message-ID: <2832997.XrmoMso0CX@diego>
In-Reply-To: <ec84dc37e2c421ee6d31294e08392d57@manjaro.org>
References:
 <20240715110251.261844-1-heiko@sntech.de>
 <20240715110251.261844-2-heiko@sntech.de>
 <ec84dc37e2c421ee6d31294e08392d57@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Dragan,

Am Montag, 15. Juli 2024, 17:15:45 CEST schrieb Dragan Simic:
> On 2024-07-15 13:02, Heiko Stuebner wrote:
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
> >  create mode 100644
> > Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
> > b/Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
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
> Frankly, I find the "voltage-oscillator" and "voltage controlled
> oscillator" names awkward.  In general, "clock" is used throughout
> the entire kernel, when it comes to naming files and defining
> "compatible" strings.  Thus, I'd suggest that "clock" is used here
> instead of "oscillator", because it's consistent and shorter.
>
> How about using "gated-clock" for the "compatible" string, and
> "Simple gated clock generator" instead of "voltage controlled
> oscillator"?  Besides sounding awkward, "voltage controlled
> oscillator" may suggest that the clock generator can be adjusted
> or programmed somehow by applying the voltage, while it can only
> be enabled or disabled that way, which is by definition clock
> gating.  Thus, "gated-clock" and "Simple gated clock generator"
> would fit very well.

The naming came from Stephen - one of the clock maintainers ;-)
See discussion in v1. Who also described these things as
"voltage-controlled-oscillators".

And from that discussion I also got the impression we should aim for
more specific naming - especially when talking about dt-bindings, for this
"usage in the Linux kernel" actually isn't a suitable metric and
"gated-clock" is probably way too generic I think.

Though I'm not attached to any specific naming, so we'll simply
wait for the clock- and dt-maintainers to weigh in ;-)


Heiko



