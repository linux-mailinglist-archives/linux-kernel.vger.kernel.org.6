Return-Path: <linux-kernel+bounces-229502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1091791703F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A641F21501
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F60A17C7DB;
	Tue, 25 Jun 2024 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O8GUPPfR"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4AD17C230
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719340101; cv=none; b=bP8OAJVByPAl+BjlLCHVqkux3bfXmnHWDhg+9KbrBw1QX6YxQ9ngOjOMD0/sCH0VmFqxrNiGQF4TQpVsb7+O9CDWbBhte9CpFWc6FEQXK9liJfnMyf46lWJLC1nkAnh+/Q4aOA9B/iLrjv9aJv71CZPhPU4cRKVJj1a3Sduzbm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719340101; c=relaxed/simple;
	bh=pgXB3ku76GP+Ynds4TGlmCZD8EhfvV2JMzgzNC6TMuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eE7d3DYwVKkJ+DNF1t2ftgm57wD+hWmRm2T5lrcUYEgCs8Oz8cM5R+Nj6RQP2ZDDqdy7x8ubKqwQe1HM8OfxoKLyh7jNXaxPjxl6zgwnEPMUy/qr8pZM8XMYvwJ8yivAPc+uYFzFQdIFowRGklibTrw7gFYWiVhWFkK1HI6obdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O8GUPPfR; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57d10354955so6773006a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719340098; x=1719944898; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PcWoGGIEC7a8K4XEAMfnShumcqiU+VC3T2hAJ7CQxuk=;
        b=O8GUPPfRtg0fSBYDFnpasBhtx+a5dz0XmGfIRrYqgOoUg6VT4+HoKb3oTOMWle6N2O
         50BjnyXuyarOGKM7G9U/0VXk3hSonoUSI1+BmQegTFpeMqIkg78gBTLxqEcEBp/VxtvC
         TarJ31N92SswNgSx/UfQI3McRCd9M1C5ng4nwKMZMU7JW0wVcL8sjXOoEBY98EyOf8gF
         2+1xz7KJAQHh99uDGyZENxxWkzpfFCdhZq2Aw3PUKxwysscX0q/SCAYxLcDz/Ga2TQjC
         5LOhvu6zRJpWg8N/tJ2qqMXLyapnqBV08DEhmtL8WjEQcK3o16QxqXRDEzyDc8pl7oxe
         SyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719340098; x=1719944898;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PcWoGGIEC7a8K4XEAMfnShumcqiU+VC3T2hAJ7CQxuk=;
        b=kAte7uTjmBZwRgLy8b/1AunjGK2PR5M0MYFLoF2nW0hY4Q8gPqPqkjRgvO38vyPEOW
         35yvPP1sljkzllqL1JKQjY1DP5J1eXw6H1ka+2WOD99h3gAGONC2fBs9SO7U9oJ3yZ5E
         kJfsuID64xLlkipvIMZ4XuM9QMEj+43SxoAo33QkVAOP49w27wfYhY60f1hO6WjXIBzh
         xDtUhqMnOqk3I0JgWDd2VIeb7m6E8axEQXMUkfm6p0MCHp59DgXVwb9A635Qz2MDsRnT
         mTcRcR8iVg/FscRFmDvbzSTqC2lyGyaYtlK6B2Usd3Yhx+I0+M63qdamiTsu0oLfQW+W
         VKpw==
X-Forwarded-Encrypted: i=1; AJvYcCX84mWc9Gi29BAxT8DMbsn2eqhPzMRLtzbGt6GYtyZay2X2+mUIplNuhjzCv+QATN098R5wggS5Gf/6VMYz+0DGI3l0hHjxBH4YhRf5
X-Gm-Message-State: AOJu0YwopUsbP4JPAopP9Ft6gf0oN9Jxs4oPzxxrOgaqF+pzCqRUjzst
	14sWJoXgCm4N2NvI/mIIw0gSj7rbYL/+B+Pps0Tto6taFcKc1inWybMrt+Fp0pQ=
X-Google-Smtp-Source: AGHT+IHH9Hnr7bNyOy7pplC6xVh0aDu4XjTvNl6ry3li+pWizfJqcj812ToaosLCAUB1mnaROqNCTw==
X-Received: by 2002:a50:cccf:0:b0:57d:3be:5ec2 with SMTP id 4fb4d7f45d1cf-57d4a01f21dmr6022510a12.30.1719340098207;
        Tue, 25 Jun 2024 11:28:18 -0700 (PDT)
Received: from [192.168.215.29] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3042fd72sm6323136a12.48.2024.06.25.11.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 11:28:17 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 25 Jun 2024 20:28:07 +0200
Subject: [PATCH v4 2/5] drm/msm/adreno: Add speedbin data for SM8550 / A740
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-topic-smem_speedbin-v4-2-f6f8493ab814@linaro.org>
References: <20240625-topic-smem_speedbin-v4-0-f6f8493ab814@linaro.org>
In-Reply-To: <20240625-topic-smem_speedbin-v4-0-f6f8493ab814@linaro.org>
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719340091; l=1481;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=pgXB3ku76GP+Ynds4TGlmCZD8EhfvV2JMzgzNC6TMuc=;
 b=4pAQCD48WMIG4yPsA0ws8Nht+e2p4Y2ez7R8+XZVKTh1CmihZSf2KTi89K6tp6SMOv2htCcc3
 eDOPlXUrflcDo3HEbFZc5BtkIKqfE7vvJ9frwICe6+2ScwBiA3Jwcrx
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Add speebin data for A740, as found on SM8550 and derivative SoCs.

For non-development SoCs it seems that "everything except FC_AC, FC_AF
should be speedbin 1", but what the values are for said "everything" are
not known, so that's an exercise left to the user..

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 53e33ff78411..8f280d69ba71 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -11,6 +11,9 @@
 #include "a6xx.xml.h"
 #include "a6xx_gmu.xml.h"
 
+#include <linux/soc/qcom/smem.h>
+#include <linux/soc/qcom/socinfo.h>
+
 static const struct adreno_reglist a612_hwcg[] = {
 	{REG_A6XX_RBBM_CLOCK_CNTL_SP0, 0x22222222},
 	{REG_A6XX_RBBM_CLOCK_CNTL2_SP0, 0x02222220},
@@ -1208,6 +1211,11 @@ static const struct adreno_info a7xx_gpus[] = {
 			.protect = &a730_protect,
 		},
 		.address_space_size = SZ_16G,
+		.speedbins = ADRENO_SPEEDBINS(
+			{ ADRENO_SKU_ID(SOCINFO_FC_AC), 0 },
+			{ ADRENO_SKU_ID(SOCINFO_FC_AF), 0 },
+			/* Other feature codes (on prod SoCs) should match to speedbin 1 */
+		),
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x43051401), /* "C520v2" */
 		.family = ADRENO_7XX_GEN3,

-- 
2.45.2


