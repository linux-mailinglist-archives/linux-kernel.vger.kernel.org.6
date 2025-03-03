Return-Path: <linux-kernel+bounces-541434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755F4A4BCE5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A02169D6C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C17B1F2B82;
	Mon,  3 Mar 2025 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="3BeQndjN"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2117E1F0E5A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999143; cv=none; b=lO8YVh9BPniKvm9aXToTpmyK5hWSpsxF1Q0Wpbe1XX/y053wVYpFX+u7B4fpaYrxIY6MYJumC+Ok+zP0vyQ0vzHBP5KzsxCNGpU3AsweycIAsk0gB/jFTXwRrunHmMbHBDUW1CNUoCNfBfo8l80u/JsgjBjO0jeloqnlwYeZIII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999143; c=relaxed/simple;
	bh=jiHdE51xfDe7UWHKDk7UeUSBh/D7H7YwrHUywcZ5yvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JOtYq6q454sTRdzrShmrSx7PqZIMh/SqDj4zSzpvgzU0JG8+HYPbNYS5wkFs2eUkMOtdnzlm/4HSJg6VpioZQf8JOYNs6fIXZg1akYSlA8D1eALn0wOYBY5O0xs3MWtrfHg+1azGEBLkf5KGT0cuqHrGLGYB/K1OIEBOgJr1n6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=3BeQndjN; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3061513d353so44352871fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 02:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740999139; x=1741603939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiHdE51xfDe7UWHKDk7UeUSBh/D7H7YwrHUywcZ5yvQ=;
        b=3BeQndjN95Jh+A37g9kvmDPRt9+WvvvsF8cDPIMAG1EC/9WsOD8nfC0bgeKYQmfp5s
         oAI57o6UlWM28J4wVyPs93TmILFbBMs4arPdGsL84bwqF6OTmzxtdeADbI7d8fb8Vm5G
         x3IwPyDaLfeTLGr8lhqVWw9XhpallVg84txf5cTrcLlp/DhTOYsHdnXlH8T6+6D6jAPp
         VUWeHcP0quKcpU55IG1WkaYGySicWVS/3+4Z5rAmD34evYusaKhWchLfg4lIOj8wzky7
         rNn4yJe8hvLQx5OS3wiaDuKUfNsE/LTKGTPIFBnhz6KNtZ+XUZ5C3opNB0brO4EcLcPy
         VSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740999139; x=1741603939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jiHdE51xfDe7UWHKDk7UeUSBh/D7H7YwrHUywcZ5yvQ=;
        b=HayBoRlaByrgQiXv0v2W+0Av4Zy5uDmnnFQ10EiiyIfoA5GV3avsTVKEYPWS1G1qjn
         OHuZB0NtXeh+QiZmJXd0nap8/g/+54kQQMxjOSImXC13Zka9q3lEajRQs7Nh2LxLmp9f
         LCUkFKYeFhrUOkXZCJpVqYw6Y4d1pi+6ZyGu5vmyAuqEL24D0KEHv1zgA1QiEhF+s7ai
         7j8U7gR0A17LRLTXZm90Uk7J22fQ4MjeSGqs6YG0DAMB4egKtphvLvY9ANJJUaLPlv2r
         HCDgqFV/48N4YINnHFawcNhNCN1JocMcPoUjkyE571PSc7Yu71/DWkEO2A8svZVBf2qz
         azsA==
X-Forwarded-Encrypted: i=1; AJvYcCUkf96sk8DdvY75EPalLEegHDkekiUsgItoEoZ/Tw4uF3Faft0DbVbrtZdLWk+JwhBqwWj55px+fTJVKi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysk5dadtrO5ctNc9s6cBKcJvmHGILV3MKfmsl3KyIrBDOliCeP
	2FDhTTlkNPmnWwjlWRDrdgtMddnc4/mn8lzFbVTv3QldO44JXO8CFqe4i/LoA1b2MX7LXBmmeyt
	xNrSl81ei2f7qse3CGthKLzKmJaGfDF9mUmznnw==
X-Gm-Gg: ASbGnctVav8g7VwyBP5VzjQKXjuPKeZYSINhuEexWEu78FJCH3YEFUsp2c/YNBQQjhR
	pL3B2gXrGsiwKkxajVnK0WCAYTxyiTOuRCRcFdSSIjgAeivKoXgLp3+5cMsw3QbrAjRPJV/XM6t
	FrbQHg2eilMs+nGA2LG24AWg3puh19UvsunKKx94GZHV4bclxk5EPv3bXwhw==
X-Google-Smtp-Source: AGHT+IF8fkfV29Z/HA928OoGgTZHXhKuyAxLwcUqLae5A9q1bV5bQjlkE0VaGo4fkbUTL9tFTMn51z6IlDksQu53oso=
X-Received: by 2002:a05:651c:b06:b0:309:231c:c676 with SMTP id
 38308e7fff4ca-30b93259b13mr54096241fa.17.1740999138576; Mon, 03 Mar 2025
 02:52:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220162238.2738038-1-andriy.shevchenko@linux.intel.com> <Z8WJNPrD6033anWw@smile.fi.intel.com>
In-Reply-To: <Z8WJNPrD6033anWw@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 3 Mar 2025 11:52:07 +0100
X-Gm-Features: AQ5f1JoQMnxj-WCNLM1m-bQQM8090ZXf675BYUgTuNzV5rfdvFkUP1ykES3KC3Q
Message-ID: <CAMRc=McQMvbLc0OGa7JU_F7Y6Qw6-pUGK9EC25jfVAZNcTkzfA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] gpiolib: finish conversion to devm_*_action*() APIs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zijun Hu <quic_zijuhu@quicinc.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Raag Jadav <raag.jadav@intel.com>, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 11:49=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Feb 20, 2025 at 06:20:25PM +0200, Andy Shevchenko wrote:
> > GPIOLIB has some open coded stuff that can be folded to the devm_*_acti=
on*()
> > calls. This mini-series is for that. The necessary prerequisites are he=
re
> > as well, namely:
> > 1) moving the respective APIs to the devres.h;
> > 2) adding a simple helper that GPIOLIB will rely on;
> > 3) finishing the GPIOLIB conversion to the device managed action APIs.
> >
> > The series is based on another series that's available via immutable ta=
g
> > devres-iio-input-pinctrl-v6.15 [1]. The idea is to route this via GPIOL=
IB
> > tree (or Intel GPIO for the starter) with an immutable tag for the devi=
ce
> > core and others if needed. Please, review and acknowledge.
>
> Bart, I know it's still 2 days left till the two-week ping time, but sinc=
e we
> are at rc-5 and this may affect other subsystems I gently ask for your
> Ack/Review and I push it to my branch for GPIO (as it has dependencies wh=
ich
> are already in my and a few other trees).
>

I thought this needs an Ack from Greg or Rafael?

Bart

