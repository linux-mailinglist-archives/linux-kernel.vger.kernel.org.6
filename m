Return-Path: <linux-kernel+bounces-439323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E0D9EADAB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5001A283C47
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44A423DEBE;
	Tue, 10 Dec 2024 10:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g/WW6Ko4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49DE23DE8B;
	Tue, 10 Dec 2024 10:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733825543; cv=none; b=dXIr59GAvzJSzusTQDNXusw0ebMEkpsJKArwGBfxtccp6O9FniUNCFF290kY6oEmI61ROe2J1Jv/W6k5EIIh8plJMMIGsuBZfiUE5kOjDXXwrX8fNYyUvWFGGK2fa0wf0DR8S5CBpX0XVcgpLb+6xZ+ajGD9zVbu9TKVR0O8Hfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733825543; c=relaxed/simple;
	bh=vYg8wU42z6GwnwQ6+y+kBfKrFpVAPNchj09BZz4eGr0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=s0Lj7iWEWRLEClWyft1qeAR6orz0hmtVQK5YBwrDaL8/EN36yOEJQIxea5MPKJhKRt6YwiTtUhLrkDzrjcGVSIxDJkdDpwrjknWoCQgqb3k24V9KeDo2GZI8pWMSblUC1WsFWinbXzFXohZI5D3294ys+abhVWEdGdZ4/+BSxKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g/WW6Ko4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA94bf0014580;
	Tue, 10 Dec 2024 10:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+xSULu1W4jer6gCjVvUYVNZD9AKl7ksD1gp8ZetqYb4=; b=g/WW6Ko4K0egBxut
	6ATlTnMjlzxR+31CZEPsoOUk4Yr/JJhNEp4g5uVCl4eQQ5eYpmtKPlKD9CPyLP9G
	sN+jlPgQx5HoVntuAvQLM3DdcgUOZ4LdljB9GouSRP8unETgu9LqshkImXgHhbQU
	wFWGBJbZI8OcKRun8HQZKOUCts0dPKqbjUsUHXETr5Z5n7CysYdhuKmDOLFbbWXF
	+rfttMVhJ6MUCqlEVOFfUM09wk3tJyqnBg/cI0qxI29CP5oLsIfo/4r/x4bDULkn
	mHO2frzqd7hjie7ISfwQtSvJtzC1BdwYiwvOE/BXvQ/mSGTA/j2mg5bxTcO8NB8c
	XVG3oA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43dy8tujgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 10:12:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BAACFwu000891
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 10:12:15 GMT
Received: from [10.216.28.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 10 Dec
 2024 02:12:11 -0800
Message-ID: <aa67ea21-b451-4a1d-b4bf-4912b88c0341@quicinc.com>
Date: Tue, 10 Dec 2024 15:42:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: snps,dwc3: Add
 snps,filter-se0-fsls-eop quirk
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Uttkarsh Aggarwal
	<quic_uaggarwa@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
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
 <99810132-85b6-45ee-9933-7a00c3672c47@quicinc.com>
Content-Language: en-US
In-Reply-To: <99810132-85b6-45ee-9933-7a00c3672c47@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UY41v4HwgMP5vdunX35jyK2vr4GVxLh2
X-Proofpoint-GUID: UY41v4HwgMP5vdunX35jyK2vr4GVxLh2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=733 clxscore=1015 mlxscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412100076



On 11/20/2024 2:53 PM, Krishna Kurapati wrote:
> 
> 
> On 11/7/2024 3:25 PM, Krzysztof Kozlowski wrote:
>> On 07/11/2024 07:17, Krishna Kurapati wrote:
>>>
>>>
>>> On 10/18/2024 11:57 AM, Krzysztof Kozlowski wrote:
>>>> On Thu, Oct 17, 2024 at 05:10:54PM +0530, Uttkarsh Aggarwal wrote:
>>>>> Adding a new 'snps,filter-se0-fsls-eop quirk' DT quirk to dwc3 core 
>>>>> to set
>>>>> GUCTL1 BIT 29. When set, controller will ignore single SE0 glitch 
>>>>> on the
>>>>> linestate during transmission. Only two or more SE0 is considered as
>>>>> valid EOP on FS/LS port. This bit is applicable only in FS in 
>>>>> device mode
>>>>> and FS/LS mode of operation in host mode.
>>>>
>>>> Why this is not device/compatible specific? Just like all other quirks
>>>> pushed last one year.
>>>
>>> Hi Krzysztof,
>>>
>>>    Apologies for a late reply from our end.
>>>
>>>    In DWC3 core/dwc3-qcom atleast, there have been no compatible 
>>> specific
>>> quirks added.
>>
> 
> Sorry again for late reply.
> 
>> Nothing stops from adding these, I think.
>> >
> Agree, we can take that approach of adding soc specific compatibles to 
> dwc3 driver instead of adding through bindings.
> 
>>> Also since this is a property of the Synopsys controller
>>> hardware and not QC specific one, can we add it in bindings itself.
>>> Because this is a property other vendors might also use and adding it
>>> via compatible might not be appropriate.
>>
>> This does no answer my question. I don't see how this is not related to
>> one specific piece of SoC.
>>
>> If you claim this is board-related, not SoC, give some arguments.
>> Repeating the same is just no helping.
>>
> 
> But my point was that although the issue was found only on some QC 
> SoC's, the solution still lies in some bits being set in controller 
> register space and it is part of Synopsys IP. So wouldn't officially we 
> add that support in bindings and then enable/disable the feature via DT 
> like we did for other quirks ? If many SoC's need it in future, the 
> driver needs to add a long list of compatible specific data which 
> otherwise might be quirks in DT.
> 

Hi Krzysztof,

  Gentle ping to provide your feedback on the last comment.

Regards,
Krishna,

