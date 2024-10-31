Return-Path: <linux-kernel+bounces-391281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EE49B84B0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB0831C2096D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AD81CCB5E;
	Thu, 31 Oct 2024 20:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HdqSMMiQ"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42521B3B2E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730408141; cv=none; b=FpJtxeBJK5R2HYUWyXIjQqrzElipotD0aVxfLMVva88z6FMY2GdZTzW6LVHT3XkeZHkvrEKE6J3lFVvuhkJUZ1+aU381EnCbDj0a2w86l8js4o7X0u7JlqYGM1gNxaHz+ymVR851AEsOFVeWdhKQ/h/3l0o8hdvMkP96u5EL4II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730408141; c=relaxed/simple;
	bh=5QF1GfxDyoWq5h+USFwpYEnKgfZ8PnsYLlMZFcmmpNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDezSy3ogWVs5Vyg0axszYXlNWnjvsVPpTcaRJ+PlNN2wKBriG+caev2CeJoT9ma2uAoxbQ1Lk8onsdpvJg9arfsYbKPtZoyXaUaNOad2bmcP9NLpulMFpv6mZkrse1fNWeF7QTfXJBj/2jM/M5mN7hkUwyXgVIG30F9Rr56hTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HdqSMMiQ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e8607c2aso1521168e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 13:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730408133; x=1731012933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h164uvathdh9GwUZcWXqlrzCUWdwa05VF7nF2pa0Pnw=;
        b=HdqSMMiQS0KjL7IyJNWmdzRNlUnOSYeWVwuRZf85FZsLXk4FOcD62UW0lpdqNIw+8/
         mCarBGyn01PIlmdYQqa6+FFzl9ORXX70H+5b8HSrD8spM7ARe/sw5j1GOS8cyJ92OL34
         BfiUxPPry+Qc4fYPjTU2JDb6ewzQqCbMEWFKzJX7gnqE1gTtxNi2BhBBTAL40rDZT6IU
         qUYYAnmUroOU7FXI45kEVKkhBksI89zw5B3swMJvw5XazqHctqyCu3zK+wLMG31F5BZX
         QngREXtv943TH/olNjB1Y9xRvcZv22tK0IqG7qSHiQgwpQ8xnfYKIEgHG/sna76AxeEw
         sUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730408133; x=1731012933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h164uvathdh9GwUZcWXqlrzCUWdwa05VF7nF2pa0Pnw=;
        b=tKU5GK4Q1FxAibQG2RnZO2mPq4VeYKEcm+zp1uxIKSKuxVlonlPYDfidtx1LIqcyOE
         CraoL+Zs8InSFuN5/X6HQbc8tPElE2plHpl6zovpbRGTsss6RIZGpCOx4pF+H1FtrQZn
         QC1UxDw8nOeSgcqdYoUO7xelTpgWIhAI6NLWoEzMj3vL8X4/lmY7HlMojfo2L3P94RbJ
         mCMjPafYcCQW0zdmYmmr7UJCJ3VrR52Wg46JVlIoPguS0zJVryxqkOWXtffpDjFlHJ6R
         om9QyTIubU4iCL2XRxa9IQwsTOJ5Xr+tI2tlygoaYlklMEnGRP0Q/frSvBz3tjWiElnn
         LCJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYLofKxd8L/BpYoGNlxldp/k3Ke0abctAIIgtYDNuTz5dYwe0SmWiUPklAvrUxuvX3+hgNd61dC1XemLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBu0A8h+Ot5ENZIBme82fEeB+U/AO3HTKOoCC8Ep9TO5PZl1mG
	C0CxnmEvSstFYd4pO2jDgHZRclqSZlrb6GKFiGllrsrhurXftfen9gJl8hkIUZs=
X-Google-Smtp-Source: AGHT+IGJ+tWCwIEDayGEBAeK10meBPh3PGgEPOw1Qyld1seRLcMErL1vcpY7qkKPYdHBp7JrKlK46Q==
X-Received: by 2002:a05:6512:32c7:b0:539:a353:279c with SMTP id 2adb3069b0e04-53b348d8f6cmr11419018e87.28.1730408133014;
        Thu, 31 Oct 2024 13:55:33 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bdcbcf6sm320927e87.194.2024.10.31.13.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 13:55:31 -0700 (PDT)
Date: Thu, 31 Oct 2024 22:55:30 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Guido =?utf-8?Q?G=C3=BAnther?= <agx@sigxcpu.org>, 
	Robert Chiras <robert.chiras@nxp.com>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: display: nwl-dsi: Allow 'data-lanes'
 property for port@1
Message-ID: <jfvvw7rnkxp4xbcmcikyxyfmisx3bmng6uqc7yqsvkzhc3hhgq@arfzqn6raxcg>
References: <20241031194714.2398527-1-Frank.Li@nxp.com>
 <gz3ifraqt7ga4isxhx6negcmfngen5jmhmcecnvy7gu7mpfffw@j65umo6arwc7>
 <ZyPmeippTU8SQLkH@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyPmeippTU8SQLkH@lizhi-Precision-Tower-5810>

On Thu, Oct 31, 2024 at 04:20:10PM -0400, Frank Li wrote:
> On Thu, Oct 31, 2024 at 09:59:26PM +0200, Dmitry Baryshkov wrote:
> > On Thu, Oct 31, 2024 at 03:47:14PM -0400, Frank Li wrote:
> > > Change $ref of port@1 from 'port' to 'port-base' and add 'endpoint'
> > > property referencing video-interfaces.yaml. Allow 'data-lanes' values
> > > 1, 2, 3, and 4 for port@1.
> > >
> > > Fix below CHECK_DTB warnings:
> > > arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx-lvds-tm070jvhg33.dtb:
> > >  dsi@30a00000: ports:port@1:endpoint: Unevaluated properties are not allowed ('data-lanes' was unexpected)
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  .../bindings/display/bridge/nwl-dsi.yaml       | 18 +++++++++++++++++-
> > >  1 file changed, 17 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> > > index 350fb8f400f02..5952e6448ed47 100644
> > > --- a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> > > +++ b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> > > @@ -111,11 +111,27 @@ properties:
> > >          unevaluatedProperties: false
> > >
> > >        port@1:
> > > -        $ref: /schemas/graph.yaml#/properties/port
> > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > > +        unevaluatedProperties: false
> > >          description:
> > >            DSI output port node to the panel or the next bridge
> > >            in the chain
> > >
> > > +        properties:
> > > +          endpoint:
> > > +            $ref: /schemas/media/video-interfaces.yaml#
> > > +            unevaluatedProperties: false
> > > +
> > > +            properties:
> > > +              data-lanes:
> > > +                description: array of physical DSI data lane indexes.
> > > +                minItems: 1
> > > +                items:
> > > +                  - const: 1
> > > +                  - const: 2
> > > +                  - const: 3
> > > +                  - const: 4
> >
> > Why are they indexed starting from 1?
> 
> Not sure, git grep -r data-lanes Documentation/devicetree/bindings/
> Most start from 1. Not sure latest DT team's intention.

They usually start from 1, because just before the property comes
'clock-lanes = <0>'. Otherwise in most of the cases the lanes are
indexed from 0.

> 
> Frank
> 
> >
> > > +
> > >      required:
> > >        - port@0
> > >        - port@1
> > > --
> > > 2.34.1
> > >
> >
> > --
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry

