Return-Path: <linux-kernel+bounces-394480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D3C9BAFBC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E22BB21045
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4812C1AE00B;
	Mon,  4 Nov 2024 09:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bxm7kVvh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5021AC448
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 09:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730712944; cv=none; b=ACr6vQ8Hq+3UOnm+wB3I/emUSn05nisroSK1zfRfqJbPMPjxFNHSJkbZyQATfK1RgjNDSyvDiCrVEc+oA8YCRwLcttOBl/ceoQnt3UlWGX/J63m32YPZarG/eaDleO2ugZXa1gP700VkR3HPZEqCYywo7/yVhfv8spCmzEyVb6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730712944; c=relaxed/simple;
	bh=QcoTEie8FZ60+JPHif5psISMr/kD+U+xWtCc+upG3zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JWpEFivQRehwVLOPc9HbW85hR0euvSX7DVAusuH5mXbECN+0TrjUiYOPgBggMPKb3a1qZ2qpvkCmGWlvCLaHby7t/aqPF/P7bpkJQePODmEcHg/ZNIciASxzIZKNS4ZhbRhSsiIsob7qf6VTbgoIjunvkyppxmploilDyp8tvR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bxm7kVvh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3MZbkm028240
	for <linux-kernel@vger.kernel.org>; Mon, 4 Nov 2024 09:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a7ClmRGW/Dq8E6lrvmSf+/iEncnmMhHeY3NKR0VniJk=; b=Bxm7kVvhTNC34neX
	tREOAqsEVKHwtoztJBS4OwgmKZNd7VR0OIm99nCrKThOCj9KQv+tlYkDzudNw1an
	gph1o1zSZPh07IexQpH26STxfQ2u9ngSY1N+sDj0fFDEgjwv2MINwWXOYUyft3tt
	RCohAxjebOQ9P+3xEvcsxqZaYU4aQEMZiGwil5kta3GF3h0BriYfYjATjr7798wj
	s8ExedUoN5SH06k2ro/2+aV/VJfU947lViB37P358HY6pvn8p2nI/qC44pKjcgc1
	yvFX9cn4sTY/THkM9ouf2aVQTnTK2DNS+iFNIc5kxDnDLL4Nh+3xsJ40nwde3xkJ
	soE0Ug==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd4ukppk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 09:35:41 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-84fca3ad0ddso62307241.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 01:35:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730712941; x=1731317741;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a7ClmRGW/Dq8E6lrvmSf+/iEncnmMhHeY3NKR0VniJk=;
        b=M9OzENLbG1x8v/g6hHS/4hxAiHIjkP/eyCPf52/kdC8ZNZRw5FxlcrjN9csG8CMUln
         PJSIaIDIo5JMHt3ovXBctZnhJPtivvBeMd2RVMj0cn/aJm3pZavWS8OaWJsFQKfosHij
         Hno4EDkBFE2x7j80ujackBsDlZRqme3EUz4WZIdARhTzTRLwj3IGnyUmiC0mjcrauyTJ
         MrplLr9kj6cI0NOkenedHG4YRrtL9jcm85bEy02jqdNimlQyu2U08gkOZDYQRQyLWT0V
         Ar5luoo1UxUH32xzcvyGtWOUW0MsMiextJKTIM+Sd7zOH+X8oMpN6FvI2frdZq3PjRbi
         UrCA==
X-Forwarded-Encrypted: i=1; AJvYcCWxVOVg5Ag0uk7dImppXRqxt2LNjzS1j6P7ORJFlMMhgDetvOgcPuNK93rZpyJe4qw7/6RiUid9flRsIGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze4eM0dIrQgGZ8qGVrWbtQLWqWLvPVDO3YTbPGVmirMhB9kWQz
	WEh1p1wqPpCon6zDRdvNjEsSQkkwNYaKOIYI0NodI7zsT9/v6jASXR9Sd552FaH+YKKOg5Qz2Yp
	Ha6uMYZq67SuF9IoeJHqQvElP77nz89O1BRnWUSMyzAqLr+ebspxVU480KB598DtPOi6nSQM=
