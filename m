Return-Path: <linux-kernel+bounces-422502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DD59D9A62
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8182816587C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE28F1D63C6;
	Tue, 26 Nov 2024 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iEMo2MWz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E35E1D45E5;
	Tue, 26 Nov 2024 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732634694; cv=none; b=UG1qBVK9n/hSMofXm3DOfGfU9KGSorvyAtiLHLO30dLcEWeNd2dfDTvHKHPqyPgUvj5gAobnJdG/jb44S8B15kQ/jj7LU/4sJNg2ZSstKpcdRoqQDKbXvGR3BPeA8jkUJn4jGXt6+sQmqr5UjjgZ5Ph8hbHz3l8hyhhTg91zQ8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732634694; c=relaxed/simple;
	bh=m8JifkIcWKn2vScoQAglbez3I2ckcKkP5Tw545MTy3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QiaPEq3GvIO+8ZOpcWDh2wLrKCv9tebKDjTPiCaiyEAMn4CtL9w2ySv0sqwhT7B3OClOIDQLaEx4fx8bpYwKRWyMSSbfSzmtXZoJEXGgvlP2Fu52wsvtji01uZSJ78+afstHegHHi0z2ZJ1rNCSKY/MtlEAFicEBiMHZT6xz+Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iEMo2MWz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQEteBo009477;
	Tue, 26 Nov 2024 15:24:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/1cZnQT68TGHVierbrKfkfuNZesBX//u5csAVytjwqQ=; b=iEMo2MWz5aOUwmva
	95lAnjY5+9nYXFQduIRGGOjcliMhkeKYrAzbUqY6tMwI1ANGJzQbFjKAwGon+ws3
	f1HnosXLMCvMu9r4t0Mtk+MNfRJ6MwArhA0w4NiEUCpwr7AwdkK3PlZn1t8vPkWj
	TQJ1YaIPJHxGYJ2t7Gmo3YbQtBX4BmtHUs19VVyDKSTTMOzNs6pQEAQdXT2WAybs
	C3m1IQMqX4chw9ygc179PDhJPWcII8zfOKXUUWHVQEJvqJOhSfmUwL4Ui2Rnegfh
	swU7XQuoB/tTPQWNDgV0TjH08BdypENzIgOwfYTvx8vaKjyj9vGTgohS7FTTiIJo
	HGKXeg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 435gha82ep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 15:24:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AQFOZMg030262
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 15:24:35 GMT
Received: from [10.216.49.153] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 26 Nov
 2024 07:24:29 -0800
Message-ID: <56b6f58e-e100-4dfd-b764-a9c3f5aad887@quicinc.com>
Date: Tue, 26 Nov 2024 20:54:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: display/msm: gpu: Document A612 GPU
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        "Abhinav
 Kumar" <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20241126-qcs615-gpu-dt-v1-0-a87782976dad@quicinc.com>
 <20241126-qcs615-gpu-dt-v1-1-a87782976dad@quicinc.com>
 <680a9f92-1d29-410b-bc63-a998d2d64e9e@kernel.org>
Content-Language: en-US
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <680a9f92-1d29-410b-bc63-a998d2d64e9e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1dm9BEiApSTMSpTxBBdyVG4XYFulg3k1
X-Proofpoint-GUID: 1dm9BEiApSTMSpTxBBdyVG4XYFulg3k1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411260124

On 11/26/2024 7:42 PM, Krzysztof Kozlowski wrote:
> On 26/11/2024 15:06, Akhil P Oommen wrote:
>> A612 GPU requires an additional smmu_vote clock. Update the bindings to
>> reflect this.
>>
>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>> ---
>>  .../devicetree/bindings/display/msm/gpu.yaml       | 28 ++++++++++++----------
>>  1 file changed, 16 insertions(+), 12 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
>> index 6ddc72fd85b04537ea270754a897b4e7eb269641..201150d3151b55c26c95832d36f4e02f66060a25 100644
>> --- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
>> @@ -187,6 +187,7 @@ allOf:
>>              enum:
>>                - qcom,adreno-610.0
>>                - qcom,adreno-619.1
>> +              - qcom,adreno-612.0
> 
> Keep things ordered.

Ack.

> 
>>      then:
>>        properties:
>>          clocks:
>> @@ -195,18 +196,21 @@ allOf:
>>  
>>          clock-names:
>>            items:
>> -            - const: core
>> -              description: GPU Core clock
>> -            - const: iface
>> -              description: GPU Interface clock
>> -            - const: mem_iface
>> -              description: GPU Memory Interface clock
>> -            - const: alt_mem_iface
>> -              description: GPU Alternative Memory Interface clock
>> -            - const: gmu
>> -              description: CX GMU clock
>> -            - const: xo
>> -              description: GPUCC clocksource clock
>> +            anyOf:
> 
> No, this makes everything total mess. Why xo now is allowed to be first
> clock?
> 
> Drop and explain in commit msg why other devices now get smmu clock.

I thought it was okay to make this list a bit flexible. Btw, the other
existing clock-names list for a5x and older gpus uses "anyOf".

I suppose the suggestion is to add a separate clock-names list for A612
with strict ordering. Is that correct?

-Akhil

> 
> BTW, I am pretty sure this breaks existing platforms.
> 
> Best regards,
> Krzysztof


