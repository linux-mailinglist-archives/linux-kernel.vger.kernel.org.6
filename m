Return-Path: <linux-kernel+bounces-312355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61192969568
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85C1E1C231DE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA3D1D6C77;
	Tue,  3 Sep 2024 07:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ibtFUNFZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1071D6C61;
	Tue,  3 Sep 2024 07:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348543; cv=none; b=YrbRSR6N+n91kfW/dj/LUCn5qN1DT45t6YEDG7wkDh9J3X1akKLMRB5/axIPwWbOaVOGRGFxv3FyiRpdjge22iGCCJ+WcZ8E1gcK6ui4DFGOgnkJJN4LnmUdX/sPZELb6VbM5s/ZMLSprzg3nvzbtHNcBo85nzMTbuLJd5RKmU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348543; c=relaxed/simple;
	bh=yTo/8EwDOr8YArIADqD64idxFMEmF+kyRoYrx3NxGCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Lv8EyPPnBmVcVUm8gIFrzlNZxh919BEOBJbxmtI9opHzvHeHK6pZuROFMeTXjtjrW6hWHD3pT0WgPMQx2fVm9HH15duYOB7gGYk1qjB+lwpzsHfAFKyO+0mFWdgOTpIkue9SoKS7RTE9HCryM4+0J4vPG0bal4TXUI6+gLXq5+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ibtFUNFZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 482NamoZ030904;
	Tue, 3 Sep 2024 07:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IkpCs1nUIGRyUlej5KjWF1AyqtoB7I0xwDRlFtYL48g=; b=ibtFUNFZsxFFUGNb
	y9ZqldmYP8en+hf2Qf5jLWHjWUZ9yD41LPXl/2GxiDELngvPxZoE8uowOq3cKV1k
	ssVXdwvVbUF5zoQ+N1272/AF53vQWuhjmpSyjHzbFyw2hJwo2O8LJ/LQ7XebKMeo
	z4zbVRRAcWXxFdEaxw7gPK51huzVqKHY05qNjDiEqxQNUXUF0pqDKTZ+OuDYo/lX
	aHPyqsoNIft1hHjNFXEBbYspnmXjVSjrmvMRYgiUeXIQ9lYimnoYTDAZts8JYwyj
	yrryvIIS1MDyfPCbGcrObsY6dfcE7fjiJcb5rrf26RYs+yNAOOb0kxSiGcX8xz8w
	eC8cAg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41bvf8xewb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 07:28:58 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4837SwxC014185
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Sep 2024 07:28:58 GMT
Received: from [10.233.21.53] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Sep 2024
 00:28:55 -0700
Message-ID: <cb68781f-7127-47fb-88b2-a99766e16cd6@quicinc.com>
Date: Tue, 3 Sep 2024 15:28:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] soc: qcom: llcc: add errata to get bank num
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Conor Dooley <conor@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240903-qcs8300_llcc_driver-v1-0-228659bdf067@quicinc.com>
 <20240903-qcs8300_llcc_driver-v1-3-228659bdf067@quicinc.com>
 <vtj5liux4hrb7je3ojnfyixor6sk2oy2p4nlvt2rgnzisjj773@ckyl7a2kpa62>
 <407fc8ff-8058-4ab4-a822-7a5e47e5b301@quicinc.com>
 <6c846a47-8192-4c6c-927b-8969485d49aa@kernel.org>
Content-Language: en-US
From: Jingyi Wang <quic_jingyw@quicinc.com>
In-Reply-To: <6c846a47-8192-4c6c-927b-8969485d49aa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1jTJ_xkiypB2vVyN2mBBO5ZsaUX4eEbO
X-Proofpoint-ORIG-GUID: 1jTJ_xkiypB2vVyN2mBBO5ZsaUX4eEbO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_06,2024-09-02_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409030058



On 9/3/2024 3:19 PM, Krzysztof Kozlowski wrote:
> On 03/09/2024 09:17, Jingyi Wang wrote:
>>
>>
>> On 9/3/2024 3:13 PM, Krzysztof Kozlowski wrote:
>>> On Tue, Sep 03, 2024 at 02:21:31PM +0800, Jingyi Wang wrote:
>>>> Use "num-banks" property to indicate the actual num of banks for
>>>> errata.
>>>>
>>>> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
>>>> ---
>>>>  drivers/soc/qcom/llcc-qcom.c | 15 ++++++++++-----
>>>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
>>>> index 8fa4ffd3a9b5..3fb45e625d82 100644
>>>> --- a/drivers/soc/qcom/llcc-qcom.c
>>>> +++ b/drivers/soc/qcom/llcc-qcom.c
>>>> @@ -1275,12 +1275,17 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>>>>  		goto err;
>>>>  	cfg = &cfgs->llcc_config[cfg_index];
>>>>  
>>>> -	ret = regmap_read(regmap, cfg->reg_offset[LLCC_COMMON_STATUS0], &num_banks);
>>>> -	if (ret)
>>>> -		goto err;
>>>> +	if (unlikely(!of_property_read_u32(dev->of_node, "num-banks", &num_banks))) {
>>>
>>> Drop unlikely.
>>>
>>>> +		/* errata: get num of llcc banks. */
>>>
>>> Huh? What?
>>>
>>>> +	} else {
>>>> +		ret = regmap_read(regmap, cfg->reg_offset[LLCC_COMMON_STATUS0], &num_banks);
>>>> +		if (ret)
>>>> +			goto err;
>>>
>>> Sorry, but what? You can read it from hardware, but you add DT property?
>>> No, that's just wrong. Why commit msg explains nothing about reasons and
>>> problem you are solving?
>>>
>> we need the property because there is hardware errata on this SoC, regmap_read get wrong num.
> 
> That's what compatible is for.
> 
> Anyway, you did not explain the problem but just send some code. All
> your patches in this and all future submissions must explain why you are
> doing this. What you are fixing, why you are introducing something.
> 
Sure, thanks for remind.
> Best regards,
> Krzysztof
> 
Thanks,
Jingyi


