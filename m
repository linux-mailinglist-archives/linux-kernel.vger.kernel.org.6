Return-Path: <linux-kernel+bounces-433507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754539E5958
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9731698FB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F1521A421;
	Thu,  5 Dec 2024 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sBQnZ+g0"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB642BE49
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733411212; cv=none; b=jJpDyqGdpn6gApG5Ue8fR/yXAHFCAGXfWyHvOUg4rt40jA2OLb7QCl1f7CMQsNdyCH4ByDbdKQ+Es4ScWiCXCtS4v3NxCxaL+QHM22MWv2ippeYHZmR6WnQRbL8x3MO/Z7q6T5hqbRRQROFchvL63YSRFo5x6T2l4vfQ6QeKQTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733411212; c=relaxed/simple;
	bh=/vvfdxnrBoRZ8tYl8FRklALE0KalVmA2J6aZIhuf4/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qT2RzJu8G5T9bw2DHnLqcc63euvQjAw23HrImbhJf4SGI6cbt0LfVcOgq59qeNqxogNYK5JN1yqeD8EiEjwe3s38RqNsIR2kVxeZK4iC69cA6VCsUYM3tlJMdNBXl2v1QfrkrPWCQuOTV1nBQ+XVcmksuLo4knwuawG0CFuvCVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sBQnZ+g0; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aadb1so1342083a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 07:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733411209; x=1734016009; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W4oP5izvNF5OOtr3Waf88aH91OpBFvN5iR6It/NxVU4=;
        b=sBQnZ+g0uh9WopVuR06Muk8TasTx4vSuDjliV5b7M/3YRqLlYHpiplUC17UBCYvEW1
         OSYPrmlaFJCaKBr+C2pp3eOrBRJ7P+xtYs3wTrXTc5uc5cKoSlm5kXCI4JXf8xmX0C1Y
         1BYOlXcjApSod90E01/1UZCZURzChQfwmNt9jt5EZX1CnGsOD3x+L7NvPrB92L5wEKZH
         Cdo9ZCe3k4V8nTJulx+rsi39PoDA5HdGCnZGx9wE0f3JIJGVT/GkfoHTLa9fU6cvf4MX
         ZuD3F3jl9pmpGHPrsSpRADli8o1FflVy9c5Q56L5pOLvyG7Sl7T9W/gxgPj/DAcacVUY
         Qs1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733411209; x=1734016009;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4oP5izvNF5OOtr3Waf88aH91OpBFvN5iR6It/NxVU4=;
        b=ICDSMBBr48+qcHWIQ6jGl08BGlnpgaS3WmpKSGm3W67dwICaJxoEt9G1EjmaL3CN1I
         u6g9cVdB3f8D+r4RI4ZPWBqgh+IAo7MfSkiiIzwRdRUH/CasloV1mB86k/EcUm71nNsk
         dZQ8oa0gfTsJUYM/lE74FZQXy1rJ5YiIsJC7Zehpdv9LeUy3an2FZdwsVWsfa3+pSU9r
         /MlVwPYQIMQYiY0+T82kLKz8KSuWlT76sjNNo+3163flrSTJ8YSgqutD7Ztp8ZssMGBE
         i+Q5PKoyOtML3vWlP/H+kL/0qxCdT4YRIFXyzfE7Q++QMvL7nstIGJM+m133eg8stfSI
         082w==
X-Forwarded-Encrypted: i=1; AJvYcCVl0Zsuq2PMNeQU8eBWHOR1CziwQsST6zXIsQOZgJ495Q4mYJT0glB9DwpI8TqFABMVDRITHAhwt7NmO/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGKI3rL5OXoEgL5R2/9tPzDWzmWykv9ILojFE4tIaehM1Q2Z0B
	JcYkWl1hS9b/h6xzkNpO3w2dQ49b4ILAkufnAgV+u57MEHMXo1mmqv3e2ukBrrFOX5yX/GbFdWE
	Sj/o=
X-Gm-Gg: ASbGncseUqd/UVuz4DyXxis++unSA4vRTPV2A17qTukGvhh1bbejboDz+pkw+X3j349
	UFleo37PzlCOb+liD/uu+V647rkNxqgZRZZwc6WrnFR7eq7y1HmaLWTCjxOPK1ryNd9TOlLGGrr
	u1twG9S9DRrXUkBv+P9M7Otctn+0ZXlUbM+ALx7rP9JLy84yYJleVmec1X4AxfXnQio6uYg2ExR
	U67nzrUiLld9+jk3U619oVvy4gjbgyK2KCGCrsSbfMhllmhXwlLHnOMKmLNo+KHW/0DTJ8=
