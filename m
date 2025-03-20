Return-Path: <linux-kernel+bounces-569881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C26A6A8B3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2CA7175AA9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7153F1E5739;
	Thu, 20 Mar 2025 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FWfbET7u"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6311E32C3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481317; cv=none; b=TAGzt0/1GFC3FFiTSoj4cMTsaG2ypaAumWhV9jGHjfxH3Ymg2Ksp8Y/yG3FcNKMkxIyxxaU/3IsFbr9NJjmcHgzLv0vV1wrhaKeuSTQ46OYSPwx/GJ1HCcUWKpshKjtnyCoTksh0ECL+ECuCMK3ChJEah30z/RMjgJ4ZffNr81U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481317; c=relaxed/simple;
	bh=DI58Pw9T9LNZxJRwp+ghPB/m1N9hsBceza04B2Cm5Lw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dsqM0KuHYWGJIxu4OYW3+IqSvV/ZXWLV4mGrbmxPu+khLiWjRFO9zKHticO56+VKVmPH2QVhYD3fsw4Bn1CBGJ456PVuKbTYUwm8gHXRAfxWQZppMhvuPanLsc3qSJSrtL3qKEuUttGxmsQWvmosZTj61o5mouzRTpC/hhMwg+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FWfbET7u; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so7083455e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742481314; x=1743086114; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JDldgEKP21N20uoAtepE5Q3RPhmylKc6wagJ8mfYRwY=;
        b=FWfbET7uo52+TiJbZEB9i6UNiS4VCwEPoe/30lgS/OAdqzfHG+nqLWVQK/82xY65yL
         RCLwfyzvEMWa+kDFCioLQq2I4/ke3lYPSAWjEgXXovaAJ2XYkpncJ8gvW0odyb2DOxUE
         DbDU3Qx0T/is4RZrunUqK/vEflbTvuCY4PzSS/wMooL7rQ02SZEL8VBNfK83hf+U0Uy3
         wOU4mDov8PY1QorSrfWCB8du4LdJqH2L3lZGp+Qs8JIrbi81d897gXfff6XGIYyBKb60
         XxxNYySzyQaoCbKe7MvGn0dK4iT7uvkrhFfaA5/XCjZbySUD4lX/+kwal97cPd3S2APO
         BW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742481314; x=1743086114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDldgEKP21N20uoAtepE5Q3RPhmylKc6wagJ8mfYRwY=;
        b=awBG7SaAb53ZOLjtDYJq/l1L34Efk5OCbqbqEIDijGUfNp/w43AU+Ls3ZywKt2AgZe
         XFjLamlLGvmCvNkpZpzjfilvqruke3EPwKPiorZJIk8GilUb9a/wIqcD+eVxz0LawMi/
         pb1Iden2SqN6A9IsO7dtEBmQRLT5jnlcuAeUNEV9YoGlmlZPocm4SUbJAXPQfKpJwmfK
         t1ClyFqN9pv26F7xbK8T172ds7tFYb7E3/8vVgZzVG9IAw7hQarRZPOCALeL4dQdhAXA
         7e8EabjdzEchtOyR+iWY3Y5Zc6p/OkcJCnT3X0pjW2Fa8GFpiZy7AgLgdyCaQ+RMIJqb
         7/Mg==
X-Forwarded-Encrypted: i=1; AJvYcCWtl2LWt74Z1FDjVGTRPwo8wpYtZ3lO0/HzPbaaDOrTuPhpe66Rpx4wPwqCGtAuOCQB/tJ4CX+NXD7ywzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTc1Dtz8uRHYtMPyE95eSAnx4M5Qkq0gQAx2Mdz5ZBbdOcof/x
	HmF03ftvSGFj8pOh2Gu4jpnX5mgocRiLY8iBP5/Zveax2KU6o9eLB7Ttr6jwDyU=
X-Gm-Gg: ASbGncvQLe9YIwDcdb7s8x0BOCUIamjA+3IrUbOesZ4RyJJ1S7Ee1ilud1LUTWow086
	LyOMtMvp/HsjxhmTYH9QB8jusvrZOlit/aeAS7lrVKbQWAkefAC5kp0zn+zZJs1a8mwRD4vname
	7cE8djVtKa1btsX1wiTKk+HO6jAnhF4v2AB8Cv5t3c53jHFzWeKqEDQZLXMoRumTpSOHVzDaPSh
	poH9Ow3pLELSXjnjHXVn0JXv90YYabhA7eBYjj+6JWudZW9sTkiIBiIjrLiVP+bujyUIeSQ8VFY
	o/FurreLEijZ8dVI0qcleNkT9ZhXHPNQl1mxRi7TMcJ2z58=
X-Google-Smtp-Source: AGHT+IFP4ya3uVnn9lss7Z9uy/QUwk8dHMMYU3s0EZOI0v9F/UhLzEo0uzWD2sePXj7PQ3GAwNSmkA==
X-Received: by 2002:a05:600c:1da1:b0:43c:fe15:41d4 with SMTP id 5b1f17b1804b1-43d437c3379mr75983075e9.18.1742481313810;
        Thu, 20 Mar 2025 07:35:13 -0700 (PDT)
