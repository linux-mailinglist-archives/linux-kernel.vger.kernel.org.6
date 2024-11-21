Return-Path: <linux-kernel+bounces-416672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8F09D488A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01131F22408
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C62E1CB323;
	Thu, 21 Nov 2024 08:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1TTuoVS2"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAEA1AA7A6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 08:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732176641; cv=none; b=Yk3xvV/fjxSDhYUBgbxa08hUl++qVcJHnR10MjVRjMzH+sxAM0DT/QEtz5s8TGxH8e3+vPUSQ4xkWhAka5AyD/7ZGbiSCn0sHVpotsn+hMGLOidprmO43zPhJ3c1xYWVYLcnwAGp55hqrOMuuEVJLraM3eoigloQ6sz3eCtcIr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732176641; c=relaxed/simple;
	bh=5lOL0dAG+qWC0r4hkRD0OLI4t1JweZw1bUh7yRT08po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tblDpVmLHxdB7NPnKqlfbshUG30RpQEGj+dXeDAnEQscwicXbARKpuUOZlvo/W9yB/U+slA3cwf680R1vP82nzab0Fvvn0UHNo5e4TnHp04p2e9PJ45VvHC+fixznbNb8F8gnoAuSqszV31vRS3P0Zqh1EojFOVZFm9YpNRDWKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1TTuoVS2; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53a007743e7so610179e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 00:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1732176637; x=1732781437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnPwcB+5WPLiKnjzFr2LUkl9/dt100jcqR+MZTr4V+I=;
        b=1TTuoVS2T9NrTTbNg9Mq83G5VUQHaoObfwe9gGuQGEaJwNQlnq9WLn+vw0DQF5N4pB
         yIEpSD42X1m1p9oO4t/s8+aVW+sRYkWQYHwUDxj9buUp+Dr0rDy1FIh41eMM9kk30bJ8
         WqPA5qafJVPYpN0pplYyNMTp8HSB9mPbuMiZf+EcXIUVX3YkeOFUj/lJpBjg6JdPx68q
         FiBYCKgjbboYTU1pnIsuf7Ennkmgaq2tmJ6HuAvwponiQDh7hqNH4rKsQGN3xMSFmS9w
         J6MmPHOiSSHiutr3A0zio0bv4FLIbOV9JxuMpr508BvRkpz7OMPTpLEZsomuFLXTB1Pk
         e8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732176637; x=1732781437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnPwcB+5WPLiKnjzFr2LUkl9/dt100jcqR+MZTr4V+I=;
        b=sPEwI49ZC2c94p/DCvs3Eby4x/f8VKTD96+wFQp91cx4WRlUpm0KoXUkssJTcakt5B
         uUT060AijTi+p8JOJKFtynGd8M8d7PvU0rz7hJ2Ny1NIHWKS7SS1ccUjDCXQdXPCA4Oo
         Kw0Od4agRhEZ9vErz1yTqiopR9WwFHCdAoUDcsniMx0altO/tVUyebJQgH2WYrmt7ZPQ
         30nW3raTLFYvsh9fpekEEkqWHfpGc+k0ST8FB+GiyNCbk+5CvXutyEHevP6EyWrZTuVV
         FXFpCaYtm3Xk0tal5+TD31zwYOEyGDicpqmx7xIQJNhy9Qh59Jo7dke6XvYyKvhwAbHY
         MAcg==
X-Forwarded-Encrypted: i=1; AJvYcCVhfXjka3ybjTGILIRsCsRP948vzcauvzcDmrK6XjqZgP08G3mamSWm6RbUWlsVnQuZySct2R1rpo6n/aY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDPfmVOTb/322K6M/1iarObLLG0lBSWLmx0Jbvo0MCCOe4ZVg7
	h+OXAV8hx1l1+T+pupNXhykiWX8FE1Oh4Rt9oli5e+WJndRq7qoNZw46fHDjPVw=
X-Google-Smtp-Source: AGHT+IGlTpfF8XVK0B5gc3g3nL1WX7zKVvmRxcMqPy555X8l8nNBazMekEELBSkNiok4v12jorW8dQ==
X-Received: by 2002:a05:6512:3b24:b0:53d:c062:b5b7 with SMTP id 2adb3069b0e04-53dc136739dmr2901878e87.42.1732176637449;
        Thu, 21 Nov 2024 00:10:37 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:d902:9409:ef0:268d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b01e1170sm46696195e9.3.2024.11.21.00.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 00:10:36 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Mun Yew Tham <mun.yew.tham@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 1/1] gpio: altera: Add missed base and label initialisations
Date: Thu, 21 Nov 2024 09:10:28 +0100
Message-ID: <173217662607.10730.5524794345806722350.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241118095402.516989-1-andriy.shevchenko@linux.intel.com>
References: <20241118095402.516989-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 18 Nov 2024 11:28:02 +0200, Andy Shevchenko wrote:
> During conversion driver to modern APIs the base field initial value
> of the GPIO chip was moved from -1 to 0, which triggers a warning.
> Add missed base initialisation as it was in the original code.
> 
> Initialise the GPIO chip label correctly as it was done by
> of_mm_gpiochip_add_data() before the below mentioned change.
> 
> [...]

Applied, thanks!

[1/1] gpio: altera: Add missed base and label initialisations
      commit: c7899503ad9c06a0c6ee2796301139731cf1f5ab

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

