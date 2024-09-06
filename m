Return-Path: <linux-kernel+bounces-317995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C83F896E6DA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 02:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AD1CB23385
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F81BA4A;
	Fri,  6 Sep 2024 00:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Gx4pcjfE"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FD0D2FF
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 00:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725582512; cv=none; b=dJ7ZFyGSNJQt0TzMfyopYTDyYX7ZeFSJWcjWMF99MN/qAaiBIO3/Vbn6+pwbZmRz1d/xresSESKnux2+DgLeYNoV5QwovF8Vv4Y2ZnRxg4pFO88UpE2WR9nFliUvU/RRssYBYWqaHWjkTz+IzUC53+3ZqrWusHn+2FsS40sKEwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725582512; c=relaxed/simple;
	bh=0G3PtZ/8IfM3Mh1Jv5fsRa8pHH77mAQvROrHZR6mywg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=tAY8cjcC1Dcayz2ZMo1NVgqFn9IPckb/jewjTGzCKgaQO9Ng7x87XVhoQDRVGnh/4UCw8XKb5vrPc1QrF4Is7wK3OL1dqeNSGBfFfb9g4ZJv/Iexp+DBvlIBbyRucE4F9pbks+DtHBL9haknWBc/+obPY+TkAaetJpsGpZ7qEGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Gx4pcjfE; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240906002826epoutp01c9a1e1f462d36db258bacc036fb54664~ygCWnS9tH2864828648epoutp01X
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 00:28:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240906002826epoutp01c9a1e1f462d36db258bacc036fb54664~ygCWnS9tH2864828648epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725582506;
	bh=/K5CJCfZcVCllRnsIi9+UNcTjf0AITHon/EsS+9mPsE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Gx4pcjfEESZXhzaezQdIZxEqwz2hOTpmsF9kYCEHqd1fbWeoEtavqKCNhySxafaIt
	 6T9RTT8UOYU9sOeBqkSQpqpN5K8k1QpKzCDn1E49EowTHEzlatIl913vM4Se8eSVCU
	 24ALlbS9/P0/A0msS3w71IYMx3PDK/2VCl+72GA4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240906002825epcas5p45ed92bfd84fe6b666e21003f46d4d600~ygCVdl84y0634906349epcas5p4a;
	Fri,  6 Sep 2024 00:28:25 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4X0HBv6ngDz4x9Q8; Fri,  6 Sep
	2024 00:28:23 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	28.50.09640.7AC4AD66; Fri,  6 Sep 2024 09:28:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240906002823epcas5p1d799d16d335e97d1afe6cc50421b0fda~ygCTcgcdB2290222902epcas5p1C;
	Fri,  6 Sep 2024 00:28:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240906002823epsmtrp1149c2568161631bec2c4829ea4875fa9~ygCTbqtgF2060620606epsmtrp1x;
	Fri,  6 Sep 2024 00:28:23 +0000 (GMT)
X-AuditID: b6c32a49-aabb8700000025a8-3c-66da4ca7f6eb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	22.82.08964.6AC4AD66; Fri,  6 Sep 2024 09:28:22 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240906002820epsmtip21e374058057cc842f8d99223fa25f001~ygCQ8FGZP0814808148epsmtip2n;
	Fri,  6 Sep 2024 00:28:20 +0000 (GMT)
