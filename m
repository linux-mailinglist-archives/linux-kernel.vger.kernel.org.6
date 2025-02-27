Return-Path: <linux-kernel+bounces-537457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A368A48C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B46416D4F3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC22227B8E;
	Thu, 27 Feb 2025 22:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QmPQhNmf"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F7027781F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 22:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740696806; cv=none; b=W/rfSaxR+ixnt5I6NNAbt2uD06Up/QO5dHb8LMG+mZljcZbrKaUtnk573wS2pT/s+zx2NwQYn/P5P7C39xldH+YKbHJfjkGXVSVM5VthapYwAqML7dlf9g5mnUB5Q02swj3yksNZFcaHUqJapBw2OFEpuCDrB2LShUAnK3m3ibI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740696806; c=relaxed/simple;
	bh=sGvdnue/B5GYlmaUtedTZkS3J2gnunXBcoKQK+BG5Cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGgtaGvoKjJ4GgexWwy3YLeI8aSbYFrNMUH8oI/XmVHq4t49uq//SXjmjWw+IXy1Bpk9TxTBKld0NMhCTHagXC7hmweJdGEgmjRKJuXQBLivusiTMbKhaJvGa/SOWId+PDKJ9vqaUPTF546kjttOEmyi5G2uq/W1G+UJGez9NCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QmPQhNmf; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5461cb12e39so1380152e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740696803; x=1741301603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYAfR6rT+J2Pmezoedxv/QKmEL6vhTnAGCGwcyVDn58=;
        b=QmPQhNmfL8rp1P+SsJQ31uOC9I0E1xF4FAHT/u4+BneXewIjwpCGKgMWfm6MUGl6dL
         PnTFPecK2+A2RSvqLMRJA8RjyyNHvWKN+RiwrX2iziOQFLDhBLQHhxnBfavV3Bs/jyPa
         J1b1NUguH4GIvHd0EF7wY3BonhF37V2CVAVJohpw3nARrF9AMGQcsBrhZIVDrXSt7dL8
         keQVZ1ENwE7OyMjGEhYERKekNdQVcZR85PHNXOFbKY7NfoZdIUP4Xl9b4ehfHHkprx3w
         3ED/qXY6qpvZ+/ZgJuMWwWq996sw9pD1gfnEMz5QBfgHRgLGRWjdrwXxghKtT4LTo+PP
         lRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740696803; x=1741301603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYAfR6rT+J2Pmezoedxv/QKmEL6vhTnAGCGwcyVDn58=;
        b=OEoa/Li9LzZkAsge4Qxt1Rh5BLje6VZGTuJiSNH194mrkhnU5wdGz75+5wWYJQi/RO
         5I1atYKUPaMbyd6atKM6cm5ftDYwUJd8h2C1niRgG8ypUUkQOn0uc6vrMacrdqsI2o+u
         aAPkIzq/AUWPgoDfLTIaCxv8VM6zeIuSR1Wyzv/4tYtxsrezpnjjagYs2gu+Hzl75IYa
         +3VnTlcc6DYF6aAQcyF8FgFxeESfOqanjogwPXzLrBzHyQ3bGXv+FuXaDQDXSocaZV9j
         1VkuZZw6AMytuQGdv3DXv+JFdUO8Hyo/J5RZ2wKYoXnFiH/5BP6QHkQB5G1gQ7rnO1Su
         6MFw==
X-Forwarded-Encrypted: i=1; AJvYcCWZxZttNWcvTkMgX5Psj07YaAOkufjWcRjWu6b3pAyQtDSyVrv6X5AWv+W0hJOSu93GZEyEhK6y4+CGDIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC9T3qeeisI5AMA/ZoGrqXLUdkr3iXpiTM75LceGREFDNkgeLF
	RhzgqFTVCgb7B96Q73mBT5KUQkOP1ntEMHyn+vCnUq8U8zzIpo7CyGldFJlAmoR8kwrjQbRA/ND
	dRRFcd21mxLp4PFrpU5aimfnuwYEWjwhIL7ZjKA==
X-Gm-Gg: ASbGnctyMJdIAJuRXac6d8uWSk0h9tqkoqf0GRsi/AevNaAJQxNGkd075QzW2eICpaY
	OkpFjcioNA6+jnCXkVwwPH0Niiu1Zqw11pfnMyJrMy1sFrMV4ytRypko7B64MzKza4cu15VSu8+
	9J8CEuA4M=
X-Google-Smtp-Source: AGHT+IEtwiHtj9LHUcW0e/otkeY6xFx8rK1S/vfrLBTeffolkmIjfF0YZc4BMa7wskN4DXcOEuc/fyfJLasqmpJiYAc=
X-Received: by 2002:ac2:4c4f:0:b0:545:2770:79b2 with SMTP id
 2adb3069b0e04-5494c351b83mr499150e87.33.1740696802619; Thu, 27 Feb 2025
 14:53:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219102750.38519-1-brgl@bgdev.pl> <Z7XqSVfhPGI5J63B@finisterre.sirena.org.uk>
 <CAMRc=MdEcjFUp2OEutcnDqSHbbait3f25NEWbdp7mARyKZLvBw@mail.gmail.com>
In-Reply-To: <CAMRc=MdEcjFUp2OEutcnDqSHbbait3f25NEWbdp7mARyKZLvBw@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 27 Feb 2025 23:53:10 +0100
X-Gm-Features: AQ5f1Jp6iZursAYFoyZhYUa8R_xOEcekX9mX715XkkcwLe7KRWmfwikYltCeIOs
Message-ID: <CACRpkdbkcX5pEeikkDZAxSGp+M3kJH5SWimxQA6P35iiDAUNdA@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH] pinctrl: bcm2835: don't -EINVAL on alternate
 funcs from get_direction()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Mark Brown <broonie@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Stefan Wahren <wahrenst@gmx.net>, 
	Liao Chen <liaochen4@huawei.com>, Chen-Yu Tsai <wens@csie.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, linux-gpio@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 3:30=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
> On Wed, Feb 19, 2025 at 3:27=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:
> >
> > On Wed, Feb 19, 2025 at 11:27:50AM +0100, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Since commit 9d846b1aebbe ("gpiolib: check the return value of
> > > gpio_chip::get_direction()") we check the return value of the
> > > get_direction() callback as per its API contract. This driver returns
> > > -EINVAL if the pin in question is set to one of the alternative
> > > (non-GPIO) functions. This isn't really an error that should be
> > > communicated to GPIOLIB so default to returning the "safe" value of
> > > INPUT in this case. The GPIO subsystem does not have the notion of
> > > "unknown" direction.
> >
> > I see this was already tested for these specific boards.  I've also
> > found that Avenger96 is failing with bisect pointing to the same commit
> > this is fixing:
> >
> >     https://lava.sirena.org.uk/scheduler/job/1126314
> >
> > as is the Libretech Potato:
> >
> >     https://lava.sirena.org.uk/scheduler/job/1126285
> >
> > neither of which produce any output before dying, they'll not be fixed
> > by this change.  Seems like an audit of the drivers might be in order?
>
> Right. I don't know if they return EINVAL or some other error so let
> me prepare a change that will not bail-out but simply warn on
> get_direction() errors in gpiochip_add_data() instead.
>
> This patch can still go upstream IMO.

I'm fine to apply it, maybe as non-urgent fix at this point? (for -next)

Do you want to send a non-RFC/RFT version or should I just apply it?

Yours,
Linus Walleij

