Return-Path: <linux-kernel+bounces-308804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 352E0966200
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598471C22331
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFAB1A4AAB;
	Fri, 30 Aug 2024 12:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uWd0DB9C"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CD813C3D5
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 12:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725022059; cv=none; b=NY5mcp9dtoI1NBfk1yjayd6zhFE3uwczjopYE7xxlmitwdVqQrAC87cqD/j4PvI9Fanb93i2ZbKw42HYdtIoLqlml+U8PJXbw9Z4w2VnAZUxCE/nQ3mWJS4qEaqeZ7hXCJPpMcNMGcHBp8KRyTpI5CkmUIWP+IoUIHzbtAYtV/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725022059; c=relaxed/simple;
	bh=4gvxmS9TvItrhCfjogXw1j7nH+Lm5xjeHghHhmbWmIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=M8D0N31l49t0ehw2raBfTCIT25MkrjkalDegLTvUnuIy0/+Ys1WjF0IDC2gjGtkREfSAhTzbpAITixiG/h80HLB5QPBukMoRlnNDXxMY19bSDfyNL0d/GCIC+MVZp7lNlJ7yZaleEIs7PABXW4T00T7XP4ncdlHAZPxnC4W5BJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uWd0DB9C; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240830124730epoutp0458c0611feffa758924433ff3ef22e62e~wgmpExHF70832708327epoutp04h
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 12:47:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240830124730epoutp0458c0611feffa758924433ff3ef22e62e~wgmpExHF70832708327epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725022050;
	bh=3JkjFYf+4qlxI5zfoyr4dB3RANjBNh7DK088pyLCacw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=uWd0DB9CWVP4vpkFWimUQcAOUmvnTVFxIQ+MH2EmZ1UWfYwMjuUH7UuAGHksevzxm
	 LMfBtvRmDyOaORiMkZ5GD4AxjiZTKa+ibJuDDBUqPcK2ml2xLvd2KO6ViIqwiptCLB
	 XV1Eb+hx767vEuCPpWlh9kgoJokkejhyIHZMIm+w=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240830124729epcas5p456c5e28f73cc73332971e5dd7b419aab~wgmotU7cI0928409284epcas5p4e;
	Fri, 30 Aug 2024 12:47:29 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WwHww4FHfz4x9Pr; Fri, 30 Aug
	2024 12:47:28 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CF.49.09642.06FB1D66; Fri, 30 Aug 2024 21:47:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240830121630epcas5p233ce5797f1df6de841a6627e892463e1~wgLlZtfCX1375313753epcas5p2-;
	Fri, 30 Aug 2024 12:16:30 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240830121630epsmtrp11022322a25aa358ab86b541e19b49280~wgLlY5Hx20067200672epsmtrp1L;
	Fri, 30 Aug 2024 12:16:30 +0000 (GMT)
X-AuditID: b6c32a4b-879fa700000025aa-f7-66d1bf60c6c0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0E.DE.07567.E18B1D66; Fri, 30 Aug 2024 21:16:30 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240830121628epsmtip276d2b88ffc81dda59760c8d0a9a584ec~wgLixWXRF1786417864epsmtip2a;
	Fri, 30 Aug 2024 12:16:27 +0000 (GMT)
