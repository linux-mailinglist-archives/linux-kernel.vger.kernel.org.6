Return-Path: <linux-kernel+bounces-200117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CC78FAB1D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EAF22841F5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 06:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563B213DDD5;
	Tue,  4 Jun 2024 06:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y4W2SlXa"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B041EB27;
	Tue,  4 Jun 2024 06:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717483570; cv=none; b=RmtZb1XJf8kZlFf/1nqAkZFWb50vu1FUCmqoZ+yxo9r7c9WkLQWAXjopQruXdEDDTD2uut45e2CLe4UKFlwYLf4b4JoKKSUo7zhpKMDpD/9zdrEJOLttJTWoUyV4g1YOLJnOxsjOzoVwODjoSTuL9Suyie6T/UAtt8XEx6z9FjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717483570; c=relaxed/simple;
	bh=Ecz97fuA80kTvU9pUiDGPFSSeiB30Bdma4sD2YjzAuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ojed+xkqhOckSJ9m3ijYB1hRxUazhuIfDBGjjOCVVycmFNfXn7mV5ExcDWhLgNv1CTGsmDt8/LfO2toJa7lyQcXP+OJPzHxi7XoaUI7xRHQjatjvXDzH0KdsN04fKtlbpzSyRmLexuTF4cCd2sijc4ohFZV4y0lE8mvSN6GyD+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Y4W2SlXa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45406u9I027017;
	Tue, 4 Jun 2024 06:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W5fV2eyMl9DzZbkzaE8fuVIp2iWIDzcWjq2/eRbmFTw=; b=Y4W2SlXachqDys9H
	laleOfb72r/EeUpuToI5XvT1g9IP29P2aUDCGmsQxgpvpLgSA9K3xf78FIATVY9X
	1/FqlM9OoooTGUiYnXEOvsn1CkhpKTmeYS7ZPVtB3oy9zLObWWAJTpczuS9BeYso
	74gO3n3/SN2+s8Lq1h4eMjWgU6fmkusgQnBfXL1fpOdGyeyR1V0EyqsMVUm+Qw3y
	VR2rj6jGy/PEmgjmCUdSHxwb+snwoobIbUD6nVsioaqiOGpp7CcOIRxFUV4lrXJS
	7Ur9Dyty5to6qdfPqgDLr9jPzCE/NDuPX4REJifn8rthu3YuRVBQm4vHz8ZQ8aZa
	rfuYxA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw6v63wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 06:45:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4546jwr3028382
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Jun 2024 06:45:58 GMT
Received: from [10.216.52.99] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Jun 2024
 23:45:56 -0700
Message-ID: <91b3af13-e723-4a49-b7f6-06f927c286c9@quicinc.com>
Date: Tue, 4 Jun 2024 12:15:53 +0530
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
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <0fceefc4-2b3c-41a4-a6ac-d0b6dbacc1f7@topic.nl>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xi61c0ePZgzqs6I81ZUnwz5XikUtLuYA
X-Proofpoint-ORIG-GUID: xi61c0ePZgzqs6I81ZUnwz5XikUtLuYA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-04_03,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 priorityscore=1501 mlxlogscore=589 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406040053



On 6/4/2024 10:56 AM, Mike Looijmans wrote:
> On 04-06-2024 03:03, Thinh Nguyen wrote:
>> Hi,
>>
>> On Mon, Jun 03, 2024, Mike Looijmans wrote:
>>> When disconnecting the USB cable on an LS1028 device, nothing happens
>>> in userspace, which keeps thinking everything is still up and running.
>>> Turns out that the DWC3 controller only sends DWC3_DEVICE_EVENT_SUSPEND
>>> in that case, and not a DWC3_DEVICE_EVENT_DISCONNECT as one would
>>> expect. As a result, sysfs attribute "state" remains "configured"
>>> until something resets it.
>>>
>>> Forward the "suspended" state to sysfs, so that the "state" at least
>>> changes into "suspended" when one removes the cable, and hence also
>>> matches the gadget's state when really suspended.
>> On disconnection, did you see disconnect interrupt? If so, it should
>> transition to USB_STATE_NOATTACHED. This change doesn't seem to directly
>> address your issue. Can you provide the driver tracepoints?
> 
> The device doesn't issue a disconnect event, I didn't have tracing 
> enabled in the kernel but added some dev_info() calls to determine what 
> was going on. Added this to dwc3_process_event_entry():
> 
> dev_info(dwc->dev, "event: 0x%x type=0x%x", event->raw, event->type.type);
> 
> When disconnecting the cable from the host, I see this:
> 
> [   50.841411] dwc3 3110000.usb: event: 0x6084 type=0x42
> [   50.841457] dwc3 3110000.usb: event: 0x4086 type=0x43
> [   50.841494] dwc3 3110000.usb: event: 0x6084 type=0x42
> [   50.841534] dwc3 3110000.usb: event: 0x4086 type=0x43
> [   50.841571] dwc3 3110000.usb: event: 0x4086 type=0x43
> [   52.650990] dwc3 3110000.usb: event: 0x30601 type=0x0
> 
> The "0x4086" and "0x6084" messages are endpoint events that occur all 
> the time while connected. The last event is the "suspend" one. After 
> that, total silence.
> 
> If you need traces, please point me to a description on how to obtain them.
> 
> 

Hi Mike,

  I may be wrong, but can you help understand the mechanism as to how 
disconnect interrupt is generated in your targets. For example, on QC 
SoC's, this happens when HS_PHY_CTRL reg VBUS_VALID bit is cleared and 
cable is disconnected. This is because the vbus line is not routed to 
controller. But from my calls with Synopsys previously, I remember that 
the vbus line is routed to the controller as well for other OEMs. In 
your SoC, what is the indication to controller that vbus is absent ?

Also, after this happens, do you see the next plug in working ?

Regards,
Krishna,

