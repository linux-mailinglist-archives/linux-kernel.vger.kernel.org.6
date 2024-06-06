Return-Path: <linux-kernel+bounces-204485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7251C8FEFB2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796B51C22CAB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52021974FB;
	Thu,  6 Jun 2024 14:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IqIQay0Q"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4B5196C85
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684615; cv=none; b=Fk0VtjG8HFQcM04caLi057WQZOJff4BKkXTQgaO2SA141kcH76cUDMZtYpAJBKncD149bjTZSYLlA8NKA+jNnKvjU95Ipxeg/XuWyin75CSc0I8dqTPA4E4rEapAMtKRrdvGNDokyvqgGUK3Korq+BgrGtFMxKHFNJMG0PHRNjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684615; c=relaxed/simple;
	bh=HYbaZvNxTbJKa5f2sNO1p1OoBPjJdhGaLI/bsnkYCJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AYH3Ar4ISMbeq3P0hZOOxX6wTpt8+tdqXE86LkBIAwLeVl7Ty7OJD89QeQskDkSQ//aqzgmTKkEEC/C1Ft2zGQXJyiCrrriULdNKEXjQA2woantVaUocfScM2xcfQfaS+FufnbXvO3iJSjLmkxLztiI71oOsS/cU4kjDtFdbzEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IqIQay0Q; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4213b94b8b5so11123485e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 07:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717684612; x=1718289412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BEGX/YRM4abY7OJ5gwhaYjtg7TEA+2R15UHkn44kNAM=;
        b=IqIQay0Q5P7XYVATbQn48HyzwiLUxI9p95BsPhPjHMLptI7Yw1BbAEYl1Gj9yPhR4w
         oYD/hk42u5R/TTZV4PvsnFUAx1rG/iO+fYDVoopToydKPv+Qnl94VnmG55zpKckNMZh6
         GdzBi2byTKkSHkPbh8kJYE+JZLU2kuD8OMv+JCTA1+umBKa42Y6S8/dOgNdQFevJAdIi
         p98zcrwoHRd1EODe9mIKy83b5P1ULS97+3cQh8fFgkcNDSgtcGN6MmJqCQorrh5nQHJm
         p/5HpG/F4zdtdKf/+fCBoCmiA1wNBwo4qOtjZLszFZ9LGrAtBYMVJXHcdFwDk6K8zogt
         6v2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684612; x=1718289412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BEGX/YRM4abY7OJ5gwhaYjtg7TEA+2R15UHkn44kNAM=;
        b=TYlznuVRlvVGMrHoNyQ0KucpJv5RgUr+ztzGUrZkzh9j8RpK5lGxb8Qr59ix+cK3oK
         1ybFOjjusZ8rKLT6q1+DLnuMesNpcV7hjTtv7azlMa9CMT1L4f3eNjtPmAUClEoASf3C
         Gk1RyNxRaSLRBZ53C/HXj6Ht6SLjdyBG8jBDNmUOnJVwWFKmuhNLUSaSozGKnjK6DRgY
         e38VROVDQjbHoodhis894ifSzpO0SQMuhl0FqWq5MAYUHzN7VhAkSeX2Hn+9MNPoYYkE
         8oXMarzoO5GO7e/mDYNdeyaAtMpwhgTgKRI6apHEwKW8L+V3xaBqKFUDFkcGvMfLZ8zq
         0yJw==
X-Forwarded-Encrypted: i=1; AJvYcCVjTWkXfAtz8rfdum2l+zh+ley5S4i8dtub8IobfxXjgTIQDdFgxhHQpLCb1XnSoLzFP5lKxzXa+9ceeDBC4aYNRvc1CzerGKk6b3y7
X-Gm-Message-State: AOJu0YwSVOn2HQX9gvVz4u15ZqLfMJJxAK5WnNqtht21idQXi0/5NFft
	zSUAjw4205zSjE+5quNtwFR0waG8NS+qRUu8xDwx4X0z6nPdb+XF8kptYe9tSvQ=
X-Google-Smtp-Source: AGHT+IEzOvqTcqQFVTM/zPrDfgG4Ch2gvXbBob36jdrxqP8DV2hXHRxxXD0hBtX3K+evZarwhWDdKQ==
X-Received: by 2002:a05:600c:4714:b0:41f:afa6:3d85 with SMTP id 5b1f17b1804b1-421563504aamr51262215e9.31.1717684611808;
        Thu, 06 Jun 2024 07:36:51 -0700 (PDT)
Received: from krzk-bin.. ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158148ffasm59540865e9.38.2024.06.06.07.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:36:51 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	patches@opensource.cirrus.com,
	llvm@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] mfd: max14577: Fix Wvoid-pointer-to-enum-cast warning (again)
Date: Thu,  6 Jun 2024 16:36:46 +0200
Message-ID: <20240606143648.152668-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'type' is an enum, thus cast of pointer on 64-bit compile test with
clang and W=1 causes:

  max14577.c:400:23: error: cast to smaller integer type 'enum maxim_device_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Year ago this was solved, although LKML discussion suggested warning is
not suitable for kernel.  Nothing changed in this regard for a year, so
assume the warning will stay and we want to have warnings-free builds.

Link: https://lore.kernel.org/all/20230814160457.GA2836@dev-arch.thelio-3990X/
Link: https://lore.kernel.org/all/20230810095849.123321-1-krzysztof.kozlowski@linaro.org/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mfd/max14577.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/max14577.c b/drivers/mfd/max14577.c
index 8f7472c76009..67bf4de4c0c1 100644
--- a/drivers/mfd/max14577.c
+++ b/drivers/mfd/max14577.c
@@ -397,7 +397,7 @@ static int max14577_i2c_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
-	max14577->dev_type = (enum maxim_device_type)i2c_get_match_data(i2c);
+	max14577->dev_type = (kernel_ulong_t)i2c_get_match_data(i2c);
 
 	max14577_print_dev_type(max14577);
 
-- 
2.43.0


