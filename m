Return-Path: <linux-kernel+bounces-194016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB1A8D3583
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A3D1F22E32
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A00717B50F;
	Wed, 29 May 2024 11:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2zRylEoV"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C6F16DECF
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 11:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981899; cv=none; b=CAcmun//YIAGxUcFOtS7a/OBpHkBcbdBAgcKURQJ4AUz/KhKQBealempUxffi6RKcx6n6l4WWSuyul8biG8FvwuCkzBWh8Fs0hw59y3eWoYn+l4k74VrR0gb4OLfm0wFStHlqax9XvsWwoQ2rqr/KsDU2D2qK9ckxBLGud0TCrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981899; c=relaxed/simple;
	bh=DTCCleyVcSCm/MaSCNeHp3zRfmdlT7E0UJ4lfxfio1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTJds0NrIXG9fS6XbpqkG/aMcXWyu+UCUTeu3gDOkICkOuohVTJnM6AMD/GDLBYJrI2/2HWrVmToo8lAMlT+4+9C09q/bsHfNfFOJ4pJx2gWoHahIVoBMoRTlsxZF4qAXY1plEffZbnGPIeAznRfqxOG7Z4FLC1gcx1qgLkZYaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2zRylEoV; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e73441edf7so18856481fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 04:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1716981896; x=1717586696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ewvEYPrJ+34TaqUmmUUdKceBPfIMWuE1wY14k9hWtU=;
        b=2zRylEoVjQrVWDOYzgXw681+L9XLlfbauG35iudcWqo9qH5WdmpLwWQMxNvKpeHz+9
         Wrpnl8BtHv/A4WTdxEFnU+kO7EeipPSQTTdtb0hWi4dwsAa2ZKgiVR9QmDUJDkJeD+Uz
         hQbgsIdwc+t3eM6VSiblhx8laVeLuo4DJes3bkgQ1d+l3LlR2D+EwXsIgLZWm5wJOvXl
         /tuZd9j4BYGA0uyeIJTXibTMUuB/Ye5HVmso7umQ2Mtbc6OYwiAIxgo2tAzuuK5FWSKk
         0dYsaSraGRANIgS1IhQs4wqZlxsHmc1PlR3wPjgu4W4wJMf0GrzADvvYlQnwFlCTNTte
         GPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716981896; x=1717586696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ewvEYPrJ+34TaqUmmUUdKceBPfIMWuE1wY14k9hWtU=;
        b=M+paYgtoI5Gg8EH4HI1MU8eGfnIgvJw5xSIcjahf3VRdd9KK3CGxDIMu/oGZM9MoXl
         +E43s4/25brWPNcPkWcDcpTNZqh0bbhrM36DlPys89MOHeWxdr2M20SNhs4aL4eGpF6x
         VoCX5Z4x7z0VlQ40K7XpnVCezD47tMfZnT8qpVLI+Adknp67cgypdMiQWum5JqWruF7F
         wAH8vJHfOkxlX0s/yAVUiiOvWZHIUMaOsvOsVyQYRN0Yl5pHdJvd8HAPEejyhBhZ/3Dv
         U34ISN9jTHD+iBUMyXAG/cr4b61+Z3pXFRf6RDB8TitP1O7y3VE2F79ih2fF5HF3qNFd
         d0rg==
X-Gm-Message-State: AOJu0YydnhxZcEyAbE+M/PO4LVqxbvgtgQ7+qs1sGLb7v4rkmIm1E9Ef
	LSaeNDRVfQ5zCpgCDuDRXvwAQyNxgKAu1GavNi7txRRoJQgolwHxdcSi0g5lq5pcLYmQriSFcdu
	TwjCft3dS3hJgrlww2QXSbNdwuyFie7huWjrR6w==
