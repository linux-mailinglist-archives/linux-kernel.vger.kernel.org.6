Return-Path: <linux-kernel+bounces-174785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D608C14F0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72E351F21091
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 18:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E882C7E107;
	Thu,  9 May 2024 18:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L0eH3QZX"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E126D3D3AC
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 18:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715280090; cv=none; b=jT+0woIKHufvxkzJH8ViAN2Dabhi7UegOrn3BE9klLc+Rg1m8/fWpCmgIzqnn08CRcK++l4/YcvMbaU6+Aeeaqzoqo8Th4P2J7IRrWgBY+ZeuIdr38tr87Q/xSsBnT0hvPhl4zP5KBw4sZg/FlhRNRjZzJYOc3yaw0qeaUtMwzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715280090; c=relaxed/simple;
	bh=z6XHl5llDJyiHPA78/v4DUNEAeOPZTfmTPQPFm4H3Nk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XwqcPx7s7lOuA01XU8st2MKd+ZL5AT92YbyIeHMjBc+CvlUnZ9/JubDAQVZAKrZ1Ea73lw/nLqhChF0cYZWItaVTegAthNNfykO1gADB+BTnGUWkrw9UZm9Nn7DNOYMWTIIiqus8TxZTufSY+f5sZFW3Q7oNdXXSzKEO7Z1rsrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L0eH3QZX; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59a9d66a51so277477366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 11:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715280087; x=1715884887; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mqPEfUzcM7hu8r9fmVZs+WucUjP6utXCGhcKPrzzj8I=;
        b=L0eH3QZXygPjvMUIMMzJ9GOIlykb2QPjVKbNV+1BAeDhhErNfrxUoktUvp+GpCIfcq
         shAEb11u430KWbv7YLXKjEqYpmCZtQmRQuaoTH8GBhJLy/yjrY7UhdXqhIOIMdlmjMGl
         PvIoxOmRP1tf5F12ihuBeE+/DWYgRqYed3JVfsKG0F/DhiOpSSY0Mgx+oX5KuhnQ8P7o
         +wLPUYFTY8rB4QSkNsJDCkRv58jSwhA23JqIwtP0xdezx1PiKJ1QMM7qAcwJi2O3r+J9
         hH4LDo8L2C6Sq1URWhfam+LaH07BSNlwX/djqrBwrFIRr7GCTvjuOQZXx/yIv80oVUL0
         Eu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715280087; x=1715884887;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqPEfUzcM7hu8r9fmVZs+WucUjP6utXCGhcKPrzzj8I=;
        b=CsYOTpBQp9qxNifbzLOjoAKZ8JwDMryqhEubdvvUplTVPydFMTD3Cgo59BeWbEKIB/
         mQoCk7BkOoJ/+OprzR6An/nlssnbZq0fdKUaUsQbHX+w7qoe0rFb3iArW1zaxLuCqw0B
         goJnL+ioweuWFGhAXvzTqBNxxt7/ZizGcN11DdZ3StGzmD6NtSJm81FC1gxKIhrQgz+5
         Aabgj9/SLEcGi2D7lFB2Skt2uxJznG79sxoUzJhVpqRltQnHW1jO6bTcuq9GZKy0g9e/
         OBJmadjRvgnYQebOHtfjuM/D7N/8klsa0prDKxcMX7+oddZZ5WKvTDEONKPNFbDKyztC
         lRHA==
X-Forwarded-Encrypted: i=1; AJvYcCUKskV1uellllCHRJl5ofFUcni7WyIyrO02xLvLSfwVI6i4mCropDzFrGUQZppI2OIv9SvB+8LDkPVB9wFLgWyLDK4hzbtsqDaj9Qii
X-Gm-Message-State: AOJu0YzqDwa4tqA3njyuDARuEV7Q4qaSL6e7gc902hNEgfJrytS63cgO
	sAub0ZbtkezSI7pGH6YZa44Bz9nye2K+nmy82slrG7e3ZEp73xqS0tGJnPDPQ7w=
X-Google-Smtp-Source: AGHT+IGhx7HNcYGITxPU9mNn+ku+A6vTT7YBFccM+yXBc7Idaz4Uq4aqT5RpvZSXeN7Mp2i7aNrD6Q==
X-Received: by 2002:a17:906:aad5:b0:a59:a9c0:57e9 with SMTP id a640c23a62f3a-a5a2d678775mr26706966b.76.1715280086983;
        Thu, 09 May 2024 11:41:26 -0700 (PDT)
Received: from [192.168.62.15] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01517sm99929166b.157.2024.05.09.11.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 11:41:26 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Thu, 09 May 2024 20:41:23 +0200
Subject: [PATCH v2] drm/msm/adreno: De-spaghettify the use of memory
 barriers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240509-topic-adreno-v2-1-b82a9f99b345@linaro.org>
X-B4-Tracking: v=1; b=H4sIANIYPWYC/1XMQQrCMBCF4auUWRtJo5HGlfcQF5Nk0g5oUialC
 KV3N7hS3upbvH+DSsJU4dptILRy5ZIbzKGDMGEeSXFsBqPNWVvt1FJmDgqjUC4KB3dy3pl0MRb
 aZRZK/P7m7o/mJOWllkkIfyPDf2TtVZtHH7UNfe/i7ckZpRyLjLDvH2cr00SjAAAA
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715280085; l=5092;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=z6XHl5llDJyiHPA78/v4DUNEAeOPZTfmTPQPFm4H3Nk=;
 b=bWXRy6aulY2LTlIiaVEc91Yo7C4I8hLO+xSdtizQpxkFS48xA6mHIfG9nDAHOLmFZvLwxWUvl
 6ts9tcSY/TPC54E2eMJRWZyg7uk7mfqLrJeSHz8/kdeQTuvUHduzFyd
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Memory barriers help ensure instruction ordering, NOT time and order
of actual write arrival at other observers (e.g. memory-mapped IP).
On architectures employing weak memory ordering, the latter can be a
giant pain point, and it has been as part of this driver.

