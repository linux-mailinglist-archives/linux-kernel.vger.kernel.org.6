Return-Path: <linux-kernel+bounces-311217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B99E968633
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EB8D1F22A7E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12061865E9;
	Mon,  2 Sep 2024 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TJoFen1Q"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279F0184538
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 11:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725276466; cv=none; b=icrOImVVogts6+FVTYLcb1PVHy7KbW0EuQQObJHIuYOdJGUmfKcUIjWdx04EBQYaVC/hkdDDcc/TcxNCOXr3PKixKwIvszAuZulrDnx/ST1bBVLmebbP/K5WP7q4OCfZvKq6+Zw7yOsu/DV4mmzwbA7jZIewyxdLKus+GOY1wNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725276466; c=relaxed/simple;
	bh=dDtIAW3Jl0BKLkcBhMxE29qrl+PF/gswKY7TJKCqL9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=abnXefW/tVBtWdiC5GJ3blIej7fhQZwqCGaKuaFJyC3sCJ90jTd4887QFCgvVYtScGBm6jUWBA4LVygbE2p3D+wrE76erGxczkAQxIodrt+fe3/QTty0flAWC1BX1+bGMkj0aLF+kQNyoCRmLT3m7mf0LkQEYKFcVgJlhaQxzSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TJoFen1Q; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240902112740epoutp03fcde1d725d702e21a73df1c70c3f857d~xaczi0XvX1823218232epoutp03E
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 11:27:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240902112740epoutp03fcde1d725d702e21a73df1c70c3f857d~xaczi0XvX1823218232epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725276460;
	bh=YLwvDc/s5euAwx4K36BUYpM/aXGcOUQG+Xs/bjkVf9w=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=TJoFen1Qqv3ZWmTNzgMRZyu/M6/w5Tlqcoaph4506hq9YwANhqgtH+0dPwJ2DCWnc
	 umbuispN4oAN/02t4qlwAKWEe7uu09GtVj2afA4nFbj1mnPLLDVy+gyN31TYXuHimL
	 1nL1lNN1lNNLWqP9gsldopPhK1Fas/oMd6lSjfmk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240902112740epcas5p1367e3ae65ca0b677788747790ed5ef53~xaczBv9HD0328703287epcas5p1E;
	Mon,  2 Sep 2024 11:27:40 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Wy61R1z2Kz4x9Q0; Mon,  2 Sep
	2024 11:27:39 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7A.05.09640.B21A5D66; Mon,  2 Sep 2024 20:27:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240902112727epcas5p3d00e35e64dac52a923882d649d529538~xacmyZ64Q2982429824epcas5p3A;
	Mon,  2 Sep 2024 11:27:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240902112727epsmtrp1d63f0840e12b4417a2b89b8e6710ac3f~xacmxmhs-2296922969epsmtrp1v;
	Mon,  2 Sep 2024 11:27:27 +0000 (GMT)
X-AuditID: b6c32a49-a57ff700000025a8-b3-66d5a12bd9e3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A3.DD.08964.E11A5D66; Mon,  2 Sep 2024 20:27:26 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240902112724epsmtip1c81a4c06b3c9cd7d0e9b2b6e5dd5530f~xackNo31D1156011560epsmtip1g;
	Mon,  2 Sep 2024 11:27:24 +0000 (GMT)
