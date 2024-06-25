Return-Path: <linux-kernel+bounces-229552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F569170B8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D498F1C24F8E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BFD17E911;
	Tue, 25 Jun 2024 18:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GRwh5EMg"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29C718637
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341690; cv=none; b=p59tI6Vg6nyJ+ToRrVVgMpq39tgkHYOz2EdggIH1PiBSH5Vdd93TRFL8gogSGznAdTUKegW5Fj4boLhFyNt/5LIpmN+tDEYECdHdTtPo2jXhtYyFdtxeTA6Pnzdjtjs7ndJwvqFLgYjCe5nuZXvo+/FZbrO7qcsfY9NZTlifTnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341690; c=relaxed/simple;
	bh=eaij4ky7Aj6Mo/9du9/Ra9OWPq/fZxhy7kMrtRpyFYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WYae72QthNbfXgEZSSwL40iTtsVmxE52XwUqSuiMeqeJnvgLjgHSiSSGcxdw35/iOv9WnYOZiUiQpu+Uf/ltEB8AqF6qlxzKY999RTEP6nMtQIjx4PtnQXmGsYa/0TK6nX/cmXgQ8XgcLJ+rwk0ryYye/ph08xxIsfHzN91Yms8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GRwh5EMg; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57d06101d76so6444288a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719341687; x=1719946487; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xAeS4mM4aSNcoVf/kotftvMHKTcYgSCvsxfnUxg7P5Y=;
        b=GRwh5EMgn+bCC2HpXZdUk1VcXhAu53MGVet4ybcU1fo8Po0kIRw+SWHx0ilRojaJGi
         dpolJifHD4CD9mzCtsoEsGmPht3jRIlP2aLIBziKcRwakzkWtqsfex8KLZ4btv3qrtvC
         SsuxxsOHuI1YmLRM+AP5wnlfxTVYAOrSMeWC2ipT2y/Y5VT9efUNS9Q1gS0E1sh7XdP2
         XLQnAu8xhUrKlt1fbKCA+4EIRj/gd/CX1YPZkWddmmXUiR/dqWxDtFyQLhBeQMtqbXiJ
         kRBjZbvCjWNLCe0iRleK5MupNfmXpifwY7jyIA7IU2sZ6dOaJXqXbz21GXOI6DqG6xN0
         7YXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719341687; x=1719946487;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xAeS4mM4aSNcoVf/kotftvMHKTcYgSCvsxfnUxg7P5Y=;
        b=Faxj04SuRVpuSwgP1k+cos9frEdPmuhO9UoaV6uwo8hZ+z6zn2HB3QR//8rhQY1tAp
         eZRCn0ST8s2fXK09KEtUoy3NOi0ytDQfZAooJQImoPqu31zsrbVU+2Hk1AjHpMtTVQM7
         SauiI+fPkIiKbUoGnLMJpYOHIB8l+YohDzh9+tidI0R1o5oyKxKyLs+QbStH8i8IVg56
         DzMSYNdA6CGBk2h1eD3AZbqObfnBN1cm6YQGU0OT4wi+y3n2/iFbXz8UudcYNDOeYtmp
         bxmMZdYM3cXtZNbvQDbFo6lYArSEDz0ME+mtyVdht34+cZ+9FQG+hBW46hsO1fKIOxLq
         LLrg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ2AhYYIMJVJ6LO4xDXB3fgoV4wfbNC8SrEToyr+2mPelBbASX0uzSnhBY5UFIKxO8Auuos3OHFEFXpQbxjz4Iyh6zpV4k+VCQfBJh
X-Gm-Message-State: AOJu0Ywi3dAHj80jMqrp0uuhlM8WP0CiJy3CYsZqcN1W8qxX0303Kf/r
	00xgnjDVtoxkfWzTB9CusdlE7nRpFs3Q9wRKely9e66nqsjldEwTw7N9BqfIp20=
