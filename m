Return-Path: <linux-kernel+bounces-343647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBCC989DAE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33BDA1F21958
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A52418755C;
	Mon, 30 Sep 2024 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2qGN8hon"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B481183CC1
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 09:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687481; cv=none; b=SX0BtJzZHQEgvKNnlLSD8YyR6pOp4hMBRi0pA8QxrwccxWJ7PWRcL2hUICjrPQdlbhSOy4UAICiCeYAWsGVRJIu6aOVDDoNN60HfkwKlreCyzxUolXYBLawbJwu8gdclpnMe5fYzaafINy64Uv3lrj6+kcRDFxHPnHrYbvOL3qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687481; c=relaxed/simple;
	bh=qDdYD6XtEzoE+bIvCc85PjknxnyK0Eqt2/xjj90H5dk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bVscTCjBzx5aPzTh9sI+aMWUVqvL4pPy0cpIJYnaPtDZnHPqSRflYUi5ouKqHCHnCS/mAwYtYM5Lbo8k+/9PZF1LVDPChya1fDT+NiSpbnwznD9xvG5A4SPtarIgRKO/1ggEzGPAiUdO1Pk0Dac1iDLpqgLm0CUKzUr0kQVrbww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2qGN8hon; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso51111775e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 02:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727687478; x=1728292278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c+AJ60vTnn4OfaHASmdMRI84bP+OXJuds8ClPyVwo7o=;
        b=2qGN8honS7IB5rjKpXbReW13wG2oqFNPHi0+agaz4pOy+CrjzoLdl/lO2qh4AvrSEI
         iZLn+gnTvNSyMKxxyw3xXj3opLiokCV/cI1PE7M8b82lRODuUPBjF82SK1PDsP2JVbOX
         LNZVfdy4bMTD9LJuD6z4WSks/sx6sLY2J3DYsm+gjfddhtNWTR04itxpp3yiHmt/wPNp
         5jdl17DiC1WdbDz8zeW2pJbgIJ2wCITnPuInyTc0BB5uBctRnIjuv7KMhtseoEz3Tl/M
         uekIccURRbC3Ho79EWncQQAHnlVq1THn1dx+6TKg3rSHWW7sK2uNYMRmrENXHgvrArBa
         6gTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727687478; x=1728292278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+AJ60vTnn4OfaHASmdMRI84bP+OXJuds8ClPyVwo7o=;
        b=g4Mx06xpsI6tU3LXpjDklHisqMhwHb6A7dKJe0ODBpuSKntdpExyYyp6WK/9rGfct2
         83CliGUSFj5j+N7/5HsTiLCioqE7RjDseoHRamf2f77K90HIkaeVY2eRvwM61ubKEiJ4
         dnysQdXntHJBja94wDIGdWTyTOtyAI+FHuuAksX1nuoDCXmJiCF7mHf7CHCOt/Xq8sA7
         8/kV/OUtsC2v/OV1yjs9Fg1ySyXNdYq5jqHviWMfIAG8UJoDeh/GsRC3IbSVLgGc9eon
         7Pc3sMrMP+OH6UzMU/RRCbX871kL++GlzotRdf0v6CDcJVFu4ZwwiEnKKpgye42vOrpd
         zHtw==
X-Forwarded-Encrypted: i=1; AJvYcCXphCTchWSUlRcrfvMT8j5DSnehR45cuSZZrPVM+yL1OjOl2Bb4OcXF5cD+on2i+zjuydcD74cnOKd+vL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiYRw16NzW6NbLN85F4PiHsS8CDAwGLUzFMsUYDubqrABiMYrK
	G0Zua0zXcJtujjhn2pg4GBlaLwnUKLWOIPGDrSWJncniEcMqvT8Ht34DX3eVOlw=
X-Google-Smtp-Source: AGHT+IEakmid4weMzgcB5hvS4fmSB9tjRPWOIxYXsK8WdO+Z/xh1QbooPSntbIPib3f58YLkywXBIA==
X-Received: by 2002:a05:600c:198c:b0:426:6e9a:7a1e with SMTP id 5b1f17b1804b1-42f584a1d36mr104426815e9.35.1727687477578;
        Mon, 30 Sep 2024 02:11:17 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:8791:e3e5:a9ca:31a6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57dec169sm97231595e9.21.2024.09.30.02.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 02:11:17 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/2] gpio: mvebu: allow building the module with COMPILE_TEST=y
Date: Mon, 30 Sep 2024 11:11:10 +0200
Message-ID: <20240930091111.32010-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Make it possible to build the module when COMPILE_TEST is enabled for
better build coverage.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index d93cd4f722b4..98722e814e81 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -487,7 +487,7 @@ config GPIO_MT7621
 
 config GPIO_MVEBU
 	def_bool y
-	depends on PLAT_ORION || ARCH_MVEBU
+	depends on PLAT_ORION || ARCH_MVEBU || COMPILE_TEST
 	depends on OF_GPIO
 	select GENERIC_IRQ_CHIP
 	select REGMAP_MMIO
-- 
2.43.0


