Return-Path: <linux-kernel+bounces-194003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4227D8D3552
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9293B24A44
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C1816EBF0;
	Wed, 29 May 2024 11:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="rrC07swY"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C301B282F0
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 11:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981536; cv=none; b=jWOVah8or7OjKC90DoK1j6E0J0RBsDcIMooxbtd3M9rD5Znxu12cQZDdhhiDy+NYJlrNNN0xs1aGmhiQjBltYDHfFrPS8m7cqujNLt/4vL+wsR91gTjqXR0Xq0nBwqTsY7LmRKZOZx9APtdhmcMk6eYxfiaPvjXufnGqhTyp7iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981536; c=relaxed/simple;
	bh=gjxeQun7tqJlaKIpr3hZCjEJL31ZtfkgnCtA0oYH9GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EomoZhiPlbtEdV+0zxgHIIpuRj3bFNOnismnx5iUKhVIZzZrzlmduoYB3cCtUyKk8GJZegUpORT7NuTwdY4yOONXwOmx1oIZ5Wx2xm8xW91IPIp4MEdt2XpBqDcVT5d4GjyoUH6hZBsXoGZ1FzlepjHHo+YY+/CG7tH3CKRKctM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=rrC07swY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4202ca70270so22764995e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 04:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1716981533; x=1717586333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPbMsrUw/l6uPe530j31X38fTdExWtJ5rpvDpF4l9bg=;
        b=rrC07swYYGzzJtcJH111BBDJgUgl9GbndyV61VjEJGSrLFYBriSfPqaPIJPVT75m5R
         T3OeQvXQJazvOEOun9obJ99+pYQ0AOGxfhYECTjL6BBzbfZlTL/VAPYswtMeFMB+khoy
         pcCOMxmPWOGuupIvd5OWgRNzR36mwHIIJIihx9ghOxBEv285ARRs4csZSgfFuLTSvoTK
         eOet4apSGW8ig5fLq1qoNgtUCn2fitfKgweqvl/FuPSPDj8MzTS2GWM2/xR6QwK5NGWu
         kCaKtiR/tfr6paSiQogkGYKvg5AZjWaOuki55bNi9bxLR6A1WbhNV1GcUPiLwHzsMqmB
         MC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716981533; x=1717586333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPbMsrUw/l6uPe530j31X38fTdExWtJ5rpvDpF4l9bg=;
        b=tGD4a4FukamXnf21QPy08Zt7oDQW1RcuFkHBlTxPOscM5/H3jy2pdE745m4ERL02E2
         96i9Ou1VbOjTK8O0OIatpe2sopfCrU5qwita6cMt4o9boadF9tIyE3ykAXDbTLtV/lG7
         UAv9BZeoJ0bvx+0TjsSS52/nZ6WX59FyFc02Q/9GUZsj34jWgSsEL9cbqYCs40vq5VG9
         fAZmV29ejLTklF9PFd/wExPkn1HPVR00IfqOtpT5x1HFFtJbP6R1rKNs8lsAu9+IvR1b
         tGICpFL3rdEVgPbIfpst/M/ihvz8pdKV9qjMxePfDznxdo6CleZM/s8le4yE7aiSYmJc
         qqeA==
X-Forwarded-Encrypted: i=1; AJvYcCXAw+eTWqHKK7pbv3cY1CvT9po1AVMg+OJZ9h6Uz4u1Cl99NH+emWVFCFKGjirBWbiowyjclvRjNb9bYhMZckLD0zWm6zqYBdv7HdUu
X-Gm-Message-State: AOJu0YwCiEqJqSIxfzRumuJeeSySSd3X3GWUggzm+fxY2gjNjtpecYIE
	7UVNYX6lmOCmRaDlGaexnv5VLlz2o6pr9IDJYs/+09vRLSJtAugWbujVC0TAaYI=
X-Google-Smtp-Source: AGHT+IG0Ij15J/SBlDpUfTD72vlZeHCExvCOlzN+u5QszYRUIdVXO3E/4Bk8VSxmnDXfJVEw8s51qQ==
X-Received: by 2002:a05:600c:3b97:b0:418:a706:3209 with SMTP id 5b1f17b1804b1-42108a99e26mr174961145e9.31.1716981533090;
        Wed, 29 May 2024 04:18:53 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:e6b1:4b58:a920:97c3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421010b9b02sm208360555e9.46.2024.05.29.04.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 04:18:52 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Etienne Buira <etienne.buira@free.fr>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpio-syscon: do not report bogus error
Date: Wed, 29 May 2024 13:18:51 +0200
Message-ID: <171698152657.19416.4759398595612990949.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <Zktwd4Y8zu6XSGaE@Z926fQmE5jqhFMgp6>
References: <Zktwd4Y8zu6XSGaE@Z926fQmE5jqhFMgp6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 20 May 2024 17:47:03 +0200, Etienne Buira wrote:
> Do not issue "can't read the data register offset!" when gpio,syscon-dev
> is not set albeit unneeded.  gpio-syscon is used with rk3328 chip, but
> this iomem region is documented in
> Documentation/devicetree/bindings/gpio/rockchip,rk3328-grf-gpio.yaml and
> does not require gpio,syscon-dev setting.
> 
> v3:
>   - moved from flag to parent regmap detection
> 
> [...]

Applied, thanks!

[1/1] gpio-syscon: do not report bogus error
      commit: ca09ce254a65fa0c09f3369724ee0477a7246247

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

