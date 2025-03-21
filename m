Return-Path: <linux-kernel+bounces-572001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A1BA6C546
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0EB189FBC2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2B8231A51;
	Fri, 21 Mar 2025 21:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNUtJeZu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280A12A1C9;
	Fri, 21 Mar 2025 21:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742592924; cv=none; b=V1o56pc8xYdNnhhBtoObQcPjCSgjaIoi4M6yFy6z+U0U0j+NlIT2sF8e3aLbKXlo5jR8JYWjTG1+sKvZiSM2qzxIavMbsGpBNtDi3mzvwfX1SeiMKtgMkHC5etmjFPyRcSKsuKbbQMLFV3wxh4JZedbiz+2SCTWsFt6Anu2WYDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742592924; c=relaxed/simple;
	bh=99MMakXTIkezKY2wg7hUxSRWmsbUh/X4l9UQUYmUuS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtWxeek9TnlEYuE3Kws0j9hurXGmXdKZGedrxgGsoNKw9fQW2RpNsFYzbt+jeoHbyHeu0jzEjXM98lhigKa0oSr3mqKUbbgosl9+bW6HEQE81/O2unaXnPsWNN6UdhzmfzaRUZvMkVrezmu9Vw3o16Li39CcSwMaMk8FlBXk20I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNUtJeZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76820C4CEE3;
	Fri, 21 Mar 2025 21:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742592923;
	bh=99MMakXTIkezKY2wg7hUxSRWmsbUh/X4l9UQUYmUuS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kNUtJeZuriHtWQ9t2GLqbjr0xJOJG2+mrVK386fmuLXewV19OtcT8OtsctdN8owKu
	 hIRO7rcym5RA6gYhwegr0cF9s8z+ImYBbd04nApIb5ChUaWBBP1iB6L9GK0g0rxipy
	 flfS0wnWGHiYxt5nZwBcAVBmMzDaPhUirL2LHGa2l8gVvBzxgQYuY1fYA+GU//Ehuf
	 jNEWUNAbLKd7dDT9CjTDpoQfeBkuKEatBplFRqwvXAeOr9auS9TNsnNIPSQYs8HP5i
	 dJAUwERdELEyIZZpTa2h5PCGR5EbFTyfsAFZFEvlfOtqAM71FqbFD5GGGM3OjVjid5
	 sl73VySMGqbuw==
Date: Fri, 21 Mar 2025 16:35:22 -0500
From: Rob Herring <robh@kernel.org>
To: florin.leotescu@oss.nxp.com
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Shych <michaelsh@nvidia.com>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	viorel.suman@nxp.com, carlos.song@nxp.com,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	festevam@gmail.com, Florin Leotescu <florin.leotescu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 1/3] dt-bindings: hwmon: Add Microchip emc2305 support
Message-ID: <20250321213522.GA4149883-robh@kernel.org>
References: <20250321143308.4008623-1-florin.leotescu@oss.nxp.com>
 <20250321143308.4008623-2-florin.leotescu@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321143308.4008623-2-florin.leotescu@oss.nxp.com>

On Fri, Mar 21, 2025 at 04:33:06PM +0200, florin.leotescu@oss.nxp.com wrote:
> From: Florin Leotescu <florin.leotescu@nxp.com>
> 
> Introduce yaml schema for Microchip emc2305 pwm fan controller.
> 
> Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/hwmon/microchip,emc2305.yaml     | 110 ++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml b/Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml
> new file mode 100644
> index 000000000000..79081c116274
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml
> @@ -0,0 +1,110 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/microchip,emc2305.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip EMC2305 SMBus compliant PWM fan controller
> +
> +maintainers:
> +  - Michael Shych <michaelsh@nvidia.com>
> +
> +description:
> +  Microchip EMC2301/2/3/5 pwm controller which supports
> +  up to five programmable fan control circuits.

Fix wrapping to wrap at 80.

> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - microchip,emc2305
> +      - items:
> +          - enum:
> +              - microchip,emc2303
> +              - microchip,emc2302
> +              - microchip,emc2301
> +          - const: microchip,emc2305
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  '#pwm-cells':
> +    const: 3
> +    description: |
> +      Number of cells in a PWM specifier.
> +      - cell 0: The PWM frequency
> +      - cell 1: The PWM polarity: 0 or PWM_POLARITY_INVERTED
> +      - cell 2: The PWM output config:
> +           - 0 (Open-Drain)
> +           - 1 (Push-Pull)
> +
> +patternProperties:
> +  '^fan@[0-4]$':
> +    $ref: fan-common.yaml#
> +    unevaluatedProperties: false
> +    properties:
> +      reg:
> +        description:
> +          The fan number used to determine the associated PWM channel.

           maxItems: 1

With that,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

