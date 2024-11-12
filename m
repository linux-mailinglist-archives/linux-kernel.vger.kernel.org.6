Return-Path: <linux-kernel+bounces-405423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 727AF9C517A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A18C8B259FC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF0B20B7FA;
	Tue, 12 Nov 2024 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wPfNaZcj"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9ED1EBFFD
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731401300; cv=none; b=ay9+bWPwlFPXx2TzPq3/rXAdVN+23NcVBQtCC121nZI335/DPTvj9P5VZwNZonAz3f7H09YNYqUB9rO+WWOAEF8BXWbz+zDdmPSzm7CLFfLwcNoXWORk6B56CLC/rSunpEO2qDEDYevX8VgWU0UHP2Y13PSrjDWQCS2Fg+245sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731401300; c=relaxed/simple;
	bh=dxnT7wDAFkF35Sr7lpyeXzGCLbal3sDIsD+NOmbHktI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJxK/+dWOzYSCW7tfN2/6L3HP480v9z4AD1fTGQ+1Yg7D1871Dqa4WCzMymPoWBiXk8sNEmhoiM30Aw2NtAVT1vcrWG1qE/e6F/a965A0T6IONQJjEE5NYDVQeo60IQlI3va6rHQvv94UB3gKLtIjupyV87ssw6I0qQwqfJpoKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wPfNaZcj; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539f84907caso5974546e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 00:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1731401297; x=1732006097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BS4Z+JVLC+cIyIjSTxJTy/XnT+AgYmNkxO0eQSRVvDQ=;
        b=wPfNaZcjed1kn6+5hqYK1gi7mx+0b5T8B9/ZOS4t1sGSzHxHMoFWvbTSmNAb87FNvj
         2Ns/CVTqRdGGVuJktCN6BYijaPkGQGV8LI6JC0t+7bigMzAQmiX6MsowtxDjtqXKebEu
         cAMSusm0SFyYpvGOJmxi2m5fSTo6AmCdQzrSi6hDgfj8nc8xOlxSWcHK8iWXSKqedAhc
         Ga6sFrZZV5gYRF627z1ByCjJ1LE6sND/Ryaqk38dQD1Cq2zrE1xbD98BRqsuPh3dNIr5
         6vpDG4WBznZX5wY8X078tWJRQLDZiUf/khcInCEKYYtVM8SGiZZzVYPcMD0dkgeD6yWW
         /BVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731401297; x=1732006097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BS4Z+JVLC+cIyIjSTxJTy/XnT+AgYmNkxO0eQSRVvDQ=;
        b=pDyq0qFet6SC9hArqmeUotmw8X44RJE5nw4c8kgYc1UxNROM/XAIGWLVxzZdLgb4ob
         X7V7qfbgtEKNmONXWSYM4LfOiZvZ1HTyE5f0+cD6T1vcUaq1+71h1tX4JbkEab2GOxXf
         9IEiXncfIKNsRk8SnQ7Q3+Z9YmHYlDVrf31voWj6SM6gf3K47rapxzUjfBvSm5gEkV28
         98+EuFTnKirGhcRlMcpCD3zHFRuB6e/IsFMNv+CsjmN8IE1MiYAF1InbUeg+dPajjSbZ
         yn/q5pCvF1xzXZ+402ghRULWXNLb8aVYRF4lZMnyJoZqB+tm2xNqls9UTaadJaymnLud
         BNBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/QtEaQfYIFLyacFv6WOETaIs3RM6t2fZ//HZQXYZAV3D5hKsiYYN4AOm6XNFId+VmIKvX/f5n7u1XdFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcygDmgIBc5OCvFsz83j9oax1ikhjsCIJm4dCXMUf+UTWittIp
	kYUpLY4sA3EtT0Wu6qsowmXUV2BXcef2U80ww5WzmSfK+LPW9x5yn1AdwX4U6bhT/ooADEnUBl8
	U3Mss1EjeJv30lzYukl0LiPZLnp733epIWX+Tqg==
X-Google-Smtp-Source: AGHT+IFwq/t+KDsbuV2QhWwuNI5bupx1wsWOMyqz9EMw/Cb8GOHaigP3+bypOiWYwPdWO9Dvex17+Yq5iUawyDu5Osg=
X-Received: by 2002:a2e:9a0a:0:b0:2fb:3e27:cbef with SMTP id
 38308e7fff4ca-2ff201bc2c9mr64900231fa.23.1731401297361; Tue, 12 Nov 2024
 00:48:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112015408.3139996-1-ye.zhang@rock-chips.com> <20241112015408.3139996-5-ye.zhang@rock-chips.com>
In-Reply-To: <20241112015408.3139996-5-ye.zhang@rock-chips.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 12 Nov 2024 09:48:06 +0100
Message-ID: <CAMRc=MfTmpLSEUVTXSu8jf9tyTfQc=iG9NpovFem-qSDOCnagQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] gpio: rockchip: Set input direction when request irq
To: Ye Zhang <ye.zhang@rock-chips.com>
Cc: linus.walleij@linaro.org, heiko@sntech.de, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com, 
	andriy.shevchenko@linux.intel.com, tao.huang@rock-chips.com, 
	finley.xiao@rock-chips.com, tim.chen@rock-chips.com, 
	elaine.zhang@rock-chips.com, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 2:54=E2=80=AFAM Ye Zhang <ye.zhang@rock-chips.com> =
wrote:
>
> Since the GPIO can only generate interrupts when its direction is set to
> input, it is set to input before requesting the interrupt resources.
>
> Signed-off-by: Ye Zhang <ye.zhang@rock-chips.com>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/gpio/gpio-rockchip.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
> index c090cac694bf..cdfdd5501a1e 100644
> --- a/drivers/gpio/gpio-rockchip.c
> +++ b/drivers/gpio/gpio-rockchip.c
> @@ -476,8 +476,11 @@ static int rockchip_irq_reqres(struct irq_data *d)
>  {
>         struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
>         struct rockchip_pin_bank *bank =3D gc->private;
> +       irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
>
> -       return gpiochip_reqres_irq(&bank->gpio_chip, d->hwirq);
> +       rockchip_gpio_direction_input(&bank->gpio_chip, hwirq);
> +
> +       return gpiochip_reqres_irq(&bank->gpio_chip, hwirq);
>  }
>
>  static void rockchip_irq_relres(struct irq_data *d)
> --
> 2.34.1
>

This looks like a fix to me, do you want it sent for stable? If so,
please add the Fixes tag and put it first in the series.

Bart

