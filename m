Return-Path: <linux-kernel+bounces-317957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E289496E60A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 01:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45DF2B23DA4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 23:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985311B3B31;
	Thu,  5 Sep 2024 23:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="a5b5TLk8"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56E418EFF8
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 23:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725577558; cv=none; b=SEoWr9MY+8Mgg0YHICYDwD+CFoZBg1opM8Jx6DTlg7azL+FxdnUggsHPuv6LCbjUF/E02Lswj7gAb30lIyAgyOzNOUpveok8jIRF82KHACKatrgf73PT5ROngbb0aMuJatll3p5P2ohQuGJNopN7vmk/xqIdGzO33vsBE3ZhlFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725577558; c=relaxed/simple;
	bh=+4O5N9e8+9ul/xN0mXB3WQdSIhKwso4YrdP1WuTwEMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=k012DeMxO3gryyGK/IVsFtJd/0oNtWb9XhNWzDW+8TWXnsvmn+7twIG2COFWoL99Z2XJdECuBHbU+lmmG+ZbXZG4UKnOMzQN6K0VKl56W5cyZ8JorRxs/0aMHXZRHkjPXde7CRcZ+AnR7Gs/cQjTFWgAERfAhzPwVA83LQq6nUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=a5b5TLk8; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240905230546epoutp04a8b54673e7532a8b15fe66fc39ff4385~ye6LScLOJ3129631296epoutp04F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 23:05:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240905230546epoutp04a8b54673e7532a8b15fe66fc39ff4385~ye6LScLOJ3129631296epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725577546;
	bh=xmRoz3FyRgWNcA3DQK0/z0O8dXuvPWc1FqhwHlhQGJ4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=a5b5TLk8R7VmMicH+jbpU6170wAfD02WMgydtoEqry9PR5MNwT7IafsZZ0sO7jOAE
	 UWhuC2+Pm2/p+Vec2iddjiBJ3tmIAmXxA4B2qq4CRCE0Tu4xI6skYl3+NKCLxR2c4C
	 XE2hf48QMW5DGDHIUQxcrtNVzX/E0xxa/tJbOWTc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240905230545epcas5p1bf74fbf6e23454285fbecc1aa584c65c~ye6KeEyb-1489714897epcas5p1n;
	Thu,  5 Sep 2024 23:05:45 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4X0FMW5x46z4x9Q3; Thu,  5 Sep
	2024 23:05:43 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	26.14.09640.7493AD66; Fri,  6 Sep 2024 08:05:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240905230543epcas5p431c4ef16a34eb9b098845551b993218f~ye6IN1u0h2568025680epcas5p4l;
	Thu,  5 Sep 2024 23:05:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240905230543epsmtrp1cde676dc32f788f3ec3a5515bcaf6194~ye6INDfFO0488504885epsmtrp1P;
	Thu,  5 Sep 2024 23:05:43 +0000 (GMT)
X-AuditID: b6c32a49-aabb8700000025a8-1b-66da39479f5d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7D.AD.08964.6493AD66; Fri,  6 Sep 2024 08:05:42 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240905230540epsmtip269bef7c34e3e34df92fad931bb2b1456~ye6FscI3G2416424164epsmtip2U;
	Thu,  5 Sep 2024 23:05:40 +0000 (GMT)
