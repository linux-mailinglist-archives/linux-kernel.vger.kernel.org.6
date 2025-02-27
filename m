Return-Path: <linux-kernel+bounces-535771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB91A476F5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E2947A3CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7362222B8;
	Thu, 27 Feb 2025 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LYFRcNm9"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06001E832D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740643101; cv=none; b=oM2QbF1ncBo3msv/HBw8b7itI/5ByIB6EdI8L9s6ReAT7/XW9la9dhMHLOH523kl7TW5r7jLoOkBbA5o8F30MNAdKJ4n0DuodZi44FCSK3+58Ya2Qok8pP35Y2MlPv34ofqbJJ+xPo8Dsvhl+DWCBo5NDBJG54JUKOLmbYwARfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740643101; c=relaxed/simple;
	bh=dBUoo4HkdPsPB/a09rol8wF45I3Q1kMtFXdsaoK/dik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfNZL+8HF/ztLoXa38zfEqHAsI7QA6VN2ntpZRuVjAA9Eb6kwIzGrXlh0Uwkc7s3GBXt+ha09ZBaLJ13ME0Qdd4vDVdFLXVoyZFTjqgHvaVYpIwwtQkbyaG7O0UG97jprC3xjWi4up/9hv5rAj5XO65HGZPSDI7RAZSeYqwQO54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LYFRcNm9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-439a1e8ba83so6084475e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 23:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740643098; x=1741247898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TN/1+Dvy1pIWqRV2HfuQkQI4NcLTbUVzevWMjjLr3SQ=;
        b=LYFRcNm9wKn7KdMsUwTk1BfGHE4RNRz5m8k8qCYcD3tBfbA9qlJqwvfwl5VyNhhq3e
         58g60rrXZL5xMLQsYRs4MS/TINoPmgbm3oz4n1GB45Cq04FFLcFhPF++GGAJHJqQgvwT
         meWdFKdK+EPPskCKIgXfWIvXsmFRaywT5JBFC5dAlPjvvSTOKU3qM4KJ4Y1F4VGt+pJ1
         avjvyXVhe0Er6fVoCh6WjgxkY/r7JBqFKffjvaJmYic/5Em38dtfJ1deHs6AVtEG1UnK
         TrmwRE3L5BEae3FpohDmsAbwC6pEyqPJRNzN0wQaxg1FniGaPqMtjUNf4WzZfyN3EFUD
         +Mqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740643098; x=1741247898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TN/1+Dvy1pIWqRV2HfuQkQI4NcLTbUVzevWMjjLr3SQ=;
        b=PjuWyRCI0Ma8Jnozr2adMA6p2wYotIvy2CTEJkknMbjX20MW3a0V5QQNMfg7k6tyOV
         Gvv0N2xGKVhY7lXZiY5kLhft6ab7FFJYCc2BYwjWsYr/nOPTvSu5fSwCUaJb9WjpHVVH
         vJU2EY27UXb+yqW+Ed4h+AS6V9gC6QGiW/wGco7fxRGHQLVgDC3TNfTmFIgN0AMMbMWD
         IeYmPCGsETPiooR65+XHlOpKAAJbcm+d2kiZxzTwZM0h0tT7czRvxjsB5xuze46qBONo
         BW5W62bhycM/z2tIZdTyX9F5MTNnccpji4ryDg2mqZXzGpv6vL3j31wO79QnyX+MeGHj
         mRkA==
X-Forwarded-Encrypted: i=1; AJvYcCVyPqM0RJRdC0mOTGbwxUD01V/Pchj3awRK7cuLkOJQ0cfAhrdGFGyMOXeAuR2dJCjxEx00t+xy+Uz1QuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSncnPdhiF+Yeb9pa6a2TNL6zyED54U1+VhDariSV1elUMNXdA
	lG3oCNwFqzLwC8dLbSphInnbkYAM6nJe47GpZRsNak7oVYGNK64DGfM2sq40pP0=
X-Gm-Gg: ASbGncufNSV5qrggGLBEhQki7MWf6YQG+prPev7jA1snnnXFe8SHYlyU7ifM2LLHrNr
	hz9eSb8RRBCrpUs09xthlB5afIWOfZ6MzePVpTUfrEcZuz2KpS8BbR6nViEkCmG+CYHUKt/2xDs
	Aj727HrdpOZJ7ivGH2lGXM0kcKDdoajpA3axP2FcIouGU94WFyabPCZi32QRzQ7/5ls/+ICw4Ws
	byUuikY9oRlWmdWQXBRMYxlRaG6hF/uc1hVDsiEEoJxGc3MG9M/hy9C26JPz+NpvduZmSksugWq
	0LeLUBIz8ZicGYQy63XsbZyHSw==
X-Google-Smtp-Source: AGHT+IF3sBOLZBtF2H3ra7eCA0+civX2mMDDIXML6HJy3fFHHapQwfDiYWARVRPHDLlUQvdKc+mSSQ==
X-Received: by 2002:a05:600c:5489:b0:439:86fb:7326 with SMTP id 5b1f17b1804b1-439aebb5558mr174988355e9.22.1740643097826;
        Wed, 26 Feb 2025 23:58:17 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b50f:c403:bf52:2dbb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba52b947sm46155715e9.2.2025.02.26.23.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 23:58:17 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/3] gpiolib: fix bugs in retval sanitization
Date: Thu, 27 Feb 2025 08:58:16 +0100
Message-ID: <174064309353.7700.4012102526424090624.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250226-retval-fixes-v2-0-c8dc57182441@linaro.org>
References: <20250226-retval-fixes-v2-0-c8dc57182441@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 26 Feb 2025 11:12:28 +0100, Bartosz Golaszewski wrote:
> Here's a set of fixes to issues spotted in next after queuing the series
> adding return value sanitization to GPIO core.
> 
> 

Applied, thanks!

[1/3] gpiolib: don't use gpiochip_get_direction() when registering a chip
      commit: 9becde08f1bc2857cd66f847eca2aaec3fc05c21
[2/3] gpiolib: use a more explicit retval logic in gpiochip_get_direction()
      commit: cc78604fd4799a8e8e9d23ea4898acd6b605982d
[3/3] gpiolib: don't double-check the gc->get callback's existence
      commit: 8a5680bffb2f681688b5788751c767fc380ff9b7

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