Message-ID: <b273201d-c589-4c57-9d57-ad2affaeade0@samsung.com>
Date: Fri, 30 Aug 2024 17:46:26 +0530
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
In-Reply-To: <20240809234227.eriwy5e6leatzdyh@synopsys.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmlm7C/otpBneviVm8ubqK1eLOgmlM
	FqeWL2SyaF68ns1i0p6tLBZ3H/5gsbi8aw6bxaJlrcwWn47+Z7VY1TkHKPZ9J7PFpIOiFqsW
	HGB34PXYP3cNu0ffllWMHlv2f2b0+LxJLoAlKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTM
	wFDX0NLCXEkhLzE31VbJxSdA1y0zB+g8JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpB
	Sk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2xsdLs5gK9jhW/D14iLWBcZpJFyMnh4SAicTP
	D8+Zuxi5OIQEdjNKrN2/lxXC+cQo8ebqPSjnG6PEub4NbF2MHGAt8+5bQcT3AhXNe8EC4bxl
	lDjwtp8RZC6vgJ3E7YmfmUAaWARUJX5+4oAIC0qcnPmEBcQWFZCXuH9rBjuILSwQIHFlyQyw
	VhEBHYkDJ84zgcxkFuhglVjQ3cYEkmAWEJe49WQ+2Ew2AUOJZydsQExOAWuJSRN8ISrkJZq3
	zgb7RkJgLYfE0hU7mSBudpG4NbcS4mNhiVfHt7BD2FISL/vboOxqidV3PrJB9LYwShx+8g0q
	YS/x+OgjZpA5zAKaEut36UOEZSWmnloHdRmfRO/vJ0wQcV6JHfNgbFWJU42X2SBsaYl7S66x
	QtgeEpOebGeZwKg4CylUZiF5chaSd2YhbF7AyLKKUTK1oDg3PbXYtMA4L7UcHt3J+bmbGMFp
	V8t7B+OjBx/0DjEycTAeYpTgYFYS4V2652KaEG9KYmVValF+fFFpTmrxIUZTYOxMZJYSTc4H
	Jv68knhDE0sDEzMzMxNLYzNDJXHe161zU4QE0hNLUrNTUwtSi2D6mDg4pRqYYuenWyusTPZp
	0ci9nbH/jbvFtwzpinuzTq0Luqu7x/rpkvvaOe7ZJdc4HLe+2PIl69KlFX8rzu07+1Ns8rvV
	E1mFAv5oHzAtyZmheWZ7UpnD5VnWwZf+c95I03ISvHZlfVrdEcU6vov77GQaHIumXRM5cfJe
	CLuDau40c1/Oha69a2aZyk/26szeLpqv8MZxJ5Psp3aBhRnrpxyySrsY8ePFPfNJC+edNTlh
	tDT2annZRc8nS5ZI3j8Q7qTDqHP260wni2l+07LPsf8t8g3jDVAQscparGh94ZmDbqfk76wK
	v23KLWdP1C0671S4RqEpMLnKUuJVk0SF+kRnXQf7STpm8798ylYP/KPI1++sxFKckWioxVxU
	nAgAx4aET0QEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJXldux8U0g40/VSzeXF3FanFnwTQm
	i1PLFzJZNC9ez2Yxac9WFou7D3+wWFzeNYfNYtGyVmaLT0f/s1qs6pwDFPu+k9li0kFRi1UL
	DrA78Hrsn7uG3aNvyypGjy37PzN6fN4kF8ASxWWTkpqTWZZapG+XwJXx8dIspoI9jhV/Dx5i
	bWCcZtLFyMEhIWAiMe++VRcjF4eQwG5Gieer9jN3MXICxaUlXs/qYoSwhSVW/nvODlH0mlFi
	14L5TCAJXgE7idsTPzOBDGIRUJX4+YkDIiwocXLmExYQW1RAXuL+rRnsILawgJ/E9DcnwGaK
	COhIHDhxnglkJrNAD6vEl68fWSAWdDNLzLz2CqyKWUBc4taT+WAL2AQMJZ6dsAExOQWsJSZN
	8IWoMJPo2toFVS0v0bx1NvMERqFZSM6YhWTQLCQts5C0LGBkWcUomVpQnJuem2xYYJiXWq5X
	nJhbXJqXrpecn7uJERxjWho7GO/N/6d3iJGJg/EQowQHs5II74njZ9OEeFMSK6tSi/Lji0pz
	UosPMUpzsCiJ8xrOmJ0iJJCeWJKanZpakFoEk2Xi4JRqYNLTT51wRqZcRPDhTsdFoTtmznNl
	2LFJ4r5s972reYo/kst6OnlqBA+7GG9ZxxjbfUVvgkYUp+OCi9x3L5zyD7Xk7ku/fKRZp5uh
	kfnJFYaYcL1g60eHf9enq3y6sflFtoZyf8HHhIbWx+L6STqLsmdz6G6aIFvM2HVuT/bv3V3M
	h873P2jTLZ3R9te318zq4P1rHTyKf54eaUjKEz4bwVQ+SfqDss4Dv27u0lkPquNWtrbOXsG8
	Q/LSorfnj5+tfHbFNas/Zxd3/PVFj05sDC7/WHL3zPfZXbd84pM4H15QZhX4+jLNv33u/ddz
	Z63s3ytVzl4cE/jxVunK37cDjq7r1mU/MVe93PNlPVdljBJLcUaioRZzUXEiAMRox+EgAwAA
X-CMS-MailID: 20240830121630epcas5p233ce5797f1df6de841a6627e892463e1
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


