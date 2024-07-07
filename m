Return-Path: <linux-kernel+bounces-243561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D5F9297B3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 13:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E595B20DFB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 11:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CCE1CD20;
	Sun,  7 Jul 2024 11:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b3+I2ftD"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6CB1B812
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 11:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720352912; cv=none; b=F6+3TYsAQP2Jss0bPFLp5CZ4Fmnh+cMnxMGU/riT65r5AOUnQZVHMR8vjsztRuIcT2z0B/p+DU9aRaLmjPvZ53rwFIWx0HGfn8Tqj+4TdEqjMH4Bzt5rvVSIvYfR972ZB0Lzk1ac2yS6Da3bdYdr2xRzIcn22tQkWJcrsOheXMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720352912; c=relaxed/simple;
	bh=puXzOPF/AYrg4WFo42l3Uwt5Xf58Tys5KqMAY49+BPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oCgNiSbU+xDKdyC9bb8Bi03LEbJwYU1HyLAiL/9Pdo+1SWgZcP2pTi+MNdfa3EVHYWusbTrRnPLM2kQvAI+tU5Hen///B2f8/N2oUIY3M+jgwsWSa0myk5VlUD/cPLJlQQUupnCccuqh8hd4o0ltvEtMweEitx8mP0SnuoQOB9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b3+I2ftD; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-36799fb93baso2016130f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 04:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720352909; x=1720957709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aj+H9xvUnyjT7MSWsF+iRqKuLRi/HfbWIla1Bmzx9bg=;
        b=b3+I2ftDtfxi3jkf7Um5jmn0RQjmhWPmn9Kj/DVerJZambBG/SNLClTyAgdgH9Eqf7
         UxfLu4DmoDcD8/1L5wWj53lo1ReiPWy5lw2yRG+zIuW9HntGVb8BHJ0vOGKK2Tc/DtXO
         jLtFy2lYXeSKWefF1dS9l+wv9RF9WN2HIf9hHm0E4fHRHR9UjHURr7FNxemVyhLiwM3Q
         IRWI13LYkfE9jhhSw2Vw7mqw1vyH64yeN4lxy5gkHIUGZcrbGV/E/doG6liGWzyrHga9
         SN8Vkxl9ojfhuIbZJjMt6fapCRv1ncD38jxeyPsnTIgqUplesjDwdrpyIfiUXzHVv6EN
         s8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720352909; x=1720957709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aj+H9xvUnyjT7MSWsF+iRqKuLRi/HfbWIla1Bmzx9bg=;
        b=ukZ6vtbrMu/ilo6vP1CggfPUNDMpWObQEc94w1gvFQqGFjP3k7tFz8XodHEm6oHOPD
         sy/BxyuwXC3V2UC3bGDXApNmz560nmlI7tnpmyKDf3sb/zrumogNhjJR+MMMMxBk9fvz
         hPXzS1J7sD4Y2M1xe481HT1w5lhOZf2oACbaW4uAOEaNQrB/u4MXYVXfpQNoX/Hbyx1r
         R6ZoQoOjBhZlIL9ByvBvQtJFTwSlUWLyRJr8Jqvy5r+qLTT9G4BM5YzddA8p4+4m9mqN
         I1FJf8bA7EASkm+0VKZuPP0N1j2Qpr0hBJ7QslpxfhbdS9hDvCKAVxYYNnDG6EuTEvmK
         skUA==
X-Forwarded-Encrypted: i=1; AJvYcCU3RL06F1tFkuVVmTc1Xs0O+0c8Dweaqv/3A2g3wPFg1EncFGDttsTxDkJOTyf6K1qQOjROQB3qlE2uZYBgj9K/GLr8XmMXVowhRRnE
X-Gm-Message-State: AOJu0YzeUawiSiCAlxRC9A7O2z6kvrYq+Gu0bqwt9S8fIB6lGgFTSkPB
	6aSCOmHnOkTI0UkM1ujzO2k5YjYv7bmg6HsoQ/X4IU/DPVl8csoB69jH4K0NRDM=
X-Google-Smtp-Source: AGHT+IHeMOE4bOFQg+g/YY8EP60jFy+PSHmwQodEWUVahd9Sv7efipLc0NJkFBPW7S07o5gHz1LR0Q==
X-Received: by 2002:adf:ab1c:0:b0:367:9791:f155 with SMTP id ffacd0b85a97d-3679dd55b9emr5247812f8f.40.1720352909065;
        Sun, 07 Jul 2024 04:48:29 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367b09401d3sm4926279f8f.28.2024.07.07.04.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 04:48:28 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] mfd: syscon: Simplify with cleanup.h
Date: Sun,  7 Jul 2024 13:48:23 +0200
Message-ID: <20240707114823.9175-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240707114823.9175-1-krzysztof.kozlowski@linaro.org>
References: <20240707114823.9175-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allocate the memory with scoped/cleanup.h to reduce error handling and
make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mfd/syscon.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 7d0e91164cba..c939a76e83b8 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -8,6 +8,7 @@
  * Author: Dong Aisheng <dong.aisheng@linaro.org>
  */
 
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/hwspinlock.h>
@@ -45,7 +46,6 @@ static const struct regmap_config syscon_regmap_config = {
 static struct syscon *of_syscon_register(struct device_node *np, bool check_res)
 {
 	struct clk *clk;
-	struct syscon *syscon;
 	struct regmap *regmap;
 	void __iomem *base;
 	u32 reg_io_width;
@@ -54,20 +54,16 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_res)
 	struct resource res;
 	struct reset_control *reset;
 
-	syscon = kzalloc(sizeof(*syscon), GFP_KERNEL);
+	struct syscon *syscon __free(kfree) = kzalloc(sizeof(*syscon), GFP_KERNEL);
 	if (!syscon)
 		return ERR_PTR(-ENOMEM);
 
-	if (of_address_to_resource(np, 0, &res)) {
-		ret = -ENOMEM;
-		goto err_map;
-	}
+	if (of_address_to_resource(np, 0, &res))
+		return ERR_PTR(-ENOMEM);
 
 	base = of_iomap(np, 0);
-	if (!base) {
-		ret = -ENOMEM;
-		goto err_map;
-	}
+	if (!base)
+		return ERR_PTR(-ENOMEM);
 
 	/* Parse the device's DT node for an endianness specification */
 	if (of_property_read_bool(np, "big-endian"))
@@ -152,7 +148,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_res)
 	list_add_tail(&syscon->list, &syscon_list);
 	spin_unlock(&syscon_list_slock);
 
-	return syscon;
+	return_ptr(syscon);
 
 err_reset:
 	reset_control_put(reset);
@@ -163,8 +159,6 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_res)
 	regmap_exit(regmap);
 err_regmap:
 	iounmap(base);
-err_map:
-	kfree(syscon);
 	return ERR_PTR(ret);
 }
 
-- 
2.43.0


