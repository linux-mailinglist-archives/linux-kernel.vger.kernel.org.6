Return-Path: <linux-kernel+bounces-311260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 961E49686CF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEBD6B230AC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D681D6DC3;
	Mon,  2 Sep 2024 11:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bmjy6fVO"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C9317F394
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 11:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725278120; cv=none; b=OrbKgZm5q4gEF7tYgPBHJXXXAYdvpGqCzTWr/o2QLKo6Khpce8w25NgZCDjbf14qM8uoL0mmipNVGWDKeZvD+ZxUWxC/FUfgT3goprcLC9ulCsrLF+ZN13gFlAbmhiqK8LpUrsO3sCme2AG3xVsAH+dZxxf2gWeN6tASXMBdGqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725278120; c=relaxed/simple;
	bh=9J7GkouTbYRkiXQCeY02KWRx8IwFXPUu0A8xf8Lp4u0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZGwf6tG38FnJmj7HuKANMzlsiYVfQRaUJPKpmOeWIPhCR5KxX7PG31NFebsVS8aodIyuR47ktj85dwzfzZaN9YgJYj1BhB640OCOVyAhf12H8k4IVTpmiWQMB50qAspvwyoWpOUvxlT3CcXLSBW17VZ9f8QWvm8yJ4nbIVuO4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bmjy6fVO; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-533488ffaddso5184436e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 04:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725278117; x=1725882917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9J7GkouTbYRkiXQCeY02KWRx8IwFXPUu0A8xf8Lp4u0=;
        b=bmjy6fVOZyJN/gaFZfcrQWacC4/u8Y3lHGu1DkSKzMKb2ZkWM7HUNETClw7vQk5yrw
         Nfy7CdbmyxxmtonZV9SYHh54ov3ZjB/JQDiwOz5XeI9vi2yBdvloeIUTwugPcpxKi6Fw
         VpG3AKkAoYj6ejZAh5q78hU9/4qVeOZuU4V4iDl2NnPfQRK1i2LJYM/en6K0VV96rkhh
         86TC5cy1pFbSccpNdaasOUdBvSKT6KFDYnPBci5APZx9Trl16mNzTJouo6Pf5PqdkvMA
         epf6hWya2Bbd8M9lWVIpEEa3Nfa1F+5FIvh6zp5KlZzxxyKYGUfUCpnLgY3m61lmsDkQ
         xmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725278117; x=1725882917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9J7GkouTbYRkiXQCeY02KWRx8IwFXPUu0A8xf8Lp4u0=;
        b=LCzuk2/NPWd0uGD5eAOebwbGSxAWw5jdwdMd48TxDwjl717P4zDf34JjVg9vsBBS2U
         SF419OHd2XOIq4So+sOHYJTFOwFoiwBvgba+KRrMzh33bncCFOl1DkTBB2Os/Ffxpwey
         mu1GkADWloOUYsWbB0YI96v9Jgp33Bh+Awqy2Sgv3f/iAi2WbTdcFjzr1rsjI1j7pZVg
         uE8pk5VoCr87JeepyL1s4mvvb2JWCvYIGfirJyotIByXmAfWrhcspPza97LwOoKsFXXV
         y5uldqdT0uBYRH3T0Vpkav0bQ31q8kHEysoT2N7lvaiRmodrzAvXfHmbIUeFoIkE+nuD
         emYg==
X-Forwarded-Encrypted: i=1; AJvYcCXE1sIpgWIhSev/3A2pR9TlbKCZKZgF1h4mBq8DrVHDmFMmvbg7ULyIe/uevLqjOVlMe65PgRWckez9cD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCV0YqiiqzJV/fd2Znq70ElpALtgphwnN9kXQkx39TJbGq5ly3
	x+yX386qx2NnN6EUapO4a29kJzfYJHy9Il93+HrbSPJy2y4cT6nwhCIdw8pmo3lpvFkY7YvXCtV
	OZPfMe+knfAUROjCtGJI/RZ/lGUTDjcwiV9d+PuC/RU1kF+6w
X-Google-Smtp-Source: AGHT+IEGE12FfStnUdBGy/2dKVU5vyf2aKrdPnQfwMUTc+zGFDGNenYTlMLP89onXE8zV0IWCEadu5GfRUaSGbS+0XM=
X-Received: by 2002:a05:6512:3b2b:b0:533:71f:3a53 with SMTP id
 2adb3069b0e04-53546b053admr8752543e87.19.1725278116390; Mon, 02 Sep 2024
 04:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829131051.43200-1-shenlichuan@vivo.com> <172527039219.21144.385699965145763717.b4-ty@linaro.org>
 <ZtWWoT75zCSB4g1x@smile.fi.intel.com>
In-Reply-To: <ZtWWoT75zCSB4g1x@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 2 Sep 2024 13:55:05 +0200
Message-ID: <CAMRc=McgnoZz0TuwB0nWAdiRyZ0tNkX9NUKq9THH1Hh0rPk9CA@mail.gmail.com>
Subject: Re: [PATCH v1] gpio: stmpe: Simplify with dev_err_probe()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linus.walleij@linaro.org, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, Shen Lichuan <shenlichuan@vivo.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 12:42=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Sep 02, 2024 at 11:46:34AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > On Thu, 29 Aug 2024 21:10:51 +0800, Shen Lichuan wrote:
>
> [...]
>
> > Applied, thanks!
>
> Be careful with patches from @vivo.com [1]!
>

Thanks for the heads-up!

> This one in particular missed '\n' (and yes, I know that it's not an issu=
e
> for the ev_*() cases).
>

b4 didn't complain so I didn't pay attention.

Bart

> [1]: https://lore.kernel.org/linux-spi/20240829033511.1917015-1-11162571@=
vivo.com/
> (read full discussion)
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

