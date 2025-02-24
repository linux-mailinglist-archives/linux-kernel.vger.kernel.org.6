Return-Path: <linux-kernel+bounces-528482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8268A41829
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F330F162EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D2F244190;
	Mon, 24 Feb 2025 09:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lwjKvi1R"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4048E242929
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740387951; cv=none; b=HV2Zb71V+/nwlGYCD8DdEBRxvusS776WA7SCyqqR2pkY44gTNuUf7Y1MQqgFu+EPooAM+MNiQ9EwZRF92ISE91/3BwlpCk0dG3CNMt2IXJ1S1lf1DocQJNS2nuMaI2mi+VDomegVtVTSwvz7USuMcfrArXftbX/FGTTPHwKo8nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740387951; c=relaxed/simple;
	bh=3e9NHcUNxohh2CpI0RlnEGP7bLm3cOQid8XcKAi7Rxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nBcHERPzkm4SNft0xDFyY1+xzNcX7YFU7fQXpNoJzoOhOf62cLjo4P83bNPgZVt8wMLnKksANM7BW3AXoYrXIvUAXLsDPUJlEH5atUQjgBMUWmnyQaTAhVA77o5yALdlO1GDGfubM7SQ/sOZQPgpb0pzHfNWOrL61UYGKUHXKqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lwjKvi1R; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-438a39e659cso25996195e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 01:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740387948; x=1740992748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFYRxGlQrFZDLwzhBGeR9eonPXy+s09Qb4jWFcOTfYk=;
        b=lwjKvi1RytbVCoP4cuouJqr6jEQ1c/yk1qAOThNe4yjLAzISP3OEJAFzKO1TyqOp7z
         BJkocSwKjEl10m9TrBApBuHJe6MzWXO9ymTglT6hpsm3Df7LDO3hPvnh0oZCYofOYiK3
         0NuSYdrD2mABozCAhl88F1/aR/sbjYsDQTbTMqUcV7Oy0UEFzCNXdaFf0EjdJeVgQ8b4
         kAyILX3WDXWKOyKZtmlR70nImEUP3Yl1wo/pG1EVCvG/+wxL6hXu8hrGVVKPs3bP9GJI
         da8TvvIDsw7LLNmh5DljfQbgiOB1famIljEms3SSssmP1Gf6GPRil7zJ2sXsQxoBbBZU
         pnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740387948; x=1740992748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFYRxGlQrFZDLwzhBGeR9eonPXy+s09Qb4jWFcOTfYk=;
        b=JN7DR7H1F318Ok2IAWLgwRldNyQY5lQgZcFP9hIbKW+35tuLsDkjxwuctAHAMW1arr
         p19vzFxZRwT3ZQRjf+YhBGDrrQxyviECoWeUdPGF9XytaOPKpEde7hjt8U9oPgeNc3tf
         eq1Se15qJvru3HzhM+gwXQJ5k+cy2m9pyF+g9z3DDrN6AQ+A7q2VmIO1l1CYfZHb62CD
         8q2+XMOn4fay3V1r0CYUoVP36ZumDC0Xy96ihTtrAJbRxukydHgQYLM+zxNAC6hP2GAB
         M9PvjZGxqjinv+NWN8X/8tyc4YcwuftNGlQHOhgykarkcG1G/htIkiwgURDZkPn49XWa
         BpYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgDGzibvvAzrArMXh1SRcWOM+0W9qRAX7rXaBM4XK6hrCPfdSIEspqovkQO7sHtIADQgFi0oq8AX5bPbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3NVpxixfLs0uNR82aIE8mgB2b7ahWKj7srJpQ05OP/plWy5fG
	YokQhayw+LbtbmM6efzm+pcBtQWy1FiksGR0MwDYiaMu+pbkcbk5Mi+Bgnt4EmQ=
X-Gm-Gg: ASbGncucz9R+wCn3Oybip5PTNJW330vTzN3yyzLl0/r63e3Vf4hSOuUSIXrVaPyUCAX
	WlFj/rzANpnzx5eV4L8HkTxBB2bl4QVoagp1ssnX3BIeVraJNPQXwk7Qjy1J3Gt+8mRRcb5iVN1
	fqemLnO9pGSyvZyAWgJZQ9E5RKwicyW1rbk+PU5C/5l2dk+nOqkfLYCbh08t0dbBIjSnX0EboL1
	pz1CVuIpe0B7hPb7++ZtDQnVrbCwmnCL5p17saRj5NtNBwUvNpLgZ9S35DpHxeAR/snO7ibZKho
	onVSMoRIxkwmKceH+8d4j1//
X-Google-Smtp-Source: AGHT+IEFHiBEmy8sXEyrtqQXwnh8dEXvmz0066u4ABmknFw9wG4yoH3NVSTLUkjYgwsYUVJbfwi7Zw==
X-Received: by 2002:a05:600c:3c9d:b0:439:88bb:d026 with SMTP id 5b1f17b1804b1-439aeadf8a3mr101484835e9.5.1740387948472;
        Mon, 24 Feb 2025 01:05:48 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:eb70:990:c1af:664a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce37fsm101497385e9.8.2025.02.24.01.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 01:05:48 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/8] gpiolib: sanitize return values of callbacks
Date: Mon, 24 Feb 2025 10:05:46 +0100
Message-ID: <174038792740.24614.6901327376350274039.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250210-gpio-sanitize-retvals-v1-0-12ea88506cb2@linaro.org>
References: <20250210-gpio-sanitize-retvals-v1-0-12ea88506cb2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 10 Feb 2025 11:51:54 +0100, Bartosz Golaszewski wrote:
> We've had instances of drivers returning invalid values from gpio_chip
> calbacks. In several cases these return values would be propagated to
> user-space and confuse programs that only expect 0 or negative errnos
> from ioctl()s. Let's sanitize the return values of callbacks and make
> sure we don't allow anyone see invalid ones.
> 
> The first patch checks the return values of get_direction() in kernel
> where needed and is a backportable fix.
> 
> [...]

Applied, thanks!

[1/8] gpiolib: check the return value of gpio_chip::get_direction()
      commit: 9d846b1aebbe488f245f1aa463802ff9c34cc078
[2/8] gpiolib: sanitize the return value of gpio_chip::request()
      commit: 69920338f8130da929ade6f93e6fa3e0e68433ee
[3/8] gpiolib: sanitize the return value of gpio_chip::set_config()
      commit: dcf8f3bffa2de2c7f3b5771b63605194ccd2286f
[4/8] gpiolib: sanitize the return value of gpio_chip::get()
      commit: 86ef402d805d606a10e6da8e5a64a51f6f5fb7e2
[5/8] gpiolib: sanitize the return value of gpio_chip::get_multiple()
      commit: 74abd086d2ee5ef10f68848cfe39e271ac798685
[6/8] gpiolib: sanitize the return value of gpio_chip::direction_output()
      commit: dfeb70c86d637d49af9313245e6b1f2ead08ce9b
[7/8] gpiolib: sanitize the return value of gpio_chip::direction_input()
      commit: 4750ddce95ae8be618e31b0aa51efcf50e23a78e
[8/8] gpiolib: sanitize the return value of gpio_chip::get_direction()
      commit: e623c4303ed112a1fc20aec8427ba8407e2842e6

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