X-Received: by 2002:a05:6102:3a0e:b0:4a5:bff5:4ee1 with SMTP id ada2fe7eead31-4a8cf9d4693mr10223873137.0.1730712940774;
        Mon, 04 Nov 2024 01:35:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFym09hnNdijaVFukhOsYz+216T1RS1/Kf0jAwrcJdxn4xJijzfx2HMy+bQo+HqXyxcUUNhlg==
X-Received: by 2002:a05:6102:3a0e:b0:4a5:bff5:4ee1 with SMTP id ada2fe7eead31-4a8cf9d4693mr10223860137.0.1730712940325;
        Mon, 04 Nov 2024 01:35:40 -0800 (PST)
Received: from [192.168.212.146] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e565e08e6sm527905766b.129.2024.11.04.01.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 01:35:39 -0800 (PST)
Message-ID: <925202f0-7fd1-4422-88fb-138c9027ac2c@oss.qualcomm.com>
Date: Mon, 4 Nov 2024 10:35:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/3] dt-bindings: interconnect: Add EPSS L3 compatible
 for SA8775P
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar
 <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>
References: <20241026123058.28258-1-quic_rlaggysh@quicinc.com>
 <20241026123058.28258-2-quic_rlaggysh@quicinc.com>
 <7k2vnjop6xyshquqlbe22gm7o5empeluvsohfmq5ulnaas3keb@yzomhzi4w7vf>
 <2ac4604c-a765-48b1-84b2-8979f18c29a7@quicinc.com>
 <vljb7wwqaaqgdcm6whf5ymhnh4jbtswyibto4qpqmbgwvshudy@unh3jhbyeac6>
 <00c9feac-722a-481a-9c57-36463fe0b3ff@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <00c9feac-722a-481a-9c57-36463fe0b3ff@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: NE7LQk1vPen-NOpnAwSE9YKsBi6cNKa2
X-Proofpoint-ORIG-GUID: NE7LQk1vPen-NOpnAwSE9YKsBi6cNKa2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040084

On 4.11.2024 7:40 AM, Raviteja Laggyshetty wrote:
> 
> 
> On 11/1/2024 12:26 AM, Dmitry Baryshkov wrote:
>> On Wed, Oct 30, 2024 at 12:23:57PM +0530, Raviteja Laggyshetty wrote:
>>>
>>>
>>> On 10/26/2024 8:15 PM, Dmitry Baryshkov wrote:
>>>> On Sat, Oct 26, 2024 at 12:30:56PM +0000, Raviteja Laggyshetty wrote:
>>>>> Add Epoch Subsystem (EPSS) L3 interconnect provider binding on
>>>>> SA8775P SoCs.
>>>>>
>>>>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>>>>> ---
>>>>>  .../devicetree/bindings/interconnect/qcom,osm-l3.yaml         | 4 ++++
>>>>>  1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>>>>> index 21dae0b92819..042ca44c32ec 100644
>>>>> --- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>>>>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>>>>> @@ -34,6 +34,10 @@ properties:
>>>>>                - qcom,sm8250-epss-l3
>>>>>                - qcom,sm8350-epss-l3
>>>>>            - const: qcom,epss-l3
>>>>> +      - items:
>>>>> +          - enum:
>>>>> +              - qcom,sa8775p-epss-l3
>>>>> +          - const: qcom,epss-l3-perf
>>>>
>>>> Why is it -perf? What's so different about it?
>>>
>>> The EPSS instance in SA8775P uses PERF_STATE register instead of REG_L3_VOTE to scale L3 clocks.
>>> So adding new generic compatible "qcom,epss-l3-perf" for PERF_STATE register based l3 scaling.
>>
>> Neither sm8250 nor sc7280 use this compatible, while they also use
>> PERF_STATE register.
>>
> That is correct, both sm8250 and sc7280 use perf state register.
> The intention for adding "qcom,epss-l3-perf" generic compatible is to use it for the chipsets which use perf state register for l3 scaling.
> Using generic compatible avoids the need for adding chipset specific compatible in match table.

That is exactly what bindings guidelines forbid.

You need a SoC-specific compatible so that you can address platform-
specific quirks that may arise in the future while keeping backwards
compatibility with older device trees

Konrad