Message-ID: <f9561f03-5f83-4270-b7f3-17b880cfabfe@samsung.com>
Date: Fri, 6 Sep 2024 04:35:38 +0530
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
In-Reply-To: <20240905211338.omst6jr3okbxkqdh@synopsys.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmuq675a00g68rNS3eXF3FanFnwTQm
	i1PLFzJZNC9ez2Yxac9WFou7D3+wWFzeNYfNYtGyVmaLT0f/s1qs6pwDFPu+k9li0kFRi1UL
	DrA78Hrsn7uG3aNvyypGjy37PzN6fN4kF8ASlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pm
	YKhraGlhrqSQl5ibaqvk4hOg65aZA3SekkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUg
	JafApECvODG3uDQvXS8vtcTK0MDAyBSoMCE741n3K9aCNx4Vm9/8YWlg/GXdxcjJISFgInHq
	xQ/2LkYuDiGB3YwS0//3sEA4nxglpp14wQJSJSTwjVFiZSM7TMexe/8YIYr2MkosetkO5bxl
	lNhxdRFYFa+AncSdX68YQWwWARWJ6S07oeKCEidnPgGbKiogL3H/1gywuLBAgMSVJTPA6kUE
	dCQOnDjPBDKUWaCDVWJBdxsTSIJZQFzi1pP5QDYHB5uAocSzEzYgYU4Ba4lntxeyQJTISzRv
	nc0M0ishsJZDouFKG9TZLhIXGvcxQ9jCEq+Ob4GKS0m87IepqZZYfecjG0RzC6PE4SffoBL2
	Eo+PPmIGWcwsoCmxfpc+xDI+id7fT8DukRDglehoE4KoVpU41XiZDcKWlri35BorRImHxK+l
	vJCwus0icejrFPYJjAqzkIJlFpIvZyF5ZxbC4gWMLKsYJVMLinPTU4tNCwzzUsvhEZ6cn7uJ
	EZx6tTx3MN598EHvECMTB+MhRgkOZiUR3tciN9KEeFMSK6tSi/Lji0pzUosPMZoC42cis5Ro
	cj4w+eeVxBuaWBqYmJmZmVgamxkqifO+bp2bIiSQnliSmp2aWpBaBNPHxMEp1cCkZKs973Zx
	2uabGh0NHIeUiiPNEryzGKKftfN3rUlyu74p+Edd3tQYcy2mex7ybS+/vXIWarmd3MX/gfG/
	4cLb3inZp2+fnyD+Kkq0Y3F19mbLT4etUnnLfdU1FiRsKPql5ZOT2dr7tfG5ZWSCgc7/HacU
	hfgNveOTalMCTuZtPnN6v7DMHDXfI5t22M7/uD5p2c28mZrxz0xjuI9mq5+csqvhJ+syntcB
	F3T8zt9Jfl52om6S9ZsNmS8vRhk4KDB7bygra9a4rfPU4OS5J1UrqlurWua3XLrzxLLtppl/
	p8/mzwvPJC2wWbKvWil4xfaZSq/WyR2YzBttuHzB0+XROqrPvKUOh2+4vX/vvT1KLMUZiYZa
	zEXFiQDZcnvfRgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJXtfN8laawet51hZvrq5itbizYBqT
	xanlC5ksmhevZ7OYtGcri8Xdhz9YLC7vmsNmsWhZK7PFp6P/WS1Wdc4Bin3fyWwx6aCoxaoF
	B9gdeD32z13D7tG3ZRWjx5b9nxk9Pm+SC2CJ4rJJSc3JLEst0rdL4Mp41v2KteCNR8XmN39Y
	Ghh/WXcxcnJICJhIHLv3jxHEFhLYzSjxZWsMRFxa4vWsLkYIW1hi5b/n7F2MXEA1rxklFs59
	wAyS4BWwk7jz6xVYEYuAisT0lp3sEHFBiZMzn7CA2KIC8hL3b80AiwsL+ElMf3MCrF5EQEfi
	wInzTCBDmQV6WCW+fP3IArHhNovExNkTwDqYBcQlbj2ZD1TFwcEmYCjx7IQNSJhTwFri2e2F
	LBAlZhJdWyEuZQZa1rx1NvMERqFZSO6YhWTSLCQts5C0LGBkWcUomVpQnJueW2xYYJiXWq5X
	nJhbXJqXrpecn7uJERxnWpo7GLev+qB3iJGJg/EQowQHs5II72uRG2lCvCmJlVWpRfnxRaU5
	qcWHGKU5WJTEecVf9KYICaQnlqRmp6YWpBbBZJk4OKUamJyO2VxZ4DU9aLPOhBZGt8cspp7M
	pU+y7rd9Wb2Tr5R5qYjWX86dxmbrryyznpJ9jCeu/8g796VdZZP6V+6wumL23XLtS+tX6nv/
	Sk2P/J1/cFbqu4/FK9SmONU/kDzMYnJSJyi7vrKbuzP6YQDbz0VpInNXF8jt+WDh+/zQhrMX
	50vEau4xefi/pObNB49K991+8lpvlyzXPeUqXT1r7/Uy33ad74ELnp/ZkOH0Vziu+39ZKbPe
	5s3lbJyyry/Et/F4+4dd/n40nqNe/VbY3AkO3VxKjbYFy/c6y55pkQ5+vPrbhJT3IQvn3tEy
	cSq+JN1lzrS3MDbl6kPPt2ls6Uz5H/jF30oUeWwOZdJVVmIpzkg01GIuKk4EAL9DTs0iAwAA
