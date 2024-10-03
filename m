Return-Path: <linux-kernel+bounces-348524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EDA98E897
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 04:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE5A51F25FAF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 02:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7EC45028;
	Thu,  3 Oct 2024 02:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="chqIecEm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF954086A
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 02:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727924328; cv=none; b=iOEu6ZEBgEG687OeYPcxenZzSBwzEioncVD3CV92rEFpQxSuNWqZCuhiJiTMJ3YFJa2Rv+rp46nBql8dclWevpLCpHn2xeIa6SuFHjNXhYlr/2OVZlDr9eATHFcfy7Myvq2YnLm8bDEvQK2wbv3zMJOmpGIUKePGkzNJ0HKQ308=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727924328; c=relaxed/simple;
	bh=RbbsTxcQGy55FkTg6CEEGqhEsl4ZzuLrgtjdk4G2IrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q1WanocrhDjEt6z8/rksiM/UbIqm8qoL9kEnRKqD3V8VlUa/gOs1joSRb1aVj1+IMPuM4m+TGrBg5NNP3IQhyv3mpeumwbtX3K0VyVo2fNIkCUa6niimr8lC9sPEWteXOwbyUwuqTZvOBx/S2q2rlVDt6rN0HYb2H7lQZVatlf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=chqIecEm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4932ngQs020801
	for <linux-kernel@vger.kernel.org>; Thu, 3 Oct 2024 02:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lbSF7jHlkaR5xovzGmMq56CCaUsco0zxxJXKbsOr+IA=; b=chqIecEmoTfYtV0m
	QD2D7AQld6dNmElt92FjUtUicC4xVeyuLxdSvc5Qa0o04ya0z6IHj72I1D6BnDta
	uPeO8Mvr8v/kTAsbHxnsJvKuL2K82XtKfJStXa2ubMracmbqDvNQybxdE2mYv+0o
	2Tb5SdWcy4Oy3nBu56FFcbjy00qlWl7uDDZZcBTt++6QAxW5LmBIHeb/yHYfU87j
	9eltgaVKlZ3MjbUdkYmb9VIby3jEyP8bWXI7yI4idPd1IVaR4u4OrDc/WuDB9bnq
	gOHjPykszITyMWvjI4+lx6QPHrJzegQniPDNqbsOZb+3JZsuxfuo0R+sJ+c9+PPM
	l1DsdQ==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41xa67d6un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 02:58:45 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-287433009bcso397844fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 19:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727924325; x=1728529125;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbSF7jHlkaR5xovzGmMq56CCaUsco0zxxJXKbsOr+IA=;
        b=UGgzCmGHzvjveJBUPngbgq9y0I/htMYkruBIVSXFRWNsizihnhpDnYUa2FZ9nuV8sI
         qJMoGze521AGQm56T4Fvv5/NzFUb7YN7se0UY0EX5BT1rvo8VDUFe0GVKvKE/8cbs3a/
         vtMAxi43HZqK2EiT3VUQ7g062NgvtwIgF3fbBB3DVsJHPhb2g4AJtRVjJMmiy6NZSWqj
         H0ojaBVgm9oTdp9Wna3NOmVvNuYZeKBYANVQ6DAUrpDvM0u5Sl2m6fMdwPX6c4uSYlvJ
         WDH0CqSTb8f1WJx1tX53y8UyeGg5FeScHUUWOBu7XJ3Xp7v7mfDSp6Vn3VfUV22+cRf5
         lD7w==
X-Forwarded-Encrypted: i=1; AJvYcCUlspxKTiRbA54XjrnTIRP1K2GqXat5rzrtLp1Q2UKEAJeyDkYPn05grKI1L8uluQibD0FIvZAVZfH/7Wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM38//d8dKmV8X9QH/NwopBPDbRSNuvH2C2nBRIlRu9m4b6VCe
	o54Zak2Vx9mfgJ8bdS6gVAcpNtjWBmu1W/Pm65O4oSI7VeMoC8PTpZMm3xCeeA8KeYGxMX5S62C
	Vjo8OlsZvr09cvNuDKggfYJNcVIxig7Hyn9nhB+EnH9OUn2ntajyAYHB/9uVdZtqUNS1vHyj72z
	RNYTNT/FfDBIc=
X-Received: by 2002:a05:687c:2c5b:b0:277:e457:6057 with SMTP id 586e51a60fabf-28788f4bf55mr3371443fac.44.1727924325200;
        Wed, 02 Oct 2024 19:58:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEslbkkscbIupCM6YFAHuYU1JfX4Afm5uZdwnidaEUekyOLhEtI1qq/CLEky2lu9R/N3g9GLw==
