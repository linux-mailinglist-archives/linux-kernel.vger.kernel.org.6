Return-Path: <linux-kernel+bounces-556007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13824A5BF96
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705A83B3395
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6270C25485D;
	Tue, 11 Mar 2025 11:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="RvJd4iHc"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBFD221F10
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741693567; cv=none; b=QBTWP0q29/tP0q85qckvJ2hL2Ku/veUKgH9Fz0M+djG+ZzsaHwGk+etqqWhBLvdhjvL0gYOMSfEyRgzNhbBCzLaxxsOrNvczQsLj9LDZupRHym3AQiKuoG9GZ4ZIHuMUgm0S9m4gSF/qq3YmxVZA0EV6IlO0r/WTLbeReeF5IUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741693567; c=relaxed/simple;
	bh=HlzzY05BWtlJR2koHJrBJ3eDmc59baWY962o/k5YXK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9gmlXhw3FVj1sGzPjyZuU8pDQD4RBgDTHjDcQpsRyL6aVHNxDDms2BHcUkZo38l3tV6hJf+BPDgjDmteav5ldNBIqDuPWo3Fvb8xgY0aydg9H/5+c730l00NvKbbrv8irv5NKq8ZdN6C+XxCsCVg0zD5ExeMiKqsg+QGWBFHhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=RvJd4iHc; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-549644ae382so6391863e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 04:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741693563; x=1742298363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlzzY05BWtlJR2koHJrBJ3eDmc59baWY962o/k5YXK4=;
        b=RvJd4iHcAz/8woGSfMGsuvVEttUlbLjBCQfSKSZs6gZzByjAdeRe910poRUOq+t6fe
         /4ZdYtTXa8/BA2DuWUeeMln3ugJw6U0hjoLZkBG67Utj4roV+34Byim5sDpcRV5mWZuR
         4Z7KP/n7FdHRP3VfdnbACljDt8gY4SrIO04oHAxScdGum8Tu1qyAwXVzIK0ZJMunziHd
         na24RM+1Uk4AkBkaIXeSiW8Rz6uG7q9e5c3QaF0vgNt2RsuyzF+GwMv1ooiUotdh4jJI
         ZH5SsmL5l7oSdd7wJSSw62LYT6q9J0e3Q8s/7qTX4/IDZbfMLQuP7PXlKxjXq9uEAF21
         8Z8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741693563; x=1742298363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlzzY05BWtlJR2koHJrBJ3eDmc59baWY962o/k5YXK4=;
        b=iqb0IM+VpUFnYVDCn0yEQCk5MIwf4Ze3Ww5X9ZFNVd8q6awrbyNvqwDtzAhx0l3rnt
         hbisaQbEPama+EEGLBtoXapV0O5CKLW+752ROL3uFawjTpUPbMgjcExSNd9hJChcNm1L
         JqDFVu9zFSz1vhhxcLit/RF0Mv5pctvKmQl+5bhVKzYuTQkYh2cSdKA5TXFCpS1rPHFG
         Lo0FwpHvm5ersPzSMH9+vQSsbT6dbKLz8aPqfZuNmA4d4zXy76V0NCc6fI5lbXoRCKYI
         kbQii+bZO7tJbF9UDKT3yUNvYqpeEXxqnCS+qlLwC8wFUIIMSWybcNLUqVxfhz9bTFW9
         VzxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW86nDkcYIJalHYLZ4L83bVw2iAGw4bGNAAOx55Qg6Zgw9EaD4+cGHCVCyh5uHbjI7MDZxAOBva1zD0zzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD8M0yBgQrS2oxBT2dWs+ufQIg9s/zda1WmOGHWG73DB16sRq4
	LvcuMUsLupHU+MRtl+uIdn4VyVwngkjzg9CeHRu25M4j09LNaZtEcY2IEqoqHrWKyaOdWIERNbZ
	om+wFXxcLyKYo2wM62JGHhlDzDq5KU6hyto7bMw==
X-Gm-Gg: ASbGncuDX7BHyr6J9FyJZ4THUmc8fyhMSVTH6LrrAnVcHjCiEYpKcgG4ok5A/iBmu/A
	tPQ1XdxLDx/OIaAsELWezERQ7cA16/dijUmTaQK0GcinrvC3pEdgv/j51EWxemQGuYDKr4FV6Bf
	nzUvL4v9mBFIvAcT+TwhLamH9lK9R4PxQnnSojH0JT7mA2AhcjqLbrh3g3
X-Google-Smtp-Source: AGHT+IG4TTEqvKKmU2492g+AukZb45PJtvegal8h8Xen11Z8QtCphiS4Y8oNyA46u4GkRFEnjLMwklQP0xpWjgnldJM=
X-Received: by 2002:a05:6512:ba6:b0:545:f4b:ed66 with SMTP id
 2adb3069b0e04-54990e5e270mr5969176e87.21.1741693562644; Tue, 11 Mar 2025
 04:46:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311110034.53959031@erd003.prtnl>
In-Reply-To: <20250311110034.53959031@erd003.prtnl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 11 Mar 2025 12:45:51 +0100
X-Gm-Features: AQ5f1Jq_7RVi4eqH6I3J4FQSDCj7bjjh65GU3qe_TbZeAh-Mej8_AfvoQOJZwNE
Message-ID: <CAMRc=MewC-7XFfWxPS7cmMycxo-62NDrUKFyjnnCbwqXQXWuZw@mail.gmail.com>
Subject: Re: regression: gpiolib: switch the line state notifier to atomic
 unexpected impact on performance
To: David Jander <david@protonic.nl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 11:01=E2=80=AFAM David Jander <david@protonic.nl> w=
rote:
>
> On kernel 6.13, after git revert -n fcc8b637c542 time is back to what it =
was
> on 6.12.
>

Interestingly: I cannot reproduce it. Obviously gpiofind doesn't exist
in libgpiod v2 but I'm running gpiodetect with and without reverting
these changes and am getting roughly the same results: ~0.050s real
time for 1 up to 4 chips.

Any idea why that could be? Can you reproduce it with libgpiod v2 (I
don't know why that wouldn't be the case but worth double checking).

Bart

