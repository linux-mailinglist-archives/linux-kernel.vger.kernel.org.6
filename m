Return-Path: <linux-kernel+bounces-348523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D65D298E895
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 04:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C67C1F23BC4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 02:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD46199B9;
	Thu,  3 Oct 2024 02:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LgUhfv4L"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE9026AD0
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 02:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727924325; cv=none; b=ZrSeckcHL9zUxxl6dLhxPG4KBv8kuUy/fFRji0QlyrT9eibn6+/AXpynugMkDN9t9MUQmSoq6zUIV/ZZfQqc9Im4I8YTMAsUaVShViwHUvJxlif72r1mRC3I9l/0FDhyYtcAA5wBF28GiuVo/iL764z3Tpa/oJvj3aSeuJBoI5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727924325; c=relaxed/simple;
	bh=ECeOnqwkL9oJWvy2IoxkgjFotjTcF/KXI8WgJ2j6Ppk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=abP/5g/RpUiG8H37g0O1QvNhan7BUUvGZvCNJLRqykyFSpu/QyurzJETGM7J3eUC6kjGo7TA+oWxjx3GR7JbhaSfkFnBtHmzi7NzTJrRTD/lDDbcrpyYAV/5zb9Tc9T02L0+OIziYiFGNIW4pnKgu9f3zjwhSz88XLCCQrIeNyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LgUhfv4L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4932nhXA002382
	for <linux-kernel@vger.kernel.org>; Thu, 3 Oct 2024 02:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uB3ZxPTHnAWMaOklWPn7Q1NGeCixNFs2bRfPkU5N7Mc=; b=LgUhfv4LVewn+8bo
	dx8BfyMbjC81Otuq7Q8YxyCl7xKISjwzBH5oEBxc5oY7opOWy70qUIqaZdWY19g0
	y9ttpAWqzKa6BrHXTQAOuNBHJ+69Fmfjvq3jyxu3o0UDwhNnPqzrTt/iz4Kk/EAg
	49rbUuFCoCPeuPiHmyAAI52uR4ZNIE9UR0v8Ko69F9R56zWATMOEHVRUThKX8Kib
	mASfJUYdYFzk7+Rimj1bm24jF0ofeMpE8jpKijCMPZRp2IwXtzPXgOSMHtnwr+sj
	iNxMscIjXOnORIT41K3XsP0KBg9q/KQfEQzaKygrBC1082niU5G6vXChgQKejGEJ
	d8hR+w==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41x94hn7d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 02:58:42 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-2871adf05aeso733776fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 19:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727924322; x=1728529122;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uB3ZxPTHnAWMaOklWPn7Q1NGeCixNFs2bRfPkU5N7Mc=;
        b=cwsqNIRq3El0K1pGvSug5EgsgKj3tgetKBMN3y0Dtuf3z8JvlajMrytLQgq/MXbx9l
         16Dc90SOh3gWOu8Cd83ejTmrCh2irZBtfd+ljCMsgt/fzFAIqnNj9QgGTtlrDmSuMwOz
         SwuPLJZsaZlfatYjGrCixjrBiEnMGbxTUpU6X304ZNZ4IQj/BKKeWufZnUTm7i/P9wqA
         2s5Tb58sYVJw778zYOZly2a7wYsSMr6Fh626K9z/rQ22ty2zMLY3DUk9N5z1UepftNku
         5SoLIaTEnKkelCPCKuQEJBKyiTwKTuTYhTr8lmUVknPdMIUz4Pu56cW+y5RjmX58RpWs
         kgCw==
X-Forwarded-Encrypted: i=1; AJvYcCX1eEzEhbMy4x5VcmkchWG6QmfeAt+mwAzD3KwLMPdezM8W082/gHRW9tH9V8zpWzYT4Z4d6HOM3N5T1Pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmANtzAec+RSS8YMbp8uF0YtIKfv229DYquaQVR8JYZvlYS+EA
	fwQumZRnxRKeySLL8qtZFtmT5+HL1MuAlIXK2JodI+Y1x4LkYwul4eQG9NqhtQJNMhZ0n/NCAnW
	g68063jAY4xH6Ozc41QxJO21PitvRUUdsnKvFcUik5S0HIRjIbElmPVpYVGqAMms5CuaeCVRgiy
	vcvksBpvtQZyo=
X-Received: by 2002:a05:6871:8a6:b0:254:affe:5a05 with SMTP id 586e51a60fabf-28788c46d29mr3849541fac.21.1727924321825;
        Wed, 02 Oct 2024 19:58:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoRavS3UfpeB3yFBG10czruBQKvndSIjPg0YTRGNfVBE8+yBK/nh/+1v+zCglyQ9P7PQ7tmQ==
X-Received: by 2002:a05:6871:8a6:b0:254:affe:5a05 with SMTP id 586e51a60fabf-28788c46d29mr3849531fac.21.1727924321543;
        Wed, 02 Oct 2024 19:58:41 -0700 (PDT)
