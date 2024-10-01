Return-Path: <linux-kernel+bounces-346677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F6F98C774
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 23:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BAEC2834D2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A991CDA31;
	Tue,  1 Oct 2024 21:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="HfbBzqrS"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A125519C56F;
	Tue,  1 Oct 2024 21:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727817514; cv=none; b=n6I5gmIkxria+N/K9IRgBnRrxudDgiDCL7xbnNZQ4f1EQzGf1d5nEtZ+hNbsL4LWNx1CI68pGhB+1/g87g6OPG4IusHBdkzj/8FEZulSBj7OzYts2b/XXlzAbLmgUXs0fU+4oMWfIAmAAeRFOQqsy9Iay9hgQZvCFPFGEDVrYfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727817514; c=relaxed/simple;
	bh=5BEqICgxywgmXFlHoLikSfxTzOLsRkFpUx8kZwsw5d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/ElyaDYRKCzAzeherSSTKTGtDBHdK5l3bGgKag/xUcT+Q25V3Ny32dAkIvIWx6dRpxhWqBNTlCgevpC7acoKhldV/bUKksL7D59XHF8ixI/EyS6ruj08hwAeOUM2tSHwxPVMbJo4kWD8t7d5WcGo9qmAXOzqpc1NBKz8KadL/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=HfbBzqrS; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 2AC1923D6B;
	Tue,  1 Oct 2024 23:18:30 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5c_6UKsH-27M; Tue,  1 Oct 2024 23:18:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1727817509; bh=5BEqICgxywgmXFlHoLikSfxTzOLsRkFpUx8kZwsw5d8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HfbBzqrSbDqfukvQgebq/5lhHCi3dAiHhUVfMtu5g4tXB0IJS/KBDvXiW+WOmgP+Z
	 Jn1g6Lzmxqq+q+u9ARpOlrjjVPUzHu9juLQIen7hxnmubBhn0jhTEWl3tQkRzpI/jd
	 3w6zCwMXAD/kK4OKi0MsHz6rzyKCNI2YnYy/Mnfo9ZvAi9D+aOJWk+NS/ezT0nCf+w
	 dGrzwZ/JhsKzl0YLqHSwdnq4+VVG1NYX33o3a9MHMpK+NM/30uRiC5SWMsSLlOHGFR
	 vM35D2qdxRPzZmBN6F5wF5kOwFQtfQSauF1Fb1pSFyYfNkG9us8dGpIPUDMKOBgXwM
	 lR8DjlheUPksQ==
Date: Tue, 1 Oct 2024 21:18:03 +0000
From: Yao Zi <ziyao@disroot.org>
To: Conor Dooley <conor@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Celeste Liu <CoelacanthusHex@gmail.com>
Subject: Re: [PATCH 3/8] dt-bindings: clock: Add rockchip,rk3528-cru
Message-ID: <Zvxm71YvGbF1s_2w@pineapple>
References: <20241001042401.31903-2-ziyao@disroot.org>
 <20241001042401.31903-5-ziyao@disroot.org>
 <20241001-name-stooge-7a939f71a08e@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001-name-stooge-7a939f71a08e@spud>

On Tue, Oct 01, 2024 at 05:29:15PM +0100, Conor Dooley wrote:
> On Tue, Oct 01, 2024 at 04:23:57AM +0000, Yao Zi wrote:
> > Document Rockchip RK3528 clock and reset unit.
> > 
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> >  .../bindings/clock/rockchip,rk3528-cru.yaml   | 63 +++++++++++++++++++
> >  1 file changed, 63 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3528-cru.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3528-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3528-cru.yaml
> > new file mode 100644
> > index 000000000000..ae51dfde5bb9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3528-cru.yaml
> > @@ -0,0 +1,63 @@
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
> > +    enum:
> > +      - rockchip,rk3528-cru
> 
> nit: This can probably be a const, rather than an enum.
> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  assigned-clocks: true
> > +
> > +  assigned-clock-rates: true
> > +
> > +  clocks:
> > +    minItems: 2
> > +    maxItems: 2
> > +
> > +  clock-names:
> > +    items:
> > +      - const: xin24m
> > +      - const: phy_50m_out
> 
> Why is this input clock named "out"? clocks should be named after how
> they're used in the IP in question, not the name of the source of that
> clock in the SoC.
> Without descriptions provided in the clocks property, it is hard to
> understand what this second clock is for.

Thanks for explaination, it should something like "clk_gmac0".

> > +
> > +  "#clock-cells":
> > +    const: 1
> > +
> > +  "#reset-cells":
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> 
> Why would the input clocks be optional?

This follows other Rockchip SoCs, which often omit input clocks in
devicetree and depend on clock names registered in common clock
framework to work.

For completeness, they really shouldn't be optional.

> > +  - "#clock-cells"
> > +  - "#reset-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    cru: clock-controller@ff4a0000 {
> 
> nit: the cru label is not used and can be dropped.
> 
> Cheers,
> Conor.

All comments will be adapted in next revision. Thanks.

Best regards,
Yao Zi

