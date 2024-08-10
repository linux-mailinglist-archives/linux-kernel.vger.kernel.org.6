Return-Path: <linux-kernel+bounces-281957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2D594DD78
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 17:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E9F1F21ACD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 15:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AE416A925;
	Sat, 10 Aug 2024 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="maQmKgX+"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FAD166314
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723303507; cv=none; b=uL4mNoPw1VAOdUhmklOa/h6x7Pbnrhx+uxpBDP0Mko42b5JnmusJ9ehiN5rMUtxriWDmQxZ7AA172q6jGNjEfl21v8ZouQvdwd8f75wfZEm/RW2AynRkb6w4tnhigTs/aUAVbCCcWl0CIqU8HMzWrMgIExgQYyiLAQd7frs2WU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723303507; c=relaxed/simple;
	bh=W6P5mhHnBDt8GTxk6TjzOmyyfhkvaPS3xldpqvB5tUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=brB9HA+SBa4+x4kjC83+QPLYf1HL3QIzU/dDz+oBQeYTXc+o9D9XqmNBeXRUe5iQFSu2xi5/a5KD0HgIGRU46V/Nn3Z/EVgRTJDe6ii5agQqfS5P4+hY4MteYeIGZux2yGGFaA+YNo4J8s3ZGBQjvB4j1JaDCQkdb3ehX49b5dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=maQmKgX+; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240810152457epoutp0270836394143f0c46feb6fdc97a174b88~qZ2Z7l-l-0659406594epoutp02b
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 15:24:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240810152457epoutp0270836394143f0c46feb6fdc97a174b88~qZ2Z7l-l-0659406594epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723303497;
	bh=V62DCjCfgaGoBP6BvPH2p9TGD9S+1fBA6+ndYZM8SWM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=maQmKgX+vKomztKkg0ZRUSHMYVnQMaCv4mIUKskWhgl4yrHQX8AfaVArqcL8Vca6M
	 Q3m3n2ORH6h8HjjCUzvZ/wCf0lpEP8bgW8gRVTQ512SVKa+1HsffoKqT+a5k3sinc5
	 h3NpGXSWeFggS/heYIn+Oz6dV9pyrxYkMzK260Lo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240810152456epcas5p34c9245d0db0a81e87b2b88b536b75d85~qZ2ZSpyHK2660726607epcas5p3N;
	Sat, 10 Aug 2024 15:24:56 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Wh4Mq32Y0z4x9Pp; Sat, 10 Aug
	2024 15:24:55 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	89.51.09743.74687B66; Sun, 11 Aug 2024 00:24:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240810151456epcas5p30ac47e95a0f55cdf81410495389abd2c~qZtqwnE9o1956319563epcas5p3O;
	Sat, 10 Aug 2024 15:14:56 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240810151456epsmtrp2f5a28982d9f3ecacef1ee0878136aa3f~qZtqv54790514905149epsmtrp2m;
	Sat, 10 Aug 2024 15:14:56 +0000 (GMT)
X-AuditID: b6c32a4a-14fff7000000260f-b5-66b78647ffd3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F1.12.08456.0F387B66; Sun, 11 Aug 2024 00:14:56 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240810151454epsmtip2b5a42ba0b969f1a4043a0a18540e7ac8~qZtoziKD-2489724897epsmtip2l;
	Sat, 10 Aug 2024 15:14:54 +0000 (GMT)
