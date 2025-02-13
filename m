Return-Path: <linux-kernel+bounces-513612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E77A34C69
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B7FA16B435
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ADF2222D5;
	Thu, 13 Feb 2025 17:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LiDE+xmv"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8322222C1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469130; cv=none; b=S9Pdwg4uYiMd8rEqG7+qj9+8E/zy2W7ZaXKteWqbcvjcz5fqlqQfmAXiiG7r0RM7FQ8s6TtQFwmQaXCKZBJwVPm5us/657GnC9wPGH5tctMuAdQDONUAUR6HL/MQHOm44U3YjS20kbCP7i7f0mzVyRNUhHCOyiNbB/4ZJUGME2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469130; c=relaxed/simple;
	bh=1XiHw4tysHZjQU5ChfFDqUqFY9o9KtfCc8HnMsfBflg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fY7ad4pnPSGN/Ew2mYycBiLBSWBwxrmPfLOMRiIR//csLVzAF1f/+i2j8kE2h7QRe4T8XgYaefhvLFqSWsp8KTYXpS+f1EC6wepof12DT77mwyYBUER06AhS9gunZhKLF7wAX5LoNT4anpgm5SlSRzZoL2L8wF0WaADaIQpxLak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LiDE+xmv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43956fcd608so7908465e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739469127; x=1740073927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIQEb2lERL52AWDIt9iZmMWM1q2cL+pDQtCUvQlkWmM=;
        b=LiDE+xmvhnv6XWMILoHwJVG0p3FXz3tzoaQeRUDbzbTdV0EzLuMG17PGrUmT2TMAoW
         2g8UOBQolN1qtmSbJuy72CTTVluqzvBLNqtWAzBte2toDxTzeaS/ql8ZdLIxJCigF7r3
         1+5RchEvEvBrPptoYsJcQWDft8d70HKbENpdeBXKLt9TF/6eVGAyfzBSA2sVIxlokbmM
         T56M9oAQ28fP9fNr8KRbMFHCyQDensSYB0c0PUzsP2AuasnzFGnzv72+05WTkmoY8pjs
         mcnrpcCHg+4Jgk5rEYAVh8NrK87tKSGpCmVaIXA3xkZrRzhcotEFfqNt2vW6bny+Bsv6
         ChYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739469127; x=1740073927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIQEb2lERL52AWDIt9iZmMWM1q2cL+pDQtCUvQlkWmM=;
        b=Gb1HCCTRa4RJkFqkP5CznyC1sJuWBeKT47WmJRi2hb3o53e1Hmqo/+ZGTzL2uofQVw
         1aHBfBG1lPO1pARwHotg/TNLTUBmkD7Rhd6HKCdZiAxgisd2c/gEA3xLkMdmzG3Fcnkq
         LKyP5Uze2cuhAIyGUJ95fAgVjHznS1owT/lYLksv6ojMy4dPfWRKXAMCVNunOKtNak5o
         U7NtrZE4PS6ZrjKJqDIb1uwmA1RCWp/3CT2IN2z2eN4wa3Az2svmp7SgSETI8MJ/N3+t
         zkoQaVXh9Aef+p+FYKe/d1dKpyLoU8S+QHmRjn35RZzMhnK9jLFNdLl4o898pjgFQp2M
         FUKg==
X-Forwarded-Encrypted: i=1; AJvYcCWnT2lZhajfs9L5kqV6SGeK8cX+SFvnp0ASZFqfxf64IoxUr0Apw7gZBMjn76FpU/JeEfgSpJRguwzDniM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2SFiRGiMNhk6wJL8IVSZLh6U7Zslz9LZgnDcmLassjpIXmxnW
	+XbR+WO0D4lEDTou5+Scrwu9934i9FmFQ0dmmVsEgpz0cEk+hKKjHxyZ0UThS/M=
X-Gm-Gg: ASbGncuypKUVHnyVLVfD472OoYviREWzkeFV89dU6RzH9ay8RCnKDwHj30uPCsWh+mb
	PnZZocMTu/uh6NDm4QvuOzEOCvQVPMKEAbNdz25XjdnX82vAxF1dZEW7aWCyCjbRSW4l4oNIZTQ
	8GzhuwhCZn4xuWsa0Bn8HIxb3RBiVxwQ6A3z61XRbvm5ZK+CW/x/gLRFdKP14H9xf9fJVATbqr+
	o0fznvJQ5YniLOfhCv5ZbBJOf8/w6mqsPrwFE+wpt7UCveeFFQ1JNRsRURAF2oNTIyzVaW6fyrz
	FPI2tbCDWUGSXJM=
X-Google-Smtp-Source: AGHT+IEFgpaDe8oOT53TJfQOEINjGndH+ERgdUXE5ply5cAp7CoaQUpMOTdQ+mRt1C3jJ/fyYRIh+w==
X-Received: by 2002:a05:600c:1c1c:b0:439:3ef1:fc36 with SMTP id 5b1f17b1804b1-4395818fdfemr93388065e9.18.1739469127271;
        Thu, 13 Feb 2025 09:52:07 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:affc:1fb5:fa08:10e8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258f8c4bsm2467250f8f.46.2025.02.13.09.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 09:52:06 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] gpiolib: Fix crash on error in gpiochip_get_ngpios()
Date: Thu, 13 Feb 2025 18:52:05 +0100
Message-ID: <173946910471.103328.15879117296822484780.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250213155646.2882324-1-andriy.shevchenko@linux.intel.com>
References: <20250213155646.2882324-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 13 Feb 2025 17:56:46 +0200, Andy Shevchenko wrote:
> The gpiochip_get_ngpios() uses chip_*() macros to print messages.
> However these macros rely on gpiodev to be initialised and set,
> which is not the case when called via bgpio_init(). In such a case
> the printing messages will crash on NULL pointer dereference.
> Replace chip_*() macros by the respective dev_*() ones to avoid
> such crash.
> 
> [...]

Eeek! Good catch, queued for fixes.

Bart

[1/1] gpiolib: Fix crash on error in gpiochip_get_ngpios()
      commit: 7b4aebeecbbd5b5fe73e35fad3f62ed21aa7ef44

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