X-Google-Smtp-Source: AGHT+IEZrJZS1tfhyTZGHs+U9v369kOCPKFuTyDtNvE4wjV/huT/hN7vydHLOuarueDDNPJZbhY6ZA==
X-Received: by 2002:a50:871a:0:b0:57a:1fef:619e with SMTP id 4fb4d7f45d1cf-57d49cba82dmr6411757a12.18.1719341686936;
        Tue, 25 Jun 2024 11:54:46 -0700 (PDT)
Received: from [192.168.215.29] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30583e93sm6206332a12.96.2024.06.25.11.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 11:54:46 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 25 Jun 2024 20:54:41 +0200
Subject: [PATCH v2 1/2] drm/msm/adreno: De-spaghettify the use of memory
 barriers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-adreno_barriers-v2-1-c01f2ef4b62a@linaro.org>
References: <20240625-adreno_barriers-v2-0-c01f2ef4b62a@linaro.org>
In-Reply-To: <20240625-adreno_barriers-v2-0-c01f2ef4b62a@linaro.org>
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Akhil P Oommen <quic_akhilpo@quicinc.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719341683; l=2477;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=eaij4ky7Aj6Mo/9du9/Ra9OWPq/fZxhy7kMrtRpyFYE=;
 b=Z0KB5jk9AhXcGs1aL3QtNdOPM5K/I4gVZFo+tLfA1o/pzDBDBAHZizVeTI/hoeYeCFn8s3LVE
 WBYMHf66XPSAmUwwriFgo+nFF+A0QD2AX3EK7pq3QNX6nzgBgLH4q7t
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Memory barriers help ensure instruction ordering, NOT time and order
of actual write arrival at other observers (e.g. memory-mapped IP).
On architectures employing weak memory ordering, the latter can be a
giant pain point, and it has been as part of this driver.

Moreover, the gpu_/gmu_ accessors already use non-relaxed versions of
readl/writel, which include r/w (respectively) barriers.

Replace the barriers with a readback (or drop altogether where possible)
that ensures the previous writes have exited the write buffer (as the CPU
must flush the write to the register it's trying to read back).

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c |  4 +---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 10 ++++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 0e3dfd4c2bc8..09d640165b18 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -466,9 +466,7 @@ static int a6xx_rpmh_start(struct a6xx_gmu *gmu)
 	int ret;
 	u32 val;
 
-	gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, 1 << 1);
-	/* Wait for the register to finish posting */
-	wmb();
+	gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, BIT(1));
 
 	ret = gmu_poll_timeout(gmu, REG_A6XX_GMU_RSCC_CONTROL_ACK, val,
 		val & (1 << 1), 100, 10000);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index c98cdb1e9326..4083d0cad782 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -855,14 +855,16 @@ static int hw_init(struct msm_gpu *gpu)
 	/* Clear GBIF halt in case GX domain was not collapsed */
 	if (adreno_is_a619_holi(adreno_gpu)) {
 		gpu_write(gpu, REG_A6XX_GBIF_HALT, 0);
+		gpu_read(gpu, REG_A6XX_GBIF_HALT);
+
 		gpu_write(gpu, REG_A6XX_RBBM_GPR0_CNTL, 0);
-		/* Let's make extra sure that the GPU can access the memory.. */
-		mb();
+		gpu_read(gpu, REG_A6XX_RBBM_GPR0_CNTL);
 	} else if (a6xx_has_gbif(adreno_gpu)) {
 		gpu_write(gpu, REG_A6XX_GBIF_HALT, 0);
+		gpu_read(gpu, REG_A6XX_GBIF_HALT);
+
 		gpu_write(gpu, REG_A6XX_RBBM_GBIF_HALT, 0);
-		/* Let's make extra sure that the GPU can access the memory.. */
-		mb();
+		gpu_read(gpu, REG_A6XX_RBBM_GBIF_HALT);
 	}
 
 	/* Some GPUs are stubborn and take their sweet time to unhalt GBIF! */

-- 
2.45.2


