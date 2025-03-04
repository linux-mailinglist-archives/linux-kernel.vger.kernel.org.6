Return-Path: <linux-kernel+bounces-544268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7238A4DF80
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87168178822
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEED42045AB;
	Tue,  4 Mar 2025 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="AavPMQOw"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF14204595
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741095720; cv=none; b=XwNTa6+7TX40EOJ771tJgdRqv38QFL9YSQw4pwrtU5MB0RrCC5wj+v1zCfsm0VarPRP+amV/y7+J9XubwBU9F21GioUthlXeitN4Q4WvF20j2QXGr+y+yjIAPQd1aq/lO9X+LtMkPv3NFbYtLI47JAjErx5/IlB+gbmvYpxIzg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741095720; c=relaxed/simple;
	bh=qFAVCBevFGrjOj+GP0A7nWL93SYZC/TKlKr5cimR+r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pZCtMuyn4IETKurFoNJti/V7GYkmk8JnxPlcy7kdkhddAcoO48Q8CK3nKvZIAIrynNe1bR1yiZX02j8XwPu5xcFHcIUZmbXPUerMNNJfV9QCTJPPv8afK14lWwl3TUGIdokV0MIT+VJRDh8eAYuSiPmr7W93Jcwchx8ylWhE6gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=AavPMQOw; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43690d4605dso36581105e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 05:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741095717; x=1741700517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wn5SBFVn5PTSiaQDxaLMYYp6enRvlaDi4aBmx/czMD8=;
        b=AavPMQOwzjKp8aF7djZ77v+CZrKJyTsJLBIbWErcwyXDzCpnXraq1MuJ7bcNrvNLiq
         7Y/s/9XPeVnYDRtqTHUH5ZN+iarUabzudqUtOzTL1c6VCmPrMtJZxe0IhfPqRJBJCadP
         TmkhiDrwVfHEGnQNJAXVgtka+/DIt6LOmr8uZRYpp1mmO+6ErBVL5wDGsKwax6X7Pohb
         MKTCAsa7LKR//vyiL9mbiCvMGLIj5+++cD00a7GNRTvNfc53k8e96dG+Iv2no1FTAHM8
         54/wQ/9pqxvu1k9yTZ85OGI4lw5QAyL9Unddh2H5b5NNE87RWh6g8q7AD+AjPW4Xe0tV
         FD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741095717; x=1741700517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wn5SBFVn5PTSiaQDxaLMYYp6enRvlaDi4aBmx/czMD8=;
        b=dUEyd15Zd6I0v2R1BrdoXYwggvmNJOaej8cTqD6pRCs/C89l7gDw2JmfSufKZW10kM
         l8wW9n4o9iharZOLeLw7LT6nRxyjB1YhEhycfIRYdN6FAVRnZkCtDh0TRSbax/4iLvuH
         NSoJJDay2Xe+ZdA5TpDjG64twmj7gMPc+pspyxbtuAAtKXbNizxx2P02UxKwK3T3NS06
         583MZZ3zQ9q7dhAZSkCSJcYwuvFtIZDU7JgIiWbTa1y8ZUrhtmfTGmPpZb+FLCGH3FCA
         vAzEHCWAbBmo0HU2XxzwA/b0C8Yncp0YFWyew2SfoQYRg6im0x5Vfb4d6iJD3Du4TBd/
         KAQA==
X-Forwarded-Encrypted: i=1; AJvYcCVc5IRNs8XT8x/zQwiUnP8E2Gn5MLB4dOVB+Kyes39faUnniKZrKP477/uq+T/mfy9TVlx+eJl2b91hweA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYqC+9jazEEz3JiS1lqUqbz15/aWXlay8jxF9qAxX1EZR0TIE3
	D7aEyMdqV23Smk98nRhSHWLVqjWFnJWjDBwSgiNC/wSHFSwdWh+DGpzjrH1czCU=
X-Gm-Gg: ASbGncvtXM6y5TtGmFz4DXAMtLn7qlydBi7eHAIITuteTX+rriiv54zUrnb6pCGB1j7
	AtB8NjGlnCRp1kHDS7Gla3ogm2M5gGO+b+to1KR3Gqt6/xtG9ch4fB2pdPwJ8SzXSVH5E5hV2ye
	qyEvbwbtPf10cfoPSuv1P7BZOh+vs6LOmRqyJl2N81IwDwYF7GPZGn3UjCItOE2KUQhMDj3uLGe
	jnYo0BoZseP3/4MA2EJ76sjDXcfolbD3FsCnCqXMnnC0iNm9FEvv827z9mVnF0e1WLoBa3Nu9rI
	ffk/oj3NqHfwJRTq7e1/7aEsdusZ/FDjm2SzZ+1170zg
X-Google-Smtp-Source: AGHT+IEzx61klxYJlpUbSKy+UGvqsAxGMbWClRABkjxJDKokk/7WG0skF6SLttB9UBlBKQ2l2Z+X9w==
X-Received: by 2002:a5d:598c:0:b0:390:f0ff:2c1c with SMTP id ffacd0b85a97d-390f0ff3109mr13702639f8f.18.1741095716807;
        Tue, 04 Mar 2025 05:41:56 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6018:7257:350d:e85e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7dcfsm17982026f8f.55.2025.03.04.05.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 05:41:56 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Kent Gibson <warthog618@gmail.com>
Subject: Re: (subset) [PATCH v1 0/3] gpiolib: Reduce 'gpio' namespace when operate over GPIOd
Date: Tue,  4 Mar 2025 14:41:55 +0100
Message-ID: <174109571262.102031.5467613849616675528.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250303160341.1322640-1-andriy.shevchenko@linux.intel.com>
References: <20250303160341.1322640-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 03 Mar 2025 18:00:31 +0200, Andy Shevchenko wrote:
> In order to reduce the 'gpio' namespace when operate over GPIO descriptor
> rename a couple of functions.
> 
> The choice of the name in patch 2 is inspired by the existing
> gpio_do_set_config() versus gpiod_set_config(). The patch 3
> also fixes it to be gpiod_do_set_config(), so we establish
> two namespaces here:
> - gpiod_do_foo() for the internal APIs
> - gpiod_foo() for the external APIs
> for whatever foo that makes sense.
> 
> [...]

Applied, thanks!

[1/3] gpiolib: Align FLAG_* definitions in the struct gpio_desc
      commit: a45faa2aba2cb2b12ad4c732c9f5692db1f7f12f

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

