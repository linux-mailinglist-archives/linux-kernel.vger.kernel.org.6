Return-Path: <linux-kernel+bounces-281357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6B594D5E9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1534E281ECD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C79015A84D;
	Fri,  9 Aug 2024 17:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRvROvl2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EB113A260;
	Fri,  9 Aug 2024 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723226303; cv=none; b=OvG/YwIaOLt7GvwN94CqS4N5bfch5+KZEEJq3T3XrsY44RwddpBtIoHUvY2cMPKQh4ctzO6ctziVybV5nhPGRMZNQ7Uy0gXICuMJWW3xUHZHQsc24ow0nEe/mlXwds9WDFbdAb7BnhpyounJlY8A5LACgPtxpYIG6Wd0g4PoO2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723226303; c=relaxed/simple;
	bh=DxL8HNz0O+ryzWyfsA6C9wCd/wXfyjYBBqmvUecssDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMCKVIwm/lmICJ5bcI1QAzS/WPmMz8ae7mi5wyrJWUwyvrHa2wsF3KelhxKfr/+PAOi449zVkV1anmQ1UEmZ6UMZK0KFvtHhWmSWBhhtHVowgCmbI+meOR7ydFzyHImUMec5cr+hqI12iy104S35XLR/pCL5HeH/9hB5a6/PDNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRvROvl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3FAC32782;
	Fri,  9 Aug 2024 17:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723226302;
	bh=DxL8HNz0O+ryzWyfsA6C9wCd/wXfyjYBBqmvUecssDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QRvROvl2bllmqnyALF6Jeo8hS9QwzJFnJd6kZz4GU0FurSczGU5xIZm6FMJDPZLjS
	 jiDwv1zLwa1MWipXGKWM5Yf57/ESflyM+1sssCbbwL/fAzXZ/pOL66nZ6kirhhZiu4
	 IsG/xYPFERP6tgPzKtNTgB1WjUUZwesYU1JzKeyg2kOkwJwNYjcMVP4pZQHtc85gjl
	 VTRPe6rFRIj9r6WhhjYce9S3d/i4ArNh7cY+Uq7boC1RPmrBWbCHn+V0H/fP54rcbk
	 N/JZG5IENLbDqZyMFJEigryEHnkFGslZGg4ihPF2sDjnSEr41pFSXCmro01IOaz4+e
	 BnOiONSsXjfDg==
Date: Fri, 9 Aug 2024 11:58:21 -0600
From: Rob Herring <robh@kernel.org>
To: Yannick Fertre <yannick.fertre@foss.st.com>
Cc: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
	Philippe Cornu <philippe.cornu@foss.st.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: display: st,stm32-ltdc: Document
 stm32mp25 compatible
Message-ID: <20240809175821.GA927825-robh@kernel.org>
References: <20240809151314.221746-1-yannick.fertre@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809151314.221746-1-yannick.fertre@foss.st.com>

On Fri, Aug 09, 2024 at 05:13:14PM +0200, Yannick Fertre wrote:
> Add "st,stm32mp25-ltdc" compatible for SOC MP25. This new SOC introduce
> new clocks (bus, ref & lvds). Bus clock was separated from lcd clock.
> New sources are possible for lcd clock (lvds / ref).
> 
> Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
> ---
> Changes in v2: Rework clock property.
>  .../bindings/display/st,stm32-ltdc.yaml       | 51 +++++++++++++++----
>  1 file changed, 41 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml b/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
> index d6ea4d62a2cf..cc578ad9f040 100644
> --- a/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
> +++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
> @@ -12,7 +12,9 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: st,stm32-ltdc
> +    enum:
> +      - st,stm32-ltdc
> +      - st,stm32mp25-ltdc
>  
>    reg:
>      maxItems: 1
> @@ -23,13 +25,6 @@ properties:
>        - description: errors interrupt line.
>      minItems: 1
>  
> -  clocks:
> -    maxItems: 1
> -
> -  clock-names:
> -    items:
> -      - const: lcd

No, keep these at the top-level. Add to the list and add 'minItems: 1'. 
Then in the if/then schema, just use minItems/maxItems to limit the 
number of entries.

> -
>    resets:
>      maxItems: 1
>  
> @@ -46,11 +41,47 @@ required:
>    - compatible
>    - reg
>    - interrupts
> -  - clocks
> -  - clock-names
>    - resets
>    - port
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - st,stm32mp25-ltdc
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 4
> +          items:
> +            - description: Lcd Clock
> +            - description: Bus Clock
> +            - description: Reference Clock
> +            - description: Lvds Clock
> +        clock-names:
> +          items:
> +            - const: lcd
> +            - const: bus
> +            - const: ref
> +            - const: lvds
> +      required:
> +        - clocks
> +        - clock-names
> +    else:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +          items:
> +            - description: Lcd Clock
> +        clock-names:
> +          items:
> +            - const: lcd
> +      required:
> +        - clocks
> +        - clock-names
> +
>  additionalProperties: false
>  
>  examples:
> -- 
> 2.34.1
> 

