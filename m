Return-Path: <linux-kernel+bounces-200280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 969B18FAE06
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EEC11C2127A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF10142E82;
	Tue,  4 Jun 2024 08:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R2z097cp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D53BA39;
	Tue,  4 Jun 2024 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717491160; cv=none; b=X1DuebNkD5kIY4imKQCmu3kPb7OzmPIcNeYbjlc9tywMwMH/AuGC2ckR2NqYS7d4HpOusyliLvKBGVTKxFlMKs4Mx1NFrJBSoueaSyosTd6LdYWAOegcK2SLCWP7sJVAYo53xjWSF50+5lFAtr8z6l34lxN39qz4PSFNgQshe1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717491160; c=relaxed/simple;
	bh=LN3LntYkPqGd4pd8dEOnMvv+52Ftx6R4N7xNNNSsefY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uituqKazPElhwIRO8eOysTQIzNJ3+xeLihi6iJRNt2UY7QfQx3gmJrRFWSbWQd111pHH956bs0U2v72/2gGJVXH0frPgbNqpk0CRRipykQWaaJW/E80vCPyRNKEqWwE7vb36WYLdPufg/oju6gaIHE5jrDx1+QMu5vph6+IDZWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R2z097cp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4542OMDJ031648;
	Tue, 4 Jun 2024 08:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/IgZ+kibNZwPCBCkJecCGYakXqFcRgLlu5olQRmGYOs=; b=R2z097cpYlG5asA0
	SQUW/N+9sHFpIc1Uos0P+IvDuBHFvCOLiesSw6SOuZ99of47gt3JF7wuI8X1nPPI
	iUbJq8k91AQ3ng3eBzAecx2ZLaIvwgLdjPtRR3/FO04FiewJbz7Jrsn1xNVJlltK
	fehOYIR8XFrSSrrx4r6lY3X7V0wb1jKiOU1SV2eDIErrpXWTzH7B24u2AQIRg2eR
	2tfJf2Bc3epUHXUo38Jr9191NrpkXLkt/2QQjSKnsufBPv8+WtOK2GlmyutO81mD
	8ETZUdOKbar/YRuLttrCwBSTGtMa8WGxnwncnKxPwmDHUhBcSXv94cknAw+2a2Rn
	NLPhow==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw7dp6y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 08:52:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4548qUw3009763
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Jun 2024 08:52:30 GMT
Received: from [10.216.52.99] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 4 Jun 2024
 01:52:28 -0700
Message-ID: <79f52dae-7c16-4545-b36a-fcf481e66da5@quicinc.com>
Date: Tue, 4 Jun 2024 14:22:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: gadget: Inform system of suspended state
To: Mike Looijmans <mike.looijmans@topic.nl>,
        Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.c5f44c79-75b2-43c1-a791-806fe8b693cd@emailsignatures365.codetwo.com>
 <20240603131304.233403-1-mike.looijmans@topic.nl>
 <20240604010256.4dxamwvcjxug6xfb@synopsys.com>
 <0fceefc4-2b3c-41a4-a6ac-d0b6dbacc1f7@topic.nl>
 <91b3af13-e723-4a49-b7f6-06f927c286c9@quicinc.com>
 <9473c090-a21b-4d11-a98d-6083547d9648@topic.nl>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <9473c090-a21b-4d11-a98d-6083547d9648@topic.nl>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1CXeTzTxksmncalCqDJlpqaw0TFK-Qmn
X-Proofpoint-GUID: 1CXeTzTxksmncalCqDJlpqaw0TFK-Qmn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-04_03,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=984 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406040071