Message-ID: <2e678109-8399-48d5-9567-033eab910bca@samsung.com>
Date: Mon, 2 Sep 2024 16:57:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: Potential fix of possible dwc3 interrupt
 storm
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jh0801.jung@samsung.com" <jh0801.jung@samsung.com>, "dh10.jung@samsung.com"
	<dh10.jung@samsung.com>, "naushad@samsung.com" <naushad@samsung.com>,
	"akash.m5@samsung.com" <akash.m5@samsung.com>, "rc93.raju@samsung.com"
	<rc93.raju@samsung.com>, "taehyun.cho@samsung.com"
	<taehyun.cho@samsung.com>, "hongpooh.kim@samsung.com"
	<hongpooh.kim@samsung.com>, "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
	"shijie.cai@samsung.com" <shijie.cai@samsung.com>
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <20240831005046.5lndwdr7cfm3k3to@synopsys.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmpq72wqtpBhP+s1q8ubqK1eLOgmlM
	FqeWL2SyaF68ns1i0p6tLBZ3H/5gsbi8aw6bxaJlrcwWn44CFa/qnAMU+76T2WLSQVGLVQsO
	sDvweuyfu4bdo2/LKkaPLfs/M3p83iQXwBKVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZg
	qGtoaWGupJCXmJtqq+TiE6DrlpkDdJ6SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAl
	p8CkQK84Mbe4NC9dLy+1xMrQwMDIFKgwITvj9sE7LAULwyoOL3dpYLzr2sXIySEhYCJxuGUP
	cxcjF4eQwG5GiVOPX7FBOJ8YJX6s3MkIUiUk8I1R4sASI5iOiW9PQnXsZZQ4fbmbCcJ5yyix
	4N9hJpAqXgE7ifP/lrCC2CwCKhKLG86zQcQFJU7OfMICYosKyEvcvzWDHcQWFgiQuLJkBtg2
	EQEdiQMnzoMNZRboYJVY0N0GNpRZQFzi1pP5QDYHB5uAocSzEzYgYU4Ba4mV93axQ5TISzRv
	nQ12nYTAFg6Jm73LmSDOdpGYOH8rC4QtLPHq+BZ2CFtK4mV/G5RdLbH6zkc2iOYWRonDT75B
	JewlHh99xAyymFlAU2L9Ln2IsKzE1FProG7jk+j9/QRqF6/EjnkwtqrEqcbLbBC2tMS9JddY
	IWwPiUlPtrNMYFSchRQus5C8OQvJP7MQNi9gZFnFKJlaUJybnlpsWmCYl1oOj/Dk/NxNjODU
	q+W5g/Hugw96hxiZOBgPMUpwMCuJ8C7dczFNiDclsbIqtSg/vqg0J7X4EKMpMIImMkuJJucD
	k39eSbyhiaWBiZmZmYmlsZmhkjjv69a5KUIC6YklqdmpqQWpRTB9TBycUg1MsRoTNZTtTs5b
	6MW3ZPo0Jy3/a0mpt4JVH+pdnj9xbyeH+r/YUtPV9/3kisSyDWa9Yl57ekZ63rS+lwmz7yRL
	yX99Wlbo+X4uq/H17utx7y7s2+y13lVTaRGL45sZlufF2Q/NO2UnPJXpTUzvPKFHaktfbVf4
	cNvw1zU1MeGLciq59/pazjTqGdi9+Z+88tyehfFv8kyVDrzhT6mwrN1z5lrcqj0LHI+e0+C4
	+PRb/fHl3B7KqcoX1m+Yzj9jjivXrBffJrnNPOHePmuPPY9UZ1tf7ZlTfi/Ft9Y7LDQL+NCz
	+MdR340BYcvTfB7v6lC8+qf6+q0bbLNOT2qZfWnviWuOK7cuTX+cvub/dFYLobtKLMUZiYZa
	zEXFiQAC7yZuRgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJTldu4dU0gwv3rS3eXF3FanFnwTQm
	i1PLFzJZNC9ez2Yxac9WFou7D3+wWFzeNYfNYtGyVmaLT0f/s1qs6pwDFPu+k9li0kFRi1UL
	DrA78Hrsn7uG3aNvyypGjy37PzN6fN4kF8ASxWWTkpqTWZZapG+XwJVx++AdloKFYRWHl7s0
	MN517WLk5JAQMJGY+PYkcxcjF4eQwG5GiWX/prJCJKQlXs/qYoSwhSVW/nvODlH0mlFi+o8D
	7CAJXgE7ifP/loA1sAioSCxuOM8GEReUODnzCQuILSogL3H/1gywemEBP4npb06ADRUR0JE4
	cOI8E8hQZoEeVokvXz+yQGz4yCxx5cA9sG5mAXGJW0/mA1VxcLAJGEo8O2EDEuYUsJZYeW8X
	O0SJmUTXVohLmYGWNW+dzTyBUWgWkjtmIZk0C0nLLCQtCxhZVjFKphYU56bnFhsWGOallusV
	J+YWl+al6yXn525iBMeZluYOxu2rPugdYmTiYDzEKMHBrCTCu3TPxTQh3pTEyqrUovz4otKc
	1OJDjNIcLErivOIvelOEBNITS1KzU1MLUotgskwcnFINTJs0+kVXd9191t324LXKuQlhEk3t
	0q++v7znvO2A58GmvctWzLu7kyVFsCA8RjOlqmfukyM/byTcU73/SKmUm00yt4LZV2PW6eiG
	ZwXC8fOEVmafji4wLfvA+P6XYrfbRc3XN3sWnU++tjHLoO7zcsbHGpui6895dj/3nKy69UXz
	b7HF/c4B/6Zd5Lzw8fGMSc7NJh+E7p9YuJZjjbeG3A+r1IPvTzMcOdYwpSqM2+zExO6su5+S
	5Z1Vi19vD/wetP7410XL9zSvvrQm0j7ogfiSJU9zsx7v27fYdsX3sojwH0sE/lySZP4n7DAl
	QP/KhakajYrvCz5y7ZyyQILnmPTWNPa14U7ZZ7b66TuFCMcosRRnJBpqMRcVJwIADglqFiID
	AAA=
