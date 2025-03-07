Return-Path: <linux-kernel+bounces-552067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764DBA574EF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1EC4178321
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447841E505;
	Fri,  7 Mar 2025 22:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lGGTuGf1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A306E1A8F97
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 22:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741386658; cv=none; b=K8Q++ii6ybtTVvwHhhS1fSBdsAiM6WhT4YntDX2xt2KOj00WcqZBWOXLbKNjoj6lcOfTdvGlBGq/1hnpQgIW2FmbahFJeT30bdK9bGZICDyga5uJ8ntpCfnNTv5y6iW71OefnvLQXpn8kCbvzTgJAsN9UCHSzqEuy3h2DvoKrvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741386658; c=relaxed/simple;
	bh=bCNAocCazVKoVFzq/ND5cjZiWr84ZC7bmNadsW1yn9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0LE/aO8qSzj3fog1PDasf1SMYwgjbm7OHt4vcRRbeS8rlHezGukY7x0bzzjUpY6HM8YHcmXBhdPJwzVV8QGE/tEHXAZzPYIjQr8n5mCPzZFgvzzfFN6xCn5iw96uMZKB8llo6L4H4kr6Kzg/0jlOUJVxfc1DyrI7vzrEbn700c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lGGTuGf1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527EEnWi031962
	for <linux-kernel@vger.kernel.org>; Fri, 7 Mar 2025 22:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ak5fxQibEzWrpDH5Ilc3caDZL5F6Fyf98J8EyekNGds=; b=lGGTuGf1QBsFhqug
	y+AEq/fVLBCpxKJm3ESO4Rvq2CZtwXrkJuhtDQdP0pG5sS8ajLzMcRwILll9t9yg
	YoSWcjftY1G5rPqvIyCFWFVmHWwAq2GQXewt+gwjSrtKe03ehTw7LGxnw+YOzhV5
	DpDYXs4DaTqJH8EJPqbzUvsTWsNVxgt2uy+L2REzy9LZhdYN5W+o/42CcKxuRBX/
	1CIMD98qNhDLmvwELoICplAHgIIc8XEGTrUkBPPD/yyrynfAw2jIKwoaUd0b9AP7
	ZaelTsOEIe8u8wG9VI60tKaeb+cqTJktAZDh5E7GbF1CegKbFe7cbhvr5iLmovMO
	KsRB6g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 457aghmth5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 22:30:48 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e8f3c21043so5620716d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 14:30:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741386647; x=1741991447;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ak5fxQibEzWrpDH5Ilc3caDZL5F6Fyf98J8EyekNGds=;
        b=v9KBg1FfH2pRueyd6R8fK+Ur7/O+uouG8T2OmmFFku4XOgC8ngtILyExiyPmT9/IaZ
         y6JIlJeazsBK9ojg6ToZcDdCLrweFgOAvTN3rK5I6CX4yWHYmPprLtMHEVxF6V4iIFwo
         AWWZNj2xJoRX+BzyWnlP7LzfkAWKGSlac63xf6ZQ/cLwVuu1J3dGC3wfz5Wr0P45RksN
         XdzGVosj9khrTh3feSKR3yD0tqUxwQJwow7mFMXZoRSitcrEMizWIM+X0dP55bF2yvYX
         YWOSfqJVsX1fj6GwciCkTsWJ3pVnSEAdgKsBoT0xrStWEFHCc2VJxT6jkfpgSORbR3xq
         pE4g==
X-Forwarded-Encrypted: i=1; AJvYcCWHhM5letMe6g0MGlbdpJ32iglA4oX2T1OKjp44ZtNxmQJenvO+jQqd9OBCDvDSXNOS3nyj4YfgS+mfRCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWqQ7CcVVOs+ComsXvM1zbVac/tVgwU1vZiGFq+4YBg5luXeVd
	T1cJSqDngW+xxXEClR1VenDAdkOC2yo6eFFztK0DXx/wIeYuwRlzIv56YuIRhvXNPecDQH3yQu1
	5KxN8IKcM16ek953SPgrkS4B0xNSraGEkqvoOdf26FaHfFTm7179HaNsmdQPGQ0k=