Message-ID: <7fbd2cce-20a0-43c1-862a-3e0b756d8920@samsung.com>
Date: Sat, 10 Aug 2024 20:44:53 +0530
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
In-Reply-To: <20240809234540.wyanxgos7j4d7cu2@synopsys.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmpq572/Y0g2kP+C3eXF3FanFnwTQm
	i1PLFzJZNC9ez2Yxac9WFou7D3+wWFzeNYfNYtGyVmaLT0f/s1qs6pwDFPu+k9li0kFRi1UL
	DrA78Hrsn7uG3aNvyypGjy37PzN6fN4kF8ASlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pm
	YKhraGlhrqSQl5ibaqvk4hOg65aZA3SekkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUg
	JafApECvODG3uDQvXS8vtcTK0MDAyBSoMCE74/+Ku0wFnUYV3xa+YWpgnK3excjJISFgInG7
	aTZjFyMXh5DAbkaJb+fWsYIkhAQ+MUqs3ywCkfjGKHHoZgsjTMfkxQtYIBJ7GSWurFrGAtHx
	llFi70FTEJtXwE5i85MJbCA2i4CqxOPD99kg4oISJ2c+AasXFZCXuH9rBjuILSwQIHFlyQyw
	BSICOhIHTpxnAlnALNDBKrGgu40JJMEsIC5x68l8IJuDg03AUOLZCRuQMKeAtcTtZ1sYIUrk
	JZq3zmYG6ZUQ2MIhsW/NJVaIq10kPp56BmULS7w6voUdwpaS+PxuLxuEXS2x+s5HNojmFkaJ
	w0++QRXZSzw++ogZZDGzgKbE+l36EGFZiamn1kHdxifR+/sJE0ScV2LHPBhbVeJU42Wo+dIS
	95Zcg7rBQ2LSk+0sExgVZyGFyywkb85C8s8shM0LGFlWMUqmFhTnpqcWmxYY5aWWwyM8OT93
	EyM49Wp57WB8+OCD3iFGJg7GQ4wSHMxKIrzN4ZvShHhTEiurUovy44tKc1KLDzGaAiNoIrOU
	aHI+MPnnlcQbmlgamJiZmZlYGpsZKonzvm6dmyIkkJ5YkpqdmlqQWgTTx8TBKdXAlBFobb1A
	bMepq+LJSufm5y82Et0RMiksQfly7xeXd95y8bvuVF/zvpniK2vodtOpv2mLg5/ORXmLxz9l
	Pi1pX2rnUCice0lm066k7z4f7XlLQ69sfbxy5ae5d2wn79/1tN/u4vEd0fu4i14WWz7IcU4/
	Ib+T1X4x909dL4EkkRqDqHmm2WtuNZ8vXWG4zmGPBGN06pUOxpKTT8vy2Z7famFbErj4puzC
	c5pXX57jcdnSLaQ/LzxNYrLl75g/fZbTL3TMjBE1d3scLHDZeNICPSGetTvW/ZTylXkfd5dR
	cqr31RXGP9kytIPlFuw6On2ewDTZtTPq1l6Y/urv5bK1FzeIWVTkV738U2Xe5a4dqcRSnJFo
	qMVcVJwIAHjgkL5GBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSvO6H5u1pBj1L1SzeXF3FanFnwTQm
	i1PLFzJZNC9ez2Yxac9WFou7D3+wWFzeNYfNYtGyVmaLT0f/s1qs6pwDFPu+k9li0kFRi1UL
	DrA78Hrsn7uG3aNvyypGjy37PzN6fN4kF8ASxWWTkpqTWZZapG+XwJXxf8VdpoJOo4pvC98w
	NTDOVu9i5OSQEDCRmLx4AUsXIxeHkMBuRonVZ34yQiSkJV7P6oKyhSVW/nvODlH0mlHi06s7
	LCAJXgE7ic1PJrCB2CwCqhKPD99ng4gLSpyc+QSsRlRAXuL+rRnsILawgJ/E9DcnwIaKCOhI
	HDhxnglkKLNAD6vEl68foc7Ywyxxb/p2VpAqZgFxiVtP5gNVcXCwCRhKPDthAxLmFLCWuP1s
	CyNEiZlE19YuKFteonnrbOYJjEKzkNwxC8mkWUhaZiFpWcDIsopRMrWgODc9t9iwwCgvtVyv
	ODG3uDQvXS85P3cTIzjStLR2MO5Z9UHvECMTB+MhRgkOZiUR3ubwTWlCvCmJlVWpRfnxRaU5
	qcWHGKU5WJTEeb+97k0REkhPLEnNTk0tSC2CyTJxcEo1MOlsOP513Q65XqZMhh0aZZPnmyep
	SnjLOWTo9xfdDdgi+OZIYNKXJ7dl/2++u7GKbbZ93vI/skEMV1YYl+7RSmK4bWz6+lrA/Pup
	ktcTeWf73tc1t322Np79/8tD12ys9X71lE2wUpUwDrusrfN6bXnKy7+NsxZFmt+NufnV99N9
	28iAB7adv79vFCvMfCW37Z2brobcRo9grr4VfiePTmPv4NvL0y73IVxCQr3EQPRj3sKCd0zL
	j85fkvrpV8KsufJM7240nWr5NGOz5q/Lv7Q/JcWv515wqoItY0Ys75/PEUEfGSSiNk3XCbF5
	Wyh7s+qv/7NX7oKGfpxh0t8PZdmEZixdvXnNRc2zUp/7NimxFGckGmoxFxUnAgCgptmMIwMA
	AA==
