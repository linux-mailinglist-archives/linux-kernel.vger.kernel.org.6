Return-Path: <linux-kernel+bounces-204454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E81B48FEF68
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 537FDB288CD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D117A199E8C;
	Thu,  6 Jun 2024 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u27PvCYd"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79032197A75
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683903; cv=none; b=F/NcClhoztESPUdhw2Tmf7sg+NS6wxTtaULyvYVEGDg3UOcr5bnZQ8izr8Zf02JwJjn7ak2Y/uhbfXD69jdPEoxYwoBpKJ+9U7MbvXOW5gA8+2fVpx04dQ26uEf8pAcDUCLbQ7O6QZZ2xV24g4R0zSs22dOLCf4mlrK3VkPump0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683903; c=relaxed/simple;
	bh=HxuTLkBQopINQRN4REuwcUtobjjBsG1xC011iW2JoWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j8H1jgjCVkXr/9Xr+qYgJ9rlo7EC7PNXzUezgOW/cPAjZq5NHWMnFvYWEYncghPV/lnoGOw7XoJhSYJ19BsFwUAQHRcaR6nKdd0zLD496LMnrlzT3nrd9KHIP8epS6PzXqTzlCxKUD5pRmeyWHyK3ohxErURFdMmuExF17Cncn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u27PvCYd; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57a677d3d79so4072504a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 07:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717683900; x=1718288700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ULCmZTLH9n5CknDHZXV8N8Yow6DCNDPV4w3gxTOWljs=;
        b=u27PvCYdmKHg7SO6PBC1ShHSM1557TcaZ6o7kSdaeLSfuMsDzJNdztOujAN+vEyOHU
         U1oUmByhSGD7nkLlRnix1n/7N3ktQk+1HthksvTyHju5qMvKwYvL9pu39R5TMH0NDU/R
         e/kxmHgSG+JvsFEDnRDn5L6mXOsikm5EkHCsDamzKqTyGy1+ZWz/7BKawMKUZmg8hZlN
         I0htJX1aGZcO5r8CMzZHDBnmkdRyLkN51dxunvaQzi8pVdHUpneaUw62kdFx4aFHUKsC
         ZWMr7FhU/Z9/gQkITSnwEVzfU5mUnbZqIH5EuOqt2kq0KoWN86EOEEquW5O3TvA+R9Ln
         4Pxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717683900; x=1718288700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ULCmZTLH9n5CknDHZXV8N8Yow6DCNDPV4w3gxTOWljs=;
        b=DG7BH0QgD6QJ1E+4ZnWw+HaO8rve47ZpohEQIoib2n798UDZ7QSQoW0pvkpGildWGK
         wC7rKkZdzSrrxVdU1/VQLcM2cYrVcDCHP4pVOdVVW2wcMzK+q+nWNDR6frIpiRJwWjW3
         z3UKIa0WkE2Jn+3eRWPowtTwTUzRWZt5m4B3Jo+4keVRzSRjhlBeV8HEPsSZcCuj7GAe
         jyluy+NLV3rG/fpQ6/kEvd7zy7yhVNWF+LkwGvHWHTlj2Swt/+19AsKS7Wp41Eb9IfEY
         xvORrrgxOMY3kOahkyq9tmdbrKA++Hexcor4vPKzR4ZWkJ7sRyfosI/uf97hW7qhp1P2
         jd8g==
X-Forwarded-Encrypted: i=1; AJvYcCUGkf88f0NYKcFZm2yb63v0mXQ+1A+Lkk/ekKNAWfmUl4LEfYvhV/IR7+S4Kt96HZKmcG/oSovlsAL9I9eCEXjH4+PeWQ2iIvBoJ/5h
X-Gm-Message-State: AOJu0YxWJxtJvuy+W5pkSmauaYeuCLVfbyFjoWxuIJsUaYBG66XDh189
	mrauTDfAWbFmeyupZ++Qv2c1QxF7aHhTNvr1lRqdxN+blf6ummIV1aby3WZsuqM=
X-Google-Smtp-Source: AGHT+IFy5SbbOufUy/PtgBUt0Mn2h32RxYk6OQCJyJWhipcb0m0KlPl6vMlWDiXkxRkGrv3OlXeODQ==
X-Received: by 2002:a17:906:4154:b0:a68:e268:fa30 with SMTP id a640c23a62f3a-a6c7651ad4emr200470666b.38.1717683899900;
        Thu, 06 Jun 2024 07:24:59 -0700 (PDT)
Received: from krzk-bin.. ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80582110sm104953466b.32.2024.06.06.07.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:24:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lee Jones <lee@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] mfd: arizona: Simplify with spi_get_device_match_data()
Date: Thu,  6 Jun 2024 16:24:56 +0200
Message-ID: <20240606142457.130553-1-krzysztof.kozlowski@linaro.org>
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
 drivers/mfd/arizona-spi.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
index de5d894ac04a..eaa2b2bc5dd0 100644
--- a/drivers/mfd/arizona-spi.c
+++ b/drivers/mfd/arizona-spi.c
@@ -190,19 +190,12 @@ static int arizona_spi_acpi_probe(struct arizona *arizona)
 
 static int arizona_spi_probe(struct spi_device *spi)
 {
-	const struct spi_device_id *id = spi_get_device_id(spi);
-	const void *match_data;
 	struct arizona *arizona;
 	const struct regmap_config *regmap_config = NULL;
 	unsigned long type = 0;
 	int ret;
 
-	match_data = device_get_match_data(&spi->dev);
-	if (match_data)
-		type = (unsigned long)match_data;
-	else if (id)
-		type = id->driver_data;
-
+	type = (unsigned long)spi_get_device_match_data(spi);
 	switch (type) {
 	case WM5102:
 		if (IS_ENABLED(CONFIG_MFD_WM5102))
-- 
2.43.0


