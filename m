Return-Path: <linux-kernel+bounces-567494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF2DA686D7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 233723ACC14
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F462512E8;
	Wed, 19 Mar 2025 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hb99jytf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195932116F4;
	Wed, 19 Mar 2025 08:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742373099; cv=none; b=jhthVJOTwDyIdrYRdbG2pJfV8lHRrJ0VWuYK+hjfm7poVgJt0DHKzv3SyLd6WI1z+h3uts7/c7N1JEswQD/w+mwPYiP1cybzERwUT6pL0WcPggDaMVXhHvamLTqhFB6JjbJconeQS4uPr4+KYXHdxRxJQ2+li3crzzVdkwVmt5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742373099; c=relaxed/simple;
	bh=aVPdxdnrKkfTw922ZCVfACXM/nXhIdDwBNRV6ecWg+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcyEa6QsAmUKnGodUA7+uc8fLjSrLyPehRN6GxM13l67W/C+RKe/Pc6eEkvoiEQ5VmJE0Mxra1jNy2oG8doYrkc7rC/1K2osf7BK4HuFTdIhl2CT58QgKheyMMtdZQ29y+JuMWIczrr1Ejkh2S5SQDTcfQ9IkbEbXmpm4a8Ubtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hb99jytf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0838AC4CEE9;
	Wed, 19 Mar 2025 08:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742373098;
	bh=aVPdxdnrKkfTw922ZCVfACXM/nXhIdDwBNRV6ecWg+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hb99jytf9vGVahGnJVnE4WW8B1NpKg8JgxpCnBqvF2z+z1evdvc1JH2wpIdZb/nKO
	 2qcTicUtKTCRkLGGIozc7OvFqJS+vtu8hQnFv13ZWAGW41eEVcUIEvVc2nQm7glaph
	 H9UbGSlpcv6aIOAw6p/Z6igCfZ5ocY5X5/ubDCS6PANySfsy7oc3TFWdowRXjMlXWE
	 6XhEFJC9HcnuOgLjZk3gsXIWSE2rWc1zTg+e/GoQe3KNjzjtkkcvnpp2f2rTohb3mO
	 c4o6HTh3IL+zGDLn4IWWlVnmWAF+HOheQx3E7ud+Is9v892joDk1BITLCJoZpFfSi6
	 uh250zswv821g==
Date: Wed, 19 Mar 2025 09:31:35 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: florin.leotescu@oss.nxp.com
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Michael Shych <michaelsh@nvidia.com>, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	viorel.suman@nxp.com, carlos.song@nxp.com, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, festevam@gmail.com, Florin Leotescu <florin.leotescu@nxp.com>, 
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: hwmon: Add Microchip emc2305 support
Message-ID: <20250319-optimistic-positive-peacock-cc26b1@krzk-bin>
References: <20250318085444.3459380-1-florin.leotescu@oss.nxp.com>
 <20250318085444.3459380-2-florin.leotescu@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318085444.3459380-2-florin.leotescu@oss.nxp.com>

On Tue, Mar 18, 2025 at 10:54:42AM +0200, florin.leotescu@oss.nxp.com wrote:
> From: Florin Leotescu <florin.leotescu@nxp.com>
> 
> Introduce yaml schema for Microchip emc2305 pwm fan controller.
> 
> Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/hwmon/microchip,emc2305.yaml     | 113 ++++++++++++++++++
>  1 file changed, 113 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml b/Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml
> new file mode 100644
> index 000000000000..e61ef97e63af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml
> @@ -0,0 +1,113 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +

No blank line here. Use existing code as template. If you find such
code, share so we can fix it.

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
> +

Just one blank line

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


