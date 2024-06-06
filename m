Return-Path: <linux-kernel+bounces-204453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6B28FEF67
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB6F287E18
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA766197A7F;
	Thu,  6 Jun 2024 14:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YXJv/ZWG"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB2E197A75
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683889; cv=none; b=C5FarwqbmaTz1EbU8tUit8kQA9xdhp5n87yQeWZPllDvOtePuRUBGz3xl2bWNFHIvuhp7qQ3RtlkaPzldvzEJquAxXAIAvnd3VtJU6t6k0Ph7vaO0tjycQcYi7aXmRQH0AsdxW0BicpEWasWJoMWMcHxcaGDUIq1J+rcvmn4O1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683889; c=relaxed/simple;
	bh=2wdmFMwyhJogEgHyP/JfsfCGdURDardPyYMuizSHKdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Claui3eeAr3ScqT/JbAFq6jtyjlmIJ+yDLIUHdCciiSNEvLntlbgLzYJRmfhLXTVtuWfOPCTo1dFzwqTizohd4YhWmvXpehBp/Yj/0qJNJoFu+C+T9X2/esNAn0e8/EPN1KKr4hZR/a5bJlIhvyUyWTXxubkXK5g/UZ9y4t63uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YXJv/ZWG; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52b92e73e2fso1136315e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 07:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717683886; x=1718288686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xb5IzxHPDHxF7XfxqfesNhkUf5qflUpZIi271IJuxyc=;
        b=YXJv/ZWGibkE/2hm1flZs8STNfQqzDCZ1s993q/6+4oOmT5n1ZNo/CaicmYWI+j433
         EEPy3iUSxhFNa7D+h48x4+sYWoaj8PHLHXVfFRfmNvuMAk6hSQ8oUJHpc3I3f6e1fasi
         N/brgnlIGmZ+MpX8t1FkHjzp2ncWdNP1CFVQBTgbZRLRo9kjdR3VorxmCbWfHMQDp9pA
         6Euz1uL7JCzlW1DzDstAr1UT/Su8Xa5os3FnSROSl55YsbbxTz4VSevv66UHSme/rsI6
         lY5ToU6pLoPER/1BM6YOUQ4gKk1aJJIN9I5WaY5uB4aaGx+W2FJmUeRNzfA2vUEyr8aW
         9yPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717683886; x=1718288686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xb5IzxHPDHxF7XfxqfesNhkUf5qflUpZIi271IJuxyc=;
        b=BuVfERy5ReZ47/2u/GTkpiYK07gtM0ujRZsS56uPbwWlkQ+oy5JvXA8rnqfOOd6+D+
         U8fzJOKPmhF1x7b2Wgv3ALxY/Yx3wjd0zVAUxDutRNjQ2v+rZTQzGrFjCR1Jsd0j1dlC
         O6MPgt0SHutSRtVvEDBTlLvk65ebjEIqzUpH2bX8Xltyrw+b4wgQxdeWjXFL/bWGg15y
         zj3J3k3Os2k3gnbg7bWI9jezHTKDtzqyl5iT23IMrYqTPsu3/7zHncq8gscWc1lRyf3f
         a9tr7eAIt3w2jQ8ZpvamZPuQBI8QxgfIKQ3yQg10Zeab6AjhiwaxVdhPSLH4v8RWlab3
         YqpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzRNM+Z+c3t/sVlHc0TGa8O0LxGwJik6Q6I36X7eWoB8KaerPXclQ0wrNeVmhLHP3zedDovZw50CJsLU2qK1uJnGC6nyPxO0tTIjhf
X-Gm-Message-State: AOJu0YwWAFPzFDKHUQnNfUeGtlJMnYeJ05uMEQl+NjPCPZ9zn7zzBz5i
	WBuzWYpW7PNJ/zy6T7cWBeqory0ZVGc8rBKC5ACnPjFahIxHguttCRpEyfVeC9I=
X-Google-Smtp-Source: AGHT+IEx8HRSWaBTtfYg3nCa8mP+YSdRQvnvQSL1xfyvSFIVXLKtPpSIDoPSiqW4rrkYIIIiUzFSSQ==
X-Received: by 2002:a05:6512:110f:b0:52b:8435:8f26 with SMTP id 2adb3069b0e04-52bab4f43b5mr4234853e87.44.1717683886172;
        Thu, 06 Jun 2024 07:24:46 -0700 (PDT)
Received: from krzk-bin.. ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb41e1fe0sm213854e87.58.2024.06.06.07.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:24:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Mircea Caprioru <mircea.caprioru@analog.com>,
	Peter Rosin <peda@axentia.se>,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] mux: adgs1408: simplify with spi_get_device_match_data()
Date: Thu,  6 Jun 2024 16:24:43 +0200
Message-ID: <20240606142443.130517-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use spi_get_device_match_data() helper to simplify a bit the driver.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mux/adgs1408.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mux/adgs1408.c b/drivers/mux/adgs1408.c
index 22ed051eb1a4..5386cfedcb06 100644
--- a/drivers/mux/adgs1408.c
+++ b/drivers/mux/adgs1408.c
@@ -59,9 +59,7 @@ static int adgs1408_probe(struct spi_device *spi)
 	s32 idle_state;
 	int ret;
 
-	chip_id = (enum adgs1408_chip_id)device_get_match_data(dev);
-	if (!chip_id)
-		chip_id = spi_get_device_id(spi)->driver_data;
+	chip_id = (enum adgs1408_chip_id)spi_get_device_match_data(spi);
 
 	mux_chip = devm_mux_chip_alloc(dev, 1, 0);
 	if (IS_ERR(mux_chip))
-- 
2.43.0