X-Google-Smtp-Source: AGHT+IG3n3rheA8zko7qp1b4VyWBqjQnC6L2ZIjk3x6yI5qCJphyIylEY95jPMeS/SIWqqrgwJ70ug==
X-Received: by 2002:a05:600c:4f87:b0:42c:b5f1:44ff with SMTP id 5b1f17b1804b1-434d0a07e55mr91108605e9.24.1733410881161;
        Thu, 05 Dec 2024 07:01:21 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52c0bc7sm62830795e9.35.2024.12.05.07.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 07:01:20 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 05 Dec 2024 16:01:08 +0100
Subject: [PATCH v4 4/7] drm/msm: adreno: find bandwidth index of OPP and
 set it along freq index
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-topic-sm8x50-gpu-bw-vote-v4-4-9650d15dd435@linaro.org>
References: <20241205-topic-sm8x50-gpu-bw-vote-v4-0-9650d15dd435@linaro.org>
In-Reply-To: <20241205-topic-sm8x50-gpu-bw-vote-v4-0-9650d15dd435@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5830;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=/vvfdxnrBoRZ8tYl8FRklALE0KalVmA2J6aZIhuf4/U=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnUcA4ffp2G+r00yspMOON4TPqISXjmk5DodVVlf2F
 H8WdJpCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ1HAOAAKCRB33NvayMhJ0fddD/
 wMF+R1NR6QAWBxUcL7E/VOuFvVHeL7qSzhnc+eC5gdjLdR26WoI6NC8CcWf+9LPmHXcz/Mz+Mgxk/A
 PSNdYkxunfSeJqU5KGBAlHRVbJgno/BG+iawJWg9jN2NM4TOZF6MWF4HFDqH567GPyg0u8ZMfBpCcI
 HgmAQINM5DGWIkdlVDSPsFTgcSPvy7aLEHjMr47xbxNoVvHRHhJMuqOb0aVL7oGZTPnCLZHea+50UE
 h+CB/cxDC7gSIZ48QbXGr6Im7AUnlYMI2bCM/rP+oOK+uJA5snrVVG1XGzrMAbihAiJhAd8bcXz/JS
 iOvizEb4ZjzdYgfLDJzi2Z3SfUfNnYHSSunl8rXt6xZ/RAsDySoocW2jRtiRzJ84k3GtcjawR3zy3W
 JtsHOfh8RpyxaOMbTATPAZ8GgxSPqML+Xcywv/iDNgYVcmmNzs5KH8aYW3/Zz8Y7Hz0mdx85QOZKZm
 VwMvCsDky94NoQhyaQhLtTrifNCieUjDaoWjZ/cBnsAuaJD6xSvR67pF5iNVsMaFA6OtgGPThGMWIx
 lTzt8j/S3diqSHlXUBESbW4OENOA5geXascNO3nSZtXdpFOU/4OzCPy3QYpMuGo3ZuVTCP5AyD6Q4t
 JhbL6EVYTzJQ1b8jXawuL0R7aa8JAdn14KLTZWVKkLu9kQJqIRdygm/3I2Rw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The Adreno GPU Management Unit (GMU) can also scale the DDR Bandwidth
along the Frequency and Power Domain level, until now we left the OPP
core scale the OPP bandwidth via the interconnect path.

In order to enable bandwidth voting via the GPU Management
Unit (GMU), when an opp is set by devfreq we also look for
the corresponding bandwidth index in the previously generated
bw_table and pass this value along the frequency index to the GMU.

The GMU also takes another vote called AB which is a 16bit quantized
value of the floor bandwidth against the maximum supported bandwidth.

The AB is calculated with a default 25% of the bandwidth like the
downstream implementation too inform the GMU firmware the minimal
quantity of bandwidth we require for this OPP.

Since we now vote for all resources via the GMU, setting the OPP
is no more needed, so we can completely skip calling
dev_pm_opp_set_opp() in this situation.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 39 +++++++++++++++++++++++++++++++++--
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  2 +-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c |  6 +++---
 drivers/gpu/drm/msm/adreno/a6xx_hfi.h |  5 +++++
 4 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 36696d372a42a27b26a018b19e73bc6d8a4a5235..46ae0ec7a16a41d55755ce04fb32404cdba087be 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -110,9 +110,11 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp,
 		       bool suspended)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	const struct a6xx_info *info = adreno_gpu->info->a6xx;
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
 	u32 perf_index;
+	u32 bw_index = 0;
 	unsigned long gpu_freq;
 	int ret = 0;
 
@@ -125,6 +127,37 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp,
 		if (gpu_freq == gmu->gpu_freqs[perf_index])
 			break;
 