On 6/4/2024 1:55 PM, Mike Looijmans wrote:
> On 04-06-2024 08:45, Krishna Kurapati PSSNV wrote:
>>
>>
>> On 6/4/2024 10:56 AM, Mike Looijmans wrote:
>>> On 04-06-2024 03:03, Thinh Nguyen wrote:
>>>> Hi,
>>>>
>>>> On Mon, Jun 03, 2024, Mike Looijmans wrote:
>>>>> When disconnecting the USB cable on an LS1028 device, nothing happens
>>>>> in userspace, which keeps thinking everything is still up and running.
>>>>> Turns out that the DWC3 controller only sends 
>>>>> DWC3_DEVICE_EVENT_SUSPEND
>>>>> in that case, and not a DWC3_DEVICE_EVENT_DISCONNECT as one would
>>>>> expect. As a result, sysfs attribute "state" remains "configured"
>>>>> until something resets it.
>>>>>
>>>>> Forward the "suspended" state to sysfs, so that the "state" at least
>>>>> changes into "suspended" when one removes the cable, and hence also
>>>>> matches the gadget's state when really suspended.
>>>> On disconnection, did you see disconnect interrupt? If so, it should
>>>> transition to USB_STATE_NOATTACHED. This change doesn't seem to 
>>>> directly
>>>> address your issue. Can you provide the driver tracepoints?
>>>
>>> The device doesn't issue a disconnect event, I didn't have tracing 
>>> enabled in the kernel but added some dev_info() calls to determine 
>>> what was going on. Added this to dwc3_process_event_entry():
>>>
>>> dev_info(dwc->dev, "event: 0x%x type=0x%x", event->raw, 
>>> event->type.type);
>>>
>>> When disconnecting the cable from the host, I see this:
>>>
>>> [   50.841411] dwc3 3110000.usb: event: 0x6084 type=0x42
>>> [   50.841457] dwc3 3110000.usb: event: 0x4086 type=0x43
>>> [   50.841494] dwc3 3110000.usb: event: 0x6084 type=0x42
>>> [   50.841534] dwc3 3110000.usb: event: 0x4086 type=0x43
>>> [   50.841571] dwc3 3110000.usb: event: 0x4086 type=0x43
>>> [   52.650990] dwc3 3110000.usb: event: 0x30601 type=0x0
>>>
>>> The "0x4086" and "0x6084" messages are endpoint events that occur all 
>>> the time while connected. The last event is the "suspend" one. After 
>>> that, total silence.
>>>
>>> If you need traces, please point me to a description on how to obtain 
>>> them.
>>>
>>>
>>
>> Hi Mike,
>>
>>  I may be wrong, but can you help understand the mechanism as to how 
>> disconnect interrupt is generated in your targets. For example, on QC 
>> SoC's, this happens when HS_PHY_CTRL reg VBUS_VALID bit is cleared and 
>> cable is disconnected. This is because the vbus line is not routed to 
>> controller. But from my calls with Synopsys previously, I remember 
>> that the vbus line is routed to the controller as well for other OEMs. 
>> In your SoC, what is the indication to controller that vbus is absent ?
>>
> The board I'm testing this on is an LS1028ARDB. Looking at the 
> schematic, VBUS is routed to the chip. There's also an LED attached to 
> it, which turns off when I unplug the cable.
> 
> In the devicetree, I can't see any hint of NXP-specific "glue" in the 
> DWC3 entries, so it uses the controller "as is":
> 
>                          compatible = "fsl,ls1028a-dwc3", "snps,dwc3";
>                          reg = <0x0 0x3100000 0x0 0x10000>;
>                          snps,dis_rxdet_inp3_quirk;
>                          snps,quirk-frame-length-adjustment = <0x20>;
>                          snps,incr-burst-type-adjustment = <1>, <4>, 
> <8>, <16>;
> 
> The "fsl,ls1028a-dwc3" keyword doesn't actually occur anywhere in the 
> kernel, so it uses plain "snps,dwc3".
> 
> 
>> Also, after this happens, do you see the next plug in working ?
> 
> Next plugin works, because of a "reset" event at that point that makes 
> everything happy again.

Ahh, got it. Thanks for the info.
I ran into a similar issue before where disconnect isn't generated [1] 
and was suspecting it could be the case here but it isn't.

[1]: 
https://patchwork.kernel.org/project/linux-usb/patch/20231011100214.25720-1-quic_kriskura@quicinc.com/

Regards,
Krishna,

> 
> The state remains in "configured" while the cable is out. Plugging the 
> cable back in makes it revert to "default" first, then it goes back into 
> "configured".
> 

