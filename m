Return-Path: <linux-kernel+bounces-319376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6926696FBC3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211A3281022
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFEC1CBE9F;
	Fri,  6 Sep 2024 19:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EPf3kEv4"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3523B3FB8B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 19:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725649360; cv=none; b=Hnw5XGOISDTPgyAgbx79h6kn+VDCuCq03i/TiMtQO4TQZ4vEJlKo3B386p44aBJQu5q/CMCiR62DlIu8aFG7Vrd+Xi50Jnm1Z9bn2fIkur17VoAQ+kZiOdyEncYHPh8YAA8vcinUXTQkVY2QATeen+jtFRbivhOifuXIA7Xjbdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725649360; c=relaxed/simple;
	bh=GqwTqN5nCEEEyUmMxKo0kFJEzGudtyS0+X8MJ2KxMMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=OAwqJ42aW0viwVkntMacPj1yqG0hqcEM4kXW6ULwrGdV2bn4ZYbKVZOFD8cAW9De1UVas27xB+h7Jh0QE+mX2s5BJ9Zqp1dTYdtmrrmwcevx/ghTciWkehUewkLJkRk00RKWfYUhn1hIQ6t1d7+qqltNeacEvd4c2pY2fBeK9aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EPf3kEv4; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240906190234epoutp03f3f8bc95a50ffb645d6badb3168881a9~yvPHaPEbG3127631276epoutp03g
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 19:02:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240906190234epoutp03f3f8bc95a50ffb645d6badb3168881a9~yvPHaPEbG3127631276epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725649354;
	bh=75WiNNI7z8Kiwza5cjXx+4j/WIIyNxu49S+mQkErRKs=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=EPf3kEv4bu6YF1p7NNNiBN4pxwwFaSM+4z6paGCShn3FRWcEmJ5VEArrOlj9hx/PF
	 mdTvn7ZLOu4tcL0ufrIR4Vj7axQHxLEsg5G+qGw1K/V4ok87g8g5rTGaFuMoytpp/Q
	 8j5bi4xu1WTPSg/74pWF5WbeU3Qjd3ywm6jkixQY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240906190233epcas5p270c8b5cbc3a971e8710e1a1e4e4c393c~yvPG5Myo81292012920epcas5p2g;
	Fri,  6 Sep 2024 19:02:33 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4X0lwS2wmdz4x9Pt; Fri,  6 Sep
	2024 19:02:32 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AE.1D.08855.8C15BD66; Sat,  7 Sep 2024 04:02:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240906190231epcas5p4adbe8f0a1bc5e7bfcaa29a5be9d5622c~yvPEuisnk1749317493epcas5p48;
	Fri,  6 Sep 2024 19:02:31 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240906190231epsmtrp1d666eb9a8973761996bf191267e0d836~yvPEpjuVJ2750627506epsmtrp1P;
	Fri,  6 Sep 2024 19:02:31 +0000 (GMT)
X-AuditID: b6c32a44-107ff70000002297-4b-66db51c8d3ce
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	33.0D.19367.7C15BD66; Sat,  7 Sep 2024 04:02:31 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240906190228epsmtip2c57a0b2bd8fd3aed1057fabfb6a5ba7d~yvPCQZK2e0371703717epsmtip2O;
	Fri,  6 Sep 2024 19:02:28 +0000 (GMT)
