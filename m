Return-Path: <linux-kernel+bounces-375018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FAC9A8FC3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C485E28308A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729041FBF53;
	Mon, 21 Oct 2024 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6z3oItO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD2D1FBC87;
	Mon, 21 Oct 2024 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729538793; cv=none; b=BLp+NOB1pe7YklSOZFX1UH5e5PTI3dtzWKoaRkUF9d0VtOyK+7enAMq+3GAWBbHdG+q4fICdGZxxLdkHOCfIsqgekhZedscaM7XMykCrIFOt9J0hU7pBEow5PkKP6ciBAPfKm8y5bVNX7zKgspZOgIh0m36eU+Ydh6sOFnvj73w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729538793; c=relaxed/simple;
	bh=zA4sZ0GOCefJgtUsyAnLlD0LbsF0ALVbHDC66/Uv15A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkW3rwbFqV6lutgGVh4Te2sxYshdfFrsEtwdt6oyCS3wWDp+wQK0XA5cAUWlihwhWMOtIBbgZdtpQoy9yUX3jSijeVEBf8J06w3Kgp3WPTNiwHUuyovvIaj8Yd6hgk1CX1AT+fydcIilMVgikNP9jtn9Q4w54rVMq3fK/vl2oGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6z3oItO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B03C4CEC3;
	Mon, 21 Oct 2024 19:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729538793;
	bh=zA4sZ0GOCefJgtUsyAnLlD0LbsF0ALVbHDC66/Uv15A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B6z3oItOv3LMfLuqZ+r7kMjS7DXUolmGT0kIZPxHbo01Xj9/9lisFQ05LrFohJ1Sp
	 eqX1ziV7LZIN1ypa+h+Co2wvuNs3q4PGM6nAQhHY/8plmSaS/YX15jlM9lpm0KmRIW
	 YhKBxwNDKgYQc2+myG3YD8vqnzSDbBbQToO6ms1c7TBuM7gQe6Lelr+btLIhg7i3ZP
	 tGdqf7/I/ikEU4sLJCyXHdGEQn0qprClyFVCqQROaHyVxT1BnTRBHFfVmyFJeUPlst
	 F23X3dHrPfeO/LsGe3a3DGC4qGGDPa66DBv5U2Q/Bs+KjLpiUuaEBYQIQMdEAvdRMx
	 fRENLuqAmEHiw==
Date: Mon, 21 Oct 2024 14:26:32 -0500
From: Rob Herring <robh@kernel.org>
To: James Calligeros <jcalligeros99@gmail.com>
Cc: Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	asahi@lists.linux.dev, linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>,
	Neal Gompa <neal@gompa.dev>
Subject: Re: [PATCH v2 1/3] dt-bindings: sound: Add CS42L84 codec
Message-ID: <20241021192632.GA965116-robh@kernel.org>
References: <20241020-cs42l84-v2-0-37ba2b6721d9@gmail.com>
 <20241020-cs42l84-v2-1-37ba2b6721d9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241020-cs42l84-v2-1-37ba2b6721d9@gmail.com>

On Sun, Oct 20, 2024 at 12:47:31AM +1000, James Calligeros wrote:
> From: Martin Povišer <povik+lin@cutebit.org>
> 
> CS42L84 is a headphone jack codec made by Cirrus Logic and seen in Apple
> computer models starting with 2021 Macbook Pros. It is not a publicly
> documented part. To a degree the part is similar to the public CS42L42.
> (The L84 superseded L83 seen in earlier Apple models, and the L83 was
> pretty much the same as L42.)

Why can't this be added to 
Documentation/devicetree/bindings/sound/cirrus,cs42l42.yaml?

I guess perhaps you don't know what the supplies look like? Do any of 
the custom properties apply?

> 
> Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
> Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> ---
>  .../bindings/sound/cirrus,cs42l84.yaml   | 56 +++++++++++++++++++++++++
>  MAINTAINERS                              |  1 +
>  2 files changed, 57 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs42l84.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs42l84.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..7f8338e8ae369bc529ac3cf35041d5a7b9f3e6d1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/cirrus,cs42l84.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/cirrus,cs42l84.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic CS42L84 audio CODEC
> +
> +maintainers:
> +  - Martin Povišer <povik+lin@cutebit.org>
> +
> +description: |

Don't need '|' if no formatting.

> +  The CS42L84 is a headphone jack codec made by Cirrus Logic and embedded
> +  in personal computers sold by Apple. It was first seen in 2021 Macbook
> +  Pro models. It has stereo DAC for playback, mono ADC for capture, and
> +  is somewhat similar to CS42L42 but with a different regmap.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cirrus,cs42l84
> +
> +  reg:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  '#sound-dai-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      jack_codec: codec@4b {
> +          compatible = "cirrus,cs42l84";
> +          reg = <0x4b>;
> +          reset-gpios = <&pinctrl_nub 4 GPIO_ACTIVE_LOW>;
> +          interrupts-extended = <&pinctrl_ap 180 IRQ_TYPE_LEVEL_LOW>;
> +          #sound-dai-cells = <0>;
> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c1a2c296446c0724a0c6e70c845e5e5e1e693fd5..f5f85714dc4e8ca9c60b3f6963b2cec1ea33fdd0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2132,6 +2132,7 @@ L:	asahi@lists.linux.dev
>  L:	linux-sound@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/sound/adi,ssm3515.yaml
> +F:	Documentation/devicetree/bindings/sound/cirrus,cs42l84.yaml
>  F:	Documentation/devicetree/bindings/sound/apple,*
>  F:	sound/soc/apple/*
>  F:	sound/soc/codecs/cs42l83-i2c.c
> 
> -- 
> 2.47.0
> 

