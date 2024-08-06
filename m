Return-Path: <linux-kernel+bounces-276831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6809498EF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504701F22B96
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1CD155C97;
	Tue,  6 Aug 2024 20:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="POowLvBR";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="POowLvBR"
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3651073451;
	Tue,  6 Aug 2024 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722975581; cv=none; b=LGS59MLktmulaQLmz0SP10esx9wdIhGiHagtkrdvNu8ndJ7czo7AIE+rW2O4eZn1Nxuae7I2cSrLIuLY1dK5mAIBLQ53Xj8nXYQV/dDvQeMETz5dnxzh3gcyap23F3IogDK0r4L5qc2AH8DbAFV0DcdoY1bhlqNs2i4utlY/OxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722975581; c=relaxed/simple;
	bh=stWwF0GuGn8B9mcQqlBa2jF5NZhyeHfpbpw1CaPXFHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nORuH/EjyQZevna6QEhztrWCmocpU5phLsIwzqFZmY0sU4Y6/UCzBSCi7chSSxbHZ6Dy8EjCMSjwqMmQnXO7v2cnq2h9O+8wTJOPpeh2YMh3HK+AfqfRPIX3J8HY9qzZsEhMLcr0R8K5uhaCsFeJzb+15Jvwas4kKojrVoiOROE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=POowLvBR; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=POowLvBR; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1722975233; bh=stWwF0GuGn8B9mcQqlBa2jF5NZhyeHfpbpw1CaPXFHI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=POowLvBRKDgra8US0miJh7IqlgD9IuHN6LH1xR77PUW9WFLor18owg7hMPXm4CsP7
	 DX48bKuF2/nEKKglLjLE1l6oJrYIqctQLrrZjsCExDlP7srwJmYDHu3qboF5YP3A8/
	 rx9dMoJMd3kJJq18H53ZpM6VliPj0gPQH6bl4SKRNqpNiK/7s1bxTVe3VV4LfLUGab
	 1NEjpJB6s7spLhFMHUxNtOn0YGQlUA+jXG3FBjDLhb9/0Fc3rMWeB4ZXuQJVqirJcc
	 piBkeoQgzLj/eh9QcmXdIIqcbsI3hI3/6vn2fmKMRU5ztdVhzSnSYPiPYfRqOlT2xZ
	 maPjOsJQ10oqA==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id CE3524793E2;
	Tue,  6 Aug 2024 20:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1722975233; bh=stWwF0GuGn8B9mcQqlBa2jF5NZhyeHfpbpw1CaPXFHI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=POowLvBRKDgra8US0miJh7IqlgD9IuHN6LH1xR77PUW9WFLor18owg7hMPXm4CsP7
	 DX48bKuF2/nEKKglLjLE1l6oJrYIqctQLrrZjsCExDlP7srwJmYDHu3qboF5YP3A8/
	 rx9dMoJMd3kJJq18H53ZpM6VliPj0gPQH6bl4SKRNqpNiK/7s1bxTVe3VV4LfLUGab
	 1NEjpJB6s7spLhFMHUxNtOn0YGQlUA+jXG3FBjDLhb9/0Fc3rMWeB4ZXuQJVqirJcc
	 piBkeoQgzLj/eh9QcmXdIIqcbsI3hI3/6vn2fmKMRU5ztdVhzSnSYPiPYfRqOlT2xZ
	 maPjOsJQ10oqA==
Message-ID: <d1ac7446-143b-40d3-9f12-f734ab7cc31f@mleia.com>
Date: Tue, 6 Aug 2024 23:13:52 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: timer: nxp,lpc3220-timer: Convert to
 dtschema
Content-Language: en-US
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240731074544.208411-1-animeshagarwal28@gmail.com>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20240731074544.208411-1-animeshagarwal28@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20240806_201353_874826_6BDB1142 
X-CRM114-Status: GOOD (  18.26  )

On 7/31/24 10:45, Animesh Agarwal wrote:
> Convert the NXP LPC3220 timer bindings to yaml format.
> Add missing resets property as it is already being used in dts.
> 
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> ---
>   .../bindings/timer/nxp,lpc3220-timer.txt      | 26 ---------
>   .../bindings/timer/nxp,lpc3220-timer.yaml     | 55 +++++++++++++++++++
>   2 files changed, 55 insertions(+), 26 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/timer/nxp,lpc3220-timer.txt
>   create mode 100644 Documentation/devicetree/bindings/timer/nxp,lpc3220-timer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/nxp,lpc3220-timer.txt b/Documentation/devicetree/bindings/timer/nxp,lpc3220-timer.txt
> deleted file mode 100644
> index 51b05a0e70d1..000000000000
> --- a/Documentation/devicetree/bindings/timer/nxp,lpc3220-timer.txt
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -* NXP LPC3220 timer
> -
> -The NXP LPC3220 timer is used on a wide range of NXP SoCs. This
> -includes LPC32xx, LPC178x, LPC18xx and LPC43xx parts.
> -
> -Required properties:
> -- compatible:
> -	Should be "nxp,lpc3220-timer".
> -- reg:
> -	Address and length of the register set.
> -- interrupts:
> -	Reference to the timer interrupt
> -- clocks:
> -	Should contain a reference to timer clock.
> -- clock-names:
> -	Should contain "timerclk".
> -
> -Example:
> -
> -timer1: timer@40085000 {
> -	compatible = "nxp,lpc3220-timer";
> -	reg = <0x40085000 0x1000>;
> -	interrupts = <13>;
> -	clocks = <&ccu1 CLK_CPU_TIMER1>;
> -	clock-names = "timerclk";
> -};
> diff --git a/Documentation/devicetree/bindings/timer/nxp,lpc3220-timer.yaml b/Documentation/devicetree/bindings/timer/nxp,lpc3220-timer.yaml
> new file mode 100644
> index 000000000000..3ae2eb0625da
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/nxp,lpc3220-timer.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/nxp,lpc3220-timer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP LPC3220 timer
> +
> +maintainers:
> +  - Animesh Agarwal <animeshagarwal28@gmail.com>
> +
> +description: |
> +  The NXP LPC3220 timer is used on a wide range of NXP SoCs. This includes
> +  LPC32xx, LPC178x, LPC18xx and LPC43xx parts.
> +
> +properties:
> +  compatible:
> +    const: nxp,lpc3220-timer
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: timerclk
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names

Since there is always just a single supply clock, there is no need to
specify "clock-names" as a required one, please change it.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/lpc32xx-clock.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    timer@4004c000 {
> +        compatible = "nxp,lpc3220-timer";
> +        reg = <0x4004c000 0x1000>;
> +        interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
> +        clocks = <&clk LPC32XX_CLK_TIMER1>;
> +        clock-names = "timerclk";
> +    };

I would appreciate, if you can use scripts/get_maintainer.pl in future.

--
Best wishes,
Vladimir

