Return-Path: <linux-kernel+bounces-529042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9DCA41F35
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9C5E165F01
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B8F233712;
	Mon, 24 Feb 2025 12:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NukBH3qI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CC919B5A3;
	Mon, 24 Feb 2025 12:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400275; cv=none; b=q2EqTGABboJGHKGSP8uJgz8Spu5hP2Oh/Rl09+i7EnLrHD75YmodQo+3+Al+2VDnIDHZ+Y21brdAGf6mZlqrlEbiCw0Z6MJAhrEiX/DcnKaAd9hTr6TgUP0rRXcMv//zJtjg38d2cj1g9wi/biGXrv1l4wuLRMkIcIMubE4375I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400275; c=relaxed/simple;
	bh=gc1D//Ffey8erAww4BtrYA/C5TzLux2XzdYyCROK0w8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LzANUy6i5YYIG+IFLTvme9S4SY6qgPW+Viq2CE5VWkK8N2kAF0xuVyol9zALe2AeCvYjo27dhmWHLUxHJu2e74Z/xof1CXnAB0xxv/V337VGhhkQc7LyOqMG/J+SXbxNotMp/Sx04+rRtYTDgMVIlUjBaDgqsvgBNJPi+A5zexQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NukBH3qI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13225C4CEE8;
	Mon, 24 Feb 2025 12:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740400275;
	bh=gc1D//Ffey8erAww4BtrYA/C5TzLux2XzdYyCROK0w8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NukBH3qIVuiuCGmBh6hzBM9KH8XfZoGm6ggcvta1b0j3EqI8yvPp1hK8BXG1rzhvt
	 wqU9Ywx17tLnCYsKlocPE8Q1k/QqJzITn8vHKDjsdOsz7Ic4ULY7At/6EemgMn2ZSb
	 Bz/3HNWekpcA7BDZtiVk8MJimEdwZH+58oskxrA68Q9hQnojTFf+O1v1mlt44mhh7I
	 4L2Zzwa5aWCdp8hUSKO2HIHXPgADlYuZvlqur9HpQ9DTSQg/fG5BRiPEG/iQXgVV/u
	 aNiMX2PPaWLTEUyayv8v6b0Hn8kk+AxEDI92+/hsLWWieqIV5Mwvuuw+iOEVSA7Xpi
	 8HoIgSbXxDmYw==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e04f87584dso6355341a12.3;
        Mon, 24 Feb 2025 04:31:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVE3zeWQnaAfw8geMkzAAo2wy3gBQgLDdO2qeos7VjGKGCWkymvdRteh1h2Bs2qWu8TBJ8aAkd3SGuB@vger.kernel.org, AJvYcCVn+/7OxqHxjnOGRe5tyJcEmyF0X/XCGAMeyIDuDY4/43KiMS+Wwm6fLSMtdX4Y0HdbwIDAhUYzWAL13ks/@vger.kernel.org
X-Gm-Message-State: AOJu0YztbMgIaIgVHHEHtpkChbz8q2FpYTqEa8uw7PddxN31yo3a8uEx
	Aa564jxSZKBzNXPb/c/NY2Mq//CxENNyZNB9O75g39nJjZzYGlk+RZSW6i/NZLlpay5BA19qq+u
	tgtAgQ4XSAOphibJ6/Oo0yJhwrw==
X-Google-Smtp-Source: AGHT+IHIrFLQGrUmr0/vRBFFvkZaV+UNoXq1Y47I6/AgegFXRC8cAvE98Z6EsH8IgPlqwmpF0VzqMVFcZN6ZdyHqFN4=
X-Received: by 2002:a05:6402:35c9:b0:5dc:c9ce:b029 with SMTP id
 4fb4d7f45d1cf-5e0b70b6efamr12810252a12.5.1740400273495; Mon, 24 Feb 2025
 04:31:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224114648.1606184-1-vincenzo.frascino@arm.com> <20250224114648.1606184-3-vincenzo.frascino@arm.com>
In-Reply-To: <20250224114648.1606184-3-vincenzo.frascino@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 24 Feb 2025 06:31:01 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+h5Dt=_mSaew269pXnuR-nQjgzRcdkN2XdCJjwMX-YqQ@mail.gmail.com>
X-Gm-Features: AWEUYZm3u587qtfsFiWkv7dVwFwrNgMkCER2T9IDPbRJEnI5_7JDV-pRlScrhz8
Message-ID: <CAL_Jsq+h5Dt=_mSaew269pXnuR-nQjgzRcdkN2XdCJjwMX-YqQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] ASoC: dt-bindings: xlnx,audio-formatter: Convert
 to json-schema
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-sound@vger.kernel.org, 
	Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 5:47=E2=80=AFAM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Convert the Xilinx Audio Formatter 1.0  device tree binding documentation