X-CMS-MailID: 20240810151456epcas5p30ac47e95a0f55cdf81410495389abd2c
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
	<20240809234540.wyanxgos7j4d7cu2@synopsys.com>


On 8/10/2024 5:15 AM, Thinh Nguyen wrote:
> On Fri, Aug 09, 2024, Thinh Nguyen wrote:
>> On Thu, Aug 08, 2024, Selvarasu Ganesan wrote:
>>> On 8/8/2024 6:45 AM, Thinh Nguyen wrote:
>>>> On Wed, Aug 07, 2024, Selvarasu Ganesan wrote:
>>>>> On 8/7/2024 6:08 AM, Thinh Nguyen wrote:
>>>>>> On Fri, Jul 19, 2024, Selvarasu Ganesan wrote:
>>>>>>> In certain scenarios, there is a chance that the CPU may not be
>>>>>>> scheduled the bottom half of dwc3 interrupt. This is because the CPU
>>>>>>> may hang up where any work queue lockup has happened for the same CPU
>>>>>>> that is trying to schedule the dwc3 thread interrupt. In this scenario,
>>>>>>> the USB can enter runtime suspend as the bus may idle for a longer time
>>>>>>> , or user can reconnect the USB cable. Then, the dwc3 event interrupt
>>>>>>> can be enabled when runtime resume is happening with regardless of the
>>>>>>> previous event status. This can lead to a dwc3 IRQ storm due to the
>>>>>>> return from the interrupt handler by checking only the evt->flags as
>>>>>>> DWC3_EVENT_PENDING, where the same flag was set as DWC3_EVENT_PENDING
>>>>>>> in previous work queue lockup.
>>>>>>> Let's consider the following sequences in this scenario,
>>>>>>>
>>>>>>> Call trace of dwc3 IRQ after workqueue lockup scenario
>>>>>>> ======================================================
>>>>>>> IRQ #1:
>>>>>>> ->dwc3_interrupt()
>>>>>>>      ->dwc3_check_event_buf()
>>>>>>>            ->if (evt->flags & DWC3_EVENT_PENDING)
>>>>>>>                         return IRQ_HANDLED;
>>>>>>>            ->evt->flags |= DWC3_EVENT_PENDING;
>>>>>>>            ->/* Disable interrupt by setting DWC3_GEVNTSIZ_INTMASK  in
>>>>>>>                                                            DWC3_GEVNTSIZ
>>>>>>>            ->return IRQ_WAKE_THREAD; // No workqueue scheduled for dwc3
>>>>>>>                                         thread_fu due to workqueue lockup
>>>>>>>                                         even after return IRQ_WAKE_THREAD
>>>>>>>                                         from top-half.
>>>>>>>
>>>>>>> Thread #2:
>>>>>>> ->dwc3_runtime_resume()
>>>>>>>     ->dwc3_resume_common()
>>>>>>>       ->dwc3_gadget_resume()
>>>>>>>          ->dwc3_gadget_soft_connect()
>>>>>>>            ->dwc3_event_buffers_setup()
>>>>>>>               ->/*Enable interrupt by clearing  DWC3_GEVNTSIZ_INTMASK in
>>>>>>>                                                            DWC3_GEVNTSIZ*/
>>>>>>>
>>>>>>> Start IRQ Storming after enable dwc3 event in resume path
>>>>>>> =========================================================
>>>>>>> CPU0: IRQ
>>>>>>> dwc3_interrupt()
>>>>>>>     dwc3_check_event_buf()
>>>>>>>            if (evt->flags & DWC3_EVENT_PENDING)
>>>>>>>             return IRQ_HANDLED;
>>>>>>>
>>>>>>> CPU0: IRQ
>>>>>>> dwc3_interrupt()
>>>>>>>     dwc3_check_event_buf()
>>>>>>>            if (evt->flags & DWC3_EVENT_PENDING)
>>>>>>>             return IRQ_HANDLED;
>>>>>>> ..
>>>>>>> ..
>>>>>>>
>>>>>>> To fix this issue by avoiding enabling of the dwc3 event interrupt in
>>>>>>> the runtime resume path if dwc3 event processing is in progress.
>>>>>>>
>>>>>>> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
>>>>>>> ---
>>>>>>>     drivers/usb/dwc3/core.c | 8 ++++++--
>>>>>>>     1 file changed, 6 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>>>>>> index cb82557678dd..610792a70805 100644
>>>>>>> --- a/drivers/usb/dwc3/core.c
>>>>>>> +++ b/drivers/usb/dwc3/core.c
>>>>>>> @@ -549,8 +549,12 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
>>>>>>>     			lower_32_bits(evt->dma));
>>>>>>>     	dwc3_writel(dwc->regs, DWC3_GEVNTADRHI(0),
>>>>>>>     			upper_32_bits(evt->dma));
>>>>>>> -	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
>>>>>>> -			DWC3_GEVNTSIZ_SIZE(evt->length));
>>>>>>> +
>>>>>>> +	/* Skip enable dwc3 event interrupt if event is processing in middle */
>>>>>>> +	if (!(evt->flags & DWC3_EVENT_PENDING))
>>>>>>> +		dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
>>>>>>> +				DWC3_GEVNTSIZ_SIZE(evt->length));
>>>>>>> +
>>>>>>>     	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), 0);
>>>>>>>     
>>>>>>>     	return 0;
>>>>>>> -- 
>>>>>>> 2.17.1
>>>>>>>
>>>>>> We're not waking up from a hibernation. So after a soft-reset and
>>>>>> resume, the events that weren't processed are stale. They should be
>>>>>> processed prior to entering suspend or be discarded before resume.
>>>>>>
>>>>>> The synchronize_irq() during suspend() was not sufficient to prevent
>>>>>> this? What are we missing here.
>>>>>>
>>>>>> Thanks,
>>>>>> Thinh
>>>>> I don’t think the triggering of interrupt would not be stopped even if
>>>>> do soft reset. It's because of event count is may be valid .
>>>> Ok. I think I see what you're referring to when you say "event is
>>>> processing in the middle" now.
>>>>
>>>> What you want to check is probably this in dwc3_event_buffers_setup().
>>>> Please confirm:
>>>>
>>>> if (dwc->pending_events)
>>>> 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
>>>> 			DWC3_GEVNTSIZ_INTMASK | DWC3_GEVNTSIZ_SIZE(evt->length));
>>>> else
>>>> 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0), DWC3_GEVNTSIZ_SIZE(evt->length));
>>> Yes, we are expecting the same. But, we must verify the status of
>>> evt->flags, which will indicate whether the event is currently
>>> processing in middle or not. The below code is for the reference.
>>>
>>> if (!(evt->flags & DWC3_EVENT_PENDING))
>>> 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
>>> 			 DWC3_GEVNTSIZ_SIZE(evt->length));
>>> else
>>> 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
>>> 			DWC3_GEVNTSIZ_INTMASK | DWC3_GEVNTSIZ_SIZE(evt->length));
>> So, this happens while pending_events is set right? I need to review
>> this runtime suspend flow next week. Something doesn't look right. When

yes. You are correct. Its happening while pending_events is set.
>> there's a suspend/resume runtime or not, there's a soft disconnect. We
>> shouldn't be processing any event prior to going into suspend. Also, we
> Clarification: I mean we shouldn't process any event that happened prior
> to suspend on resume because there was a disconnect.

Agree.
>
>> shouldn't be doing soft-disconnect while connected and in operation
>> unless we specifically tell it to.
> Thinh

