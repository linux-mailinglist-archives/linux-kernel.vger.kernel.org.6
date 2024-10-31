Return-Path: <linux-kernel+bounces-390540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E469B7B0C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0F21F22237
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E348E19D06A;
	Thu, 31 Oct 2024 12:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="JgIsLpoj"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829E219CCFC
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378877; cv=none; b=N7eZfoWB2Cj72Ms0Xh4xnjQ5tBHzAhyZD+YefUUGonpOIC3LrRotPj4/yN44ACEAUK9WIMFOb0gf4QrZPxaGQ40pWbDyzV1wCc3ANOU+3y6PnYBWbrfDVz3y9f+qBuzs/AxZZIwN1nM+lbi0/a9op/Yn2Nayhbjbpa2G/comhCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378877; c=relaxed/simple;
	bh=CWpOQ4tgnjf2IEvw0fHIBZPVWojN90ESGJEHvLyLgkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=USKDRR1Joih3vwgOIhX5pFXxTzvMKfOKokgqw/Fz2EjFI/IeBloma8VgLVFrjPV9F3B5Kf+hPNE2fod5AhmcRgjOw0KH+a1arA5aHBxM7q2kTXMeM2ZatQDI9oK8vb5aaGb6nHPfpZwiFIDWueOGkX6qMqntRZHd+DaKqwYvJeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=JgIsLpoj; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d4b0943c7so541060f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 05:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730378874; x=1730983674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ozjNpRB8k0BYDxGSTteWtp0Ws+RxNT8u/Dulech5Ns=;
        b=JgIsLpojOdwn0CWvTvV9ip0mN5K5kwAKT+/LFz/sX6q3B16TXw6QE/yapdOdVfHajS
         WBr07ZcmNtO10dSuUcrCQrVH0vYR+aUcDRTs09p1AxPU0UepSKyzDuErHQ2TduyvyWg8
         71q6z6h3Ry2kB8KRuqw6JF0pi9OIf8KcJQ65UMyEROHQ+aO0ItkqA9V/5tGiiSG9UqYb
         jMExiXyo50cSwVELv9E6+L9BpvaP++BSTV0ILyZ5UqMAmizfHeA+hQ6E56jvqygMYSps
         4NElQbZrVmzNIimaylAp8aRpXE6nRIRdn42aHJS8hUadQLUE8RUfOA0zJ1WNP9a5ZckI
         zkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730378874; x=1730983674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ozjNpRB8k0BYDxGSTteWtp0Ws+RxNT8u/Dulech5Ns=;
        b=wlUdC6mUHfaDzfcHlacvX+i/6h8GA29YQOwhWmo7i+DuWSdC7wBEzy43Sf4kBMEDk3
         WTP25rGJkKPnBaalkYKKcHsdBHJiKRcBuUxUut8QCkZ2HH6qO3fICgKP4PKeKHw9qE4B
         pBqpNVnMkAItjbveMQG9oUqIEiT2EQCFd6AOmjrk1N7+rJJu0fjAXjQSsgzTS32gr2w7
         VnF70CHTBAjqyIo+tX2sTTmc3pirdQMsbDV/zeD1yRdIx1ksyynL1cDeWtymx0mC6nn1
         KAcWyx46+n/L8Mv/ZP1JjJAdcSsCar5iObW/6X8xqfgLcqNlfNEE2+RXp/ktxzy/B0ZM
         F0DQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9OiigRWhvQyT15FYzFNVP6XXumoH/+5qwG/fvvkmzZr+Y/cw8CYZy9yVcZhNrDioNY7ZoZVHdlYy7aPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBTffWSdraoHHZgvVzUd2X3lwPWvAKU10Y9SM63hSgzR1iO5Km
	apMmFJcezbjmYDEf8jl47nLAOtGsTfvNaCql+XknBdfdgsaZogc+SSxP6QU9Yns=
X-Google-Smtp-Source: AGHT+IGG4iH4sXrF3ljEdxhjg48rkSTIkGg1AidcJT9SmHAkovtw078Uox3MAJM8kX9OiR+PEipyoQ==
X-Received: by 2002:a05:6000:1fac:b0:381:bdeb:1799 with SMTP id ffacd0b85a97d-381bdeb17fbmr3041997f8f.16.1730378873730;
        Thu, 31 Oct 2024 05:47:53 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:a6bc:32f9:21fc:be97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116abf3sm2022938f8f.101.2024.10.31.05.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 05:47:53 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Mary Strodl <mstrodl@csh.rit.edu>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: (subset) [PATCH v2 0/2] gpio: Check for error from devm_mutex_init()
Date: Thu, 31 Oct 2024 13:47:52 +0100
Message-ID: <173037886486.8163.11106516180498915523.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241030174132.2113286-1-andriy.shevchenko@linux.intel.com>
References: <20241030174132.2113286-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 30 Oct 2024 19:36:50 +0200, Andy Shevchenko wrote:
> Ignoring error checking from devm calls is a bad practice in general.
> While not critical today, it may become a problem tomorrow.
> Fix this for devm_mutex_init().
> 
> In v2:
> - fixed obvious typo (Mary)
> - collected tags (Mary, Wolfram)
> 
> [...]

Applied, thanks!

[1/2] gpio: mpsse: Check for error code from devm_mutex_init() call
      commit: 5e3eedf55f13ef20ff475eacac30d1e6f91641da

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