Message-ID: <30ca8527-419b-4e44-a21b-18e494b39076@samsung.com>
Date: Sat, 7 Sep 2024 00:32:26 +0530
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
In-Reply-To: <20240906005935.caugoe3mqqdqwqao@synopsys.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEJsWRmVeSWpSXmKPExsWy7bCmpu6JwNtpBrfO8Fu8ubqK1eLOgmlM
	FqeWL2SyaF68ns1i0p6tLBZ3H/5gsbi8aw6bxaJlrcwWn47+Z7VY1TkHKPZ9J7PFpIOiFqsW
	HGB34PXYP3cNu0ffllWMHlv2f2b0+LxJLoAlKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTM
	wFDX0NLCXEkhLzE31VbJxSdA1y0zB+g8JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpB
	Sk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2xqd3HUwFMyoqvixZwNTA2JzSxcjJISFgInHy
	/gzWLkYuDiGB3YwSL1+cZIZwPjFK7Np/hw3Omff7NhNMy8fTS5lBbCGBnYwS6zsSIYreMkp0
	zjkPNIuDg1fATmLFtiSQGhYBFYk/a7aC9fIKCEqcnPmEBcQWFZCXuH9rBjuILSwQIHFlyQxG
	EFtEQEfiwInzTCAzmQU6WCUWdLeBNTMLiEvcejKfCWQ+m4ChxLMTNiBhTgFrifN/37JBlMhL
	NG+dDfaBhMBaDok5t+YwQxztInH1YgsbhC0s8er4FnYIW0riZX8blF0tsfrORzaI5hZGicNP
	vkEl7CUeH33EDLKYWUBTYv0ufYhlfBK9v5+A3SMhwCvR0SYEUa0qcarxMtQqaYl7S66xQpR4
	SPxaygsJqtssErvXt7FOYFSYhRQss5B8OQvJO7MQFi9gZFnFKJlaUJybnppsWmCYl1oOj+/k
	/NxNjODEq+Wyg/HG/H96hxiZOBgPMUpwMCuJ8D71vJUmxJuSWFmVWpQfX1Sak1p8iNEUGD8T
	maVEk/OBqT+vJN7QxNLAxMzMzMTS2MxQSZz3devcFCGB9MSS1OzU1ILUIpg+Jg5OqQams1Of
	iahZMe3ZrcXF3qeUnXY9xLPyeomc0r2/Fb8v/KuyfrVn3fEbRh4Ot952VOk4zP+U3b39lP2H
	p1NMn3/emhjz428uW/zyYzznzx18ul/YaQbbg7SJJktO7SvMftB8L5DN6+DkUzffLJ+c9mDG
	495XW14EeslNeLZtw6HDqxQFXM9mr77uzWdwoSJWIDqBqVJ0d+UVY38B2Zx9hmUa8ilL1VcV
	XHNw6rr94emrpfvbMpyPNTXcEeFpTylOq+hdMPtxuNjTBW+CJY/Oi0vVeR3BtyXIx7i6Ze+X
	vOfZn2fJzrvNZui4SGR75jZds0/3dm3/FDo1/dac6lUHBPYXflhmFHvz8GtLpg9mL8y4+JRY
	ijMSDbWYi4oTAdWV2gxFBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJXvd44O00gxWzWSzeXF3FanFnwTQm
	i1PLFzJZNC9ez2Yxac9WFou7D3+wWFzeNYfNYtGyVmaLT0f/s1qs6pwDFPu+k9li0kFRi1UL
	DrA78Hrsn7uG3aNvyypGjy37PzN6fN4kF8ASxWWTkpqTWZZapG+XwJXx6V0HU8GMioovSxYw
	NTA2p3QxcnJICJhIfDy9lLmLkYtDSGA7o8T3Pf2MEAlpidezuqBsYYmV/56zQxS9ZpRYufcx
	SxcjBwevgJ3Eim1JIDUsAioSf9ZsZQKxeQUEJU7OfMICYosKyEvcvzWDHcQWFvCTmP7mBNhM
	EQEdiQMnzjOBzGQW6GGV+PL1IwvEgtssElvmLAHrZhYQl7j1ZD4TyDI2AUOJZydsQMKcAtYS
	5/++ZYMoMZPo2gpxKDPQsuats5knMArNQnLHLCSTZiFpmYWkZQEjyypG0dSC4tz03OQCQ73i
	xNzi0rx0veT83E2M4PjSCtrBuGz9X71DjEwcjIcYJTiYlUR4n3reShPiTUmsrEotyo8vKs1J
	LT7EKM3BoiTOq5zTmSIkkJ5YkpqdmlqQWgSTZeLglGpgqvfXvZ+xj+92yNuKyMLtuwPltG07
	Ly2rCM3yEj6okfcg+JHl+eWpeodKuMNnLGH98uaC4q2ZIdlceb9f9Bn8N1h9K3HXjt1d1dqJ
	M0t0xW8Uzvs3l1eLcd37qzOzBCZ+2WvjZZti1Ve/zm/SnG096rVryhy03dMu3JrzIWHFocMK
	XPZZDoxzLL9err42kYn1yqSDzZs7A94+Z5+W5rXfRPfWIfb+KW81Jvty7uFlnhO35mnKFMZd
	0zgWZDInKVUGvq1dUpUVwfPkKMtksZMGs/LfNK/9+tOGt+VTMu+fFt95Wx9vuHhgTt5qy6sM
	OWred1o49FZfXMTZM33egYxgXqvOxs+/GqeqS8mxZVT+UGIpzkg01GIuKk4EAK46nMUeAwAA
