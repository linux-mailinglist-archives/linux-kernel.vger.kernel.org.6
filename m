Return-Path: <linux-kernel+bounces-533037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 855DAA45509
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB213A8A4E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 05:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD3D192B9D;
	Wed, 26 Feb 2025 05:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nCIuF1oV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A17E26772E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 05:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740548950; cv=none; b=Miy1nhE20FI+fHjfOUt2jv0RUBBCx/Ze86ogt8MTl7H8a7m+lth0g9zKme1s0VlOl5OMfWHPPbJAu+J70nA+zqBFZBwZw+Un4RVmQsLpSLhY4zU8zQvG3GMCu5Fss6fylOT5A1po9Fus++i+uYgopPy4msX9g8jc8lMtmcuh4/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740548950; c=relaxed/simple;
	bh=lj5C8vmbWvP75MTRwx25cJ5finZ0HpaXCJopKaRNLMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hc+Ohzi30tE4RKe2iX1pr50KWNCR4h4aw+hHl7D1o6UdyaVjERQzsJWULWWxMpjlL0snl6AebbBq6Y7q2JJXfcGNjQeRgHf1RwTG+jwyKaAGsvN0GfPUpVLbf8AGNyXRsrBFga1vJuOy0pEFVoBSeLfV/2fhPliD3hI2mXK6J5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nCIuF1oV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PMWo50011791
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 05:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TPXgoKAyXg++2ImpcGgZeoHfq9cDp+zIaEVLuPVA7N0=; b=nCIuF1oVaaMYGa+y
	VJzgw6R0tFj7uY9EpJ6j+To3FrYpYYQmnxFpgDE31o1P67EjVTZhNf0UWHYRu9p2
	OD12+KPcaTo76iLyvr3A5zlK50ZnD4H3Ew/UP1rHlbTf1SbkiFc7cb42EorpriYi
	IDCIcNLz8tjuG7/+IUpK0ztX4zjlqKi9xtRj0exyQUq4qdsmfY77WYm479VaKxLS
	9f0OlY3t7l2PxTTPifkha9qzdJV1UA6OGTGCvHb88la9qgDjk0Fn/BzgAresqQql
	Ma8OvGuVrmUkDWS43b42M28TBh7gm0AjN463dNTMR7+XdUYGFBTfHqmIZeHcjqex
	MyTbDg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prk8vg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 05:49:07 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22119b07d52so83156565ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:49:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740548946; x=1741153746;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPXgoKAyXg++2ImpcGgZeoHfq9cDp+zIaEVLuPVA7N0=;
        b=oV2vrXh2Bi1X3OyiM/FyqudcqZtO1oHPt4DsRjZsVh2q237mKDO5SKl6wcAPDkht5T
         dQxubrzVIZE6ecFx2r4PNuVk3EJRGvyX0pMNB+TvIphpgOJMZ2Rcdo2uJlZzxKmxiQjC
         425ohtMSmUfobNBcGW/I9u4+AyY0Qw7diEmy/AEb0ztnigG610eGzod4i53ywHjk8vXi
         Pzhw7Ojhtn3hPQ9FeV4WvR6RRFCE0mOPJBScyAjv+Z8xCeLxMalagb5H91BiUky9zfjN
         OniHIuwqqjZMFcNAkjBCOV/GscSIobzA2wuD87X1RDtz14TkhXNgw9wpcmQPQDWJmUD3
         g4+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMalkMATO4HnF8p2cFTPXf1TZzJOzZVdcNVK008EvpqMjbvWuPJhRQqOAnZfmf4LHWxVEPEnZNtaH1Q/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx21POwZWDiQ0YxxMfz3FLxrqfqya3swOp8OHzk6bLD5nu1JwJH
	0tb5Gmvsc1w5f8RqwO2ycxiYqz7gtO86PdOugc6oFYqlYJjAQTuADobU7mWLrUQGtsKxodyWHNS
	kIF4bcSynGZj5MKg7kGbU0GX57gh08UIf7CHlU1Vhes+4TfCiHeQTcYJhqx3kJ1M=