X-CMS-MailID: 20240902112727epcas5p3d00e35e64dac52a923882d649d529538
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240719110149epcas5p3dd468685a095c094ed2e540279bf3ec2
References: <CGME20240719110149epcas5p3dd468685a095c094ed2e540279bf3ec2@epcas5p3.samsung.com>
	<20240719110100.329-1-selvarasu.g@samsung.com>
	<20240807003806.5owtgwgw2lczg4u5@synopsys.com>
	<b6baeb45-1684-4fcb-8c71-392cb4788c85@samsung.com>
	<20240808011536.oid627ez4ppdfkhp@synopsys.com>
	<b48e7aba-6c54-431f-bbb5-3e5490df0c1a@samsung.com>
	<20240809234227.eriwy5e6leatzdyh@synopsys.com>
	<b273201d-c589-4c57-9d57-ad2affaeade0@samsung.com>
	<20240831005046.5lndwdr7cfm3k3to@synopsys.com>


On 8/31/2024 6:20 AM, Thinh Nguyen wrote:
> Hi Selvarasu,
>
> On Fri, Aug 30, 2024, Selvarasu Ganesan wrote:
>> On 8/10/2024 5:12 AM, Thinh Nguyen wrote:
>>> On Thu, Aug 08, 2024, Selvarasu Ganesan wrote:
>>>> On 8/8/2024 6:45 AM, Thinh Nguyen wrote:
>>>>> On Wed, Aug 07, 2024, Selvarasu Ganesan wrote:
>>>>>> On 8/7/2024 6:08 AM, Thinh Nguyen wrote:
>>>>>>> On Fri, Jul 19, 2024, Selvarasu Ganesan wrote:
>>>>>>>> In certain scenarios, there is a chance that the CPU may not be
>>>>>>>> scheduled the bottom half of dwc3 interrupt. This is because the CPU
>>>>>>>> may hang up where any work queue lockup has happened for the same CPU
>>>>>>>> that is trying to schedule the dwc3 thread interrupt. In this scenario,
>>>>>>>> the USB can enter runtime suspend as the bus may idle for a longer time
>>>>>>>> , or user can reconnect the USB cable. Then, the dwc3 event interrupt
>>>>>>>> can be enabled when runtime resume is happening with regardless of the
>>>>>>>> previous event status. This can lead to a dwc3 IRQ storm due to the
>>>>>>>> return from the interrupt handler by checking only the evt->flags as
>>>>>>>> DWC3_EVENT_PENDING, where the same flag was set as DWC3_EVENT_PENDING
>>>>>>>> in previous work queue lockup.
>>>>>>>> Let's consider the following sequences in this scenario,
>>>>>>>>
>>>>>>>> Call trace of dwc3 IRQ after workqueue lockup scenario
>>>>>>>> ======================================================
>>>>>>>> IRQ #1:
>>>>>>>> ->dwc3_interrupt()
>>>>>>>>       ->dwc3_check_event_buf()
>>>>>>>>             ->if (evt->flags & DWC3_EVENT_PENDING)
>>>>>>>>                          return IRQ_HANDLED;
>>>>>>>>             ->evt->flags |= DWC3_EVENT_PENDING;
>>>>>>>>             ->/* Disable interrupt by setting DWC3_GEVNTSIZ_INTMASK  in
>>>>>>>>                                                             DWC3_GEVNTSIZ
>>>>>>>>             ->return IRQ_WAKE_THREAD; // No workqueue scheduled for dwc3
>>>>>>>>                                          thread_fu due to workqueue lockup
>>>>>>>>                                          even after return IRQ_WAKE_THREAD
>>>>>>>>                                          from top-half.
>>>>>>>>
>>>>>>>> Thread #2:
>>>>>>>> ->dwc3_runtime_resume()
>>>>>>>>      ->dwc3_resume_common()
>>>>>>>>        ->dwc3_gadget_resume()
>>>>>>>>           ->dwc3_gadget_soft_connect()
>>>>>>>>             ->dwc3_event_buffers_setup()
>>>>>>>>                ->/*Enable interrupt by clearing  DWC3_GEVNTSIZ_INTMASK in
>>>>>>>>                                                             DWC3_GEVNTSIZ*/
>>>>>>>>
>>>>>>>> Start IRQ Storming after enable dwc3 event in resume path
>>>>>>>> =========================================================
>>>>>>>> CPU0: IRQ
>>>>>>>> dwc3_interrupt()
>>>>>>>>      dwc3_check_event_buf()
>>>>>>>>             if (evt->flags & DWC3_EVENT_PENDING)
>>>>>>>>              return IRQ_HANDLED;
>>>>>>>>
>>>>>>>> CPU0: IRQ
>>>>>>>> dwc3_interrupt()
>>>>>>>>      dwc3_check_event_buf()
>>>>>>>>             if (evt->flags & DWC3_EVENT_PENDING)
>>>>>>>>              return IRQ_HANDLED;
>>>>>>>> ..
>>>>>>>> ..
>>>>>>>>
>>>>>>>> To fix this issue by avoiding enabling of the dwc3 event interrupt in
>>>>>>>> the runtime resume path if dwc3 event processing is in progress.
>>>>>>>>
>>>>>>>> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
>>>>>>>> ---
>>>>>>>>      drivers/usb/dwc3/core.c | 8 ++++++--
>>>>>>>>      1 file changed, 6 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>>>>>>> index cb82557678dd..610792a70805 100644
>>>>>>>> --- a/drivers/usb/dwc3/core.c
>>>>>>>> +++ b/drivers/usb/dwc3/core.c
>>>>>>>> @@ -549,8 +549,12 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
>>>>>>>>      			lower_32_bits(evt->dma));
>>>>>>>>      	dwc3_writel(dwc->regs, DWC3_GEVNTADRHI(0),
>>>>>>>>      			upper_32_bits(evt->dma));
>>>>>>>> -	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
>>>>>>>> -			DWC3_GEVNTSIZ_SIZE(evt->length));
>>>>>>>> +
>>>>>>>> +	/* Skip enable dwc3 event interrupt if event is processing in middle */
>>>>>>>> +	if (!(evt->flags & DWC3_EVENT_PENDING))
>>>>>>>> +		dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
>>>>>>>> +				DWC3_GEVNTSIZ_SIZE(evt->length));
>>>>>>>> +
>>>>>>>>      	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), 0);
>>>>>>>>      
>>>>>>>>      	return 0;
>>>>>>>> -- 
>>>>>>>> 2.17.1
>>>>>>>>
>>>>>>> We're not waking up from a hibernation. So after a soft-reset and
>>>>>>> resume, the events that weren't processed are stale. They should be
>>>>>>> processed prior to entering suspend or be discarded before resume.
>>>>>>>
>>>>>>> The synchronize_irq() during suspend() was not sufficient to prevent
>>>>>>> this? What are we missing here.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Thinh
>>>>>> I don’t think the triggering of interrupt would not be stopped even if
>>>>>> do soft reset. It's because of event count is may be valid .
>>>>> Ok. I think I see what you're referring to when you say "event is
>>>>> processing in the middle" now.
>>>>>
>>>>> What you want to check is probably this in dwc3_event_buffers_setup().
>>>>> Please confirm:
>>>>>
>>>>> if (dwc->pending_events)
>>>>> 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
>>>>> 			DWC3_GEVNTSIZ_INTMASK | DWC3_GEVNTSIZ_SIZE(evt->length));
>>>>> else
>>>>> 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0), DWC3_GEVNTSIZ_SIZE(evt->length));
>>>> Yes, we are expecting the same. But, we must verify the status of
>>>> evt->flags, which will indicate whether the event is currently
>>>> processing in middle or not. The below code is for the reference.
>>>>
>>>> if (!(evt->flags & DWC3_EVENT_PENDING))
>>>> 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
>>>> 			 DWC3_GEVNTSIZ_SIZE(evt->length));
>>>> else
>>>> 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
>>>> 			DWC3_GEVNTSIZ_INTMASK | DWC3_GEVNTSIZ_SIZE(evt->length));
>>> So, this happens while pending_events is set right? I need to review
>>> this runtime suspend flow next week. Something doesn't look right. When
>>> there's a suspend/resume runtime or not, there's a soft disconnect. We
>>> shouldn't be processing any event prior to going into suspend. Also, we
>>> shouldn't be doing soft-disconnect while connected and in operation
>>> unless we specifically tell it to.
>> HI Thinh,
>>
>> Would you be able to review this runtime suspend flow?
>>
>>   From our end, after conducting multiple regression tests, we have
>> determined that the resetting of "evt->flags" are sufficient when
>> attempting to enable event IRQ masks instead of enable event IRQ mask
>> based on pending event flags. There is a possibility that reconnecting
>> USB with the host PC may cause event interrupts to be missed by the CPU
>> if disable event IRQ mask.  So, The fix should be as follow. Could you
>> please review this once from your end?
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index ccc3895dbd7f..3b2441608e9e 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -554,6 +554,15 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
>>                           lower_32_bits(evt->dma));
>>           dwc3_writel(dwc->regs, DWC3_GEVNTADRHI(0),
>>                           upper_32_bits(evt->dma));
>> +
>> +       /*
>> +        * The DWC3_EVENT_PENDING flag is cleared if it has
>> +        * already been set when enabling the event IRQ mask
>> +        * to prevent possibly of an IRQ storm.
>> +        */
>> +       if (evt->flags & DWC3_EVENT_PENDING)
>> +               evt->flags &= ~DWC3_EVENT_PENDING;
>> +
>>           dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
>>                           DWC3_GEVNTSIZ_SIZE(evt->length));
>>           dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), 0);
>>
> Sorry for the delay response.
>
> In addition to that, please rework and rename
> dwc3_gadget_process_pending_event(). We're not supposed to handle any
> left-over event. So remove the manual calls to the interrupt handlers
> there.
Hi Thinh,

