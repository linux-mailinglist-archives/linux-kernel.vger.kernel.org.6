Return-Path: <linux-kernel+bounces-234746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD7E91CA58
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 03:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 795C8B22859
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 01:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BB911720;
	Sat, 29 Jun 2024 01:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MM89ZgeP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D4C5684;
	Sat, 29 Jun 2024 01:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719626079; cv=none; b=uOQdPtIhRsDEkAzwv3aky2cv/2CDhn45nqzzgodx3roy8pKJlSI2K6RVjxmQA45Uln+Vmr3MsqvCjiSdgZ3LGXXGSVAQb2czK8gCiX/AmP6b1ap68cHYUyyBVyMxwuzM72AwewKC/x4MkDP6jdnqz6DzdsqMG80JF6JTo+jbfwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719626079; c=relaxed/simple;
	bh=hBL6o3IZoX4iQunkZSwUA3XsMrf6zf6UfNsn3pLIQFw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jNak8Nf4canuOgjRMkZj1EjiyQ5zjNC+SqM5CC5B6wqc4HQWpIVznEASFoEjDusA5RS+qtGTu6o33OW3SB62Tuj92kc2GRTFVeTGSO2h6fvELJAixRfC6h2KT95thYhCBK9apoa3Iakg0S3Q3qS1g7IkiALSrX/Vfgo8QWDGQzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MM89ZgeP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45SHX0tF002602;
	Sat, 29 Jun 2024 01:54:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4AumC6Xhp5HCc5Tva93ziu8w3pHmtGSQwexR2QIhkxs=; b=MM89ZgeP7BLQEVP3
	xcuWMRBSPPWYvMAszx4z0YD0VnfkWvbNDZktKJFDZzX4odaQnOJA6JYYX3HaDmVx
	Ml9A+06uRZo1Sk8KwQ9byLG7yyri1I/UfkAT4QWqxKb6G+kKwULfkIPgAEMlOTwk
	fabQs3wmoWtE3tnjASXkFk7IhxYslJFHMyaHPT9pVZ6/sIwg8oVXBjllcTE4Na0m
	h7jllgVIqy74gaTLve+IKfJ9BmLmgBFpwmWMEuALH0VU1oFC4Y06tAHdQ5ZZtvD8
	jFijv63TkkcPtgCpJN/Dbex5nwTY9Sk0I+UcI3OOO6F2vyB2BWTHrVD4r6FS42HF
	Mbu+mA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 401ubvt9c1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 01:54:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45T1sGYI001520
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 01:54:16 GMT
Received: from hu-akhilpo-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 28 Jun 2024 18:54:11 -0700
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
To: freedreno <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        "OPEN
 FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Will
 Deacon" <will@kernel.org>
CC: Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Abhinav Kumar
	<quic_abhinavk@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>, David Airlie
	<airlied@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        "Sean
 Paul" <sean@poorly.run>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/5] drm/msm/adreno: Add support for X185 GPU
Date: Sat, 29 Jun 2024 07:19:35 +0530
Message-ID: <20240629015111.264564-3-quic_akhilpo@quicinc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240629015111.264564-1-quic_akhilpo@quicinc.com>
References: <20240629015111.264564-1-quic_akhilpo@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mF-JdbtrznITkUAHQWyqv-aq94MCPazF
X-Proofpoint-GUID: mF-JdbtrznITkUAHQWyqv-aq94MCPazF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_18,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406290013

Add support in drm/msm driver for the Adreno X185 gpu found in
Snapdragon X1 Elite chipset.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
---

