Return-Path: <linux-kernel+bounces-539515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 530E9A4A565
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38325173B1B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8201DE2B2;
	Fri, 28 Feb 2025 21:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFJExWtH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110141DD525;
	Fri, 28 Feb 2025 21:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740779478; cv=none; b=sCcV3fOSB3J7ZxzbLEvmqqxLqHmmMkQ1aaT5k4x3mHqrmO3Cy97Hy0vz85V6HFGxNHvSk6B4nSziFeHrxL8UL1x5L8gHVjJaX6yTO1nuaJnsoXDvwN3H6w5tbK2vExiMHIz+wKhGBnLIMnWVMyCFA972npcaXCaGpEIagQ/FP5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740779478; c=relaxed/simple;
	bh=MpxAPzTlZ5GUX0OOzjchOn8f8pXXh+0IM+v+xJd4WWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4/qaYrDXEqZLSNIDHxicbozxYVIVjuS/AWZRtxghBdQl+lhtMGr8AHGm01uYmymbceB7u8TifgASOW4YvGc9pnjxhvQPkPz7bpKmfrRxMHRO92BaYwYT45tAG4//ZCQQu0+tuoLgwT96fqv3FFg1E1yANjtPjxdPK1fYXN+V2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFJExWtH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6AAC4CED6;
	Fri, 28 Feb 2025 21:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740779477;
	bh=MpxAPzTlZ5GUX0OOzjchOn8f8pXXh+0IM+v+xJd4WWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TFJExWtH2LCBe7zjInr9DuNEQHLDHXLiJBc3/HwBevOdhVxqXOryyZLBeVOEU1/O3
	 Fse/CqUmQ2d/liVgpd2ZXuqL6ntJ5N1aNoevYQBSUczjhsGZdz8UWsCCb9sCOZ64Ia
	 V3v75TzQM6ILLwp/YzYnXPrgWnrw2X+BNXymwVyUjdSsNkMNxcynq7pekl8uGa61rp
	 YUluNc1Ho4kqxCSXsuPfa6GilbamXY8OCXa+uFQcgJE5nAtyz4cbfZSri/9CDpWXI+
	 V1RFBZPCwaa4VMS43U6SMlg50kUWi4gkaeLQRKgYb49aZ5PfMcn2A7OjjMEkuClObu
	 XAwNgq0DExw/g==
Date: Fri, 28 Feb 2025 15:51:15 -0600
From: Rob Herring <robh@kernel.org>
To: jiebing chen <jiebing.chen@amlogic.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
	jian.xu@amlogic.com, shuai.li@amlogic.com, zhe.wang@amlogic.com
Subject: Re: [PATCH v3 1/6] dt-bindings: clock: meson: Add audio power domain
 for s4 soc
Message-ID: <20250228215115.GA3756522-robh@kernel.org>
References: <20250228-audio_drvier-v3-0-dbfd30507e4c@amlogic.com>
 <20250228-audio_drvier-v3-1-dbfd30507e4c@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228-audio_drvier-v3-1-dbfd30507e4c@amlogic.com>

On Fri, Feb 28, 2025 at 04:04:09PM +0800, jiebing chen wrote:
> Audio power domain found on S4 device. It need to enable before audio work.
> 
> Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
> ---
>  .../bindings/clock/amlogic,axg-audio-clkc.yaml         | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml
> index fd7982dd4ceab82389167079c2258a9acff51a76..364783c6f7572b09d57de2b35d33adb7bcf7db18 100644
> --- a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml
> +++ b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml
> @@ -21,6 +21,7 @@ properties:
>        - amlogic,axg-audio-clkc
>        - amlogic,g12a-audio-clkc
>        - amlogic,sm1-audio-clkc
> +      - amlogic,s4-audio-clkc
>  
>    '#clock-cells':
>      const: 1
> @@ -100,6 +101,9 @@ properties:
>    resets:
>      description: internal reset line
>  
> +  power-domains:
> +    description: audio controller power

You have to define how many (maxItems).

> +
>  required:
>    - compatible
>    - '#clock-cells'
> @@ -116,12 +120,26 @@ allOf:
>              enum:
>                - amlogic,g12a-audio-clkc
>                - amlogic,sm1-audio-clkc
> +              - amlogic,s4-audio-clkc
>      then:
>        required:
>          - '#reset-cells'
>      else:
>        properties:
>          '#reset-cells': false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - amlogic,s4-audio-clkc
> +    then:
> +      required:
> +        - power-domains
> +
> +    else:
> +      properties:
> +        power-domains: false
>  
>  additionalProperties: false
>  
> 
> -- 
> 2.43.0
> 

