Return-Path: <linux-kernel+bounces-271815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB5E94538E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8067E1C2343D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C352E14A60E;
	Thu,  1 Aug 2024 19:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hXBl8tqK"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E291E4A6
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 19:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722542028; cv=none; b=fHdsMjawhToP4xLxgBXa+ZTCd04NWpHKHc31z7oN6uDwe1AWX3DcidJNtZl7FeeHtRRMy2iBj2hPvXJttuQc4BwnE2IgDRyixaIQsbzuKuTHJY/bC7O/w74mAYtdO2/oFIoYaCaj73Pbb28EAQHGBjEAZCiSMwoZoClWS0Zm0qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722542028; c=relaxed/simple;
	bh=wLC+wyAvBIDqZxxTL+OJUZIAzsd6IEPTdtsg8MlEoSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPviU+PtXvP9AF3ibK+ORwdwPqhAs7jqXDku22SXItDxk2oA3RLKomWpV5xw9/G3mPunMNfgKKQtMKkvuC7nTDjPHIBKFKtcDwFGXjVh/0KcuaIvSfIvKLEKE6VisQ3VaYGE0APFCesZz9aVAALlrkxtdEmW+B2ncAa23Gu/C60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hXBl8tqK; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ef248ab2aeso107799801fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 12:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722542024; x=1723146824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLC+wyAvBIDqZxxTL+OJUZIAzsd6IEPTdtsg8MlEoSw=;
        b=hXBl8tqK6+q8HtOQyXmmrw/17FjrB8IX7CLMpa59IxPqFtSmFp5MHGuGO0rRDESTjf
         kTtXYyIsN5yNambBWKBwvv+ksi4ujZvB8igRGpIKzZJrYZ19QVa0PTQ8PJl9JTc8nVM4
         7AYWeWfuBWYRJTnYIFk/ZzLXPODSFX8bv6+JfuW96n15hzamyMvpP5YAP9d/30beeBwA
         rnx7H2EFqmN1husdFoif68Bfcq0e4ZHn3VVDvznSyIj2sQCzaLXVA2nKcrJ4KC7CoL4i
         j3jdTNsfoNMx8Lt7HaKfNtzX4uMNPxzUxLgmSEECnWLq8yOQwq5soaOBAgT1q9H+UQJ0
         I5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722542024; x=1723146824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLC+wyAvBIDqZxxTL+OJUZIAzsd6IEPTdtsg8MlEoSw=;
        b=l+HTNFQfmlOfVKFmADmOe85l+xFWZ1TYyh7QdrC125NoG/KdokqNkz/HiButnsVTIR
         5Ii7TKlO8NbFnz8Ljjf4iSYk+cauD3Mrw9ZXg2FGASM2lfeTNDb2MbYS+KmzfkozgulO
         J5ChQvzvd9XFi/TdIb4sa6WWj2WK/KhJWrTGiWOHyqAHJBEw4QlLHZDw3yQPGd3j1tep
         6XNzdT2r562EoyXcupQk9EiRB/zFmfsOvO9FaTd99n2QQKeSNPamIE/kNrmmM5lOK7/V
         IZgId7Ii/SoMxRRZmIC+6zx8Z51rC7x1jAhnBx0duR9vQWzzjAgMxrPOIlsG1QtGz9Vo
         Lbrg==
X-Forwarded-Encrypted: i=1; AJvYcCW3ulWYrDBu7vi7nSWGoXRKCaLdaWhHJwoT9uSRceXGmnajTr62eWs1wWf7fbTIe2+G8jViWeuJUVvJmkYxruDdcmiJ05/rzWqhH+OL
X-Gm-Message-State: AOJu0Yy8jcYvnnYpPf1QedlR+tzmFlgPkcVSO46gSHDunJbsO8kFdcb0
	MQEUsMFV5sSc19KWkPvRC9YquwmbW0K4al4EhB7mO85VGLTPmTCXcRqCtCWV2fwP+vhEtR4+42e
	9zqcPTro/VYS1EwoKl9EWLGC0Tt7VNTYf5xHNtQ==
