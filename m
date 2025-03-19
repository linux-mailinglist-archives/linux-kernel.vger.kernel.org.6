Return-Path: <linux-kernel+bounces-568503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E23A6966E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3F919C3754
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5E01F4C97;
	Wed, 19 Mar 2025 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lhCoWHCX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708D918DF93
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 17:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742405332; cv=none; b=Qcg4leSXmWkCh+TLDGmOBRsmlxJX+WnQxm0OsJZ0gSq3tUwg2OPpXQQXetxpDSHkyETuRALhvxl9O6QtA1jchCKSMYj4yddggbseZWMsbri/h2FEgz5DahuCCKu/18NZZBJtlXJ5UsZX1LdoCINMrE2FBGuvJS5Kc47GQWTVD3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742405332; c=relaxed/simple;
	bh=CWK+EArxHVvZhO9jSHqbQevs+LkkMH0t7GTRwoUCTc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XnlvBss4E+NVvsq5ahdMtQcPuuvWCqVtndFoDjOWqUYNgaN7V+y2U6FE1Le+rnA88a0dFIGFXkvvAIc3QoGFxcO5Ndq641Yg4jn6e5PGd6kMAmjwyl9QfDu7fpaEeB5N7PGeekGtw/eFv5iWl7oiM6PU7MIXaJ9gMVbU0U+l0hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lhCoWHCX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JE0IEJ020482
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 17:28:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vdbmtSFf9LsX0Hod50MXJ8Rpn1iGHT3/np5G+JKs7cU=; b=lhCoWHCX7qe+rVwX
	LqmV72JQOzvBnoG3aA8+g2N42668uUZSOLOtRgALRFXBdKuvzlehaeBL87CfUU2R
	9uV/p/CyV9n3uO+k43dNmm7407EQLpHQNDRofDYbfAa68XUJocbik36mmzVKfOLf
	dCz+XQIIBUz9smyQpuu0neKfMGend9fneY5Wie95bq/uYbzWpWqmOZmR3U1l/fuy
	dU2YRsc1lHIGw+Qo08MN3uBZ1uUezWZr3kjrCcPxU9/FcATI890F4qbCatEMrwri
	dcXLSIQ1yhr4BxpgXr+ToFKYV8NFpM43LoqCwljc93jZ20TZ3d8vqSoCgdQAMSEs
	uVi+PQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45fdmwugmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 17:28:50 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e19bfc2025so16360496d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742405329; x=1743010129;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdbmtSFf9LsX0Hod50MXJ8Rpn1iGHT3/np5G+JKs7cU=;
        b=QnuByCEg7BIXr37X6YSGXLD9qzg3GUBf7CRPVQG5sNXGvzVVQNtxRpCNZUC3YxdyyD
         QEqz3c2feocL4mYCeX9RpKkc5IebCWkswC8rxwtJXNp9sop27dXRu2iBU68i7TvbijHz
         coobFXv1B5wVdumfEPYzPzk6AkhtBdV43Pe8sk0ABODPyMMRLR+dBbkdrzqVCxs+gGFN
         dLMCHiR2XnCkdsn4u73wSWFoKohwmyoMdKTmHvBPlAya2igSvEgLh7Oq7Re580aAKeTJ
         FS2ljHdX7dK1qTVlTfZfaCSb5wmZ7WTltbVsKZQRUjomXvAQKBcqCw9QgrtSCIqSyr/C
         tQow==
X-Forwarded-Encrypted: i=1; AJvYcCXW30ChG9+XP1FsgjRSZJMyGnvRGG2TCXuVynlhb9fL6zwadBShIA6DbApEnI2Zg24min6B5OPF3w63JfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK7qJaHrWIcG3c/HRBOPzu4O2R0izpvQi9FYMNj6GdJeWQudGl
	unA7vfclIXFkgrbaCIMpdaljbIgp44oOa81fBAedp2p+dloAizXR5aUCGXaMSNayFizu9KVvTks
	p8vQ1bIWcYCFNTfw13L4j48WUJ3mHtgJvkNU6/+9j0v1AkGyZdGVpH7TOgxS6g+I=
