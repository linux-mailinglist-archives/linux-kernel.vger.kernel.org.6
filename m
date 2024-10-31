Return-Path: <linux-kernel+bounces-391315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C26E9B8511
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9726FB246AB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110E41CDFC5;
	Thu, 31 Oct 2024 21:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bXyOxBTL"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790DA1CEEB0;
	Thu, 31 Oct 2024 21:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730409277; cv=none; b=sfbuatzRwSWHpTZ8YXEj/WeQG+FPLYmpF85Y/i4N5Fug38FhWCneJdtYEiltun1ZSVJ1JnZCRwqsES1WasY0pKzkYsh7C5sgpkBj7YTUokUeJ4dMonFi6F2gAe1Pcs5pyYfmHBInKgH1NyzkYmMsxuELwfQyqa7hQDu4Gs27Q2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730409277; c=relaxed/simple;
	bh=DTR4VLpPm15RWrWvWhTTUfDMUmkP5i7IJuNL+zw/5uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhC1W+rBtpT0F+pk7F+SuxSoQhhH4LTa5hiw4vP8KcGPLfnC5qsmiqBFn+YhqFJBoK9aOiR7xCjC0BZQ9+/PYMtI7eeYeKTpNg6MrIBBnj6kOyJAiMaMWgXmaM7BF5AOnSB3AWLfWyB38pvc2UMEkmIVAAjLlS2pQlURIahsQYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=bXyOxBTL; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 33A78581;
	Thu, 31 Oct 2024 22:14:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1730409264;
	bh=DTR4VLpPm15RWrWvWhTTUfDMUmkP5i7IJuNL+zw/5uY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bXyOxBTL+H/6OJls2paSZCrx0iJDI/i+HuYKNmbd4SppA3nUKGgw4Hb776VapIiG4
	 ilX9+UOM42EfnoEqw/6AUkUCh/QPHGkeCTdi72YRhVi4MGtLjzaKy7ncmhRv4DNS5b
	 m5kQ0KAv6F0U+32pGWlGfbsQCKuD5E348ksal5so=
Date: Thu, 31 Oct 2024 23:14:21 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Frank Li <Frank.li@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guido =?utf-8?Q?G=C3=BAnther?= <agx@sigxcpu.org>,
	Robert Chiras <robert.chiras@nxp.com>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: display: nwl-dsi: Allow 'data-lanes'
 property for port@1
Message-ID: <20241031211421.GG2473@pendragon.ideasonboard.com>
References: <20241031194714.2398527-1-Frank.Li@nxp.com>
 <gz3ifraqt7ga4isxhx6negcmfngen5jmhmcecnvy7gu7mpfffw@j65umo6arwc7>
 <ZyPmeippTU8SQLkH@lizhi-Precision-Tower-5810>
 <jfvvw7rnkxp4xbcmcikyxyfmisx3bmng6uqc7yqsvkzhc3hhgq@arfzqn6raxcg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jfvvw7rnkxp4xbcmcikyxyfmisx3bmng6uqc7yqsvkzhc3hhgq@arfzqn6raxcg>

On Thu, Oct 31, 2024 at 10:55:30PM +0200, Dmitry Baryshkov wrote:
> On Thu, Oct 31, 2024 at 04:20:10PM -0400, Frank Li wrote:
> > On Thu, Oct 31, 2024 at 09:59:26PM +0200, Dmitry Baryshkov wrote:
> > > On Thu, Oct 31, 2024 at 03:47:14PM -0400, Frank Li wrote:
> > > > Change $ref of port@1 from 'port' to 'port-base' and add 'endpoint'
> > > > property referencing video-interfaces.yaml. Allow 'data-lanes' values
> > > > 1, 2, 3, and 4 for port@1.
> > > >
> > > > Fix below CHECK_DTB warnings:
> > > > arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx-lvds-tm070jvhg33.dtb:
> > > >  dsi@30a00000: ports:port@1:endpoint: Unevaluated properties are not allowed ('data-lanes' was unexpected)
> > > >
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >  .../bindings/display/bridge/nwl-dsi.yaml       | 18 +++++++++++++++++-
> > > >  1 file changed, 17 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> > > > index 350fb8f400f02..5952e6448ed47 100644
> > > > --- a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> > > > +++ b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> > > > @@ -111,11 +111,27 @@ properties:
> > > >          unevaluatedProperties: false
> > > >
> > > >        port@1:
> > > > -        $ref: /schemas/graph.yaml#/properties/port
> > > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > > > +        unevaluatedProperties: false
> > > >          description:
> > > >            DSI output port node to the panel or the next bridge
> > > >            in the chain
> > > >
> > > > +        properties:
> > > > +          endpoint:
> > > > +            $ref: /schemas/media/video-interfaces.yaml#
> > > > +            unevaluatedProperties: false
> > > > +
> > > > +            properties:
> > > > +              data-lanes:
> > > > +                description: array of physical DSI data lane indexes.
> > > > +                minItems: 1
> > > > +                items:
> > > > +                  - const: 1
> > > > +                  - const: 2
> > > > +                  - const: 3
> > > > +                  - const: 4
> > >
> > > Why are they indexed starting from 1?
> > 
> > Not sure, git grep -r data-lanes Documentation/devicetree/bindings/
> > Most start from 1. Not sure latest DT team's intention.
> 
> They usually start from 1, because just before the property comes
> 'clock-lanes = <0>'. Otherwise in most of the cases the lanes are
> indexed from 0.

I'm not sure what the rule is for DSI, but for CSI we number data lanes
starting at 1 regardless of whether or not the clock lane is
configurable. Consistency help for driver implementations.

> > > > +
> > > >      required:
> > > >        - port@0
> > > >        - port@1

-- 
Regards,

Laurent Pinchart