Message-ID: <64d049cc-d55d-4376-b6b9-402eb6f170c0@samsung.com>
Date: Fri, 6 Sep 2024 05:58:18 +0530
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
In-Reply-To: <20240905231825.6r2sp2bapxidur7a@synopsys.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmpu5yn1tpBq1vdSzeXF3FanFnwTQm
	i1PLFzJZNC9ez2Yxac9WFou7D3+wWFzeNYfNYtGyVmaLT0f/s1qs6pwDFPu+k9li0kFRi1UL
	DrA78Hrsn7uG3aNvyypGjy37PzN6fN4kF8ASlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pm
	YKhraGlhrqSQl5ibaqvk4hOg65aZA3SekkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUg
	JafApECvODG3uDQvXS8vtcTK0MDAyBSoMCE7Y8b7TWwFW+Iqjrf9YW1g7PDrYuTkkBAwkVix
	9CxzFyMXh5DAbkaJ5sYv7CAJIYFPjBInljlDJL4xShx8/ogVpqN54xUmiMReRolvO2exQzhv
	GSX+zp/JCFLFK2AnsWHPPrAOFgEViQ2dp9kg4oISJ2c+YQGxRQXkJe7fmgG2TlggQOLKkhlg
	vSICOhIHTpwH28As0MEqsaC7jQkkwSwgLnHryXwgm4ODTcBQ4tkJG5Awp4C1xNUjrVAl8hLN
	W2eD/SMhsIVD4unh2+wQZ7tIfHjXxQhhC0u8Or4FKi4l8bK/Dcqullh95yMbRHMLo8ThJ9+g
	EvYSj48+YgZZzCygKbF+lz7EMj6J3t9PwO6REOCV6GgTgqhWlTjVeJkNwpaWuLfkGitEiYfE
	r6W8kLC6zSLRc+4fywRGhVlIwTILyZezkLwzC2HxAkaWVYySqQXFuempxaYFhnmp5fAIT87P
	3cQITr1anjsY7z74oHeIkYmD8RCjBAezkgjvU89baUK8KYmVValF+fFFpTmpxYcYTYHxM5FZ
	SjQ5H5j880riDU0sDUzMzMxMLI3NDJXEeV+3zk0REkhPLEnNTk0tSC2C6WPi4JRqYJrxYcsf
	ezezt9+2cTf9XVuWZlRUpvZy7aENK6O2fX7VoyLbk+mRVdU25XCMc7Wlh73PtMSEhpO9UpOO
	xu6ps1xVMHlH4dfWvuRqJc4tB67ceTnDI6zo4fnfs+9byB+KXRx6dqlWVMk1F+NrmjydO03k
	dbUV11WxXE9LaLGuV/gsZjvv2Lu5euIpMxe8+nBm/TOXhOn7Hm985KCeFVF9ei/j7L8bF31K
	VMq8v37Tqrg8I1WRWXyamkvsFt+akbD/lhdT/zSV7QGrBK6uYrvuqhbJ5ahjxHrjs7G9i0nz
	j58TG0zPRB43/zIrd+nkOFnGbDPTdXX6H4RXRSsH32vuF2/cW2249rnjTg/B9u/+nUosxRmJ
	hlrMRcWJAH4rqAtGBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSvO4yn1tpBku6DS3eXF3FanFnwTQm
	i1PLFzJZNC9ez2Yxac9WFou7D3+wWFzeNYfNYtGyVmaLT0f/s1qs6pwDFPu+k9li0kFRi1UL
	DrA78Hrsn7uG3aNvyypGjy37PzN6fN4kF8ASxWWTkpqTWZZapG+XwJUx4/0mtoItcRXH2/6w
	NjB2+HUxcnJICJhING+8wtTFyMUhJLCbUWLr1q9sEAlpidezuhghbGGJlf+es0MUvWaU6Frd
	AVbEK2AnsWHPPlYQm0VARWJD52mouKDEyZlPWEBsUQF5ifu3ZrCD2MICfhLT35wAGyoioCNx
	4MR5sM3MAj2sEl++fmSB2HCbReL+sk/MIFXMAuISt57MB6ri4GATMJR4dsIGJMwpYC1x9Ugr
	E0SJmUTXVohLmYGWNW+dzTyBUWgWkjtmIZk0C0nLLCQtCxhZVjFKphYU56bnFhsWGOallusV
	J+YWl+al6yXn525iBEealuYOxu2rPugdYmTiYDzEKMHBrCTC+9TzVpoQb0piZVVqUX58UWlO
	avEhRmkOFiVxXvEXvSlCAumJJanZqakFqUUwWSYOTqkGJtHs2J/TPTZv4szrnRq4ZrfcqhVt
	E7RYPlRLJUckXlw2/9gP57P3pigbvr4cMMFqk2qU4sItf+1Cns+Lz43cmqN6drZqMbf4Pvlj
	2ituLLz7qn/nE/MOx58LzmXO/f5l+RuhQ/OL9syrtHt85n9E//uJ0dGZD+05VH57P1Rh5Pj6
	/v22V0w75/3ZdYuxo6/Gflft3BXvC1f+3nL20zbhADvnRStaxf4KvgnaYbLNr3ry/91t91tv
	ml1MecC6cVFJ+uITIbqHYtv0pMLDM0UKW384xKxf/GBvWEuG/cw1NlpzpwcYzoqz/7+vd09Y
	yWMJset3nPXWsWiuPqhy9f8vB/2P/SJ6whNcVsp5dfw5vsRSiaU4I9FQi7moOBEAbNp/ciMD
	AAA=