X-Gm-Gg: ASbGncsFNZmGZ5caasYdaImBOPmkCBOzZ7NF8IqDaUonm1YZEUJj015NxCK/QMkhJsT
	5FApESBXiEf9IWn1vvFKM43rhdkI3AmTRq+9OgmdmRTXU7h2gBI55mTibUUeKl5HAiCFHGMb+WW
	B4jGV0MRtE9IYJjSUjNOvLLFLB00KApqQN/4muoQF4v9afb0jVvQJsvMjxgSAwbKqYcmHjWBrjG
	PEXMn0r/4K6IdbWjUvHkoJ1eWjP3NmS4ZaBSkUBhWI8gcKAJdolobSb8OsJOmWnrjnGioehA35k
	KkWoHWAhgt5VWWiFEWlYDKMXzlsgdoZZHftk8PRP0kgjfqY4fVFN/eZYb7jG8QEzu9gRew==
X-Received: by 2002:a05:6214:f0a:b0:6e8:fe16:4d42 with SMTP id 6a1803df08f44-6eb2b93945bmr16243086d6.1.1742405329515;
        Wed, 19 Mar 2025 10:28:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSxO9Ad8Gc8/z7Se2G1kFx5n0pPSkG+JyMNgf9vIXCx+1ZEU+MZgfslIX3i34qdI2GvBa3LQ==
X-Received: by 2002:a05:6214:f0a:b0:6e8:fe16:4d42 with SMTP id 6a1803df08f44-6eb2b93945bmr16242886d6.1.1742405329200;
        Wed, 19 Mar 2025 10:28:49 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147e9bbbsm1060035466b.54.2025.03.19.10.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 10:28:48 -0700 (PDT)
Message-ID: <05e082b5-6ae3-4d25-af81-f2c3b664ad7b@oss.qualcomm.com>
Date: Wed, 19 Mar 2025 18:28:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] arm64: dts: qcom: sc7180: Add specific APPS RSC
 compatible
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Marc Gonzalez <mgonzalez@freebox.fr>,
        Dmitry Baryshkov <lumag@kernel.org>, Arnaud Vrac <avrac@freebox.fr>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250318-topic-more_dt_bindings_fixes-v1-0-cb36882ea9cc@oss.qualcomm.com>
 <20250318-topic-more_dt_bindings_fixes-v1-2-cb36882ea9cc@oss.qualcomm.com>
 <l4vd2xmrowmmtefieb4cbirq6ntkvnwbhtpxcyzwdeok2vgtt7@zqgqndumgecv>
 <881655b5-30c0-42f3-863f-5b6606a3e2cd@oss.qualcomm.com>
 <rg377etwxv3yupth3acak4ycthahi7sennm54sbah55yqj2qdk@vip4xxkbsp7n>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <rg377etwxv3yupth3acak4ycthahi7sennm54sbah55yqj2qdk@vip4xxkbsp7n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: nGp9-yivtd9idePuWQ2pj-i52Uw45L5i
X-Authority-Analysis: v=2.4 cv=ReKQC0tv c=1 sm=1 tr=0 ts=67dafed2 cx=c_pps a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=rhAqBTIILTDuOorn4egA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: nGp9-yivtd9idePuWQ2pj-i52Uw45L5i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_06,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190118

On 3/19/25 6:25 PM, Dmitry Baryshkov wrote:
> On Wed, Mar 19, 2025 at 03:14:42PM +0100, Konrad Dybcio wrote:
>> On 3/18/25 10:30 PM, Dmitry Baryshkov wrote:
>>> On Tue, Mar 18, 2025 at 07:35:15PM +0100, Konrad Dybcio wrote:
>>>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>
>>>> SC7180 comes in a couple firmware flavors, some of which don't support
>>>> PSCI in OSI mode. That prevents the power domain exepcted by the RSC
>>>> node from providing useful information on system power collapse.
>>>
>>> Is this behaviour specific to SC7180 or only to ChromeBooks? For example
>>> TCL Book 14 Go or ECS Liva QC710, would they also use this compat?
>>
>> The hardware and firmware representation of the RSC is identical, but
>> I wanted to alter the bindings required properties based on the specific
>> possibly-chrome platforms.
> 
> Should we instead have a separate compatible (?) for ChromeOS platforms
> only?

No, the RSC is exactly the same. Quite frankly, the expected power-domains
entry is just a way that's convenient to Linux to signal the platform going
off between the drivers

I don't think there is much to overthink here.

Konrad

