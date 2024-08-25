Return-Path: <linux-kernel+bounces-300441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD85195E3B7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 15:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45274282CE3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 13:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3B9155C9B;
	Sun, 25 Aug 2024 13:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MCqDzkgF"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A9329CEF
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 13:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724593811; cv=none; b=BvmtrsbyxZp5sZpZ1XpXwnbow60A087JnV5pqx19jqim17ed3WbnCuFqvsTVxRnP0gzWZH967vMhpWBHX3JD9XvrzTfeb75oii3azIJHektzDlIS6IbDHv5i2sLkARHTRoX8Im3k2C25OP72PnD4yIxnJKx254m2b2BpzT29clg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724593811; c=relaxed/simple;
	bh=4uh3rJXCUZL0N3DgAeYYc0MeMO09QwEYofrL3WFBWoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTdY/lAbeWpr57hQMG7O6zfo9mlodSL+LuORhP68tkpNFhP5nbw56qCWp4t0m0YyepjwqIIVNkb3Os40IuVEDvMIPbVh40jzpNhANqOphKbThUY2HW3In9bp/JMGZ7BTsU7FWZ9bzULQjz2U/Li19Gu1OvJXk7oQ8skQ++aSsP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MCqDzkgF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42802ddfaa6so3919695e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 06:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724593807; x=1725198607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVr+4PPQohBq2Hhdcp2P4lz8bIedV9DtOFUZkPdBmHE=;
        b=MCqDzkgF5Qkcn1R1wMcATJUZT9v8rLnwwjrPEOEuz/sZXbTnu0CeBbSWOKizIe9FU6
         bDgaHGZqB1iwhQzgNpnc8hUzvpWsxxBgX0RE8PFnJzKlhlKgfnd+3EsycgJggVaUkgKn
         1d/jO7g8btAN95ys5m+dyCD7cnqrbEEKB+L0ZsJBBvuuTvgxu6S2P7ZyWTWuu9NBKoPk
         0Ybt8RRq7apt3pvGFSkswoqQi0sucAoOUUrhL4L995ZD1y94XnRbgtgPEoNDx9TK9EYd
         PNLz+lMwPsUHQdDpR3FHoWVHaD5ejXxWgK1XljSC0R8Y1St4ixRlbPlGLwCI2k927u2G
         J3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724593807; x=1725198607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVr+4PPQohBq2Hhdcp2P4lz8bIedV9DtOFUZkPdBmHE=;
        b=O2zGVsZ+bDlRIOyVhjLyQDjY8zuOFRhy/KUpSqIXmIUoI8r18U+QDKv52nn+HlWVyz
         yaYyRSz3ucfM9rhlzx7jI0SQRTCtM1Z4EohYFyUnGzSynfPOPRoWv2jsX3nyEn1Xir/f
         weQR1HLw9Ry46aWhPtpJNgoSGJf606KbvTUntikkGUdtPARiM0bMfqHJ6cmy8dilvmv2
         uEjfbMVxUBgLUOUZvAQ01wJTlUPXKZSG4Vc0q3QNpARQlsYFfEx9lPHk5pWkJlFm3y4h
         ky4rg7mQtjG5YwoQpSgqsAfUsPEM5u7IJ68dp+30dSNmBUAP00LYVsFybU57gzwrUwKC
         IqLg==
X-Forwarded-Encrypted: i=1; AJvYcCUZaWCY/gjoW9ZzMeBPUk4JSkt60CgFGxpJDG3eZJI7dwJvaLq7sB4NAVtaS274KytJTg7KXVe2qUt4R5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWeZVbGz5b6ieDofjT7+MLlpqCiDojKfJ8uTxfUbkKkKgOC2Cw
	ZchRTivo1zmHPTQXvqF70pTcwC8ri3NwuuIc8/cKypq4XfvdMmJcISF/YbpmQ/3yq433lQyctP1
	/
X-Google-Smtp-Source: AGHT+IF1JPg8c/K+unhOGNVfEAMIz5SMqT+TqLYrkg4HV3S7iZetXZI5aLVbvkuvFOtR1wwGEAxw3w==
X-Received: by 2002:a05:600c:198c:b0:425:73b8:cc5d with SMTP id 5b1f17b1804b1-42acc8da99dmr32783395e9.1.1724593806925;
        Sun, 25 Aug 2024 06:50:06 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac514e1f7sm122188365e9.5.2024.08.25.06.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 06:50:06 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Vladimir Zapolskiy <vz@mleia.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH 2/2] memory: pl353-smc: simplify with scoped for each OF child loop
Date: Sun, 25 Aug 2024 15:50:01 +0200
Message-ID: <20240825135001.48963-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240825135001.48963-1-krzysztof.kozlowski@linaro.org>
References: <20240825135001.48963-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use scoped for_each_available_child_of_node_scoped() when iterating over
device nodes to make code a bit simpler.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/pl353-smc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/memory/pl353-smc.c b/drivers/memory/pl353-smc.c
index 994c7a792e34..28a8cc56003c 100644
--- a/drivers/memory/pl353-smc.c
+++ b/drivers/memory/pl353-smc.c
@@ -74,7 +74,6 @@ static int pl353_smc_probe(struct amba_device *adev, const struct amba_id *id)
 	struct device_node *of_node = adev->dev.of_node;
 	const struct of_device_id *match = NULL;
 	struct pl353_smc_data *pl353_smc;
-	struct device_node *child;
 
 	pl353_smc = devm_kzalloc(&adev->dev, sizeof(*pl353_smc), GFP_KERNEL);
 	if (!pl353_smc)
@@ -93,12 +92,13 @@ static int pl353_smc_probe(struct amba_device *adev, const struct amba_id *id)
 	amba_set_drvdata(adev, pl353_smc);
 
 	/* Find compatible children. Only a single child is supported */
-	for_each_available_child_of_node(of_node, child) {
+	for_each_available_child_of_node_scoped(of_node, child) {
 		match = of_match_node(pl353_smc_supported_children, child);
 		if (!match) {
 			dev_warn(&adev->dev, "unsupported child node\n");
 			continue;
 		}
+		of_platform_device_create(child, NULL, &adev->dev);
 		break;
 	}
 	if (!match) {
@@ -106,9 +106,6 @@ static int pl353_smc_probe(struct amba_device *adev, const struct amba_id *id)
 		return -ENODEV;
 	}
 
-	of_platform_device_create(child, NULL, &adev->dev);
-	of_node_put(child);
-
 	return 0;
 }
 
-- 
2.43.0


