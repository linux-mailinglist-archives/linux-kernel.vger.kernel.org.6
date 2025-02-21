Return-Path: <linux-kernel+bounces-526668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEE7A401D8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FBDF3BCF0C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA03253B7B;
	Fri, 21 Feb 2025 21:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjP/evoV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D235E1FF7C8;
	Fri, 21 Feb 2025 21:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740172083; cv=none; b=L7dPWTGQgxcIEDOg0l2Pb49wnGJE0Nds9Q7uhQir0h6qTki8XKwxI2MZwm3UWB0JlxVsKkuxQgauYLttWcSIeFSueLc4vRMIhywGvIvwnFLdlWFxxLUrxsm6Vo5B+2S6kbYKkz2AF11s7v5nTgyPl7qO6DY8m/Up3NeenJ2NN5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740172083; c=relaxed/simple;
	bh=OkPgP7EaLg3zzaugexfyoWlImQLRS4upEXuczawslTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPHdWOGavQURaRWfpwS6XdbFYJLu3YSZIy3oPWtuyoR/FaqcZjjcmAwBKrvmw8IDWiG4aCsGn37VQstvOnrzqbb1aHpYhAVujE8bWFH4hXnI4iaxLStCEcXULSGjzeqUvz5PRALHVTPcxBPitkN+OHTbTBrCmczW9WXWg0Fkjfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjP/evoV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D880C4CED6;
	Fri, 21 Feb 2025 21:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740172083;
	bh=OkPgP7EaLg3zzaugexfyoWlImQLRS4upEXuczawslTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UjP/evoV2VwHrbmdUraWzGUzMnMW5rkxuTFNQ3Pygm6Ghc8onscQK5Ik95eaGIK0j
	 6eFoTozzzHYhdc0BAbqPQifxZnALbSMJh+itz7obQhyAahrR/19gGay6wGlvPi1mLz
	 3RamjjbXdsSaOIGbKyKvoGMWHP53AkeO4mhUNe1eS5KWfGMWgVAs94tdwb2Icv86de
	 0IuYHY5s/pOjmQf4AW+seWUqoQudHe3Wb2s4OZX1FcjF3l9X1Yp05dPq0gRqMfG7ad
	 qSDruJWsmdaBt+f/5oVUMapdPqg7BQzE8rMWmoKxwwdTHBJdw7YXXtuKAYueompzQe
	 iIlBJTKh+kzCg==
Date: Fri, 21 Feb 2025 15:08:01 -0600
From: Rob Herring <robh@kernel.org>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: interrupt-controller: Add support for
 Amlogic A4 and A5 SoCs
Message-ID: <20250221210801.GA81340-robh@kernel.org>
References: <20250219-irqchip-gpio-a4-a5-v1-0-3c8e44ae42df@amlogic.com>
 <20250219-irqchip-gpio-a4-a5-v1-1-3c8e44ae42df@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219-irqchip-gpio-a4-a5-v1-1-3c8e44ae42df@amlogic.com>

On Wed, Feb 19, 2025 at 03:29:03PM +0800, Xianwei Zhao wrote:
> Update dt-binding document for GPIO interrupt controller
> of Amlogic A4 and A5 SoCs
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  .../bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml       | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
> index a93744763787..03548ee695bd 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
> @@ -35,6 +35,9 @@ properties:
>                - amlogic,meson-sm1-gpio-intc
>                - amlogic,meson-a1-gpio-intc
>                - amlogic,meson-s4-gpio-intc
> +              - amlogic,a4-gpio-intc
> +              - amlogic,a4-gpio-ao-intc
> +              - amlogic,a5-gpio-intc
>                - amlogic,c3-gpio-intc
>                - amlogic,t7-gpio-intc
>            - const: amlogic,meson-gpio-intc
> @@ -49,7 +52,7 @@ properties:
>  
>    amlogic,channel-interrupts:
>      description: Array with the upstream hwirq numbers
> -    minItems: 8
> +    minItems: 2

There should be an if/then schema that retains 8 as the minimum for the 
existing cases.

>      maxItems: 12
>      $ref: /schemas/types.yaml#/definitions/uint32-array
>  
> 
> -- 
> 2.37.1
> 

