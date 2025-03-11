Return-Path: <linux-kernel+bounces-555526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D5AA5B915
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6713E3B034B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 06:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAA61EE035;
	Tue, 11 Mar 2025 06:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o8xoj3wR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DA820B22;
	Tue, 11 Mar 2025 06:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741673813; cv=none; b=kzUJfLT+whQ+8dqWNvbME4fJGEjaa3yTQM89tzXyenJMLekKHPJDy6vClVqtGpxAI6kj3VzUSF4AA32oWOxPXGx3UsDXRarjQqZ3HwfAmuHYnOAJXaK8eX759cf7Ba8HQxPeYny57dL4ig2j2lQQ4C6tCYuz7E040M772+nmYKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741673813; c=relaxed/simple;
	bh=k/5Tg7LyN/7jDuAPLOSqYrB/029fVEk0sO1e1ygKico=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hq4+mvgiJ5MmYnIfENfSw1CYSx6F/9L7hco0AT8YbTnRbt9AgHjHsToxv3ou3Br9dFqjRYuMsHv/TFY3FO/u2u4Te0DoV/JwWAypv+bm+p3BpQHfrrXyaey7NISQYE5WoxD4M1viP0f1IdsqrXUDGuogad/g6z8qLWs9+/Bx+24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o8xoj3wR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AKjhn9006253;
	Tue, 11 Mar 2025 06:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JHbVnjh4q9xB2LzjdS6wKi6kBiBzwQ1KsR99fp+DG5Q=; b=o8xoj3wRXkNGjHkd
	m17NVXxJSmYebZ39uddwWFBFVLv7GC8TDVZ4ywuP/QbdtAM/LhcfsnLwgG6o8nz6
	q4WtbRL9Jk9sPWwaUD+MdjKYce7WWHI0cult3UNBokRIGpZZXXS9WLH66+bvEHfA
	yzdj7JWelO/OVKAiAoj0DblS6AzrWWKyRmT9D0db5LopDLxn3iVdAzoRi/Pj7fYm
	kIo0Y1nNj8RJSLXvuHWWL1c6Vi43k/AGtlhSEWw/+XIv3jB5j0po6hRTE/e0Ud5R
	AiPdvZmH942Qe0YOvsjCPtZoNcUCXoGmfL/of5UOVK7lvPDO3NtUJUZT7e0cADAt
	GFjHpA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458f2mf92x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 06:16:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52B6GKfs015925
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 06:16:20 GMT
Received: from [10.216.23.206] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Mar
 2025 23:16:13 -0700
Message-ID: <8d54a612-433e-4860-a843-294fe0d6db4e@quicinc.com>
Date: Tue, 11 Mar 2025 11:46:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Support for Adreno 623 GPU
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, Simona Vetter <simona@ffwll.ch>,
        <linux-kernel@vger.kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        "Abhinav
 Kumar" <quic_abhinavk@quicinc.com>,
        Jie Zhang <quic_jiezh@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        "Thomas
 Zimmermann" <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>, <freedreno@lists.freedesktop.org>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        Sean Paul <sean@poorly.run>,
        "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
        Rob Clark
	<robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "David
 Airlie" <airlied@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        <devicetree@vger.kernel.org>
References: <20250228-a623-gpu-support-v2-0-aea654ecc1d3@quicinc.com>
 <174075232770.2756163.15128447349702656600.robh@kernel.org>
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
Content-Language: en-US
In-Reply-To: <174075232770.2756163.15128447349702656600.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EFmODcM4L_YS48Fyr14FyKTDBWPkoAE0
X-Proofpoint-ORIG-GUID: EFmODcM4L_YS48Fyr14FyKTDBWPkoAE0
X-Authority-Analysis: v=2.4 cv=ab+bnQot c=1 sm=1 tr=0 ts=67cfd535 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=gEfo2CItAAAA:8
 a=Qi1LLK4JJPgfJq4B5soA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 mlxscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110040

