Return-Path: <linux-kernel+bounces-512475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27046A339BD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF7C67A3C24
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881EA20B7F9;
	Thu, 13 Feb 2025 08:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MuPfC2eB"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A88620B21D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739434434; cv=none; b=Rgp+gios1QJxM1g4cgXh0J9I01Jhspa83Fk5EL5mMIe6RSYWbDRx2HdZzmWZPDYeR4Rk+UJaipEngYO7Y5n6YoZTT0jBFii0moY1rrgtuIHknyJ0FwhtijGAQvlKuzol7wwyMfJw0RuyGDmh4KmItpTSWY6dq9NHyjgNALVUsIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739434434; c=relaxed/simple;
	bh=5vZT6XRac5Sw20P5sZfV62hmlC+ZCKjlScO/x0rmuYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YELU/cSG3fFldAWZ6+eeHxRXMAatIH7xuBqylB40HC3tVTTCoJ0c3FXGycRWYBDbf227v9PKXOd5K+yYouHD9fm8g5qwzNZWUsm9RwaL/Royqv6U4M90czMegNPo7ZOsGHCaGNlxapjYGFSC1aJwRQEZTxurgtdtm2Es4XuImn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MuPfC2eB; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5439e331cceso648087e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 00:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739434430; x=1740039230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmuftgvnuZZgHkOz1gVQFljvkOd+vXnZycbJ9gQVvqU=;
        b=MuPfC2eBtclF0qE37TC0SpGor6eDz2lSUe8rO0GVTTfYif83qkpx6GrhETOgzLSxQi
         7mic9a/GLNqxjkNe2mO37hv+8xEpFxeqpL9vCnlHAJ1cZjMfOXDNSaK+WAngWmPAOkd8
         72sT3ZY2S67U5S3fmV4w6EaTs3tBYzcQWePUwbSDYfPmda5Cmd2K0+VkTaH7D+m+vYVk
         YsBTZJWKbUMh9O9oxKMJsfVZOZzr5lwGQsPLpIjk8yu8omv6OAm93yiKDOrQkOvftj1W
         pyl+/iCX4vJxJE7FOCIk3aJVU5Vk7u8wN+RpNlp7Q1HNig7PbE56M7kGkogI4QauqqKT
         tMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739434430; x=1740039230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmuftgvnuZZgHkOz1gVQFljvkOd+vXnZycbJ9gQVvqU=;
        b=vSlsEVmMwDMBeF5ieBMWwjRCr7klYukKyHjfzDY9Nud4vfrkRUUH03FSECBCHVa6D+
         14OQiJEd9NS6MINSHbgBbplujWsIKo69izN0bnNW7cnQOIkhC96GAlJjTBuJkmf04xOA
         kEouPQYUTNLQS7m+nj/7kEfhseted0PlrIFFMh387luWOy7WbtF+VnSC2SsUYGKx4bid
         g2klwknrs0LbfpVej9ktIayH3cy6uNzwCoXIHqfez1fIrpPdc+cpkN15blrBIBAtCqzZ
         2e14rSl1ngmN7l3y9X16nvXMYDGYWO9SH3cPguvMLcWYI1iXrT4kHoVemtgfX3BaJB3E
         X2oA==
X-Forwarded-Encrypted: i=1; AJvYcCV26uKdMU5Ve225g1rdwv4RUxVRzLll+UHQwpmfapcr9QO7X1dLhSna2rv6QKk4qoGMeqtt0ENAbKjpdZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXaCubqdYkvIl40mV0VzvZFJTWo5SCknK5JBdrVkSO/WG06hZs
	59YodvxLIihOLyOfXFdi0zcEkrf8gtqyavwk8u0CXQV+6wjehKTzKqK4nb0qPLRAgpRQk8oj5Yz
	5d85PsdeO7GR9Uri1/hh8vCYgpOnptTDx/xar
