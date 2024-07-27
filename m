Return-Path: <linux-kernel+bounces-264146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F014193DF7C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 15:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DEE9B21080
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9591140378;
	Sat, 27 Jul 2024 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nl1BSvKz"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698E813AD20
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722085368; cv=none; b=pgv7l99B5O1YcBjYMBBaf0NTQ/NQwEHfIeU/wu4T7/IQ9Hz6X8CP1O0s5rtc58no/OizXpBqCFgJSOLQZjssXHgLKw+ozrdDCB3ArMApCCvXEr07xTlVKXTGWgyFrXp4VESwFMGErDOfnDg+IJRvRoD9ii1TQycAK0uPeMLR+08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722085368; c=relaxed/simple;
	bh=J7dJ1HEM/2kfxbMQktTWpnSMS+Y2hicohD+cLOeNPAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=QtR4V3/ahYWF9+qCl86lyW4/OgnJV4xzUAd3tPv7MFjSNMIcJH0GDOCU+y31C3VatS7GGafMmp0Cqe/L+snmmFnEPHEk+RHXPMdNyXkJO1v41Zkb1CKHZRBJDLIOeorclI+RkjRaBGyqZggJA70eb1Kx24aY5jftS6JWEKU53Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nl1BSvKz; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3cabac56b38so1303400b6e.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 06:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722085366; x=1722690166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQdnaqHqNdySkKT22L5CuAzyHGa1f8MTJfg3ZhjYfhA=;
        b=nl1BSvKzO51JYV7FRuwQijqNJY7ojLgegaixPZf5AyK2QUPMTsQl9NySdwP7PCgAOW
         5ZrcWOMIdYX6v0Q+4DQPXjWTqsj1koz6TzMGn0p1xFpPA7ohMQpl02RHLP/gYLKPwQ2i
         cIcfqWozgNk4sAS9JeY9PHld0uPRG1J3F5HYsvoEP81qzAIXcZPs7U+v8ODy/3c6osUn
         d7lMM2BE84Hb2ju/iTnyZZnNxehFMCjr9mEFY5oXE60Py/INuIFlwodA6JMPnJsDvRjz
         bWaUBDSuRjN3noc9kG4cHHQUibw/wDuNNACbPKjBtARGAWL9NJqmSBQMu/iFSWq/oGy3
         p6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722085366; x=1722690166;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQdnaqHqNdySkKT22L5CuAzyHGa1f8MTJfg3ZhjYfhA=;
        b=osxmWlVezpn4AnVe7yZt9ox134dU6xPGrDH4gEcLnSLY0POsAk/mo+MVq8ufzeMGPv
         MsLEGtdZHXPoH2L+mY53Wyk29XWnL6VfQIqVLVpvIhldx9Jaju+u5u1ZE3eWCqJy+nM2
         itUMr5NExfJCTRW+bljXpRRVfnowgjZhg7N1LQgtnGJkxAIrqaskkQgiDWwi5H1qHy+c
         xqK30lO0FD2vo6r01MsUqn0fTg5+ZB53487nwU9ZZBHfWV9ecK4AiRHg8dAxt1E+NbFq
         KvQCa1s8ABuNzwnSY9+bob5iOFvuqmaBEy2gKSlqmDi6WgcCR/TTk4aNBg0JeVXEHJ+D
         1baA==
X-Forwarded-Encrypted: i=1; AJvYcCXCPgwVLPZo0o1Xy2dyjt37jktWBdzZVBbmEs8iF6P+H9BGiLIcOqyWME6rt6fkJtxnHUZIcq3eO82qyxpD1t3E1cueD0ZGmzB02Sbj
X-Gm-Message-State: AOJu0YwrJ52a8HghHvtapAwFNPiyf07lKs0g2sGtXdCMUNREksbntqV7
	Ght84VOFyQ1bTIeLlX9MXQa0Ka2fAfJxMbu+s326wapF8+07KXe+y2S9zVnApuJJpYQNIC0gwNk
	TCa9zsvsP0c+AC2iRFovLXt76oo0=
X-Received: by 2002:a05:6870:3327:b0:261:1460:9e7c with SMTP id
 586e51a60fabf-267d4d40357mt3141323fac.11.1722085366519; Sat, 27 Jul 2024
 06:02:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727130008.408772-1-animeshagarwal28@gmail.com>
