Return-Path: <linux-kernel+bounces-436967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24139E8D37
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85050280FEF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BBB21518F;
	Mon,  9 Dec 2024 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kFhDhNvc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FF221517C;
	Mon,  9 Dec 2024 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733732423; cv=none; b=dZAERZ8C1q/+GPLX40aOkMTB6XZ3CBrX2evbIIT2NAwizthtslTOrcNcPTr4ZmHXU6dENA9Krkwf19GNcP1K5RkPbtTVVD3T+v11gWEyC4TP3+fyOQ6lw/4qOhFa9YJjPXOkILfgRZeZY29i6/AXw/EnNkYbAI7UUSshWuOMwSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733732423; c=relaxed/simple;
	bh=lHuPWHa/efQT1BNZFlGjszR58NyERmLq8SkocIwsOP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=I/gaq/TrLZ32t/5NlH/XKa/oGMaZF7+q92AIxN3ZU0eyAs7OeyXjFeuvmm2sxBVdPialuEIUP+PEIZJllCfjQRTUaqa3CXU0mDEe+GIytVOf4MJbvJrieLZ+5PqAOKL1+fW+4511sp/Kuyqpy+En9pS/6/5z358Es7HvspZ6gro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kFhDhNvc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8NRkM9007232;
	Mon, 9 Dec 2024 08:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=sdNWNVryJQx5h8jYbXCmZe
	/MFgrUPGTmXDFDkbVAL6o=; b=kFhDhNvcVH9SXoGgyWUIvutdu7sYWza4wSDSTM
	qf6cHUgc80RYdyRr9I69MdBEiH7UM0BM8Aj2F4fy0WoBkPev+4Ve/kdKj4qLcD02
	6OO3HzvfvkbuEIGB2QKOcLiWKrl8ChLK3hNJ1RMsv31TuWvWeQSlWCzj/fcvbNhR
	vYUH+7ZHmZ/OeBEtz9DT3cHosnh00bB0N6bK7LLpavvbQhngZCpfq7OukVp5SN3R
	YIN4O23L8gNZIZxgT3gZCpFNZHVfFRjwA0OZztH8L4FmFC03/PHwqPEcQmfoPKNY
	WR/4BUtyhePtp3Is0dUMPZ4PHbz4+67mSqt/9YuUzmOBqqSg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cek1uuj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 08:20:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B98K6m6010277
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 08:20:06 GMT
Received: from [10.213.111.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 9 Dec 2024
 00:20:02 -0800
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
Date: Mon, 9 Dec 2024 13:49:15 +0530
Subject: [PATCH] drm/msm/a6xx: Skip gpu secure fw load in EL2 mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241209-drm-msm-kvm-support-v1-1-1c983a8a8087@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAAKoVmcC/32OwQ6CMBBEf4Xs2TVsg6Cc/A/DAdtVGtMW20Iwh
 H+3QLx6nEnevJkhsNccoM5m8DzqoJ1NgQ4ZyK61T0atUgaRi4JI5Ki8QRMMvkaDYeh75yNKVXJ
 ZFYVkVUIie88PPW2rt2bPnt9DGo97Cfc2MEpnjI519pu0PEVcRUiEeQEr2ukQnf9s/0ba2L9XR
 kJCQdVZsZDVSV2uySu1lcdkg2ZZli9ALLLJ8wAAAA==
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        "Konrad
 Dybcio" <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>,
        Elliot Berman <quic_eberman@quicinc.com>,
        "Pavan
 Kondeti" <quic_pkondeti@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Akhil P Oommen
	<quic_akhilpo@quicinc.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733732402; l=4603;
 i=quic_akhilpo@quicinc.com; s=20240726; h=from:subject:message-id;
 bh=lHuPWHa/efQT1BNZFlGjszR58NyERmLq8SkocIwsOP4=;
 b=uijuPtexS6QSDML4UKcSB3E9bXi4aONbzEzVfNZqP2oJwoHkvem7wi2HIfpJBkMe0jz5bDsiy
 HTfbLBTrF+pAYdb84cYLUYrxH59U/aLRq9URRB4n2z899kpiIc/C2Zy
X-Developer-Key: i=quic_akhilpo@quicinc.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: t7ty5QztJhS1rH1mryfB75g24t2twoGK
X-Proofpoint-ORIG-GUID: t7ty5QztJhS1rH1mryfB75g24t2twoGK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 adultscore=0 clxscore=1011 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090063

When kernel is booted in EL2, SECVID registers are accessible to the
KMD. So we can use that to switch GPU's secure mode to avoid dependency
on Zap firmware. Also, we can't load a secure firmware without a
hypervisor that supports it.

Tested following configurations on sa8775p chipset (Adreno 663 gpu):

1. Gunyah (No KVM) - Loads zap shader based on DT
2. KVM in VHE - Skips zap shader load and programs SECVID register
3. KVM in nVHE - Loads zap shader based on DT
4. Kernel in EL2 with CONFIG_KVM=n - Skips zap shader load and
	programs SECVID register

For (1) and (3) configuration, this patch doesn't have any impact.
Driver loads secure firmware based on other existing hints.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
---
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 82 +++++++++++++++++++++++------------
 1 file changed, 54 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 019610341df1..9dcaa8472430 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -14,6 +14,10 @@
 #include <linux/pm_domain.h>
 #include <linux/soc/qcom/llcc-qcom.h>
 
+#ifdef CONFIG_ARM64
+#include <asm/virt.h>
+#endif
+
 #define GPU_PAS_ID 13
 
 static inline bool _a6xx_check_idle(struct msm_gpu *gpu)
@@ -998,6 +1002,54 @@ static int a6xx_zap_shader_init(struct msm_gpu *gpu)
 	return ret;
 }
 
