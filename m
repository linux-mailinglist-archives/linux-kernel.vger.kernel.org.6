Return-Path: <linux-kernel+bounces-555663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FABAA5BAFA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6166A16F72C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E203225A32;
	Tue, 11 Mar 2025 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cF4r1lxe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC73D1E9B0C;
	Tue, 11 Mar 2025 08:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741682568; cv=none; b=i9fzlmevgWYaCzjjY+cGe62I9rFGKCF8zThCOcF/qS0YAR48BCcwXxf/fzOgYhr6gsA+0QEn2zWuJMNdF1Vrnmt7Dpj7SLdJZMo8IFotsvxzc/z64Lrylqz8+jhAvjI+SAF5tCnUOZ20Sid4Uc3hd34xuFFQqb+VH3NbONHIIps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741682568; c=relaxed/simple;
	bh=QzsgKSTlkwDsaiuWN6Kc/I7xqmRseAtTWlfyXN3qWiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZI+3STa4qxyQkT+wC+qlv7ZEdvYlET66G//oWU5P4Luz0BoliS4teF70LQZAZQaJwllyg2hrJjtnyFy7qCkty/ADZIKs+kxTgw79TsRJM4zaskuVILNC88iXib5lMA5FUyfW6pC3abv+l6kb4aXCqnshQxe06j1uagWR03llWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cF4r1lxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02112C4CEE9;
	Tue, 11 Mar 2025 08:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741682568;
	bh=QzsgKSTlkwDsaiuWN6Kc/I7xqmRseAtTWlfyXN3qWiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cF4r1lxem37JVNj82VdWy2+U8ymAJbgtvA5iei+Cur12H+HvlP9c6gJQejKBdewmd
	 n3ye/N6xy/Y9u6lCDfzNOyfeLOH+c8coHYmA1GeVutG0KiL0Qz8jy2KMw1SZqiKA7R
	 CKurl6ZxlzQ/jJcUiL5v9TR9l+sGzqnBfGjv7eOcHvNCpqxxyN7oZVjHFHkDajSV/y
	 dIqikFyogKorLdNXWQIQ+E91v+8Ayk3mbQRisiS/Y+IcqFsbtkQ32zIeWZ+QhtQUN+
	 HXL+8IDR1bE/ipYTrPWGPL/11BSLN7YcGkwbPNnmtOy2jYgcD/JD86ywEXaxB1XoQN
	 z12I7zIsT3Xjw==
Date: Tue, 11 Mar 2025 09:42:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Francesco Dolcini <francesco.dolcini@toradex.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v3 3/5] ASoC: dt-bindings: wm8904: Add DMIC, GPIO, MIC
 and EQ support
Message-ID: <20250311-solid-poetic-camel-77a29b@krzk-bin>
References: <20250307135244.100443-1-francesco@dolcini.it>
 <20250307135244.100443-4-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250307135244.100443-4-francesco@dolcini.it>

