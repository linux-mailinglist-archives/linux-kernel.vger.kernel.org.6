Return-Path: <linux-kernel+bounces-239144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7367D92571B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5201F26532
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E47613E02A;
	Wed,  3 Jul 2024 09:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ni/OSS/p"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4BF13DDA6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719999781; cv=none; b=okAY22lu0evs/Ro76Hx7xHUZg9rHl9uLRx/3H/Y9XcKVCe2g41Nugga7d1EZJkh9orSc0rhZr07jC+CXgwR71dfMIK0u+/t0efeRTG98GFUhTmmaYFuuDu0x1WKsPFFsu3DnHWv/HrXIPm4XEd0xAbyneOcOm5RzI/36pHOJsP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719999781; c=relaxed/simple;
	bh=69S8VVQH6jBMjq2wWaMDevdT9Jq5+NLiRt2FAcxu+ug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=onUTdMVYgiiUBlkjn8MPi9QaQDiHJR8BV3w/LXrn8XyY0FnIvsvB4WQ6SK2yhIJ0v1J4UuPcq5yoRmK3xu67+q2nCFmn6oM866E46I7eWRr53kMwangX9775N4rKDbf4zLywh5pYWcwhaJGhQup4C4VGqqwocHVKz5/jB7Qscvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ni/OSS/p; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42565cdf99cso45763215e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 02:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719999777; x=1720604577; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DSfOCAVt0bY+fqoFGSVQNvowRrX3jzlSptxCIMvtd6I=;
        b=Ni/OSS/pIl408/IlaGrfgB+Xkc9ojifVTJZBNw7TscPOxGcX5eM7AvajLZLXukWIVF
         Rkh6GBTPWGQdoZ2j1AXIGJHVm1X9tnOOi0gsYOToqRFqHZwFoOweD6mYwMETwTIZugnG
         Ks+C3rthAfqCkaUWYKbf0fZ++rDgPGhszp+QPp9ICAlvT4wCPjVINWJikz5qj+r0TWNA
         18D7686FpSybA5YIdqzpvGZ3gruacZg0w56mabWAV+KlPhUME/EeHYHN6i639UWx3mmK
         tV6WikBosuY6RulmvYiMK2jzOs+mo61QAZKVixbRdbw/MLXD/fx8sN7U72SMx3hYAXzx
         yglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719999777; x=1720604577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSfOCAVt0bY+fqoFGSVQNvowRrX3jzlSptxCIMvtd6I=;
        b=NainveOTtcwSGunDjdRZttFQFt+iF3Ji7N7U1fetEqy8jRNTvLrxKr3bczSWXhxnsv
         PRLmZr5+wiu2Sftfmyq6+oHU0Z8I12fDAZdmdUEBRCIkO6BSrms5ZoQmIwji5gtHtSQm
         7licIwWY0o6czrPqvH8MPke9cXfRJtUvzaQA5LSuUE05PT09jUrwXfX0qwWy8a1NDGJa
         HCS9c6qWFMFjn65YyTWdXTP1n4WeeOBZ/s23+ynIKVuOWogZ18LtlqV0/+MWFetrV4Fh
         V5RPN10GUTJlbKLo89SiVg+7N9iAPG3RCvAJmKyLet3806x7TcsbAuLt5GJK4A/C+CNB
         SaTA==
X-Forwarded-Encrypted: i=1; AJvYcCUPYQ6TlK1PRv6fxcm9X0T2A+spHZ/5H2dRyRJJEub+hf5/Ouqom6KikX6yhMXy/Re91qSIiuFBitGMsQFuvX+QSi40lc8jLDsfRazh
X-Gm-Message-State: AOJu0YztVD9uxfl9ga0RvKhMkwxKVnuekc+FuSu4xkaxSaCGQORRshl1
	OY8fOR5WzOKG2FkVxe+zVmEt+J31yBxouRFuXi5rn0pA8rSmLrwupIJOvx8OlhfsSVK/KSnmYtz
	j6Ys=