+	/* If enabled, find the corresponding DDR bandwidth index */
+	if (info->bcms && gmu->nr_gpu_bws > 1) {
+		unsigned int bw = dev_pm_opp_get_bw(opp, true, 0);
+
+		for (bw_index = 0; bw_index < gmu->nr_gpu_bws - 1; bw_index++) {
+			if (bw == gmu->gpu_bw_table[bw_index])
+				break;
+		}
+
+		/* Vote AB as a fraction of the max bandwidth */
+		if (bw) {
+			u64 tmp;
+
+			/* For now, vote for 25% of the bandwidth */
+			tmp = bw * 25;
+			do_div(tmp, 100);
+
+			/*
+			 * The AB vote consists of a 16 bit wide quantized level
+			 * against the maximum supported bandwidth.
+			 * Quantization can be calculated as below:
+			 * vote = (bandwidth * 2^16) / max bandwidth
+			 */
+			tmp *= MAX_AB_VOTE;
+			do_div(tmp, gmu->gpu_bw_table[gmu->nr_gpu_bws - 1]);
+
+			bw_index |= AB_VOTE(clamp(tmp, 1, MAX_AB_VOTE));
+			bw_index |= AB_VOTE_ENABLE;
+		}
+	}
+
 	gmu->current_perf_index = perf_index;
 	gmu->freq = gmu->gpu_freqs[perf_index];
 
@@ -140,8 +173,10 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp,
 		return;
 
 	if (!gmu->legacy) {
-		a6xx_hfi_set_freq(gmu, perf_index);
-		dev_pm_opp_set_opp(&gpu->pdev->dev, opp);
+		a6xx_hfi_set_freq(gmu, perf_index, bw_index);
+		/* With Bandwidth voting, we now vote for all resources, so skip OPP set */
+		if (!bw_index)
+			dev_pm_opp_set_opp(&gpu->pdev->dev, opp);
 		return;
 	}
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index 2062a2be224768c1937d7768f7b8439920e9e127..0c888b326cfb485400118f3601fa5f1949b03374 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -209,7 +209,7 @@ void a6xx_hfi_init(struct a6xx_gmu *gmu);
 int a6xx_hfi_start(struct a6xx_gmu *gmu, int boot_state);
 void a6xx_hfi_stop(struct a6xx_gmu *gmu);
 int a6xx_hfi_send_prep_slumber(struct a6xx_gmu *gmu);
-int a6xx_hfi_set_freq(struct a6xx_gmu *gmu, int index);
+int a6xx_hfi_set_freq(struct a6xx_gmu *gmu, u32 perf_index, u32 bw_index);
 
 bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu);
 bool a6xx_gmu_sptprac_is_on(struct a6xx_gmu *gmu);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
index fc4bfad51de9a3b6617fbbd03471a5851d43ce88..5c566ce6612ed25763337d20de90d78697dfb801 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
@@ -765,13 +765,13 @@ static int a6xx_hfi_send_core_fw_start(struct a6xx_gmu *gmu)
 		sizeof(msg), NULL, 0);
 }
 
-int a6xx_hfi_set_freq(struct a6xx_gmu *gmu, int index)
+int a6xx_hfi_set_freq(struct a6xx_gmu *gmu, u32 freq_index, u32 bw_index)
 {
 	struct a6xx_hfi_gx_bw_perf_vote_cmd msg = { 0 };
 
 	msg.ack_type = 1; /* blocking */
-	msg.freq = index;
-	msg.bw = 0; /* TODO: bus scaling */
+	msg.freq = freq_index;
+	msg.bw = bw_index;
 
 	return a6xx_hfi_send_msg(gmu, HFI_H2F_MSG_GX_BW_PERF_VOTE, &msg,
 		sizeof(msg), NULL, 0);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
index 528110169398f69f16443a29a1594d19c36fb595..52ba4a07d7b9a709289acd244a751ace9bdaab5d 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
@@ -173,6 +173,11 @@ struct a6xx_hfi_gx_bw_perf_vote_cmd {
 	u32 bw;
 };
 
+#define AB_VOTE_MASK		GENMASK(31, 16)
+#define MAX_AB_VOTE		(FIELD_MAX(AB_VOTE_MASK) - 1)
+#define AB_VOTE(vote)		FIELD_PREP(AB_VOTE_MASK, (vote))
+#define AB_VOTE_ENABLE		BIT(8)
+
 #define HFI_H2F_MSG_PREPARE_SLUMBER 33
 
 struct a6xx_hfi_prep_slumber_cmd {

-- 
2.34.1


