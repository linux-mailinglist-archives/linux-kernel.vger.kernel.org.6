Return-Path: <linux-kernel+bounces-235830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F336791DA40
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66010281FCC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1767084D0E;
	Mon,  1 Jul 2024 08:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="gE7HuV6/"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDF784A5E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823309; cv=none; b=SddiP1iaxoATmKgZNS4iVoJmlM05vGgdDsgqkxPVEJxxej2ikZokz8EkKYBXeOXivohuTrCK80NQ7bt94/n0f+bw0dYozuv+C+IHPQCGwPZ/How/rs366xyPgTt34VXr8FZGaomkFo/zEHx7IKP1TO0pBX22xsXddf8wFnsXxn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823309; c=relaxed/simple;
	bh=A5Zg1PRYfzfOHOtP83qHfhhvwMY5XoJvZFi2Uh3VW3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HuZaFEGpl0L6H3lxO9R13OYYaZKYqnl7bmOEZc36ja+YIMGZc84gRGGfMXma1u5je8sOVSK8vGFFKnL1pGpLCbhFtlzMpN39gJ4C7Stfk0poHtYRcGDbm6huhg5Z2yQpPazQm/0TwUIMKZ0DYUbbyzx/tejdUtLFenIeafIgfyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=gE7HuV6/; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so34626631fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719823305; x=1720428105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9juGhjHfVWoUy99hHa5hPCw3ioXYAtyhRKhN5Xhpo8=;
        b=gE7HuV6/aBhndsvb6GGSFHcRWDsrAMazeBWrMS14OtOmgzj+Bo5s+LtMsCWcWoPXBH
         fsz2sHtTLpafqCW4KsiYOq7fl4P2NKIpvA5IEkkuj80qTEIRj27jRc0WQllgvsAaMjL+
         qXAURu6AFLrn5uvljIn0jUQIQr9l1hXJ7F1t6DaKDMQrOqz4DXPgDnRvCcHiNhCZU8Yn
         65XRzRrEhe8QhEib0L3Y3n7KhEh47HqSgecGjbqcy1cMG5ertSbqCBKmVzmcr+VhXa+2
         jM8gT0gXXSASbKNs/LhkjBeZCdT8Rgblvx3OYC2tmtoxGIdif+mG65yS0297zhA/WJv3
         i0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719823305; x=1720428105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9juGhjHfVWoUy99hHa5hPCw3ioXYAtyhRKhN5Xhpo8=;
        b=kvubuXzYrdNF1tJwOKpmNPCGd1+f6M+7Sv9JQSbyLdzvQqJuL+GXcBJ7VGpOQ62Jhq
         yvNJ6yrfYDO9NAl4g5f5hbG5+a/0260gAcunC3cUcnW8ZPvVideVv8nHTxCu4l44djOB
         Bnb9cqiQckDTeIuMpyw+IoLZq54sdAJH+EE+ArDYqCvKIQ7v2tiBrGAOU9GwM3cw11No
         5hYbpMrSUByHM4v5vwW+W9/UTzreSy0m4vyBGShmHwn/iw3SI/6M8l/e7sjk30BL5E6E
         lI4xUHecX6p+WqPNQKmZbTvh0yRC5DGAzCZ2Tu2VaH9aV/NoTdhqgLPpJlRIhjYUmXwW
         1cCA==
X-Forwarded-Encrypted: i=1; AJvYcCVbAnN+2U6jLitq8aY/iJSvypH1D/V6vU8t2d/kxHt8CTz9M20i/0xGMPkja5BabxD8XWkv15xOk1UaqvNGFqnfEZtjIKXuOYhWtYO/
X-Gm-Message-State: AOJu0YwKlXbD7a5bWvUwXbYj3KbPqhBVjm5HcQ0BQtGj0hPwUaHguIHS
	PhKIW6RGUtaCj0Ifxeei6EViuTqUT9GsDS4k0R40xUlS+SeXDiWwRpDh+vqJ0FbTIbwvCr1zzOe
	NtW8yCR3e1sAG34f+NnT5riQiN/83qd48ycQc1KmkCws5aOdr
X-Google-Smtp-Source: AGHT+IEsCWgMx9DJFYAcQiyEJw4++CwfBQYA9g4zZOE5DaBcnPejbFFLGbW4vhjuhsfFCmyeaoej8jPIhz7E2M6qR/Y=
X-Received: by 2002:a2e:96c6:0:b0:2ec:2038:925d with SMTP id
 38308e7fff4ca-2ee5e37ffa9mr42312751fa.1.1719823305729; Mon, 01 Jul 2024
 01:41:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624093934.17089-1-brgl@bgdev.pl>
In-Reply-To: <20240624093934.17089-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 1 Jul 2024 10:41:34 +0200
Message-ID: <CAMRc=MfH8ZuA2pK3bzSw5mitsFE9wUnoD4iG4Tg8_83SJm-poQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] gpio: sim: lock simulated GPIOs as interrupts
To: Linus Walleij <linus.walleij@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 11:39=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> I realized that the gpio-sim module doesn't lock the GPIOs as interrupts
> when they are requested from the irq_sim. This leads to users being able
> to change the direction of GPIOs that should remain as inputs to output.
> This series extends the irq_sim interface and allows users to supply
> callbacks that will be executed to inform users about interrupts being
> requested and released so that they can act accordingly. The gpio-sim is
> made to use this new API and lock GPIOs as interrupts when needed.
>
> Thomas: if this is fine with you, can you Ack it so that I can take it
> through the GPIO tree for the next merge window?
>
> Changes since v1:
> - drop the notifier in favor of specific callbacks
>
> Bartosz Golaszewski (2):
>   genirq/irq_sim: add an extended irq_sim initializer
>   gpio: sim: lock GPIOs as interrupts when they are requested
>
>  drivers/gpio/gpio-sim.c | 25 ++++++++++++++++-
>  include/linux/irq_sim.h | 17 ++++++++++++
>  kernel/irq/irq_sim.c    | 60 ++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 98 insertions(+), 4 deletions(-)
>
> --
> 2.43.0
>

Without any objections, I'd like to take it through the GPIO tree by
the end of this week.

Bart

