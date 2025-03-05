Return-Path: <linux-kernel+bounces-547331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127F1A505F5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30683A7A93
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873881A316B;
	Wed,  5 Mar 2025 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRcZL88m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62891957FC;
	Wed,  5 Mar 2025 17:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741194446; cv=none; b=DrTSImQnWIgjaxazvX6RQ3ZM5s+UUzRD3x2j3PIa8hWYMMV0ybs7wo/bsTmtncZkCg1GSHcbS/LjphjQoF3PrLxpk28J5WCtLEtn33OQ7OdG6viDcedm0RuLxMDtKh7RtSJo1YQx5BaRSs5S/6wejanToRREaqantLBollPFDDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741194446; c=relaxed/simple;
	bh=bLNqQdLWuR0xn/KW0CPq8vI0e4EX5wAgnKJpoztWMHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwL9l5pJzEYENKAIv453bVKrwanDPdBFGQqRCtFxLnqV/Mnf58UjOZ3ESULBKze2Egmnb0qJik7iO2A8FhGKWCBgORXcig4gv+v5rNS87Cx8+LjNisTEu+4IE4e+6ZN6dIjtFKax93HlSEWJju3J07hNr+5BxQIAwArlvM8kL1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRcZL88m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23704C4CED1;
	Wed,  5 Mar 2025 17:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741194445;
	bh=bLNqQdLWuR0xn/KW0CPq8vI0e4EX5wAgnKJpoztWMHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eRcZL88mboMBgd/Z6RV1twdyEVm5uiwvcj4bZ5HeqWq3rGDvMJj272ouZcy8jt696
	 Gt6I0vBWZSsLLK9oLqRWGhS8PmCY9yy3lTLffYrpI1tGcVn++96k/4Zg61hguEDlpn
	 TNiFw5QnMMsVfifjFKcedAr2rZJyOoTzWKcwMLoUTDNywAMJf1JNfO3Ao9lYy7TPVu
	 BmrhSupwkTUtu51i7rYMxSqU2WGejx1ENCuAH8+40TAv2W1lBBjF+G/R06Q+Bn2lv9
	 0LqmyGGqNMOz0WmjEsZwBaNxN3SMt+t7HJcWwxYxV2dfJY+PjLFOX3ML5q8jS196f7
	 9WkRotH9uWkgQ==
Date: Wed, 5 Mar 2025 11:07:23 -0600
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: xianwei.zhao@amlogic.com, Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v3 1/4] dt-bindings: interrupt-controller: Add support
 for Amlogic A4 and A5 SoCsy
Message-ID: <20250305170723.GA2143418-robh@kernel.org>
References: <20250305-irqchip-gpio-a4-a5-v3-0-1eec70352fea@amlogic.com>
 <20250305-irqchip-gpio-a4-a5-v3-1-1eec70352fea@amlogic.com>
 <20250305-corral-unfair-a7f25abbfd64@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305-corral-unfair-a7f25abbfd64@spud>

On Wed, Mar 05, 2025 at 04:28:16PM +0000, Conor Dooley wrote:
> On Wed, Mar 05, 2025 at 06:02:56PM +0800, Xianwei Zhao via B4 Relay wrote:
> > From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> > 
> > Update dt-binding document for GPIO interrupt controller
> > of Amlogic A4 and A5 SoCs
> > 
> > Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> > ---
> >  .../amlogic,meson-gpio-intc.yaml                    | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
> > index a93744763787..3c5853c71efa 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
> > @@ -35,6 +35,9 @@ properties:
> >                - amlogic,meson-sm1-gpio-intc
> >                - amlogic,meson-a1-gpio-intc
> >                - amlogic,meson-s4-gpio-intc
> > +              - amlogic,a4-gpio-intc
> > +              - amlogic,a4-gpio-ao-intc
> > +              - amlogic,a5-gpio-intc
> >                - amlogic,c3-gpio-intc
> >                - amlogic,t7-gpio-intc
> >            - const: amlogic,meson-gpio-intc
> > @@ -49,8 +52,6 @@ properties:
> >  
> >    amlogic,channel-interrupts:
> >      description: Array with the upstream hwirq numbers
> > -    minItems: 8
> > -    maxItems: 12
> 
> Please leave the widest constraints here, and let the more restricted
> ones in your if/else below.
> 
> >      $ref: /schemas/types.yaml#/definitions/uint32-array
> >  
> >  required:
> > @@ -60,6 +61,22 @@ required:
> >    - "#interrupt-cells"
> >    - amlogic,channel-interrupts
> >  
> > +if:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        const: amlogic,a4-gpio-ao-intc
> > +then:
> > +  properties:
> > +    amlogic,channel-interrupts:
> > +      minItems: 2
> > +      maxItems: 12

And then you don't need this clause as 2-12 is the full range.

> > +else:
> > +  properties:
> > +    amlogic,channel-interrupts:
> > +      minItems: 8
> > +      maxItems: 12

And 12 is already the max, so you only need 'minItems: 8'.

> > +
> >  additionalProperties: false
> >  
> >  examples:
> > 
> > -- 
> > 2.37.1
> > 
> > 



