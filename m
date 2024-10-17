Return-Path: <linux-kernel+bounces-369472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3139A1DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C651F2221D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EC9762EB;
	Thu, 17 Oct 2024 08:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hhttywN8"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8521D6DAA
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729155536; cv=none; b=TnlwuJSf8DWb14RsR8fFFTT/X7H/3oUD574kZ8fOt/NGoM+W106Zl80igj9foUUUL+MCPey9MvlWGyB32qN7OBXiD5uzZb3WqyPGaJmOIoXDnHnN+ECalg/mX4jT4zQVQcuwi0Ywe05H1LAMo45uGOht2l/7BXVdJmZHFdRmEpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729155536; c=relaxed/simple;
	bh=sfb7bUi4od8neIwegvIlefSvXPj8ArVh68UTqxXQHeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAZ7/iuxSJgCLoidU4TO55r+7pvFIbB17cbugKlCYFD+vH5D0Yehc1tj2172rE7wiMaRAogTU3vw/fH5yrouGsTexsX+ogCGbTBiVYPY4JQvHNP/Bn3xt4ukWMicIpZv7LhMUrqFmI1INmGQ6sz5kmKcMbWjw3zpeLSOvZsDHMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hhttywN8; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso717774e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 01:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729155531; x=1729760331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zRM9EoMz8GkgMmNdxpc70pbXD7mbvlXQ9Z0MoNkt/Q=;
        b=hhttywN8nHIbbe48dex/+8ABcL6cpnwxMTTzfwQNMp/mOp6VdbYxdjO7n22E++fST3
         K2aOPwsu06HvW+HYZaRt/LVUpNZZISPpozMIDfVrRPXUfTAzflZPruoQ/NQJmpfnRQ25
         lR0UokSid6FWKkRVGJDTVDAhilLO6OnFXse7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729155531; x=1729760331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zRM9EoMz8GkgMmNdxpc70pbXD7mbvlXQ9Z0MoNkt/Q=;
        b=dFeOtijwtWHRBabHyxvoHOJGIKOboEidBRmbUtr0MIFKBzHvp0gHI/Cz1QgMGB+Izx
         xc6OF1MmcslzFhWjqQ91LYekxgQtf1JmShhDV1OOloxch7o+XFWDWsjQO9Gx7+qZWG9K
         bf3CB2NO3q+IgkelK88NADe9ZTqTjV9jANlBRH7QUXAqxmSb4JOM61+++wyFwDNCncA9
         5+qhM2OIWyNIcI9LMAsNMghJc775Mas93hKNfgELZecHSS06EI/GPu0xTZA3YP6SwML6
         wVsWwVJW9N5oohQZ7TP8+gaOdrZLrCROUBH7X/CwuFiWAeGFzbg0Js4aUd9NyBsjm++c
         l5SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGK3T5wkzkHN1QaHoFJ7WO84jrVr5HOY4PMVd7MluemRfdYvsoLyO52mGia4BdP55NQWzKmwhWORK/IK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqmYZzHAbJ5Bi74ehoW0hfPK7Z4ogsMWksigoE4W45KJ+Rp+Og
	TuBWE/rXPaYxYg0xrMSbjjJU8ZJkcO8twu1bd25sSMvoswaE93Nzn8K0hSeYJ2IBAZSnIShoVGo
	tU9C+IEHvjO1bW5dm36MQtTOD1KgGZ2g7Bo2O
X-Google-Smtp-Source: AGHT+IEBDemRIM9FCfeg0ySLERoVJekwSTOsN+i71w3vQ46v+1urNQBGt6t68MLpvYzLAlc+A68seIBeOTQwNt9A6Ss=
X-Received: by 2002:a05:6512:10d1:b0:532:c197:393e with SMTP id
 2adb3069b0e04-539e54d7ba7mr9397189e87.11.1729155531218; Thu, 17 Oct 2024
 01:58:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017075522.178337-1-bo.ye@mediatek.com>
In-Reply-To: <20241017075522.178337-1-bo.ye@mediatek.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 17 Oct 2024 16:58:39 +0800
Message-ID: <CAGXv+5GnKX+kkYwuqJ2V_1GkgQOfWZgS=MSy5pfiBDo=X4d+mA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: paris: Revert "Rework support for PIN_CONFIG_{INPUT,OUTPUT}_ENABLE"
To: Bo Ye <bo.ye@mediatek.com>
Cc: Sean Wang <sean.wang@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Yongdong Zhang <yongdong.zhang@mediatek.com>, Xiujuan Tan <xiujuan.tan@mediatek.com>, 
	Browse Zhang <browse.zhang@mediatek.com>, Light Hsieh <light.hsieh@mediatek.com>, 
	Evan Cao <ot_evan.cao@mediatek.com>, linux-mediatek@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 3:57=E2=80=AFPM Bo Ye <bo.ye@mediatek.com> wrote:
>
> [This reverts commit c5d3b64c568a344e998830e0e94a7c04e372f89b.]
>
> For MTK HW,
> 1. to enable GPIO input direction: set DIR=3D0, IES=3D1
> 2. to enable GPIO output direction: set DIR=3D1, and set DO=3D1 to output=
 high, set DO=3D0 to out low
>
> The PIN_CONFIG_INPUT/PIN_CONFIG_OUTPUT/PIN_CONFIG_INPUT_ENABLE/PIN_CONFIG=
_OUTPUT_ENABLE shall

Of note, there is no "PIN_CONFIG_INPUT" option.

> be implemented according to view of its purpose - set GPIO direction and =
output value (for
> output only) according to specific HW design.