X-CMS-MailID: 20240906002823epcas5p1d799d16d335e97d1afe6cc50421b0fda
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240905002630epcas5p4532c1e66864e39990376b696aa1f53d7
References: <b273201d-c589-4c57-9d57-ad2affaeade0@samsung.com>
	<20240831005046.5lndwdr7cfm3k3to@synopsys.com>
	<2e678109-8399-48d5-9567-033eab910bca@samsung.com>
	<20240904010322.leqt3pap6lguivg4@synopsys.com>
	<11535d95-c972-4dbe-afb5-de3a44bc4a21@samsung.com>
	<CGME20240905002630epcas5p4532c1e66864e39990376b696aa1f53d7@epcas5p4.samsung.com>
	<20240905002611.rxlv66zsker2h5w2@synopsys.com>
	<d5552437-119c-4a0f-9d71-6959727b6364@samsung.com>
	<20240905211338.omst6jr3okbxkqdh@synopsys.com>
	<f9561f03-5f83-4270-b7f3-17b880cfabfe@samsung.com>
	<20240905231825.6r2sp2bapxidur7a@synopsys.com>


On 9/6/2024 4:48 AM, Thinh Nguyen wrote:
> On Fri, Sep 06, 2024, Selvarasu Ganesan wrote:
>> On 9/6/2024 2:43 AM, Thinh Nguyen wrote:
>>> On Thu, Sep 05, 2024, Selvarasu Ganesan wrote:
>>>> On 9/5/2024 5:56 AM, Thinh Nguyen wrote:
>>>>> On Wed, Sep 04, 2024, Selvarasu Ganesan wrote:
>>>>>> On 9/4/2024 6:33 AM, Thinh Nguyen wrote:
>>>>>>> On Mon, Sep 02, 2024, Selvarasu Ganesan wrote:
>>>>>>>> I would like to reconfirm from our end that in our failure scenario, we
>>>>>>>> observe that DWC3_EVENT_PENDING is set in evt->flags when the dwc3
>>>>>>>> resume sequence is executed, and the dwc->pending_events flag is not
>>>>>>>> being set.
>>>>>>>>
>>>>>>> If the controller is stopped, no event is generated until it's restarted
>>>>>>> again. (ie, you should not see GEVNTCOUNT updated after clearing
>>>>>>> DCTL.run_stop). If there's no event, no interrupt assertion should come
>>>>>>> from the controller.
>>>>>>>
>>>>>>> If the pending_events is not set and you still see this failure, then
>>>>>>> likely that the controller had started, and the interrupt is generated
>>>>>>> from the controller event. This occurs along with the interrupt
>>>>>>> generated from your connection notification from your setup.
>>>>>> I completely agree. My discussion revolves around the handling of the
>>>>>> DWC3_EVENT_PENDING flag in all situations. The purpose of using this
>>>>>> flag is to prevent the processing of new events if an existing event is
>>>>>> still being processed. This flag is set in the top-half interrupt
>>>>>> handler and cleared at the end of the bottom-half handler.
>>>>>>
>>>>>> Now, let's consider scenarios where the bottom half is not scheduled,
>>>>>> and a USB reconnect occurs. In this case, there is a possibility that
>>>>>> the interrupt line is unmasked in dwc3_event_buffers_setup, and the USB
>>>>>> controller begins posting new events. The top-half interrupt handler
>>>>>> checks for the DWC3_EVENT_PENDING flag and returns IRQ_HANDLED without
>>>>>> processing any new events. However, the USB controller continues to post
>>>>>> interrupts until they are acknowledged.
>>>>>>
>>>>>> Please review the complete sequence once with DWC3_EVENT_PENDING flag.
>>>>>>
>>>>>> My proposal is to clear or reset the DWC3_EVENT_PENDING flag when
>>>>>> unmasking the interrupt line dwc3_event_buffers_setup, apart from
>>>>>> bottom-half handler. Clearing the DWC3_EVENT_PENDING flag in
>>>>>> dwc3_event_buffers_setup does not cause any harm, as we have implemented
>>>>>> a temporary workaround in our test setup to prevent IRQ storms.
>>>>>>
>>>>>>
>>>>>>
>>>>>> Working scenarios:
>>>>>> ==================
>>>>>> 1. Top-half handler:
>>>>>>         a. if (evt->flags & DWC3_EVENT_PENDING)
>>>>>>             return IRQ_HANDLED;
>>>>>>         b. Set DWC3_EVENT_PENDING flag
>>>>>>         c. Masking interrupt line
>>>>>>
>>>>>> 2. Bottom-half handler:
>>>>>>         a. Un-masking interrupt line
>>>>>>         b. Clear DWC3_EVENT_PENDING flag
>>>>>>
>>>>>> Failure scenarios:
>>>>>> ==================
>>>>>> 1. Top-half handler:
>>>>>>         a. if (evt->flags & DWC3_EVENT_PENDING)
>>>>>>                     return IRQ_HANDLED;
>>>>>>         b. Set DWC3_EVENT_PENDING flag
>>>>>>         c. Masking interrupt line
>>>>> For DWC3_EVENT_PENDING flag to be set at this point (before we start the
>>>>> controller), that means that the GEVNTCOUNT was not 0 after
>>>>> soft-disconnect and that the pm_runtime_suspended() must be false.
>>>> In the top-half code where we set the DWC3_EVENT_PENDING flag, we
>>>> acknowledge GEVNTCOUNT. Therefore, I think it is not necessary for
>>>> GEVNTCOUNT to have a non-zero value until a new event occurs. In fact,
>>>> when we tried to print GEVNTCOUNT in a non-interrupt context, we found
>>>> that it was zero, where we received DWC3_EVENT_PENDING being set in
>>>> non-interrupt context.
>>> For DWC3_EVENT_PENDING to be set, GEVNTCOUNT must be non-zero. If you
>>> see it's zero, that means that it was already decremented by the driver.
>>>
>>> If the driver acknowledges the GEVNTCOUNT, then that means that the
>>> events are copied and prepared to be processed. The bottom-half thread
>>> is scheduled. If it's for stale event, I don't want it to be processed.
>>>
>>>>>> 2. No Bottom-half scheduled:
>>>>> Why is the bottom-half not scheduled? Or do you mean it hasn't woken up
>>>>> yet before the next top-half coming?
>>>> In very rare cases, it is possible in our platform that the CPU may not
>>>> be able to schedule the bottom half of the dwc3 interrupt because a work
>>>> queue lockup has occurred on the same CPU that is attempting to schedule
>>>> the dwc3 thread interrupt. In this case Yes, the bottom-half handler
>>>> hasn't woken up, then initiate an IRQ storm for new events after the
>>>> controller restarts, resulting in no more bottom-half scheduling due to
>>>> the CPU being stuck in processing continuous interrupts and return
>>>> IRQ_HANDLED by checking if (evt->flags & DWC3_EVENT_PENDING).
>>>>
>>>>>> 3. USB reconnect: dwc3_event_buffers_setup
>>>>>>         a. Un-masking interrupt line
>>>>> Do we know that the GEVNTCOUNT is non-zero before starting the
>>>>> controller again?
>>>> The GEVNTCOUNT value showing as zero that we confirmed by adding debug
>>>> message here.
>>>>>> 4. Continuous interrupts : Top-half handler:
>>>>>>         a. if (evt->flags & DWC3_EVENT_PENDING)
>>>>>>                     return IRQ_HANDLED;
>>>>>>
>>>>>>         a. if (evt->flags & DWC3_EVENT_PENDING)
>>>>>>                     return IRQ_HANDLED;
>>>>>>
>>>>>>         a. if (evt->flags & DWC3_EVENT_PENDING)
>>>>>>                     return IRQ_HANDLED;
>>>>>> .....
>>>>>>
>>>>>> .....
>>>>>>
>>>>>> .....
>>>>>>
>>>> Sure, I can try implementing the proposed code modifications in our
>>>> testing environment.
>>>>
>>>> But, I am uncertain about how these changes will effectively prevent an
>>>> IRQ storm when the USB controller sequence restarts with the
>>>> DWC3_EVENT_PENDING. The following code will only execute until the
>>>> DWC3_EVENT_PENDING is cleared, at which point the previous bottom-half
>>>> will not be scheduled.
>>>>
>>>> Please correct me if i am wrong in my above understanding.
>>> As I mentioned, I don't want DWC3_EVENT_PENDING flag to be set due to
>>> the stale event. I want to ignore and skip processing any stale event.
>>>
>>> The DWC3_EVENT_PENDING should not be set by the time
>>> dwc3_event_buffers_setup() is called.
>>>
>>> Specifically review this condition in my testing patch:
>>>
>>> 	/*
>>> 	 * If the controller is halted, the event count is stale/invalid. Ignore
>>> 	 * them. This happens if the interrupt assertion is from an out-of-band
>>> 	 * resume notification.
>>> 	 */
>>> 	if (!dwc->pullups_connected && count) {
>>> 		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), count);
>>> 		return IRQ_HANDLED;
>>> 	}
>>>
>>> Let me know if the condition matches with what's happening for your
>>> case.
>> Hi Thinh,
>>
>> Thanks for your continuous reviews and suggestions.
>>
>> The given condition also will not matches in our case.
>> As i mentioned in starting of this thread please refer once the below
>> link of older discussion for similar issue from Samsung..
>>
>> https://urldefense.com/v3/__https://lore.kernel.org/linux-usb/20230102050831.105499-1-jh0801.jung@samsung.com/__;!!A4F2R9G_pg!a3VpPHvMr9enk0YPjSoWJ12Kr5Hw2Ka43Q_wi80lw6ty2tJT4hKRKsCnQNdqbVS3JORK2VwqdoXDWz1q8ynpe7Ex6cU$
>>
>>
>> DWC3_EVENT_PENDING flags set when count is 0.
>> It means "There are no interrupts to handle.".
>>
>> (struct dwc3_event_buffer *) ev_buf = 0xFFFFFF883DBF1180 (
>> 	(void *) buf = 0xFFFFFFC00DBDD000 = end+0x337D000,
>> 	(void *) cache = 0xFFFFFF8839F54080,
>> 	(unsigned int) length = 0x1000,
>> 	(unsigned int) lpos = 0x0,
>> *(unsigned int) count = 0x0, (unsigned int) flags = 0x00000001,*
>> 	(dma_addr_t) dma = 0x00000008BD7D7000,
>> 	(struct dwc3 *) dwc = 0xFFFFFF8839CBC880,
>> 	(u64) android_kabi_reserved1 = 0x0),
>
> This is the info of the event buffer that was reset after the
> dwc3_event_buffers_setup(). I'm talking about the first time
> DWC3_EVENT_PENDING flag was set.

