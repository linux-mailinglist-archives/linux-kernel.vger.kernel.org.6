Return-Path: <linux-kernel+bounces-242158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 136C1928472
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F922843F9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26845146583;
	Fri,  5 Jul 2024 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yJF9dsO2"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94431474D7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720170090; cv=none; b=W+bqrY8cq2BketA24M9ARg3QW2PQm+2UMxNNHJ3pJVu0nQx9QMjLicGioTiUEDDVrTMZVvrdk54WfYWtEov0TNoP9wFIVIMF2C9p3RulyBVONYNirsNT6q0Hwtr45taczWUDCZV+ZpSFAPtCnri8KDU9yly/SW53q/rmvZZ2m+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720170090; c=relaxed/simple;
	bh=k0qVBklCOoP4+/R7I0j3kCnzNa//P7JSSrR/ztL9apQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CAj37skR779IQSG+HTeoqAVJAPxboF51sTxeyhLhoFwzAVMYnDBuv/QS9VwD2SDcVlG9HuWmvBwehFntL5Ya6Qs9A1il21lB/qC1WsZ0kpmW5gGqAVL4xeUzuu7KmHlafnOwDWVXjFotpqOjvpoTSILFHxgZWGo2cFkH/WlxQn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=yJF9dsO2; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso13581321fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 02:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720170087; x=1720774887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPhHYpUsQgcCRmlLQq3hZc5zGjNgRA3rXYjA2LGa+90=;
        b=yJF9dsO2vXxdHwYXFAXdzoeWcqiuQANhEIuI/yunvf4VPFTgtkWsOgQXM/HF914I49
         fH9kXmWoo8r72RDsx0aaLBpsNZWjAeLi8uisGXb2mMRnhDt+ovXmfG1Xr+iuwGke0LoZ
         fzyPqNx+B0OOB8HSrBscOlDyXi3hDyq2qd3TGyUZS1H1E7nJyj6UaFECVMINbAvSZpn1
         NQMvC6B8SmSXcSUs8ZJoaEuuQPL8+Qq+zvlGRId0HUfVRW5mvIKtoOe87kQ62ibJ4KAb
         9fPbRWUiWVsx9rXA0R8oD8Cxt28/UzCho56LWZjS1C02fiy/PxwzzchEKWyCQ0kVlwZA
         wO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720170087; x=1720774887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPhHYpUsQgcCRmlLQq3hZc5zGjNgRA3rXYjA2LGa+90=;
        b=N4JqpVLnV3HNMlqkx2d9XBRFnJbbtgjJeiUqC8MMMWFaL+/IxaBTaLegG2cGw69T5j
         vGIRC8iSNGKRkficJG/QqMr9fHL9p8RWU3ZO1lUyPyXM0Ppz3xvftN7DUxvV+I8/Qs71
         6XEHhI4oexKw4feI9puBqwPz488SXa7TPFNlbiFJfnFFMBgVee/i9WmqNHEoKNEFuHLK
         QGKDVUhVZe0OJU092GIXg56RafUAa2EZM5FsvLvGu8ggJvB57WunQkZ/vW53usPPS8TK
         WCVCcVMuPmj4FKsxNNQflyX5LKUAuB4k3eqLk+NkJaU88E1AzPTzSXtMYYsES0uYGEpl
         TIWg==
X-Forwarded-Encrypted: i=1; AJvYcCWohi9VcI/TNDwW9Md5oarDp9DNjl9GEtVSIAqbR2F7QG0xCJmqWoI4aJNMWzljAH2x7ThuEKWPutpu9K1XK1+LYbwqP5XiWSyEOgug
X-Gm-Message-State: AOJu0Yzt1WMardp2h77YfbjuVLUa8bATbwja5uIsMboTITy2dc0IWf8L
	iiTndAkWfkuylUn7hMMH/1mM6m0tXUBbpICmuMWtaiEKFT0a+GMqKh8Z8dEki+s=
X-Google-Smtp-Source: AGHT+IFfKAMUyESiTj9ZH1wVd1tZ9VI7h8RYpOsIVHzCGwk5qX32mBZjImpUvDBGNxEPRTzxrgKq5g==
X-Received: by 2002:a2e:b049:0:b0:2ee:8749:d49e with SMTP id 38308e7fff4ca-2ee8ed6b8f3mr28611291fa.10.1720170086744;
        Fri, 05 Jul 2024 02:01:26 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:c688:2842:8675:211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d69d8sm53190495e9.19.2024.07.05.02.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 02:01:26 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: of: add polarity quirk for TSC2005
Date: Fri,  5 Jul 2024 11:01:24 +0200
Message-ID: <172017008185.10806.14182341575808451693.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZoWXwYtwgJIxi-hD@google.com>
References: <ZoWXwYtwgJIxi-hD@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 03 Jul 2024 11:26:09 -0700, Dmitry Torokhov wrote:
> DTS for Nokia N900 incorrectly specifies "active high" polarity for
> the reset line, while the chip documentation actually specifies it as
> "active low".  In the past the driver fudged gpiod API and inverted
> the logic internally, but it was changed in d0d89493bff8.
> 
> 

Applied, thanks!

[1/1] gpiolib: of: add polarity quirk for TSC2005
      commit: f8d76c2c313c56d5cb894a243dff4550f048278d

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

