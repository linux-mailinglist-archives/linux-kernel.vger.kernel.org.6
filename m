Return-Path: <linux-kernel+bounces-289968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C295E954DCA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E751F2129F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB641C4618;
	Fri, 16 Aug 2024 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BKNSOX7f"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE7E1C3F27
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822338; cv=none; b=q/rP9V5UiYdSiYlwPIdXyfxNihthkwarf3ztWDlJ/C17QDwfj8PZ2KPCHFnYedXxZ0XPlS3S31u/z12zH6YaX/q8Kgi34HALDt72x8aVh2b2iusIGEg1d6k7GGjVK59xYSC1CXtEzFH7B9LwsXElXVrErrIv8uLrPcP81IFd/dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822338; c=relaxed/simple;
	bh=3ARnnx7uT2kjUKO/lBdUAxqqDcV1RDRByaeh6p9QzVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mFhgEcnpNr5J5dPB4+d/pvl1J0dJa8NRaGTwMfFLzF2YI/+UHZzXZvKdTsghArLyEiZcG47xCUoaTiMRCIbAEqovmo939msEM2lDACx1ep+Eoy3qEyHqOsOZzx6PIEexglfK8iyqMy8VNXOLN8xBP01qQW2ktZkOVetPWMD5UIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BKNSOX7f; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-428fb103724so16744795e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723822335; x=1724427135; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LOl1ZqBXdbAJXZzTI3BlQ8z/3fBsZwwoZ15vO5UkJdk=;
        b=BKNSOX7flAFtVilcKIw3BjpXNGzn4eU3cILCKRB0fSZ6SWhexbvHVt9K0F/SDsDc3z
         MMZrWiADE1Hh8iNbl4HX19sakphr8WyuxafJ/EdsjjrpDJMylUP0IS+UP+oVXeJDGFcE
         WBGEHe4faNl6i8zvEeukJQyY3ZovcrJP5xYxCWTygTsvfgF9ohivcxovaFN53AtYN6Vf
         X7rwiGFmZRZt/CSuErTn2pUXbwkMzgFNYbEGDDYa4GmPAYk3SL3SdW/R130IwVPIj2VE
         aCmC1E3umaXSDuGK4j93uu+Q9mfLpFTICeP2Evc93AMRLOFc3k/XV/hIY28qcyUf5ej4
         FS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723822335; x=1724427135;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOl1ZqBXdbAJXZzTI3BlQ8z/3fBsZwwoZ15vO5UkJdk=;
        b=YCTOEJyzjuF/QWg5S1u4zUvJMCYn5wlOacvWvUUqCcFBx38rGkB9ZceRazq55sZjEB
         CqVPuV2cr4PP+EuRyHfTR6QtwdsORaV5/d2CuhFp9E7uPbpUfdDb7os8CBe6/TBU7Sbo
         zQXf+j5IkDw5piAw1wHryfojovLLUf8FRBRHWaf5vwwZLO027gv+zLyL1yoAFQrKc3jr
         Icy3cgbFmBGxyWsWebXu1791Mgn0NndNEKaOCuBObXsYSP38zl6WQz1whoLwx7dAltdX
         sZQwRhtt7JKK+TiEZU08tQXyZa86GCg4s9kTX+OCBJwQ7Zw5tyPa6ELwm3QjjfeQmVZn
         Vtsw==
X-Forwarded-Encrypted: i=1; AJvYcCVUBTb11wkT9TozAZ+gA5jqYCoSQZIr/k5yopRh2ENlQS6RMughzlkpxMm8eJS1npIyr0lMmTFKobkdqGnPxmv6JPOeGF5SR4IE+u2A
X-Gm-Message-State: AOJu0YyvbXXMPsE+oZH3StbNkuSyA7y7SsE12aNWWDlr9b36vdrGR9lv
	BxEWqRMQtx5bxnmMnMFLdb6j0TbK67dZNN45CzSL4LVXb/V6aLE00zV5uF8BLpo=
X-Google-Smtp-Source: AGHT+IEFjSH4WqobBhV+up3oZ7ztZRwBuC3HgNzLRXaYpTTRLatXBwsIRxgmIFfySIZM1KogU0AXTQ==
X-Received: by 2002:a05:600c:450c:b0:424:8743:86b4 with SMTP id 5b1f17b1804b1-429e232b8a0mr50953985e9.6.1723822334803;
        Fri, 16 Aug 2024 08:32:14 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898497f0sm3853661f8f.39.2024.08.16.08.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 08:32:14 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 16 Aug 2024 17:31:46 +0200
