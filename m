Return-Path: <linux-kernel+bounces-424539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEA59DB597
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7A94166ADA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D93194141;
	Thu, 28 Nov 2024 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zFgG/7Q4"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFC8176ADE
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732789552; cv=none; b=J+JQ0V7BfuX094x/4iMjypTWm4/4lbFAJbJ5VGtqO3NIf8EgHIzY6XLIWWAmN3BPSOkY8ttaCKrBH+LeFrMwQkJBVlkxjAqKOaoF8HutQQ3LOdH5bPuySjF5XyXpI3nS/gV1Toqg1CHA5jUTW4VsKI6TsyXzIVR4OHrkH7DntTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732789552; c=relaxed/simple;
	bh=vsEtJhqxnbLwiKyoTF80GGH+V1VYTVJylLP0loUgqSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XSasfVw4NF0r/fvC+Q0FLdippcuUnAOk50KHM2tL9U7ohas+Y7uLKA/0zuEZ+pGllbLSs5x4+kT6lXuBHGIPOC+L8pXynuyIsBwBo2TtEhoPkdst99RR+lw32HY02llEu1neh/rYpZsPoDj8g2/RX/nnwC0B07fAsn3r3KlXksA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zFgG/7Q4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434a1639637so5941175e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 02:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732789549; x=1733394349; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=reoDVbzQsiSf/gPv0A34FrWumLX+gyEDCSO0BWtsisc=;
        b=zFgG/7Q42juePtAqz6+rjW8MhJDU8ePUopqFhQonszGOLxbIzaIHiJHIoUFA0FlIu2
         /fJ+DDHp8hmGJotI4DlkLlV3EtFl6XojutEDbLG5tA1Xb5YX31FhtthQBMbrvX22ye92
         DDdJqeRbdCbta0O53vKSUmeNnuXXyYMjObJJCuQndZByfsv9Hzc8MzDa7AjERJlMuMXC
         fig6FuHaxUiejYoeMnvYuySoiKx/AtziWY/+029STv5MzSXJz2gHGX63XG8ITUUm5I1T
         miRWEJFMrqUO2dEDR65ZP+PW3ccf8R8yTxz+ZwNzjgaDT6o0WkPX/fOqk+0xRkyBLc7L
         9DMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732789549; x=1733394349;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=reoDVbzQsiSf/gPv0A34FrWumLX+gyEDCSO0BWtsisc=;
        b=UDFL1XljvBlo1L/sjHEnZjmdaCuTZzvnZ+CK9sE6J6hJxrVHgPPNCmtZbYApPgCAdO
         xVblBzu55Hz7w2A48gJacm3jHPmQq9UFXcC8XqWzlB6vXgJZYYBlw87MDi2E4kePl9yw
         Aq93vFOSMLA+mEn3avNXQNuck8i5EHM9nEhSr6OQzBUB7ZvdzdxkncUZ0rDSKXukQmql
         HImEYe7PGh+//fjZzzTh6922hguOjAUaUEsCdi9GsjvzXNHTsngrTnRxjV6yri7i4zHy
         ET7C9M9+Uy650mVfmINFE15oh9AquMVfKhfY3u92WS6j70NTM/ZCDU3LJDb/m7FeNPwv
         Etdw==
X-Forwarded-Encrypted: i=1; AJvYcCXvuvFn5blwr28Z1Sd2vVsLcOBg758cNPFgXichLZpLxFDZYCdOokOotmGg6mj3Q1GENI7O2/vcZva9iRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAK60ZtUAE8ErtmJ7WpxiqeOUEA9PFkUKxp0TROueqLPZtGQYN
	N5LEKrPfvjjopGb1Zl4uQhpB647WoT3ftRbpJBlQl+xyQaGBbF8HAoxwrbd+QC8=
X-Gm-Gg: ASbGncvZceO1b53fNncGMbCt68SV6Lvo1DiW2112uirLRyQ+O1aMyXXmTPLeLwNCDmD
	dObrBMrbBmmsRCUGvnO/IXMcSocMm2k1nsST2GCw8Q7Yv0do8XnMV9xW+4sWwo0Qx7ggHPtZWBf
	ttIy7tX7LI0fAbB3n7Lg9izOzrClse1pXjCXchv/KObAi0u1KBJQBg6S2VskHJ+p16o5cgcYf3u
	4NgTaRfSmErs/FE9mh0qTeFPSGY+7O92AAQd1Qb7k3vDgw1xQSIe8a0lshguKHMcOO+NW8=