On Fri, Mar 07, 2025 at 02:52:42PM +0100, Francesco Dolcini wrote:
> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> 
> Add two properties to select the IN1L/DMICDAT1 and IN2R/DMICDAT2
> functionality:
> - wlf,in1l-as-dmicdat1
> - wlf,in1r-as-dmicdat2
> 
> Add a property to describe the GPIO configuration registers, that can be
> used to set the four multifunction pins:
> - wlf,gpio-cfg
> 
> Add a property to describe the mic bias control registers:
> - wlf,mic-cfg
> 
> Add two properties to describe the Dynamic Range Controller (DRC),
> allowing multiple named configurations where each config sets the 4 DRC
> registers (R40-R43):
> - wlf,drc-cfg-regs
> - wlf,drc-cfg-names
> 
> Add three properties to describe the equalizer (ReTune Mobile), allowing
> multiple named configurations (associated with a samplerate) that set
> the 24 (R134-R157) EQ registers:
> - wlf,retune-mobile-cfg-regs
> - wlf,retune-mobile-cfg-hz
> - wlf,retune-mobile-cfg-rates
> 
> Datasheet: https://statics.cirrus.com/pubs/proDatasheet/WM8904_Rev4.1.pdf
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> v3: v2 did not pass dt_binding_check, this is now fixed.
>     Fixed a DT compilation error by moving a misplaced closing bracket.
>     Changed 'retune-mobile-cfg-names' to be a nonunique-string-array.
>     Renamed 'retune-mobile-cfg-rates' to 'retune-mobile-cfg-hz',
>         dropped the 'ref' because it is now a standard unit suffix prop.
>     Redid line wrapping to be compliant with the DTS style guidelines.
> v2: Added an example of how to use the ReTune Mobile config properties
> v1: https://lore.kernel.org/lkml/20250206163152.423199-4-francesco@dolcini.it/
> ---
>  .../devicetree/bindings/sound/wlf,wm8904.yaml | 116 ++++++++++++++++++
>  1 file changed, 116 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml
> index 329260cf0fa0..4ad8681cb266 100644
> --- a/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml
> +++ b/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml
> @@ -38,6 +38,72 @@ properties:
>    DCVDD-supply: true
>    MICVDD-supply: true
>  
> +  wlf,in1l-as-dmicdat1:
> +    type: boolean
> +    description:
> +      Use IN1L/DMICDAT1 as DMICDAT1, enabling the DMIC input path.
> +
> +  wlf,in1r-as-dmicdat2:
> +    type: boolean
> +    description:
> +      Use IN1R/DMICDAT2 as DMICDAT2, enabling the DMIC input path.

Are these two properties mutually exclusive?

> +
> +  wlf,gpio-cfg:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 4
> +    maxItems: 4
> +    description:
> +      Default register values for R121/122/123/124 (GPIO Control).
> +      If any entry has the value 0xFFFF, the related register won't be set.
> +    default: [0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF]
> +
> +  wlf,mic-cfg:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 2
> +    maxItems: 2
> +    description:
> +      Default register values for R6/R7 (Mic Bias Control).
> +    default: [0, 0]
> +
> +  wlf,drc-cfg-names:
> +    $ref: /schemas/types.yaml#/definitions/string-array

No constraints, so I assume you can have here any number of items?

> +    description:
> +      List of strings for the available DRC modes.

Why the actual names are not defined? Why do you need this property if
they are not defined (thus driver does not request this by the name)?

