Return-Path: <linux-kernel+bounces-351510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0B2991255
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 00:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5760E2814A5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890621AA78A;
	Fri,  4 Oct 2024 22:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pRateUr3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA2C231C9F;
	Fri,  4 Oct 2024 22:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728081063; cv=none; b=k76RAVDLiOAyU/wSFKKYrfI+M+2DCVz3N2N/MVwiNNGLCoFzfKYOtrINOnvQJC+CMkOneOZyMuDwP5aRfXlHNwXaPnswzn4LpDyEcSGR1tuHHB61OyZfcN0hs13mqLR/TSzCl5fzRNe+XJUPGGOpd3e4PnoXGehH2eS1YEUCQEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728081063; c=relaxed/simple;
	bh=BgRwyliACBnT66ihhfVej0/HJsEABY7aPb6zx0dkdzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=txb4jmR/toAHTFsBAaA/W15S5GMlN2VvVQ3f/vBvMYm2bpmVIUykAcF19VYvYaRqptOEsdyKDXFR6SKPdBju7V0YHKmIL6LTu7mf7Iq06WFUNgotgbnDprC6tsKaNUPl6QLUTK4rNeluYfVcU6mZXPnQgSGIL13Y8u2JaNp1GH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pRateUr3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494BE9gJ017372;
	Fri, 4 Oct 2024 22:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sIIFuxFWnisemmQkJjj2CElTPnR87/XsEZKsQqMKHYE=; b=pRateUr3FzKlWwuC
	tE24QdeNG8KNlFFF1cpvsNNohbWvyXTmQ8mJLBhjJxnPzbdOdCUS2B4bKj8pRx/A
	p8x3I5Gu0ic5cCIFlsGYP/d6117YnyGLqB+d7M0mQwtjzK8Ap77k9UnEAmrLkjJ/
	6b1op8maOP5rBd/HDG0+FlxAe3jON1t/Cc3bTNQE5S8RNYeNeEhtGzacM2/dWTaO
	LrxXg3kQ1NYJEh6vLN08iw2pRQOXF7TIwaCEybAPplGn+Cpgk4FfP/XNFYW0OsFO
	lw7n+nMdEFUJifOOLKvapjuem+eMDGN+foUww2wtlPOdM4ZNuiyPFdKYurw6FCPm
	Y1sr8A==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42205n3dfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 22:30:51 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 494MUo84032475
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 4 Oct 2024 22:30:50 GMT
Received: from [10.134.70.212] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 4 Oct 2024
 15:30:49 -0700
Message-ID: <cf68b09e-ab3a-4e69-a7b8-7edddcf1c6c4@quicinc.com>
Date: Fri, 4 Oct 2024 15:30:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 1/2] firmware: qcom: scm: Introduce
 CP_SMMU_APERTURE_ID
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark
	<robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar
	<quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>
References: <20241002-adreno-smmu-aparture-v1-0-e9a63c9ccef5@oss.qualcomm.com>
 <20241002-adreno-smmu-aparture-v1-1-e9a63c9ccef5@oss.qualcomm.com>
Content-Language: en-US
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20241002-adreno-smmu-aparture-v1-1-e9a63c9ccef5@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oXV_PNUTAXeIC2-E6GxWx06NisMh6erQ
X-Proofpoint-GUID: oXV_PNUTAXeIC2-E6GxWx06NisMh6erQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 clxscore=1011 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410040155



On 10/2/2024 8:01 PM, Bjorn Andersson wrote:
> The QCOM_SCM_SVC_MP service provides QCOM_SCM_MP_CP_SMMU_APERTURE_ID,
> which is used to trigger the mapping of register banks into the SMMU
> context for per-processes page tables to function (in case this isn't
> statically setup by firmware).
> 
> This is necessary on e.g. QCS6490 Rb3Gen2, in order to avoid "CP | AHB
> bus error"-errors from the GPU.
> 
> Introduce a function to allow the msm driver to invoke this call.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

Hi Bjorn,

Tested-by: Jessica Zhang <quic_jesszhan@quicinc.com> # Trogdor (sc7180)

Thanks,

Jessica Zhang

> ---
>   drivers/firmware/qcom/qcom_scm.c       | 19 +++++++++++++++++++
>   drivers/firmware/qcom/qcom_scm.h       |  1 +
>   include/linux/firmware/qcom/qcom_scm.h |  1 +
>   3 files changed, 21 insertions(+)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 10986cb11ec0..bd633c57b6e8 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -903,6 +903,25 @@ int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare)
>   }
>   EXPORT_SYMBOL_GPL(qcom_scm_restore_sec_cfg);
>   
> +#define QCOM_SCM_CP_APERTURE_CONTEXT_MASK	GENMASK(7, 0)
> +
> +int qcom_scm_set_gpu_smmu_aperture(unsigned int context_bank)
> +{
> +	struct qcom_scm_desc desc = {
> +		.svc = QCOM_SCM_SVC_MP,
> +		.cmd = QCOM_SCM_MP_CP_SMMU_APERTURE_ID,
> +		.arginfo = QCOM_SCM_ARGS(4),
> +		.args[0] = 0xffff0000 | FIELD_PREP(QCOM_SCM_CP_APERTURE_CONTEXT_MASK, context_bank),
> +		.args[1] = 0xffffffff,
> +		.args[2] = 0xffffffff,
> +		.args[3] = 0xffffffff,
> +		.owner = ARM_SMCCC_OWNER_SIP
> +	};
> +
> +	return qcom_scm_call(__scm->dev, &desc, NULL);
> +}
> +EXPORT_SYMBOL_GPL(qcom_scm_set_gpu_smmu_aperture);
> +
>   int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size)
>   {
>   	struct qcom_scm_desc desc = {
> diff --git a/drivers/firmware/qcom/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
> index 685b8f59e7a6..e36b2f67607f 100644
> --- a/drivers/firmware/qcom/qcom_scm.h
> +++ b/drivers/firmware/qcom/qcom_scm.h
> @@ -116,6 +116,7 @@ struct qcom_tzmem_pool *qcom_scm_get_tzmem_pool(void);
>   #define QCOM_SCM_MP_IOMMU_SET_CP_POOL_SIZE	0x05
>   #define QCOM_SCM_MP_VIDEO_VAR			0x08
>   #define QCOM_SCM_MP_ASSIGN			0x16
> +#define QCOM_SCM_MP_CP_SMMU_APERTURE_ID		0x1b
>   #define QCOM_SCM_MP_SHM_BRIDGE_ENABLE		0x1c
>   #define QCOM_SCM_MP_SHM_BRIDGE_DELETE		0x1d
>   #define QCOM_SCM_MP_SHM_BRIDGE_CREATE		0x1e
> diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
> index 9f14976399ab..23ec8ee5e49f 100644
> --- a/include/linux/firmware/qcom/qcom_scm.h
> +++ b/include/linux/firmware/qcom/qcom_scm.h
> @@ -85,6 +85,7 @@ int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
>   
>   bool qcom_scm_restore_sec_cfg_available(void);
>   int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare);
> +int qcom_scm_set_gpu_smmu_aperture(unsigned int context_bank);
>   int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size);
>   int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare);
>   int qcom_scm_iommu_set_cp_pool_size(u32 spare, u32 size);
> 
> -- 
> 2.45.2
> 
> 