On 2/28/2025 7:53 PM, Rob Herring (Arm) wrote:
> 
> On Fri, 28 Feb 2025 01:37:48 +0530, Akhil P Oommen wrote:
>> This series adds support for A623 GPU found in QCS8300 chipsets. This
>> GPU IP is very similar to A621 GPU, except for the UBWC configuration
>> and the GMU firmware.
>>
>> Both DT patches are for Bjorn and rest of the patches for Rob Clark to
>> pick up.
>>
>> ---
>> Changes in v2:
>> - Fix hwcg config (Konrad)
>> - Split gpucc reg list patch (Rob)
>> - Rebase on msm-next tip
>> - Link to v1: https://lore.kernel.org/r/20250213-a623-gpu-support-v1-0-993c65c39fd2@quicinc.com
>>
>> ---
>> Jie Zhang (6):
>>       drm/msm/a6xx: Split out gpucc register block
>>       drm/msm/a6xx: Fix gpucc register block for A621
>>       drm/msm/a6xx: Add support for Adreno 623
>>       dt-bindings: display/msm/gmu: Add Adreno 623 GMU
>>       arm64: dts: qcom: qcs8300: Add gpu and gmu nodes
>>       arm64: dts: qcom: qcs8300-ride: Enable Adreno 623 GPU
>>
>>  .../devicetree/bindings/display/msm/gmu.yaml       |  1 +
>>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts          |  8 ++
>>  arch/arm64/boot/dts/qcom/qcs8300.dtsi              | 93 ++++++++++++++++++++++
>>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c          | 29 +++++++
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |  8 ++
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c        | 13 ++-
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h        | 17 ++++
>>  drivers/gpu/drm/msm/adreno/adreno_gpu.h            |  5 ++
>>  8 files changed, 171 insertions(+), 3 deletions(-)
>> ---
>> base-commit: 89839e69f6154feecd79bd01171375225b0296e9
>> change-id: 20250213-a623-gpu-support-f6698603fb85
>> prerequisite-change-id: 20250131-b4-branch-gfx-smmu-b03261963064:v5
>> prerequisite-patch-id: f8fd1a2020c940e595e58a8bd3c55d00d3d87271
>> prerequisite-patch-id: 08a0540f75b0f95fd2018b38c9ed5c6f96433b4d
>>
>> Best regards,
>> --
>> Akhil P Oommen <quic_akhilpo@quicinc.com>
>>
>>
>>
> 
> 
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>   pip3 install dtschema --upgrade
> 
> 
> New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/qcom/' for 20250228-a623-gpu-support-v2-0-aea654ecc1d3@quicinc.com:
> 
> arch/arm64/boot/dts/qcom/qcs8300-ride.dtb: iommu@3da0000: clock-names:0: 'gcc_gpu_memnoc_gfx_clk' was expected
> 	from schema $id: http://devicetree.org/schemas/iommu/arm,smmu.yaml#
> arch/arm64/boot/dts/qcom/qcs8300-ride.dtb: iommu@3da0000: clock-names:1: 'gcc_gpu_snoc_dvm_gfx_clk' was expected
> 	from schema $id: http://devicetree.org/schemas/iommu/arm,smmu.yaml#
> arch/arm64/boot/dts/qcom/qcs8300-ride.dtb: iommu@3da0000: clock-names:2: 'gpu_cc_ahb_clk' was expected
> 	from schema $id: http://devicetree.org/schemas/iommu/arm,smmu.yaml#
> arch/arm64/boot/dts/qcom/qcs8300-ride.dtb: iommu@3da0000: clock-names:3: 'gpu_cc_hlos1_vote_gpu_smmu_clk' was expected
> 	from schema $id: http://devicetree.org/schemas/iommu/arm,smmu.yaml#
> arch/arm64/boot/dts/qcom/qcs8300-ride.dtb: iommu@3da0000: clock-names:4: 'gpu_cc_cx_gmu_clk' was expected
> 	from schema $id: http://devicetree.org/schemas/iommu/arm,smmu.yaml#
> arch/arm64/boot/dts/qcom/qcs8300-ride.dtb: iommu@3da0000: clock-names:5: 'gpu_cc_hub_cx_int_clk' was expected
> 	from schema $id: http://devicetree.org/schemas/iommu/arm,smmu.yaml#
> 
> 
> 
> 
> 

These warnings are for the smmu dt change which I marked as a
dependency. Hopefully, the v6 revision from Pratyush will fix this.

https://lore.kernel.org/linux-arm-kernel/20250310-b4-branch-gfx-smmu-v6-1-15c60b8abd99@quicinc.com/T/

-Akhil.

