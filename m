Return-Path: <linux-kernel+bounces-511247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F04AA3284A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D3463A4D2B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF6320FAB3;
	Wed, 12 Feb 2025 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="RvHdBGE7"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC5620ADE6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739370104; cv=none; b=evE7aaP8/1HhP3faLx6KVM0Zo1I5HfrTsvJ193L5mahmHhRuNtwi+3F0mNdldPwVFv8MRtKw+hpFzLMy11Ae4YtODh5dkoCYenQ68+SHbkmE6Zs++vh1o0LrYi3x0dbcFl6ii46ncFD/rq/1CQJ9jJuTzrkblWyHsKDgHIOWcio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739370104; c=relaxed/simple;
	bh=1xluZ/xn+znRDhXdajWvxqNWi62xirMRzK0zofqFzK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h4GT8f9MO/iyk72JlADpRveWpCHexmBUXr2I3sQWl+ql7QeRWlhTxqkPH6tlmf1VTvu1Roed+FmXIfIuc5Hg/KfoP8HFluLTea+6hGAez8lelTh2+floxGAdnFrBGzLYcC8WWot15Kb+KA5crD621bGwyNQUSFdMs43k/mMCNAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=RvHdBGE7; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38dc9eba8a1so4519903f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 06:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739370101; x=1739974901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7XFcJrR0jVxIOhGAlDRu0SUXNyGMm70VS4UkzK/e5A=;
        b=RvHdBGE7SIqjWw+rsPcB9Qo9bWG9+V4aFH/m/XuydBk3lLhcSNpY1Ege6hrBKi/CRx
         r6ED8AXNrAXUA+SK+sNOJzoab8G5Mb8TDbtQjwdAr1tlc2SL3pEaMtg2vWx0l8Y2jLJt
         qtnUb5RHYYo1HXh/zJPHVcsN/os9AqtJWpk8VU5reardknI4hndMYw5IRB9in1jne5K0
         +ZB607AJNlpeBC8qEKQEQhlDmox7X/tY/y9jsPnl/iXMuzUSKrKU+zsv68OoOCiLkPmw
         HvvmivxAkMnFJ5rUtRyPYFuxr9ryno2VneoWbEp3I8vILAL27eLGywaig3XrFr6hqU3a
         iFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739370101; x=1739974901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7XFcJrR0jVxIOhGAlDRu0SUXNyGMm70VS4UkzK/e5A=;
        b=l/fO07fzdUSU6iWrdOpDQXNwAHBev897m+p5Iym+HuMBSbLqWOZ1/24WK7VCAYWrD6
         MkTNOWplCsYSyBHcnOxXlWduJLCY+EmLW1wwYAOoGW91sBgvUMFnmX7hAQuJfxpJdrL9
         0gOUbWSBoc65W/4TMNS6Se1YAhq52YDrwLmbXF8G4lwZyPKjDfAZE///312+z+xeRoFn
         o8Rqz+n+bbrpSMKUZH85R5AwfkwFqkYat36m4KmZuKOuvTI8iIuST7qm2VdijZizKWy3
         d+Bd3xgN7ndvIpR1IfVJsfQz4vLdh5mFRIUcbxqCP74y8s9jbc2SxSdjuOm1NRNC3Iju
         5+cQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9NBr7arQL84B4di1CL2ZuuaJ3fRB6pVYJEwXIpzp/4X7bmPifdMtZRGnk0CHDAEnQ3kYAuAXFcJFyzCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTo3X7RNWgd1lrAGc6SRrn7qnXKDP+HW156UktXpR5nhNKyMUK
	hjIJzvD6B+D8/lsMNOFRzM3TKP6aldlt/JbEOu0BXccun9IqAqKoNQz1WtQO9Rk=
X-Gm-Gg: ASbGncvrtDV2tHXnro1srwEUcwF/yn5wnin61v5TzBVBL8Y9y8VOJ0LWpNnF5yxjd5g
	VdlybuQI8oQzqQwJR9x3+jjTLHNkDTAMtx1gXYQdnv8cEPOtYdQpg/wADvHDaDKjdkIifS1eJzu
	rHjLxtKftIHe+TP6dT/pCZnkSmwxdooV3yPkuKKoFkCvWvUnVuCBqprx4PPgSzK7pDqG3JKgYRQ
	ehSVnbXJHfkc+5Mx2ZIYhN/PHU3WU73tb8ZuIGpW51raIO6Z/l4YAXomgRrdgvsatiR8qax2Y37
	KNxxn8wLf1RX/JE=
X-Google-Smtp-Source: AGHT+IEUSlN9z8qlAkN8JoTBKW8p1CRSividrqsvgF0DeDdGA0bzCj1hm2FB/XOp81aha1n//r6Yrw==
X-Received: by 2002:adf:eb83:0:b0:38d:d9bd:1897 with SMTP id ffacd0b85a97d-38dea271f65mr2421120f8f.22.1739370101302;
        Wed, 12 Feb 2025 06:21:41 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:521c:13af:4882:344c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a071157sm20938305e9.27.2025.02.12.06.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 06:21:41 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: (subset) [PATCH v2 0/3] gpiolib: refactor for_each_hwgpio()
Date: Wed, 12 Feb 2025 15:21:39 +0100
Message-ID: <173937006403.31129.5577338516228495218.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250207151149.2119765-1-andriy.shevchenko@linux.intel.com>
References: <20250207151149.2119765-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Fri, 07 Feb 2025 17:07:33 +0200, Andy Shevchenko wrote:
> Some of the for_each_*() macros use the very similar piece of code
> that may be deduplicated (by introducing a new helper macro in patch 1).
> On top of that the implementation of the low-level for_each_hwgpio_in_range()
> looks too verbose. Try to simplify it (patches 2 and 3).
> 
> Changelog v2:
> - added kernel-doc for a new helper (Bart)
> - added two more patches
> 
> [...]

I applied patches 1 and 2. Please revisit 3/3 in order to not duplicate
the for_each_if() macro.

[1/3] gpiolib: Deduplicate some code in for_each_requested_gpio_in_range()
      commit: 8893516000b247f91fa2cef34f2a77b609e661a4
[2/3] gpiolib: Simplify implementation of for_each_hwgpio_in_range()
      commit: 767412f092fc6e04147305acd70f15770ece47ec

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

