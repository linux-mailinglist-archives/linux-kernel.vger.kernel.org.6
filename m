Return-Path: <linux-kernel+bounces-239043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF1B92555D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B635B1F2353D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE2C13A402;
	Wed,  3 Jul 2024 08:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QDKXnheg"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2642629C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 08:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719995446; cv=none; b=OCNF5kOtl7ELoN8rScqHG3LYWm4AkJ3Rm4XGqYC/CKYAPgHWFxBHInZZvotX2ftA4oJV/UvPgi/x7y24ACwq2RYGyOmaTctfhX3OSEQcCmLj32EDZ9GH7XxIqQceys7Kk3fjCFtXb6NLSMTqYtuZLgMfPYURLJav1eDCBIOU3AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719995446; c=relaxed/simple;
	bh=kpSp09z9l65LGLeoiNxvNF9tKw48UToBsdik82/pzXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NOzotxg9M2wQiz6zrEL7jCDH2dqMPd63o8sfHz8+0HzGTtBeFu/7dsikGAYdKF+XtXQkqurRuemYmJGO9XvGxjPAIxf93Y3dB8HQETpLjic0xXIPbW7BY3moMlnfCzaXBe0Gl1tDsH30Xdzd4VNg8t2jAnxdsCFoK4fcaPjMkYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QDKXnheg; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-356c4e926a3so2971483f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 01:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719995442; x=1720600242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TDi8IaRkk+Cjp4SeIDuRWKdtZkOON6mpqHjWnbp/CVs=;
        b=QDKXnhegixBB0rRq5jMQ+O+9wOHPypYDiv2WXlORUmpQOHwuwv1KSyZelUA8VCR76c
         viwHFjtBBBs59yRX0sfssZtLsOkFTNGH1d/xH4GAxVhJ3yAOyyZhw4323wPEewS+Jm7B
         F2j1dry0tBb0YmmYkiQhKfr/ubW2MwQqPXrcJqZC44m4QpJXVvsNb2dd5sKn11u3V3RR
         teyCAvfBuHwa5LBhFbsjEwQWjhHK1hZ3MblOboE0EbbhbBzNKYHCBe2qO477OvDwN2m4
         M0xZdRpwCH1mIxs4MDheKbut+Wg+zAny3l1V4uelXrlBSuXB2gKoDZm4fOSqLe+9XFT4
         Eydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719995442; x=1720600242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TDi8IaRkk+Cjp4SeIDuRWKdtZkOON6mpqHjWnbp/CVs=;
        b=PhVXA8RH+B/S0sHefiYT63LV/UAE3nZJDgtCOVRJcmnLNSJD3IkJypUFvY2vL5LKR3
         UnWlNMuDJwmuaprcAuPDXIa9BN4/5fiw9Z/eiPIhCRVD9LWroj15Oz4FmemkWSSz2A1U
         bdIh3oqG9T8Xd9mXoQanYw0nAI/9B8j7EA8v/oHmtKXSqs8yOhMximM4d2At9MLYY8jP
         k5S7jEVLMNYzC9UijiJDXaFj/JpyldmO1Ey0v3E/SUhd7XvSx32XzvL44CyXIyDpvVYw
         bJVBi2qK/FjQJAYsdFzLuPYwD2/tDI4V7n0jfnphIy/75p/6Lh2057HZ+J89m0m5ByPa
         2bjg==
X-Forwarded-Encrypted: i=1; AJvYcCVwxKmooiX7lhHGrIon9U1OT2TFIbBVVpCf32uIsQiNwFqfZ9N1M5vSzVzsI1UZpn2JQ8ZE8TFo74qiY4qd81BWXvTof80AQM5pIv3E
X-Gm-Message-State: AOJu0YzjDXgGyKZMUohJ0k6ZKQcG3M3PJ0gr2dwEa7HMdJtZRGIyaeEF
	OsCtXxG00M87kfTH2qtCYgMKvojLVR48p2rUYUhfiYxoiY9SR8dwTdhGi1ATuV0=
X-Google-Smtp-Source: AGHT+IFmuVW/1p7lFLWxtwEKJATmACtFZc9wUEgKR4WTWUJsCZsXt2d8FtH8L/lbl9nCjbyd+7L/Jw==
X-Received: by 2002:a5d:6c66:0:b0:366:e991:b9ac with SMTP id ffacd0b85a97d-367756a3423mr6929835f8f.14.1719995442214;
        Wed, 03 Jul 2024 01:30:42 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d8daasm15127345f8f.30.2024.07.03.01.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 01:30:41 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] power: sequencing: simplify returning pointer without cleanup
Date: Wed,  3 Jul 2024 10:30:38 +0200
Message-ID: <20240703083038.95777-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use 'return_ptr' helper for returning a pointer without cleanup for
shorter code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/power/sequencing/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 9e606c9f6f04..9c32b07a55e7 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -687,7 +687,7 @@ struct pwrseq_desc *pwrseq_get(struct device *dev, const char *target)
 		/* No device matched. */
 		return ERR_PTR(-EPROBE_DEFER);
 
-	return no_free_ptr(desc);
+	return_ptr(desc);
 }
 EXPORT_SYMBOL_GPL(pwrseq_get);
 
-- 
2.43.0