Received: from [192.168.86.60] (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-287ab9b5ba5sm188924fac.21.2024.10.02.19.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 19:58:39 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Wed, 02 Oct 2024 20:01:32 -0700
Subject: [PATCH RFT 1/2] firmware: qcom: scm: Introduce CP_SMMU_APERTURE_ID
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-adreno-smmu-aparture-v1-1-e9a63c9ccef5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2997;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=ECeOnqwkL9oJWvy2IoxkgjFotjTcF/KXI8WgJ2j6Ppk=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBm/gkcWIcpdn2/xdWuhuQYvPCj6vFgI+ERHLL5B
 uxSWZReAIaJAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCZv4JHBUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcUMmA//eVBu9B7Ev3OMWmjXNH9MrFelo5hICM0seNCG3VO
 +xJ2dGbDsRl0spsDLFrzU1Zc685JBF2nRUf49/4zzfxNRmatKgP6dl1sLrI7eop/q401e5JyXlI
 ia82MIwlc9RIXwXJ5qRIK7rWHcSo2jx6LebTAnz6DZibrfxKO4w/F8OI6t7N5Mml0gCncndzk3/
 D5C4PHwDkPA82gmRS0RxaC/KU8snVqQVN2PeJ9o6LmqA6jGrYJtAQeqY8c1gBVHitOakiWcSctr
 X4MmOK0eZ/i1XmuSuX3L8c871yghyY6wIW8pxHKzcwOYC49YeKcSSNwZ4KOmMkYBbgBxInZc8Va
 WOBSsObLppy1VnZnWjSaVCOI2E10xJRzwfw/D1lmcHcMWiEsCJ/S0O+HB0Aj6/ZAnfNxZ9GLE/n
 3b5cKMjF5aedpllWqJIPXL4CC6EdZP9iU+Ap9sR62bmmC0FsL62n0W/eslwZetwPWere3fsUSwm
 jf9eVvc013pwtmg4mnkos3G3GNd6EwhjImSmCbFRaMpLH36WFtbszc2LvCnMQ+NTuIusthd8JTn
 wUwgZ/tLBEQxZ8S47AHE4GdJmTBh7N+A7lSuBhSeeVaJbHyWkgaOGIexogqcthZLWqvtKGlf02S
 IR2aCKp0+2A9BHC7dLood5uZVGjvCyQRUwlpn2IuX+V4=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Proofpoint-GUID: 9_PDjWwy9AYDYA6TrUo9MeKFoui1WuhQ
X-Proofpoint-ORIG-GUID: 9_PDjWwy9AYDYA6TrUo9MeKFoui1WuhQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410030018

The QCOM_SCM_SVC_MP service provides QCOM_SCM_MP_CP_SMMU_APERTURE_ID,
which is used to trigger the mapping of register banks into the SMMU
context for per-processes page tables to function (in case this isn't
statically setup by firmware).

This is necessary on e.g. QCS6490 Rb3Gen2, in order to avoid "CP | AHB
bus error"-errors from the GPU.

Introduce a function to allow the msm driver to invoke this call.

Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c       | 19 +++++++++++++++++++
 drivers/firmware/qcom/qcom_scm.h       |  1 +
 include/linux/firmware/qcom/qcom_scm.h |  1 +
 3 files changed, 21 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 10986cb11ec0..bd633c57b6e8 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -903,6 +903,25 @@ int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare)
 }
 EXPORT_SYMBOL_GPL(qcom_scm_restore_sec_cfg);
 
+#define QCOM_SCM_CP_APERTURE_CONTEXT_MASK	GENMASK(7, 0)
+
+int qcom_scm_set_gpu_smmu_aperture(unsigned int context_bank)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_MP,
+		.cmd = QCOM_SCM_MP_CP_SMMU_APERTURE_ID,
+		.arginfo = QCOM_SCM_ARGS(4),
+		.args[0] = 0xffff0000 | FIELD_PREP(QCOM_SCM_CP_APERTURE_CONTEXT_MASK, context_bank),
+		.args[1] = 0xffffffff,
+		.args[2] = 0xffffffff,
+		.args[3] = 0xffffffff,
+		.owner = ARM_SMCCC_OWNER_SIP
+	};
+
+	return qcom_scm_call(__scm->dev, &desc, NULL);
+}
+EXPORT_SYMBOL_GPL(qcom_scm_set_gpu_smmu_aperture);
+
 int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size)
 {
 	struct qcom_scm_desc desc = {
diff --git a/drivers/firmware/qcom/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
index 685b8f59e7a6..e36b2f67607f 100644
--- a/drivers/firmware/qcom/qcom_scm.h
+++ b/drivers/firmware/qcom/qcom_scm.h
@@ -116,6 +116,7 @@ struct qcom_tzmem_pool *qcom_scm_get_tzmem_pool(void);
 #define QCOM_SCM_MP_IOMMU_SET_CP_POOL_SIZE	0x05
 #define QCOM_SCM_MP_VIDEO_VAR			0x08
 #define QCOM_SCM_MP_ASSIGN			0x16
+#define QCOM_SCM_MP_CP_SMMU_APERTURE_ID		0x1b
 #define QCOM_SCM_MP_SHM_BRIDGE_ENABLE		0x1c
 #define QCOM_SCM_MP_SHM_BRIDGE_DELETE		0x1d
 #define QCOM_SCM_MP_SHM_BRIDGE_CREATE		0x1e
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index 9f14976399ab..23ec8ee5e49f 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -85,6 +85,7 @@ int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
 
 bool qcom_scm_restore_sec_cfg_available(void);
 int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare);
+int qcom_scm_set_gpu_smmu_aperture(unsigned int context_bank);
 int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size);
 int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare);
 int qcom_scm_iommu_set_cp_pool_size(u32 spare, u32 size);

-- 
2.45.2


