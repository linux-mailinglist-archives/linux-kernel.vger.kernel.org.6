Return-Path: <linux-kernel+bounces-423113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D459DA308
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 304B8B25254
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 07:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E01714D433;
	Wed, 27 Nov 2024 07:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkPR3K+q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92F51114;
	Wed, 27 Nov 2024 07:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732692354; cv=none; b=KfC8MEamWC0hyt96ECPK2uWzCoHACGzQbpkr1sCviyRKcTeqIK7IPdDTass2PARQWHbkgr1eFtYSba7p2R3iAY7UO6vV8i1anqKbfcYlNkvJ2mZ1E9ktpEyu1XYNirDbfFzFJ1lwMQuq6ivc4o2hH/cNo0z+jfDlRypa1s8oa78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732692354; c=relaxed/simple;
	bh=pGn4kfUpOcmSqIS3vciAoVzfQoYoykNksqMjg/m4A7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZV1h1UPSFkzrrXo/TmHGMBYHuL4bvkEvKDwZOIFOIFl2QRvlrh1ajIDkPF/MKxRuIOb3cKBHIO2xqh7BXqU4ePdtf0df0fYs5BfNwGL0aBCgD7arKCBjS7/9hsNY5etPHMAdoQ+XIKZk4t5L+cVVayj4YL+mh1mfuIiOXQAA1g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkPR3K+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908BFC4CECC;
	Wed, 27 Nov 2024 07:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732692354;
	bh=pGn4kfUpOcmSqIS3vciAoVzfQoYoykNksqMjg/m4A7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dkPR3K+q9/8URcH8C1V9tbKnvOkEYNvce4wjGS+JjcSOtIg5zBrEcLGV/FjQpBoiI
	 ipMIk0Tc4GMhmo6IlkpOsvurupAzoNNZHQEq+E7eCOQfXaC6JFVUstjXQkXMK4tukD
	 sGMvEigQ0Ibn2NNbdGs+L3Q2e2/rJci+OmZXZjvLUYPBOE+I1Bp+4RXrhd1yBtCPdr
	 YSXXYfuzl8PblXfiBkBASVJgPZHNHeJItzyM6T4Vxv+/ePAzlaPIhmJtK4GgqD/vqW
	 edPmHNHnOp1pAjmOYklohnnAMTkXUVLMa+XSIFzxtaSpP4RBlyV0DUOTJkx65xXVwN
	 Skzfg2Zxdd5Zg==
Date: Wed, 27 Nov 2024 08:25:50 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sandor Yu <Sandor.yu@nxp.com>
Cc: dmitry.baryshkov@linaro.org, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
	jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, 
	vkoul@kernel.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	mripard@kernel.org, kernel@pengutronix.de, linux-imx@nxp.com, oliver.brown@nxp.com, 
	alexander.stein@ew.tq-group.com, sam@ravnborg.org
Subject: Re: [PATCH v19 3/8] dt-bindings: display: bridge: Add Cadence
 MHDP8501
Message-ID: <b6m4c5qbjbwdwuycunhoe6hj3akmqb257havourydry4wlrmkn@hmzkyodyqz4n>
References: <cover.1732627815.git.Sandor.yu@nxp.com>
 <e495a40a0add052d4f8cdeb4a81ea7408cdccaf6.1732627815.git.Sandor.yu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e495a40a0add052d4f8cdeb4a81ea7408cdccaf6.1732627815.git.Sandor.yu@nxp.com>

On Tue, Nov 26, 2024 at 10:11:48PM +0800, Sandor Yu wrote:
> Add bindings for Cadence MHDP8501 DisplayPort/HDMI bridge.
> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> ---
> v18->v19:
> - move data-lanes property to endpoint of port@1
> 
> v17->v18:
> - remove lane-mapping and replace it with data-lanes
> - remove r-b tag as property changed.
> 
> v16->v17:
> - Add lane-mapping property
> 
> v9->v16:
>  *No change
> 
>  .../display/bridge/cdns,mhdp8501.yaml         | 120 ++++++++++++++++++
>  1 file changed, 120 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml
> new file mode 100644
> index 0000000000000..24abd8447a28c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml
> @@ -0,0 +1,120 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/cdns,mhdp8501.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence MHDP8501 DP/HDMI bridge
> +
> +maintainers:
> +  - Sandor Yu <Sandor.yu@nxp.com>
> +
> +description:
> +  Cadence MHDP8501 DisplayPort/HDMI interface.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx8mq-mhdp8501
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: MHDP8501 DP/HDMI APB clock.
> +
> +  phys:
> +    maxItems: 1
> +    description:
> +      phandle to the DP/HDMI PHY
> +
> +  interrupts:
> +    items:
> +      - description: Hotplug cable plugin.
> +      - description: Hotplug cable plugout.
> +
> +  interrupt-names:
> +    items:
> +      - const: plug_in
> +      - const: plug_out
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Input port from display controller output.
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description:
> +          Output port to DisplayPort or HDMI connector.
> +
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              data-lanes:
> +                $ref: /schemas/media/video-interfaces.yaml#/properties/data-lanes

Drop, not needed.

> +                minItems: 4
> +                maxItems: 4
> +                description: Lane reordering for HDMI or DisplayPort interface.

Blank line

> +            required:
> +              - data-lanes

Blank line

Best regards,
Krzysztof


