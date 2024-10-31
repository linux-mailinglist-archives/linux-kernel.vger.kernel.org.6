Return-Path: <linux-kernel+bounces-390532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92B09B7AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18A681C21CA9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A81619EEC4;
	Thu, 31 Oct 2024 12:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="smlXXzfi"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD17119D084
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378611; cv=none; b=A7FPZaMvKCiINhSQzu8O+1W2Ew8AuIuvOVQrH32EAqhV0L7LTLGLSeEwb+1AG60ISaTA7TZUnSVKORgFODNvkcJyGWIRZlFYVL8TauSEhWNlw4NvlsRwiNzriqvtGk99b2Wl7rx8ENm0uKOKS0B3QX4MHqydV9TD89bgJB9Ie4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378611; c=relaxed/simple;
	bh=UN0TCpzuzjXzpuD/YbvswwIqzUFPFchbJ0W2UC09I5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q5Zx7LKpl8fRR8CLX6DUcbMWqEkzHRi4exj9LA3SJ8pZMpluyI4hWWUiknavony01wxNUSuqsw5tGiN0qm4XdEGdblfxKXntPcKccO/eOKg2K/tUOUhcXF6AaAIeSRUDPGkrDHSDHqhJsZKetn44EUgv1aLz3t1ok5vJdcCQhDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=smlXXzfi; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso6882845e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 05:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730378607; x=1730983407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NvAiEcmr3Bkqwa+x+z3wqEtD01j06Ynm63RukDU9ec=;
        b=smlXXzfimDFvtkg9sK5dCTfyrTy81XOVO4WfACg7zWxEsqJPKDPTuDAf3jZyWlcSmz
         cQiqReJJA4c98pQIHupMKGMjI0V+JXbnRQHVJ21fCqWFZqNLKMXQl8LoKrSZ0dIoIdKo
         jhT50KsKth4ykn659ZGM8MsfI5pl/FXhydTP+iSvs0KweghxlXpezZBLIx+1GY/XFHVy
         LbMre91Sd5NaKzjnxJkzadUQw2/cG5SowYuYZ7NKe2m+pvqIai3DgJEKyTVbkxohsjdO
         LywkvaTivxC6/FbA+y/Qr0pXPKyxJhlbOtE3tIgKyvGYS8lqidQweKalikreahxto7pq
         c3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730378607; x=1730983407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NvAiEcmr3Bkqwa+x+z3wqEtD01j06Ynm63RukDU9ec=;
        b=BgF7+Dw0jbAs6Fbw+nwc6X+HwhGTaIo3Zi+vvMLE0oPqF2HX/fUjhTAZvtqP61tFJm
         DI5I2vGsiX1xyvGszBFZVY52bqRKM4g7vxT+yg7erf4tqiwRY1vdEpLZryYcy03aBLHS
         2oqw/DkCPbZgpkWvf73I76Xe+KMmx2AdC0FOJgfx8RFXI+uv5nz25bHRojhmKU6J9pcc
         oW7S/Vu1JD5kTWjS/0TNSTBMYCCu1k85OecIc15AI3GoebUz5EFWg55c8ShNCzvydg7j
         BzS7EWy4TdkNks8eT3RvNGJXfvptfVHHGc8wtohOiKRE83HrkYINqyN1iszvwHDInXsj
         tz2g==
X-Forwarded-Encrypted: i=1; AJvYcCWqYW/0lP0cmKDU5PA92SfDWN9bT7K9tpzVMrMEu3Cxb0TebG5D1KMmNnvVkj/+k4xueGN2UzDTJTPaMX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdDDAc6M7NB+wPq5f6KRiUdCMcP3nDhmXOVoYF2VHA0kgnapxT
	KfAyjDKkBF8n3pR4YaaONZgyBKyq7mo7WcS9sDkyVJXDGJLWVpegPV4TJNfpsWU=
X-Google-Smtp-Source: AGHT+IF30i6ka1elJWPx3EArTq7Yjb50xuHjDZ5vtObnKFlbrvUrpV5QCfQF5TFFmJk617XgpXk/Vw==
X-Received: by 2002:a5d:4441:0:b0:374:c56e:1d44 with SMTP id ffacd0b85a97d-3806121fdf9mr12656862f8f.48.1730378606974;
        Thu, 31 Oct 2024 05:43:26 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:a6bc:32f9:21fc:be97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c1185b4bsm1999195f8f.112.2024.10.31.05.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 05:43:26 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Kent Gibson <warthog618@gmail.com>,
	Arnd Bergmann <arnd@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] gpiolib: avoid format string weakness in workqueue interface
Date: Thu, 31 Oct 2024 13:43:25 +0100
Message-ID: <173037860284.7463.3619742464937960411.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028142152.750650-1-arnd@kernel.org>
References: <20241028142152.750650-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 28 Oct 2024 14:21:46 +0000, Arnd Bergmann wrote:
> Using a string literal as a format string is a possible bug when the
> string contains '%' characters:
> 
> drivers/gpio/gpiolib-cdev.c:2813:48: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
>  2813 |         gdev->line_state_wq = alloc_ordered_workqueue(dev_name(&gdev->dev),
>       |                                                       ^~~~~~~~~~~~~~~~~~~~
> drivers/gpio/gpiolib-cdev.c:2813:48: note: treat the string as an argument to avoid this
>  2813 |         gdev->line_state_wq = alloc_ordered_workqueue(dev_name(&gdev->dev),
>       |                                                       ^
>       |                                                       "%s",
> 
> [...]

Applied, thanks!

[1/1] gpiolib: avoid format string weakness in workqueue interface
      commit: a22c9dc26d6fc522357b73858b13e29c58f49d64

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