> to json-schema.

Similar issues in this one I won't repeat...

>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  .../bindings/sound/xlnx,audio-formatter.txt   | 29 -------
>  .../bindings/sound/xlnx,audio-formatter.yaml  | 76 +++++++++++++++++++
>  2 files changed, 76 insertions(+), 29 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-fo=
rmatter.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-fo=
rmatter.yaml
>
> diff --git a/Documentation/devicetree/bindings/sound/xlnx,audio-formatter=
.txt b/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
> deleted file mode 100644
> index cbc93c8f4963..000000000000
> --- a/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -Device-Tree bindings for Xilinx PL audio formatter
> -
> -The IP core supports DMA, data formatting(AES<->PCM conversion)
> -of audio samples.
> -
> -Required properties:
> - - compatible: "xlnx,audio-formatter-1.0"
> - - interrupt-names: Names specified to list of interrupts in same
> -                   order mentioned under "interrupts".
> -                   List of supported interrupt names are:
> -                   "irq_mm2s" : interrupt from MM2S block
> -                   "irq_s2mm" : interrupt from S2MM block
> - - interrupts-parent: Phandle for interrupt controller.
> - - interrupts: List of Interrupt numbers.
> - - reg: Base address and size of the IP core instance.
> - - clock-names: List of input clocks.
> -   Required elements: "s_axi_lite_aclk", "aud_mclk"
> - - clocks: Input clock specifier. Refer to common clock bindings.
> -
> -Example:
> -       audio_ss_0_audio_formatter_0: audio_formatter@80010000 {
> -               compatible =3D "xlnx,audio-formatter-1.0";
> -               interrupt-names =3D "irq_mm2s", "irq_s2mm";
> -               interrupt-parent =3D <&gic>;
> -               interrupts =3D <0 104 4>, <0 105 4>;
> -               reg =3D <0x0 0x80010000 0x0 0x1000>;
> -               clock-names =3D "s_axi_lite_aclk", "aud_mclk";
> -               clocks =3D <&clk 71>, <&clk_wiz_1 0>;
> -       };
> diff --git a/Documentation/devicetree/bindings/sound/xlnx,audio-formatter=
.yaml b/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.yaml
> new file mode 100644
> index 000000000000..52a685519bc0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/xlnx,audio-formatter.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx PL audio formatter
> +
> +description: |
> +  The IP core supports DMA, data formatting(AES<->PCM conversion)
> +  of audio samples.
> +
> +maintainers:
> +  - Vincenzo Frascino <vincenzo.frascino@arm.com>
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - xlnx,audio-formatter-1.0
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 4
> +    description: |
> +      Base address and size of the IP core instance.
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 3
> +    description: |
> +      Names specified to list of interrupts in same order mentioned unde=
r
> +      "interrupts".

You didn't define the order though...

You must define what the names are and the order. We had that, but you
dropped them.

> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 3
> +    description: |
> +      List of Interrupt numbers.

Generic description of 'interrupts' is not useful.

> +
> +  clock-names:
> +    minItems: 2
> +    maxItems: 3
> +    description: |
> +      List of input clocks.

Must define the names and order.

> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 3
> +    description: |
> +      Input clock specifier. Refer to common clock bindings.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-names
> +  - interrupts
> +  - clock-names
> +  - clocks
> +
> +additionalProperties: true

Only common schemas which are incomplete can use 'true'. This must be false=
.

> +
> +examples:
> +  - |
> +    audio_ss_0_audio_formatter_0: audio_formatter@80010000 {
> +      compatible =3D "xlnx,audio-formatter-1.0";
> +      interrupt-names =3D "irq_mm2s", "irq_s2mm";
> +      interrupt-parent =3D <&gic>;
> +      interrupts =3D <0 104 4>, <0 105 4>;
> +      reg =3D <0x0 0x80010000 0x0 0x1000>;
> +      clock-names =3D "s_axi_lite_aclk", "aud_mclk";
> +      clocks =3D <&clk 71>, <&clk_wiz_1 0>;
> +    };
> +...
> --
> 2.43.0
>