I disagree. The PIN_CONFIG_* options have proper meanings defined in

    include/linux/pinctrl/pinconf-generic.h

that every driver implementing the generic pin config API should follow.

For PIN_CONFIG_INPUT_ENABLE:  enable the pin's input.  Note that this
does not affect the pin's ability to drive output.

Note the latter sentence. When you say set the direction of the GPIO
function, it clearly affects the pin's ability to drive output.
Similar argument for PIN_CONFIG_OUTPUT_ENABLE.

My understanding is that PIN_CONFIG_INPUT_ENABLE and PIN_CONFIG_OUTPUT_ENAB=
LE
are _not_ for setting GPIO function directions. Another angle to think
about it from: if the pin _was not_ muxed to the GPIO function, this
kind of does nothing in terms of the function of the pin. It still
continues passing signals for whatever function it is currently muxed
to.

> However, the reverted patch implement according to author's own explanati=
on of IES without
> understanding of MTK's HW. Such patch does not correctly set DIR/IES bit =
to control GPIO
> direction on MTK's HW.

Can you provide a correct and detailed explanation then?

MediaTek's datasheet says _nothing_ about the hardware implementation
details or how it's supposed to be configured. There's just a diagram
showing the hardware, which seems to be a closer match to type A as
described in "GPIO mode pitfalls" from Documentation/driver-api/pinctl.rst

Neither does the upstream binding say anything about using the generic
pin config properties with MediaTek pinctrl devices. The original commit
adding this driver mentions "add pinctrl-paris that implements the vendor
dt-bindings", vendor bindings that don't seem to say anything, at least
not the upstream ones.

The generic pin config binding however *does* clearly describe what
each of these properties mean. See

    Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml

For example:

    input-enable:
      type: boolean
      description: enable input on pin (no effect on output, such as
        enabling an input buffer)

And

    output-low:
      type: boolean
      description: set the pin to output mode with low level


If the hardware has some quirks or limitations, such as the SMT bit
can't be set when the GPIO direction is set to output, then that
should absolutely be considered, fixed and *properly documented*.


So what exactly is the breakage you are seeing? What options were
used in what scenario? What is it intending to do?


> Signed-off-by: Light Hsieh <light.hsieh@mediatek.com>
> Signed-off-by: Evan Cao <ot_evan.cao@mediatek.com>
> Signed-off-by: Bo Ye <bo.ye@mediatek.com>
> ---
>  drivers/pinctrl/mediatek/pinctrl-paris.c | 38 +++++++++++++++++-------
>  1 file changed, 27 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/m=
ediatek/pinctrl-paris.c
> index 87e958d827bf..a8af62e6f8ca 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-paris.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
> @@ -165,21 +165,20 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctl=
dev,
>                 err =3D mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_SR, &r=
et);
>                 break;
>         case PIN_CONFIG_INPUT_ENABLE:
> -               err =3D mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_IES, &=
ret);
> -               if (!ret)
> -                       err =3D -EINVAL;
> -               break;
> -       case PIN_CONFIG_OUTPUT:
> +       case PIN_CONFIG_OUTPUT_ENABLE:
>                 err =3D mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DIR, &=
ret);
>                 if (err)
>                         break;
> +               /*     CONFIG     Current direction return value
> +                * -------------  ----------------- ---------------------=
-
> +                * OUTPUT_ENABLE       output       1 (=3D HW value)
> +                *                     input        0 (=3D HW value)
> +                * INPUT_ENABLE        output       0 (=3D reverse HW val=
ue)
> +                *                     input        1 (=3D reverse HW val=
ue)
> +                */
> +               if (param =3D=3D PIN_CONFIG_INPUT_ENABLE)
> +                       ret =3D !ret;
>
> -               if (!ret) {
> -                       err =3D -EINVAL;
> -                       break;
> -               }
> -
> -               err =3D mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DO, &r=
et);
>                 break;
>         case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
>                 err =3D mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DIR, &=
ret);
> @@ -284,9 +283,26 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctld=
ev, unsigned int pin,
>                         break;
>                 err =3D hw->soc->bias_set_combo(hw, desc, 0, arg);
>                 break;
> +       case PIN_CONFIG_OUTPUT_ENABLE:
> +               err =3D mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT,
> +                                      MTK_DISABLE);
> +               /* Keep set direction to consider the case that a GPIO pi=
n
> +                *  does not have SMT control
> +                */
> +               if (err !=3D -ENOTSUPP)
> +                       break;
> +
> +               err =3D mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR,
> +                                      MTK_OUTPUT);
> +               break;

Looking now, the device tree bindings don't even allow "output-enable"
or "output-disable" so the PIN_CONFIG_OUTPUT_ENABLE condition won't even
ever get exercised.

So I don't know why this section even exists. At least this part of my
patch was correct.

>         case PIN_CONFIG_INPUT_ENABLE:
>                 /* regard all non-zero value as enable */
>                 err =3D mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_IES, !=
!arg);
> +               if (err)
> +                       break;
> +
> +               err =3D mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR,
> +                                      MTK_INPUT);

FWIW the implementation is also slightly wrong in that it is ignoring
the argument. If the DT specifies "input-disable", then what happens
is you get PIN_CONFIG_INPUT_ENABLE with "arg =3D 0", but you still set
it to the input direction.


Thanks
ChenYu


>                 break;
>         case PIN_CONFIG_SLEW_RATE:
>                 /* regard all non-zero value as enable */
> --
> 2.17.0
>
>