Thanks for your comments.

Regarding the handling of leftover events during dwc3 runtime resume, I 
understand that we are not supposed to handle any leftover events. Would 
you be interested in making changes to the code as suggested below? The 
reason for removing interrupt handlers from 
dwc3_gadget_process_pending_events() is to avoid handling any leftover 
events from the last suspend right. If so, based on my understanding, we 
can simply remove the use of dwc3_gadget_process_pending_events() 
instead of rework on this function since it is not necessary if we 
remove the call to interrupt handlers from there.

I would like to reconfirm from our end that in our failure scenario, we 
observe that DWC3_EVENT_PENDING is set in evt->flags when the dwc3 
resume sequence is executed, and the dwc->pending_events flag is not 
being set.



diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index ccc3895dbd7f..63e8dd24ad0e 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -550,6 +550,15 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)

         evt = dwc->ev_buf;
         evt->lpos = 0;
+
+       /*
+        * The DWC3_EVENT_PENDING flag is cleared if it has
+        * already been set when enabling the event IRQ mask
+        * to prevent possibly of an IRQ storm.
+        */
+       if (evt->flags & DWC3_EVENT_PENDING)
+               evt->flags &= ~DWC3_EVENT_PENDING;
+
         dwc3_writel(dwc->regs, DWC3_GEVNTADRLO(0),
lower_32_bits(evt->dma));
         dwc3_writel(dwc->regs, DWC3_GEVNTADRHI(0),
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 89fc690fdf34..951c805337c2 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4739,8 +4739,6 @@ int dwc3_gadget_resume(struct dwc3 *dwc)
  void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
  {
         if (dwc->pending_events) {
- dwc3_interrupt(dwc->irq_gadget, dwc->ev_buf);
- dwc3_thread_interrupt(dwc->irq_gadget, dwc->ev_buf);
                 pm_runtime_put(dwc->dev);
                 dwc->pending_events = false;
enable_irq(dwc->irq_gadget);


Thanks,
Selva

>
> On runtime suspend, the device is soft disconnected. So any interrupt
> assertion to notify a new connection must be a custom configuration of
> your platform. No event should be generated while the run_stop bit is
> cleared.
>
> On runtime resume, we will initiate soft-reset and soft-connect to
> restore the run_stop bit. A new connection event will be generated then.

Agree.


>
> Thanks,
> Thinh

