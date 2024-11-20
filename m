Return-Path: <linux-kernel+bounces-415488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D95D9D3705
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 10:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 474A41F27001
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB651991A8;
	Wed, 20 Nov 2024 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Zjfndpt6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0D3158535;
	Wed, 20 Nov 2024 09:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732094684; cv=none; b=fUUvSbrcDNvisBB5VnYlrY5ytiz+ftGlqtw8D7ebZGygW6juwLl18tWr5dEKoUsM3OdCI6VJzpYMbC1PW6x96GLvoiiQ+P77Xs/yA3EkDJlsys8ZgFN+OSqnIq24Ry5dI7JjCIAG5HVy/PL2SSOLraezla5kffxit9AlbtnGhwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732094684; c=relaxed/simple;
	bh=KeeZjdkz3m5NAs3K+kqMz9FMhPpTqy/RdWyM6Bwg3vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U26rx2z3Y9BbUEbKT8+Ksml/dXwNtKAS8niRf8DvnFbGsNc6AKTXndEK/yMooU5vEujOsN1a60sIUemjReakfBzNcvT4X+YAHyXP+VEDHPW4KX0SQq5jOP66rdz8g41/avhBHJLQCQYQtuBBJRItg5RFEmEd4uYtX8Pf4rckrP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Zjfndpt6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AK9FJbR019260;
	Wed, 20 Nov 2024 09:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0eUrxXeKNDLoWi0nj3C/7caPr7l7ZX4VyKkMA5xqIIg=; b=Zjfndpt6qNtfGIQr
	+McUepRTRXD4PcLMxKpi1YUihmRoNPrNzaSOOTnV+HdfaD60XHoVSXore76xUwdV
	Lh4zK+FDNuZTsuq+i+3HOwAj5i+VSbS/PhMzssyBHzmaeKvGKkaKgAQkvf/Cgab0
	YBIPiI3UnGrKPQf7yQEjw0nDz6DUvA2PjilRPXFPBfROc35eUTo0Yy8VkeTZ/L6y
	g4M2LY0wVkL97jnmAlFQ8PxyBgwLJGJDcUqZsdx8qLqD9K3kqOrPRgqzvFi7ENow
	tt8oHZ+8xF76DyGXctqWGvqY/MXm0DgG2G2dKJ34Y0PjQ2ZtsJcjap2vqYauLjg8
	VIQhPg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431c7hg5ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 09:23:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AK9NwWM028281
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 09:23:58 GMT
Received: from [10.216.62.246] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 20 Nov
 2024 01:23:54 -0800
Message-ID: <99810132-85b6-45ee-9933-7a00c3672c47@quicinc.com>
Date: Wed, 20 Nov 2024 14:53:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: snps,dwc3: Add
 snps,filter-se0-fsls-eop quirk
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Uttkarsh Aggarwal
	<quic_uaggarwa@quicinc.com>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>
References: <20241017114055.13971-1-quic_uaggarwa@quicinc.com>
 <20241017114055.13971-2-quic_uaggarwa@quicinc.com>
 <gclvciv5cmrcut6qvo3kh3ycutqt5sot5k4i2nwics6myhuxvq@cf6ajwflxdlc>
 <1129e0a7-6bd0-416e-8c56-6b8d75600c4e@quicinc.com>
 <f9f66565-6356-4b61-8653-1e9c006b892c@kernel.org>
Content-Language: en-US
From: Krishna Kurapati <quic_kriskura@quicinc.com>
In-Reply-To: <f9f66565-6356-4b61-8653-1e9c006b892c@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aXnsb68vogMjrmCwR3eejPNCDYEXDKLi
X-Proofpoint-GUID: aXnsb68vogMjrmCwR3eejPNCDYEXDKLi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=713 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411200064



On 11/7/2024 3:25 PM, Krzysztof Kozlowski wrote:
> On 07/11/2024 07:17, Krishna Kurapati wrote:
>>
>>
>> On 10/18/2024 11:57 AM, Krzysztof Kozlowski wrote:
>>> On Thu, Oct 17, 2024 at 05:10:54PM +0530, Uttkarsh Aggarwal wrote:
>>>> Adding a new 'snps,filter-se0-fsls-eop quirk' DT quirk to dwc3 core to set
>>>> GUCTL1 BIT 29. When set, controller will ignore single SE0 glitch on the
>>>> linestate during transmission. Only two or more SE0 is considered as
>>>> valid EOP on FS/LS port. This bit is applicable only in FS in device mode
>>>> and FS/LS mode of operation in host mode.
>>>
>>> Why this is not device/compatible specific? Just like all other quirks
>>> pushed last one year.
>>
>> Hi Krzysztof,
>>
>>    Apologies for a late reply from our end.
>>
>>    In DWC3 core/dwc3-qcom atleast, there have been no compatible specific
>> quirks added.
> 

Sorry again for late reply.

> Nothing stops from adding these, I think.
> 

Agree, we can take that approach of adding soc specific compatibles to 
dwc3 driver instead of adding through bindings.

>> Also since this is a property of the Synopsys controller
>> hardware and not QC specific one, can we add it in bindings itself.
>> Because this is a property other vendors might also use and adding it
>> via compatible might not be appropriate.
> 
> This does no answer my question. I don't see how this is not related to
> one specific piece of SoC.
> 
> If you claim this is board-related, not SoC, give some arguments.
> Repeating the same is just no helping.
> 

But my point was that although the issue was found only on some QC 
SoC's, the solution still lies in some bits being set in controller 
register space and it is part of Synopsys IP. So wouldn't officially we 
add that support in bindings and then enable/disable the feature via DT 
like we did for other quirks ? If many SoC's need it in future, the 
driver needs to add a long list of compatible specific data which 
otherwise might be quirks in DT.

Regards,
Krishna,



