Return-Path: <linux-kernel+bounces-184184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 687D18CA3AB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 23:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252B128173A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CAF139CFB;
	Mon, 20 May 2024 21:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COcLBCX1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C13A1D531;
	Mon, 20 May 2024 21:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716239251; cv=none; b=i2xPx0l1WmEaJ8P0oMpinlPdx6RMSbFZ3cTmUJUB7a5ajG4bDBaYJxasXuIV5Xz3cnOXnMVVAkE5gApVX5DhoYZ0T17l6sbmlSkxGU9CPzBbcUfhLrrywKsXNzkMJ7j15dRhZJPkslx0J7cZx5UELGAduRYxseh3bbIOHxjgMKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716239251; c=relaxed/simple;
	bh=X/NsTjluZhFUIdDleKVBp6yB9DdSZqAO99eq3Zz04l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gb6VCo0Uj48cz/fTkxVkLhhKua2EHZ6WtiRU0j+JQC6lJZwkOmaPBZAFeUiIteL48KcNYJDA73ecbJLfxFijDoqAT5dMVvWTKe8+zLy38QN9pwmD5ypq9jcrXjeWaUOa+yk8L5QA/rDe36RbhyEG7QDVE5InXcsseCzrFIqGTA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COcLBCX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44D8C2BD10;
	Mon, 20 May 2024 21:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716239251;
	bh=X/NsTjluZhFUIdDleKVBp6yB9DdSZqAO99eq3Zz04l8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=COcLBCX11lfP8lavHY9s/toyqvSg0NurL5PdVAePq5mib/NEy463Muej/HOax+eLx
	 y8tUmti4dWfu3xUUT+aiN0V10wxnYLZfqx9/Kzft/yecuvlfWMcGGJS7dDETp4Nnj8
	 oVse2C/FFlqR3oqzMmYrRH5KxPD0iQV2czPJvL620Ch4JyYAVSibMURUAhvbSqboem
	 Ci/mnOigC+B/TR0Xqkvbdt19uMeQ6aXidSreVnfpI5Mh6mgKokpZxSIwcqp9pzYgBH
	 cl3QgPwYIGSdITwSDB8ClhtRg2cjspJ3W6Rfg7htOz20Qct3H+qHF4S504N971qnHD
	 yhFPwYQzEcTGw==
Date: Mon, 20 May 2024 16:07:29 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com, Nishanth Menon <nm@ti.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 3/8] dt-bindings: soc: intel: lgm-syscon: Move to
 dedicated schema
Message-ID: <20240520210729.GA1509114-robh@kernel.org>
References: <20240519-dt-bindings-mfd-syscon-split-v1-0-aaf996e2313a@linaro.org>
 <20240519-dt-bindings-mfd-syscon-split-v1-3-aaf996e2313a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240519-dt-bindings-mfd-syscon-split-v1-3-aaf996e2313a@linaro.org>

On Sun, May 19, 2024 at 08:42:18PM +0200, Krzysztof Kozlowski wrote:
> intel,lgm-syscon is not a simple syscon device - it has children - thus
> it should be fully documented in its own binding.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Context might depend on
> https://lore.kernel.org/r/20240510123018.3902184-1-robh@kernel.org
> and also further patches here depend on this one.
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml  |  1 -
>  .../bindings/soc/intel/intel,lgm-syscon.yaml       | 53 ++++++++++++++++++++++
>  2 files changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 622ea0f1b08e..5a0aeae24a50 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -77,7 +77,6 @@ properties:
>                - hisilicon,pcie-sas-subctrl
>                - hisilicon,peri-subctrl
>                - hpe,gxp-sysreg
> -              - intel,lgm-syscon
>                - loongson,ls1b-syscon
>                - loongson,ls1c-syscon
>                - lsi,axxia-syscon
> diff --git a/Documentation/devicetree/bindings/soc/intel/intel,lgm-syscon.yaml b/Documentation/devicetree/bindings/soc/intel/intel,lgm-syscon.yaml
> new file mode 100644
> index 000000000000..aa8d24074fd7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/intel/intel,lgm-syscon.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/intel/intel,lgm-syscon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel Lightning Mountain(LGM) Syscon
> +
> +maintainers:
> +  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: intel,lgm-syscon
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1

Should have ranges.

> +
> +patternProperties:
> +  "^emmc-phy@[0-9a-f]+$":
> +    $ref: /schemas/phy/intel,lgm-emmc-phy.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    chiptop@e0200000 {
> +        compatible = "intel,lgm-syscon", "syscon";
> +        reg = <0xe0200000 0x100>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        emmc-phy@a8 {
> +            compatible = "intel,lgm-emmc-phy";
> +            reg = <0x00a8 0x10>;
> +            clocks = <&emmc>;
> +            #phy-cells = <0>;
> +        };
> +    };
> 
> -- 
> 2.43.0
> 

