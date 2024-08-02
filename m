Return-Path: <linux-kernel+bounces-273227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2301946610
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 01:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DBC828353F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B3713A41D;
	Fri,  2 Aug 2024 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y6KExnQs"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143A76D1A8
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 23:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722639909; cv=none; b=qSAEG1eS7yHADck1dDXm5yiTih0xcmJC2s1+kMLLw+tLZ1ygKqAsJBw2btP4z+LYztVa501LZrgRj9TronmmMfgyseF2zZ2hR/DtirnHfSQrF6H8vqaUQhwjLlrmoW73OTP1SZlr0oEsHxelr02+tmbqgDr/9OGYG0p9qwaCCS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722639909; c=relaxed/simple;
	bh=1l2HG0mAcYSPHpBTeVOshWV4YNWUADVGijU9aCZU+BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QBmSkqxBWfvX0qlXSFejhCUYMNe0lZbh+w0tkoNS3T/WzYEwMxbP78LxAGaYROZB7iML+Ww89Vy1ytaSzavTRpJG+JhcJDP5UdddpNXTLGoagcCzp9j1TxX/gqVHCVi2Dk1fjLwJiHdsteKFlyeqjlDykdh4h2MP7Tfd3n406tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y6KExnQs; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-530ae4ef29dso7714912e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 16:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722639905; x=1723244705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1l2HG0mAcYSPHpBTeVOshWV4YNWUADVGijU9aCZU+BU=;
        b=y6KExnQsmgw9PP2UEePfOJb8lDSOFRVN4+x6WXV9LaIX3SeaDDEKujVVewDRSfjYrs
         WK6gDIfvHlAKAj65IQwGbqN5iDlZ7S8LCVQY3T7GAjWU/QurNWIiLZhLYZk+O4CMzbiA
         3mjxeCQY0dDxlb+sYzVmQ14+xTE2I/b7b9zp8BQuePE/F2rS8lSw0h7OIgO66TDTRDzt
         VC0K0q+hC8zKrKL0fTJSFFewdFNqUSeMejgJ/fYwhVGL8PFUxUyKJNNyUHDpVDYqCOOV
         pQGgmC+AdaOn6S6rk7WlU596W6TnG2PWrQl3N5vlImrGvWOA4x8EAhFrw1Kv4Z8i0egL
         ME9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722639905; x=1723244705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1l2HG0mAcYSPHpBTeVOshWV4YNWUADVGijU9aCZU+BU=;
        b=PBakVQEt0MPz+P15mJ+tFUYmXVWsrc6DmohuPCDh1Hhxn1EZcqh9i4PKrSRBmSDKF1
         7WJ5ziQ+7JYz1ebOdqpuD3Fmku/T+TxUF50GncyuGgtAw7Dce/PSZFYqDWJM0syxIN5p
         DZxJkm3P2VSJTbgvAGKZ8YCTo20XRmihEVW8d7nPu8gpgDZbA4mFhXty0+9F6HTVohPC
         tHPFOLgzRsHCwkGRR26ajE1r3seeZiQsveZrh5O02j7R1s+RK0Z8cl08u23GpLHMCQG5
         qcTvZj2Yne9594n/yqcMjcqvE8NqniODp9fi1QQh0wr7Z6ZOOM7K3Mwbk9mBjiJXpvHx
         pr4A==
X-Forwarded-Encrypted: i=1; AJvYcCWbe2UC6Mk2ZfXlZAffzAME4DTTCxuZ4qC45lWIEdL/n7jhTLLbuFUBQvlPHJ3digonmYbEG1fvl/bWCiulr3YGoo4rs/0F9IdGNWCR
X-Gm-Message-State: AOJu0YxZfBuTiYnWgPcUsCKd5erCEmGtWL+mq9NA22PKL/6VyLsPZrab
	ulfsJD7R2XY+TcL/CkyLMBF4H9C5Ono8b/kcgUbrgE8KGGPhBesei4dzRf1mOik70ijLKfY/Lbh
	mA0ISD+uCYMqnmEFg9upJlZtevKzdutZzp9E89Q==
X-Google-Smtp-Source: AGHT+IHiky/rVdWthmVWKiSIzFDGUnJD6TaG3+/N+nw6JpPsFbuQqgGkLMWGevVLpwCKdyODEdsHUnS8HiVk3slTT1s=
X-Received: by 2002:a05:6512:3b95:b0:52e:fa5f:b6a7 with SMTP id
 2adb3069b0e04-530bb381097mr3600518e87.13.1722639904955; Fri, 02 Aug 2024
 16:05:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2831c5a6-cfbf-4fe0-b51c-0396e5b0aeb7@app.fastmail.com>
 <e19821dc-01b8-4801-88ce-4c33d1a9fd63@arm.com> <8f8c07c6-d138-491c-9ca0-72f82779b2d2@app.fastmail.com>
In-Reply-To: <8f8c07c6-d138-491c-9ca0-72f82779b2d2@app.fastmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 3 Aug 2024 01:04:54 +0200
Message-ID: <CACRpkdaX91Lb7esSNOHZZDcU9f5c5_-V4ZuGAvjBhxAs4uZKmg@mail.gmail.com>
Subject: Re: [RFC} arm architecture board/feature deprecation timeline
To: Arnd Bergmann <arnd@arndb.de>
Cc: Richard Earnshaw <Richard.Earnshaw@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Richard Sandiford <richard.sandiford@arm.com>, Ramana Radhakrishnan <ramanara@nvidia.com>, 
	Nicolas Pitre <nico@fluxnic.net>, Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Kristoffer Ericson <kristoffer.ericson@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>, 
	Nikita Shubin <nikita.shubin@maquefel.me>, linux-samsung-soc@vger.kernel.org, 
	Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, "Jeremy J. Peper" <jeremy@jeremypeper.com>, 
	debian-arm@lists.debian.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 5:12=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:

> Right, for us this is clearly only done for legacy user
> binaries. It is still possible to run an OABI Debian-5.0
> or older rootfs with a new kernel, but there are not a lot
> of reasons to do so, other than ARMv4 (StrongARM)
> hardware. The only times I ever tried using it were
> to test kernel changes that impact OABI syscall handling.

I tried it with the old RedHat rootfs of the NetWinder. It "worked"
but you had to create e.g a sysfs directory for the thing to even
boot. Debian 5 got its last update 12 years or so ago.

Security-wise it must be strongly discouraged to connect
anything like that to a public network given the plethora of issues
in that old userspace, so I don't know if it can even be
useful for anything. The SSH agent will be refused by
contemporary servers. Maybe if you just have 1-2 old OABI
binaries without source code that you just have to keep running?
Is there any such system?

If people absolutely want to run these machines they should
probably port OpenWrt to them so they can run a modern
userspace, and OpenWrt uses EABI, albeit with a hack, but it's
the best I know of:
https://github.com/openwrt/openwrt/blob/main/toolchain/gcc/patches-14.x/840=
-armv4_pass_fix-v4bx_to_ld.patch

Yours,
Linus Walleij

