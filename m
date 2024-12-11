Return-Path: <linux-kernel+bounces-440971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A269E9EC755
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1672188C1FF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813891EC4EA;
	Wed, 11 Dec 2024 08:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Shnmf0Qs"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951BF1DE8B7
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905809; cv=none; b=Z5WyXVwEvXwoZo3zlbhiLUxINUCdaYt2pFoh8rIWO1UY5uSWGgeeTlOrweIhpsmGNpco0K4knuDF3qJxvjRjOIo7oPIfS4rgvJrGUF84jKyBO/JJl86vtf3/XM1PMvqgn7VKDIFA4Qt19yeHNlgw2acvVP09xmNvmwgbsPGhV+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905809; c=relaxed/simple;
	bh=m1NcPOsMY9FCd05ub7OGALb9yrmOmV54oQAtHzEO7ck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jgg2Geg3DmgMBlxIkHSxN2wumYvsHW9+570IelgOTtcBO2rrrcHQFfDn8/nRT6dwHKKEKXOjOGUhblWRTYxo04dJFlkldX/yb8t/IShexw66MghOKh1ETfzjjOJHyKEBW5VK+u03hh880ITZonR0AmS3zWpIgxZ/9O5Pw8xcFMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Shnmf0Qs; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385deda28b3so4779903f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733905804; x=1734510604; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U86WDKdPrAsITfGPygHUha71OD7ZxDhxILD/leyKWik=;
        b=Shnmf0QsD5vjBGRjSIalzziId6RJyn6pkY59ZLG07bxuMTZIKlFCOuYligzG0hKuVb
         r8KoGeT98BJfgeUFv9OpD+kw1ki49DuguvE6VXcgSPs6rsxw+lzZH3aXQfpxdQJEQDN3
         Q0vAmEwX21tDQQJhjrX9HGcq4+QQq6QI+F4xm8KTLimAok/Z8hE7eUcX6+3hIkmi59mj
         AKcG/NZscJ9eLDriEXU1Mf9LyGZu7+mGW/SFwMLb3mIx3vNyB0ziYcZPCnzYTs92CtYZ
         ZoBuxfhvyNDP47ZwGcdSi2QJbZusMjpbTed0un0afWV2W6GXNKNbaWsg5bAZWrtxjin0
         FIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733905804; x=1734510604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U86WDKdPrAsITfGPygHUha71OD7ZxDhxILD/leyKWik=;
        b=OhGFryG2dDnet41CWeBCmuewDjFaX++G4zg97co+E7eDgPcWle4hj/r1LsmMK4XR4P
         rrkOx66oyFVNPoHShN6147R3yWYiC6pT5UoM4uEkrZsf5+gZ9yKZzGAGnRbyyN96PwfY
         gBCGT63u8NN3xo95zRr/aOcMLbSrmGNBSuwnPYAvn1VNCKnczngGa+iTGR8yRFKXqA5I
         nShmhufKjzT2gHNvuvoeeMmQao3bDR5ZWZHTmG7BhcyOtanp8rNU//R3OJZ6eQjry+Sl
         6nyzkLnHPQRJzOdbpaegv6KPvhDMJbEaG/wiOYBvtyi6sOlbu9tx8keNG6RBAuPi54Bt
         stTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqlgvxJ/FVPqh/OxzAxfUZKgvvBIPdVRog4NQHYl4vwlPScBeQl6SY9KhaJpwR3yaeS0paylz+kXyla8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsXLYmjuf9tp4gU4mtUC32/Zqa2k+z7X2bTOeMuNHQAkT3uaIL
	hKbbR8iT/H6WiECTChanyd+KtmR2VRRq3/1B/I6yWtIMN9W+e3hgOHXPi65hJ90=