Changes in v2:
- Increased address space size (Rob)
- Introduced gmu_chipid in a6xx_info (Rob)
- Improved fallback logic for gmxc (Dmitry)

 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 18 ++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c     | 13 +++++++++++--
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c     |  2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.h   |  5 +++++
 5 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 53e33ff78411..c507681648ac 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1208,6 +1208,24 @@ static const struct adreno_info a7xx_gpus[] = {
 			.protect = &a730_protect,
 		},
 		.address_space_size = SZ_16G,
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x43050c01), /* "C512v2" */
+		.family = ADRENO_7XX_GEN2,
+		.fw = {
+			[ADRENO_FW_SQE] = "gen70500_sqe.fw",
+			[ADRENO_FW_GMU] = "gen70500_gmu.bin",
+		},
+		.gmem = 3 * SZ_1M,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
+			  ADRENO_QUIRK_HAS_HW_APRIV,
+		.init = a6xx_gpu_init,
+		.a6xx = &(const struct a6xx_info) {
+			.hwcg = a740_hwcg,
+			.protect = &a730_protect,
+			.gmu_chipid = 0x7050001,
+		},
+		.address_space_size = SZ_256G,
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x43051401), /* "C520v2" */
 		.family = ADRENO_7XX_GEN3,
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 0e3dfd4c2bc8..20034aa2fad8 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -769,6 +769,7 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
 {
 	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	const struct a6xx_info *a6xx_info = adreno_gpu->info->a6xx;
 	u32 fence_range_lower, fence_range_upper;
 	u32 chipid, chipid_min = 0;
 	int ret;
@@ -830,8 +831,10 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
 	 */
 	gmu_write(gmu, REG_A6XX_GMU_CM3_CFG, 0x4052);
 
+	if (a6xx_info->gmu_chipid) {
+		chipid = a6xx_info->gmu_chipid;
 	/* NOTE: A730 may also fall in this if-condition with a future GMU fw update. */
-	if (adreno_is_a7xx(adreno_gpu) && !adreno_is_a730(adreno_gpu)) {
+	} else if (adreno_is_a7xx(adreno_gpu) && !adreno_is_a730(adreno_gpu)) {
 		/* A7xx GPUs have obfuscated chip IDs. Use constant maj = 7 */
 		chipid = FIELD_PREP(GENMASK(31, 24), 0x7);
 
@@ -1329,7 +1332,13 @@ static int a6xx_gmu_rpmh_arc_votes_init(struct device *dev, u32 *votes,
 	if (!pri_count)
 		return -EINVAL;
 
-	sec = cmd_db_read_aux_data("mx.lvl", &sec_count);
+	/*
+	 * Some targets have a separate gfx mxc rail. So try to read that first and then fall back
+	 * to regular mx rail if it is missing
+	 */
+	sec = cmd_db_read_aux_data("gmxc.lvl", &sec_count);
+	if (IS_ERR(sec) && sec != ERR_PTR(-EPROBE_DEFER))
+		sec = cmd_db_read_aux_data("mx.lvl", &sec_count);
 	if (IS_ERR(sec))
 		return PTR_ERR(sec);
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index c98cdb1e9326..092e0a1dd612 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1031,7 +1031,7 @@ static int hw_init(struct msm_gpu *gpu)
 	gpu_write(gpu, REG_A6XX_UCHE_CLIENT_PF, BIT(7) | 0x1);
 
 	/* Set weights for bicubic filtering */
-	if (adreno_is_a650_family(adreno_gpu)) {
+	if (adreno_is_a650_family(adreno_gpu) || adreno_is_x185(adreno_gpu)) {
 		gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_0, 0);
 		gpu_write(gpu, REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE_1,
 			0x3fe05ff4);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 1c3cc6df70fe..e3e5c53ae8af 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -21,6 +21,7 @@ extern bool hang_debug;
 struct a6xx_info {
 	const struct adreno_reglist *hwcg;
 	const struct adreno_protect *protect;
+	u32 gmu_chipid;
 };
 
 struct a6xx_gpu {
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index cff8ce541d2c..e1c69bb022d6 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -474,6 +474,11 @@ static inline int adreno_is_a750(struct adreno_gpu *gpu)
 	return gpu->info->chip_ids[0] == 0x43051401;
 }
 
+static inline int adreno_is_x185(struct adreno_gpu *gpu)
+{
+	return gpu->info->chip_ids[0] == 0x43050c01;
+}
+
 static inline int adreno_is_a740_family(struct adreno_gpu *gpu)
 {
 	if (WARN_ON_ONCE(!gpu->info))
-- 
2.45.1


