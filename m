Return-Path: <linux-kernel+bounces-510123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A445FA31878
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3727188832A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415AD268FE0;
	Tue, 11 Feb 2025 22:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbtqrJNF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8304C263885;
	Tue, 11 Feb 2025 22:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739312347; cv=none; b=URfeI6mg8jt9zQsReNmWM86z7GooH7qSwD1s9Zq7E5deJpNcbKVPMvTLo1CPSr56134gz3zk9zWthF2IsGljR1f45+TODT49KJJXcGmG4QoQH3STmibMGxiGZQNEokgtLHC/gGy/asvnO+RtUcns46I77YEWdBlmswNKtvuW6kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739312347; c=relaxed/simple;
	bh=3L2XukuatOYg5/zh3ZhOK3hqE29EONmvF6HXiPcG9bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCT1Z2ozZeWXiy6SKtqOpF5HWWINXusYBGLDHiJDmiWL2sOGmoIAiGsogny0D/P7ACOvLlN7CRgx3kU5NAfOlKOq5ppXiq/UfmEPh6zNKtcdp3SwiGq1J5BP5H56d7x8tZDSN+AfoK3pRqHJ1M3MSpNKpn4a/7be4wmKm6bT3SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbtqrJNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3780C4CEDD;
	Tue, 11 Feb 2025 22:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739312346;
	bh=3L2XukuatOYg5/zh3ZhOK3hqE29EONmvF6HXiPcG9bU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dbtqrJNFdT+wza4ffDei+crWQwihl/ahZeMM3x7EEDlkbBxi1pccSFpfAIsDUqbYv
	 s81wMKJ48U/AC2VFesMhld2JyVQPtLkUo5FNhlaI82bCethp96jT8LRamy98lojUzb
	 Exh65uaKDPM+EKp2/Ms0Xi7WyP8E11vLrUDQIw8q1Yn5caJA167rhpa7e6cIT1dY3J
	 6+THLxSJAyghgqJqn1VU9uecbMXMzqtftmlI0Kx09XCEuTTXjPltu0FYzsSuEa6aTM
	 cTEGm9CGfvyr696xNEJ+4nbwZj9oLMLu50GkmuU3HuYLo74NhuYj7kHNYgHLtEGnxd
	 jt/ci5e5/sqIg==
Date: Tue, 11 Feb 2025 16:19:04 -0600
From: Rob Herring <robh@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	patches@opensource.cirrus.com,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 3/5] ASoC: dt-bindings: wm8904: Add DMIC, GPIO, MIC
 and EQ support
Message-ID: <20250211221904.GA1270109-robh@kernel.org>
References: <20250206163152.423199-1-francesco@dolcini.it>
 <20250206163152.423199-4-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206163152.423199-4-francesco@dolcini.it>

On Thu, Feb 06, 2025 at 05:31:50PM +0100, Francesco Dolcini wrote:
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
> - wlf,retune-mobile-cfg-names
> - wlf,retune-mobile-cfg-rates
> 
> Datasheet: https://statics.cirrus.com/pubs/proDatasheet/WM8904_Rev4.1.pdf
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  .../devicetree/bindings/sound/wlf,wm8904.yaml | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml
> index 329260cf0fa0..b89d9db02848 100644
> --- a/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml
> +++ b/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml
> @@ -38,6 +38,74 @@ properties:
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
> +    description:
> +      List of strings for the available DRC modes.
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
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description:
> +      List of strings for the available retune modes.
> +      If absent, retune is disabled.

Is there no defined set of names?

> +
> +  wlf,retune-mobile-cfg-rates:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      List of rates for the available retune modes.
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
> +  wlf,retune-mobile-cfg-names: [ 'wlf,retune-mobile-cfg-rates', 'wlf,retune-mobile-cfg-regs' ]
> +  wlf,retune-mobile-cfg-regs: [ 'wlf,retune-mobile-cfg-names', 'wlf,retune-mobile-cfg-rates' ]
> +  wlf,retune-mobile-cfg-rates: [ 'wlf,retune-mobile-cfg-names', 'wlf,retune-mobile-cfg-regs' ]

I'm not really a fan of these long lists of properties, but codecs and 
touchscreens seem to need a bunch of parameters.

> +
>  required:
>    - compatible
>    - reg
> @@ -70,5 +138,25 @@ examples:
>              DBVDD-supply = <&reg_1p8v>;
>              DCVDD-supply = <&reg_1p8v>;
>              MICVDD-supply = <&reg_1p8v>;
> +
> +            wlf,drc-cfg-names = "default", "peaklimiter", "tradition", "soft", "music";
> +            wlf,drc-cfg-regs =
> +                /* coded default: KNEE_IP = KNEE_OP = 0, HI_COMP = LO_COMP = 1  */
> +                /bits/ 16 <0x01af 0x3248 0x0000 0x0000>,
> +                /* coded default: KNEE_IP = -24, KNEE_OP = -6, HI_COMP = 1/4, LO_COMP = 1 */
> +                /bits/ 16 <0x04af 0x324b 0x0010 0x0408>,
> +                /* coded default: KNEE_IP = -42, KNEE_OP = -3, HI_COMP = 0, LO_COMP = 1 */
> +                /bits/ 16 <0x04af 0x324b 0x0028 0x0704>,
> +                /* coded default: KNEE_IP = -45, KNEE_OP = -9, HI_COMP = 1/8, LO_COMP = 1 */
> +                /bits/ 16 <0x04af 0x324b 0x0018 0x078c>,
> +                /* coded default: KNEE_IP = -30, KNEE_OP = -10.5, HI_COMP = 1/4, LO_COMP = 1 */
> +                /bits/ 16 <0x04af 0x324b 0x0010 0x050e>;
> +
> +            wlf,gpio-cfg = <
> +                0x0018 /* GPIO1 => DMIC_CLK */
> +                0xffff /* GPIO2 => don't touch */
> +                0xffff /* GPIO3 => don't touch */
> +                0xffff /* GPIO4 => don't touch */
> +            >;

Please make your example full and add all the optional properties.

>          };
>      };
> -- 
> 2.39.5
> 

