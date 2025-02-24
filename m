Return-Path: <linux-kernel+bounces-529034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA21A41EE1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE7037A3E98
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A034233720;
	Mon, 24 Feb 2025 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RU33N3fL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2837221F1B;
	Mon, 24 Feb 2025 12:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400020; cv=none; b=olCf4ObUO9C8zcLYwM4/Frzn4uKuMQjaidRtzkTwKZwO0M4rgmCZczzKc425z0rF0ZFmMRdi9YvZY9bAmYklvNDHHhbR/J12Od2FzdfGeOjwqMa/1EiklI6/nDJWNsk8Yaw5e7R9G8xzorReW+2m2aw6cUsQ9MW2r1DQSbqgGi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400020; c=relaxed/simple;
	bh=lMaZnIo/c51auDH+6WQwJ9/tpgxxJvj9CF15z4hlGWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uyfc4DT3dV9K2+QNZexpMGZ0XrBo2Lwkfw/dAIk6zSxpyXeYDC0fSP0zN0KUbfBlwSluD3b9WDrazHjuCkRZtvBUDO/r/LILU0LD0XoxXawVL0FfngeHrJsJbKFnOkRVKff6ihp3BLuti4iDrfWXporG+S0aiJ3XqwUCDfvYc4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RU33N3fL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E6DC4AF09;
	Mon, 24 Feb 2025 12:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740400020;
	bh=lMaZnIo/c51auDH+6WQwJ9/tpgxxJvj9CF15z4hlGWQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RU33N3fLUHbl4fLDk+4+4/KChfNrl/ODuy1CGNeQxxo8Ju3ZjG/upPsFp75dbUrma
	 ONfNyRQJLq4ex8Jt9xfBuEcTi6tnarW0vBkLn6OI36iOwHLwtDZI6GLqawGYnU6Vyq
	 EnTbnTfROMyE1TErimAq2KJgT8EGuN6BKZPJKbpDDCId4VAD568hqkT8Prn3Ia6X7m
	 BC8GtkJx//yNrr20ou4x9jelVEDmu6WcRrMs3T1nnOIJnAdXNd+rV4eBkIqpvIHr5J
	 MmgpZT9DpU4JcHSsxG5bcyM0O1vLpcgP9AY2o6XqPD5+/UH7eOAhWPfUi/c3qEm+7k
	 UZeXwafboJPMA==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaeec07b705so695003466b.2;
        Mon, 24 Feb 2025 04:27:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUeSbwjLOGg3Jze6kcGSr7rhXZBGgW86FWJXnP7OgPlKeX3/Q0SNPqDdj5A3eCL3q052X/L5vfhc3hyHc9F@vger.kernel.org, AJvYcCVt3E+/cJUHHEZ2HrLHPZy+24TezOE0G7A6tb9EkuSm0+XqSd33KZxol3U8LFDUPIonLiZ8L2+YJ3Ei@vger.kernel.org
X-Gm-Message-State: AOJu0YzQDTXWmd54PX4+cMLoKzSb9ACPbXh420gqSw8G7a7YvA/w7wxY
	wqeoovcxazfJfAkRltiBaE3zmzToiEqZXIhcPpZFtigekRcio6Jp0Pqib/JpltCeRRn4HQzvFtE
	YQ+KyisqsAu5hF8F6UjkE6ZlC+w==
X-Google-Smtp-Source: AGHT+IE0bdnAF+czJ4RoK5ksBXS0GISmkLkK0AOBEJHD5YhJY25EFFnVa4LvHrvx4VDNZsHs7ulbsTvrislbrRlsIW4=
X-Received: by 2002:a17:906:3199:b0:ab6:32d2:16d4 with SMTP id
 a640c23a62f3a-abc0de519c6mr975592166b.56.1740400018723; Mon, 24 Feb 2025
 04:26:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224114648.1606184-1-vincenzo.frascino@arm.com> <20250224114648.1606184-2-vincenzo.frascino@arm.com>
