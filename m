Return-Path: <linux-kernel+bounces-561266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 882E2A60F75
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20A004602CD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A4F1FDA86;
	Fri, 14 Mar 2025 10:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pi8MVHLl"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA131FDA78
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741949826; cv=none; b=dpW7Ee4QIlQCzL17Ckyx9KxDcBhaiG1Wn7mRGRElROOzHopRY4Ea78SggLt+9D+n+0P7LjMgzQd86eT7FGTSmkDHLMx93bLh/4rtM4DzBkL9osadPCIAD5qfMtwQNAYJqYhWt1c7t2RdiztSdWR0++N7/pEil+EysCz9412sq4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741949826; c=relaxed/simple;
	bh=96miNLq7hjmZ1DWvw2RWqPE8vNM1MzuLA2VCBM8nKeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oz0e9PTQPVrvMsp7VXkTxbTC+xgGLr1FT9MuX+A+W1jFIcXw/NGmp1nfwwM8J6uSTl8I4gzWh1nIaPFV7aT/dqUiSrGbWXSEflOC8ebCjWcvTIgKCbifT0K9jJjLgv36Zk4nwnQi/Ye4JB1ZSwWZGNvmcJwqj2qCY7x1oLmhSzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pi8MVHLl; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5498c742661so2169758e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741949823; x=1742554623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96miNLq7hjmZ1DWvw2RWqPE8vNM1MzuLA2VCBM8nKeU=;
        b=Pi8MVHLlipWSdjRAu0KR1I7EaMI4E5f1hJKZVKWtIwYUkKW7XhPYP9VeFgJRTjLqqf
         5bcQQ6IEUHmHu0bpOWgoiQFhUAVe+P5D8vBdlS0DTJ3CS3b/MrpvLoVh2JrhGPN7YRD5
         ZUZ5h+66AiqzdpAMkdtr8W5Ss4v3QtI8aGkHzrsHuNzjAyhfrK73eihEgMHsH3YXRK5r
         9asbjPMd86h9sZWbAGpqSDur7CCFFqOLV9gVqt8+JKw7fR9QmW4QNHrSRB/+aihq++h9
         pvFdQxR1iaLwaorU3B8pTUOmh+zToW/bg3UahfzD7W6peIlgQOmSUJPuHhC0ZKNjN2qa
         YF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741949823; x=1742554623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96miNLq7hjmZ1DWvw2RWqPE8vNM1MzuLA2VCBM8nKeU=;
        b=GlJLhLHwYWDQXSbWtzDK/2hYGysqq1ivBrwFznZrvV4PaMf5Uuh1Y8khC58Qaf+7qD
         voNbxHG5XoCjgCVdvUIDYH7rbfD3XTkZm7SPI9Jw7TJxRw5ccEiJI0Bd0ML5LWNv5mYZ
         MjvB/tUsmASS5w3yFKxjlTHoJgtXzIPgtELmLF26eiJkZBuIu7AQUmvQBkUz6UhNlXLL
         FXpQ0b8H0NMZ+jP4eFo4ps0yPLPsWYlujgEYOCBDT82ayrWI5HAWYTSxu6pngSxLBQBN
         wwq5cVvno1M8uZAQuEQZsKx5CvthidlZSZU8g7AGA2bfkTiOOxF/hxtv20WIQYlfjm9I
         GrpA==
X-Gm-Message-State: AOJu0YzLOCjsK2bL2e8ey4Gc7Ish5znKKkv5Fphdd38ZwgxBZkhqLgzw
	ByeQz4HkQUzblPkF/VpswAREQd5cRV5Ghxdd21kW8mYIQ9HeKcesRjTB68Kpm6CxDcIr2F1wYhx
	aDJrgwOGyN6wt0wLxwFPgEXQCYSjAxBx7LFIxyw==
X-Gm-Gg: ASbGnct9VIUhT9Hmy6FMsqrlARNugYJh62BCIdDXGArvrDBgTRi/RZf7PLtLg3Fx0BD
	9BkB3HvgPDoIHoaNthX616iy8DLBojTNPjd5RIASmUacoPLZYPa3RybwxWNNUiNpI0T5dBnEn6T
	lB09nHzde2+D/zsOb8LExORyk=
X-Google-Smtp-Source: AGHT+IFBUfIyEDOuJTN62TSknKdeCzQe/LcEGx11Lhh+Rd6KnxH9lfyrYhlZLPk9+k1t8FjAQaeRWWJZNCwHOYSl0Sw=
X-Received: by 2002:a05:6512:1386:b0:549:66d8:a1f3 with SMTP id
 2adb3069b0e04-549c39610d3mr563884e87.40.1741949823389; Fri, 14 Mar 2025
 03:57:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313142404.896902416@linutronix.de> <20250313142524.325627746@linutronix.de>
In-Reply-To: <20250313142524.325627746@linutronix.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Mar 2025 11:56:52 +0100
X-Gm-Features: AQ5f1JpCR7cVKXr0DimAAw6tMnp4Yn9xX72fQe7CHhF_GYUjU8nxmVAU7sY5xbE
Message-ID: <CACRpkdYzi=MsXf2fzTiMZgtdF=5pxDCS1jJnB1JYKi4bxB4UXQ@mail.gmail.com>
Subject: Re: [patch 6/7] irqchip: Convert generic irqchip locking to guards
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Talel Shenhar <talel@amazon.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Guo Ren <guoren@kernel.org>, 
	Herve Codina <herve.codina@bootlin.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 3:31=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:

> Conversion was done with Coccinelle and a few manual fixups.
>
> In a few interrupt chip callbacks this changes replaces
> raw_spin_lock_irqsave() with a guard(raw_spinlock). That's intended and
> correct because those interrupt chip callbacks are invoked with the
> interrupt descriptor lock held and interrupts disabled. No point in using
> the irqsave variant.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Talel Shenhar <talel@amazon.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: Florian Fainelli <florian.fainelli@broadcom.com>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Herve Codina <herve.codina@bootlin.com>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

