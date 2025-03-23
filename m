Return-Path: <linux-kernel+bounces-573021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6966EA6D20B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 23:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E113AA553
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2AB1E521B;
	Sun, 23 Mar 2025 22:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E++Fv1W7"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA301C8619
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 22:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742769571; cv=none; b=sOH8hlCGB3JlPIeptPuHnjpdbWbrcGUugSyKjgovs96X2JPpthenIuLgyBNeJw161Y3LHDTVcKc2zGpq2zqtWqatKQU6plnRTlxpM5g8MiUqrV9DNwle9KCChUrRfQRiW+XuqK/K16KW8rCIA56a4/IQwPBwLUjIQFHQTBBy1nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742769571; c=relaxed/simple;
	bh=rkPD/zJcnab9QOgG4eBd9kcunv90F+5fDLXXmd7T+is=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hg4tBr7CAea66/KM4Zf5N+pv4quvkdyCRl0RZztZthuc4vamG07UHEE33Y056Re9vW+PnJvL32dRqEwvv2/lQYLu2w9vVPaq96WBsu+bSVxMCPtp3t52u/XArrESRkn+2R+kf7WCVq+z42YszVHwDd2IAkSyz2tywjL3xjJAFPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E++Fv1W7; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso764023566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 15:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742769567; x=1743374367; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=epweE/CfbfJt2xFB7j7q8NZbqQJAbZszVB23uUdGgMg=;
        b=E++Fv1W7pxUdPjZG4G+2GdPITas6vD8CUVFmOnxWhuFDdswGjRsLMVxTtJucZ/6k2j
         IQWkyjKucWUAKYy1t7NUvMWSmVc34wfwC7gzbYyoSNVPJsdLOJ30b7UhNyObvznw1W89
         2Uvex+ZOg44xlm8zFFjPaZVcCkdN/gki3+iU02VH8+XMiOTIUlNdyqYqD6A5pWTmrZrm
         V6vjthIpPa4LVGfqtwUAdsmnRnnx9f5K5nITynMgnc5oAh71kP9B/Nuf+ykFzRnSU2Xn
         P/SNXIdJXWNBnbQQlzsgJDa+IRWRlNRMEfzksq/6ftm64OdBn5b+NhusBaboA6nRU5jp
         lXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742769567; x=1743374367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epweE/CfbfJt2xFB7j7q8NZbqQJAbZszVB23uUdGgMg=;
        b=IKWhb/bBPyr/6gxhYPjORmSRJd2TnPf6W3/BvaalOB9H+NTRzY1yVY1eDbuDxli4EV
         AfecbVlr7PqhARF8TfTYtNOYzNSG3RL0/pNrGLWyM9DbsaBI46OOAJ5hvD51z/MIedQP
         ZTQzuenFHfi5ZByZrLs9VDUifBDNxmNiKzJcVPmyu7L0c0mVGIg9iMcb0+Ygi3uHDFFM
         9N97c3YzWyNZm76g3tOW6s8I1iMKa+t9P7vqYYf0cmzjXqyqtMKuVVpwMQ6E1eHTcfKq
         YjEoOZcvVzMUY1WgWzTT6SWWJOOyhvobq60OApm8jdroR/ZYCCC7TwOcCpZmftiPpkAH
         nByA==
X-Forwarded-Encrypted: i=1; AJvYcCVnWmgaTAvsvjnAlZXjms3DiKK3ewhxq727lRn8jXiQBjoj++ZWY27rU3UEWHMNLbDKZeWJbOuDzHjzt1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL8qfVV4MdRb04qerCYp2tyWti0jglm8fJ6QqVBlwuO4kGWO4K
	ro3TfPDEJ5Bi5LJ8Rmo2ioGrMQ49H4yaoZN0rytWs2zhq625zGzHw7L3mlDVfNo=