In-Reply-To: <20250224114648.1606184-2-vincenzo.frascino@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 24 Feb 2025 06:26:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJTsk6uudqNJ7dpkH_GeKnAuqTWHSw=WmeN=-PBXDS1Pg@mail.gmail.com>
X-Gm-Features: AWEUYZmi7hUhVER6mycTzw9mt2QdU5RhHSNKbnPAfDOl3xceqac7UV8a1ZEPzTQ
Message-ID: <CAL_JsqJTsk6uudqNJ7dpkH_GeKnAuqTWHSw=WmeN=-PBXDS1Pg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] ASoC: dt-bindings: xlnx,i2s: Convert to json-schema
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
> Convert the Xilinx I2S device tree binding documentation to json-schema.
>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  .../devicetree/bindings/sound/xlnx,i2s.txt    | 28 --------
>  .../devicetree/bindings/sound/xlnx,i2s.yaml   | 68 +++++++++++++++++++
>  2 files changed, 68 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.yaml
>
> diff --git a/Documentation/devicetree/bindings/sound/xlnx,i2s.txt b/Docum=
entation/devicetree/bindings/sound/xlnx,i2s.txt
> deleted file mode 100644
> index 5e7c7d5bb60a..000000000000
> --- a/Documentation/devicetree/bindings/sound/xlnx,i2s.txt
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -Device-Tree bindings for Xilinx I2S PL block
> -
> -The IP supports I2S based playback/capture audio
> -
> -Required property:
> - - compatible: "xlnx,i2s-transmitter-1.0" for playback and
> -              "xlnx,i2s-receiver-1.0" for capture
> -
> -Required property common to both I2S playback and capture:
> - - reg: Base address and size of the IP core instance.
> - - xlnx,dwidth: sample data width. Can be any of 16, 24.
> - - xlnx,num-channels: Number of I2S streams. Can be any of 1, 2, 3, 4.
> -                     supported channels =3D 2 * xlnx,num-channels
> -
> -Example:
> -
> -       i2s_receiver@a0080000 {
> -               compatible =3D "xlnx,i2s-receiver-1.0";
> -               reg =3D <0x0 0xa0080000 0x0 0x10000>;
> -               xlnx,dwidth =3D <0x18>;
> -               xlnx,num-channels =3D <1>;
> -       };
> -       i2s_transmitter@a0090000 {
> -               compatible =3D "xlnx,i2s-transmitter-1.0";
> -               reg =3D <0x0 0xa0090000 0x0 0x10000>;
> -               xlnx,dwidth =3D <0x18>;
> -               xlnx,num-channels =3D <1>;
> -       };
> diff --git a/Documentation/devicetree/bindings/sound/xlnx,i2s.yaml b/Docu=
mentation/devicetree/bindings/sound/xlnx,i2s.yaml
> new file mode 100644
> index 000000000000..5d7f0c651944
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/xlnx,i2s.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/xlnx,i2s.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx I2S PL block
> +
> +description: |

Don't need '|' if no formatting to preserve.

> +  The IP supports I2S based playback/capture audio.
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
> +      - xlnx,i2s-receiver-1.0
> +      - xlnx,i2s-transmitter-1.0
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 4

If there is more than 1 entry, then you need to describe what each one
is. Looks like 1 entry per channel? But I can only guess.

> +    description: |
> +      Base address and size of the IP core instance.

That's every 'reg' property if there's only 1 entry. Description
should be specific to this binding or dropped.

> +
> +  xlnx,dwidth:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum:
> +      - 16
> +      - 24
> +    description: |
> +      Sample data width. Can be any of 16, 24.

Don't repeat constraints in prose.

> +
> +  xlnx,num-channels:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 4
> +    description: |
> +      Number of I2S streams.
> +
> +required:
> +  - compatible
> +  - reg
> +  - xlnx,dwidth
> +  - xlnx,num-channels
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    i2s_receiver@a0080000 {

i2s@...

> +      compatible =3D "xlnx,i2s-receiver-1.0";
> +      reg =3D <0x0 0xa0080000 0x0 0x10000>;
> +      xlnx,dwidth =3D <0x18>;
> +      xlnx,num-channels =3D <1>;
> +    };
> +    i2s_transmitter@a0090000 {

i2s@...

> +      compatible =3D "xlnx,i2s-transmitter-1.0";
> +      reg =3D <0x0 0xa0090000 0x0 0x10000>;
> +      xlnx,dwidth =3D <0x18>;
> +      xlnx,num-channels =3D <1>;
> +    };
> +
> +...
> --
> 2.43.0
>

