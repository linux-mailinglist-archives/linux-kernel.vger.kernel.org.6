Return-Path: <linux-kernel+bounces-344277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A6198A7B9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D29D1F24346
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793E0199247;
	Mon, 30 Sep 2024 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jWX/7Qvc"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5206A19048F
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707696; cv=none; b=eNsVXwT/1XirozTgDVKnJYFbbQiKY8yBcx/CO9Dp9MtUNIBhbXevUEELidWqDV/61+6pnFVRF6rL04mEN4G/fjWuTvQ0h3jSf7r4IIy8E/o1E+OnzgBEcgfxxauA5IyB/wBPQ9cLOknd8BeEfgZM04f0dpW6DMA+SEGMjIIvEgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707696; c=relaxed/simple;
	bh=dS7033UK5o0SDp12ez9+MsK/OvK6hEmTLroWCeXZvno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WsOdxpFfVN1YjXBYZw9ust6M3D1VTPHeL2Wlp74154DKpUeOfAj4Ys6TLvZqbRJsY6Mge0dgnK0JcE/Wz62gRMQmri9JrP0ASUXjLMXCEsCHtZuZSUFfMj0TZnD0uKVyCTaIzXxMZ42MBObXJ8IlL1RjKmplzt0e+glKgtiCqUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jWX/7Qvc; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37cea34cb57so567244f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727707691; x=1728312491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5JPVDbbNqioPx5PpN9QQ9QHeM55uETxow7YFSewChHo=;
        b=jWX/7QvcJYtxl/uqE1ZFULxjKzK0zKk5tv/lU1MGKHKdaIltfKKg2yL0uVl7CAN9LT
         7Mhny4MTLEfVv+Rqo8dBjrRFcw+0GGgLBPDHhHQyJaZS96anYZofc6jKzESBfyZSEgoZ
         1M1PmGaJeQHMkeavU/lZA0iFHV7jOcslJo1fX6/+AWRw+YvDOHjRnoLfivnUKfvYJF96
         9TWpTa71Yy/YyVPhrYHtqMoLpmp0Q5WggQMAf1OLlrpl5JXpi4pTrqiChjg18Uqh0hzY
         JvKQOmvSzIJBoNSBh/R0H2G7Rt+qnbLQEIizr/dQs3iYmCkAfaNE7cAPPvvIm17hlcco
         6tbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727707691; x=1728312491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5JPVDbbNqioPx5PpN9QQ9QHeM55uETxow7YFSewChHo=;
        b=mmYmKxexdUkLnngnEU0cxtX1ussMNaoU4FCZtP94H0LdV851Djz4J52JbIf5ukW5DY
         iZBN442PCqjAwOz6AKm3e9YdB4EChEnBcTGYWQjHcfMF1CCDtt0H2ZrE4yHA6uQ3pus1
         vl5oYim5yNBs/Ch8aCH8V+SoyFcv1ZO7+pxxeqJRrHB9qVvR19ZeMvY9tLHSKJ65OTqA
         qFVcPFL+a0MtGpSTCfzhVNfW9Yj0rb1DEEGKZ3W2eQYmmy3Y0o6m+gL3FIo/XxWrViBa
         tAmlEFqYgtFplyPn7OU4zZ/2DMdNZ8ppbYkdpXJs7q2NyM/vryrC35zbKkWtARCUQwhK
         cSag==
X-Forwarded-Encrypted: i=1; AJvYcCWSARgrIj4B6A6CX5mURLUPCa08rCR3WHX3Qj4wb7c880y1ewohYKZfpdMF+11ZbMDP+LjkL5NW7a1sd5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmoraTPr5VE6O547wFZLzL6jSCBVFqyEmhuAr5CYsBp5XCIbO/
	4FBq6rO8xNW1OMKbJ+RiPa4P8amdri115qwE5ZuCuOjBdyFb6Wrisds4IcV0UEI=
X-Google-Smtp-Source: AGHT+IHEBWsgzN+e1E83ihM7s8lCg7F/C4ranxA5EM4TGZYF65BQAsQ7T5R0fceezMF+TXipft52dQ==
X-Received: by 2002:a5d:4572:0:b0:37c:d183:a8f8 with SMTP id ffacd0b85a97d-37cd5a82669mr6394506f8f.19.1727707691355;
        Mon, 30 Sep 2024 07:48:11 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:8791:e3e5:a9ca:31a6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd566a41fsm9241505f8f.45.2024.09.30.07.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 07:48:11 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Srinivas Neeli <srinivas.neeli@amd.com>,
	Michal Simek <michal.simek@amd.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/3] gpio: xilinx: drop dependency on GPIO_OF
Date: Mon, 30 Sep 2024 16:48:02 +0200
Message-ID: <20240930144804.75068-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This driver doesn't really depend on gpiolib-of being built and can be
compiled without it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index d93cd4f722b4..0d676c96b72d 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -796,7 +796,6 @@ config GPIO_XGENE_SB
 config GPIO_XILINX
 	tristate "Xilinx GPIO support"
 	select GPIOLIB_IRQCHIP
-	depends on OF_GPIO
 	help
 	  Say yes here to support the Xilinx FPGA GPIO device.
 
-- 
2.43.0


