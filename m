Return-Path: <linux-kernel+bounces-561806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E840A6167B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5926A3B0909
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5217A2040A6;
	Fri, 14 Mar 2025 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NJ5jXlQZ"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E472036ED
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741970407; cv=none; b=lGlTvzLlVxvC3YnowgteS2OD44ys8ut4u23AUXaPSukA+6yInNi1VYkbQwVkA3O5SMruFb8Mi04H/5T79HQhezNV/z/2QlqTNhU079YOUfZNSzAtSpCHoLEl5IGPp4MYftXGaCW8PfHCUGm6zNF+RS9Lj9SPqt5+wLbom7mus3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741970407; c=relaxed/simple;
	bh=EMglvuwJCM4I+POaB0pzqrwXSchddeRXR/kp58h7CKE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WA4F5Z9gWSAkmRGLniqI2qD9RPa03DOfEf/qA4J/QFGOnNtlaSIIks2pW2F4CNs90pp1vllA4c03bQdZcz13tg0igV0Zm3A2R+iNrQlcR5193kDqh3UvfE98t3PRx2i3mVRr1m8BiBlk2FUGhgqPGrosD20RKcC/A5GdLPZHVoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NJ5jXlQZ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e5e63162a0so3346712a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741970404; x=1742575204; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5EHw6xE0g+7qki2CSo1YJpVOxoekKA/7CSCBUCVC664=;
        b=NJ5jXlQZ/hwOScFX95HnPdPZdRXXVjjSgVkMwG7ssFH1eqkLQIRUbgc0nMuS87m1oS
         g3Cn4lBDh2LPa7M1joLd+XqeCyi9QalVuRvyg0l58HoDf4mdZM4uoqc2iyAWaxyDlQ8F
         dvaKx1yAYkI+l5RfCToIcZPH+PrqXT5JGxYyVOivCrts7R/bHe7PT95ddKaN2YuuyeBC
         tLU+yP+1Mbb2x1E2W4G3i23n5j8Sk8+vGjF7GtQ4owmeEX9VUHnmnOuoNe5yH9OvO4rI
         J4ZGpHxj6oXg0M3oMhorFGLDbLHMUABpDllL3fCFdsDT7rXvk1pOIOTIy88iD8ddGL55
         Te8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741970404; x=1742575204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5EHw6xE0g+7qki2CSo1YJpVOxoekKA/7CSCBUCVC664=;
        b=t6IQ805kO3ie015Nbwpyu+4JYpX/iHB4mc2oRSDxGv4JTmAV0+i9zISkWL3jwEfz3z
         N+8mzU0JcltKrxuPbrxcvCH0f/Jv2j4qAlCvMHbvm/mqhmsOFSMjRCV8C6h50uASg344
         v7KaZdyRE0urk6Y3nkzY4Iv135cnuAEGJSKuBTPdxMTjkTTVxq8j5iaThldGxz6Oy6Q6
         s5GKVLboUCBx0A8SuXf5VsmwBojwGDtHuEJHFTmcfflVAkUbLldHkwJUwvjFcVpEA1hL
         SlcMvhu5TwmEn7Os9I9vXAVC0Xq6TtNOxkRAEJCGSl1luHR7WKTQPpu0h3iVBeRcRJZz
         O9Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWxmtbvCroQz6z67VlHKvQcUFyqHjlm8mKw/du6Cn3QYFOVdhjHNt3vLXoxU2czEYEdzkvIPb6Fhbx1m14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrv/Wk+uvcMUjzmTMiC/Avj9QWwJAhT4jwdjgTUfz5YNZByEQs
	EU9gDOKqIU7LO6wdkt5tkJkzD2VNLRd3Xt6wLimUwmzaDuyCTjNlzxOm2ELW9Qo=
X-Gm-Gg: ASbGncu/JuR1Gp5Qn5mdFjKmL0WH6RlHgcrxfsSW6zQpuOzqIFC/gVf5cU1h9Oz7WS3
	QNuAN39BeNwll+pfr4xFGN7bBVK6VDWf0amPAK6FDZAw5CQLW7EmTsnk0LjXdekCbSEzwAXkz2l
	WsKcvOgzWT8S2eG4WluRrAqOm4iMsLCVafHYMqM4xzTDTRCiR4qOo+cyhhT7Vxje0aXGgGVdziU
	hWsEFJtwcgPwY8/QPxabkO7b9JX2VDyeWrC6QgkAzHzs+qmmldVqeEEi2eBnt58NbcKQSvx8hxO
	U1TVj1eDQ81Qx/oWjQhHuumApeomNhrwEvo26CB4hwN5uFmHHLX9yjkINlDX6nVgqWUAEcQwv7h
	CXtwWw/kLhcmZJ6fJDGDrleRZrwfZXTpRFp6nRXk=
X-Google-Smtp-Source: AGHT+IFm72MRO+sabSmFs08xZRpk0IIZks2PIM2q02CRV+JCE7zgfN2FDEwb9GyApg/KaKdRxs7krQ==
X-Received: by 2002:a05:6402:3550:b0:5e7:aeb9:d0cc with SMTP id 4fb4d7f45d1cf-5e89e6afc19mr3874499a12.3.1741970403936;
        Fri, 14 Mar 2025 09:40:03 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816968cd8sm2115727a12.18.2025.03.14.09.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 09:40:03 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 14 Mar 2025 16:40:02 +0000
Subject: [PATCH 2/3] firmware: exynos-acpm: silence EPROBE_DEFER error on
 boot
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250314-acpm-fixes-v1-2-ab03ca8e723f@linaro.org>
References: <20250314-acpm-fixes-v1-0-ab03ca8e723f@linaro.org>
In-Reply-To: <20250314-acpm-fixes-v1-0-ab03ca8e723f@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

This driver emits error messages when client drivers are trying to get
an interface handle to this driver here before this driver has
completed _probe().

Given this driver returns -EPROBE_DEFER in that case, this is not an
error and shouldn't be emitted to the log, so just remove them.

Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
issue is in linux-next only afaics at this stage, as driver is not
merged into Linus' tree yet
---
 drivers/firmware/samsung/exynos-acpm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index a85b2dbdd9f0d7b1f327f54a0a283e4f32587a98..48f1e3cacaa709ae703115169df138b659ddae44 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -690,14 +690,11 @@ static const struct acpm_handle *acpm_get_by_phandle(struct device *dev,
 
 	acpm = platform_get_drvdata(pdev);
 	if (!acpm) {
-		dev_err(dev, "Cannot get drvdata from %s\n",
-			dev_name(&pdev->dev));
 		platform_device_put(pdev);
 		return ERR_PTR(-EPROBE_DEFER);
 	}
 
 	if (!try_module_get(pdev->dev.driver->owner)) {
-		dev_err(dev, "Cannot get module reference.\n");
 		platform_device_put(pdev);
 		return ERR_PTR(-EPROBE_DEFER);
 	}

-- 
2.49.0.rc1.451.g8f38331e32-goog


