Return-Path: <linux-kernel+bounces-408936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7E29C8554
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937A3282DBB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D541EB9FD;
	Thu, 14 Nov 2024 08:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="3Rv73PHd"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF811E8822
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731574506; cv=none; b=saB8vyegdxo1n1eK82tKK1KqlasIbCsizET1Zq+gvoCjxhuTmlpQbBlDXxRm7n+y+w6Er0UvJQtJIYxcMShWeP1bKz7aTeRsVyqOCq8T8u6+/V6k7a0H4Krevt8eUC7xh/t00lJZ+IE87BWP9nAJM8ZdFxoCg36hhX3z2ed9FKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731574506; c=relaxed/simple;
	bh=BRDf8b35P49ChHiIo8YMyiWPE3Z2iHuLyTWB6FjvoME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYGIl3mcnfDHxgR+k6HuLotDrovCTZJSdxTSMA8LiZIzj+ozNtpU0aD50f7k7GVpGB8RtrV582tJyi79T18HZzAbnT14zxrbeNfx36WTw4UjK3kg70ZizVBbk2dLmm21bNW2GMNhEH2vdooKvHFeOQyfwvfYb0rjAI2or1gnUeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=3Rv73PHd; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53da3545908so336622e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 00:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1731574501; x=1732179301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkBbJj7BfW/fDhpfQZIe1WHT5ksVj7BqqExH4/PtpYc=;
        b=3Rv73PHddv7S6psDMYskID8qeJyje0pQKX2wctynh3B8Yo1NmbKqmYs2zJNS0MyyT8
         jN5KFKi28Gd/gCExK+VRpiiTz7JF+2B4C1mY+AbPKAL9oCvDrhQV1sfsYrAzr4asYFOz
         aMc/WTYgjEyEQEkejEnkkpfyHS4+sYBsvGuIbSITudaw7nmq4cUMsKst0qn2itKp8I1J
         1ApCunBZQLSHyqBkKa6hTYwoGwO4/0eNeeI7wevFnQjH+nxxBMZm1lhfzWkgsdG1oyHA
         unV1d1w6zaLC2h0jltnrZgFdaDnI3hrm/Nmyv6E0b9+gtKSgM5ums/njWgTEtP2H60FF
         F8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731574501; x=1732179301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkBbJj7BfW/fDhpfQZIe1WHT5ksVj7BqqExH4/PtpYc=;
        b=S4wzKPrrwQkCeU3m6EN9u7nWwYwMbN082Jdv7gNE3LEaU0NjP2Zg+U7YVZC+TcVzWC
         OPDm0Em4qmVKnOOiyqL92Ext0cBwueoW8ivmNhaFpSSXWo0EBU/tD95gSoNI/y2JwKzA
         7VdaGDHB0JF4iLcRZjTnFPTUoHO6aqlh65o5/tiBbgZWZUViPKNb8tm0SjR+BwulfynP
         WQOa8REiE8nUtH19uMkzT8WLRIR2ifnRO4+TUeqvYoPyYmbD23wQFIO9gBDD8A9FGzoi
         mHC4y6GV8Ve6jiGgUcjcaycCrT6XrVk2tZ0hfrLqEEmSCVE1V8FIcpBrkq8kYrXEshJN
         7wew==
X-Forwarded-Encrypted: i=1; AJvYcCWbEcBEd7Yw5Y7DLR7GGq2AYAxeXHuNBtSQeKBoK4kiw/fYJZVFQiuLsOvoyBKOMV99Fz7Las8ubP+r2Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYq3UHBvA78oyFgiqccHRP6KdI50a6qtm5620yHlz9xptN1Zoi
	FJL1GZpqJsHmGLMxyPCkRGNYu0QvZ60iCmROL6pQfB6nlzBVik4MSdHMzRk/TdOr2EIriVNaXtS
	pcGdzZ9/FnJQhayO3APvdqM2Ai0yBchBPoXnUVVsSePqFB+se
X-Google-Smtp-Source: AGHT+IEwpPlGd9At63I8RuNf1kkhMFb10NwI+VOwJnq285RAFgNn8X4mjEzNpCGwUQ/oRBfOHJM0GvNfmlY1uctn4MU=
X-Received: by 2002:ac2:483b:0:b0:53d:a882:c2b1 with SMTP id
 2adb3069b0e04-53da882c2b4mr257744e87.26.1731574501347; Thu, 14 Nov 2024
 00:55:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113171219.2949157-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241113171219.2949157-1-andriy.shevchenko@linux.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 14 Nov 2024 09:54:50 +0100
Message-ID: <CAMRc=MeaDjhxAwmTcNZ+oHniFn4EWVEmfP8MdNWitmD+Rr=scA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: Move and sort Kconfig entries as suggested
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 6:12=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The Kconfig under drivers/gpio has a specific comment
>
>   put drivers in the right section, in alphabetical order
>
> but in time some of the entries fell unordered there.
> Put an order again.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
Could you elaborate on why you're moving drivers between categories?
For instance: you moved Intel LJCA to USB drivers and I'm sure you
have a reason for it (it's not clear if this actually is a USB driver,
it's not registered as such) but please expand on it in the commit
message.

Bart

