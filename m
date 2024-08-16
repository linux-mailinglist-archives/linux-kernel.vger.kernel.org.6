Return-Path: <linux-kernel+bounces-289439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F7295463B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373401F22B75
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25E316FF48;
	Fri, 16 Aug 2024 09:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0kiyosmJ"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6280216F8FD
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801911; cv=none; b=AoyZ8acnjqKIl4OQJmvatYvz/p6XeDYmLEXY0uT0Oke7jsKc2EEIyl2oVhNa6usd6DIs9V7a/hiXvt4SCj0bJsfRYL3+kl9FTfNlM4IwFwOCD0QiIt2O45aaSmyJ386Sa01JLsvtAfoMbVGR+2Ni1BhTA9nHnvcTOBo+vJRLNzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801911; c=relaxed/simple;
	bh=N5SOTibYb8uwB+hX5O6pWKCoAiqG29BgRMDtN0JxNGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNsWOHUP/j/mBstniMZjzX0E+99L6zl0h+6lGgL1Rpx+zvHSZcWMnRB/I5LPdXzOFlDqlalg/KFOOpttyG2gWCnVlcbFdMT2IBu5rCYOxpHDlDCb/NwqPjRnRoDygh9ORwosHskfRcwDnP50Go7owvnkd9DJsrQ2CL9n6mscz6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0kiyosmJ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52f01b8738dso1700426e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723801907; x=1724406707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZKQ9SGEFFZ7Ozck5+ma3O19D5pAx2pPSfe4wqt41Z0=;
        b=0kiyosmJQhhscxLIUgijXnkNeV11Uja2D3nBMfqvifUPtlsXj4o7mBy0N0ReaizES7
         KflHtUZgGb4uFMOZ/LQ6sRDaQobEMsXI1FaOnm9Rt5vKyD7f9npq3HzyX2pQcAkb6CoC
         bnuWxAbxFeBQJ9v43I9+vSlPNxnN8nEIPhSPbbfOgHS6IIyRNi/OfrX74QnCZfXlS7x4
         41oe5J18bgcg6kCluPoXsIQ+YjtZ+4GRvpbyRZPJ+Y8LJN1l78gScVJJutIahmxTlht0
         mYj1I1FPnWg6MbfigW9WFEfov+moWSqEoLaCkQZQ+ynchXAmiB75qCB9RG5zbAFeyJmr
         1ZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723801907; x=1724406707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZKQ9SGEFFZ7Ozck5+ma3O19D5pAx2pPSfe4wqt41Z0=;
        b=KgHdbrooqdWca//X+X4kp7QlTtx/F+O35zXR5Wtc3MPTWjcmTnqfayBAtn8wDdIVdy
         I8fO6eXmCIpnzTjAIVW6RHw1k+aAtn0oX+x74jCJWqWEf3YSCz4SO1q4C/Ucqclxj2mC
         TEx/emYpSaCBdzKoR3rKI/19DFV/+qDonPaeUSRztNHWcS9UGvZVle1PI8IpugtwxfuW
         L1k4dOKa5g/irmi9+exwNX0QxBpIvufMwxNPNXbkwDBGi1CUuHhouCmouXJXqz83UabD
         oZQEnejSeJUuUftnjC+THL3Hp7st5/JV85onURCgH0dV1IVh9ekFJKFZOVPyLuN4bbXt
         aVmA==
X-Forwarded-Encrypted: i=1; AJvYcCW+tV8CH89t2/GyVNPsAeypUFBOnRYQEW3kS/thg96ivBPy4DsFyOOq0y0q/aZh0Gz0l6RdJoLNrnt8cAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN9OLZ/TB8fXmArNmP4S22e6stouQvnGYc/HRRMClob1dAunZt
	JEwxqU65ju89A2rwXrm53bAo2+1XyvFo9jeN0IEkCFBFToWxXaZW2nQkx2N0KPUiZIhdUsDu+Gt
	3lE80//dk+61nP319vtPovi0dEpivPLrdu5Wruw==
X-Google-Smtp-Source: AGHT+IFvf4NVVwAMYnNZ7wUfCDLw1BETNHu6+3V8GBs5LuzbFRx9yZcyI3xlLzEbUp13L+Uf5Nt/CA8AsBf32lrvGWw=
X-Received: by 2002:a05:6512:3e09:b0:52c:82fa:ef7b with SMTP id
 2adb3069b0e04-5331c6dc2e5mr1455045e87.44.1723801906649; Fri, 16 Aug 2024
 02:51:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815071651.3645949-1-ye.zhang@rock-chips.com> <20240815071651.3645949-5-ye.zhang@rock-chips.com>
In-Reply-To: <20240815071651.3645949-5-ye.zhang@rock-chips.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 16 Aug 2024 11:51:35 +0200
Message-ID: <CAMRc=MdjazVyck=KDqs-zUVwzzRhFFF7e4Gh5Sk9LYzv5am2pw@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] gpio: rockchip: avoid division by zero
To: Ye Zhang <ye.zhang@rock-chips.com>
Cc: linus.walleij@linaro.org, heiko@sntech.de, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, tao.huang@rock-chips.com, 
	finley.xiao@rock-chips.com, tim.chen@rock-chips.com, 
	elaine.zhang@rock-chips.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 9:17=E2=80=AFAM Ye Zhang <ye.zhang@rock-chips.com> =
wrote:
>
> If the clk_get_rate return '0', it will happen division by zero.
>

This looks like a backportable fix. Please add a Fixes: tag and move
the commit to the first place in the series so that it can be sent for
v6.11 and stable already.

> Signed-off-by: Ye Zhang <ye.zhang@rock-chips.com>
> ---
>  drivers/gpio/gpio-rockchip.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
> index 8949324ed816..03e949b0a344 100644
> --- a/drivers/gpio/gpio-rockchip.c
> +++ b/drivers/gpio/gpio-rockchip.c
> @@ -212,8 +212,10 @@ static int rockchip_gpio_set_debounce(struct gpio_ch=
ip *gc,
>         if (bank->gpio_type =3D=3D GPIO_TYPE_V2 && !IS_ERR(bank->db_clk))=
 {
>                 div_debounce_support =3D true;
>                 freq =3D clk_get_rate(bank->db_clk);
> +               if (!freq)
> +                       return -EINVAL;

Newline here.

>                 max_debounce =3D (GENMASK(23, 0) + 1) * 2 * 1000000 / fre=
q;
> -               if (debounce > max_debounce)
> +               if ((unsigned long)debounce > max_debounce)

This is a separate change, please put it into a different commit.

Bart

>                         return -EINVAL;
>
>                 div =3D debounce * freq;
> --
> 2.34.1
>

