Return-Path: <linux-kernel+bounces-529704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751AEA42A0B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B92863A72D4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF665265634;
	Mon, 24 Feb 2025 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="QGUA3CWN"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B4D2571A7;
	Mon, 24 Feb 2025 17:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418532; cv=none; b=FuV6gL0fIEHOq8ZPTTnhyeFGXx/ToGpToR+3/Tg+uF9zbJoa4MaCdmISInbOiYHpsp0RLqXdWMMoYQX+FWLBnu5n1sA+DFeRJ8KC4wR+lfG/Aa8EI2ffxWAlA31GQX97H8FdOtAQDcVxIRZi/6/ECNpA5t4zO6Lx+hXpygQNxC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418532; c=relaxed/simple;
	bh=i22IAVTAO3pfY8ToQVg8JT04CAxa2kXTVUFL+IbTL4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDz4fJt7kO4wVObDP9UAgv0hcQmzJ/H4lnFSxyz5xQTBYBHFU8IutalGi1ONxmY5U3HgCRMTscJ1u1dQpfnkn6HU/3RAEpLbEUviIKMm6O1j7KzSVCG3pkbKDS8rhuJAtgaAVtEWZVg8o3IPhGcMwVZ0Yduna86oTIDjsFQrM7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=QGUA3CWN; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 8F22F20648;
	Mon, 24 Feb 2025 18:35:26 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QpJm_5OANzFD; Mon, 24 Feb 2025 18:35:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1740418522; bh=i22IAVTAO3pfY8ToQVg8JT04CAxa2kXTVUFL+IbTL4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QGUA3CWNEtsRmDhqYaetzRpV0soYfzkz79PxMxPeaRXJWW4GyiEwwFeTT45fLax0/
	 Lut4N6ImQA4vC+2KCo8dj7hzusdpwlsInDUv5G2+Tb5Kmm+DdTZPkLsMpxqZJ4zq21
	 ZWKvvM+UJm2OWg6y01Mnx9U0XxSyP5ZpMOcNSMkaaYG/qX8u6H4NG5Yqmh10QmL8ZC
	 e8IJgCZwx0Pe89RPOJ+kqL4yVZMegp6ERK9TXvsnnEwCKU0M6bq1b54gnLKvDRuiW7
	 +p+naZHib8SsDhKaoVeTWTMM4mhvRVquQfwRK6bpzKcpMPMXSkDp3dAruNd7Tud1jr
	 7RlyLgyRbn0YQ==
Date: Mon, 24 Feb 2025 17:35:04 +0000
From: Yao Zi <ziyao@disroot.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: clock: Document clock and reset unit
 of RK3528
Message-ID: <Z7ytqSQkwwi3RmB9@pie.lan>
References: <20250217061142.38480-5-ziyao@disroot.org>
 <20250217061142.38480-6-ziyao@disroot.org>
 <49730692.MN2xkq1pzW@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49730692.MN2xkq1pzW@diego>

On Mon, Feb 24, 2025 at 10:09:29AM +0100, Heiko Stübner wrote:
> Am Montag, 17. Februar 2025, 07:11:42 MEZ schrieb Yao Zi:
> > There are two types of clocks in RK3528 SoC, CRU-managed and
> > SCMI-managed. Independent IDs are assigned to them.
> > 
> > For the reset part, differing from previous Rockchip SoCs and
> > downstream bindings which embeds register offsets into the IDs, gapless
> > numbers starting from zero are used.
> > 
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> >  .../bindings/clock/rockchip,rk3528-cru.yaml   |  64 +++
> >  .../dt-bindings/clock/rockchip,rk3528-cru.h   | 453 ++++++++++++++++++
> >  .../dt-bindings/reset/rockchip,rk3528-cru.h   | 241 ++++++++++
> >  3 files changed, 758 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3528-cru.yaml
> >  create mode 100644 include/dt-bindings/clock/rockchip,rk3528-cru.h
> >  create mode 100644 include/dt-bindings/reset/rockchip,rk3528-cru.h
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3528-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3528-cru.yaml
> > new file mode 100644
> > index 000000000000..5a3ec902351c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3528-cru.yaml
> > @@ -0,0 +1,64 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/rockchip,rk3528-cru.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Rockchip RK3528 Clock and Reset Controller
> > +
> > +maintainers:
> > +  - Yao Zi <ziyao@disroot.org>
> > +
> > +description: |
> > +  The RK3528 clock controller generates the clock and also implements a reset
> > +  controller for SoC peripherals. For example, it provides SCLK_UART0 and
> > +  PCLK_UART0 as well as SRST_P_UART0 and SRST_S_UART0 for the first UART
> > +  module.
> > +  Each clock is assigned an identifier, consumer nodes can use it to specify
> > +  the clock. All available clock and reset IDs are defined in dt-binding
> > +  headers.
> > +
> > +properties:
> > +  compatible:
> > +    const: rockchip,rk3528-cru
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> 
> I do think this needs a
>     minItems: 1
>     maxItems: 2
> or similar.
> 
> xin24m is the main oscillator everything else is supplied from, so is
> absolutely required, but that gmac0 supply comes from an (probably)
> optional clock supply from a mac phy?
> 
> So is possibly not available on a system without ethernet hardware?

I don't think so. By the CRU commit message[1] in the vendor driver, the
"phy module" should mean the integrated phy for GMAC0,

	The io-in clocks are module phy output clock, gating child
	clocks by disabling phy output but not CRU gate.

	Add gmac0 clocks. They are all orphans if clk_gmac0_io_i is not
	registered by GMAC driver. But it's fine that GMAC driver only
	get it but not to set/get rate.

(gmac0 is called "clk_gmac0_io_i" in the vendor driver).

Taking that both the upstream and downstream Rockchip GMAC glue (GMAC
driver) takes some care of the integrated phy, if the clock is an
out-of-SoC supply, the second paragraph sounds less sensible: the clock
should be registered by the external PHY instead of the GMAC driver in
this case.

And there cannot be a case that an integrated clocksource is missing.

> 
> 
> Heiko
> 
> 

Thanks,
Yao Zi

[1]: https://github.com/rockchip-linux/kernel/commit/16f512f1e10375dc48aa6c26cedeb7079aba01de

