Return-Path: <linux-kernel+bounces-433194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCD49E54F7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9913188173F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4021D217F36;
	Thu,  5 Dec 2024 12:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Q6zSpAwA"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063A1217730
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400382; cv=none; b=TBxs1331kgQsyDNrrUH1LJK9/G0ysZC7xnLpOu3rPt5xwy3cnC//yGi3a+gt/4OnXPSQyedUfr0H7mzrTEd0f+9BKf0kQ7Fv1X6OGBysiBGU/+n6FaZo4Y9HhbS+TSf2DSPF3h944+toCMH+W+0clqdeITZbCM1InCv+/k3AyLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400382; c=relaxed/simple;
	bh=EHhGcMmIPZQlHvSzckeuvpUvnt/z4uItzGTV+aTrF4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jysRl0irtUJNxsFcASeDHlHIHMqfNMUkmm49ZZ9mM8vlaHDPBVAeVt6oRmdiTL43+Bdm4e5+FpaGdGJmzmEywYYlElVeeVL0FhWAc9arx7hVWgNgCCFmdPROO3gRsKWuRw677ep7OwOozue95GQPURxyh9rM4z6J9VAv6KjMFMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Q6zSpAwA; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385e96a285eso486919f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 04:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733400379; x=1734005179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1IMlCojeP5q6YL2cpETJ1hIUJSlb4xwiIMaEqu2JuuU=;
        b=Q6zSpAwAVLkaZ0CB2Y8LfaPJymkU3+uj+LTIDJe0eqK0JB3k1oeLlxpEaELZ6sGeVn
         FwDQ5FmsHt61p7ENCDHyiKGYxnr1WDAMINMTJD0wJAQvPjbb2HCtx99dfjTN+7HIC/L6
         PoEuvrXQH+xvJnV9r5fLTpkabaiNaMOcIStf5MpWjLOasmQSUPaMbts4Ouh2k/CPAjdX
         H3D1jhu9gVqeLkohSAA9pkFwHbb9bJCgsgtRU2B9mcBac9FtNXtQ25kHyxjeShQM3QcL
         PzWmsD2wnxjf7g3pHj9tym/T9QRljINXHloRNg5TqHQAyroq70HNMb7/GDSroklbZIuE
         Df6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733400379; x=1734005179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1IMlCojeP5q6YL2cpETJ1hIUJSlb4xwiIMaEqu2JuuU=;
        b=tqIwahCJ8VFn8PpzhZ332U9vT/X6eG9+oQlD2J0akSntskry8iksMm1r1GEXe33wPa
         Lx/E19nlEwAfEFF24/Xu1paxmzZLDnvJtaCZazrhSGkOkhvHrvfq5mqS0Yy8DY1h4L0U
         LomQQ5mhzY30oYqhTN1XMdmcOFi4OwzeBW5GO40atIqeEl1dNW3ObrDM11wiDTzOjonq
         HU3DQvb13PclUhtzl4xmTHj70E0LKkoWQzYEbIywAilkUaLei3gLzalD2GEcq7AF3ODo
         qouvq3AX//KAF3IJAzEv2gaOC+SsjbSDPLUdHMO59NJD87qHF2UQmJs75VLpOTBgi+v8
         OdRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMt778dXyUtgy458DVG7ZKQ573twF7DEE/z/CdVhvSquwFeHrt5ts+ihcEsrWUheLoRphZuc6GX5b86YE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx76EcxzN/lFxROwZ2dnUwC8qAl0erbW9cJl3PwvsVpp/dTE97
	mpYo79z91KQ2a2AmWtKgKlTPmTwlmLCEHZejMq2aXo0RK6ZI+7DWxEbAbAHac4g=
X-Gm-Gg: ASbGncsjE+Q6sIOvjYGatAYShMFFn2LTrVwsX3tomyE0ZRiZkDcmwmu0dL73EmPCB7g
	y+PdL8m/Bu+TrqXM4PKYuOlnsJ6q0ybT4kdwa/VhhdrzQPyq5rFREiMYqkO24e6vqxJXJs1FgZ2
	1rlu57GP11zHNVX/3UsJJ1d4bVySpOTBbaAClKHS5r1oyThBB5dQDOtpTmFQmNfIK1hKtAYh+oT
	lDMAwg7fEZ1ug+mK2LlkgjBU5yvuH/SYpBkJN1OXgk1aMRK
X-Google-Smtp-Source: AGHT+IF+ZO5Y2Gp4nFlsAx+6No4w7F187R8MDxdYO39Sc8nWC0dgPyV0mOjPzWTk8+ryT1t9Q6houg==
X-Received: by 2002:a05:6000:20ca:b0:385:fc32:1ec3 with SMTP id ffacd0b85a97d-38607ac4f0emr4407515f8f.20.1733400378815;
        Thu, 05 Dec 2024 04:06:18 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b496:c2c8:33f:e860])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da113508sm21934095e9.35.2024.12.05.04.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 04:06:18 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andrew Davis <afd@ti.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Kevin Hilman <khilman@kernel.org>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: [PATCH v2 1/2] gpio: omap: allow building the module with COMPILE_TEST=y
Date: Thu,  5 Dec 2024 13:06:09 +0100
Message-ID: <20241205120610.40644-1-brgl@bgdev.pl>
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

While at it: simplify the dependencies and drop the dependency on ARM as
it's already implied by ARCH_OMAP.

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Changes in v2:
- rework Kconfig dependencies

 drivers/gpio/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 56fee58e281e7..d87b3d99f8f7a 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -528,9 +528,9 @@ config GPIO_OCTEON
 	  family of SOCs.
 
 config GPIO_OMAP
-	tristate "TI OMAP GPIO support" if ARCH_OMAP2PLUS || COMPILE_TEST
+	tristate "TI OMAP GPIO support"
+	depends on ARCH_OMAP || COMPILE_TEST
 	default y if ARCH_OMAP
-	depends on ARM
 	select GENERIC_IRQ_CHIP
 	select GPIOLIB_IRQCHIP
 	help
-- 
2.45.2