X-Gm-Gg: ASbGnctFjDpV/QNe1W7CiSjiFI99Xs0SHEf2peB9alFFu+nWrsbfULgpOHwlOL1RBWj
	V7IX57WS1GQq5a8cXbmjziJ2dBN+ptU5lgYQGjIJJkRla4du1ZmRElVhrKpLQojSQR/7l9KwP0L
	0A+exjVLTQjc67Aq1vY+CO8Pmp1JO2YiiC23Zd/K8OQxwpymDA/4zz1LI/iChEvmV9mJoIw/NSQ
	BYbzZmZIf0fFI8CZ6mZj1m4CNzw0AdHc5pg7QzKKGojL/I3S/BnwfRRr1gWlNeMCJARCgteoy+o
	rJAKOxrsZldJvAictknNz9k7L7oxRMGwFqeGw2/nh4SsX3ERBfaBKYD1mwFChcD4rRAskg==
X-Received: by 2002:a05:6214:ac1:b0:6e8:f645:2639 with SMTP id 6a1803df08f44-6e908cd150fmr4825226d6.5.1741386647148;
        Fri, 07 Mar 2025 14:30:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiC4koxcJVdaUrklQtVOopVLiy0hknFp7oOAgVhzdT3gbIZwIK648n2T72jt6jEmVlQvFqKQ==
X-Received: by 2002:a05:6214:ac1:b0:6e8:f645:2639 with SMTP id 6a1803df08f44-6e908cd150fmr4824846d6.5.1741386646742;
        Fri, 07 Mar 2025 14:30:46 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c74a6af7sm3083132a12.33.2025.03.07.14.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 14:30:46 -0800 (PST)
Message-ID: <d0d6feb9-e89d-49c3-8569-91591eae6161@oss.qualcomm.com>
Date: Fri, 7 Mar 2025 23:30:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] dt-bindings: power: qcom,kpss-acc-v2: Add MSM8916
 compatible
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Robert Foss <rfoss@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Kyle Deng <quic_chunkaid@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-usb@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250306-topic-dt_bindings_fixups-v1-0-0c84aceb0ef9@oss.qualcomm.com>
 <20250306-topic-dt_bindings_fixups-v1-3-0c84aceb0ef9@oss.qualcomm.com>
 <Z8rTW3fQObiZ7del@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <Z8rTW3fQObiZ7del@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: eKXJnHpDxTm1pXPYn8T2mnkoIx5Pee6J
X-Authority-Analysis: v=2.4 cv=R5D5GcRX c=1 sm=1 tr=0 ts=67cb7398 cx=c_pps a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=2aLQLXHzPMxx44zPxJMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: eKXJnHpDxTm1pXPYn8T2mnkoIx5Pee6J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503070170

On 7.03.2025 12:07 PM, Stephan Gerhold wrote:
> On Thu, Mar 06, 2025 at 07:11:15PM +0100, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> MSM8916 seems to reuse the same hardware as MSM8974 and friends (for
>> whom this binding document was created). Add a new compatible for it.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> ---
>>  Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml b/Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml
>> index 202a5d51ee88c7190805efe8f1bf493bdb69ec45..27dae49163fa0790ceb6fda8a5c674f739d4a41a 100644
>> --- a/Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml
>> +++ b/Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml
>> @@ -18,7 +18,9 @@ description:
>>  
>>  properties:
>>    compatible:
>> -    const: qcom,kpss-acc-v2
>> +    enum:
>> +      - qcom,msm8916-kpss-acc
> 
> Hm, MSM8916 doesn't have a *K*PSS (Krait Processor SubSystem), it has an
> *A*PSS (ARM Cortex – A53 SubSystem, or Application Processor SubSystem).

You would think that, but actually it's still called KPSS internally..

> 
> I think this should be either qcom,msm8916-apss-acc, or you just keep
> the qcom,msm8916-acc we already use. I'm guessing ACC stands for
> "Application Clock Controller", so it would be unique enough already.
> 
> There is actually a patch from Rayyan already with a R-b from Krzysztof.
> Maybe you, or whoever is responsible, can pick it up?
> 
> https://lore.kernel.org/linux-arm-msm/20240710155226.130086-1-rayyan.ansari@linaro.org/

I'm not opposed to this either

Looks like Sebastian Reichel and/or Ulf pick up power dt-bindings patches

Konrad

