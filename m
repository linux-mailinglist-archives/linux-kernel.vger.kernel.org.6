Return-Path: <linux-kernel+bounces-429858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FE59E27CF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FE65167BD2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B11F1F8AFB;
	Tue,  3 Dec 2024 16:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="p2/hedTi"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213F713B2B8
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244111; cv=none; b=W3cC2tb1V/WI4yZL93yRgb+YhzwL/QKU2vELsuOUm+DBxh7BCnkl6A8aoOXnOD2XAgAuHkd/DFqncj7O46PWoWjDSByFAnBNRtVhm0n1/iZlJTTsM0ql12brbFYdhfUhspol+38UgEY2PP8hYAoRS5efjhyS6u5xjDYS6YE+j+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244111; c=relaxed/simple;
	bh=mi8ZKLBkRBFPTJhG12a+AsfcEAOw95iD8h4NMdD5Mqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hqr71y5H9RiursoAYbapvcsWUBMRh2M3WtEGUmoADjuk829bvSqLKas8568hlvC8NPLPjPmqQPsR+zgpGYg+grfQNLhLEU9pqUvY3v6vOX6d86kd+R8ANU3B83nX7xyvPAa8ACxTgyNa9MN5Yid5dygZDkHvYW9SZPxIhC6gNuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=p2/hedTi; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ffc016f301so62792841fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 08:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733244108; x=1733848908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=79YYTw4OLJH/nU0R7kGinztAGDupZuTEGxaRjZIufcY=;
        b=p2/hedTi8rDsVJJskes+AiopOS0/VYtQ/i/AOwxPp15OZ4tHLSCotBBY6j5K+PMxxa
         BPumUU1Ah+VfNIajsgwoUKR70qnLgkgbhMyNsiF3qgYB6JXCxzF4lFnDQ7M+5A7U2whI
         nWmBhlcYqkXAw4XRmhGoRloFENx+LsdPapjHoyfzcGSe7xXgDUaUW048vCd4OCeFEWm9
         WF08kkx/A8bDGsLjzXvLosM02sLLiA/wLYBP1/Xk5xmJUijt1ewfW9Shw3lSOsZXKzBJ
         7Dt5TWbJhMQASkWzY3RV/bFgLNefN8LZdmfjoDJ5qu17GD4Oi6J6Cxe6Il0O7IjQFZsJ
         9/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733244108; x=1733848908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=79YYTw4OLJH/nU0R7kGinztAGDupZuTEGxaRjZIufcY=;
        b=gmiaeYkGmZrRpPrEVIlsUIMecOmkMwL1MgndJ5rzGNqfeyjs3xBOKdaAGR9Y4gQh8y
         WTQ7tBJ6RsTJk5vJ/lH+VrF/OqT4txbAIrJctduqDxT8d7bLGKuihjleAdgcLAZHYMv/
         GyAf6dXO1qYvtymFHPyLNo4aMEg+nOWTG5xUB2HnTZPnqX/l7EXLngB6G8S7DaiN9d7z
         Qy7rUlt3hlLmXFR4Q4cGTHCtQMKLmcevRgUqRnKDUpmDkSFhsGaRNg+hkCC5O9jsGtwQ
         +cAzz94pZTM2Kbw+2BhIrWYpZk0J5jQmdN9VSqzlQTR03/gEGxTz6ge0JIMrpP9zB0sh
         lWFw==
X-Forwarded-Encrypted: i=1; AJvYcCW5T2/S7Z3uOQK/pxh6KPU5Vp9OJTOd6nnmd9jvTVLU/uD8+JVsgIgXMPPzD8sLM8sD+zhTG9V9NAnv8Hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOW+83OrlPavPJEopGGrbhiecqqVpUXaa2GYfWhiswyjsqbXKa
	LiGZIiwl/zH+mhmRbhUbYQsL1R6N3MUDrQUkGKINwQE9RgMZcCeDDVmpoGNRYz0=
X-Gm-Gg: ASbGncu8X7YrcmhHr0/bsAS7jEsCKF9V5pCkJ/8yDM3UxN8o+gXqsAl4q1kmqp2/jeu
	uDEPyymtOfMfJZFtZmk+7Aj6K1p3hhKn6yU9i58YNH/PjjzCBPC68T6jcNw1Mvuj5i+B/yeYQy+
	8++/PrhC1b687+K/C8k+8N0HMY6UffM0jp5o3d7q2G4ZEranLFGPg9Q6QiBxD3vJ6E1VOjyy1/N
	PeKFEOheW1Tc10U/xRPzCU0777nLVQcW4wnrhuenfwZyuzlZ4rZz5OJMWlUSa0PsU/ILb2JyuSc
	eL6fIS7AYYgveA==
X-Google-Smtp-Source: AGHT+IESQkBNm3NGGmpXD3R9iAv+O3VG3UIwtvPMrzNoDzrMyo0u4WNNVUXmqMJ3+hGaEOr2LUgDGw==
X-Received: by 2002:a05:651c:2210:b0:2fa:cdd1:4f16 with SMTP id 38308e7fff4ca-30009be4929mr19048471fa.14.1733244108166;
        Tue, 03 Dec 2024 08:41:48 -0800 (PST)
Received: from brgl-uxlite.home (217.97.33.231.ipv4.supernova.orange.pl. [217.97.33.231])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3000b262f32sm2482161fa.4.2024.12.03.08.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 08:41:47 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Kevin Hilman <khilman@kernel.org>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/2] gpio: omap: allow building the module with COMPILE_TEST=y
Date: Tue,  3 Dec 2024 17:41:42 +0100
Message-ID: <20241203164143.29852-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

For better build coverage, allow building the gpio-omap driver with
COMPILE_TEST Kconfig option enabled.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 56fee58e281e7..fb923ccd79028 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -530,7 +530,7 @@ config GPIO_OCTEON
 config GPIO_OMAP
 	tristate "TI OMAP GPIO support" if ARCH_OMAP2PLUS || COMPILE_TEST
 	default y if ARCH_OMAP
-	depends on ARM
+	depends on ARM || COMPILE_TEST
 	select GENERIC_IRQ_CHIP
 	select GPIOLIB_IRQCHIP
 	help
-- 
2.45.2