X-Google-Smtp-Source: AGHT+IGVIJCasw1w/lv4nzEi6y4n3531XuVT2EDn/i1vSfZn52Q39Pj28ZjDj+ocKgTB+1FjYDEvjQ==
X-Received: by 2002:a05:600c:4e8b:b0:42c:de34:34be with SMTP id 5b1f17b1804b1-434a9db8393mr69151985e9.3.1732789548697;
        Thu, 28 Nov 2024 02:25:48 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd2db59sm1265909f8f.11.2024.11.28.02.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 02:25:48 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 28 Nov 2024 11:25:41 +0100
Subject: [PATCH v3 1/7] drm/msm: adreno: add defines for gpu & gmu
 frequency table sizes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-topic-sm8x50-gpu-bw-vote-v3-1-81d60c10fb73@linaro.org>
References: <20241128-topic-sm8x50-gpu-bw-vote-v3-0-81d60c10fb73@linaro.org>
In-Reply-To: <20241128-topic-sm8x50-gpu-bw-vote-v3-0-81d60c10fb73@linaro.org>
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1341;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=vsEtJhqxnbLwiKyoTF80GGH+V1VYTVJylLP0loUgqSU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnSEUn67+M0ZML1AQ2Cu12caF1aO4b5n+ci1RzZfKS
 W1UiU6CJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0hFJwAKCRB33NvayMhJ0Tk/D/
 4/1hGwJ8vuHp8WboZb5xYxpLSFr2w5QWVfhTYJfXz3uYFf09IKoQt1rD0qqOYKUrioDRVPXnOvnfEC
 gdYfqAzokrpfBrJ1IDSdDZL+bMw1poelWVWdr/UDO+0q6ivtCgTxe2i1toSmnHE+ccpXigknc2U1iS
 4WecgJfwi5zaxlqGStKnjZ9MxeJrP+tdi4VW0ghOInX7WgduaepmTAgesQ+Rpwlan7bVaG1eG82k8V
 /vqsiQUlUWnE26PhWF3K6eNPhgJfD3x4DFGKxo3eqS7dmDvq3d7qNtP3hbfJVLdrdGwkk144aPe0MS
 yVH1y4I40NCPtp7OnHEKjXgF9xJoLRbyT00Fb23tJMPethBjIJpk8WlY65znroi+j3S1h18DId/rDd
 PqHbmxcxetOWwL7/3XxDYrss9FqK+Zex+tDk6DRcaWhyM498GXdx19lvKJv8ND4HZx337ctJvhESGI
 ufv7C0e84+6RUTlMZ/lZ5BBEBsCbh1SDOh01uiyiDNT8SuBt7hIW5oYwurg6UTtd0TUG8wAyOzI2cZ
 wIMDENQbTNcZRmSUhpzL5Yje+OU3Vmh6qIR8MBF9VDeKTKv2XfTwxUhgDqqDexHTA4QaQesWcGgPNL
 B5Zxk5qKmVc9bmnZjA+xVsY2XGnYSD6O9w30M20cCS0NRrieE9AwUWCgXaVw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Even if the code uses ARRAY_SIZE() to fill those tables,
it's still a best practice to not use magic values for
tables in structs.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index b4a79f88ccf45cfe651c86d2a9da39541c5772b3..88f18ea6a38a08b5b171709e5020010947a5d347 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -19,6 +19,9 @@ struct a6xx_gmu_bo {
 	u64 iova;
 };
 
+#define GMU_MAX_GX_FREQS	16
+#define GMU_MAX_CX_FREQS	4
+
 /*
  * These define the different GMU wake up options - these define how both the
  * CPU and the GMU bring up the hardware
@@ -79,12 +82,12 @@ struct a6xx_gmu {
 	int current_perf_index;
 
 	int nr_gpu_freqs;
-	unsigned long gpu_freqs[16];
-	u32 gx_arc_votes[16];
+	unsigned long gpu_freqs[GMU_MAX_GX_FREQS];
+	u32 gx_arc_votes[GMU_MAX_GX_FREQS];
 
 	int nr_gmu_freqs;
-	unsigned long gmu_freqs[4];
-	u32 cx_arc_votes[4];
+	unsigned long gmu_freqs[GMU_MAX_CX_FREQS];
+	u32 cx_arc_votes[GMU_MAX_CX_FREQS];
 
 	unsigned long freq;
 

-- 
2.34.1