X-Google-Smtp-Source: AGHT+IF+Csk0/r4TTYC0yJ0HEwR7LHJUXwkCep8r6woD9QJ4S3iLowEnlT3nsy9pVzJ7OHKg7Bg27A==
X-Received: by 2002:a05:600c:4804:b0:425:7784:56e6 with SMTP id 5b1f17b1804b1-4257a007729mr95529115e9.11.1719999777514;
        Wed, 03 Jul 2024 02:42:57 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a1030dfsm15341394f8f.100.2024.07.03.02.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 02:42:56 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 03 Jul 2024 11:42:37 +0200
Subject: [PATCH 2/5] soc: qcom: mdt_loader: simplify with cleanup.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-thermal-const-v1-2-6e59e139c65d@linaro.org>
References: <20240703-thermal-const-v1-0-6e59e139c65d@linaro.org>
In-Reply-To: <20240703-thermal-const-v1-0-6e59e139c65d@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1546;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=69S8VVQH6jBMjq2wWaMDevdT9Jq5+NLiRt2FAcxu+ug=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmhR0YOOfP8ePx5Tn0Yv/47Shv5rANBKvKuhrRT
 LCg2FEuP6+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZoUdGAAKCRDBN2bmhouD
 16JBD/4sDgUB70ZhGLI3lo6v/ZHoFxM2NToEX4OIZ6RZvxbVksW9CnhoNxbYC1b39qjhRT+p032
 +l2/sp2WItgL0TW9eras+iZs19N1qapDaO5coYLmT21Zs9C5VawZ0tzzc9ASHabtigeHOyBWTre
 yWoZZFVNOTM0hpGB3xcVy/E8tEvFB+exgN1dg0fOsI6kFvW+k3HLGhvRir9Nhbr4bFaJZmoKalk
 NO6bRl0rU2DtOY9LsDkyE2T1eLtpjwPfKvqkhl9fZ/djcmS+2D38SuxYEcLkevC2ZjBVfdJGDsE
 k5KndtwafZD/FUPMnQthg/U7VJpb5Oqiage1Dm06rrBRPZlNVxQxj/X8LRPxlOQ+Z1HH/WKF32+
 LXtkKnP3x8+d8T6uFR0fj6/6nXbP4tjg921xIoFMXowqfzxUmFxJviIAmR60xloY1xYHRjErnXU
 nwDOxOWhBuhl16dT47ALQoLa9jBiiQwGqTutSVjV5N7xOWLt4Xby1wU9Arz0zHiNwpi44MGk5CU
 pklILdRXug0utH4TIyYrm6uyU9sKh5fkavRzsb9PV88H0GnPB8t1nGsfWvMxpoP7k85zyYxg/Lv
 vZYeZJ5IlaTXpQFU48zW8UBbhFul0la4z9SqRHUawIkhcUhfHEA6mr+/2q0SW9Q+otctNGX/7vB
 wkXYy3ULsbS++6w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Allocate the memory with scoped/cleanup.h to reduce error handling and
make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/qcom/mdt_loader.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 6f177e46fa0f..b2c0fb55d4ae 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -7,6 +7,7 @@
  * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/elf.h>
 #include <linux/firmware.h>
@@ -37,13 +38,12 @@ static ssize_t mdt_load_split_segment(void *ptr, const struct elf32_phdr *phdrs,
 {
 	const struct elf32_phdr *phdr = &phdrs[segment];
 	const struct firmware *seg_fw;
-	char *seg_name;
 	ssize_t ret;
 
 	if (strlen(fw_name) < 4)
 		return -EINVAL;
 
-	seg_name = kstrdup(fw_name, GFP_KERNEL);
+	char *seg_name __free(kfree) = kstrdup(fw_name, GFP_KERNEL);
 	if (!seg_name)
 		return -ENOMEM;
 
@@ -52,7 +52,6 @@ static ssize_t mdt_load_split_segment(void *ptr, const struct elf32_phdr *phdrs,
 					ptr, phdr->p_filesz);
 	if (ret) {
 		dev_err(dev, "error %zd loading %s\n", ret, seg_name);
-		kfree(seg_name);
 		return ret;
 	}
 
@@ -64,7 +63,6 @@ static ssize_t mdt_load_split_segment(void *ptr, const struct elf32_phdr *phdrs,
 	}
 
 	release_firmware(seg_fw);
-	kfree(seg_name);
 
 	return ret;
 }

-- 
2.43.0


