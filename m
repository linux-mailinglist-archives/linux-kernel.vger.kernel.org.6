Return-Path: <linux-kernel+bounces-318279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205F196EB07
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311B71C211DD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 06:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E4D13D243;
	Fri,  6 Sep 2024 06:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="njYzfIHH"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1559F5B216
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 06:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725605619; cv=none; b=VOW3aa6Rbb5DpgwJG+TLk+C0pjgc3wcnf4/lbpIBnYeXgK5rcrgxDqkAPQUY63lXgcM9GGQ19BlQYvCZl/QbVUjk4p0mnbKaZBQSVD6+H7vaUab+sBXnQGEy9cOI87kqgO8jfhr7sU2YG5bx3912fMv1JMM3Vkf4iKvpy8scDn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725605619; c=relaxed/simple;
	bh=tnNsEtGtWFMm/bfDuYOYLc3H1LpokXva1XZ98SjaLQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hh9pH2wRH+57iTNiQffkkiV/KSkj+vH/xdeJcp+k8ZO8la0yYlXNzApVT6ieVt6Hl14+3eFL94Z4qkT9z9f/+YYJCqOJEvEDByml9zKFmRRDGiCr/45gCYKUNifOiQNitgIhSI9XxIMDLKe7WpKEHr8dzW8h9vjQmGBkN4S67fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=njYzfIHH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42bbd0a40faso14087475e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 23:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725605616; x=1726210416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IYW21oi9yH7QqhGx5jI/FXCYiMC05lPbcPdKcwx56g=;
        b=njYzfIHHAB2xpn10XVs2lqP1URgHpBnjCMw5mdJGzeEPp6nTr2eXS8/WTJdLaySurd
         T3PihBdn54TD4tbs4UyJtHd7q+dEH1R+XknkxQr2QT6iiB1Jc9Rp/cGaHIOCInsy3jB2
         FM5hGWBL6DUzfVMVZgWA4ZENaHIH+KAM5bgjxJ2MIQAcy+14ECWetPW8DcpYpeYfWCrd
         674Kgk1NJ+YN6xfVJGc4s4gL0NYZ8coKS910GmqossF/hXIv3CdOs8+MwDurx9MpZsVF
         tgp4dPW7BGo9eX8XXaxXeoov34XC2/DAUl38Cnj6vOQxlX/PWLeENWPdKA7CUHUWZ5No
         LOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725605616; x=1726210416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+IYW21oi9yH7QqhGx5jI/FXCYiMC05lPbcPdKcwx56g=;
        b=AjZF499zxG9cdyPxyBigNUAZezqRGaX+bkllsCqdixqRBSsJT+nyPd/3UXHJZqkmln
         JYRbAno0ZinSwFUXFRmV/1uo7bm3INaTOx1a7ZmmihUz4F0GZOFZ7Eq/SXiJnNVxxMLv
         eV7860qA69kPR6AIpOtKsqHF1yGJkBtERJoZySW+/i/6SfGZ7TvDHA/ctwNayXmZVAQh
         77e8YvrYH6uMwapItIN9h22uLj306ANVVVzro7D/Ea2Fwz1Nx0+qhiBl3sj1pWyg0PgM
         Y9G/5hY3MNAMqHAqi7DjLU4qpq+IZ5xVsqUAlJi3tQjMiugp86a9FM9ClVrdHeF2T9AD
         rDZg==
X-Forwarded-Encrypted: i=1; AJvYcCXLSDJjqJ19jKDTbCqyYfktK/d+Tlo1mZHDj/f3v7AimoZ9JQa0Aemg2sVRWkWv57QSEeD4AoHBojRkKMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy2BoFpDOWf9unIIgG/MarVTJRWbqtr9+z85hzSxQ7t1KtMy/1
	aIt7AiS4qT2PpMhK9JA8Vsu0+87B0rmUhWY2rx7WX1efRh7Eshp2WnMi4z+qTFI=
X-Google-Smtp-Source: AGHT+IHIug8Vy6nVa6CgM+WDS6SRKy6Pk2msF4EYJa32/Liac07D4IHnwN+x/z0KCsoTZpGMOkl6hQ==
X-Received: by 2002:a05:600c:3588:b0:426:602d:a243 with SMTP id 5b1f17b1804b1-42c9f98a268mr11474335e9.16.1725605615504;
        Thu, 05 Sep 2024 23:53:35 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b9fc:a1e7:588c:1e37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca06003e8sm10136765e9.33.2024.09.05.23.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 23:53:35 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Martyn Welch <martyn.welch@collabora.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] gpio: mpc8xxx: switch to using DEFINE_RUNTIME_DEV_PM_OPS()
Date: Fri,  6 Sep 2024 08:53:33 +0200
Message-ID: <172560561169.6345.488968579750809640.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904140706.70359-1-brgl@bgdev.pl>
References: <20240904140706.70359-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 04 Sep 2024 16:07:06 +0200, Bartosz Golaszewski wrote:
> Use the preferred API for assigning system sleep pm callbacks in drivers.
> 
> 

Applied, thanks!

[1/1] gpio: mpc8xxx: switch to using DEFINE_RUNTIME_DEV_PM_OPS()
      commit: 6b5e97c020060c2b8ad286002415106ab7034435

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

