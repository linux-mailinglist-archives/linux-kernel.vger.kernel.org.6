Return-Path: <linux-kernel+bounces-370948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B049A341C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729401F241CA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D389C17AE1C;
	Fri, 18 Oct 2024 05:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mWxzyO2L"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559B0176AB5
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 05:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729228675; cv=none; b=qDB4Kp5U9Vi97zO3an5tNSD3EYcibjL2fVaZvYhRMdzoVtM2hyXyRaBlvXQOEo1ua9KYtHEHsyuMyShAMov3oOm9BSa6WDQyJjJT73JFPXt+Sj8jSq84c0eTikBbe4WHvgA1NQlpwTqtWMw2HUkw1ogKpkyIG2YXjXtI0iEaN/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729228675; c=relaxed/simple;
	bh=Ho77DWHTdyRsuxsI6uPuILsTlNEgmwNqA2rOsdSxdZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ABQv5NwseJS5eKyQOTQllrHQ2N6qRAY6RyvvW90GEfH2O0kD6dLiv6vMF1JOr4ckXpz92nk3RX6VhPFCY0EyYKGaQHCg1CpAwg3DMx8xLATaZvbmlDdZsfcvlop8fqai2JblBy7FnPIItqihJ/AM/t5Ulc0soxwADXXV11x9X4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mWxzyO2L; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e1543ab8so2981898e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 22:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729228671; x=1729833471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fb5KpeBreuXFeJ6C2dlxdkF/AtWXYD7eWJb+jZNVASw=;
        b=mWxzyO2L0iKrU+M7qgs+jId5Juyu4kbkk8MfWKFM8uC7G40UWvVEzIl+/gyrQvKsKH
         ZXCDIdY3Kz/aCIxLObN15K+jlkQwgiL4N2gV1FRETwcp81jAnCdTFc/akwl/Hb18yydT
         rrfXc+V/MCQdoUTWmgnxUqUAaO+9OhR+C0FX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729228671; x=1729833471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fb5KpeBreuXFeJ6C2dlxdkF/AtWXYD7eWJb+jZNVASw=;
        b=b68FRel5NqnB6vj97HePtlcfvPHss0Sis+uyEWPuR8zIk5ufeGYzxU4M6CRzQRTo4m
         beZzYv2GQpPHKiUFXfybes84pv9q3WE+UCWrv1O6NX25oazJKa3ZGuoHdve3ekRBYlM/
         zOt/5Ux7vHN/hJFbvbLh4RQel1bl1xX62Mgn2tqGoBei+VzAvoEIqKU1DUihMhWZ/R4u
         I4dd8WyjvL0mc39kjVcn9sHXgAAU1vTRfusprFEiygxnMx660TsPl19n0xhHNK0K7X5M
         Nxxjq2Ue+9b9CT/7MnRpqCwfB8WxsPF2CaZrJMXINFGXnZYdwGrpOxpLIleQ+f0dMNy/
         DvmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc577u1NLmfnEuhfx+rrUk5EgHf0QGV9rurQyxJnaM++ho8z9/AC9JEYE7nX0roP47GG8rqNkQlKo+NiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxnMelhFehCKAvDFLEOf+K4I0APFaO6CbRxrNUm94uoXVuJRjL
	oI5Jx8Tgjpj1wdiDmo6JOBLjtdj1TGH/Vd81yw3iKxdCMeQC6OjVpZ4JDCreMySSylFsmMWota5
	/gY9hJBDHXlmzm2XQGsx0oPhLcX5fobQm+clq
X-Google-Smtp-Source: AGHT+IEMrNDmylr1CfjI1xQ5P74wl/iIOo4f+1YA243FTpzmnuRjnMreynnJtzQcXTFfSx2gj46cObeu9tjEebZJfM4=
X-Received: by 2002:a05:6512:104f:b0:533:4497:9f29 with SMTP id
 2adb3069b0e04-53a154704d2mr806562e87.31.1729228671134; Thu, 17 Oct 2024
 22:17:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017091238.180920-1-bo.ye@mediatek.com> <20241017091410.181093-1-bo.ye@mediatek.com>
In-Reply-To: <20241017091410.181093-1-bo.ye@mediatek.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 18 Oct 2024 13:17:40 +0800
Message-ID: <CAGXv+5ESMm3t_kJckubDf4jMLYehz66o8B42sTTM=vEF1WMpCA@mail.gmail.com>
Subject: Re: [RESEND. PATCH v1] pinctrl: mediatek: paris: Revert "Rework
 support for PIN_CONFIG_{INPUT,OUTPUT}_ENABLE"
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

On Thu, Oct 17, 2024 at 5:14=E2=80=AFPM Bo Ye <bo.ye@mediatek.com> wrote:

Please avoid sending more than one version per day. Most people in
the community are not in the Asian time zones. Give people time
to respond.

> [This reverts commit c5d3b64c568a344e998830e0e94a7c04e372f89b.]
>
> For MTK HW,
> 1. to enable GPIO input direction: set DIR=3D0, IES=3D1
> 2. to enable GPIO output direction: set DIR=3D1, and set DO=3D1 to output=
 high, set DO=3D0 to out low
>
> The PIN_CONFIG_INPUT/PIN_CONFIG_OUTPUT/PIN_CONFIG_INPUT_ENABLE/PIN_CONFIG=
_OUTPUT_ENABLE shall
> be implemented according to view of its purpose - set GPIO direction and =
output value (for
> output only) according to specific HW design.
>
> However, the reverted patch implement according to author's own explanati=
on of IES without
> understanding of MTK's HW. Such patch does not correctly set DIR/IES bit =
to control GPIO
> direction on MTK's HW.
>
> Fixes: c5d3b64c568 ("pinctrl: mediatek: paris: Rework support for PIN_CON=
FIG_{INPUT,OUTPUT}_ENABLE")

As Macpaul mentioned, you changed the commit message by adding a tag, and
thus this patch should be marked "v2". Please also provide a changelog
on what changed in this version in the footer, i.e. under the "---" line
but before the actual patch context.

ChenYu

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
>         case PIN_CONFIG_INPUT_ENABLE:
>                 /* regard all non-zero value as enable */
>                 err =3D mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_IES, !=
!arg);
> +               if (err)
> +                       break;
> +
> +               err =3D mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DIR,
> +                                      MTK_INPUT);
>                 break;
>         case PIN_CONFIG_SLEW_RATE:
>                 /* regard all non-zero value as enable */
> --
> 2.17.0
>

