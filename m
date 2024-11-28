Return-Path: <linux-kernel+bounces-424562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BAD9DB5E0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02798B273AE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5691925B3;
	Thu, 28 Nov 2024 10:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zz9shqQE"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21031917E7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732790529; cv=none; b=Y2cJQwG6CYyJ2gHI1fy3+Q9OUbFtL4zmZiXSRDm3gk2JWsI7x9iYltw79kHg2UNIaaUrzB+pdOmff7LGy9HpXwsaGKc39A0+kEXLkymmR3BYQ3lv0dFAioAAPy/Aw8KTroR3L4u1njv5G5uUtT0aMNDnPHUclsuj/jatzCvAmVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732790529; c=relaxed/simple;
	bh=URzW0D1T4YCAHqwFAbMGzXvStCZjMwIdqDPWjFKc35A=;
	h=From:References:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7MJKPdtSsRzv0xM8vkjKp2dmd7IJIm6aeibM7UJmXU0SwKWRu6CzagMYAf7BOdbMMS7XGnl3HVufiNP1YvI8JPSdKaG9waa8W+6XFMKXAi1KS5KqnAdD/eKalVjMWJZRzHYZ39SowqmdYSi5HWq2X1mOr1amYifLKKEyLjMnMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zz9shqQE; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3ea53011deaso358570b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 02:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732790526; x=1733395326; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yCTa28UWr3bKUmEGMrJfC8+idvah0kxCG8UKsA432Vc=;
        b=zz9shqQEb4QD4Og8d2z9lIaeg7XaSOn9tfS2aN7rRseqigKD/QUGBbx/yneEm7C7l0
         R2Dgx0rUv8Z86h2XKQk7Q7m/rL6Fc/JLZa7rv7QVrLxxYSyLavu9RprgrwbTn5TbJI7g
         qMfMI3NItnMPodID/hAUoukvwX13tmUyril5xwUsZ8Kx+v0PZw4BirJmUlFXzVv5mQzz
         BLEjPTFav2l6xbQw+YWffE7gvYvLWf+cIrBnQOEx3mZDeg9xMiksZg1DTPQMLrI453gY
         27LQVVaB4ax7z3IQK7om7+Wk/bxi6Et2/yx+Mvy081HRBn6g7Ij8Zk24fi0NBdVpD2yV
         56Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732790526; x=1733395326;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCTa28UWr3bKUmEGMrJfC8+idvah0kxCG8UKsA432Vc=;
        b=aW6vYN5Tk+IMQfjsVCpywVGnBA+NADVA2Y7NURqTdV+FIMfcHLf2E/jOfUPx1tuMln
         9BFdJ0Ov0mf8UlGwBqXM9aiPHdp5Z787N0HbbDKZ8HPJgLXIgCBCADmKJFEerjiEQpJi
         6gac3W+5uEHxSwpM7JMFjxuIF2EMNKkL+qJ7BqUxlB7COsMfYCxe8oViGbvO5eLsxaXi
         RGzI37YgvxSj/L3mZrqSSuLH2qUlpPLzf7FgW6Qt3VtpxmWO/DBqoDopAhlJF0xGTS0y
         zif+cR52bxs72BJKF3g871iRjv9gjw6cyK38V6FIrY5h814RrWodhankHF9OJmSrlz/d
         W6Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUap1kto39O9t/cHt8G2i/khxD41LTpazXBZQaSp+nGmFCqPFaar8QPc/129CXEbJR/996+EB9rq1HHX+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF9gkDtopF26DX4TIaSK5CAl3dkLgFHPBsiGfvYccAh4pw9iTF
	LeI5BIZs6Z/2CoAXJo38FVD0ZZ2xdElFCjrc+9K3Dpk6ELU5hGhqhPlAmOCGD3ZKfTRPlncuAo7
	SbPG2PBnwWAt7pYMWb4xWWSpGfOPrZCv66/8pZJxLfUyiJXPy
X-Gm-Gg: ASbGnct/uTYsX/C0E9DUlTL2hSHalpTW8RNSL/FIZTvMadTPzJ+4Fm2RlAigXJvBf4x
	weKBDGjdjfQ2AzapQY4NPr1vEOu9Fd4E=
X-Google-Smtp-Source: AGHT+IFyEQh4NUzoOYOOTiC5We+UX7R49fWSXxajTJy5QSnvA1oWIMmwleC4M2iaK5XK/OpUfaPwvwcOTCWlpRLuPwE=
X-Received: by 2002:a05:6808:3989:b0:3ea:519e:cc71 with SMTP id
 5614622812f47-3ea6dd9fbf4mr5559828b6e.39.1732790526060; Thu, 28 Nov 2024
 02:42:06 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 Nov 2024 04:42:05 -0600
From: Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.8.7
References: <20241127-iio-adc-ad7313-fix-non-const-info-struct-v2-0-b6d7022b7466@baylibre.com>
In-Reply-To: <20241127-iio-adc-ad7313-fix-non-const-info-struct-v2-0-b6d7022b7466@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 28 Nov 2024 04:42:05 -0600
Message-ID: <CABnWg9uMDSQ+iNfXCrLKptOhMx0pjmLQ7JkaMUPu+d7FRWqjag@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] iio: adc: ad7173: fix non-const info struct
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
	Michael Walle <michael@walle.cc>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	=?UTF-8?B?VXdlIEtsZWluZS1Lw7Ygbmln?= <u.kleine-koenig@baylibre.com>, 
	Guillaume Ranquet <granquet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Nov 2024 21:01, David Lechner <dlechner@baylibre.com> wrote:
>While working ad7124, Uwe pointed out a bug in the ad7173 driver.
>static struct ad_sigma_delta_info ad7173_sigma_delta_info was not const
>and was being modified during driver probe, which could lead to race
>conditions if two instances of the driver were probed at the same time.
>
>The actual fix part is fairly trivial but I have only compile tested it.
>Guillaume has access to ad4111 hardware, so it would be good to get a
>Tested-by from him to make sure this doesn't break anything.
>
>---
>Changes in v2:
>- Fixed chip name in a few places.
>- Add new simpler patch for "fix" that gets backported.
>- Rebase other patches on this and incorporate feedback.
>- Link to v1: https://lore.kernel.org/r/20241122-iio-adc-ad7313-fix-non-const-info-struct-v1-0-d05c02324b73@baylibre.com
>
>---
>David Lechner (3):
>      iio: adc: ad7173: fix using shared static info struct
>      iio: adc: ad7173: remove special handling for irq number
>      iio: adc: ad7173: don't make copy of ad_sigma_delta_info struct
>
> drivers/iio/adc/ad7173.c               | 474 +++++++++++++++++----------------
> drivers/iio/adc/ad_sigma_delta.c       |   5 +-
> include/linux/iio/adc/ad_sigma_delta.h |   2 -
> 3 files changed, 249 insertions(+), 232 deletions(-)
>---
>base-commit: 9dd2270ca0b38ee16094817f4a53e7ba78e31567
>change-id: 20241122-iio-adc-ad7313-fix-non-const-info-struct-92e59b91ee2e
>
>Best regards,
>--
>David Lechner <dlechner@baylibre.com>

Tested-by: Guillaume Ranquet <granquet@baylibre.com>