X-Gm-Gg: ASbGncu+SG9rPaajrJMhrR+Fyf1pOQGuBBu93sJtvLwKJ9CIS7jsKVbun7o7ZIjgd4y
	BRtT5WOlj6TB5qTP2uzH4S5jOITi3fVbd8AzIaPgwv2NLScoSBf/cZR2VUXbIFsxuzunsOIGuuU
	rotNtDDoGfsv8OJG2a3Ep1l/uZtbIjE0gM1yQtAbBonh7rJEbmzIxqQ5voU0vvo3MFCHKpa4HY1
	yzJUx8Aqx1QUf4e0bmCZSaZkzcpokQAq6aNPEX16o+uPIFR9S55RWrlZk+OCzn6kKgW4DCjuW8=
X-Google-Smtp-Source: AGHT+IGq09en0HnyDXiGn/DX/au6Q0EcVUymi4G25zrq3RQ0sx1AuF1JJDxDo+5X7J7HeWOENNonBA==
X-Received: by 2002:a05:6000:4403:b0:386:3864:5cf2 with SMTP id ffacd0b85a97d-3864ce96b0fmr795384f8f.19.1733905803964;
        Wed, 11 Dec 2024 00:30:03 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824a3e38sm735687f8f.23.2024.12.11.00.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:30:03 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 11 Dec 2024 09:29:54 +0100
Subject: [PATCH v5 4/7] drm/msm: adreno: find bandwidth index of OPP and
 set it along freq index
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-topic-sm8x50-gpu-bw-vote-v5-4-6112f9f785ec@linaro.org>
References: <20241211-topic-sm8x50-gpu-bw-vote-v5-0-6112f9f785ec@linaro.org>
In-Reply-To: <20241211-topic-sm8x50-gpu-bw-vote-v5-0-6112f9f785ec@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5886;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=m1NcPOsMY9FCd05ub7OGALb9yrmOmV54oQAtHzEO7ck=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnWU2Ei90pzqxk6DE5LSfYiHHw+v5iLh0rbkkQUMox
 R14N192JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ1lNhAAKCRB33NvayMhJ0SASD/
 9Qb/vw3MzeW4uUPJENXlKpxSlje8+9uVBi8LPWqLER1gLjuXvV4l9w9ow8Ck/ay73L9LlhHw/kZ6ie
 /WHDSBkELDJ5yMSaQyOkH6ulm38ZhUx9Nq2UHYzEIhtRMsmzWWFrboGuWmmZKdlDcG7N9gh2Zjn8st
 /9mVTXVO0emv38Fd4vigI0Qqk1FSNV7tQ7EWceL4hD9AhS9zZKhNNIBuo4ONyGtvmQyB3JrfrNAvGj
 8haeGUqbyO8FmAKXH5x3yQ+1oYzc6LphnGt49wsb1OQRpvBOJX9lYhU5AABENTQf9AZXXuqH81VBCb
 qjNE/k0uZRxEXy061XNtVhIkMf3JBv4I+hfNfAYKZSdAgahatOKIB7s8H3K8cuQfbHPek8O9Jw24Q9
 MEXVAC03+LhMgBemFkQW/9jRBOhQAtgV9w/egVeckCCxAqO9ShdAJeauEPK0P8jfYEMy/4q+OWK41S
 VQstBDldm4CCrOXe+VNNHwe+YOXvzSQoNNkEz4mq0HW09Lka94fhMZGLNpw8QaAaYhB7d/4rsMqTuM
 xba+2uy+JcsQt+6ykAF14YpOsG1zrgYlmNvSCJw3thFNnL4LlD/QmfG/MGn7WouvbrXjBsyKrzbaIa
 SX9J94Ho4hjK99p35B+UnX+5jfhsLA4s14uRF5viLeDgdxUAXOPZzSTLjIxg==
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
Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
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
index 995526620d678cd05020315f771213e4a6943bec..0989aee3dd2cf9bc3405c3b25a595c22e6f06387 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
@@ -772,13 +772,13 @@ static int a6xx_hfi_send_core_fw_start(struct a6xx_gmu *gmu)
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


