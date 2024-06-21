Return-Path: <linux-kernel+bounces-224809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC7A91271B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E006283B72
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D2F1C14;
	Fri, 21 Jun 2024 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="XHsI+mre"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D12186A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718978387; cv=none; b=CTmi8M+v9QnB/LsdvTtFN3pZBMJLO9Z6unKo1GKn7Za+3Qcm1TpPXpZibJljcyc8DDYyd44IcwwAx2Ms+kfk8g6rjaBFd6I+MrkD8wjEbbdT324GivscGXsk1V64xKyOu9NbkOqajNS7lQllLZ1JAnOJz5hCz9uT+NRBkaJrlJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718978387; c=relaxed/simple;
	bh=FZYuR10D3WxYTlWhA72cyRk2pMy6zS8D3yx7lj0lctw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZW9eOzIVoFPM1usQGO8UZ2geJuAPByuxVK2V6R4hDb9aUalNK+5OjCkPOvIL69IA2tiCLNXU9UQNtBwEun5XPmJIBxsv23pxI/gzmqjZ34cFC5SxzBR+9gjWqtZcaWqX8TMgh6ozEYK97uVMg0t+2iwrRKrN5tQs9oqxmbeErcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=XHsI+mre; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52c4b92c09bso2845200e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718978384; x=1719583184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9o75QltN1QiHAAa6uL1Tv0SbyB0F3wn6OTH/+H2NLk=;
        b=XHsI+mrea6CkAzeapGubED2x4YTCN4JljbHp0L/1f7ExpOSXKlpSm7C5upB6HKjYU7
         lMv+Yl7/aeMjO2B0SkzWsgRBZLFdVavTfNFW0Es88bX++hKpGulyI8P1wsNqsknVt1cx
         e9Iw3E9MHo1IW/aLpzhaD8KUjNG28S053sVANHPHRhqXcmvq17M1N+h2jCIK4lwr5R8N
         BVrk784Iei5BpMPlEYOFdj9qdUUNDnI+L+KDozTEDaSQJLN5UvufUvpg6Ix6J17L2uJK
         xIoMGd4wpMzRW+D6PwO7ZVIbEfE8Hm6YFEz+ilW2HK8fKyQgYfi13T+FdODH3h8erftP
         efmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718978384; x=1719583184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9o75QltN1QiHAAa6uL1Tv0SbyB0F3wn6OTH/+H2NLk=;
        b=CPq5YGmwX9OV0TOvSRNWs3qF/L5uhbZZ6k/wihQcVCLOn6Jxfyp6mGRBuBao30/aXa
         czkJRcJu6PpT79G38mBx53tCK/y2dHe+8992+2E9sECL0w1nsp4HWx4btbHc359HH6u1
         pAgSESMYSPILIw0tBHpk6vmiOD5BsltraZl4NMBp8StyYcknnvmJK6p2GW4tmQ9ciT7r
         BVAz0caAR9wjUfVm+21L97M/a6THv3C2JWxwV2DSX5YV6QjWTKcDoPq4bxuoKS0095cM
         eQYydqvVXjIQ5qLje1BrM1qLGJBqVtt93GEGXySpU71BcZ2Vks6UNAOKk8HJZ+03bUYh
         375g==
X-Forwarded-Encrypted: i=1; AJvYcCUQ8uqG4ZJn2GCjYrfeQwWzQ23gXDbOvj/yoCmRAN26U9pPO8yvZAAD1GRha/R8kPP4ZbNcPe/ECsfBdYM0tkBJJjUdX8TUVFk1kSDx
X-Gm-Message-State: AOJu0Yz8co0jdvyP9BEyeH4qRLcUSHkPK2jHZf7UrmSt7sW89mGysGd1
	vxBq6NrcS3zmm3YrDSjVxablcUXdPbPx96EjhqUrL9geRTBuz75k9pHHbPdM3G0xzEUImYPmuQG
	d2jqptMpP3j7g2C4uskmYYL8k5Wn+XLimyR7HJw==
X-Google-Smtp-Source: AGHT+IEoK/OVfXsccAiGXwUvTPgQ52p+TiJ9oX6eFqWuApRKUphFPSrr58bci/V9aJZ459iRSeF82xV5dmH+pw6OQH4=
X-Received: by 2002:a05:6512:3988:b0:52c:cb8d:6374 with SMTP id
 2adb3069b0e04-52ccb8d6456mr7618391e87.11.1718978384534; Fri, 21 Jun 2024
 06:59:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618144344.16943-1-amishin@t-argos.ru>
In-Reply-To: <20240618144344.16943-1-amishin@t-argos.ru>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 21 Jun 2024 15:59:33 +0200
Message-ID: <CAMRc=Me5R+YLmx6mh_mfszRj7TKx25cL9Vx3J-7mvRTuat8Puw@mail.gmail.com>
Subject: Re: [PATCH] gpio: davinci: Validate the obtained number of IRQs
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Keerthy <j-keerthy@ti.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Grygorii Strashko <grygorii.strashko@ti.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 4:45=E2=80=AFPM Aleksandr Mishin <amishin@t-argos.r=
u> wrote:
>
> Value of pdata->gpio_unbanked is taken from Device Tree. In case of broke=
n
> DT due to any error this value can be any. Without this value validation
> there can be out of chips->irqs array boundaries access in
> davinci_gpio_probe().
>
> Validate the obtained nirq value so that it won't exceed the maximum
> number of IRQs per bank.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>

Why not Reported-by: ?

Bart

> Fixes: eb3744a2dd01 ("gpio: davinci: Do not assume continuous IRQ numberi=
ng")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>  drivers/gpio/gpio-davinci.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
> index bb499e362912..1d0175d6350b 100644
> --- a/drivers/gpio/gpio-davinci.c
> +++ b/drivers/gpio/gpio-davinci.c
> @@ -225,6 +225,11 @@ static int davinci_gpio_probe(struct platform_device=
 *pdev)
>         else
>                 nirq =3D DIV_ROUND_UP(ngpio, 16);
>
> +       if (nirq > MAX_INT_PER_BANK) {
> +               dev_err(dev, "Too many IRQs!\n");
> +               return -EINVAL;
> +       }
> +
>         chips =3D devm_kzalloc(dev, sizeof(*chips), GFP_KERNEL);
>         if (!chips)
>                 return -ENOMEM;
> --
> 2.30.2
>

