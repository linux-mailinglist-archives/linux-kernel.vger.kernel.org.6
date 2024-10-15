Return-Path: <linux-kernel+bounces-365872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 370EE99ECD0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0D7D1F21FB0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696C51C4A20;
	Tue, 15 Oct 2024 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="SkCCZ1M5"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72DF1B21BB
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998318; cv=none; b=CXEAhQdgMVJ9p7AFbEQ5n9Auuy77ynaxlQ3d7pZoBXKtavirHUXt5vCmyLGLBCbq0ODCvmj3yKFyfY30HYPyk0e8L8b2Rr2MhLToPB4woTU7AMrK1TX6bEtkux2egUNz6XVFKOTyGe1Prfwav4TH1ZXa76QG4L8VN2roZcgSjtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998318; c=relaxed/simple;
	bh=GWE7IKCk7X4Vk66iIVqj9exPS89ESzElV0HbrMOUxRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o4UtkuiGb7COFJ5KQjgTRB+29JgV5UuUGWi+VeemDo61mjvPobbGdMRkImpWds/KVmD6YqWzuUE4tadpQhUFx5wYSuXyNHZGDhxiG6Syybf+r0BNDREVtcvQewkCbck+Wl3/C6SRgiKeqxECHXHad4cbviRbphr6BKQso/m5FwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=SkCCZ1M5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4311c285bc9so39045945e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 06:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728998315; x=1729603115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YtIz2qp9a7gBi4mP10l9nFI0kYJy4Vh55NDXHglG/3Q=;
        b=SkCCZ1M5zlffMHk31mTgxprIXq/6wbW9c5egzAs3pQE2ct8sdsuBaVWiMxogXtevHl
         fd0Jtd6qvD4gcGiMl0oKz8pzqjo2rV+XoH47qrXndrZoWauoi1V0a9D45QvfIVXED7vh
         BDbl+XURN0dzHlThy9f/jz9wY6nyCB0Nu9DBUr7RiPif6ShwrCVC+Mgi2Ckc2Qn37O7h
         JjE7eZAUaaoBWQQUsBnDCKe1uPEvmh9PjThGFIPIX6yJsRRJBmcXMHsDN17GAxmLc5Bm
         M5Z6/j1dT6BpF1icNWNyyw76ajx1/xL8iIXlAut89IxdS9Tk27qKlYm5X78bOG5/qxZ3
         SWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728998315; x=1729603115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YtIz2qp9a7gBi4mP10l9nFI0kYJy4Vh55NDXHglG/3Q=;
        b=Dq4ENhEnk2I19ZSp1zV6eQhoxNz1GMAwFWa1ZuHNn1bDtcSswE9OyH/y58bMspGrhV
         Ux5yXACWLbouWVUrT7MM62O0eZHt43uEOGAV5UXLstVmfw0h8MyxY29E6/cbi8oOKJ+A
         sgPlbjL/IqGufeJu89jfiHnNdj07yO7odbrafPQSB0VmrySXr3YRqIE4m6vW6JyoE5n4
         U/EKQPwaz0mOXCBh4auCiC6c8ekrJkHXwaYKSH9bzNtQU7lZrSuZ2DI+Fg56CG9JJYhv
         6h8yfvRcfrBC0cRS+ttpi9xF7dStPzi4rgdDPzwkbz5MRwvd1cfdIbInuYGqT3z+GMxV
         c7tA==
X-Forwarded-Encrypted: i=1; AJvYcCWiVL21/w1xoMhC3pILQoihgyImlafz8Bu1qoCmN+FchRjG3w7rIjN6hMh8+Z03T/u6WRZcALlBp7BcFxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy56zLmTy7WhD/RHj1wRiiqZ8JN/YmFW5fND+dYmIODl3X78dI+
	SHzbN6EfA5Q5YjFQVcKtkOHerWM2bJI8EMd+oPrRLyk74esA15IQssvlZ8eldzk=
X-Google-Smtp-Source: AGHT+IEshOBUy0buJ/axJY+T/Itpy8gp+/ue1Lw8d1z6JIgCEpBspfjLYSVxq+GuZGDtJPjl/hfoJA==
X-Received: by 2002:a05:600c:1c29:b0:42f:75e0:7829 with SMTP id 5b1f17b1804b1-4311df56494mr126042095e9.30.1728998314873;
        Tue, 15 Oct 2024 06:18:34 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:d382:b11b:c441:d747])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f6c5524sm17676405e9.44.2024.10.15.06.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 06:18:34 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/4] gpio: grgpio: drop Kconfig dependency on OF_GPIO
Date: Tue, 15 Oct 2024 15:18:29 +0200
Message-ID: <20241015131832.44678-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This driver has no build-time dependency on gpiolib-of so remove the
Kconfig switch.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index efddc6455315..2e91e02510f7 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -341,7 +341,6 @@ config GPIO_GRANITERAPIDS
 
 config GPIO_GRGPIO
 	tristate "Aeroflex Gaisler GRGPIO support"
-	depends on OF_GPIO
 	select GPIO_GENERIC
 	select IRQ_DOMAIN
 	help
-- 
2.43.0


