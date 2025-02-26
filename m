Return-Path: <linux-kernel+bounces-533516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAA6A45B8E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAF3617642A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19816224259;
	Wed, 26 Feb 2025 10:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="utWFaXvL"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB951A0BCD
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740565150; cv=none; b=K/DI+emCOwxujcJHDAuyBIDlHHs2CUt7D1VYPJNk+dhazAjMidQ5ycN0M5Nw33aa5wBqbPPeu+lqBH76CosT879XyLk4UB3Cr86IRJhzkrh7Yh9XYdhn0Ls+cR1ZHeXE0lQ0kLhh2DJmtflbXXIvJy48Av98NHIqQkHTAMbQnxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740565150; c=relaxed/simple;
	bh=DKJPAUCWpMarL6wTRvPVlA7VYpvvjyB6zrJZ3/cdENU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nr729N7cLwCzGXzJCOu1bf/CRNd3Cf1eOamXSwrdFT7DmBueSCGSKpL/GsvLnYjUWcHci6s6pAQOeEJ++6rN0fS0qqhcl+cXh/up1eshLTw65V9d/T4hOQ7dzxBf/RlZD7msNusY5Rk6COJ4psMp8gEA6IdNDLmBZuW1xxnnNcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=utWFaXvL; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30a440effcfso7940031fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 02:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740565147; x=1741169947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKJPAUCWpMarL6wTRvPVlA7VYpvvjyB6zrJZ3/cdENU=;
        b=utWFaXvLMnJxUSS5zmFp1zMLVLctrM8Cbe1nzLsNRGWhBJoACvjkquhXJBV+3rkJHW
         rtzapm8lDzWTq2lmp8rNzk3Qe5NkHrMHC+9kYftMvfzDHusMfhnav9JyRMz2jICebb6h
         O+iepKZpSvAXjmf+f3NkFWoeWhdxTqj0UbgvPDJeCpz0owP78ivQsQfzf543q32lZbDW
         RXH9PCQBklsOO2OJpTx9AU1u8Gx3KLm9AuyriTecz7/PX4IJ9UQEnp+0YLTrltNZqght
         DoAWSdnmQLnxe3fPn2vTM8vXJkx5FBbWNXmn3kOVz8bSybKyXhO7iq5xMiRpCiRscy9Z
         wWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740565147; x=1741169947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DKJPAUCWpMarL6wTRvPVlA7VYpvvjyB6zrJZ3/cdENU=;
        b=sRxUcDcpWvvbhS0AHmmelhAoET1Zl2MoBoBUEKyGDhabWgqmh5Vqsa27XLqlWvtM2/
         I7e3kSTjyJBFMRJE8YIgPUrCq0Y1GXCjX/z4T0JJ67N7ypICsjD9s8qlUxACVnloiX1i
         ktSj0lJF98dNE3YUihy9a1Gmnqrk3y6tysDnEpL339M33qX997qcucB34m4M8RWPeIQW
         tOpIqf7/QJLMobL7AfuYzTeRrfto2NTxIGTGs4kBBM49PLSpc3A5fcNe2BdIy91kjFAn
         6a6ImTwdz1je2C0+7knNzOrLFi/tgkaImQT64IAC3fgIBzd4RRtVGRZwo9zr+0jhdChU
         +jNg==
X-Forwarded-Encrypted: i=1; AJvYcCU/bXHxQU5XCOhpR+/jut8pWNwMKdaI2uhs/oICbI/BhrAU+B05k05nqNXbZOoRIiTaKhT8s2+dZzW5abg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvVoS6Rz0jhxgPqFBuA3z2wM/pIpdr4uceopp1t0x1Kb9Ddu0p
	kdqNF4kXZ3LuCbBpyy4mkEvUUG1gVAEpVqaKN7Wx3bEIebwTYIM6CNKZSRiwAnCmf6Q9diHw1La
	XlIEs2Ehp+3edqHO8LGXn3mh/50yuRmBYzIZXnA==
X-Gm-Gg: ASbGncvcQ+bPxdkk6O2rgIfgpzro3CpG+eAIz/v9ZRttxkTh2aqbTUs9g6q7cqWqLj0
	Rl2TV80zqcRtq/fMAc7FpVTCAJxS55OlFqvPn0uq/ASUXbi3/dNDzcjb0AWdEFQ8bMyQeYnUAnb
	pUXnY19gk=
X-Google-Smtp-Source: AGHT+IH9IyLn8GVoExU+oQLlxh7oTefH69fzA03PH2aYFHwj0v/wUocnCBinUIb/4NLpBPrOJ0p2aprs1CvgBYqqRcA=
X-Received: by 2002:a05:6512:308f:b0:546:1d8c:60f1 with SMTP id
 2adb3069b0e04-546e4662ce7mr11792066e87.15.1740565146777; Wed, 26 Feb 2025
 02:19:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z71qphikHPGB0Yuv@mva-rohm> <CACRpkdYOGeDaDUuQQUGwvFNNk7ZuFjkXSMPXL3BJ=4jGEGPkoQ@mail.gmail.com>
 <ce0d802d-6bad-4028-bb57-18bddba5632d@gmail.com>
In-Reply-To: <ce0d802d-6bad-4028-bb57-18bddba5632d@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 26 Feb 2025 11:18:54 +0100
X-Gm-Features: AQ5f1Jp5WtBrqIoIAmiHI68a90umMToYtMRHUCvv-S3W-GZVg3ZNkYQ-qANM-U8
Message-ID: <CACRpkdZtWLGAn0K+xENY+RF6CsWPn0m7R--W9EaH+xTKazALFg@mail.gmail.com>
Subject: Re: [PATCH] gpio: Document the 'valid_mask' being internal
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 7:09=E2=80=AFAM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
> On 25/02/2025 23:36, Linus Walleij wrote:
> > we can maybe move it to struct gpio_device in
> > drivers/gpio/gpiolib.h?
> >
> > This struct exist for every gpio_chip but is entirely gpiolib-internal.
> >
> > Then it becomes impossible to do it wrong...
>
> True. I can try seeing what it'd require to do that. But ... If there
> are any drivers out there altering the valid_mask _after_ registering
> the driver to the gpio-core ... Then it may be a can of worms and I may
> just keep the lid closed :)

That's easy to check with some git grep valid_mask
and intuition. I think all calls actually changing the valid_mask
are in the init_valid_mask() callback as they should be.

> Furthermore, I was not 100% sure the valid_mask was not intended to be
> used directly by the drivers. I hoped you and Bart have an opinion on tha=
t.

Oh it was. First we just had .valid_mask and then it was
manipulated directly.

Then we introduced init_valid_mask() and all users switched over
to using that.

So evolution, not intelligent design...

Yours,
Linus Walleij