X-Google-Smtp-Source: AGHT+IF5LKvLdZzdAViTxk7RViSTqKC2qm/6JryMX1R7EgHQYJw06oODfHSJfpAYnXNH4vquVf5Gn6dslXjcCQDSgGo=
X-Received: by 2002:a2e:9203:0:b0:2ef:2dfd:15db with SMTP id
 38308e7fff4ca-2f15aaacf0cmr11335671fa.19.1722542024234; Thu, 01 Aug 2024
 12:53:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2831c5a6-cfbf-4fe0-b51c-0396e5b0aeb7@app.fastmail.com>
In-Reply-To: <2831c5a6-cfbf-4fe0-b51c-0396e5b0aeb7@app.fastmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 1 Aug 2024 21:53:32 +0200
Message-ID: <CACRpkdYUHtfjL2jfGxjV1eMZGkk6NXaArbHpc5mhrY7C9rSi6g@mail.gmail.com>
Subject: Re: [RFC} arm architecture board/feature deprecation timeline
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, Richard Earnshaw <richard.earnshaw@arm.com>, 
	Richard Sandiford <richard.sandiford@arm.com>, Ramana Radhakrishnan <ramanara@nvidia.com>, 
	Nicolas Pitre <nico@fluxnic.net>, Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Kristoffer Ericson <kristoffer.ericson@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, 
	Nikita Shubin <nikita.shubin@maquefel.me>, linux-samsung-soc@vger.kernel.org, 
	Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, "Jeremy J. Peper" <jeremy@jeremypeper.com>, 
	debian-arm@lists.debian.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 7:29=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:

> =3D=3D=3D ARMv4 =3D=3D=3D
>
> This is used for both StrongARM and FA526 CPUs, which are still
> used on a small number of boards. Even the newest chips (moxa
> art, ) are close to 20 years olds but were still in use a few years
> ago. The last Debian release for these was Lenny (5.0).
>
> Dropping compiler support now would be appropriate IMHO, and
> we can drop kernel support in a few years.

I am actively using the Gemini as my NAS with OpenWrt and there
are several users of it in the OpenWrt community.

I don't know if there are enough of us to keep ARMv4 support in
GCC, but ARMv4 support has been added to CLANG (along
with ARMv4t), and I have tested to compile kernels for these
devices with CLANG (for testing CFI!) and they work fine, so if
GCC drops it, we can still build them with CLANG where it apparently
isn't a maintenance burden given that it was recently added.

Maybe CLANG has a more adaptive backend?

> =3D=3D=3D Highmem =3D=3D=3D
>
> Most Arm machines are fine without highmem support and can
> use something like CONFIG_VMSPLIT_2GB to address up to 2GB
> of physical memory. Machines larger than only popped up
> around the time of the Cortex-A15 in 2012 and for the most
> part got replaced by 64-bit chips within a short time.
> In addition, there are also a handful of Cortex-A9 and
> Marvell CPU based machines that have either more than 2GB
> of RAM or a very sparse memory map that requires highmem
> support.
>
> Linus Walleij has done some work towards being able to use
> up to 4GB of RAM with LPAE (Cortex-A7/A15 and later)
> machines, which I think still needs to be finished before
> we can remove support for highmem.

This is either really hard, or I'm a bad developer. But I keep
churning it.

> =3D=3D=3D Gemini, Moxart =3D=3D=3D
>
> These both use the Faraday FA526 CPU core that like
> StrongARM implements ARMv4 rather than ARMv4T with thumb.
>
> The chips are also over 20 years old, but the kernel
> code has been updated and is not a maintenance burden
> by itself, so there is no value in removing these
> machines until StrongARM is also gone.
>
> On the other hand, removing both FA526 and StrongARM
> platforms means we can probably remove ARMv4 (non-T),
> OABI and NWFPE support more quickly if we want, or
> we can wait until a few years after gcc drops ARMv4.
>
> OpenWRT lists the gemini platform as supported in
> https://openwrt.org/docs/techref/targets/gemini, but
> none of the individual machines have builds for the
> current release.
>
> Need input from Linus Walleij.

Yeah we use these devices. I don't know what counts as big
enough community to be considered, it's at least not just
me.

Gemini builds are in the official OpenWrt repos:
https://downloads.openwrt.org/releases/23.05.4/targets/gemini/generic/

Yours,
Linus Walleij

