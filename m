Return-Path: <linux-kernel+bounces-395146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD2E9BB925
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6038B2831A9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EDA1C07C8;
	Mon,  4 Nov 2024 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNSBI6QC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A204C1BF81B;
	Mon,  4 Nov 2024 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730734862; cv=none; b=pIUvlkA5djpdKKRG7RB1rWnbobdqqqNsKoyl6455Qv6QAWBkLcbeGGLzEYVKLKiR2zx5DxdSuE64JscRbxJpXUzw6USKPRCFL8dbpu33RYPqCTq+p5EvqkIrE56p5UqbiCxCo0Iif+fz+LVcLRIzOwsFr8V3Xqj5T1a62NB0aZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730734862; c=relaxed/simple;
	bh=3d1pXGBz/YADEkiDdLoMWwcVJksBRigwDmvlvnVgbM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMyNLoXI8S1JXfgkLlnKlWBbCr/jW38sTzS9dISmvbHpL0ISndwfV6XWaB0Cih3H43jsYWz3V5T86XnsmtRZcDl425BVs/mQP6FRdzayxSqIaUSFzCn0aQ1qqSdcqOk+pm0h9MKqGzu7bx4CZr6BGGWxlUpC269TBJdEWdDjd44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNSBI6QC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E42C4CECE;
	Mon,  4 Nov 2024 15:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730734861;
	bh=3d1pXGBz/YADEkiDdLoMWwcVJksBRigwDmvlvnVgbM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dNSBI6QCWpughxQI/tuKAPexFYL8fgVC7ansduqnEAqN0hAfCHLSTeqFHfS4cUVF/
	 wJmmau02ES6KQ6ZGVNbmiQtbl7tYlF56gfT+EfX9E0Mxi08FfeOU8OnToI3PseHsgp
	 VRjp+VDexwro8QJ6809N/0J76S00daZ8Q9ScDSV04JzC70SM/O5E6WO8HppmcfzAAo
	 HK9yvTSJ5Ujgoq6+GzOR+fMhiFvqA8K7OyxQ1y6HRZEcoAYY2FP/P2vgUETyuEOZ+M
	 ubyIOqNGMCawOHLoMrjBkvrh9Z79ee75Ic2SLB/W9EvNH8wNexoC0kNBfJfriHYsCO
	 DQkIXszZAnuEg==
Date: Mon, 4 Nov 2024 09:40:59 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guido =?iso-8859-1?Q?G=FAnther?= <agx@sigxcpu.org>,
	Robert Chiras <robert.chiras@nxp.com>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: display: nwl-dsi: Allow 'data-lanes'
 property for port@1
Message-ID: <20241104154059.GA203243-robh@kernel.org>
References: <20241031194714.2398527-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031194714.2398527-1-Frank.Li@nxp.com>

On Thu, Oct 31, 2024 at 03:47:14PM -0400, Frank Li wrote:
> Change $ref of port@1 from 'port' to 'port-base' and add 'endpoint'
> property referencing video-interfaces.yaml. Allow 'data-lanes' values
> 1, 2, 3, and 4 for port@1.

Describe "why", not what the changes are. I can read the diff. Why is 
the IP has a configurable number of lanes...

> 
> Fix below CHECK_DTB warnings:
> arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx-lvds-tm070jvhg33.dtb:
>  dsi@30a00000: ports:port@1:endpoint: Unevaluated properties are not allowed ('data-lanes' was unexpected)
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/display/bridge/nwl-dsi.yaml       | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> index 350fb8f400f02..5952e6448ed47 100644
> --- a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> @@ -111,11 +111,27 @@ properties:
>          unevaluatedProperties: false
>  
>        port@1:
> -        $ref: /schemas/graph.yaml#/properties/port
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
>          description:
>            DSI output port node to the panel or the next bridge
>            in the chain
>  
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              data-lanes:
> +                description: array of physical DSI data lane indexes.
> +                minItems: 1
> +                items:
> +                  - const: 1
> +                  - const: 2
> +                  - const: 3
> +                  - const: 4
> +
>      required:
>        - port@0
>        - port@1
> -- 
> 2.34.1
> 

