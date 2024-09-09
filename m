Return-Path: <linux-kernel+bounces-321528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1C9971BB9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9EE41F242E9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3801BB68C;
	Mon,  9 Sep 2024 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ir+6nr/c"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196B61BAECE
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889909; cv=none; b=V5F0EFHGlLtDSsC2TF61TfnjLy4di9L404ICdFEAL8O6YFWjQdK6Itowitf8BA6ApW6aZQFjH8qxUXeqYryUqzUVty0V1FBUVR9QYXb1D5qlFTDkP1Su9/lqJ42IhddOHPRp/a+muOnjpabzKw69XLNj0Ew67fi7ioaQDnG08Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889909; c=relaxed/simple;
	bh=qvFB37UNy0FXUjxrG9GIJ3EDRLNkuyXGb5mp950Q39M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ajPysBUDk5vSNiOgmEuxvOSPm84eSwJ1qCLDqRwpHlmnkilG2I5A/MDTm3Eb+hyGnfFDSxO291UxzlEECPyZARkcBDRMoCfzrtwlh7U9uJ2Gs9KxWMnB0ap8l5sBW+pL6ZzHmlxAbS9wSwOmAxHE3NikMaiUVt/+9M76xhHFrUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ir+6nr/c; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8a765f980dso26497966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 06:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725889906; x=1726494706; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ebiwwBtqKdnptnl4wd8GBFDK3ZgfnRMWFyATVPqygk8=;
        b=ir+6nr/cTmo6hs2l+weMJp6VJ6+580jC3Lv1yeiNO26oT1SCjw4uyejTROc4QcuQKJ
         WuFJisoG5lRtmurf/eId1/oazcPvOTgFuZu8mEY7iKHq9k2tj3SwpqME54ca3pMXb0bQ
         SF1Z6ZUSK6VCj/cyOBo0xcO+h1kGQAJtQiaWCxdhc9PKUplWAQCYX08bxFYegq5jotys
         ZKwKAUVI1CH0q0Yw4j9HIC6SEX018NHIotm5qkzrMjZJP6DTTedPrHYIBV1prTMOK8pL
         VHLaADp5/BM4+fInEcLoEGMOgrh0Rwt/MSQkCayjWpHDzxCiVbemX30DkpunrHmPOnV7
         2oGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725889906; x=1726494706;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebiwwBtqKdnptnl4wd8GBFDK3ZgfnRMWFyATVPqygk8=;
        b=QtPiD0nroEcH2bs4hlix8OyE/12tZBHmEhcsawMG0M3FHA5RW5ZyxzoPrLlIhcNWqx
         BFXBFDd7Dr4d+ADT63WKXB/QysYGNH1FArrgjcuyxF+qStpGVFODOmDozSD72aDj4bME
         +lpDcCamW7VLgpl4wqVpVBPeKIMOVkSmGfde/oS+n9Zifpm8+HVKYLFHeYZujRQnCZcI
         7VcX8wC6dWYpfqLFLLnZh7pNpuU7eFsfmtm+0AhtcWb1S9FvRMxFGD7vQeV+NkhcS+QK
         hV0YC/67DwJBe3TE0nNrrSycxgX/GXqckNmgLyAVdyxd9keDrnToKBwut8Mf7sX1Ps9y
         QGOQ==
X-Gm-Message-State: AOJu0YxsAxQDsXCVWinbTFf4aavFP87iLbjxCPOx7lNSDd/oatQs5Ww/
	7GP+VsNo+W5uK4PVl8JYsOisHeWAxTWb3IqcOm1edMucpNuntXFxUx1RW6MGD1M=
X-Google-Smtp-Source: AGHT+IHitMS1cWRj6WUaeP05stoqvUkgN1+30cQ8Qjo2wMMatVr+SQ+ogFBaSLtp79Pcj8lputkU3w==
X-Received: by 2002:a17:907:3da7:b0:a8a:81ec:f731 with SMTP id a640c23a62f3a-a8a885c3265mr378363266b.2.1725889905496;
        Mon, 09 Sep 2024 06:51:45 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25cf3ad6sm345344566b.148.2024.09.09.06.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:51:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 09 Sep 2024 15:51:16 +0200
Subject: [PATCH 05/17] regulator: da9211: Constify static data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-regulator-const-v1-5-8934704a5787@linaro.org>
References: <20240909-regulator-const-v1-0-8934704a5787@linaro.org>
In-Reply-To: <20240909-regulator-const-v1-0-8934704a5787@linaro.org>
To: Support Opensource <support.opensource@diasemi.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=819;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=qvFB37UNy0FXUjxrG9GIJ3EDRLNkuyXGb5mp950Q39M=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBm3v1cXH5mO890K3vAeJUuv0AtSmRWejCS85Vei
 fX3f8LzbhCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZt79XAAKCRDBN2bmhouD
 11ChD/4yh9ctCFV0lMqYOZv20i4KdgYa2NLHUN4pjlhvUeE7bNRx3gvPpT3oVHy6TYPDGYd5xo3
 qjMOhlaWM98n4j3kvYr2n4bj+STEKZbYNUGMiSvU/lGDNdaGlcMDA41KdZS2+dtZPIXiYXTXoy4
 /XrGKA5vm9X/3c1vlsz1D4SnBOFXPARuDCy0e0zAa21CsIe3ymWRvgkWPPJSDNewvsrYGT/+n8p
 luKgHx2DD/MLwnhTHKNCVJ4ZoGW/Ze2TO4/2MVkHu8KoXY0Oza+VL2cjhcDxfrQJiuegsVR7pjE
 pYOLDyEJ/13cTDHX4CEjygyGVrVPolQOJuG0LDOd75YSZMTpsNLxb7A5o+/pkKzT6+23qHWSOsF
 F9ELpIwY6vQyXC8KxYXtgaePWfY9pJIWkXfYEX7+OM9U2yu0Tf/DYoYCpd8RLqyI0YChNH73f/Y
 7GM5HG1jaUjTcqDnKB1AK14fBS9qyMZOSiAtykpZEWGBAuV5jhBKo7APsx0Qf3XkXQWgRx07qyy
 +xlJz1udRGESQ79PA8s7uWN6tyGr+pVk/qfIhnSQYt4c3K4hcFFBXoiHwbNVRvaVU65qpe8uL64
 nwtioO7ua6RiqxYui6Yc/8tCc9hGvBoC+DgR8RYhkAsvp5qYbsP0GYjBvYtKMeNqtXkGMc3hUe1
 MI4gi9DFb78nIkw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Driver does not modify static data with regulator description (struct
regulator_desc), so make it const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/regulator/da9211-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/da9211-regulator.c b/drivers/regulator/da9211-regulator.c
index d8b39ea3de0e..d4f14d7ea8cf 100644
--- a/drivers/regulator/da9211-regulator.c
+++ b/drivers/regulator/da9211-regulator.c
@@ -264,7 +264,7 @@ static const struct regulator_ops da9211_buck_ops = {
 	.of_map_mode = da9211_map_buck_mode,\
 }
 
-static struct regulator_desc da9211_regulators[] = {
+static const struct regulator_desc da9211_regulators[] = {
 	DA9211_BUCK(BUCKA),
 	DA9211_BUCK(BUCKB),
 };

-- 
2.43.0