X-CMS-MailID: 20240905230543epcas5p431c4ef16a34eb9b098845551b993218f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240905002630epcas5p4532c1e66864e39990376b696aa1f53d7
References: <b48e7aba-6c54-431f-bbb5-3e5490df0c1a@samsung.com>
	<20240809234227.eriwy5e6leatzdyh@synopsys.com>
	<b273201d-c589-4c57-9d57-ad2affaeade0@samsung.com>
	<20240831005046.5lndwdr7cfm3k3to@synopsys.com>
	<2e678109-8399-48d5-9567-033eab910bca@samsung.com>
	<20240904010322.leqt3pap6lguivg4@synopsys.com>
	<11535d95-c972-4dbe-afb5-de3a44bc4a21@samsung.com>
	<CGME20240905002630epcas5p4532c1e66864e39990376b696aa1f53d7@epcas5p4.samsung.com>
	<20240905002611.rxlv66zsker2h5w2@synopsys.com>
	<d5552437-119c-4a0f-9d71-6959727b6364@samsung.com>
	<20240905211338.omst6jr3okbxkqdh@synopsys.com>


On 9/6/2024 2:43 AM, Thinh Nguyen wrote:
> On Thu, Sep 05, 2024, Selvarasu Ganesan wrote:
>> On 9/5/2024 5:56 AM, Thinh Nguyen wrote:
>>> On Wed, Sep 04, 2024, Selvarasu Ganesan wrote:
>>>> On 9/4/2024 6:33 AM, Thinh Nguyen wrote:
>>>>> On Mon, Sep 02, 2024, Selvarasu Ganesan wrote:
>>>>>> I would like to reconfirm from our end that in our failure scenario, we
>>>>>> observe that DWC3_EVENT_PENDING is set in evt->flags when the dwc3
>>>>>> resume sequence is executed, and the dwc->pending_events flag is not
>>>>>> being set.
>>>>>>
>>>>> If the controller is stopped, no event is generated until it's restarted
>>>>> again. (ie, you should not see GEVNTCOUNT updated after clearing
>>>>> DCTL.run_stop). If there's no event, no interrupt assertion should come
>>>>> from the controller.
>>>>>
>>>>> If the pending_events is not set and you still see this failure, then
>>>>> likely that the controller had started, and the interrupt is generated
>>>>> from the controller event. This occurs along with the interrupt
>>>>> generated from your connection notification from your setup.
>>>> I completely agree. My discussion revolves around the handling of the
>>>> DWC3_EVENT_PENDING flag in all situations. The purpose of using this
>>>> flag is to prevent the processing of new events if an existing event is
>>>> still being processed. This flag is set in the top-half interrupt
>>>> handler and cleared at the end of the bottom-half handler.
>>>>
>>>> Now, let's consider scenarios where the bottom half is not scheduled,
>>>> and a USB reconnect occurs. In this case, there is a possibility that
>>>> the interrupt line is unmasked in dwc3_event_buffers_setup, and the USB
>>>> controller begins posting new events. The top-half interrupt handler
>>>> checks for the DWC3_EVENT_PENDING flag and returns IRQ_HANDLED without
>>>> processing any new events. However, the USB controller continues to post
>>>> interrupts until they are acknowledged.
>>>>
>>>> Please review the complete sequence once with DWC3_EVENT_PENDING flag.
>>>>
>>>> My proposal is to clear or reset the DWC3_EVENT_PENDING flag when
>>>> unmasking the interrupt line dwc3_event_buffers_setup, apart from
>>>> bottom-half handler. Clearing the DWC3_EVENT_PENDING flag in
>>>> dwc3_event_buffers_setup does not cause any harm, as we have implemented
>>>> a temporary workaround in our test setup to prevent IRQ storms.
>>>>
>>>>
>>>>
>>>> Working scenarios:
>>>> ==================
>>>> 1. Top-half handler:
>>>>        a. if (evt->flags & DWC3_EVENT_PENDING)
>>>>            return IRQ_HANDLED;
>>>>        b. Set DWC3_EVENT_PENDING flag
>>>>        c. Masking interrupt line
>>>>
>>>> 2. Bottom-half handler:
>>>>        a. Un-masking interrupt line
>>>>        b. Clear DWC3_EVENT_PENDING flag
>>>>
>>>> Failure scenarios:
>>>> ==================
>>>> 1. Top-half handler:
>>>>        a. if (evt->flags & DWC3_EVENT_PENDING)
>>>>                    return IRQ_HANDLED;
>>>>        b. Set DWC3_EVENT_PENDING flag
>>>>        c. Masking interrupt line
>>> For DWC3_EVENT_PENDING flag to be set at this point (before we start the
>>> controller), that means that the GEVNTCOUNT was not 0 after
>>> soft-disconnect and that the pm_runtime_suspended() must be false.
>> In the top-half code where we set the DWC3_EVENT_PENDING flag, we
>> acknowledge GEVNTCOUNT. Therefore, I think it is not necessary for
>> GEVNTCOUNT to have a non-zero value until a new event occurs. In fact,
>> when we tried to print GEVNTCOUNT in a non-interrupt context, we found
>> that it was zero, where we received DWC3_EVENT_PENDING being set in
>> non-interrupt context.
> For DWC3_EVENT_PENDING to be set, GEVNTCOUNT must be non-zero. If you
> see it's zero, that means that it was already decremented by the driver.
>
> If the driver acknowledges the GEVNTCOUNT, then that means that the
> events are copied and prepared to be processed. The bottom-half thread
> is scheduled. If it's for stale event, I don't want it to be processed.
>
>>>> 2. No Bottom-half scheduled:
>>> Why is the bottom-half not scheduled? Or do you mean it hasn't woken up
>>> yet before the next top-half coming?
>> In very rare cases, it is possible in our platform that the CPU may not
>> be able to schedule the bottom half of the dwc3 interrupt because a work
>> queue lockup has occurred on the same CPU that is attempting to schedule
>> the dwc3 thread interrupt. In this case Yes, the bottom-half handler
>> hasn't woken up, then initiate an IRQ storm for new events after the
>> controller restarts, resulting in no more bottom-half scheduling due to
>> the CPU being stuck in processing continuous interrupts and return
>> IRQ_HANDLED by checking if (evt->flags & DWC3_EVENT_PENDING).
>>
>>>> 3. USB reconnect: dwc3_event_buffers_setup
>>>>        a. Un-masking interrupt line
>>> Do we know that the GEVNTCOUNT is non-zero before starting the
>>> controller again?
>> The GEVNTCOUNT value showing as zero that we confirmed by adding debug
>> message here.
>>>> 4. Continuous interrupts : Top-half handler:
>>>>        a. if (evt->flags & DWC3_EVENT_PENDING)
>>>>                    return IRQ_HANDLED;
>>>>
>>>>        a. if (evt->flags & DWC3_EVENT_PENDING)
>>>>                    return IRQ_HANDLED;
>>>>
>>>>        a. if (evt->flags & DWC3_EVENT_PENDING)
>>>>                    return IRQ_HANDLED;
>>>> .....
>>>>
>>>> .....
>>>>
>>>> .....
>>>>
>> Sure, I can try implementing the proposed code modifications in our
>> testing environment.
>>
>> But, I am uncertain about how these changes will effectively prevent an
>> IRQ storm when the USB controller sequence restarts with the
>> DWC3_EVENT_PENDING. The following code will only execute until the
>> DWC3_EVENT_PENDING is cleared, at which point the previous bottom-half
>> will not be scheduled.
>>
>> Please correct me if i am wrong in my above understanding.
> As I mentioned, I don't want DWC3_EVENT_PENDING flag to be set due to
> the stale event. I want to ignore and skip processing any stale event.
>
> The DWC3_EVENT_PENDING should not be set by the time
> dwc3_event_buffers_setup() is called.
>
> Specifically review this condition in my testing patch:
>
> 	/*
> 	 * If the controller is halted, the event count is stale/invalid. Ignore
> 	 * them. This happens if the interrupt assertion is from an out-of-band
> 	 * resume notification.
> 	 */
> 	if (!dwc->pullups_connected && count) {
> 		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), count);
> 		return IRQ_HANDLED;
> 	}
>
> Let me know if the condition matches with what's happening for your
> case.
Hi Thinh,