X-Gm-Gg: ASbGnctTrwApClh3+ygxDDZlfbi2NYmJJ9e3C1/Nd6d2AGpAgbcV30iX2qKxckB7jhf
	ii9LUiyL7v1V5pg2p1IO0CldtyvFAtXmIRgSytTV5loqmzgUc/iMTOfzGsBtmt9otvbN5/n/eMm
	6LFNqlhRRCNF8G7upm55NscPrWZsxlP0AK23jzg1v1+GBqSvDSVBDuSs5QCKsbmC3ONGO2KGeuI
	k1sa6YGoFQ5hxwT9mprU8sBhJcKkYTyu/7V7J2UT6YxdSEhR0tqYR4AB/lKLhdzfMq5cKwsfuiu
	m6kpiVG1Pq4ahya0iQ8bChQKX/pBOygM1KIMleBW
X-Received: by 2002:a17:903:8c5:b0:215:8d49:e2a7 with SMTP id d9443c01a7336-22307e72899mr92674735ad.50.1740548946578;
        Tue, 25 Feb 2025 21:49:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPdfACxvty1eZQAAd+waUgWYZ9BRzhl4tvSNkf5vmOOGGL1MjuycVG4/ok6It6VJv1qusXfw==
X-Received: by 2002:a17:903:8c5:b0:215:8d49:e2a7 with SMTP id d9443c01a7336-22307e72899mr92674525ad.50.1740548946222;
        Tue, 25 Feb 2025 21:49:06 -0800 (PST)
Received: from [10.217.199.21] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0a639dsm24128625ad.203.2025.02.25.21.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 21:49:05 -0800 (PST)
Message-ID: <1b1e6e6a-84ee-4884-826b-f092ab5f3cf3@oss.qualcomm.com>
Date: Wed, 26 Feb 2025 11:18:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8750: Fix cluster hierarchy for idle
 states
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_lsrao@quicinc.com
References: <20250218-sm8750_cluster_idle-v1-1-5529df00f642@oss.qualcomm.com>
 <638f05f4-3a0e-459d-aec0-b925ca7f657c@oss.qualcomm.com>
Content-Language: en-US
From: "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>
In-Reply-To: <638f05f4-3a0e-459d-aec0-b925ca7f657c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3a3ql4bT0db8RztIja2qyssTifMABthd
X-Proofpoint-ORIG-GUID: 3a3ql4bT0db8RztIja2qyssTifMABthd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=872 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260044



On 2/22/2025 1:21 AM, Konrad Dybcio wrote:
> On 18.02.2025 7:58 AM, Maulik Shah wrote:
>> SM8750 have two different clusters. cluster0 have CPU 0-5 as child and
>> cluster1 have CPU 6-7 as child. Each cluster requires its own idle state
>> and power domain in order to achieve complete domain sleep state.
>>
>> However only single cluster idle state is added mapping CPU 0-7 to the
>> same power domain. Fix this by correctly mapping each CPU to respective
>> cluster power domain and add domain idle state for cluster1.
>>
>> Fixes: 068c3d3c83be ("arm64: dts: qcom: Add base SM8750 dtsi")
>> Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/sm8750.dtsi | 36 +++++++++++++++++++++++++-----------
>>  1 file changed, 25 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
>> index 3bbd7d18598ee0a3a0d5130c03a3166e1fc14d82..3af928be5b68b47988dd55f4add8e3712f07d5ab 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
>> @@ -178,7 +178,15 @@ cluster1_c4: cpu-sleep-1 {
>>  		};
>>  
>>  		domain-idle-states {
>> -			cluster_cl5: cluster-sleep-0 {
>> +			cluster0_cl5: cluster-sleep-0 {
>> +				compatible = "domain-idle-state";
>> +				arm,psci-suspend-param = <0x01000054>;
>> +				entry-latency-us = <2150>;
>> +				exit-latency-us = <1983>;
>> +				min-residency-us = <9144>;
>> +			};
> 
> I don't think this is necessary, you should be gtg with just creating the
> new power domain for cluster 0/1 and pointing both to the same cluster idle
> state (unless they both need different latency numbers
> 

Sure, I will address this in v2.

Thanks,
Maulik

> Konrad

