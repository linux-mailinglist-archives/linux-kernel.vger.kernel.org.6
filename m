Return-Path: <linux-kernel+bounces-271905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAE69454C6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 01:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14D79B22F08
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 23:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DE814E2E8;
	Thu,  1 Aug 2024 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g1LJb/p0"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89C114D45E;
	Thu,  1 Aug 2024 23:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722553662; cv=none; b=STDfHKQETEp+e30JMb5zJSgkzxjfSc1QLsC3aQofSY5cH996fyTY5aoqVKxUVwx5xhwe5EpyXHMpnnzTaVc7OKkDaCh5VO2COPb/t8BzIFfDHbop5E6Z8GPj8YsYnDBLJnaBi2JMqLm6TkeSINKVXktP4fjkT10Y501U/1FNR7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722553662; c=relaxed/simple;
	bh=tWVcs94ZZ3i843a/CC6NxTkMJYubXim8vPyJ0ylRe4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kx4HgwrwVrL7DF7LR8SKSnPGHAL8v3ikmKzib6jrsxouScR+/+uARkmKvDKuiScv8o+WiiuObvIK0xqL7nOeNlpE8KviWDOKmwnuCMxB54rdZAonVelKKDIHUHcaDKOodG+0A3QVnk/Ur7hk92+mP46zoPauPYtzvNF6dVxg1Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g1LJb/p0; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 46BCCC0003;
	Thu,  1 Aug 2024 23:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722553651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4awUVwG37LseNs27BJI5me6lqTMbdYGn9CDQNcfZPk8=;
	b=g1LJb/p0yD6SgP3eDyE9mw2oVj7wCol0tEc3HqCjkEU5R/2QPtKYabNUgLEgC8E91cg4Ev
	mPc2Obd0gKBUh7cgU7ooiysO+KFpyGCIdIekXOvTKrfFsPFjG9014nexl8rz80AXe/mkOF
	3QgRb5Lrpfm67nXj4pR0Nx4mHApPU/MNUj8pCaxuGdOHxRSJ97vLdBbMPwyeDHEBnOeL5d
	DlScwlT7k2caemmpGghwyMmPTO2i/RWypSR44V4299LptiPKX5mfTt0aBrmxe9s39XwXCE
	tMplR5Eriatc+oUuTrsswrhQPhPj3nu+rRxIEfs17URyNtlwbZg5jD/YCp/BNw==
Date: Fri, 2 Aug 2024 01:06:31 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Stanley Chu <stanley.chuys@gmail.com>, robh@kernel.org,
	krzk+dt@kernel.org, linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org, tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com, yschu@nuvoton.com, cpchiang1@nuvoton.com
Subject: Re: [PATCH v1 1/2] dt-bindings: i3c: Add NPCM845 i3c controller
Message-ID: <202408012306316257ee23@mail.local>
References: <20240801071946.43266-1-yschu@nuvoton.com>
 <20240801071946.43266-2-yschu@nuvoton.com>
 <c3ee7783-6891-4917-9935-21d46d8ac9a7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3ee7783-6891-4917-9935-21d46d8ac9a7@kernel.org>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 01/08/2024 16:53:52+0200, Krzysztof Kozlowski wrote:
> On 01/08/2024 09:19, Stanley Chu wrote:
> > The npcm845 i3c devicetree binding follows the basic i3c bindings
> > and add the properties for allowing to adjust the SDA/SCL timing
> > to meet different requirements.
> > 
> > Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> > Signed-off-by: James Chiang <cpchiang1@nuvoton.com>
> > ---
> >  .../bindings/i3c/nuvoton,i3c-master.yaml      | 123 ++++++++++++++++++
> 
> Use compatible as filename. Anyway word "master" was dropped.
> 
> >  1 file changed, 123 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/i3c/nuvoton,i3c-master.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/i3c/nuvoton,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/nuvoton,i3c-master.yaml
> > new file mode 100644
> > index 000000000000..a40b37b16872
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/i3c/nuvoton,i3c-master.yaml
> > @@ -0,0 +1,123 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/i3c/nuvoton,i3c-master.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Nuvoton NPCM845 I3C master
> 
> Use new terminology. Since 2021 there was a change... three years ago.
> 
> > +
> > +maintainers:
> > +  - Stanley Chu <yschu@nuvoton.com>
> > +  - James Chiang <cpchiang1@nuvoton.com>
> > +
> > +allOf:
> > +  - $ref: i3c.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: nuvoton,npcm845-i3c
> > +
> > +  reg:
> > +    items:
> > +      - description: I3C registers
> > +      - description: GDMA registers
> > +      - description: GDMA request control register
> > +
> > +  reg-names:
> > +    items:
> > +      - const: i3c
> > +      - const: dma
> > +      - const: dma_ctl
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: system clock
> > +      - description: bus clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: pclk
> > +      - const: fast_clk
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  i3c-pp-scl-hi-period-ns:
> > +    description: |
> 
> Do not need '|' unless you need to preserve formatting.
> 
> > +      If need to configure SCL with required duty cycle, specify the clock high/low period directly.
> > +      i3c-pp-scl-hi-perios-ns specifies the high period ns of the SCL clock cycle in push pull mode
> > +      When i3c-pp-scl-hi-period-ns and i3c-pp-scl-lo-period-ns are specified, the i3c pp frequency is
> > +      decided by these two properties.
> 
> Wrap according to Linux Coding Style (and read coding style to figure
> the proper wrapping...).
> 
> > +
> > +  i3c-pp-scl-lo-period-ns:
> > +    description: |
> > +      The low period ns of the SCL clock cycle in push pull mode. i3c-pp-scl-lo-period-ns should not
> > +      be less than i3c-pp-scl-hi-period-ns and the maximal value is i3c-pp-scl-hi-period-ns + 150.
> 
> Everywhere: defaults, constraints.
> 
> > +
> > +  i3c-pp-sda-rd-skew:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      The number of MCLK clock periods to delay the SDA transition from the SCL clock edge at push
> > +      pull operation when transfers i3c private read.
> > +    maximum: 7
> > +    default: 0
> > +
> > +  i3c-pp-sda-wr-skew:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      The number of MCLK clock periods to delay the SDA transition from the SCL clock edge at push
> > +      pull operation when transfers i3c private write.
> > +    maximum: 7
> > +    default: 0
> > +
> > +  i3c-od-scl-hi-period-ns:
> > +    description: |
> > +      The i3c open drain frequency is 1MHz by default.
> > +      If need to use different frequency, specify the clock high/low period directly.
> > +      i3c-od-scl-hi-perios-ns specifies the high period ns of the SCL clock cycle in open drain mode.
> > +      When i3c-od-scl-hi-period-ns and i3c-od-scl-lo-period-ns are specified, the i3c od frequency is
> > +      decided by these two properties.
> > +      i3c-od-scl-hi-period-ns should be equal to i3c-pp-scl-hi-period-ns or i3c-od-scl-lo-period-ns.
> > +
> > +  i3c-od-scl-lo-period-ns:
> > +    description: |
> > +      The low period ns of the SCL clock cycle in open drain mode. i3c-od-scl-lo-period-ns should be
> > +      multiple of i3c-pp-scl-hi-period-ns.
> > +
> > +  enable-hj:
> > +    type: boolean
> > +    description: |
> > +      Enable SLVSTART interrupt for receiving hot-join request.
> 
> You described the desired Linux feature or behavior, not the actual
> hardware. The bindings are about the latter, so instead you need to
> rephrase the property and its description to match actual hardware
> capabilities/features/configuration etc.
> 

This has to be runtime configurable, see hotjoin in
https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-bus-i3c


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

