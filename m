Return-Path: <linux-kernel+bounces-527963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8891CA411BB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 21:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0CFE1891B7D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 20:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD8B23F409;
	Sun, 23 Feb 2025 20:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vfuLvirY"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8686C1E491B
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 20:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740344104; cv=none; b=np4J53BN4iFrc1/hJcwjWsDD7IV17fRmf2ALB5ZyPjd+bQaV4yrJa1ZuwYD9AGJl+HMNrVORcCClQDlAPi/1STUJZvtODSBTjZbyE83vOzcw4Mw40t75WroO/qV+yj2y/99vHJpvmvRrwmx1QOP1kqXiWTwOPx2MQDbdE8trkxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740344104; c=relaxed/simple;
	bh=+HXFPjewlMNAg7XWH8v++wunTGFuJg/cfE3DU9ZIQHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TludP/MutbwwuGNxo8KWd2e8Mb+Ij0wRJl7yuNaqW6eizo87CgvahCOR8UTeSlAB43m4xNAMEyVJT19NvqmlzMxvJueqgklvQdS8g3Pl2AecjkgIzJxmeoSgJ6pceUdIqUi/qEVBJ7gib/3kvOT5S1ENCj+XhWEKymjpjXfQlBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vfuLvirY; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30a2dfcfd83so36315081fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 12:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740344100; x=1740948900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4bxYkQ/nsKJRs2jIrffultr9wOz+jQ/89XsqJiCc2g=;
        b=vfuLvirYSmUEMyCebG2VAXPfG9tbN4R6byfFxRaRyj6dnrfi0avDn/Vu56NixqAwli
         OlLVTnD4O3abOIpLrEHS8zYegql26IygN71yjE9qhxSacKSxhG/65BGxkdOMwBlDMur5
         S+8wjr1kAFYq4XM183JS1Z3qgP9nBvjKuYYf/9IXfNi4gJYzRtzMhKoCrnDiL3kCq5eg
         DFTl4sK1UdBU9oxuWnAZpsSivLOX1jG0XRWbZbJY3gGXVcgAI8KtwTb5/nHCUEJLHaH6
         upY48OqSYx6m4JNe86YWuZAQRqwqG+t0t6s/9pDH3S1ZVVW4WV/32jI+NLgqZoYdlh1K
         lFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740344100; x=1740948900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4bxYkQ/nsKJRs2jIrffultr9wOz+jQ/89XsqJiCc2g=;
        b=vA+PIThq5+wFOS5dTL4cHA25H0J4ndns6TOMxkZ+SvHhFYwmn4QKmnzAnLj7QQExBp
         DaMQa9hBE9m8Sf2pfdMumyZGm0rzfXdsZt55zAEuwLyv0CoC1KyShMaJxTe80zk5b8OI
         dDWjjsGPFrYPoNfmlddSAzu/usJbA3TymEtUkF8x22cgdg/LLwXoKFTzYQL0IJ8X8zkb
         jLHKifnx6C6Aacz7+OOyzclxONGzurw9bAv4byIAhlEv0r/Kd0IYrufH231lw/jX+kZG
         4if5KBBTuTH1CqyYM59TkfTGrXpYiNWqmzjPNBRKVHTJqyiqp0HbT3dLhO7sCqFDmRYH
         kBIg==
X-Forwarded-Encrypted: i=1; AJvYcCXeKJqFfRb3CbgxzCws4hM67ZI1ZRCwkfyjFBlJlY3q687yfrgOttn2mLKyUYpcaEIXEuza2MoV15SQFak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCEwYtjKiK7EVQ1R8iWRYNBXtWUxSFBzOfLpjqFCROORalYXwH
	jdkomxWe0JSeD32p8djSenkboN+pbhzDes+WDL9Q/zXD3Bv/faR3IWavDuaAJV3q60cLwvBMGC8
	4RiS953KeU4mkDlA/Dq/FwZ8RYTNxZYRSbsCFWQ==
X-Gm-Gg: ASbGncsjpso1a5i2ooSHzwUdPAlp7SOnG5WworEyOXyUNsM/Q0zO0i5a8IIswh5eIm3
	G/0p/MZMR5Lb5/pobNQLhxvb8KeqkbWvALCkXnXnucepHOdHr5E/dsJfX16/oBr8PMnnkoEPtwf
	7Fn4GeoE4ah6avkwLND7w7EzNylT8ZCZBaYRUaIQ==
X-Google-Smtp-Source: AGHT+IFDn780/w8soVGkUXtHpzGjhzs8+k9JV2usxFG+k5/j8YX6aH0YTVHnszJEk/w/4d+aG7PWG2yBwM6p4Q/Ab2o=
X-Received: by 2002:a2e:9658:0:b0:308:ef73:523a with SMTP id
 38308e7fff4ca-30a599a2775mr39360531fa.36.1740344100418; Sun, 23 Feb 2025
 12:55:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9ded85ef-46f1-4682-aabd-531401b511e5@molgen.mpg.de>
 <CAMRc=McJpGMgaUDM2fHZUD7YMi2PBMcWhDWN8dU0MAr911BvXw@mail.gmail.com> <36cace3b-7419-409d-95a9-e7c45d335bef@molgen.mpg.de>
In-Reply-To: <36cace3b-7419-409d-95a9-e7c45d335bef@molgen.mpg.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sun, 23 Feb 2025 21:54:49 +0100
X-Gm-Features: AWEUYZnDGB9vf_rZcGPk3HcPzJBryjbD6Lns6ejuWLna6xFV2KkIANI-1IW21co
Message-ID: <CAMRc=Mf-ObnFzau9OO1RvsdJ-pj4Tq2BSjVvCXkHgkK2t5DECQ@mail.gmail.com>
Subject: Re: Linux logs new warning `gpio gpiochip0: gpiochip_add_data_with_key:
 get_direction failed: -22`
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 10:02=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de=
> wrote:
>
> > What GPIO driver is it using? It's likely that it's not using the
> > provider API correctly and this change uncovered it, I'd like to take
> > a look at it and fix it.
>
> How do I find out? The commands below do not return anything.
>
>      $ lsmod | grep gpio
>      $ lspci -nn | grep -i gpio
>      $ sudo dmesg | grep gpio
>      [    5.150955] gpio gpiochip0: gpiochip_add_data_with_key:
> get_direction failed: -22
>      [Just these lines match.]
>
>
> Kind regards,
>
> Paul

If you have libgpiod-tools installed, you can post the output of
gpiodetect here.

Bart