Moreover, the gpu_/gmu_ accessors already use non-relaxed versions of
readl/writel, which include r/w (respectively) barriers.

Replace the barriers with a readback that ensures the previous writes
have exited the write buffer (as the CPU must flush the write to the
register it's trying to read back) and subsequently remove the hack
introduced in commit b77532803d11 ("drm/msm/a6xx: Poll for GBIF unhalt
status in hw_init").

Fixes: b77532803d11 ("drm/msm/a6xx: Poll for GBIF unhalt status in hw_init")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:

* Introduce gpu_write_flush() and use it
* Don't accidentally break a630 by trying to write to non-existent GBIF
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c |  4 +---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h | 10 ++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 16 ++++------------
 drivers/gpu/drm/msm/msm_gpu.h         | 14 ++++++++++++--
 4 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 0e3dfd4c2bc8..fb2f8a03da41 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -466,9 +466,7 @@ static int a6xx_rpmh_start(struct a6xx_gmu *gmu)
 	int ret;
 	u32 val;
 
-	gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, 1 << 1);
-	/* Wait for the register to finish posting */
-	wmb();
+	gmu_write_flush(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, BIT(1));
 
 	ret = gmu_poll_timeout(gmu, REG_A6XX_GMU_RSCC_CONTROL_ACK, val,
 		val & (1 << 1), 100, 10000);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index 94b6c5cab6f4..ab7f581f0d24 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -111,6 +111,16 @@ static inline void gmu_write(struct a6xx_gmu *gmu, u32 offset, u32 value)
 	writel(value, gmu->mmio + (offset << 2));
 }
 
+/*
+ * Use for timing-critical writes that must reach the hardware immediately
+ * (to work around write buffering), e.g. for reset registers.
+ */
+static inline void gmu_write_flush(struct a6xx_gmu *gmu, u32 offset, u32 value)
+{
+	gmu_write(gmu, offset, value);
+	gmu_read(gmu, offset);
+}
+
 static inline void
 gmu_write_bulk(struct a6xx_gmu *gmu, u32 offset, const u32 *data, u32 size)
 {
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index cf0b1de1c071..ef7eaa6d5e5c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1714,21 +1714,13 @@ static int hw_init(struct msm_gpu *gpu)
 
 	/* Clear GBIF halt in case GX domain was not collapsed */
 	if (adreno_is_a619_holi(adreno_gpu)) {
-		gpu_write(gpu, REG_A6XX_GBIF_HALT, 0);
-		gpu_write(gpu, REG_A6XX_RBBM_GPR0_CNTL, 0);
-		/* Let's make extra sure that the GPU can access the memory.. */
-		mb();
+		gpu_write_flush(gpu, REG_A6XX_GBIF_HALT, 0);
+		gpu_write_flush(gpu, REG_A6XX_RBBM_GPR0_CNTL, 0);
 	} else if (a6xx_has_gbif(adreno_gpu)) {
-		gpu_write(gpu, REG_A6XX_GBIF_HALT, 0);
-		gpu_write(gpu, REG_A6XX_RBBM_GBIF_HALT, 0);
-		/* Let's make extra sure that the GPU can access the memory.. */
-		mb();
+		gpu_write_flush(gpu, REG_A6XX_GBIF_HALT, 0);
+		gpu_write_flush(gpu, REG_A6XX_RBBM_GBIF_HALT, 0);
 	}
 
-	/* Some GPUs are stubborn and take their sweet time to unhalt GBIF! */
-	if (adreno_is_a7xx(adreno_gpu) && a6xx_has_gbif(adreno_gpu))
-		spin_until(!gpu_read(gpu, REG_A6XX_GBIF_HALT_ACK));
-
 	gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_CNTL, 0);
 
 	if (adreno_is_a619_holi(adreno_gpu))
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index a0c1bd6d1d5b..45d00acd5b1b 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -553,14 +553,24 @@ struct msm_gpu_state {
 	struct msm_gpu_state_bo *bos;
 };
 
+static inline u32 gpu_read(struct msm_gpu *gpu, u32 reg)
+{
+	return readl(gpu->mmio + (reg << 2));
+}
+
 static inline void gpu_write(struct msm_gpu *gpu, u32 reg, u32 data)
 {
 	writel(data, gpu->mmio + (reg << 2));
 }
 
-static inline u32 gpu_read(struct msm_gpu *gpu, u32 reg)
+/*
+ * Use for timing-critical writes that must reach the hardware immediately
+ * (to work around write buffering), e.g. for reset registers.
+ */
+static inline void gpu_write_flush(struct msm_gpu *gpu, u32 reg, u32 data)
 {
-	return readl(gpu->mmio + (reg << 2));
+	gpu_write(gpu, reg, data);
+	gpu_read(gpu, reg);
 }
 
 static inline void gpu_rmw(struct msm_gpu *gpu, u32 reg, u32 mask, u32 or)

---
base-commit: ec2d9beb604a623a9f5308f7abcff3561e08c155
change-id: 20240509-topic-adreno-a8939b92f625

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