Thanks for your continuous reviews and suggestions.

The given condition also will not matches in our case.
As i mentioned in starting of this thread please refer once the below 
link of older discussion for similar issue from Samsung..

https://lore.kernel.org/linux-usb/20230102050831.105499-1-jh0801.jung@samsung.com/


DWC3_EVENT_PENDING flags set when count is 0.
It means "There are no interrupts to handle.".

(struct dwc3_event_buffer *) ev_buf = 0xFFFFFF883DBF1180 (
	(void *) buf = 0xFFFFFFC00DBDD000 = end+0x337D000,
	(void *) cache = 0xFFFFFF8839F54080,
	(unsigned int) length = 0x1000,
	(unsigned int) lpos = 0x0,
*(unsigned int) count = 0x0, (unsigned int) flags = 0x00000001,*
	(dma_addr_t) dma = 0x00000008BD7D7000,
	(struct dwc3 *) dwc = 0xFFFFFF8839CBC880,
	(u64) android_kabi_reserved1 = 0x0),

IRQ Storm:
(time = 47557628930999, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
(time = 47557628931268, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
(time = 47557628932383, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
(time = 47557628932652, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
(time = 47557628933768, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
(time = 47557628934037, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
...
...
...


We are also fine with below code changes as you suggested earlier.
https://lore.kernel.org/linux-usb/20230109190914.3blihjfjdcszazdd@synopsys.com/

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 65500246323b..3c36dfdb88f0 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -5515,8 +5515,15 @@ static irqreturn_t dwc3_check_event_buf(struct 
dwc3_event_buffer *evt)
          * irq event handler completes before caching new event to prevent
          * losing events.
          */
-       if (evt->flags & DWC3_EVENT_PENDING)
+       if (evt->flags & DWC3_EVENT_PENDING) {
+               if (!evt->count) {
+                       u32 reg = dwc3_readl(dwc->regs, DWC3_GEVNTSIZ(0));
+
+                       if (!(reg & DWC3_GEVNTSIZ_INTMASK))
+                               evt->flags &= ~DWC3_EVENT_PENDING;
+               }
                 return IRQ_HANDLED;
+       }


Thanks,
Selva


> .
> Thanks,
> Thinh