Subject: [PATCH 14/17] leds: pca9532: Simplify with scoped for each OF
 child loop
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-cleanup-h-of-node-put-var-v1-14-1d0292802470@linaro.org>
References: <20240816-cleanup-h-of-node-put-var-v1-0-1d0292802470@linaro.org>
In-Reply-To: <20240816-cleanup-h-of-node-put-var-v1-0-1d0292802470@linaro.org>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Riku Voipio <riku.voipio@iki.fi>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1474;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=3ARnnx7uT2kjUKO/lBdUAxqqDcV1RDRByaeh6p9QzVk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmv3Dl9NwZPB/MApEGkh1nDqgHmMiX/P3/AIqpm
 RoLHvTk8y6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZr9w5QAKCRDBN2bmhouD
 19g0D/wMAqWjPIbSHETSNRfB9R/1HlUm5xI5ndiN59Zcgwr/clBCSt48gRDMuFGS05K/kNaSvRO
 8IbtYru6I5aMaoGCHU1KgbcevPw39TynUzLejaKERSJ2zXJ8UQ+qvh80ce/3XMYlfCBf9b19psi
 xRyJnm70aht0YnafXUBRfWvp6Im9/I7y1YV+tXBnLIKXrWLznSUDTHXSs7EKODOjnqt4mFNJfew
 qMZ4Lu9SFU+kG99RWVs4R96XWtdI5gtCmt9yjriDw5/cD9GE4Ad7Wjk+juXE5HvEjl/hZ0OnokN
 3HsBKw9y+68dZIwQVVDmPPZJb50/DGJstWUwxOti9yfDxKYMCkW/+dZf1/LxZYvuxb/0WOvODM5
 PNeM2bx/y0m/cOQY6GAYpu8UgoAbMWzQxufvxjUN52w+IQjQ7w3epmoZLycDyPEFvVQ9+Nz7kOQ
 I3QvW+PFDLC+htKn3wV0X1Adnhj3CWolfRDdVQ5m/UMB2EwDZy+VOthEx7pNzC5wcmFzTXoL6Sx
 4D/8ee8LHgG/8I5MiNA6wVgqUJCu/NJE1DY6XJ1JuVTbs8qyCiLVW8bJ/yo4ecJgPpBBhPTGdfE
 Ld2si21avus1XNVlYHHao2BVVh3XLSmqiMvmaWBGvQw3Y2J0/nbyOBAcRN0BUWe6W+N0RGJ2O2a
 fZZYbzRJlMQmwbQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use scoped for_each_available_child_of_node_scoped() when iterating over
device nodes to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/leds/leds-pca9532.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/leds/leds-pca9532.c b/drivers/leds/leds-pca9532.c
index 9f3fac66a11c..338ddada3de9 100644
--- a/drivers/leds/leds-pca9532.c
+++ b/drivers/leds/leds-pca9532.c
@@ -506,7 +506,6 @@ static struct pca9532_platform_data *
 pca9532_of_populate_pdata(struct device *dev, struct device_node *np)
 {
 	struct pca9532_platform_data *pdata;
-	struct device_node *child;
 	int devid, maxleds;
 	int i = 0;
 	const char *state;
@@ -525,7 +524,7 @@ pca9532_of_populate_pdata(struct device *dev, struct device_node *np)
 	of_property_read_u8_array(np, "nxp,psc", &pdata->psc[PCA9532_PWM_ID_0],
 				  ARRAY_SIZE(pdata->psc));
 
-	for_each_available_child_of_node(np, child) {
+	for_each_available_child_of_node_scoped(np, child) {
 		if (of_property_read_string(child, "label",
 					    &pdata->leds[i].name))
 			pdata->leds[i].name = child->name;
@@ -538,10 +537,8 @@ pca9532_of_populate_pdata(struct device *dev, struct device_node *np)
 			else if (!strcmp(state, "keep"))
 				pdata->leds[i].state = PCA9532_KEEP;
 		}
-		if (++i >= maxleds) {
-			of_node_put(child);
+		if (++i >= maxleds)
 			break;
-		}
 	}
 
 	return pdata;

-- 
2.43.0