X-CMS-MailID: 20240906190231epcas5p4adbe8f0a1bc5e7bfcaa29a5be9d5622c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240905002630epcas5p4532c1e66864e39990376b696aa1f53d7
References: <2e678109-8399-48d5-9567-033eab910bca@samsung.com>
	<20240904010322.leqt3pap6lguivg4@synopsys.com>
	<11535d95-c972-4dbe-afb5-de3a44bc4a21@samsung.com>
	<CGME20240905002630epcas5p4532c1e66864e39990376b696aa1f53d7@epcas5p4.samsung.com>
	<20240905002611.rxlv66zsker2h5w2@synopsys.com>
	<d5552437-119c-4a0f-9d71-6959727b6364@samsung.com>
	<20240905211338.omst6jr3okbxkqdh@synopsys.com>
	<f9561f03-5f83-4270-b7f3-17b880cfabfe@samsung.com>
	<20240905231825.6r2sp2bapxidur7a@synopsys.com>
	<64d049cc-d55d-4376-b6b9-402eb6f170c0@samsung.com>
	<20240906005935.caugoe3mqqdqwqao@synopsys.com>


On 9/6/2024 6:29 AM, Thinh Nguyen wrote:
> On Fri, Sep 06, 2024, Selvarasu Ganesan wrote:
>> On 9/6/2024 4:48 AM, Thinh Nguyen wrote:
>>> On Fri, Sep 06, 2024, Selvarasu Ganesan wrote:
>>>> On 9/6/2024 2:43 AM, Thinh Nguyen wrote:
>>>>> On Thu, Sep 05, 2024, Selvarasu Ganesan wrote:
>>>>>> On 9/5/2024 5:56 AM, Thinh Nguyen wrote:
>>>>>>> On Wed, Sep 04, 2024, Selvarasu Ganesan wrote:
>>>>>>>> On 9/4/2024 6:33 AM, Thinh Nguyen wrote:
>>>>>>>>> On Mon, Sep 02, 2024, Selvarasu Ganesan wrote:
>>>>>>>>>> I would like to reconfirm from our end that in our failure scenario, we
>>>>>>>>>> observe that DWC3_EVENT_PENDING is set in evt->flags when the dwc3
>>>>>>>>>> resume sequence is executed, and the dwc->pending_events flag is not
>>>>>>>>>> being set.
>>>>>>>>>>
>>>>>>>>> If the controller is stopped, no event is generated until it's restarted
>>>>>>>>> again. (ie, you should not see GEVNTCOUNT updated after clearing
>>>>>>>>> DCTL.run_stop). If there's no event, no interrupt assertion should come
>>>>>>>>> from the controller.
>>>>>>>>>
>>>>>>>>> If the pending_events is not set and you still see this failure, then
>>>>>>>>> likely that the controller had started, and the interrupt is generated
>>>>>>>>> from the controller event. This occurs along with the interrupt
>>>>>>>>> generated from your connection notification from your setup.
>>>>>>>> I completely agree. My discussion revolves around the handling of the
>>>>>>>> DWC3_EVENT_PENDING flag in all situations. The purpose of using this
>>>>>>>> flag is to prevent the processing of new events if an existing event is
>>>>>>>> still being processed. This flag is set in the top-half interrupt
>>>>>>>> handler and cleared at the end of the bottom-half handler.
>>>>>>>>
>>>>>>>> Now, let's consider scenarios where the bottom half is not scheduled,
>>>>>>>> and a USB reconnect occurs. In this case, there is a possibility that
>>>>>>>> the interrupt line is unmasked in dwc3_event_buffers_setup, and the USB
>>>>>>>> controller begins posting new events. The top-half interrupt handler
>>>>>>>> checks for the DWC3_EVENT_PENDING flag and returns IRQ_HANDLED without
>>>>>>>> processing any new events. However, the USB controller continues to post
>>>>>>>> interrupts until they are acknowledged.
>>>>>>>>
>>>>>>>> Please review the complete sequence once with DWC3_EVENT_PENDING flag.
>>>>>>>>
>>>>>>>> My proposal is to clear or reset the DWC3_EVENT_PENDING flag when
>>>>>>>> unmasking the interrupt line dwc3_event_buffers_setup, apart from
>>>>>>>> bottom-half handler. Clearing the DWC3_EVENT_PENDING flag in
>>>>>>>> dwc3_event_buffers_setup does not cause any harm, as we have implemented
>>>>>>>> a temporary workaround in our test setup to prevent IRQ storms.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Working scenarios:
>>>>>>>> ==================
>>>>>>>> 1. Top-half handler:
>>>>>>>>          a. if (evt->flags & DWC3_EVENT_PENDING)
>>>>>>>>              return IRQ_HANDLED;
>>>>>>>>          b. Set DWC3_EVENT_PENDING flag
>>>>>>>>          c. Masking interrupt line
>>>>>>>>
>>>>>>>> 2. Bottom-half handler:
>>>>>>>>          a. Un-masking interrupt line
>>>>>>>>          b. Clear DWC3_EVENT_PENDING flag
>>>>>>>>
>>>>>>>> Failure scenarios:
>>>>>>>> ==================
>>>>>>>> 1. Top-half handler:
>>>>>>>>          a. if (evt->flags & DWC3_EVENT_PENDING)
>>>>>>>>                      return IRQ_HANDLED;
>>>>>>>>          b. Set DWC3_EVENT_PENDING flag
>>>>>>>>          c. Masking interrupt line
>>>>>>> For DWC3_EVENT_PENDING flag to be set at this point (before we start the
>>>>>>> controller), that means that the GEVNTCOUNT was not 0 after
>>>>>>> soft-disconnect and that the pm_runtime_suspended() must be false.
>>>>>> In the top-half code where we set the DWC3_EVENT_PENDING flag, we
>>>>>> acknowledge GEVNTCOUNT. Therefore, I think it is not necessary for
>>>>>> GEVNTCOUNT to have a non-zero value until a new event occurs. In fact,
>>>>>> when we tried to print GEVNTCOUNT in a non-interrupt context, we found
>>>>>> that it was zero, where we received DWC3_EVENT_PENDING being set in
>>>>>> non-interrupt context.
>>>>> For DWC3_EVENT_PENDING to be set, GEVNTCOUNT must be non-zero. If you
>>>>> see it's zero, that means that it was already decremented by the driver.
>>>>>
>>>>> If the driver acknowledges the GEVNTCOUNT, then that means that the
>>>>> events are copied and prepared to be processed. The bottom-half thread
>>>>> is scheduled. If it's for stale event, I don't want it to be processed.
>>>>>
>>>>>>>> 2. No Bottom-half scheduled:
>>>>>>> Why is the bottom-half not scheduled? Or do you mean it hasn't woken up
>>>>>>> yet before the next top-half coming?
>>>>>> In very rare cases, it is possible in our platform that the CPU may not
>>>>>> be able to schedule the bottom half of the dwc3 interrupt because a work
>>>>>> queue lockup has occurred on the same CPU that is attempting to schedule
>>>>>> the dwc3 thread interrupt. In this case Yes, the bottom-half handler
>>>>>> hasn't woken up, then initiate an IRQ storm for new events after the
>>>>>> controller restarts, resulting in no more bottom-half scheduling due to
>>>>>> the CPU being stuck in processing continuous interrupts and return
>>>>>> IRQ_HANDLED by checking if (evt->flags & DWC3_EVENT_PENDING).
>>>>>>
>>>>>>>> 3. USB reconnect: dwc3_event_buffers_setup
>>>>>>>>          a. Un-masking interrupt line
>>>>>>> Do we know that the GEVNTCOUNT is non-zero before starting the
>>>>>>> controller again?
>>>>>> The GEVNTCOUNT value showing as zero that we confirmed by adding debug
>>>>>> message here.
>>>>>>>> 4. Continuous interrupts : Top-half handler:
>>>>>>>>          a. if (evt->flags & DWC3_EVENT_PENDING)
>>>>>>>>                      return IRQ_HANDLED;
>>>>>>>>
>>>>>>>>          a. if (evt->flags & DWC3_EVENT_PENDING)
>>>>>>>>                      return IRQ_HANDLED;
>>>>>>>>
>>>>>>>>          a. if (evt->flags & DWC3_EVENT_PENDING)
>>>>>>>>                      return IRQ_HANDLED;
>>>>>>>> .....
>>>>>>>>
>>>>>>>> .....
>>>>>>>>
>>>>>>>> .....
>>>>>>>>
>>>>>> Sure, I can try implementing the proposed code modifications in our
>>>>>> testing environment.
>>>>>>
>>>>>> But, I am uncertain about how these changes will effectively prevent an
>>>>>> IRQ storm when the USB controller sequence restarts with the
>>>>>> DWC3_EVENT_PENDING. The following code will only execute until the
>>>>>> DWC3_EVENT_PENDING is cleared, at which point the previous bottom-half
>>>>>> will not be scheduled.
>>>>>>
>>>>>> Please correct me if i am wrong in my above understanding.
>>>>> As I mentioned, I don't want DWC3_EVENT_PENDING flag to be set due to
>>>>> the stale event. I want to ignore and skip processing any stale event.
>>>>>
>>>>> The DWC3_EVENT_PENDING should not be set by the time
>>>>> dwc3_event_buffers_setup() is called.
>>>>>
>>>>> Specifically review this condition in my testing patch:
>>>>>
>>>>> 	/*
>>>>> 	 * If the controller is halted, the event count is stale/invalid. Ignore
>>>>> 	 * them. This happens if the interrupt assertion is from an out-of-band
>>>>> 	 * resume notification.
>>>>> 	 */
>>>>> 	if (!dwc->pullups_connected && count) {
>>>>> 		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), count);
>>>>> 		return IRQ_HANDLED;
>>>>> 	}
>>>>>
>>>>> Let me know if the condition matches with what's happening for your
>>>>> case.
>>>> Hi Thinh,
>>>>
>>>> Thanks for your continuous reviews and suggestions.
>>>>
>>>> The given condition also will not matches in our case.
>>>> As i mentioned in starting of this thread please refer once the below
>>>> link of older discussion for similar issue from Samsung..
>>>>
>>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-usb/20230102050831.105499-1-jh0801.jung@samsung.com/__;!!A4F2R9G_pg!a3VpPHvMr9enk0YPjSoWJ12Kr5Hw2Ka43Q_wi80lw6ty2tJT4hKRKsCnQNdqbVS3JORK2VwqdoXDWz1q8ynpe7Ex6cU$
>>>>
>>>>
>>>> DWC3_EVENT_PENDING flags set when count is 0.
>>>> It means "There are no interrupts to handle.".
>>>>
>>>> (struct dwc3_event_buffer *) ev_buf = 0xFFFFFF883DBF1180 (
>>>> 	(void *) buf = 0xFFFFFFC00DBDD000 = end+0x337D000,
>>>> 	(void *) cache = 0xFFFFFF8839F54080,
>>>> 	(unsigned int) length = 0x1000,
>>>> 	(unsigned int) lpos = 0x0,
>>>> *(unsigned int) count = 0x0, (unsigned int) flags = 0x00000001,*
>>>> 	(dma_addr_t) dma = 0x00000008BD7D7000,
>>>> 	(struct dwc3 *) dwc = 0xFFFFFF8839CBC880,
>>>> 	(u64) android_kabi_reserved1 = 0x0),
>>> This is the info of the event buffer that was reset after the
>>> dwc3_event_buffers_setup(). I'm talking about the first time
>>> DWC3_EVENT_PENDING flag was set.
>> Yes, the buffer that was reset before as part of
>> dwc3_event_buffers_setup() is correct.
>> I agree on your new code changes in below will prevent setting
>> DWC3_EVENT_PENDING and avoid the bottom-half handler if the controller
>> is halted, and the event count is invalid.
>>
>> Are you suspecting that the DWC3_EVENT_PENDING flag was only set in this
>> scenario in our failure case?
> Base on the discussion so far, that's what I'm suspecting.
>
>> /*diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 89fc690fdf34..a525f7ea5886 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -4490,6 +4490,17 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
>>    		return IRQ_HANDLED;
>>    
>>    	count = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
>> +
>> +	/*
>> +	 * If the controller is halted, the event count is stale/invalid. Ignore
>> +	 * them. This happens if the interrupt assertion is from an out-of-band
>> +	 * resume notification.
>> +	 */
>> +	if (!dwc->pullups_connected && count) {
>> +		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), count);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>>    	count &= DWC3_GEVNTCOUNT_MASK;
>>    	if (!count)
>>    		return IRQ_NONE;
>>
>>> By the time the interrupt storm below occur, the count in the buffer is
>>> already zero'ed out.
>>>
>>>> IRQ Storm:
>>>> (time = 47557628930999, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
>>>> (time = 47557628931268, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
>>>> (time = 47557628932383, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
>>>> (time = 47557628932652, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
>>>> (time = 47557628933768, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
>>>> (time = 47557628934037, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
>>>> ...
>>>> ...
>>>> ...
>>>>
>>>>
>>>> We are also fine with below code changes as you suggested earlier.
>>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-usb/20230109190914.3blihjfjdcszazdd@synopsys.com/__;!!A4F2R9G_pg!a3VpPHvMr9enk0YPjSoWJ12Kr5Hw2Ka43Q_wi80lw6ty2tJT4hKRKsCnQNdqbVS3JORK2VwqdoXDWz1q8ynp367zvEw$
>>>>
>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>> index 65500246323b..3c36dfdb88f0 100644
>>>> --- a/drivers/usb/dwc3/gadget.c
>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>> @@ -5515,8 +5515,15 @@ static irqreturn_t dwc3_check_event_buf(struct
>>>> dwc3_event_buffer *evt)
>>>>             * irq event handler completes before caching new event to prevent
>>>>             * losing events.
>>>>             */
>>>> -       if (evt->flags & DWC3_EVENT_PENDING)
>>>> +       if (evt->flags & DWC3_EVENT_PENDING) {
>>>> +               if (!evt->count) {
>>>> +                       u32 reg = dwc3_readl(dwc->regs, DWC3_GEVNTSIZ(0));
>>>> +
>>>> +                       if (!(reg & DWC3_GEVNTSIZ_INTMASK))
>>>> +                               evt->flags &= ~DWC3_EVENT_PENDING;
>>>> +               }
>>>>                    return IRQ_HANDLED;
>>>> +       }
>>>>
>>>>
>>> I don't want the bottom-half to be scheduled in the beginning as it may
>>> come before the cleanup in dwc3_event_buffers_setup().
>> You mean the above changes for clearing DWC3_EVENT_PENDINGnot required
>> as you given new change will prevent setting of DWC3_EVENT_PENDING
>> before dwc3_event_buffers_setup().
> Yes.
>
>> But I dont see any harm in above code changes for clearing
>> DWC3_EVENT_PENDING if it already set with evt->count=0.
> You can add it there, but do we need to if we can solve the actual
> issue?
Agree. Yes, we need to find actual issue.
>
> I'm interested in confirming my suspiction of what's really causing the
> DWC3_EVENT_PENDING to be set here. The code logic would be clearer
> rather than masking the behavior by depending on the reset by the
> dwc3_event_buffers_setup(). The runtime resume doesn't share the same
> locking mechanism as when processing an event. While it may be unlikely,
> I don't want the bottom-half thread to handle stale event or race with
> the runtime resume.

Hi Thinh,

I ran the code you recommended on our testing environment and was able 
to reproduce the issue one time.

When evt->flags contains DWC3_EVENT_PENDING, I've included the following 
debugging information: I added this debug message at the start of 
dwc3_event_buffers_cleanup and dwc3_event_buffers_setup functions in 
during suspend and resume.

The results were quite interesting . I'm curious to understand how 
evt->flags is set to DWC3_EVENT_PENDING, and along with DWC3_GEVNTSIZ is 
equal to 0x1000 during the suspend.
Its means that the previous bottom-half handler prior to suspend might 
still be executing in the middle of the process.

Could you please give your suggestions here? And let me know if anything 
want to test or additional details are required.


##DBG: dwc3_event_buffers_cleanup:
  evt->length    :0x1000
  evt->lpos      :0x20c
  evt->count     :0x0
  evt->flags     :0x1 // This is Unexpected if DWC3_GEVNTSIZ(0)(0xc408): 
0x00001000. Its means that previous bottom-half handler may be still 
running in middle

  DWC3_GEVNTSIZ(0)(0xc408)       : 0x00001000
  DWC3_GEVNTCOUNT(0)(0xc40c)     : 0x00000000
  DWC3_DCFG(0xc700)              : 0x00e008a8
  DWC3_DCTL(0xc704)              : 0x0cf00a00
  DWC3_DEVTEN(0xc708)            : 0x00000000
  DWC3_DSTS(0xc70c)              : 0x00d20cd1


##DBG: dwc3_event_buffers_setup:
  evt->length    :0x1000
  evt->lpos      :0x20c
  evt->count     :0x0
  evt->flags     :0x1 // Still It's not clearing in during resume.

  DWC3_GEVNTSIZ(0)(0xc408)       : 0x00000000
  DWC3_GEVNTCOUNT(0)(0xc40c)     : 0x00000000
  DWC3_DCFG(0xc700)              : 0x00080800
  DWC3_DCTL(0xc704)              : 0x00f00000
  DWC3_DEVTEN(0xc708)            : 0x00000000
  DWC3_DSTS(0xc70c)              : 0x00d20001

>
>> Anyway I will try the your new proposed changes alone on our testing
>> setup and will update the status,
>>
> Thanks,
> Thinh