On 8/10/2024 5:12 AM, Thinh Nguyen wrote:
> On Thu, Aug 08, 2024, Selvarasu Ganesan wrote:
>> On 8/8/2024 6:45 AM, Thinh Nguyen wrote:
>>> On Wed, Aug 07, 2024, Selvarasu Ganesan wrote:
>>>> On 8/7/2024 6:08 AM, Thinh Nguyen wrote:
>>>>> On Fri, Jul 19, 2024, Selvarasu Ganesan wrote:
>>>>>> In certain scenarios, there is a chance that the CPU may not be
>>>>>> scheduled the bottom half of dwc3 interrupt. This is because the CPU
>>>>>> may hang up where any work queue lockup has happened for the same CPU
>>>>>> that is trying to schedule the dwc3 thread interrupt. In this scenario,
>>>>>> the USB can enter runtime suspend as the bus may idle for a longer time
>>>>>> , or user can reconnect the USB cable. Then, the dwc3 event interrupt
>>>>>> can be enabled when runtime resume is happening with regardless of the
>>>>>> previous event status. This can lead to a dwc3 IRQ storm due to the
>>>>>> return from the interrupt handler by checking only the evt->flags as
>>>>>> DWC3_EVENT_PENDING, where the same flag was set as DWC3_EVENT_PENDING
>>>>>> in previous work queue lockup.
>>>>>> Let's consider the following sequences in this scenario,
>>>>>>
>>>>>> Call trace of dwc3 IRQ after workqueue lockup scenario
>>>>>> ======================================================
>>>>>> IRQ #1:
>>>>>> ->dwc3_interrupt()
>>>>>>      ->dwc3_check_event_buf()
>>>>>>            ->if (evt->flags & DWC3_EVENT_PENDING)
>>>>>>                         return IRQ_HANDLED;
>>>>>>            ->evt->flags |= DWC3_EVENT_PENDING;
>>>>>>            ->/* Disable interrupt by setting DWC3_GEVNTSIZ_INTMASK  in
>>>>>>                                                            DWC3_GEVNTSIZ
>>>>>>            ->return IRQ_WAKE_THREAD; // No workqueue scheduled for dwc3
>>>>>>                                         thread_fu due to workqueue lockup
>>>>>>                                         even after return IRQ_WAKE_THREAD
>>>>>>                                         from top-half.
>>>>>>
>>>>>> Thread #2:
>>>>>> ->dwc3_runtime_resume()
>>>>>>     ->dwc3_resume_common()
>>>>>>       ->dwc3_gadget_resume()
>>>>>>          ->dwc3_gadget_soft_connect()
>>>>>>            ->dwc3_event_buffers_setup()
>>>>>>               ->/*Enable interrupt by clearing  DWC3_GEVNTSIZ_INTMASK in
>>>>>>                                                            DWC3_GEVNTSIZ*/
>>>>>>
>>>>>> Start IRQ Storming after enable dwc3 event in resume path
>>>>>> =========================================================
>>>>>> CPU0: IRQ
>>>>>> dwc3_interrupt()
>>>>>>     dwc3_check_event_buf()
>>>>>>            if (evt->flags & DWC3_EVENT_PENDING)
>>>>>>             return IRQ_HANDLED;
>>>>>>
>>>>>> CPU0: IRQ
>>>>>> dwc3_interrupt()
>>>>>>     dwc3_check_event_buf()
>>>>>>            if (evt->flags & DWC3_EVENT_PENDING)
>>>>>>             return IRQ_HANDLED;
>>>>>> ..
>>>>>> ..
>>>>>>
>>>>>> To fix this issue by avoiding enabling of the dwc3 event interrupt in
>>>>>> the runtime resume path if dwc3 event processing is in progress.
>>>>>>
>>>>>> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
>>>>>> ---
>>>>>>     drivers/usb/dwc3/core.c | 8 ++++++--
>>>>>>     1 file changed, 6 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>>>>> index cb82557678dd..610792a70805 100644
>>>>>> --- a/drivers/usb/dwc3/core.c
>>>>>> +++ b/drivers/usb/dwc3/core.c
>>>>>> @@ -549,8 +549,12 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
>>>>>>     			lower_32_bits(evt->dma));
>>>>>>     	dwc3_writel(dwc->regs, DWC3_GEVNTADRHI(0),
>>>>>>     			upper_32_bits(evt->dma));
>>>>>> -	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
>>>>>> -			DWC3_GEVNTSIZ_SIZE(evt->length));
>>>>>> +
>>>>>> +	/* Skip enable dwc3 event interrupt if event is processing in middle */
>>>>>> +	if (!(evt->flags & DWC3_EVENT_PENDING))
>>>>>> +		dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
>>>>>> +				DWC3_GEVNTSIZ_SIZE(evt->length));
>>>>>> +
>>>>>>     	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), 0);
>>>>>>     
>>>>>>     	return 0;
>>>>>> -- 
>>>>>> 2.17.1
>>>>>>
>>>>> We're not waking up from a hibernation. So after a soft-reset and
>>>>> resume, the events that weren't processed are stale. They should be
>>>>> processed prior to entering suspend or be discarded before resume.
>>>>>
>>>>> The synchronize_irq() during suspend() was not sufficient to prevent
>>>>> this? What are we missing here.
>>>>>
>>>>> Thanks,
>>>>> Thinh
>>>> I don’t think the triggering of interrupt would not be stopped even if
>>>> do soft reset. It's because of event count is may be valid .
>>> Ok. I think I see what you're referring to when you say "event is
>>> processing in the middle" now.
>>>
>>> What you want to check is probably this in dwc3_event_buffers_setup().
>>> Please confirm:
>>>
>>> if (dwc->pending_events)
>>> 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
>>> 			DWC3_GEVNTSIZ_INTMASK | DWC3_GEVNTSIZ_SIZE(evt->length));
>>> else
>>> 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0), DWC3_GEVNTSIZ_SIZE(evt->length));
>> Yes, we are expecting the same. But, we must verify the status of
>> evt->flags, which will indicate whether the event is currently
>> processing in middle or not. The below code is for the reference.
>>
>> if (!(evt->flags & DWC3_EVENT_PENDING))
>> 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
>> 			 DWC3_GEVNTSIZ_SIZE(evt->length));
>> else
>> 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
>> 			DWC3_GEVNTSIZ_INTMASK | DWC3_GEVNTSIZ_SIZE(evt->length));
> So, this happens while pending_events is set right? I need to review
> this runtime suspend flow next week. Something doesn't look right. When
> there's a suspend/resume runtime or not, there's a soft disconnect. We
> shouldn't be processing any event prior to going into suspend. Also, we
> shouldn't be doing soft-disconnect while connected and in operation
> unless we specifically tell it to.
HI Thinh,

