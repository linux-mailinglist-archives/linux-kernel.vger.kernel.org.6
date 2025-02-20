Return-Path: <linux-kernel+bounces-524228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB957A3E0C7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B5437A8BFB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E977213221;
	Thu, 20 Feb 2025 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zE1N0M+m"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FA8212FBF
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068972; cv=none; b=pyUc/dE+RHDbI1VxXAVyH8C8iIvBOaqnJS2PENvvMBFX8V/bBsXLDK41D6lmCJmrpM2TeAYMvR5vsuVkudzcnFgad0Yb2hzHsjM/rA/FQDlC0avEVFFTPv6AV236XYYuFGQoqp6cWakUnWpeoxNPIJLgO3777+F85sCm+KjJ+zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068972; c=relaxed/simple;
	bh=G44mzomd17zjRW176IaSow82CVHdPVhJq52qbX/krTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F38bwPUnr5KczahMsiDwx2AfhRJCeluAEpld0NVbAOfVbZE+aox2WqgkE+kU4hPqMK2EA/mAFSwQ/jT7w7x1EMPbCfb+VwpeIgOWUsukcTXIodWXILAinL6adGQZIhAPmr9KTsvyWqwRWT1Um1PqFDFkatgDTrM6ndlqzq+pprs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zE1N0M+m; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38f504f087eso1050825f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740068969; x=1740673769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7m/CTzgrh0AA9xzhVYZwH6Z/AB9cMb21X+WgCPYE0r0=;
        b=zE1N0M+mcG6yeCVrShQIusxoURBJlTD5R/+EL5iJJCd42rO9aXh8QlISKn09oAZlS8
         cfuZOZ46FL/dKy0jV2g1yq01U1RDQD/zt4t843n0+SdmkNtrT08e0aHKh7zGTPJtXwLX
         L1wJYAhc5cHI+csGZirsREJBWUDOSoGIhB/90u0PnS+w6Lubjz0TZ28u/3YncEB+r1aI
         ay9GT5GmWW5hhn6loUsx9pvBRrEyUzrA943X9GWhdrLgK3N6tGOQSaCT4lYNFY0XvCAR
         OaX98jS8UX0PYG0L/nvQLWfi0bU7lj//ommHFy9MpbMyjLJjCG85ifjpu0Ujr9UAgcEV
         wz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068969; x=1740673769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7m/CTzgrh0AA9xzhVYZwH6Z/AB9cMb21X+WgCPYE0r0=;
        b=Q0NUhKE1/QeEqGwlT6T8W//uGvuCuEIS7TEHNC/uNVrzRgmlkTBHLR8xxufn0NuBtn
         qF+I8JQXQQuPaylr2ajklVNbi6OsB84yueD3UhQ0pmBzQXjpHtWgZDHJfvEiULh6HQeh
         v5ndiZ1lcEIH5p7aRG1MsL2Li5xHJr6gOsETbeYu9IMy3734uL5j3sr0DJoVaIinSzX1
         F4jkdEdC/UnIHyBHnBeL5fNFN+nZ2epAaLwUztgwpizEwn50dZGzkzixaDExdfOtbU0I
         8GbAzNalJLuv8LdPU2Qt9DnMkO6R1XO/CD3lMu/F3sB8xdVcM1iJHtjcjfskfLYKt7Ha
         k2iw==
X-Forwarded-Encrypted: i=1; AJvYcCVuhxZXZ05BWgh3LkHu64RxVshRGSFj4FA4ENw5hK/5ZnHL0oH6jFY/74QTUnQZb4t5GLWdWssIemfoasc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYMNjPw1TOcFN8IlcS0EOmWfz11J6rp4CfyY4f37qkFZAgbWT8
	Zyu9GOAqN4ikakpOqQjeH6D2e10NvOwHTjzGL64PU3NfJFY1SvQ1pqGe7f2m8Pk=
X-Gm-Gg: ASbGncu6I7/sM+i4G4Mxf13vb4xKkvmZM3htKDhHKkBddWyatzZ7rF1cwamKZ63rdH2
	TCyyxF5xmIt9ntiQXbZhgrgbP+gGADUhRwDMkvYrwpnr3G5Lg992x1+9QIF9XzdtazB1d1kTXNW
	Nwt6mCFsTtDgwRzst/MOJ62pFkJROgVHPKKStDpxgh2skxJn+IsVUFcsTmTcMyPaVM06il1kM3m
	yRLJZO0kUA69cEIIisJr2TvHWlXmh5/2pWH/2PImm6pQJSOPQn2yG/xYLUzbEqaFexSBfv46NQx
	nsbrtiNzOaPqQb1qV/cmNbv1gKgcrq8RRWkAvPao
X-Google-Smtp-Source: AGHT+IErNAEoXnEuPGcHDzaI4u+qesPWr2oJ8v0KPpx1eLR4SBNS7L5XLR9zDyZbvaRrA+qYm3ZYUA==
X-Received: by 2002:adf:fa86:0:b0:38d:dffc:c144 with SMTP id ffacd0b85a97d-38f587e73a2mr5603019f8f.55.1740068968673;
        Thu, 20 Feb 2025 08:29:28 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258f5fabsm20813753f8f.45.2025.02.20.08.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:29:27 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: broonie@kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	krzysztof.kozlowski@linaro.org,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	johan+linaro@kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 5/5] ASoC: q6apm-dai: remove redundant hw_constraints setup
Date: Thu, 20 Feb 2025 16:28:47 +0000
Message-Id: <20250220162847.11994-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220162847.11994-1-srinivas.kandagatla@linaro.org>
References: <20250220162847.11994-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

pcm core already does setup the hw_constraints from struct snd_pcm_hardware
values, setting this in q6apm-dai is redundant.

Remove the code that sets this.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index 049b91fd7a23..b644ce7d394b 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -374,34 +374,6 @@ static int q6apm_dai_open(struct snd_soc_component *component,
 	else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
 		runtime->hw = q6apm_dai_hardware_capture;
 
-	/* Ensure that buffer size is a multiple of period size */
-	ret = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
-	if (ret < 0) {
-		dev_err(dev, "snd_pcm_hw_constraint_integer failed\n");
-		goto err;
-	}
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		ret = snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
-						   BUFFER_BYTES_MIN, BUFFER_BYTES_MAX);
-		if (ret < 0) {
-			dev_err(dev, "constraint for buffer bytes min max ret = %d\n", ret);
-			goto err;
-		}
-	}
-
-	ret = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 32);
-	if (ret < 0) {
-		dev_err(dev, "constraint for period bytes step ret = %d\n", ret);
-		goto err;
-	}
-
-	ret = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 32);
-	if (ret < 0) {
-		dev_err(dev, "constraint for buffer bytes step ret = %d\n", ret);
-		goto err;
-	}
-
 	runtime->private_data = prtd;
 	runtime->dma_bytes = BUFFER_BYTES_MAX;
 	if (pdata->sid < 0)
-- 
2.39.5


