Return-Path: <linux-kernel+bounces-537307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BAAA48A47
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71606167E2E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467E1270ECE;
	Thu, 27 Feb 2025 21:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="afzf1GLU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357391A9B2A;
	Thu, 27 Feb 2025 21:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740690384; cv=none; b=eIpADjDvQsuusl8oYa1ctBeM1UgzN4jqCpj85cKignhMSVSHAS7Xwil/5dzLDTG65P+ehEs8a/eaNJp5kMwaTwAx5/NQ53Vh2mY+ymr0/ESgB+ZJSKS0StWEu26DuAR9/PEaSZqwrTd9xhvYjMeFwRjg4BSdKcMScXf98514pmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740690384; c=relaxed/simple;
	bh=bQRi42c2RSM54L+PtQ11q6/NGm4XcMphsjwmG8OVu9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GRWmPFQAzbNplXU7VQP70VVS7pCNJb64IPXcZU0HRFzPtqv85beE9i3a6THFu8eQqfym+01LUuvtbMc9AdwqUYAeAaVHUHgqjTcZ5oj7Vz34kFKgsEHmZSIxlQwv5oaVyiF1QDQbudAigabjfHKSlyNEnizHgwlYGcozwMH0aHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=afzf1GLU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RHbaAv021572;
	Thu, 27 Feb 2025 21:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xp8r7xVTNLz6gIIBagVTZCE7iak/1YtBJviVPDrIPik=; b=afzf1GLU80JoXqMM
	IT2rKo8TRC8klki+sT3t3O0hUlWT/gompWELVY7ciA9RPCvzGAzDdPnciB+3zood
	xx1xA3Z/dZhBU5foU6jAYdyRA9b+gqJx7VgMawTlOUVd49TKqA57F4eFnztLWm8f
	LGBz8S3iT1bjsoNMbNqoPUtgJygcdTYx4WR+gb8zktdxMBYOt7J8ELm+vyqgqnev
	osCvdNSBvEXyBoDiqPVlwxkyhGz+eSdh69DMueiTtQIrfLD9N70I+wsb1hTCE4r8
	mD4UKtTdP8S6A+APHqMvDIJ8NY791R6nXLkTKlS+afEUSgPZU+u9rZ1sOoLYtFF7
	RKWXAw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prkq5e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 21:06:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51RL69n9000792
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 21:06:09 GMT
Received: from [10.216.6.99] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 27 Feb
 2025 13:06:02 -0800
Message-ID: <70c7f4fc-137c-442a-b65e-3743d7b1b736@quicinc.com>
Date: Fri, 28 Feb 2025 02:36:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] drm/msm/a6xx: Add support for Adreno 623
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Clark
	<robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        "Dmitry
 Baryshkov" <dmitry.baryshkov@linaro.org>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Jie Zhang <quic_jiezh@quicinc.com>
References: <20250228-a623-gpu-support-v2-0-aea654ecc1d3@quicinc.com>
 <20250228-a623-gpu-support-v2-3-aea654ecc1d3@quicinc.com>
 <7ffcc2fc-c783-49de-b01f-9ffb442d2a72@oss.qualcomm.com>
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
Content-Language: en-US
In-Reply-To: <7ffcc2fc-c783-49de-b01f-9ffb442d2a72@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qUVV1JpdLL07SgH1sjVUP9BMHblkP7zX
X-Proofpoint-ORIG-GUID: qUVV1JpdLL07SgH1sjVUP9BMHblkP7zX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_07,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270156

On 2/28/2025 1:59 AM, Konrad Dybcio wrote:
> On 27.02.2025 9:07 PM, Akhil P Oommen wrote:
>> From: Jie Zhang <quic_jiezh@quicinc.com>
>>
>> Add support for Adreno 623 GPU found in QCS8300 chipsets.
>>
>> Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>> ---
>>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c   | 29 +++++++++++++++++++++++++++++
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c       |  8 ++++++++
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c |  2 +-
>>  drivers/gpu/drm/msm/adreno/adreno_gpu.h     |  5 +++++
>>  4 files changed, 43 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> index edffb7737a97b268bb2986d557969e651988a344..53e2ff4406d8f0afe474aaafbf0e459ef8f4577d 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> @@ -879,6 +879,35 @@ static const struct adreno_info a6xx_gpus[] = {
>>  			{ 0, 0 },
>>  			{ 137, 1 },
>>  		),
>> +	}, {
>> +		.chip_ids = ADRENO_CHIP_IDS(0x06020300),
>> +		.family = ADRENO_6XX_GEN3,
>> +		.fw = {
>> +			[ADRENO_FW_SQE] = "a650_sqe.fw",
>> +			[ADRENO_FW_GMU] = "a623_gmu.bin",
>> +		},
>> +		.gmem = SZ_512K,
>> +		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
>> +		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
>> +			ADRENO_QUIRK_HAS_HW_APRIV,
>> +		.init = a6xx_gpu_init,
>> +		.a6xx = &(const struct a6xx_info) {
>> +			.hwcg = a690_hwcg,
> 
> You used the a620 table before, I'm assuming a690 is correct after all?

Correct. a690_hwcg array has the recommended values for a623.

-Akhil.

> 
> Konrad


