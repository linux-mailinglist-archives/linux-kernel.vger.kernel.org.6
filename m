Return-Path: <linux-kernel+bounces-250415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D670D92F79C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 11:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E72E1C2109B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87F514430D;
	Fri, 12 Jul 2024 09:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cfy0oVu6"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51722143747
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720775361; cv=none; b=ArmzzptfNYx6+wfNz1TR0eK6Szax0FphXtYZzzNvRLgcYEyrVkfcf+pmp7/ogPBwVcqIPi0ptdYSC4yhGMvcnhBwYtHJFszJxqGq6gltIJMB8LvSr8MGAOwY0+ErKAGTkOAg+cBQobGNS8rRTg2IfSIFgmbHLEup6ERpXqO0tv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720775361; c=relaxed/simple;
	bh=FRMwaS7pbLLRvTwAaGpoDBvcuIzMitqPS+0MpEDLaeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3JAs4NS2q+rTTN1nRkDmbIu8aVF1iVO7ShLz2q+rvBYhR9yzBghoqizUPp17IpN/vCu8XYR0OeTMMpWx/I2a3sO5O1ZGmM3eBX0kIPKmD0P1erVB/t1eN+nx9nXmq702YkDyWHARBfbmY653oSRpBhgW15UToNvskrsTvq2yfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cfy0oVu6; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e03618fc78bso1623640276.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 02:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720775358; x=1721380158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCNPSZL1ytzjE/7mUpIJ/u/e4A8RUCUKfpqrgKWdK38=;
        b=cfy0oVu6GxJsi0WxhM7lOt9ySNp2dKWdqa1bUUE/XYdpQKAycfcWAyzAPB+1K+CUkh
         RL1Ie7cVhDeq1r+hLO5nLcLR3KYSJupdch9GHIYGxL+sK79SmD/jRcKzlO60EL2eEJmP
         70srzDWptQ5HglE2KMhT1SnXEQXgQ1YVBK/sTBnrYVkhrG0kjH+joN6sgUWpvqaauaQ0
         019qN1cTAXFiaycUJDc+qcu0rWIy6Y2+f8JJjMD5/9+Eg+so6Cqe9b14Gm/6xzmbnUBR
         hJZRiNoxcADeff7WoXmS5dtUtprlWdPtLh2+hFxok1FI7NAw3N0sx+OdhznigX4pdlss
         HQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720775358; x=1721380158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCNPSZL1ytzjE/7mUpIJ/u/e4A8RUCUKfpqrgKWdK38=;
        b=unEuVPZBxh3cpKi6ZS3cGa7ZFYgjErdqcX1od+S5cEpP1tl6Wf117Gpjy/ibm97oba
         Rgb4xbAYoGaW8snfPlGe7DXyzCD8DV8+fiXITYxw99YaeA/aYZhbzA3satNfPRFL4qvx
         Xqv+Ytegdts/XOWS9DJkbvSjDBrEytpLMaohL2zu7cgherA7AGTowGzFOWCh25pAy4+f
         FJ3Hb2m0osejxf2zDu7T+5xERpQFhGzxs+ugOOjLivCk7XksclN3Jl2nQyoXBtHlIgBO
         x5bwP3f1EClHlkb09iQEUCPXE9dMgENIsjqRb7Soo6INOyN0zXzoYr+X46ZB+Bh5vLaV
         7ELA==
X-Forwarded-Encrypted: i=1; AJvYcCV3QiPFb0XEgSPXH24RO7yQaf2QEu45kZu+C68iWYN7rW4OpqWmSGnBYWoNu+OjYNsu1mnt1amvZouBEEA58j+tMiQIzcdEDKHhi467
X-Gm-Message-State: AOJu0YwF27D6TZXVsH0R+Mq6CrjV0bwI4YP4VM9E/t0smKF+NPQrTW21
	iQTgVEcmjOdsB9FQm9LC1eor3PuM3WozmJ0h9mvcN3+xzQLfWpGt1imT95pCW8MLztjsrs5yES5
	xjfKZc7N+/W1cNhjiwghMTxrl5ybh5nyyJprEoQ==
X-Google-Smtp-Source: AGHT+IH2ZhkNSr3lAO0ISZV3PDaROoLe9tlom5kTqum4o5uFiWztS750eAeqlWthH+6h3mahZ3jiz9uDI9AN/j+tZEY=
X-Received: by 2002:a5b:503:0:b0:e03:6085:33ef with SMTP id
 3f1490d57ef6-e041b166fa3mr12051590276.41.1720775358054; Fri, 12 Jul 2024
 02:09:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuCp7Q71_o74yo9ge_5-G=Ho9bC3kJdX_JvtoqWOQujkA@mail.gmail.com>
 <CAMRc=Md5zmFxXXM89LQs6dspC0xnp_6=z=+a2SQypWjwpiRgow@mail.gmail.com> <f6afe212-8b28-450e-ae54-0de996be078e@app.fastmail.com>
In-Reply-To: <f6afe212-8b28-450e-ae54-0de996be078e@app.fastmail.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Fri, 12 Jul 2024 11:09:07 +0200
Message-ID: <CACMJSetxpEL0pomsiZffXr3bFYEGLMBvOcZDZHkizxRx92HVQg@mail.gmail.com>
Subject: Re: next: arm64: defconfig: gcc-8: drivers/bluetooth/hci_qca.c:2501:2:
 error: label at end of compound statement
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Dan Carpenter <dan.carpenter@linaro.org>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Jul 2024 at 11:04, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Jul 12, 2024, at 10:34, Bartosz Golaszewski wrote:
>
> > The actual code looks like this now:
> >
> >       case QCA_WCN7850:
> >               if (power->vregs_on)
> >                       qca_power_shutdown(&qcadev->serdev_hu);
> >               break;
> >       default:
> >
> > What can be done to silence this warning? Or should we just ignore it b=
ecause
> > it's gcc 8?
>
> clang-18 and gcc-10 still warn as well:
>
> 5:1: warning: label at end of compound statement is a C23 extension [-Wc2=
3-extensions]
>
> It's easy enough to fix it by dropping the redundant 'default:'
> line or adding a 'break;' Luiz just committed a fix, see below.
>
>      Arnd
>
> commit f14c0bb78769f2670fdd8bcd28ca5543a7601c33
> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Date:   Wed Jul 10 22:30:57 2024 -0400
>
>     Bluetooth: hci_qca: Fix build error
>
>     This fixes the following build error introduced by a887c8dede8e
>     ("Bluetooth: hci_qca: schedule a devm action for disabling the clock"=
):
>
>     drivers/bluetooth/hci_qca.c: In function =E2=80=98qca_serdev_remove=
=E2=80=99:
>     drivers/bluetooth/hci_qca.c:2501:2: error: label at end of compound s=
tatement
>      2501 |  default:
>           |  ^~~~~~~
>
>     Fixes: a887c8dede8e ("Bluetooth: hci_qca: schedule a devm action for =
disabling the clock")
>     Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 030153d468bf..ca6466676902 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2499,6 +2499,7 @@ static void qca_serdev_remove(struct serdev_device =
*serdev)
>                         qca_power_shutdown(&qcadev->serdev_hu);
>                 break;
>         default:
> +               break;
>         }
>
>         hci_uart_unregister_device(&qcadev->serdev_hu);
>

Ah, I saw the break in the file and thought it was me who had it in
the code in the first place but obviously not. Thanks, nevermind my
comment.

Bart