X-Received: by 2002:a05:687c:2c5b:b0:277:e457:6057 with SMTP id 586e51a60fabf-28788f4bf55mr3371438fac.44.1727924324832;
        Wed, 02 Oct 2024 19:58:44 -0700 (PDT)
Received: from [192.168.86.60] (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-287ab9b5ba5sm188924fac.21.2024.10.02.19.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 19:58:42 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Wed, 02 Oct 2024 20:01:33 -0700
Subject: [PATCH RFT 2/2] drm/msm/adreno: Setup SMMU aparture for
 per-process page table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-adreno-smmu-aparture-v1-2-e9a63c9ccef5@oss.qualcomm.com>
References: <20241002-adreno-smmu-aparture-v1-0-e9a63c9ccef5@oss.qualcomm.com>
In-Reply-To: <20241002-adreno-smmu-aparture-v1-0-e9a63c9ccef5@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1479;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=RbbsTxcQGy55FkTg6CEEGqhEsl4ZzuLrgtjdk4G2IrI=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBm/gkcRg/Y5KGivcfdeSGJkvp8pEtdIW6yxbLxG
 8GyBcQb6reJAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCZv4JHBUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcU03xAAqZOMzqIPiya3Ppbf4OVcDQbOrlD+YmTj9ARqMJl
 fYzVwMmwWNYPOAL7IzqyLt8+Ax+FTDtwopgfXtmY87dN/6NsEpuC7sG1XVkRdtxbvrvsWqWEPCr
 nokcf7lY5sVDWtQxdcMhl8TOUIe6at+MnDcbj9uSZ3qK9JiSWXYFzn5syFwz7QiABmjbNmkuZgN
 PNRzH+OLh/yeHP5AkDyDJqbVvTNAipzqXk6yAOV8yIY1WYPmH9MzEuXoJh3p05b4qbTADTJ3zWO
 G1ONmA2aHwvyRkP6YmkaAPCTFH/Uh1oEqEw7/4ftfOfisQazJBKDkWNEQ/Q3s6q+smhuVfLk+gd
 Cdy/38noYbMPzaf16k2OQ6i7mzYtCpFXEhtrjRjohB5XQyr0DzcSGMU4mygHExtHlAviGZb9dyV
 4ybtfVIs+WVWveOTj4jFtGHrwp5rVJucX+kJcTJjb+kHeAVgsIHXbx4AcXibmaOiwo1gAtV6h+Z
 2LZoM56C4i+TduAvtGXMiL9pH0xb7fA/EiudQa71FHLgEtxsGMZhL2Wz9mau/hUk2aA4c44UwAR
 DiFA7c5r3qzTUm8N15/BjRKy6bKkippQs+yNh19CRolZP7MBnRAHSGPl0uOLaRmdgtKJaBB7nJT
 uMqxT+jhPd/UfBEjL0Q3Z1Xudz9zz4pq/I3kQ5CLwXb0=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Proofpoint-GUID: NTcTQMDjjpaATiqfZ0E1XUC4ay54aFIH
X-Proofpoint-ORIG-GUID: NTcTQMDjjpaATiqfZ0E1XUC4ay54aFIH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410030019

Support for per-process page tables requires the SMMU aparture to be
setup such that the GPU can make updates with the SMMU. On some targets
this is done statically in firmware, on others it's expected to be
requested in runtime by the driver, through a SCM call.

One place where configuration is expected to be done dynamically is the
QCS6490 rb3gen2.

The downstream driver does this unconditioanlly on any A6xx and newer,
so follow suite and make the call.

Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 465a4cd14a43..5b06f7a04fe6 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -572,8 +572,18 @@ struct drm_gem_object *adreno_fw_create_bo(struct msm_gpu *gpu,
 
 int adreno_hw_init(struct msm_gpu *gpu)
 {
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	int ret;
+
 	VERB("%s", gpu->name);
 
+	if (adreno_gpu->info->family >= ADRENO_6XX_GEN1) {
+		/* We currently always use context bank 0, so hard code this */
+		ret = qcom_scm_set_gpu_smmu_aperture(0);
+		if (ret)
+			DRM_DEV_ERROR(gpu->dev->dev, "unable to set SMMU aperture: %d\n", ret);
+	}
+
 	for (int i = 0; i < gpu->nr_rings; i++) {
 		struct msm_ringbuffer *ring = gpu->rb[i];
 

-- 
2.45.2