Would you be able to review this runtime suspend flow?

 From our end, after conducting multiple regression tests, we have 
determined that the resetting of "evt->flags" are sufficient when 
attempting to enable event IRQ masks instead of enable event IRQ mask 
based on pending event flags. There is a possibility that reconnecting 
USB with the host PC may cause event interrupts to be missed by the CPU 
if disable event IRQ mask.  So, The fix should be as follow. Could you 
please review this once from your end?

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index ccc3895dbd7f..3b2441608e9e 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -554,6 +554,15 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
                         lower_32_bits(evt->dma));
         dwc3_writel(dwc->regs, DWC3_GEVNTADRHI(0),
                         upper_32_bits(evt->dma));
+
+       /*
+        * The DWC3_EVENT_PENDING flag is cleared if it has
+        * already been set when enabling the event IRQ mask
+        * to prevent possibly of an IRQ storm.
+        */
+       if (evt->flags & DWC3_EVENT_PENDING)
+               evt->flags &= ~DWC3_EVENT_PENDING;
+
         dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
                         DWC3_GEVNTSIZ_SIZE(evt->length));
         dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), 0);

Thanks,
Selva
>
>>>> Let consider the scenarios where SW is not acknowledge the event count
>>>> after getting a interrupt with disable GEVNTSIZ_INTMASK =0. It will
>>>> triggering the spurious interrupts until enable GEVNTSIZ_INTMASK=1 or
>>>> acknowledge the event count by SW. This is happening here because of We
>>>> just return from interrupt handler by checking if evt->flags as
>>>> DWC3_EVENT_PENDING. Clearing of DWC3_EVENT_PENDING flag is done in
>>>> dwc3_thread_interrupt. In some scenario it's not happening due to cpu
>>>> hangup or work queue lockup.
>>> This can be mitigated by adjusting the imod_interval (interrupt
>>> moderation). Have you tried that?
>>
>> Yes we tried to play around the changing of imod interval value but no
>> improvements.
> Ok.
>
> Thanks,
> Thinh

