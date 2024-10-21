Return-Path: <linux-kernel+bounces-373788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBE69A5CD4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0C91C21757
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000291D1F79;
	Mon, 21 Oct 2024 07:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DTBvvaQb"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A386C1D1519
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495452; cv=none; b=T79MC866YH4ZqE4dYsy2AA5Ao3w6s/1aRx4YM89z8G5A8XhcPwsx1wnpfbnxRYcbc5cwccz/QbB1ZXWz7kJJJB0ZXk9OnbqprmMo889Q4MXCIIznQ0gbucI1HjkjfCaB9Epykf6HW4YisX8WA6F5K1nRCwQSDQbb9Xn7XUjnhp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495452; c=relaxed/simple;
	bh=jEJV+yZyYaMqToACAPmCfoq6RVhN1T2TmqSXcj7mAjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cbJlvfYsJNz2n4sB9iswQatePXsxDcK0Ogr9EGSep8CV/xdwQJeefhlcBKKDpSEQ5/7c23n/UvgZvmDz2rW5ykEl3X3sHtPtyEV4iAfaOHTQRLAWXyLpBrfcuLainjcCnPRnmiPwsByw9qvtgt72TIEK1RlBBc9jiKI61+yWjfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DTBvvaQb; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d495d217bso4072596f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 00:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729495449; x=1730100249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7cUzfVS/GjEGIShFurThRWY3xiEOf16ByPkgwE4Bu0=;
        b=DTBvvaQbTaU81eSFSbAtwDbIk4O8qbwAbxT2fupiukhoJhHenA44kIZosvQUW5Rkkl
         ghP7eXlUTP3uAjMIgPpnxPvMVRUaWV6tO3NqIlt+qUWU8df8FntWsOg9MSlF8C5aPcgn
         NzduLiEAquqy/1WrKRsnw0S1Zv6dd08lricBCzWweN6JFOLh4bdgppJ6gzxp63atx9wZ
         bApuZd+mSvQ/u3ZklTtLxSLUhtUJR7KCZBEFbYSaEvs4xmPKuHR3YgxtYMc05WqhYq22
         OKdilyuyPwWGAoN3bcXXIcO4pLfesamC4TPjIcJJgP6keVWT2T5bJMUVUd93OBa2dRyc
         UpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729495449; x=1730100249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7cUzfVS/GjEGIShFurThRWY3xiEOf16ByPkgwE4Bu0=;
        b=g+YBkTOy1m5QXiYIRS35aTVaBApyKFo0/+A/unrDjid4iIx/pCMOfY9hQCSDx1AymF
         IJ+grLQo5FTON1XO3V/2A6+T3p1G7GTg9cBYSGfjJ2ozSjyq2OWBZPliz7cYhCM4g/t4
         ZPTR7A9S+R33WQf98g2lUYxubMMxgtclmAqXRPTIhXrxHFoHjkrNgPBxVXFlQKgfQaJ8
         y/3g8/umxEF+xrNW09ICpR/mV+wmXh7x4WG9XV7cgcqbhyBRY+SUPf0MIrYtn1eoKnSk
         6WbClex2qjl9HIgyMC0RYij4uwnyiRiGvla5ObhWzsaY/MPCHMUZzkxnbn3LhvMt1EsJ
         ygZA==
X-Forwarded-Encrypted: i=1; AJvYcCVNu119ydg3yzcw+nkMXb9PixW5guzUbblV+ziTnm/+Nm+ZxcZJwcuVcV2TE3mOXaJaH6ZWKcxBb/o+5Kk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7+q3lWJ06RcAO9tzx3VmLOeGInIwooKp4/ZfgXWOfS1CQ0pPQ
	K/hXoC8isa6AF/SHIMGLAzvnvNttcYHxpLk5Cg3mlD33U6FPV+LtmAeHFjeAMN/G12mFLrC1WWM
	Q
X-Google-Smtp-Source: AGHT+IHYbU6mekaKSSW4xuYsp9Ebhr9e3kWfV20mmirtI7vRsKFa0e0krOa4goOG3hQWQrtYXegg4g==
X-Received: by 2002:adf:8b96:0:b0:37d:4376:6e1d with SMTP id ffacd0b85a97d-37eab755c62mr9129909f8f.41.1729495448980;
        Mon, 21 Oct 2024 00:24:08 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b40b:61e8:fa25:f97b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9baa7sm3517954f8f.96.2024.10.21.00.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 00:24:08 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: max730x: use devres to shrink and simplify code
Date: Mon, 21 Oct 2024 09:24:05 +0200
Message-ID: <172949543975.8769.3770247782316456459.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241017121447.73754-1-brgl@bgdev.pl>
References: <20241017121447.73754-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 17 Oct 2024 14:14:47 +0200, Bartosz Golaszewski wrote:
> Use managed variants of gpiochip_add_data() and mutex_init() to drop a
> label and lose a couple LOC.
> 
> 

Applied, thanks!

[1/1] gpio: max730x: use devres to shrink and simplify code
      commit: 57e0e7188712dae39045e4004c7c7f9ce0a36193

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

