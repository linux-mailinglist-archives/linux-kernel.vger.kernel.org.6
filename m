Return-Path: <linux-kernel+bounces-390541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C29CE9B7B0F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1B3280F51
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21D319D06A;
	Thu, 31 Oct 2024 12:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="KzLwQjuN"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D1F86131
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378920; cv=none; b=Cp8qxFvigk1w6FkqOXU7iSK+X0JKEO9UjzdJ8uX8YHmM9a0jOuwkVlVZDNfNOJpHENTZcjumgxdqn2OlH3HdzLZ4J3CHyycz00hEHFN169yI4Q4aIodbVM/cpf7gouANrYg+VxLVrr2cmDio4U2jKrJ1qmqcG10y9pZhB9gfLFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378920; c=relaxed/simple;
	bh=M0reKWUfcyegLq9ixRQulskKYs5quxoov7rWeO39768=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t4Rzs/nb/GfteChWlQbPFPHezXHFeTTmtM3upBR94g957NhyJJ3Qi5rlsNhWZffUF6IYlaJaNLwO9TM1JjblZrQXpxMjsFbT8921RyjaB7sI0ByE75A/t64Dnr/r3ThVoRuZfSRhoTnOuomuFvGOKG5SzCtJe3JSXYx/BqiVjCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=KzLwQjuN; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d495d217bso768615f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 05:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730378917; x=1730983717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOYDvnZV6syILbeaxOHtU8YtDYmWLyONICj3B3tuFco=;
        b=KzLwQjuNZc+ntDn2H+0jKuL5yPQFA7MgJeCRORhwb53Ca6dEHKQKINWtQFDvY2tWcg
         cnsvXWy/VT9woHXKxZRgMleB7Nmou+6YneEDPiA8FXzXUZU71mSNcK6KfuDv69RPmgeI
         N6rzDLxVtGWHaJ6dL79dBHi5m/ZDajyA4g2k8kN8H51JY6dps3APl1InuYGomePAFyhv
         2ffnM0Heebdv0gRcc/2KfjHJzq6FKX46TqbGmoGnTPRRO9cK/kDHnWb21zGL7ApgNdjl
         tV/ZL/W6MPKThK6xNdMW9bTjR3PLckVjXM2PL4empaCEhJPO6x5YBqq6a58hlNlmTXuF
         zSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730378917; x=1730983717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOYDvnZV6syILbeaxOHtU8YtDYmWLyONICj3B3tuFco=;
        b=p/jfhVZ9l6UskCW1Y7/MtsWuAXRMS7WibPvWtrsxZWsI6INqXJskkAvqD6hMeBXU3x
         vE4GSMfOtJLBgFSWgyweq+RtC5Hiz1XsbOehlyHdtjpxk0uri/qfh4h0KARprzpHFSQq
         lQ0GZomzgIUhg3Z5GnktHwaSnEpfzVRdPBPs8UsOqcaKYxBZkujn/EEn73egWlNMGeyv
         WvffbIc82bYavMOcm72X5bbbG0OGIFdRDbyk4NFOkGzcIINQOraGq3gxLKE9l0Os+Jwu
         ArgTNvqWqstIbF1N5wiNJZy8LMtKFwZkDt33BWcmivrQgQFcAuOWIyG2r3SQdJRNb2eu
         bV4A==
X-Forwarded-Encrypted: i=1; AJvYcCX983ztq6FVS/jQN/Xh8rO9fsLQWUsiGz0BD2RLV9G3E7EIAapv+gr8TcJHBO1fyg8B9h7a9FsmSYgxQbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqStukjSjxEmJZVx3b5GPOF7ouBCwyYSluTmy3djjMzsjjlNBg
	iFknEn5hrpYvAuCOxhKt+/Vi+YkpWjhrE+0BTsyctk2yt+icukbJB61S7yRRZYw=
X-Google-Smtp-Source: AGHT+IEb/Egcnxx0IOOnCLh1Bt/Pd5bbNyNhI9lA1HiPgMPxGhwZcXGABSTKC3AYRv6dTXj10o+Ggg==
X-Received: by 2002:a05:6000:c06:b0:37d:48f2:e749 with SMTP id ffacd0b85a97d-380611411bamr17935818f8f.10.1730378916912;
        Thu, 31 Oct 2024 05:48:36 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:a6bc:32f9:21fc:be97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e51csm2031638f8f.79.2024.10.31.05.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 05:48:36 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Mary Strodl <mstrodl@csh.rit.edu>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: (subset) [PATCH v2 0/2] gpio: Check for error from devm_mutex_init()
Date: Thu, 31 Oct 2024 13:48:33 +0100
Message-ID: <173037891200.8414.12711922515308939001.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241030174132.2113286-1-andriy.shevchenko@linux.intel.com>
References: <20241030174132.2113286-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 30 Oct 2024 19:36:50 +0200, Andy Shevchenko wrote:
> Ignoring error checking from devm calls is a bad practice in general.
> While not critical today, it may become a problem tomorrow.
> Fix this for devm_mutex_init().
> 
> In v2:
> - fixed obvious typo (Mary)
> - collected tags (Mary, Wolfram)
> 
> [...]

Applied, thanks!

[2/2] gpio: sloppy-logic-analyzer: Check for error code from devm_mutex_init() call
      commit: 90bad749858cf88d80af7c2b23f86db4f7ad61c2

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

