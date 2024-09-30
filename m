Return-Path: <linux-kernel+bounces-343909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD5898A123
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2285281628
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D96218DF8A;
	Mon, 30 Sep 2024 11:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qowd6vvh"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9A514389F
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 11:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727697087; cv=none; b=qDx2lPwk4gpuKUHq72JG7dpdxzYkBqseFS1vzlr3Xf6KsFFX1nXLBGE0PTGic+fGaj0SjdaL6PdVXlo+x/Hsph6KxLqnj4rHIz444FlZpUpIq4cc+lfAJR5611SiameuwPDLwhR8gtB2zdaGNY6/LJJTWn0iTm98pI0QM5IDSOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727697087; c=relaxed/simple;
	bh=08fE7fYBrd9zzYFvSZGijl+vlzjHnu0p+at/BJfSCRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SRGgSq8TJ8q1ryVu12loEjxn/5hakBpnOli7LMEMWvjZFTxZo41FNj+cC7woIKmXFN2EyTGf89PGeD3EDegkRy5+eu0QBVhE81lpSV0UK3c7bKrUvPUfNt/7CGhjEeHXBlaJkOyxcphgS3EZ0ba5KGRw8NrKbD8h6p4tUpfllrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=qowd6vvh; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37cd6ece97cso1528752f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 04:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727697083; x=1728301883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cnhN28xiUyoIoByfTbaiA2O0cDcMJ2MqwIpLUCd9bBI=;
        b=qowd6vvhpW+QgPrXQvnCTJrPC3k1QOGfY7SOLDCDIXKrrOu5ofKXS4KB8QsyRBRtsB
         aDLTkQeHYigkj1TG8cWEfNjh6Ez4o1NfjupZEmQvdmtX308dEvA5LvzZhG0XMGJZOTkJ
         RguE5AJDOhgMuxIlM2xJ1Xh8utjLLsJApY+I0Np2ezANJ8fbSnU0SCwUV2TKdL7b5oqp
         LlWzT1gNb3VrL2xFR+z7jy/o6fkvN3RCFtvvnbLhFRWl4qo99rcRgsRLBGQ52RZ6z+NV
         WnGgowHXp/QD+ZZlDwRZtknxH4QL3gXaJH8hPtxeucNiODYzn4Cltc/bDkdkiC8O3EqW
         0M9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727697083; x=1728301883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnhN28xiUyoIoByfTbaiA2O0cDcMJ2MqwIpLUCd9bBI=;
        b=hOccAEG8ipRr8baUIx7bHhkQu4HArBmkTGNsqCqUJDEQP8vM9VT6hi3b8AfXsH0N82
         PjTLrU+G6GWSoeWPJU5zdn3c76hSa6adCqThZrGB4FCmfWGl4ni4Pqtt1Idyg5XiSlRu
         VbCkD4RtfsZp/LPh9d5yOemhTEaXZPbRE9Y0JfYg/deQmEdkASvG9msJAKSotvOrf9EW
         1CzvE9WreUrl0ACZ6PwP0Iv+PNgAPtIfoetTIduJDcXvi69XJfktlCQAiOILDzAYBlsY
         OAsp526QTPFz8x+9EvUUwyuPa7o6R6Ta5N+X/dZhuOyQU3Pcqv+nCn5tlmNg4EwbylpX
         Mm/w==
X-Gm-Message-State: AOJu0Yx8zrkjtdA+99hDiwP6fT3I8DYmf9HGAl40PzVN8vKRr3oe9Yss
	1AouWEzokuW4ca+VcYE3t5DQlpxz0HoNMTGcWuEwmNwDdccVLb+to5oiSipPGeU=
X-Google-Smtp-Source: AGHT+IF/MGS3gPBd6+OZGEUxxfHt2P526pBHts9h9Ayu/AEOFTFndhTAJWIXTMj2X7G41ltMrPoZyQ==
X-Received: by 2002:a5d:45c8:0:b0:374:c847:83a with SMTP id ffacd0b85a97d-37cd5a6b581mr6341799f8f.8.1727697083178;
        Mon, 30 Sep 2024 04:51:23 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:8791:e3e5:a9ca:31a6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a362bcsm148996985e9.36.2024.09.30.04.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 04:51:21 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Keerthy <j-keerthy@ti.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/2] gpio: davinci: allow building the module with COMPILE_TEST=y
Date: Mon, 30 Sep 2024 13:51:15 +0200
Message-ID: <20240930115116.54626-1-brgl@bgdev.pl>
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
index 643747da4475..746f2a8f3106 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -243,7 +243,7 @@ config GPIO_CLPS711X
 config GPIO_DAVINCI
 	tristate "TI Davinci/Keystone GPIO support"
 	default y if ARCH_DAVINCI
-	depends on (ARM || ARM64) && (ARCH_DAVINCI || ARCH_KEYSTONE || ARCH_K3)
+	depends on ((ARM || ARM64) && (ARCH_DAVINCI || ARCH_KEYSTONE || ARCH_K3)) || COMPILE_TEST
 	help
 	  Say yes here to enable GPIO support for TI Davinci/Keystone SoCs.
 
-- 
2.43.0


