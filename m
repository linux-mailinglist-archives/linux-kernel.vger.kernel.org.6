Return-Path: <linux-kernel+bounces-401278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEE19C1822
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8A71C22DB6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436801DF739;
	Fri,  8 Nov 2024 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J4trMXOC"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B0C1DA31F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731055045; cv=none; b=duVD/9ZNgisT+BsFJhu76iyShpIHMhSrn/Wsy6O7hDjywCUhs2sglhbfWsIPfNTtL4Zxkcx+8gonu+fYH0IGuVjrtfBc5z4bQkagxsgrULlgFZRJ0Y9sfTdIpMeU8yCcPQjz42DyThjeCVMY22VSfEMpGoAdrRiSX5ZwHzkvKi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731055045; c=relaxed/simple;
	bh=vVqCqej3UEHzQjSpv0v/eChyYMxhKtzxsLYbfjRtEsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4oy5yngeXnBAGJMsHex95RJpNOQLuH5rfkGgykqk8LoYwyDlgvrg4lRYkCO3in5+W6i9TsNNg4JMgsWzGpa69JNTe8HhAdlLgtHbOnwfK5PR/7B0/VQ3GkOgpvpws+Br0OvwDcZbQRYh40o6sb7reCy+jdVYF9Umh6WVswj70w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J4trMXOC; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb5111747cso18581701fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 00:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731055042; x=1731659842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVqCqej3UEHzQjSpv0v/eChyYMxhKtzxsLYbfjRtEsA=;
        b=J4trMXOCdlZotamJ1c9PSB5u42g2LpaT42W9S3lTMICufykI3At19WUB8nbWt1et5d
         NaYe/AsGBdmYZkz4swrG8HoiTFErd2BI8D5AFcOB/2alLSMoNRSa9cE26mzG89AD/Max
         DzIZXmCwfy+VvW/mKKbe85jin/fQo4C33Fs8mKaciNEKRDIfU32h8za1qLurF2nTksyk
         nN0ip+hDQX3o7U0aZoqFXaZKQn6l/E+rQHqND9Mhc2E2ZYkY/9vLvxvEh904Xa/zSEBe
         IMFLTrLCAt0yr24bnMOVw46yT5p4jaHLWggGbyDJ93eJB8WEnGB7UE1EtQHWNGT7MCRs
         fLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731055042; x=1731659842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVqCqej3UEHzQjSpv0v/eChyYMxhKtzxsLYbfjRtEsA=;
        b=dI63G1t9ZkPRantTWd5VQMdQKhD05Jv4hw/8CpgdEGVpnX5L8H5a7039JRYe3Qf/mb
         dN6uu3JL67bk4gkg4U+IkS28fcUkmx95nWNO52mxVQYjoyxJgtmbxox66vsWatXuLFHH
         efvKry7Kx76bkIHj97w461lSgGINn3NUrrYZmuEKM0QHOiTKSUUr0WOb9qFftYl3bhyk
         wQuDiM/96+rQRL21jBl7U6bi15iTT8pHsCwbq8mf0oqd1mIJUXO10AH4vy5vRTmHm+IG
         8Wz32zz2dJpwfi0aR15qydIemogP6eXsc5As2j9S4nSVABQGy5wucv7ws8/hxBLwDf/A
         cDVA==
X-Forwarded-Encrypted: i=1; AJvYcCV8fHR60v5g/neVYDDPYilr2nY02D+fZKanvr4v99RbP7xPC8tV9pgglqWUS5b6q30Uv5i4hmnRgWqmtNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrFvsv4ngN+bUx/3iKujcdIN/5KJli5p3P3oTEdl1n/Ua9yRgu
	Ktfhit5SKe92/WVXBpd6v/lWPG1HZ7N1oJbYaM8QKOsNypDaBOAEfvlRfT7a6dNKf4pm6teynvw
	F7TXQ1Z3s600eSYt3dRM83N2HMONr13YNgP3Mmg==
X-Google-Smtp-Source: AGHT+IFNMbx//cYEjFKlLreQGe6KHnDtkiSUF8TkDB0AJS6zWunIMN9dfiGm3wfKDkFfc9lg5KxffwMABzLboCKR1AQ=
X-Received: by 2002:a05:651c:881:b0:2fb:628c:2580 with SMTP id
 38308e7fff4ca-2ff201e6d03mr10547841fa.2.1731055042295; Fri, 08 Nov 2024
 00:37:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104093609.156059-1-andriy.shevchenko@linux.intel.com> <20241104093609.156059-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241104093609.156059-4-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Nov 2024 09:37:11 +0100
Message-ID: <CACRpkdb7gaYW3FXfqZ=E-yC6071LEiv8hnyMD4Hh=bxJ3BEdrw@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] leds: gpio: Avoid using GPIOF_ACTIVE_LOW
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Pavel Machek <pavel@ucw.cz>, 
	Dominik Brodowski <linux@dominikbrodowski.net>, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 10:36=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Avoid using GPIOF_ACTIVE_LOW as it's deprecated and subject to remove.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