X-Gm-Gg: ASbGncvQaGmeUsNdQvZQzkhUfs6EIaqppm71Pr4bgl+KOpvGZwcY11kFpx8MuV3fxjq
	wixrKIpHHse7yMTajOB9wDJOKiBLpN1wYfq3gupGMES2/uA8TlS/1M0E2hwNM3/sgQ0bwin8=
X-Google-Smtp-Source: AGHT+IHxDaK7ENYXtLhPy5Kf93LWj2N5S6iojG3fU8e+7THrJ3l9WM1h9CK9jmfpQxgM8xkKRYjCh9V5QtuuPWJHPGk=
X-Received: by 2002:a05:6512:ac7:b0:545:646:7519 with SMTP id
 2adb3069b0e04-54517f86d1fmr2003992e87.0.1739434430158; Thu, 13 Feb 2025
 00:13:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120-scmi-fwdevlink-v2-0-3af2fa37dbac@nxp.com> <20250120-scmi-fwdevlink-v2-3-3af2fa37dbac@nxp.com>
In-Reply-To: <20250120-scmi-fwdevlink-v2-3-3af2fa37dbac@nxp.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 13 Feb 2025 00:13:13 -0800
X-Gm-Features: AWEUYZns82i0k5Ijag1LujAqT5WjKXUA5FWo3NR6_9wBOcWaDsE90ePdb8ZFdME
Message-ID: <CAGETcx9+BzSoHj54koiGniUOUPfY9yZ9cAedbb2A-hb+2D1sGw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] pinctrl: freescale: scmi: Switch to use machine_allowlist
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
	Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, imx@lists.linux.dev, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 19, 2025 at 11:14=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> With machine_allowlist, only allowed machines have pinctrl imx scmi
> devices created. The fw_devlink will link consumer and supplier
> correctly.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/pinctrl/freescale/pinctrl-imx-scmi.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx-scmi.c b/drivers/pinct=
rl/freescale/pinctrl-imx-scmi.c
> index 8f15c4c4dc4412dddb40505699fc3f459fdc0adc..058b4f0477039d57ddae06f38=
5ad809cbb4784d6 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx-scmi.c
> +++ b/drivers/pinctrl/freescale/pinctrl-imx-scmi.c
> @@ -287,11 +287,6 @@ scmi_pinctrl_imx_get_pins(struct scmi_pinctrl_imx *p=
mx, struct pinctrl_desc *des
>         return 0;
>  }
>
> -static const char * const scmi_pinctrl_imx_allowlist[] =3D {
> -       "fsl,imx95",
> -       NULL
> -};
> -
>  static int scmi_pinctrl_imx_probe(struct scmi_device *sdev)
>  {
>         struct device *dev =3D &sdev->dev;
> @@ -304,9 +299,6 @@ static int scmi_pinctrl_imx_probe(struct scmi_device =
*sdev)
>         if (!handle)
>                 return -EINVAL;
>
> -       if (!of_machine_compatible_match(scmi_pinctrl_imx_allowlist))
> -               return -ENODEV;
> -
>         pinctrl_ops =3D handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PIN=
CTRL, &ph);
>         if (IS_ERR(pinctrl_ops))
>                 return PTR_ERR(pinctrl_ops);
> @@ -339,8 +331,13 @@ static int scmi_pinctrl_imx_probe(struct scmi_device=
 *sdev)
>         return pinctrl_enable(pmx->pctldev);
>  }
>
> +static const char * const scmi_pinctrl_imx_allowlist[] =3D {
> +       "fsl,imx95",
> +       NULL
> +};
> +
>  static const struct scmi_device_id scmi_id_table[] =3D {
> -       { SCMI_PROTOCOL_PINCTRL, "pinctrl-imx" },
> +       { SCMI_PROTOCOL_PINCTRL, "pinctrl-imx", NULL, scmi_pinctrl_imx_al=
lowlist },
>         { }
>  };
>  MODULE_DEVICE_TABLE(scmi, scmi_id_table);
>

Definite NACK to this. Please don't depend on indirect
conditions/flags. There's no guarantee that this check will hold true
in the future.

-Saravana

