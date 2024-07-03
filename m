Return-Path: <linux-kernel+bounces-239538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D8A9261DA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 158211F21870
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5C617C9F2;
	Wed,  3 Jul 2024 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MlVdVK6/"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5983217CA1D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013311; cv=none; b=KUSL5EEpXV5zB6BdoGIEyor7yH/oOK385QtjYMNVRvM6o6ri7lTR6flsBS3JPJX1DEIXmouAwAPBZCxnigU8Hvk5+MRLC6QNXo9i3JjndbZVDPhfXbacQAORYj7oUukF/mWKIO/9kb8g5JHL1etKSjEHvocXxe25YN7Avr+kH7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013311; c=relaxed/simple;
	bh=eXeh+odNiG8x4cyW9ttyv7RVPgMeH+bDRXBp/ntb5AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxpvXQU04tb4UXS/Dsc2CKsEQatkRJJYMl/GR7AdjnQfT5ljeDo968yLw2U7dMWz4AjO0L86U9p590tx/rIQciXglxaPF1G1Z9Kfp4YeR9mPA/a7rjNV49HBAquBU1mPACmQsya4NeHc98vu2YfPqrad982tnXBRSoHwWMG7RZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MlVdVK6/; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ee7a1ad286so16344871fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 06:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720013307; x=1720618107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XH47RNmUX1AGSr0QbImyT9elpUv6h36gp7mCFp6MkqA=;
        b=MlVdVK6/beA4npbdCAzgMv39IjfvLx8k+mcrNqaXj3Us5koXQIDlN/i+hVkL1qiXTU
         rO/b9EO5NbZte2k3jZKftE/UzZbzF1RXW18eXm8YFjjoSMX7dAfobuHeFFH8gcJLlqnC
         p87YjnNp4vtpBQPaAC3/AgyCZjxCmqsG+zvCKeeBU9b8bk6bdomaqud/b3KJNj10xo1N
         fzdOIir+XJxnfulwj4jUEF6rFk146Y5SCYRtBN/hgh4afvOcYeDupeIrv+Ch3KtovCls
         15Sa5v4hFj8OGjhAWdCTW6Zin+os6ED6ma19gYGMSfZv2upGyxC7CbT5PDcs0rUDIMto
         1EIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720013307; x=1720618107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XH47RNmUX1AGSr0QbImyT9elpUv6h36gp7mCFp6MkqA=;
        b=E/rITlEC7YOy60vbGDZAd0k4tZXEfW3T+aSZvHILvZj4hq+iRXJz2cR8BZaR2tN6v0
         tIUlUvG/e/bxx0zy3xKdVPyLwoc5o/JsnthYiiWSdlL/sWbjucPauBR+lNGcrSr7CRL7
         GNU3VWindbwGHtcgPzWTVQDy241kAFUsFk/5MXBGt9tXNAHXRyI1oX2VFs2dlwl716Ld
         NxRk+GrEg4jvzmnIztR/QKzLNu9Y3RcQ7iTE+A2YEWRXJ5/iTjs+P1LzzBnihVjXjeuV
         UxrMxdRLewwQi65BqK94E0A5qVrifvdFs5EBxuhq+iZXOIpuPLgyw/sO26P5WRF2C0Ni
         M7jA==
X-Forwarded-Encrypted: i=1; AJvYcCWQOzy3Q4aLOnsp72RupjwSbm9zevXeML9UOKRIz2QVvDygcrHrW7GQrQAfRkanlaujW4au2JKux4EMB+6JtyCdKaT+A03psccdSl1m
X-Gm-Message-State: AOJu0Yz5pttXUitBugqRhDY86ryerr6uMY35MD3cd8I+dq9V7v7T97MU
	5HOrnhg5HrzW2zxcQXmlZocHUaiBzOcVATo2cNrL6H1gJ7WJq3V0gW3P24tmzEw=
X-Google-Smtp-Source: AGHT+IF8+t0W+Jxcef2zPEJhg/UHQYLfiKh8V3SIvq9COfdpuCwDUDYiE5vlgZ1/wChFAeIeucnstg==
X-Received: by 2002:a2e:9d44:0:b0:2ec:57c7:c737 with SMTP id 38308e7fff4ca-2ee5e6e60fbmr73030221fa.40.1720013307158;
        Wed, 03 Jul 2024 06:28:27 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:c37f:195e:538f:bf06])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4258036d034sm137144915e9.43.2024.07.03.06.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 06:28:23 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-gpio@vger.kernel.org,
	Shiji Yang <yangshiji66@outlook.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Asmaa Mnebhi <asmaa@nvidia.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org,
	Mark Mentovai <mark@mentovai.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	=?UTF-8?q?L=C3=B3r=C3=A1nd=20Horv=C3=A1th?= <lorand.horvath82@gmail.com>
Subject: Re: [PATCH] gpio: mmio: do not calculate bgpio_bits via "ngpios"
Date: Wed,  3 Jul 2024 15:28:20 +0200
Message-ID: <172001329822.19609.1796927408061216237.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <TYCP286MB089577B47D70F0AB25ABA6F5BCD52@TYCP286MB0895.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB089577B47D70F0AB25ABA6F5BCD52@TYCP286MB0895.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 25 Jun 2024 09:19:49 +0800, Shiji Yang wrote:
> bgpio_bits must be aligned with the data bus width. For example, on a
> 32 bit big endian system and we only have 16 GPIOs. If we only assume
> bgpio_bits=16 we can never control the GPIO because the base address
> is the lowest address.
> 
> low address                          high address
> -------------------------------------------------
> |   byte3   |   byte2   |   byte1   |   byte0   |
> -------------------------------------------------
> |    NaN    |    NaN    |  gpio8-15 |  gpio0-7  |
> -------------------------------------------------
> 
> [...]

Applied, thanks!

[1/1] gpio: mmio: do not calculate bgpio_bits via "ngpios"
      commit: f07798d7bb9c46d17d80103fb772fd2c75d47919

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

