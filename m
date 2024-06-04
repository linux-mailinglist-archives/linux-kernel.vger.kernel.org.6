Return-Path: <linux-kernel+bounces-200906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FA08FB657
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85EE31F23001
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C499413C9CF;
	Tue,  4 Jun 2024 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2vRQEO4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E974846D;
	Tue,  4 Jun 2024 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513048; cv=none; b=VpqR6cNKbpevKMnqEOjb9v7q4OVYz2fJ6Je1iLxPkJV8gaOmdYq7QFV1RpVjN5GRLxuokowViYKvHinpE2Hy81zNVwIX86yI06ms/T2qs1Xjq5ppm0v7EuioqO/QFbQ6ZC96oMjG0qTgn87ur8ha1TTyacoCpHA8zSsuDL0b8Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513048; c=relaxed/simple;
	bh=Lj9qAnLR2AFw/O7NEn03XeJc7aJX3ehILngKK6g72J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0GV8Ozrg73GPeRL/ABO3hmDDrKB4jg0/HbvKUAkRlrEvRAoT4Vh2RfZ+jrjmj3oSD93Zf8mp0Ga25kZbfBYJ6arBiBdEKUYbX6A86Kd2tPndTvYhqYgoBGCecMvjw43eHI7U0FpZska5VbiAkZ5StuHm7EWMyt0/Ozw5LApYHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2vRQEO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45940C2BBFC;
	Tue,  4 Jun 2024 14:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717513047;
	bh=Lj9qAnLR2AFw/O7NEn03XeJc7aJX3ehILngKK6g72J0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q2vRQEO4ig5t1bFS3ootCTEDZZPubmDesUBXfVVXUPvxM8HpZ18tqF8jkX5kXMD7j
	 RhmLHYH2WscWY7s7/ud0dNDx0Frwvk5UG9YpAkgNivn3hI/iS64aZG6EZHVKehVb3+
	 lCTJu34AIhDOEsB6/gpT7WNJ1bHwOo30NM45/Rw62G/C0ecr+mc1es6JhJeIJM2O91
	 +HQncN2B5y3U2ytz0GxWcidFEkUb3Hhc3i+znzLDN1AP4xU0M5C5nskntoK8nIS477
	 Aa9THm8riSYSCbdCMMHfz9BxtAnWUdkH23X/G5TFIgtE63x9gBG5uHMCFejJGNZIFY
	 uxEDklcSNX9ow==
Date: Tue, 4 Jun 2024 09:57:25 -0500
From: Rob Herring <robh@kernel.org>
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ricard Wanderlof <ricardw@axis.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@axis.com
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: tlv320adc3xxx: Add MICBIAS-as-GPO
 properties
Message-ID: <20240604145725.GA588460-robh@kernel.org>
References: <20240529-tlv320adc3xxx-micbias-gpo-v1-0-300d39cecc55@axis.com>
 <20240529-tlv320adc3xxx-micbias-gpo-v1-1-300d39cecc55@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-tlv320adc3xxx-micbias-gpo-v1-1-300d39cecc55@axis.com>

yOn Wed, May 29, 2024 at 06:33:44PM +0200, Ricard Wanderlof wrote:
> Add properties for configuring the MICBIAS pins as general purpose
> outputs, with some limitations: The voltage on the pin when activated
> may be set using another property to 2.0 V, 2.5 V or AVDD.
> When deactivated the pin will float.
> 
> Signed-off-by: Ricard Wanderlof <ricard.wanderlof@axis.com>
> ---
>  .../devicetree/bindings/sound/ti,tlv320adc3xxx.yaml  | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/ti,tlv320adc3xxx.yaml b/Documentation/devicetree/bindings/sound/ti,tlv320adc3xxx.yaml
> index ede14ca2c07a..4172aced1386 100644
> --- a/Documentation/devicetree/bindings/sound/ti,tlv320adc3xxx.yaml
> +++ b/Documentation/devicetree/bindings/sound/ti,tlv320adc3xxx.yaml
> @@ -82,6 +82,26 @@ properties:
>        Note that there is currently no support for reading the GPIO pins as
>        inputs.
>  
> +  ti,micbias1-gpo:
> +    type: boolean
> +    description: |
> +      When set, the MICBIAS1 pin may be controlled via the GPIO framework,
> +      as pin number 3 on the device.
> +
> +      In this mode, when the pin is activated, it will be set to the voltage
> +      specified by the ti,micbias1-vg property. When deactivated, the pin will
> +      float.
> +
> +  ti,micbias2-gpo:
> +    type: boolean
> +    description: |
> +      When set, the MICBIAS2 pin may be controlled via the GPIO framework,
> +      as pin number 4 on the device.
> +
> +      In this mode, when the pin is activated, it will be set to the voltage
> +      specified by the ti,micbias1-vg property. When deactivated, the pin will
> +      float.

Typo and sounds like a dependency between properties:

dependencies:
  ti,micbias2-gpio: [ti,micbias2-vg]

> +
>    ti,micbias1-vg:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      enum:
> 
> -- 
> 2.30.2
> 