X-Gm-Gg: ASbGnctQMi2I+oC0RGlGL4x28MU3cldBecqVr2yHknB4sIvx5ect6OL0RwsypQb9JHx
	TFhltSOU/sixvq9L3cTaBPvvIl0vDB5bWWdMGjK2rbKFmNA58Bmpy8K1FiNS+l1cUgHlvKWZoxa
	Atox/tZGoJ1YAE8SboEB0G2fpUwD2PkWDGAWvvnp4IVr4c4XFgLU+yn9OJA66uCsDQUeU3k6bfn
	cTw+geCdimWAGgdKmrUQwc5C2O3o1Nb3PIfmorxmKt3etyO0Md/pe18yCmkZCgDImbdIuMWPEF+
	rjZAPXWLxouRv882+EScAY7FZw4TTk4NVLPvEkXpqFtQ6vnItppbiE0FfmPx81+xXWZ8M9uZgjd
	eIKt7BHipsTXqNZ5Y0BGvmFpXlt+s
X-Google-Smtp-Source: AGHT+IFxrAKkMvESpg2DzD65IhmLmaroltgGQ5JYq8gpBxP70jAXR5CPVBPl8pc6WMyqqMZfFh61ag==
X-Received: by 2002:a17:907:7f22:b0:ac3:2a54:875d with SMTP id a640c23a62f3a-ac3f251b8a8mr1007451366b.36.1742769566602;
        Sun, 23 Mar 2025 15:39:26 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e44dsm559686666b.31.2025.03.23.15.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 15:39:26 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Sun, 23 Mar 2025 22:39:21 +0000
Subject: [PATCH 05/34] mfd: sec: sort includes alphabetically
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250323-s2mpg10-v1-5-d08943702707@linaro.org>
References: <20250323-s2mpg10-v1-0-d08943702707@linaro.org>
In-Reply-To: <20250323-s2mpg10-v1-0-d08943702707@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Sorting headers alphabetically helps locating duplicates, and makes it
easier to figure out where to insert new headers.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/mfd/sec-core.c | 14 +++++++-------
 drivers/mfd/sec-irq.c  |  5 ++---
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
index 3e9b65c988a7f08bf16d3703004a3d60cfcb1c75..e31b3a6fbc8922e04a8bfcb78c85b6dbaf395e37 100644
--- a/drivers/mfd/sec-core.c
+++ b/drivers/mfd/sec-core.c
@@ -3,16 +3,10 @@
 // Copyright (c) 2012 Samsung Electronics Co., Ltd
 //              http://www.samsung.com
 
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/init.h>
 #include <linux/err.h>
-#include <linux/slab.h>
 #include <linux/i2c.h>
-#include <linux/of.h>
+#include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/pm_runtime.h>
-#include <linux/mutex.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/samsung/core.h>
 #include <linux/mfd/samsung/irq.h>
@@ -23,7 +17,13 @@
 #include <linux/mfd/samsung/s2mps15.h>
 #include <linux/mfd/samsung/s2mpu02.h>
 #include <linux/mfd/samsung/s5m8767.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/slab.h>
 
 static const struct mfd_cell s5m8767_devs[] = {
 	{ .name = "s5m8767-pmic", },
diff --git a/drivers/mfd/sec-irq.c b/drivers/mfd/sec-irq.c
index 047fc065fcf17f5bde84143d77a46749111ea5b8..5c0d949aa1a20f5538d8baf7a8aefc1160ffa14c 100644
--- a/drivers/mfd/sec-irq.c
+++ b/drivers/mfd/sec-irq.c
@@ -6,9 +6,6 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/module.h>
-#include <linux/regmap.h>
-
 #include <linux/mfd/samsung/core.h>
 #include <linux/mfd/samsung/irq.h>
 #include <linux/mfd/samsung/s2mps11.h>
@@ -16,6 +13,8 @@
 #include <linux/mfd/samsung/s2mpu02.h>
 #include <linux/mfd/samsung/s2mpu05.h>
 #include <linux/mfd/samsung/s5m8767.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
 
 static const struct regmap_irq s2mps11_irqs[] = {
 	[S2MPS11_IRQ_PWRONF] = {

-- 
2.49.0.395.g12beb8f557-goog