Received: from pop-os.lan ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6a27sm24238187f8f.31.2025.03.20.07.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:35:13 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 20 Mar 2025 14:34:14 +0000
Subject: [PATCH v3 5/7] coresight: Clear self hosted claim tag on probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-james-coresight-claim-tags-v3-5-d3145c153820@linaro.org>
References: <20250320-james-coresight-claim-tags-v3-0-d3145c153820@linaro.org>
In-Reply-To: <20250320-james-coresight-claim-tags-v3-0-d3145c153820@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Suzuki.Poulose@arm.com, 
 leo.yan@arm.com
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
X-Mailer: b4 0.14.0

This can be left behind from a crashed kernel after a kexec so clear it
when probing each device. Clearing the self hosted bit even when claimed
externally is harmless, so do it unconditionally.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-catu.c       | 1 +
 drivers/hwtracing/coresight/coresight-cti-core.c   | 2 ++
 drivers/hwtracing/coresight/coresight-etb10.c      | 2 ++
 drivers/hwtracing/coresight/coresight-etm3x-core.c | 1 +
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 2 ++
 drivers/hwtracing/coresight/coresight-funnel.c     | 1 +
 drivers/hwtracing/coresight/coresight-replicator.c | 1 +
 drivers/hwtracing/coresight/coresight-tmc-core.c   | 1 +
 8 files changed, 11 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index fa170c966bc3..deaacfd875af 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -558,6 +558,7 @@ static int __catu_probe(struct device *dev, struct resource *res)
 	catu_desc.subtype.helper_subtype = CORESIGHT_DEV_SUBTYPE_HELPER_CATU;
 	catu_desc.ops = &catu_ops;
 
+	coresight_clear_self_claim_tag(&catu_desc.access);
 	drvdata->csdev = coresight_register(&catu_desc);
 	if (IS_ERR(drvdata->csdev))
 		ret = PTR_ERR(drvdata->csdev);
diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
index 80f6265e3740..8fb30dd73fd2 100644
--- a/drivers/hwtracing/coresight/coresight-cti-core.c
+++ b/drivers/hwtracing/coresight/coresight-cti-core.c
@@ -931,6 +931,8 @@ static int cti_probe(struct amba_device *adev, const struct amba_id *id)
 	cti_desc.ops = &cti_ops;
 	cti_desc.groups = drvdata->ctidev.con_groups;
 	cti_desc.dev = dev;
+
+	coresight_clear_self_claim_tag(&cti_desc.access);
 	drvdata->csdev = coresight_register(&cti_desc);
 	if (IS_ERR(drvdata->csdev)) {
 		ret = PTR_ERR(drvdata->csdev);
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 7948597d483d..2bfcb669aa84 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -772,6 +772,8 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.pdata = pdata;
 	desc.dev = dev;
 	desc.groups = coresight_etb_groups;
+
+	coresight_clear_self_claim_tag(&desc.access);
 	drvdata->csdev = coresight_register(&desc);
 	if (IS_ERR(drvdata->csdev))
 		return PTR_ERR(drvdata->csdev);
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index cfd463ac715c..1c6204e14422 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -764,6 +764,7 @@ static void etm_init_arch_data(void *info)
 	drvdata->nr_ext_out = BMVAL(etmccr, 20, 22);
 	drvdata->nr_ctxid_cmp = BMVAL(etmccr, 24, 25);
 
+	coresight_clear_self_claim_tag_unlocked(&drvdata->csa);
 	etm_set_pwrdwn(drvdata);
 	etm_clr_pwrup(drvdata);
 	CS_LOCK(drvdata->csa.base);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index e5972f16abff..52c9aa56e8b9 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1372,6 +1372,8 @@ static void etm4_init_arch_data(void *info)
 	drvdata->nrseqstate = FIELD_GET(TRCIDR5_NUMSEQSTATE_MASK, etmidr5);
 	/* NUMCNTR, bits[30:28] number of counters available for tracing */
 	drvdata->nr_cntr = FIELD_GET(TRCIDR5_NUMCNTR_MASK, etmidr5);
+
+	coresight_clear_self_claim_tag_unlocked(csa);
 	etm4_cs_lock(drvdata, csa);
 	cpu_detect_trace_filtering(drvdata);
 }
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 0541712b2bcb..7249cc356ccb 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -255,6 +255,7 @@ static int funnel_probe(struct device *dev, struct resource *res)
 		drvdata->base = base;
 		desc.groups = coresight_funnel_groups;
 		desc.access = CSDEV_ACCESS_IOMEM(base);
+		coresight_clear_self_claim_tag(&desc.access);
 	}
 
 	dev_set_drvdata(dev, drvdata);
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index ee7ee79f6cf7..b2acd4535c74 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -284,6 +284,7 @@ static int replicator_probe(struct device *dev, struct resource *res)
 	desc.pdata = dev->platform_data;
 	desc.dev = dev;
 
+	coresight_clear_self_claim_tag(&desc.access);
 	drvdata->csdev = coresight_register(&desc);
 	if (IS_ERR(drvdata->csdev)) {
 		ret = PTR_ERR(drvdata->csdev);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index a7814e8e657b..a09579eff3fd 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -869,6 +869,7 @@ static int __tmc_probe(struct device *dev, struct resource *res)
 	dev->platform_data = pdata;
 	desc.pdata = pdata;
 
+	coresight_clear_self_claim_tag(&desc.access);
 	drvdata->csdev = coresight_register(&desc);
 	if (IS_ERR(drvdata->csdev)) {
 		ret = PTR_ERR(drvdata->csdev);

-- 
2.34.1