X-Google-Smtp-Source: AGHT+IFm3iRWb9vu5ubNNpagZdvyV8acuJn+l1fQIDdCSp825lFbjv/6qsgx7fwxNRjuqTsgL3xXuB70MVb3xq60odk=
X-Received: by 2002:a2e:bc0e:0:b0:2e9:69ec:f690 with SMTP id
 38308e7fff4ca-2e969ed0743mr91947531fa.30.1716981896331; Wed, 29 May 2024
 04:24:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527115419.92606-1-warthog618@gmail.com> <20240527115419.92606-4-warthog618@gmail.com>
In-Reply-To: <20240527115419.92606-4-warthog618@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 May 2024 13:24:45 +0200
Message-ID: <CAMRc=Me+M5PQfuOE=tqqxJF-Q_TVdFb=wh-=ApBO_2PvTV=ZJg@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpiolib: cdev: Cleanup kfifo_out() error handling
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 1:55=E2=80=AFPM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> The handling of kfifo_out() errors in read functions obscures any error.
> The error condition should never occur but, while a ret is set to -EIO, i=
t
> is subsequently ignored and the read functions instead return the number
> of bytes copied to that point, potentially masking the fact that any erro=
r
> occurred.
>
> Return -EIO in the case of a kfifo_out() error to make it clear something
> very odd is going on here.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> ---
>  drivers/gpio/gpiolib-cdev.c | 47 +++++++++++++++++--------------------
>  1 file changed, 21 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index c7218c9f2c5e..6a986d7f1f2f 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -1642,16 +1642,13 @@ static ssize_t linereq_read(struct file *file, ch=
ar __user *buf,
>                                         return ret;
>                         }
>
> -                       ret =3D kfifo_out(&lr->events, &le, 1);
> -               }
> -               if (ret !=3D 1) {
> -                       /*
> -                        * This should never happen - we were holding the
> -                        * lock from the moment we learned the fifo is no
> -                        * longer empty until now.
> -                        */
> -                       ret =3D -EIO;
> -                       break;
> +                       if (kfifo_out(&lr->events, &le, 1) !=3D 1)
> +                               /*
> +                                * This should never happen - we hold the

I'm not a native speaker but this looks odd to me - shouldn't it be
"we held the lock from the moment..."?

> +                                * lock from the moment we learned the fi=
fo
> +                                * is no longer empty until now.
> +                                */
> +                               return -EIO;

Since this is so unlikely maybe a WARN() would be justified here too?

Bart

>                 }
>
>                 if (copy_to_user(buf + bytes_read, &le, sizeof(le)))
> @@ -1995,16 +1992,13 @@ static ssize_t lineevent_read(struct file *file, =
char __user *buf,
>                                         return ret;
>                         }
>
> -                       ret =3D kfifo_out(&le->events, &ge, 1);
> -               }
> -               if (ret !=3D 1) {
> -                       /*
> -                        * This should never happen - we were holding the=
 lock
> -                        * from the moment we learned the fifo is no long=
er
> -                        * empty until now.
> -                        */
> -                       ret =3D -EIO;
> -                       break;
> +                       if (kfifo_out(&le->events, &ge, 1) !=3D 1)
> +                               /*
> +                                * This should never happen - we hold the
> +                                * lock from the moment we learned the fi=
fo
> +                                * is no longer empty until now.
> +                                */
> +                               return -EIO;
>                 }
>
>                 if (copy_to_user(buf + bytes_read, &ge, ge_size))
> @@ -2707,12 +2701,13 @@ static ssize_t lineinfo_watch_read(struct file *f=
ile, char __user *buf,
>                         if (count < event_size)
>                                 return -EINVAL;
>  #endif
> -                       ret =3D kfifo_out(&cdev->events, &event, 1);
> -               }
> -               if (ret !=3D 1) {
> -                       ret =3D -EIO;
> -                       break;
> -                       /* We should never get here. See lineevent_read()=
 */
> +                       if (kfifo_out(&cdev->events, &event, 1) !=3D 1)
> +                               /*
> +                                * This should never happen - we hold the
> +                                * lock from the moment we learned the fi=
fo
> +                                * is no longer empty until now.
> +                                */
> +                               return -EIO;
>                 }
>
>  #ifdef CONFIG_GPIO_CDEV_V1
> --
> 2.39.2
>

