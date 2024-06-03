Return-Path: <linux-kernel+bounces-199265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3EE8D8493
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B3E91C21A5D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4271112DDBA;
	Mon,  3 Jun 2024 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="z1hOUD4l"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C496912CD9D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717423502; cv=none; b=kLhUNVEPIhsHtbLCxdM3+0EmUax69YI3Fp8EYgvelM+/bASba8Csiusy/hjDE5Lb/qeyISihImz4AKQSiRUhIdepqQTUIB7uj6+FdasXIesc7FO1lHrULd4jsRRhbyWNlTDZftiUWY1FwTCbEqYheLd4GOGAug9bG40BTWu/e28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717423502; c=relaxed/simple;
	bh=G4f+2ZW/3ucBMCoRsBpjGOH5yW+ZaceG3OT6WS8aXPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqe8MfEYEt5HHakpgaOydNRpJ2N/pQ0/BIFuEo7liak1oJzIfj3uXNWO/q9odiuE83VR3rdx9s3jeir2Q9Wwjxf8/TSTWV+xJAqbB2O4V0BjhA0smCaYqF/jX5kvaNr7f7ezvYrHwSnXUFyKcO+3TZa9nRLhO5SX0q4gOkv8Jvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=z1hOUD4l; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so25288815e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 07:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717423499; x=1718028299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHHrkzTNHT8Y9v7Qdrd00FyKMnY/+AxED92FiKgka+c=;
        b=z1hOUD4lYXClijK9HnSgQoAWu70Il2QxYRYAD3ofoT5vRpmLVpwuo3ndcOt49NBJLj
         nwVWk2XH9z2Mbae819dO0+BF36aPIP35etxSZXwV9kGnA3+ENwgZLrTzFcqQpn7plzl3
         HPGylMcGAA9ExoZJOwLLKCP/IkaJs8Hxuq46TjxjxEF0QTCszIAbtUL64SInYGhI7GHH
         KHBTHTUO1NQBmBXBP6lg9e7bcrRSlwQWCvGcw4AqFxdRFT4TkBlzE4DFM43PMU/oGMSG
         k2a0SJVu8Gz5e62RRZhXN0yY36f7gPPooVjZcHnDVj83n1NYiCd88DuCs1Gp5zgwtbZg
         YmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717423499; x=1718028299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHHrkzTNHT8Y9v7Qdrd00FyKMnY/+AxED92FiKgka+c=;
        b=W2fr0DdRV50soi2FQiRv11HP69LnzqmfSbbwXIldKF0fAj4eKLXorLhVa3bV9J0hKl
         R+fxjyVauH7xUzU8AeBSdpkMl2kqhk+mL46ssKhIT50TYRehWhd3QyHxxJ/tL3dgonIa
         k6Qk/qAg6yDLZu9wCM6piNZ+ENPfGXDyH5DfQp1LnjBZdHBGyusvNrcAo+C8lCTYKoX2
         KihgQT7pZb6B+wK4iO7ojv1tEJBu+Q7bk2ZUTe+ijKDt6IDrMz0wNIpfjlIZ10M8IcCG
         yN/URu+CmrJRkf9QLVAfWpX2DKZKyxIt+HwybnXkuCYN5IRe8jQVOOv4ahZkMJ4rAnzw
         sEcw==
X-Forwarded-Encrypted: i=1; AJvYcCWDLWVIBRLmtK/Y3oVIpG9phKhwFAwL1LG8xK1MA3GvbybeaMF6RsTvMYXmwnDg0hSZhO8/3iIl56FxKEbGbzXc3izmvCrYq3PcTiU2
X-Gm-Message-State: AOJu0YzbPhkwEJ1NY6fM1mDi5ckrZYmbl+yTisYfyqxECuL/J++g1vTc
	Q65tf02uF+bib93LSpo+km00hjxNupzD16ZlniPmjS6NaES3SXfvlvKZM37J+rk=
X-Google-Smtp-Source: AGHT+IFlbwh5NxoDD1hH1ceOedwpKVlOZmjCr5/6w7TvnD/6TGIJomsMmGHXFHQtocav9hBqytBkCg==
X-Received: by 2002:a05:600c:4f05:b0:421:347a:f0a6 with SMTP id 5b1f17b1804b1-421347af365mr61281765e9.3.1717423498758;
        Mon, 03 Jun 2024 07:04:58 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:5b1:48e9:27a3:7085])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b858424sm119321375e9.21.2024.06.03.07.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 07:04:58 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: make gpiochip_set_desc_names() return void
Date: Mon,  3 Jun 2024 16:04:57 +0200
Message-ID: <171742349210.67219.629258607780165404.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527194613.197810-1-brgl@bgdev.pl>
References: <20240527194613.197810-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 27 May 2024 21:46:13 +0200, Bartosz Golaszewski wrote:
> gpiochip_set_desc_names() cannot fail so drop its return value.
> 
> 

Applied, thanks!

[1/1] gpiolib: make gpiochip_set_desc_names() return void
      commit: ea95bd851068803eb37693b2e32111b88077c901

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

