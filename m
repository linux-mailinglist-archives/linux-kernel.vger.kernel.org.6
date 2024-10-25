Return-Path: <linux-kernel+bounces-381141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069A09AFAEC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9C328150D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5077818D655;
	Fri, 25 Oct 2024 07:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="NNeY31bl"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6A41B393A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729841159; cv=none; b=ariMZkxmtOQBjowE8SNEbczRHWIEUty97yOcFxJQ0RzsmfHl/oX3hGfdLYlbk67rwC5tghQ2hXc4koCy9si0oMOpgE3TcU/OsQ6kF5BLp3fp37jhPMJ301XUre0R+U9cQZzPns8UxD2dqv7a/7TpDVGL1+uIsiQmQzpcMGywpVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729841159; c=relaxed/simple;
	bh=JFKQGkzoJxF/22a+VPfGsDNqyIxoXEnmvkJ4rlwJMjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RaETRrz8D+3Y517igiSkC7l5CHQ97txvqqc3zcQEJJf7dau88tMlJRKDKXYpj/NazS6l7JKHEXRT215dF9qAo+JDp/1Jbw6cHdprXkZHbeJ8BOmPLoIPo+ItdZuQmvDi/gqHZnNRxhrv3HGZ9aOkeJiaHV4Hi9gh93qUQ7/DYTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=NNeY31bl; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f72c913aso2239864e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 00:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729841156; x=1730445956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4g2gos01gcs3ARV9xOeM9xEQeRnKHcL1K/otT/YNFqk=;
        b=NNeY31bl4CL2K6eVfkF1QUcrwIsdwetHupudcq1NrtSEIpvRZNIh1eB4CvvTDihQ5T
         5KfclZk74AGwF6XpUfSJGhPA3PUHZ+nMAM36koKuHvtBdS8Vne6x1xGmEEBp12LV2Eje
         VEKSxfMB8x3Yy9cqGKK0fNqUYg5YoxtZi8ehVmltaWhpEGr74lmAZMe8c3PvSji3pwf4
         77hy2d7crgF8bgrIzifcOcA3JL2vD83I/3JhaJjvluazPrGByOsmWHoxIZH359cvxonY
         s1qsGdBbNurdvmXUyZiOMxqRN3YEReJns1qNuLbvsl5vxivl7qOEaut0Zml2T0ujyEsx
         Ra7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729841156; x=1730445956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4g2gos01gcs3ARV9xOeM9xEQeRnKHcL1K/otT/YNFqk=;
        b=u9KL2I46tU1+/QG2yb3G5QnDJ7hNSBly3iuCLGc8leeFBLr1dEVwMNl5+hYGYKDcXf
         U5/oBVobo8C5J9drBzMkrm9vG/OBlosOEdM4uKaFMTNPMAa6anlpRAxW7EbKiuNKpSjM
         JoJOpD20l4mbiWy+cKeaDGuFyz8AjgpO6GC0emJqj8sevP4ZrLNTDepq7AV1WRjhzFbp
         o2fr+0oiow+0Vm1NkSzVTK/qxV832nfOCo+O+PRKAkPz2gbU84MEDJxednPvcnOwZ8TS
         Kde3pAdNwIQfJNqoUIb1muIChMrQBhYU08r9rSvoEkpmQJ72jn7ORz0MHhbENl76umib
         4Smg==
X-Forwarded-Encrypted: i=1; AJvYcCW3sOwfGWKBEWLgmf8A5ZOW7jShqaXQq7UoiGqZSoZ15g4Vn7dBXnoubrAIBR974ToZT4etz8frbkZRwNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkeF1Mw0o2cTb1/lcOsgtK9IEqd/QQ8hpcZOF4EVOJZ8FuDZAW
	oa+0pU/OVKrjQYpSPdsNNyoE8XAnoQ5C3JEhOMw2Kso9C+EeocDcRA0dVnt1b3n3zNiLtsF2xAA
	/iQFYeIVI3dnH8ASzQWpzUgTmux8fUZk+D5nEnw==
X-Google-Smtp-Source: AGHT+IHXU/RWVGusZgTS+hnrrCbnABNHUWKcp7Gd9i5eDRQCyJgRfL6gJjAxp02BR0Ho5+hu73aPvO5Z/5YPkljz63Q=
X-Received: by 2002:a05:6512:68d:b0:539:e9b4:7ff6 with SMTP id
 2adb3069b0e04-53b23e8f1b5mr2874194e87.45.1729841155737; Fri, 25 Oct 2024
 00:25:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018015640.2924794-1-fj5100bi@fujitsu.com>
In-Reply-To: <20241018015640.2924794-1-fj5100bi@fujitsu.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 25 Oct 2024 09:25:44 +0200
Message-ID: <CAMRc=MdsgJOFK-U9pxK2NDjQ=MSCnq1oZtVALvKLwMbuHPrLGA@mail.gmail.com>
Subject: Re: [PATCH] gpio: dwapb: Add ACPI HID for DWAPB GPIO controller on
 Fujitsu MONAKA
To: Yoshihiro Furudera <fj5100bi@fujitsu.com>
Cc: Hoan Tran <hoan@os.amperecomputing.com>, Serge Semin <fancer.lancer@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 3:56=E2=80=AFAM Yoshihiro Furudera <fj5100bi@fujits=
u.com> wrote:
>
> This patch enables DWAPB GPIO controller support on Fujitsu MONAKA.
>
> Signed-off-by: Yoshihiro Furudera <fj5100bi@fujitsu.com>
> ---
>  drivers/gpio/gpio-dwapb.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> index 798235791f70..6113ab1bc8de 100644
> --- a/drivers/gpio/gpio-dwapb.c
> +++ b/drivers/gpio/gpio-dwapb.c
> @@ -694,6 +694,7 @@ static const struct acpi_device_id dwapb_acpi_match[]=
 =3D {
>         {"HISI0181", GPIO_REG_OFFSET_V1},
>         {"APMC0D07", GPIO_REG_OFFSET_V1},
>         {"APMC0D81", GPIO_REG_OFFSET_V2},
> +       {"FUJI200A", GPIO_REG_OFFSET_V1},
>         { }
>  };
>  MODULE_DEVICE_TABLE(acpi, dwapb_acpi_match);
> --
> 2.34.1
>

Hoan, can you leave your Ack here, please?

Bart

