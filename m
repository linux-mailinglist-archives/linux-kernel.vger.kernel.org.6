Return-Path: <linux-kernel+bounces-517247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F1DA37E2B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5353188A95A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349B41DDA31;
	Mon, 17 Feb 2025 09:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="GmdWLEep"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E907E1DC98A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739783655; cv=none; b=qQ5SE2e8YBd4jC+Ix6BqoRHMIZ+uZ21NVbkBlGMeh0qX3DrXXHKscmC8d70QkCdxw1UYdQ/4+WnAIuJR9LJQdnlhtOG3ZFqDlM/J6+lIaxPZjEjS2mf3Xnf4ZkwWiguyZhxAI20jou6T8PpgkoZ3NJ760sDO/8Z72PR20sprdpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739783655; c=relaxed/simple;
	bh=KdUvVcI76P03CdvKNlcfRR09tM/AQn84ClckQLbYTJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G013ZkesbYnm410TaqiOlwYmkuRoOVxmTivV5U3q7pC01NvFCd0WD3krvA5tuaz0Rg6rAJ5bgBtk3XoRnsgm50UI6niP87D/KT52m8egNc9S3tBG8p6xOj1kwNAiMId9e/A2z4unPsqSaQx3WAARQ8QilH4UKaC7p2IrC/16Z5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=GmdWLEep; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43964e79314so36331405e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 01:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739783652; x=1740388452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsAb4tkD7Ik8TD1TTeWRRl79j5QY70My3fQR2gIl6KU=;
        b=GmdWLEepiXsTCjJC+2RXo/9aBZjlbRPqPiVkl6iHTtpHzURZtu39rQera7mP7sOXtv
         m3ilQz0y8BMcnp/BcpY0B6491Xi0DDsx7bD5tFMFgX+G4mBngtCsvwq9ELKf0359+25d
         lNfuqk/9e2P9k3bpzciNwJVw0Vb58pFN7zDEmtbqDqz0aqvhmxojld7Flw3LcsXDCqgq
         pV5Khxppo892MwrIPwpwMOQZWPQF4tQ672/3mGPoNpb8Wdez2EYyGl8MO0BzSaCk9mag
         hauthRF/BWzDJ1lyt6kVoYy9OKfD9OX3Mz8mLLjaBBhxGrGMr4fdUchdzxYp7OXoIC9M
         Y1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739783652; x=1740388452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AsAb4tkD7Ik8TD1TTeWRRl79j5QY70My3fQR2gIl6KU=;
        b=KwiNpbUUkeJNYj4Y4rLRBPSV5x0fUBj/TLlQLxi0O+xvOHlKsVyPlKVZd3Awp5TttV
         DyjlqKWnHIbNxEd3MqQYVZOVirNXSf9jcEPeMgEegqb6AMPU0YSgnze35NUUcccdKhwd
         ylQMrDmsEnktS0Pc9u1rA94NnaIrvJXsMmxU/WfzQpcOaplwAkOqegvzW0dLfTQANqBJ
         /1TTcXxJBvEfzkn7sSzPbRU14/E8UbAKfxZSKJ+P01+QalrrHcS7jqSfxr+AtupccsIs
         fSW456QAUoSdph8q7AQbwvjuadjzckMT63qAwRcBHHNi6ulZkqCLdXoCaRMfGZRWYRYc
         2aYg==
X-Forwarded-Encrypted: i=1; AJvYcCW9KR/I9gEOj7AEvPmiAul8H6+I8KWGAH7IPq5incD0Yxxh5DSEvhuJVGId+zEsw9rc04KnagKt+C4wE5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz8FqfXugYta5ilHI/1a0ztyOXW6UaGsiBdCrpMOgrgUob/y97
	CURy0h30QDh/NmRkf2Iivnkr/G0zE49HEk3SbJrhVhXWQSifONqEfNDsUZWkLAY9s2XYbdeF0km
	aW7g=
X-Gm-Gg: ASbGncs7uVVwzjCXW/GgxiU+4g/QdhK2PXq/okCBpQz0J0bEkjWU71YOSWmXo52YlYO
	97/1Aj4rguM0Wh2RfTzYzUfhhWnNwvReA/GsDQ9nt4ABurhZrmTctAcyOPWlIjNRvXt1rdCXQAw
	RW8GsmNJtKNU9FSfC02LNJ7qeVltTc8T1WyGdrS0ZGre0LhWfHlEMKVj1LIMdclrKeIECGsEheQ
	ctuN/BGsnvRGc/GRl1S6o1xiS/h3H964MtNx9AjqXBmrJjvgYSvQspo+Rhjx7M7xaTuFhjYpjqV
	rlrUapHp+TPq
X-Google-Smtp-Source: AGHT+IFIlBeAZb5vN6e4NXiu0d0pn+xPZEoW8MDcpO9pxDLmvRza+J2zgnL1eO91jEkWPo632r0vFw==
X-Received: by 2002:a05:600c:3b8c:b0:439:3e46:4b1c with SMTP id 5b1f17b1804b1-4396e6d7c2amr65788675e9.2.1739783652154;
        Mon, 17 Feb 2025 01:14:12 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:8707:ccd:3679:187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4398ad9e1d7sm7938105e9.19.2025.02.17.01.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 01:14:11 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Alexandru Ardelean <aardelean@baylibre.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 0/2] gpiolib: Make code more robust by using for_each_if()
Date: Mon, 17 Feb 2025 10:14:10 +0100
Message-ID: <173978364829.132597.11040060815053957420.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250213182527.3092371-1-andriy.shevchenko@linux.intel.com>
References: <20250213182527.3092371-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 13 Feb 2025 20:23:59 +0200, Andy Shevchenko wrote:
> Instead of opencoding with long lines, use for_each_if() macro
> which makes intention clearer and less error prone.
> 
> In v2:
> - moved original for_each_if() implementation to the global header (Bart)
> 
> Andy Shevchenko (2):
>   drm: Move for_each_if() to util_macros.h for wider use
>   gpiolib: Switch to use for_each_if() helper
> 
> [...]

Applied, thanks!

[1/2] drm: Move for_each_if() to util_macros.h for wider use
      commit: b82e90c6f987e8f930523313eb803209cf9c6c97
[2/2] gpiolib: Switch to use for_each_if() helper
      commit: c60fa3ba030a4d95b55fcca8945dacac89c542a6

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