In-Reply-To: <20240727130008.408772-1-animeshagarwal28@gmail.com>
From: Animesh Agarwal <animeshagarwal28@gmail.com>
Date: Sat, 27 Jul 2024 18:32:35 +0530
Message-ID: <CAE3Oz81ACrS1T_b9ORBzPEXd+ZL_Y2M4_A6u01hP6XHAQkju5g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpio: nxp,lpc3220-gpio: Convert to dtschema
Cc: Daniel Baluta <daniel.baluta@nxp.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vladimir Zapolskiy <vz@mleia.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is v2 of the same patch, sorry for missing to mention it in the commit=
.


On Sat, Jul 27, 2024 at 6:30=E2=80=AFPM Animesh Agarwal
<animeshagarwal28@gmail.com> wrote:
>
> Convert the NXP LPC3220 SoC GPIO controller bindings to DT schema format.
>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
>
> --
> Changes in v2:
>   - Changed the file name to match the compatible string.
>   - Removed optional from the description of '#gpio-cells' as it was wron=
gly
>     present.
> ---
>  .../devicetree/bindings/gpio/gpio_lpc32xx.txt | 43 ---------------
>  .../bindings/gpio/nxp,lpc3220-gpio.yaml       | 52 +++++++++++++++++++
>  2 files changed, 52 insertions(+), 43 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gpio/gpio_lpc32xx.t=
xt
>  create mode 100644 Documentation/devicetree/bindings/gpio/nxp,lpc3220-gp=
io.yaml
>
> diff --git a/Documentation/devicetree/bindings/gpio/gpio_lpc32xx.txt b/Do=
cumentation/devicetree/bindings/gpio/gpio_lpc32xx.txt
> deleted file mode 100644
> index 49819367a011..000000000000
> --- a/Documentation/devicetree/bindings/gpio/gpio_lpc32xx.txt
> +++ /dev/null
> @@ -1,43 +0,0 @@
> -NXP LPC32xx SoC GPIO controller
> -
> -Required properties:
> -- compatible: must be "nxp,lpc3220-gpio"
> -- reg: Physical base address and length of the controller's registers.
> -- gpio-controller: Marks the device node as a GPIO controller.
> -- #gpio-cells: Should be 3:
> -   1) bank:
> -      0: GPIO P0
> -      1: GPIO P1
> -      2: GPIO P2
> -      3: GPIO P3
> -      4: GPI P3
> -      5: GPO P3
> -   2) pin number
> -   3) optional parameters:
> -      - bit 0 specifies polarity (0 for normal, 1 for inverted)
> -- reg: Index of the GPIO group
> -
> -Example:
> -
> -       gpio: gpio@40028000 {
> -               compatible =3D "nxp,lpc3220-gpio";
> -               reg =3D <0x40028000 0x1000>;
> -               gpio-controller;
> -               #gpio-cells =3D <3>; /* bank, pin, flags */
> -       };
> -
> -       leds {
> -               compatible =3D "gpio-leds";
> -
> -               led0 {
> -                       gpios =3D <&gpio 5 1 1>; /* GPO_P3 1, active low =
*/
> -                       linux,default-trigger =3D "heartbeat";
> -                       default-state =3D "off";
> -               };
> -
> -               led1 {
> -                       gpios =3D <&gpio 5 14 1>; /* GPO_P3 14, active lo=
w */
> -                       linux,default-trigger =3D "timer";
> -                       default-state =3D "off";
> -               };
> -       };
> diff --git a/Documentation/devicetree/bindings/gpio/nxp,lpc3220-gpio.yaml=
 b/Documentation/devicetree/bindings/gpio/nxp,lpc3220-gpio.yaml
> new file mode 100644
> index 000000000000..cea2f2bb2393
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/nxp,lpc3220-gpio.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/nxp,lpc3220-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP LPC3220 SoC GPIO controller
> +
> +maintainers:
> +  - Animesh Agarwal <animeshagarwal28@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: nxp,lpc3220-gpio
> +
> +  reg:
> +    maxItems: 1
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 3
> +    description: |
> +      1) bank:
> +        0: GPIO P0
> +        1: GPIO P1
> +        2: GPIO P2
> +        3: GPIO P3
> +        4: GPI P3
> +        5: GPO P3
> +      2) pin number
> +      3) flags:
> +        - bit 0 specifies polarity (0 for normal, 1 for inverted)
> +
> +required:
> +  - compatible
> +  - reg
> +  - gpio-controller
> +  - '#gpio-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    gpio@40028000 {
> +        compatible =3D "nxp,lpc3220-gpio";
> +        reg =3D <0x40028000 0x1000>;
> +        gpio-controller;
> +        #gpio-cells =3D <3>; /* bank, pin, flags */
> +    };
> --
> 2.45.2
>