> +      If absent, DRC is disabled.
> +
> +  wlf,drc-cfg-regs:
> +    $ref: /schemas/types.yaml#/definitions/uint16-array
> +    description:
> +      Default register values for R40/41/42/43 (DRC).
> +      The list must be 4 times the length of wlf,drc-cfg-names.
> +      If absent, DRC is disabled.
> +
> +  wlf,retune-mobile-cfg-names:
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    description:
> +      List of strings for the available retune modes.
> +      If absent, retune is disabled.
> +
> +  wlf,retune-mobile-cfg-hz:
> +    description:
> +      The list must be the same length as wlf,retune-mobile-cfg-names.
> +      If absent, retune is disabled.
> +
> +  wlf,retune-mobile-cfg-regs:
> +    $ref: /schemas/types.yaml#/definitions/uint16-array
> +    description:
> +      Default register values for R134/.../157 (EQ).
> +      The list must be 24 times the length of wlf,retune-mobile-cfg-names.
> +      If absent, retune is disabled.
> +
> +dependencies:
> +  wlf,drc-cfg-names: [ 'wlf,drc-cfg-regs' ]
> +  wlf,drc-cfg-regs: [ 'wlf,drc-cfg-names' ]
> +
> +  wlf,retune-mobile-cfg-names: [ 'wlf,retune-mobile-cfg-hz', 'wlf,retune-mobile-cfg-regs' ]
> +  wlf,retune-mobile-cfg-regs: [ 'wlf,retune-mobile-cfg-names', 'wlf,retune-mobile-cfg-hz' ]
> +  wlf,retune-mobile-cfg-hz: [ 'wlf,retune-mobile-cfg-names', 'wlf,retune-mobile-cfg-regs' ]
> +
>  required:
>    - compatible
>    - reg
> @@ -70,5 +136,55 @@ examples:
>              DBVDD-supply = <&reg_1p8v>;
>              DCVDD-supply = <&reg_1p8v>;
>              MICVDD-supply = <&reg_1p8v>;
> +
> +            wlf,drc-cfg-names = "default", "peaklimiter", "tradition", "soft",
> +                                "music";
> +            /*
> +             * Config registers per name, respectively:
> +             * KNEE_IP = 0,   KNEE_OP = 0,     HI_COMP = 1,   LO_COMP = 1
> +             * KNEE_IP = -24, KNEE_OP = -6,    HI_COMP = 1/4, LO_COMP = 1
> +             * KNEE_IP = -42, KNEE_OP = -3,    HI_COMP = 0,   LO_COMP = 1
> +             * KNEE_IP = -45, KNEE_OP = -9,    HI_COMP = 1/8, LO_COMP = 1
> +             * KNEE_IP = -30, KNEE_OP = -10.5, HI_COMP = 1/4, LO_COMP = 1
> +             */
> +            wlf,drc-cfg-regs = /bits/ 16 <0x01af 0x3248 0x0000 0x0000>,

<number>, <number>, <number> ...

unless you wanted 64-bit?

> +                               /bits/ 16 <0x04af 0x324b 0x0010 0x0408>,
> +                               /bits/ 16 <0x04af 0x324b 0x0028 0x0704>,
> +                               /bits/ 16 <0x04af 0x324b 0x0018 0x078c>,
> +                               /bits/ 16 <0x04af 0x324b 0x0010 0x050e>;
> +
> +            /* GPIO1 = DMIC_CLK, don't touch others */
> +            wlf,gpio-cfg = <0x0018 0xffff 0xffff 0xffff>;

So how many items here?

> +
> +            wlf,retune-mobile-cfg-names = "bassboost", "bassboost", "treble";
> +            wlf,retune-mobile-cfg-hz = <48000 44100 48000>;
> +            /*
> +             * Config registers per name, respectively:
> +             * EQ_ENA,  100 Hz,  300 Hz,  875 Hz, 2400 Hz, 6900 Hz
> +             *      1,   +6 dB,   +3 dB,    0 dB,    0 dB,    0 dB
> +             *      1,   +6 dB,   +3 dB,    0 dB,    0 dB,    0 dB
> +             *      1,   -2 dB,   -2 dB,    0 dB,    0 dB,   +3 dB
> +             * Each one uses the defaults for ReTune Mobile registers 140-157
> +             */
> +            wlf,retune-mobile-cfg-regs = /bits/ 16 <0x1 0x12 0xf 0xc 0xc 0xc>,
> +                                         /bits/ 16 <0x0fca 0x0400 0x00d8 0x1eb5
> +                                                    0xf145 0x0bd5 0x0075 0x1c58
> +                                                    0xf3d3 0x0a54 0x0568 0x168e
> +                                                    0xf829 0x07ad 0x1103 0x0564
> +                                                    0x0559 0x4000>,

I am really confused what are the matrix bounds here.

> +
> +                                         /bits/ 16 <0x1 0x12 0xf 0xc 0xc 0xc>,
> +                                         /bits/ 16 <0x0fca 0x0400 0x00d8 0x1eb5
> +                                                    0xf145 0x0bd5 0x0075 0x1c58
> +                                                    0xf3d3 0x0a54 0x0568 0x168e
> +                                                    0xf829 0x07ad 0x1103 0x0564
> +                                                    0x0559 0x4000>,

Best regards,
Krzysztof


