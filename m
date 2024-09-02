Return-Path: <linux-kernel+bounces-311078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8E296849F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1826F282E21
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCEE13CFB7;
	Mon,  2 Sep 2024 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="142CfxvF"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F5713B5A1
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272782; cv=none; b=G1NK5lNuNUmsE0Vo51z03prFxprO1ZRM5f0I50IT+lT+0EyluCm32hP0zx/Ki60Sd2/5UfbtetFZ1nIyhIop4HJ5rrkIfq+wAF+KkJvCYzjRPOIkH6uHw8g4NVnYlS8vcLztx47ER5rVAHErgMSURqs109S1zkuSdC1Svx0gY2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272782; c=relaxed/simple;
	bh=BFfI9FpfzIUUD35IcnYqFMz6uCrKmc0IhIxkRuHGttc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTctQT7TmWV+a7ygAEflJnv9F6jLnQk45KAdq0l4oWbO9D5/kfLLM8n5Nv+XocrfMKpdjU7VZcSjYYDAPXSa9iEAlO3zTUh2JYsPwTdUONZByrT+ZMkVK+PiWIX0Dm7unZ78Ng+sQJbjo2ap1tjB88HA0b9tu/+/k/lktOk30b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=142CfxvF; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-533de5a88f8so4163082e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725272779; x=1725877579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdhTD91gUIx/ayxEiTnAVXsfq4RDl8NYrdKQ/eSSaWw=;
        b=142CfxvFvbe+EMdVWutvCO62d7hai6gVs8vR1R0Fr4qOIZXsN6loN5vX9/JdcD967S
         WRtb0Ss7GDD5t+ilp5t9YLuiPoucEgE0+YWpjkDqsoT54uIEDktlyvKK6CVaIEb/Z6Wg
         sOcm3hQR5Luz34dcAtFUtns3wL6HP4w2SvVYfCJPbxiH1nsQlii2ncKS5pggxbfArVGE
         cMJXyydPf8HQiNNT5Ivlt/oTmb2WJrQ1BsJva1EimBXtvImiti8cjFAwwGviodFyw2f6
         ZvpnGOw2CwcwGPpDtevpl5jn3WSnqoBXvv/QmK07bGeD3gGhvL7z68JRozxUUGtfekY2
         YSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725272779; x=1725877579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdhTD91gUIx/ayxEiTnAVXsfq4RDl8NYrdKQ/eSSaWw=;
        b=g0mkxSHd4h7IPixAaJ8fhkgDUQkuZ07+iLxAZUySzi5Rf9tnb7fMoB0mDjyqEMfIUr
         AGiYVqzsV4xDGuX3rKNW6oYyYXZ8WdY42pKNOvFhdMTn4L0IQtX7X1rhC5rOobyVYLn2
         0W8F+CGM6kbevRTahYGzIThUjlwOfGG0sMrngnH884OOtH7f4VHH5vQ0jyqqDmZCWXC0
         nw9v4Yj9Ur24b3N0b23iDdUygXVWiZetWhXUX3cV7l8i0Y5W0JlO2aiwxALxWKlR9fqd
         M/U7wIQRULIZs4fdZoA33hjWsB8doserse7wP6p7yvil+D1iQITFTdF/x9/HVASSvqLj
         SJSg==
X-Forwarded-Encrypted: i=1; AJvYcCU7bzYpE70Wb2LDC18WXPd+a7zbBtgVXtLmOxAf78K0xCD34sNWDGoxGdX8ymkuZpXhcYet5CkQZFzoQLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDuPVZkwkW5JA2o40drc8rKTYDG7EPbbl6k75YYqctJoW5FZlV
	KMsSRlUxfHOw6BeihNzF72nlW1x+fr25g8dz89pkx6J9EgSmwhGC4FkTT8a/PeY=
X-Google-Smtp-Source: AGHT+IH9DTMtOJ9FIs1C+aKzuRz2rSULKJyaElIQQSnn51mT2lijrn3LSYXHij8nULaRtHH6QBi+JA==
X-Received: by 2002:ac2:4c4f:0:b0:533:42ae:c985 with SMTP id 2adb3069b0e04-53546b2df7emr6922742e87.25.1725272778785;
        Mon, 02 Sep 2024 03:26:18 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b496:9e67:73c9:9f5a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bbf15b9b1sm92362725e9.10.2024.09.02.03.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:26:18 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 1/1] gpiolib: legacy: Consolidate devm_gpio_*() with other legacy APIs
Date: Mon,  2 Sep 2024 12:26:17 +0200
Message-ID: <172527277542.24997.2961040710217329263.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240828151357.2677340-1-andriy.shevchenko@linux.intel.com>
References: <20240828151357.2677340-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 28 Aug 2024 18:12:43 +0300, Andy Shevchenko wrote:
> There is no reason to keep deprecated legacy API implementations
> in the gpiolib-devres.c. Consolidate devm_gpio_*() with other legacy
> APIs. While at it, clean up header inclusion block in gpiolib-devres.c.
> 
> 

Applied, thanks!

[1/1] gpiolib: legacy: Consolidate devm_gpio_*() with other legacy APIs
      commit: ef2753797e31a126ead23258d73fd8d979679e81

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

