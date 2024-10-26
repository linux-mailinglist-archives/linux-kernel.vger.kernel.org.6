Return-Path: <linux-kernel+bounces-383168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B01029B1801
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 14:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40DAB1F21F53
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 12:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504611CEABB;
	Sat, 26 Oct 2024 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b2Ds7RkG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40641D5CFF
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729945463; cv=none; b=oSHm4hmu4RAJZW/clgPYf41/OtnyXP0H0JieHZ8NO7zCCxlzWSeEE7aP2aWrjN1YpPtznYy5yuEQ3e9AhmAqobnqUxk88AmXWtj3weyFbBs1euN5CPMiNGxk5hUduaqKqb1ycHJJmFhvy9RSM59lbTRqh1BKVXqm0mRuLtLoBjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729945463; c=relaxed/simple;
	bh=JVzpLNQkSjvzTPDG6r/d1PNcnmVsc3m+jEMN7pe31GU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FEivElunlJ2zu+FCp8+qlySmfB52Vo3E5O9JOTjdAxESeXdfbDHhip8VJ3s2JOA7R/sEX+Ly25Sw89m9gQlIqWo8B3dzGJgJCS3IknNn8lNF949ZDjVSVVGSrCWQ2V8+AK7mf3/xquj89qpirhv/LZbiPe0qir4wZZN2IAnRmcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b2Ds7RkG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q4dxqS022378
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 12:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NEHTf5okAsV4fNv8EHBAUJXqgWu2Iw3fUGanifidahM=; b=b2Ds7RkGeYAygVBX
	YPMhNRPlftogPkSVKZHntAb/qBnoCCkkc/3KKwTiYp0xEhnYbflulTPfb1bb5GEa
	xarGKEqG9YAt4q4GFxqMPPzsNXpgsuH767ddvR9R/t0dBXh6JMO5ZfZuSli7sUuQ
	SsqIWcQAZe2TLQyPDhpl2InTF4JuF0wWLJVGbMP5ieER1OmwDOhITyMgJX+cE3AU
	f9tASGkiZGW5lNV0k870BdMJJN/5utOlQ0pV3hIUcYfiTHwps3vj9blSsXzm4+Ki
	PJQd3EnsVOnmDTm/4CtcP4I8luTavgyvpvj34UhylztGfQAigW/3RIe+LKnygsdD
	pvgKig==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gskjru32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 12:24:20 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cbf5a3192aso6457096d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 05:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729945459; x=1730550259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NEHTf5okAsV4fNv8EHBAUJXqgWu2Iw3fUGanifidahM=;
        b=lodSC45Dlb/imeAzm57OM6tAKUh4Kvr0ZJUxikQu9c6FrrM8wwJw+luZ3cQmd2Eui7
         Wj9NTxNYrqMiKrzaoBopBcIFSeYjaq6OIBQyCLFtZdd0wMsqPWzlkQEQKeWH/ke+kJ2t
         5Ae6orWNcVIKuNr0QHSUTcdGyfF/UdxjH3ynRIXQdfaz9AmRjJAHbWUb0EG8B1Flxxtu
         SORuViN8lSzuiK88BMKNfyQxeBtELswol07tDuoTVSV/9DJ58sWw51pCXvb8AetfEK73
         LJgxxTThKKRQZdjJoKazLHbzllJla1gTZhR8wuF0nlG1y7T6AYhTl8eMYISwQ4UGArPN
         NrYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhrw80eOliqCJUxBQtCj8zpUXNVqNChMOIpzmsprr0MHBrXlPN+q6wf5tYWj7FDyi+dobEcXc/VU/Zfi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK9Nm+y0aZUAqc3KRYYFuNR9QxRTZrqe5hd4ZnwBvDb5CZMfIU
	72WWtnQyaoim0j/Hwh1NVrwisTqgRfq+oL9wamjkyeQgx+IboFQlplnTNvEH4ZLrBvdybvFy06t
	BuhTJcB4qAuIyVHHuop68cwS57GRLQ8oKfc66zqWFVeJq+5rQ//HsSHaG/Gxo9wA=
