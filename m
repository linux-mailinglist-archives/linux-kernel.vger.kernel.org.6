Return-Path: <linux-kernel+bounces-561195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DCBA60E9E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0FF17EC99
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA65E1F30BB;
	Fri, 14 Mar 2025 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2ItMKjxf"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A061E5B8E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947573; cv=none; b=HIb/wD5R2uK3+ukjW7Y2I1IzF3f20iq9O7icJcHRTWoi2dvam4ChBjdVrHyHCjesl3+pLGJk+CbVj3io9e4Lz/xWlzjtg05Nz/DB+QXdW4iY2UQVDBDUZDB4kK0Lj8wUJviD0EjDpanchn5QQ8VhU8eE8KEwIXfVUDcMoHa8msw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947573; c=relaxed/simple;
	bh=8+6+nBnmssPPC84K1/VxafkuSkp+ixBcMCR/vO1NxVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SZryl+xkFMVcM1t2uzTt7hTK6wDEV879gNvOcTvmNjKoAm82pL4fUrdWn5W5t1V1m7zEGjf7cxnROUQsQiQzDWNf5Ejf7tyMyDQ7l5bGCMLx4NEbdEKUNTGCjIVM7Ol9lKmlKLkOx3Ret3s1uxyZkKzd25dK0JlhNJupNnc7LJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2ItMKjxf; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30bfca745c7so18347491fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741947570; x=1742552370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+6+nBnmssPPC84K1/VxafkuSkp+ixBcMCR/vO1NxVw=;
        b=2ItMKjxfEZ8XLGoryHit8w7LEDmQj9AuDy425pKvhsYKyyE9VLRPjM33+SYVzcNC2o
         Ji9N+xtFAw91UQpIAetDU4b+YranmlWh5BPsUw94ZCykj/FIAPH28uEzoBzAJW1bh8bE
         s3MKRkDrZIWIxRuE30WNetxa9advxPbI9YlYZxMyXx9sVTOs4QaZaeLDYp4ynpLkZgej
         qJG+VyY/qAxoe+vNaNEG3RKdgQiMm6m0+qgk8gK7KffJlMTXMguwfQg5GXCaW6O9XzFJ
         Bp5rGZo0/z+fLfxRhvNSLZT03wZL7mw+yq1zfNvZ33tGVui4euj3SwzH3NcH1kdXl/Ew
         UYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741947570; x=1742552370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+6+nBnmssPPC84K1/VxafkuSkp+ixBcMCR/vO1NxVw=;
        b=eSmVez/xNIcuQaHaPYR0v/lXadfRE7TRppSHoz/3GHYzAAo5ecM4AUaHy1G68dgJXL
         K5PNA/FrxQGa7vv6ZymQLurVasz3ol1IWa4zj5EUJxCys8p9XZAdYr/PGB1WEOJanD3X
         GstQjlnto11bGhb7gQ40kUu7KXIj2Py7IdiN+l1ntswpCwaUdyFKe94j6cMXegTBtlE+
         Z8yUjlw+DEFIe26LgDn0pL462szP48kG9Ehguew2WBi81MLxQTNJd+d4uiZ0vmt8Gctw
         AhGUbkP4Puqb8wm30zSFEUnaZoqarCExljUwQdoAYzohNZuZI4XGAiOz2Rfff2Fbn3Ro
         YuTA==
X-Gm-Message-State: AOJu0YwPfpxlT+a5HGw9tlubAB7Qzq6ksg689K+l2sUCTsH/BKOPXxJn
	TVqqx7AxowU9smrGGX7XlebjYv0eDTAVoT9FklKxNtck4mT6r2u8b8Eg+4OU/cTl9E4YQBzNx3O
	uGka+waI3YxXy3VnJOUEeluY2NzDCmwYC97BpIA==
X-Gm-Gg: ASbGncudCr4V66snPmXJP+7auRgXqeIFABQUKXzlMHvwvhNKtBkbha0bML2wtuPAWOO
	ZvXWu4OYR+tj+qvA1RtjqaJZIQu2XtJxwQUWbenrFSYupj1WmUexiMVxq/x5oVeDptXETG3SpxZ
	9bRPmyKevwHsD+aNzUDd1U3DbEucg/5JfqWWAXbZpr1NW6HbZ9sPru4yvx5dn8hIX8duOs
X-Google-Smtp-Source: AGHT+IFi0YOLIA7Rd+uD2OjZZ0dCQsd26AOLRlBfDQneHZg4T0+2f3FHz99vH/xJN1Fe5bU4ZmkVrh3tUjbetjvaHck=
X-Received: by 2002:a2e:bc1d:0:b0:30b:b987:b6a7 with SMTP id
 38308e7fff4ca-30c4a64ead1mr6813991fa.0.1741947569746; Fri, 14 Mar 2025
 03:19:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313142404.896902416@linutronix.de> <20250313142524.262678485@linutronix.de>
In-Reply-To: <20250313142524.262678485@linutronix.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 14 Mar 2025 11:19:17 +0100
X-Gm-Features: AQ5f1Jo7lLqPUNkPMiztzAYLokiNFSlUwJqNuzhYxOItPxPav8yaBkgbVnTsUu4
Message-ID: <CAMRc=MeO7r0a5JFtmBAUEO3CS3gFyowr2O8brB0x88kwLcqVAg@mail.gmail.com>
Subject: Re: [patch 5/7] gpio: mvebu: Convert generic irqchip locking to guard()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Andrew Lunn <andrew@lunn.ch>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, Talel Shenhar <talel@amazon.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Guo Ren <guoren@kernel.org>, 
	Herve Codina <herve.codina@bootlin.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 3:31=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Uwe Kleine-K=C3=B6nig" <ukleinek@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> ---

Is it ok to take this through the GPIO tree separately from the rest
of the series?

Bartosz

