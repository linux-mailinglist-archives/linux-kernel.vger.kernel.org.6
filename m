Return-Path: <linux-kernel+bounces-403335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6DA9C344C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 20:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70821C20979
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 19:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F20F13B5B3;
	Sun, 10 Nov 2024 19:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="R7EVN1tC"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23981C28E
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 19:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731265716; cv=none; b=ZgKuHRYdQGeFqWUV0pLq+v+KQdknOxxvyrONSBl1VPQ9OhTaHReXnNWbBt0lmFV/HcIjt67uYmG1vWXLX1m2dXmGGvCtz7MyC4d2EoSvfOUIGiHhmt377ZpT1DONDu12scbvAALFDro2hUrotE14gDV/kIx80I3SgWJpvs6b81I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731265716; c=relaxed/simple;
	bh=xXN+etwg9O7UOYdLRxdTl39Khe4/K71I/I9+wx19X9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/N81j5NKhCt5FnPnxlcm8h7+NVNL+zVWFC3YvZLktOB1dqnCVYFNaWzCTYqeB90juH5OTAXbfTlkZU6SKfaVMPVB4HkU51mRhdUfmde/XtMRACO+vvlbDKBB7AcTVI9CsjMlPnp59Dkg+HkJhv99TKBwy9vIIuc6DLS7o+tue0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=R7EVN1tC; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so6380129e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 11:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1731265713; x=1731870513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fqjnt/nFLi/tMSpbX01ZlyKkF6+YF1S0IaJNRH9S9II=;
        b=R7EVN1tCfAPJmWLWpflEViZniHwCQC5xSGEpaUQ7Ku9yqe4HE/gFv0iXnYwZOyeXvv
         dY6oo2oWdGrCgLW88JCRVjgE+JGpjm+2jr3Fza9DERFt0oW39LiTYvBbVb0Z+lhyzlJJ
         RPhSy3nVukoYy5X/P59ayFVZ42d5Gg9MmU0CbX4/sNbRH07gwmB3hggDtyetaRLENvL5
         NRYNcGaOHCyEFj7OxBMcGl3JFOh5VrrE1jy/QyU/EIk9/G1CjKOYpn3MOTX5HrQl8kMD
         KgKLaWW9K0uwrCxP8JLZEvi8HQo/o5vWM5azrVXRBavVu6L4fVbsud8imE4sESD48ws6
         i9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731265713; x=1731870513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fqjnt/nFLi/tMSpbX01ZlyKkF6+YF1S0IaJNRH9S9II=;
        b=ld/nRp3sKFeJV3+YiU3oOzvJwzxEWJsgvnSFU2JKs7/qh4W19nni/qNKiqHRZbKW2v
         qpgCGLLmZGmeQPe3iR5uf2CPFIRaTU1HabOqBpcob8WubRZKPk8RjJbwFTvklS9CXwLF
         Yoc/FQzdCEIVkpxRvaa8zID5lZhtpHdtzXL5yycATZZdawWZKs4+l6avpNnTxLccdiG9
         AUB7jimmrnZ96uE7q6BytY1+Dy2gaDsBn/vQ30sMBsijIUdd9QeFUQr+IM3n3zjUdBQJ
         9AGDdn8PHpVzh6Otqi1T/OLTvP3D1DIbFtu8jn5xTDftr4Zkvte93P6ZXyNXLpUZ0tJX
         r6Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWAsnHxIN/SITLuOj/GHAmNvFccz9RdoGjwUPR9kHFZefyd1MYnxhjzvFz7MH+AWDQ46+tQiBr5g+lia8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5taMe4kXAUvd9MwBdKQ85wy5ogWpJWtloXyhsrJRFY7fnpfpk
	OrOQDtMyTu9O/1g2Se/Yim0cnIsi29IBbImduVnu3RkD115WydwMeA5R58Qq9bCpzbD2YDNdEx8
	ua/7UBd7kvmiwlSND2O4HjVqruD2Wg/8AhEsRBQ==
X-Google-Smtp-Source: AGHT+IEGLuibVTWrwvIgpmZkA7EFJyYxteTsXX8ieDWPZ8HXevFsPAI7Who5jrPLgBImZjSeCmMjGjqA1GRaIq6hQXY=
X-Received: by 2002:a05:651c:248:b0:2fb:565a:d93c with SMTP id
 38308e7fff4ca-2ff201e73c7mr36829581fa.1.1731265711224; Sun, 10 Nov 2024
 11:08:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107-avatar-clapper-93eb34ad0e0c@spud> <20241107-coroner-amino-5e32e3e59ced@spud>
In-Reply-To: <20241107-coroner-amino-5e32e3e59ced@spud>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sun, 10 Nov 2024 20:08:20 +0100
Message-ID: <CAMRc=MeVHx9u0oDT-cgRir474owqwPMzgBiPW9jFRbdYjnXbhQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] gpio: mpfs: add CoreGPIO support
To: Conor Dooley <conor@kernel.org>
Cc: linux-gpio@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 11:33=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> From: Conor Dooley <conor.dooley@microchip.com>
>
> coreGPIO, which the "hard" core in PolarFire SoC is based on, has
> different offsets for inp/outp. Add some match_data handling to account
> for the differences.
>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/gpio/gpio-mpfs.c | 38 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 33 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpio/gpio-mpfs.c b/drivers/gpio/gpio-mpfs.c
> index 3718121eb97a..4aefae05a9fb 100644
> --- a/drivers/gpio/gpio-mpfs.c
> +++ b/drivers/gpio/gpio-mpfs.c
> @@ -10,6 +10,7 @@
>  #include <linux/errno.h>
>  #include <linux/gpio/driver.h>
>  #include <linux/init.h>
> +#include <linux/of_device.h>

You don't need this. Include property.h and use device_get_match_data() ins=
tead.

Bart