X-Received: by 2002:ad4:5cc1:0:b0:6cb:4e9f:7370 with SMTP id 6a1803df08f44-6d185862964mr17076276d6.12.1729945459548;
        Sat, 26 Oct 2024 05:24:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFKXcdxHJxmTLVgkVghCibNvSdv93HBNl6fpHMmv941oQH8SB8a8JYdjCscLT5BDlX5M4jhw==
X-Received: by 2002:ad4:5cc1:0:b0:6cb:4e9f:7370 with SMTP id 6a1803df08f44-6d185862964mr17076086d6.12.1729945459175;
        Sat, 26 Oct 2024 05:24:19 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b3099df78sm169074566b.158.2024.10.26.05.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 05:24:18 -0700 (PDT)
Message-ID: <8a8df92d-a8f1-456c-92cb-d0d485f03345@oss.qualcomm.com>
Date: Sat, 26 Oct 2024 14:24:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] interconnect: qcom: Add EPSS L3 support on SA8775P
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_okukatla@quicinc.com,
        quic_mdtipton@quicinc.com
References: <20240904171209.29120-1-quic_rlaggysh@quicinc.com>
 <20240904171209.29120-4-quic_rlaggysh@quicinc.com>
 <c3efb01d-2138-4b79-97a1-653b7bd531d0@kernel.org>
 <bfcc65b2-97a4-4353-a2fd-dce927c53428@quicinc.com>
 <49aa8205-6324-412d-b03d-c2b3f738cc98@kernel.org>
 <6b89de85-58c0-4808-9a33-6ee7dc26611d@quicinc.com>
 <e7ce51a1-97a1-4d54-a1d4-0f6d279a9055@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <e7ce51a1-97a1-4d54-a1d4-0f6d279a9055@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 9WqHLLj_t468sa279bK4BC-ZfMQ1cU35
X-Proofpoint-ORIG-GUID: 9WqHLLj_t468sa279bK4BC-ZfMQ1cU35
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410260104

On 26.10.2024 1:28 PM, Krzysztof Kozlowski wrote:
> On 25/10/2024 17:38, Raviteja Laggyshetty wrote:
>>
>>
>> On 9/6/2024 10:00 PM, Krzysztof Kozlowski wrote:
>>> On 06/09/2024 17:32, Raviteja Laggyshetty wrote:
>>>>
>>>> On 9/4/2024 11:52 PM, Krzysztof Kozlowski wrote:
>>>>> On 04/09/2024 19:12, Raviteja Laggyshetty wrote:
>>>>>> +
>>>>>>  static const struct qcom_osm_l3_desc epss_l3_l3_vote = {
>>>>>>  	.nodes = epss_l3_nodes,
>>>>>>  	.num_nodes = ARRAY_SIZE(epss_l3_nodes),
>>>>>> @@ -284,6 +307,10 @@ static const struct of_device_id osm_l3_of_match[] = {
>>>>>>  	{ .compatible = "qcom,sm8150-osm-l3", .data = &osm_l3 },
>>>>>>  	{ .compatible = "qcom,sc8180x-osm-l3", .data = &osm_l3 },
>>>>>>  	{ .compatible = "qcom,sm8250-epss-l3", .data = &epss_l3_perf_state },
>>>>>> +	{ .compatible = "qcom,sa8775p-epss-l3-cl0",
>>>>>> +	  .data = &epss_l3_perf_state },
>>>>> Don't grow it but express compatibility.
>>>> ok. Will rename compatible from "qcom,sa8775p-epss-l3-cl0" to "qcom,sa8775p-epss-l3".
>>>
>>> This won't solve the problem. You still grow the table, right?
>>
>> Falling back to "qcom,epss-l3" won't work because we need to vote into perf state register.
>> I am introducing a new fallback compatible "qcom,epss-l3-perf" for perf voting, which can be used for upcoming qcs8300.
> 
> Maybe, no clue, this was 1.5 months ago. I don't have original patches
> in the inbox anymore.
> 
> Just choose something sensible following writing bindings guideline.

You can see that qcom,sm8250-epss-l3 uses the same match data, so that
sounds like a good fit

Konrad

