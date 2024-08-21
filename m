Return-Path: <linux-kernel+bounces-295343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 616C39599E1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF991B2662C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD001D049F;
	Wed, 21 Aug 2024 10:32:38 +0000 (UTC)
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2AE1A4AC6;
	Wed, 21 Aug 2024 10:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724236358; cv=none; b=YLGmvHQr/O7svSLuLyx74gY2dxSmq29VYR77WvxCNGgwwPgiJ1JABPJwNR/tDgwpTibvbrIxOFCI5itUhiZOJE/mQOftdbQ4rSKrI5kXSB6QG7zT2kjuthF+TFtaWldqN6AzLVmsG4XbbTV/L4xjA2fft/i3HCvUXIYqcOY+Rmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724236358; c=relaxed/simple;
	bh=vVB65DUIC12pESNVfMS1trP8SGpZ7shpdtvG5rB2WAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=sVJTwl6FiXdovxOVcz8alB4YfcHCBYCymfnKXbR0CoCmFL0dqMqmBcSLJVjuLJmT9c7zcXAYeKT5KWF1q7YkFDCxCG8XRJeIinp9cNcJEhMvwm62fLk6VcTFpIk/wA+Qu1+l4hEMVWKo3MN5CPVy46yg+TwGZLxWfwD2iFkGQ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 21 Aug 2024 19:31:26 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 4D5F02009079;
	Wed, 21 Aug 2024 19:31:26 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Wed, 21 Aug 2024 19:31:26 +0900
Received: from [10.212.247.18] (unknown [10.212.247.18])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id 671B4AB187;
	Wed, 21 Aug 2024 19:31:25 +0900 (JST)
Message-ID: <fa07f751-06ae-44c0-8994-9634c5aa9824@socionext.com>
Date: Wed, 21 Aug 2024 19:31:24 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: phy: socionext,uniphier: add top-level
 constraints
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240818172835.121757-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20240818172835.121757-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

I have one comment.

On 2024/08/19 2:28, Krzysztof Kozlowski wrote:
> Properties with variable number of items per each device are expected to
> have widest constraints in top-level "properties:" block and further
> customized (narrowed) in "if:then:".  Add missing top-level constraints
> for clock-names and reset-names.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../bindings/phy/socionext,uniphier-ahci-phy.yaml         | 8 ++++++--
>   .../bindings/phy/socionext,uniphier-pcie-phy.yaml         | 8 ++++++--
>   .../bindings/phy/socionext,uniphier-usb3hs-phy.yaml       | 7 +++++--
>   .../bindings/phy/socionext,uniphier-usb3ss-phy.yaml       | 7 +++++--
>   4 files changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
> b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
> index de3cffc850bc..e34b875a1bb8 100644
> ---
> a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
> +++
> b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
> @@ -30,13 +30,17 @@ properties:
>       minItems: 1
>       maxItems: 2
>   
> -  clock-names: true
> +  clock-names:
> +    minItems: 1
> +    maxItems: 6

The maxItems of clocks is 2, so it should be 2.

>   
>     resets:
>       minItems: 2
>       maxItems: 6
>   
> -  reset-names: true
> +  reset-names:
> +    minItems: 2
> +    maxItems: 6
>   
>   allOf:
>     - if:
> diff --git
> a/Documentation/devicetree/bindings/phy/socionext,uniphier-pcie-phy.yaml
> b/Documentation/devicetree/bindings/phy/socionext,uniphier-pcie-phy.yaml
> index b3ed2f74a414..9fc0e87c508e 100644
> ---
> a/Documentation/devicetree/bindings/phy/socionext,uniphier-pcie-phy.yaml
> +++
> b/Documentation/devicetree/bindings/phy/socionext,uniphier-pcie-phy.yaml
> @@ -31,13 +31,17 @@ properties:
>       minItems: 1
>       maxItems: 2
>   
> -  clock-names: true
> +  clock-names:
> +    minItems: 1
> +    maxItems: 2
>   
>     resets:
>       minItems: 1
>       maxItems: 2
>   
> -  reset-names: true
> +  reset-names:
> +    minItems: 1
> +    maxItems: 2
>   
>     socionext,syscon:
>       $ref: /schemas/types.yaml#/definitions/phandle
> diff --git
> a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
> b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
> index 2107d98ace15..25c4159f86e4 100644
> --- a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.
> yaml
> +++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.
> yaml
> @@ -34,12 +34,15 @@ properties:
>       minItems: 2
>       maxItems: 3
>   
> -  clock-names: true
> +  clock-names:
> +    minItems: 2
> +    maxItems: 3
>   
>     resets:
>       maxItems: 2
>   
> -  reset-names: true
> +  reset-names:
> +    maxItems: 2
>   
>     vbus-supply:
>       description: A phandle to the regulator for USB VBUS
> diff --git
> a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml
> b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml
> index 8f5aa6238bf3..1f663e9901da 100644
> --- a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.
> yaml
> +++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.
> yaml
> @@ -35,12 +35,15 @@ properties:
>       minItems: 2
>       maxItems: 3
>   
> -  clock-names: true
> +  clock-names:
> +    minItems: 2
> +    maxItems: 3
>   
>     resets:
>       maxItems: 2
>   
> -  reset-names: true
> +  reset-names:
> +    maxItems: 2
>   
>     vbus-supply:
>       description: A phandle to the regulator for USB VBUS, only for USB
> host

Other than that:
Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

I'd appreciate if it could be applied in devicetree or phy.

Thank you,

---
Best Regards
Kunihiko Hayashi