+static int a6xx_switch_secure_mode(struct msm_gpu *gpu)
+{
+	int ret;
+
+#ifdef CONFIG_ARM64
+	/*
+	 * We can access SECVID_TRUST_CNTL register when kernel is booted in EL2 mode. So, use it
+	 * to switch the secure mode to avoid the dependency on zap shader.
+	 */
+	if (is_kernel_in_hyp_mode())
+		goto direct_switch;
+#endif
+
+	/*
+	 * Try to load a zap shader into the secure world. If successful
+	 * we can use the CP to switch out of secure mode. If not then we
+	 * have no resource but to try to switch ourselves out manually. If we
+	 * guessed wrong then access to the RBBM_SECVID_TRUST_CNTL register will
+	 * be blocked and a permissions violation will soon follow.
+	 */
+	ret = a6xx_zap_shader_init(gpu);
+	if (ret == -ENODEV) {
+		/*
+		 * This device does not use zap shader (but print a warning
+		 * just in case someone got their dt wrong.. hopefully they
+		 * have a debug UART to realize the error of their ways...
+		 * if you mess this up you are about to crash horribly)
+		 */
+		dev_warn_once(gpu->dev->dev,
+			"Zap shader not enabled - using SECVID_TRUST_CNTL instead\n");
+		goto direct_switch;
+	} else if (ret)
+		return ret;
+
+	OUT_PKT7(gpu->rb[0], CP_SET_SECURE_MODE, 1);
+	OUT_RING(gpu->rb[0], 0x00000000);
+
+	a6xx_flush(gpu, gpu->rb[0]);
+	if (!a6xx_idle(gpu, gpu->rb[0]))
+		return -EINVAL;
+
+	return 0;
+
+direct_switch:
+	gpu_write(gpu, REG_A6XX_RBBM_SECVID_TRUST_CNTL, 0x0);
+	return 0;
+}
+
 #define A6XX_INT_MASK (A6XX_RBBM_INT_0_MASK_CP_AHB_ERROR | \
 		       A6XX_RBBM_INT_0_MASK_RBBM_ATB_ASYNCFIFO_OVERFLOW | \
 		       A6XX_RBBM_INT_0_MASK_CP_HW_ERROR | \
@@ -1341,35 +1393,9 @@ static int hw_init(struct msm_gpu *gpu)
 	if (ret)
 		goto out;
 
-	/*
-	 * Try to load a zap shader into the secure world. If successful
-	 * we can use the CP to switch out of secure mode. If not then we
-	 * have no resource but to try to switch ourselves out manually. If we
-	 * guessed wrong then access to the RBBM_SECVID_TRUST_CNTL register will
-	 * be blocked and a permissions violation will soon follow.
-	 */
-	ret = a6xx_zap_shader_init(gpu);
-	if (!ret) {
-		OUT_PKT7(gpu->rb[0], CP_SET_SECURE_MODE, 1);
-		OUT_RING(gpu->rb[0], 0x00000000);
-
-		a6xx_flush(gpu, gpu->rb[0]);
-		if (!a6xx_idle(gpu, gpu->rb[0]))
-			return -EINVAL;
-	} else if (ret == -ENODEV) {
-		/*
-		 * This device does not use zap shader (but print a warning
-		 * just in case someone got their dt wrong.. hopefully they
-		 * have a debug UART to realize the error of their ways...
-		 * if you mess this up you are about to crash horribly)
-		 */
-		dev_warn_once(gpu->dev->dev,
-			"Zap shader not enabled - using SECVID_TRUST_CNTL instead\n");
-		gpu_write(gpu, REG_A6XX_RBBM_SECVID_TRUST_CNTL, 0x0);
-		ret = 0;
-	} else {
+	ret = a6xx_switch_secure_mode(gpu);
+	if (!ret)
 		return ret;
-	}
 
 out:
 	if (adreno_has_gmu_wrapper(adreno_gpu))

---
base-commit: f4a867a46862c1743501bbe8c813238456ec8699
change-id: 20241120-drm-msm-kvm-support-cd6e6744ced6

Best regards,
-- 
Akhil P Oommen <quic_akhilpo@quicinc.com>


