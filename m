Return-Path: <linux-kernel+bounces-289469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A36EE95468B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3B0E1C21BEB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C33172BDE;
	Fri, 16 Aug 2024 10:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="HfmrIPJU"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95710170A2D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723803085; cv=none; b=qIQYzFLZ94AzPgJNAqZlQUZulr+TAYn7vl/6jrZWe+krA9/gaKQxuX05LBKwSvdk7MUnxFCjgkw54q15lo7LEO3GkaCWp4r3V/NsZ0dMdUOhb4NrtafPVDLyYv2jAmPqQxfmWU2oSjwVyGfhJ9wAQvIwm865NN3OtXv2pPlYwSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723803085; c=relaxed/simple;
	bh=jgW8qR9dd1GpYhXPsruabtVGV0P70quPl95KW8r73/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KsS9boKd4oLrG1+kUL42ANPO3oyyx6x25WDwtShIRUMqKBEhwleZE80DMnOUCKHzswBTIjhOMgeV8olI/5ibs1HpWZG3xtToSUuhWVYlWPxyRQamWGQMohwWBE3fyXv1Q8ZwxMAMlMHNJEHhy0nH0LCVhjuPYF/Ih8/V7Vp67Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=HfmrIPJU; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-530e2235688so1966403e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 03:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723803081; x=1724407881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgW8qR9dd1GpYhXPsruabtVGV0P70quPl95KW8r73/M=;
        b=HfmrIPJUeFGdQACbuIm/vJgTJiMS6/uGIQl6yQY1SXYphCBrI0kg1z8Y4BgK0oRX1E
         X7qPmwzkEQ+GfZAAbnoJtBBoSap7wmU27zbiCjUtSITmuqypFjoTgnF5caRid8JglvNJ
         AhqM2wLZFzp1TMk5pTRtyTjIjrlGrSJ55rSkv46zcK///r+3PBSLhH2lal6Cza4D42tB
         YkJJLAzZCuWTcO7ZFUSonE0koWnF2MzkvnKTftcNVuWSEVwqAbGAXBnCwvexwHKhLDOi
         kmh7Y5vaZmD8IG3nXMkczFHX466Pag7H+5/xSgZaPUhh4R0YisyE0f3PK1FvyVAZKx3H
         aaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723803081; x=1724407881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgW8qR9dd1GpYhXPsruabtVGV0P70quPl95KW8r73/M=;
        b=f6KWt43F8Py0y7AouEaKCnt2eSO8lgSZ9NPGw4zPk2WY9J9xPi1EdX9BLv14uNjYxC
         TbUhEZsd6cjTTH4m8O4dJ+Rplyk7MAyUQNX7Mm9FD9JQKvbYWAR4piq/A0JRCiBK5MXX
         j0T9wgFctQ2/BoL7V2mkXMQW55pKrttE/QIT1QjXpFyt9EkJ2hXbbmnO02YgJgCiS32Z
         FVECVAsoOd0i3DGoHkWlataYcgNl3Hueaa5o2WzsxWa0rB5jOe7hAcwkAmoqQABzjqVa
         YRDB4vr0xUkAKZOu2BJ6vlRwbVXaLdpPDZiGpU6dJ+3BPXMZTeOMlgeg/qo78fZtmxWq
         DvYA==
X-Forwarded-Encrypted: i=1; AJvYcCUlbEodha1cklGovLjsI3yTV8qN0gXAjXZVt75RTL+PNfQz3FvagG7a6OCpZYmNa/yqAplCzLtp75gDI/7ZzKUJe4jh2lnY9GKZrrf5
X-Gm-Message-State: AOJu0Yz/0uGh6nY9OG2y9In8HHCKL4KGMtGIzJyopyyp5jbgqa3XCkwp
	EM9LFKWGfzhFv04hTaejNeHzw4sEBp2uJaC1UGT6atdxr80uD5SYrBCgLwHjkURV0nAW3cj0Xa2
	UYF85BOFelwMEDuSQkzevWeOkU/mFdcuqk0DX+w==
X-Google-Smtp-Source: AGHT+IFcVVXjGoc/qGWPxsaC0pBLaWdPcEgyZ2BKX13uQ6PcUDXE3ldI/yAxzls/u7L0bahDE7nlrnrf5QbmU71tWFQ=
X-Received: by 2002:a05:6512:2356:b0:52e:767a:ada3 with SMTP id
 2adb3069b0e04-5331c6e38afmr1553665e87.47.1723803080819; Fri, 16 Aug 2024
 03:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815071651.3645949-1-ye.zhang@rock-chips.com> <20240815071651.3645949-6-ye.zhang@rock-chips.com>
In-Reply-To: <20240815071651.3645949-6-ye.zhang@rock-chips.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 16 Aug 2024 12:11:09 +0200
Message-ID: <CAMRc=Mfok1T4xGvdKa54Hy9BocuFx5g4zrK8eSC3Qivhhmz9xg@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] rockchip: gpio: fix debounce config error
To: Ye Zhang <ye.zhang@rock-chips.com>
Cc: linus.walleij@linaro.org, heiko@sntech.de, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, tao.huang@rock-chips.com, 
	finley.xiao@rock-chips.com, tim.chen@rock-chips.com, 
	elaine.zhang@rock-chips.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 9:17=E2=80=AFAM Ye Zhang <ye.zhang@rock-chips.com> =
wrote:
>
> 1. Prevent data from crossing boundaries

I don't understand.

> 2. Support GPIO_TYPE_V2_2 debounce config

Should this be a separate patch?

> 3. fix rockchip_gpio_set_config
>

Same? And a fix?

Bart