Yes, the buffer that was reset before as part of 
dwc3_event_buffers_setup() is correct.
I agree on your new code changes in below will prevent setting 
DWC3_EVENT_PENDING and avoid the bottom-half handler if the controller 
is halted, and the event count is invalid.

Are you suspecting that the DWC3_EVENT_PENDING flag was only set in this 
scenario in our failure case?

/*diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 89fc690fdf34..a525f7ea5886 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4490,6 +4490,17 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
  		return IRQ_HANDLED;
  
  	count = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
+
+	/*
+	 * If the controller is halted, the event count is stale/invalid. Ignore
+	 * them. This happens if the interrupt assertion is from an out-of-band
+	 * resume notification.
+	 */
+	if (!dwc->pullups_connected && count) {
+		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), count);
+		return IRQ_HANDLED;
+	}
+
  	count &= DWC3_GEVNTCOUNT_MASK;
  	if (!count)
  		return IRQ_NONE;

>
> By the time the interrupt storm below occur, the count in the buffer is
> already zero'ed out.
>
>> IRQ Storm:
>> (time = 47557628930999, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
>> (time = 47557628931268, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
>> (time = 47557628932383, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
>> (time = 47557628932652, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
>> (time = 47557628933768, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
>> (time = 47557628934037, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
>> ...
>> ...
>> ...
>>
>>
>> We are also fine with below code changes as you suggested earlier.
>> https://urldefense.com/v3/__https://lore.kernel.org/linux-usb/20230109190914.3blihjfjdcszazdd@synopsys.com/__;!!A4F2R9G_pg!a3VpPHvMr9enk0YPjSoWJ12Kr5Hw2Ka43Q_wi80lw6ty2tJT4hKRKsCnQNdqbVS3JORK2VwqdoXDWz1q8ynp367zvEw$
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 65500246323b..3c36dfdb88f0 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -5515,8 +5515,15 @@ static irqreturn_t dwc3_check_event_buf(struct
>> dwc3_event_buffer *evt)
>>            * irq event handler completes before caching new event to prevent
>>            * losing events.
>>            */
>> -       if (evt->flags & DWC3_EVENT_PENDING)
>> +       if (evt->flags & DWC3_EVENT_PENDING) {
>> +               if (!evt->count) {
>> +                       u32 reg = dwc3_readl(dwc->regs, DWC3_GEVNTSIZ(0));
>> +
>> +                       if (!(reg & DWC3_GEVNTSIZ_INTMASK))
>> +                               evt->flags &= ~DWC3_EVENT_PENDING;
>> +               }
>>                   return IRQ_HANDLED;
>> +       }
>>
>>
> I don't want the bottom-half to be scheduled in the beginning as it may
> come before the cleanup in dwc3_event_buffers_setup().
You mean the above changes for clearing DWC3_EVENT_PENDINGnot required 
as you given new change will prevent setting of DWC3_EVENT_PENDING 
before dwc3_event_buffers_setup().
But I dont see any harm in above code changes for clearing 
DWC3_EVENT_PENDING if it already set with evt->count=0.

Anyway I will try the your new proposed changes alone on our testing 
setup and will update the status,


>
> BR,
> Thinh

