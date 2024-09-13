Return-Path: <linux-kernel+bounces-328189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D96097804A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1BFD28499E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B53F1DA2E2;
	Fri, 13 Sep 2024 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GeQB5+jy"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD3A1D6DA0
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726231345; cv=none; b=ge+uH4SZZQY6eDpB4yb88As8V+yYwkfQO+++jtTpWZMYDoq/NhSLSuvskQ+9BWITgn5TWIbKx/uWNtlrE7iVjMbhhfXJ8+Y4DWAWgZBuFDZ/PBGnbN0UML0uSSBRKDIa509RnQHmF54Tck/ZQZAk06pONrup57KfPFP0UamEJnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726231345; c=relaxed/simple;
	bh=s5pFfvEOI7fNZFwDF7FXjBZEe5M29/s7SLPDATThLQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=fQgab58ZYRfkMPTwtAXbCIZqYs/9rcE+2MD8UDUk4DGsD6fL9bsOkwGprRJGtnLwQjzJPgaYh/flGd4GB9kyqJApli+4cbuPiZl5jsRALeufJTCIB8uXmc5vGjsSAp7cqX4n320e1qEj1zG7XnMGMaJs1jezzRX0zaNaYFYh25U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GeQB5+jy; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240913124220epoutp0459b3e41b60b24dd132034d697fe7850d~0zkH_jeDW2277122771epoutp04K
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:42:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240913124220epoutp0459b3e41b60b24dd132034d697fe7850d~0zkH_jeDW2277122771epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726231340;
	bh=69uLk9lGiimVrr7ddMJOWyqtrTyPP1DP+O9FhTYpyZY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=GeQB5+jyo/E5SSptqWH4yFsu9oqc2oKFToPUgq/WO54WgMiSOnEs9k9/Z9Z/eulH1
	 vGiG7dTiyPxJvU3bM3spYifYzmIXwnl7n+hvrokv/cLH/pOrbGgwkAwq2GKtmLK9mw
	 2nf0ATkfpUjPpyH7oVSZ9cVNuCBdjaprO9tBjyg4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240913124219epcas5p36fff23e8c89eb1b94f3012895707b44a~0zkHYLTdv2858828588epcas5p3t;
	Fri, 13 Sep 2024 12:42:19 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4X4v8V1Hghz4x9Pq; Fri, 13 Sep
	2024 12:42:18 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3A.88.09743.92334E66; Fri, 13 Sep 2024 21:42:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240913124217epcas5p122019d5707ab9bff8283e14ffd6662fa~0zkFna7ZM2928429284epcas5p1W;
	Fri, 13 Sep 2024 12:42:17 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240913124217epsmtrp2c3e2b796da78873e40c23980eb439a30~0zkFmvHPE2066820668epsmtrp2W;
	Fri, 13 Sep 2024 12:42:17 +0000 (GMT)
X-AuditID: b6c32a4a-14fff7000000260f-b5-66e43329c6c5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	7C.B1.19367.92334E66; Fri, 13 Sep 2024 21:42:17 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240913124213epsmtip1c29b0ecbd23761043cc28d8ebba6fd1d~0zkCR9dek0184701847epsmtip1W;
	Fri, 13 Sep 2024 12:42:13 +0000 (GMT)
Message-ID: <dd7965fa-9266-46b9-9219-1ef726480a9b@samsung.com>
Date: Fri, 13 Sep 2024 18:12:04 +0530
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
In-Reply-To: <20240911002408.gr4fv5vkst7ukxd5@synopsys.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmhq6m8ZM0g0UbrS3eXF3FanFnwTQm
	i1PLFzJZNC9ez2Yxac9WFou7D3+wWFzeNYfNYtGyVmaLT0f/s1qs6pwDFPu+k9li0kFRi1UL
	DrA78Hrsn7uG3aNvyypGjy37PzN6fN4kF8ASlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pm
	YKhraGlhrqSQl5ibaqvk4hOg65aZA3SekkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUg
	JafApECvODG3uDQvXS8vtcTK0MDAyBSoMCE740BXN3vBG9eKA1O2MjcwzrHqYuTkkBAwkbi4
	ZS97FyMXh5DAbkaJCQsXsEI4nxgl+md9Z4Jzfi6bwAjTcu19A1TVTkaJU3/PMkM4bxkl/qxb
	C1bFK2Ancb9nNxuIzSKgKvFpQhcTRFxQ4uTMJywgtqiAvMT9WzPYQWxhgQCJK0tmgPWKCOhI
	HDhxHmw1s0AHq8SC7jawZmYBcYlbT+YD2RwcbAKGEs9O2ICEOQWsJXZc+skKUSIv0bx1NthB
	EgIrOSSO725igzjbRWJPxwuoF4QlXh3fwg5hS0l8frcXqqZaYvWdj2wQzS2MEoeffIMqspd4
	fPQRM8hiZgFNifW79CGW8Un0/n4Cdo+EAK9ER5sQRLWqxKnGy1AjpSXuLbnGCmF7SDy5Oh/s
	BCGBHlaJ5hXBExgVZiEFyywkX85C8s4shMULGFlWMUqmFhTnpqcWmxYY5aWWw2M8OT93EyM4
	+Wp57WB8+OCD3iFGJg7GQ4wSHMxKIryT2B6lCfGmJFZWpRblxxeV5qQWH2I0BcbPRGYp0eR8
	YPrPK4k3NLE0MDEzMzOxNDYzVBLnfd06N0VIID2xJDU7NbUgtQimj4mDU6qBaX+00rnMtb8W
	m3TIqVo9DWjQ6Ozc8us4m86kbfpr1a0LLKUfeyeeWn9UqtX94dtby8pvcVbEJ00XORh25KY6
	P68uG4eAmaRMkfmrySv9VicJFvdVeTH5JXZOCWRlj587+VOK7o7tWSEV1172b3pvd2rTraX6
	L+ZHT241qz7ixXzt8vmeu065oS6xvpf/a9y+euXEy/PrXhZXMiywtntkK/Rm+mqTbSyLTkp+
	SPilx5N1tfhftFLD9s+RvQdPPjZcdkdnxkQRpxtxW8Lv1fnzH4g491lItM3gq+/TQw2ZXGc9
	ihN0/nYtFLuvIK/gkfKuNCuyzy6hcmM6m+ilQ61/v3olVHjVX+R7lm3kardZiaU4I9FQi7mo
	OBEAEIjJekcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJTlfT+EmaQfN1QYs3V1exWtxZMI3J
	4tTyhUwWzYvXs1lM2rOVxeLuwx8sFpd3zWGzWLSsldni09H/rBarOucAxb7vZLaYdFDUYtWC
	A+wOvB77565h9+jbsorRY8v+z4wenzfJBbBEcdmkpOZklqUW6dslcGUc6OpmL3jjWnFgylbm
	BsY5Vl2MnBwSAiYS1943sILYQgLbGSVmLrKFiEtLvJ7VxQhhC0us/PecvYuRC6jmNaPE78vN
	TCAJXgE7ifs9u9lAbBYBVYlPE7qg4oISJ2c+YQGxRQXkJe7fmsEOYgsL+ElMf3MCbKiIgI7E
	gRPnmUCGMgv0sEp8+fqRBWIDkLPj/C9mkCpmAXGJW0/mA1VxcLAJGEo8O2EDEuYUsJbYcekn
	K0SJmUTXVohLmYGWNW+dzTyBUWgWkjtmIZk0C0nLLCQtCxhZVjGKphYU56bnJhcY6hUn5haX
	5qXrJefnbmIEx5dW0A7GZev/6h1iZOJgPMQowcGsJMI7ie1RmhBvSmJlVWpRfnxRaU5q8SFG
	aQ4WJXFe5ZzOFCGB9MSS1OzU1ILUIpgsEwenVANTuQTrtxiuizvnmk99l6N+jOdhmvC2dR53
	Il5d8v5wcE6fgVTB3br1R/2fv546d9Ouq5xXVsXuWxQlOun6/LOc9U6fDobe8T7V7/Q8+nfZ
	jeqmO31OmfUmE++I/Snv44spXlcWzJR231kx4F3kfueIEosTuouV6p/bFa3b6FyWFdN8fk6S
	XKPZxTXWAXv+nVp/5MzyhyEXrZ6cPNR0ZpaPSZdXx9fE9kuBf0v//vKxmL3IO3SigkCjivk1
	+xPTJQMLTxd1Bt96lheilmT6p1sx58ztEpPla3qshOQuzjsf4B549+kv16kZU9eprWjZ+vnZ
	t5OCodEC31ZcsPsS51th/FXCY5lSANc/KfHt+V/XK7EUZyQaajEXFScCABxvwZ4eAwAA
X-CMS-MailID: 20240913124217epcas5p122019d5707ab9bff8283e14ffd6662fa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240911002436epcas5p19be55e1144edd6f77184192c7f22a85e
References: <20240905002611.rxlv66zsker2h5w2@synopsys.com>
	<d5552437-119c-4a0f-9d71-6959727b6364@samsung.com>
	<20240905211338.omst6jr3okbxkqdh@synopsys.com>
	<f9561f03-5f83-4270-b7f3-17b880cfabfe@samsung.com>
	<20240905231825.6r2sp2bapxidur7a@synopsys.com>
	<64d049cc-d55d-4376-b6b9-402eb6f170c0@samsung.com>
	<20240906005935.caugoe3mqqdqwqao@synopsys.com>
	<30ca8527-419b-4e44-a21b-18e494b39076@samsung.com>
	<20240907003946.qn6t3xw65qwl2cn7@synopsys.com>
	<dff83c7d-56b8-481f-af69-8d4262bd54e4@samsung.com>
	<CGME20240911002436epcas5p19be55e1144edd6f77184192c7f22a85e@epcas5p1.samsung.com>
	<20240911002408.gr4fv5vkst7ukxd5@synopsys.com>


On 9/11/2024 5:54 AM, Thinh Nguyen wrote:
> On Tue, Sep 10, 2024, Selvarasu Ganesan wrote:
>> On 9/7/2024 6:09 AM, Thinh Nguyen wrote:
>>> On Sat, Sep 07, 2024, Selvarasu Ganesan wrote:
>>>> Hi Thinh,
>>>>
>>>> I ran the code you recommended on our testing environment and was able
>>>> to reproduce the issue one time.
>>>>
>>>> When evt->flags contains DWC3_EVENT_PENDING, I've included the following
>>>> debugging information: I added this debug message at the start of
>>>> dwc3_event_buffers_cleanup and dwc3_event_buffers_setup functions in
>>>> during suspend and resume.
>>>>
>>>> The results were quite interesting . I'm curious to understand how
>>>> evt->flags is set to DWC3_EVENT_PENDING, and along with DWC3_GEVNTSIZ is
>>>> equal to 0x1000 during the suspend.
>>> That is indeed strange.
>>>
>>>> Its means that the previous bottom-half handler prior to suspend might
>>>> still be executing in the middle of the process.
>>>>
>>>> Could you please give your suggestions here? And let me know if anything
>>>> want to test or additional details are required.
>>>>
>>>>
>>>> ##DBG: dwc3_event_buffers_cleanup:
>>>>     evt->length    :0x1000
>>>>     evt->lpos      :0x20c
>>>>     evt->count     :0x0
>>>>     evt->flags     :0x1 // This is Unexpected if DWC3_GEVNTSIZ(0)(0xc408):
>>>> 0x00001000. Its means that previous bottom-half handler may be still
>>>> running in middle
>>> Perhaps.
>>>
>>> But I doubt that's the case since it shouldn't take that long for the
>>> bottom-half to be completed before the next resume yet the flag is still
>>> set.
>>>
>>>>     DWC3_GEVNTSIZ(0)(0xc408)       : 0x00001000
>>>>     DWC3_GEVNTCOUNT(0)(0xc40c)     : 0x00000000
>>>>     DWC3_DCFG(0xc700)              : 0x00e008a8
>>>>     DWC3_DCTL(0xc704)              : 0x0cf00a00
>>>>     DWC3_DEVTEN(0xc708)            : 0x00000000
>>>>     DWC3_DSTS(0xc70c)              : 0x00d20cd1
>>>>
>>> The controller status is halted. So there's no problem with
>>> soft-disconnect. For the interrupt mask in GEVNTSIZ to be cleared,
>>> that likely means that the bottom-half had probably completed.
>> Agree, But I am worrying on If the bottom-half is completed, then
>> DWC3_EVENT_PENDING must be cleared in evt->flags.
>> Is there any possibility of a CPU reordering issue when updating
>> evt->flags in the bottom-half handler?.
>> Should I try with wmb() when writing to evt->flags?
> Assuming that the problem occurs after the bottom-half completed, there
> should be implicit memory barrier. The memory operation should complete
> before the release from spin_unlock complete. I don't think wmb() will
> help.
Agree.
>>>> ##DBG: dwc3_event_buffers_setup:
>>>>     evt->length    :0x1000
>>>>     evt->lpos      :0x20c
>>> They fact that evt->lpos did not get updated tells me that there's
>>> something wrong with memory access to your platform during suspend and
>>> resume.
>> Are you expecting the evt->lpos value to be zero here? If so, this is
>> expected in our test setup because we avoid writing zero to evt->lpos as
>> part of dwc3_event_buffers_cleanup if evt->flags have a value of 1. This
> Oh ok. I did not know you made this modification.
>
>> is simply to track the status of evt->lpos during suspend to resume when
>> evt->flags have a value of DWC3_EVENT_PENDING. The following test codes
>> for the reference.
>>
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -505,8 +505,20 @@ static int dwc3_alloc_event_buffers(struct dwc3
>> *dwc, unsigned int length)
>>    int dwc3_event_buffers_setup(struct dwc3 *dwc)
>>    {
>>           struct dwc3_event_buffer        *evt;
>> +       u32                             reg;
>>
>>           evt = dwc->ev_buf;
>> +
>> +       if (evt->flags & DWC3_EVENT_PENDING) {
>> +               pr_info("evt->length :%x\n", evt->length);
>> +               pr_info("evt->lpos :%x\n", evt->lpos);
>> +               pr_info("evt->count :%x\n", evt->count);
>> +               pr_info("evt->flags :%x\n", evt->flags);
>> +
>> +               dwc3_exynos_reg_dump(dwc);
>> +
>> +       }
>> +
>>           evt->lpos = 0;
>>           dwc3_writel(dwc->regs, DWC3_GEVNTADRLO(0),
>>                           lower_32_bits(evt->dma));
>> @@ -514,8 +526,10 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
>>                           upper_32_bits(evt->dma));
>>           dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
>>                           DWC3_GEVNTSIZ_SIZE(evt->length));
>> -       dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), 0);
>>
>> +       /* Clear any stale event */
>> +       reg = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
>> +       dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), reg);
>>           return 0;
>>    }
>>
>> @@ -525,7 +539,16 @@ void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
>>
>>           evt = dwc->ev_buf;
>>
>> -       evt->lpos = 0;
>> +       if (evt->flags & DWC3_EVENT_PENDING) {
>> +               pr_info("evt->length :%x\n", evt->length);
>> +               pr_info("evt->lpos :%x\n", evt->lpos);
>> +               pr_info("evt->count :%x\n", evt->count);
>> +               pr_info("evt->flags :%x\n", evt->flags);
>> +
>> +               dwc3_exynos_reg_dump(dwc);
>> +       } else {
>> +               evt->lpos = 0;
> I wasn't aware of this change.
>
>> +       }
>>
>>>>     evt->count     :0x0
>>>>     evt->flags     :0x1 // Still It's not clearing in during resume.
>>>>
>>>>     DWC3_GEVNTSIZ(0)(0xc408)       : 0x00000000
>>>>     DWC3_GEVNTCOUNT(0)(0xc40c)     : 0x00000000
>>>>     DWC3_DCFG(0xc700)              : 0x00080800
>>>>     DWC3_DCTL(0xc704)              : 0x00f00000
>>>>     DWC3_DEVTEN(0xc708)            : 0x00000000
>>>>     DWC3_DSTS(0xc70c)              : 0x00d20001
>>>>
>>> Please help look into your platform to see what condition triggers this
>>> memory access issue. If this is a hardware quirk, we can properly update
>>> the change and note it to be so.
>> Sure I will try to figure it out. However, we are facing challenges in
>> reproducing the issue. There could be a delay in understanding the
>> conditions that trigger the memory issue if it is related to a memory issue.
>>
>>> Thanks,
>>> Thinh
>>>
>>> (If possible, for future tests, please dump the dwc3 tracepoints. Many
>>> thanks for the tests.)
>> I tried to get dwc3 traces in the failure case, but so far no instances
>> have been reported. Our testing is still in progress with enable dwc3
>> traces.
>>
>> I will keep posting once I get the dwc3 traces in the failure scenario.
>>
> Thanks for the update. I hope enabling of the driver tracepoints will
> not impact the reproduction of the issue. With the driver log, we'll get
> more clues to what was going on.
>
> Thanks,
> Thinh
Hi Thinh,

So far, there have been no reported error instances. But, we suspecting 
that the issue may be related to our glue driver. In our glue driver, we 
access the reference of evt->flags when starting or stopping the gadget 
based on a VBUS notification. We apologize for sharing this information 
so late, as we only became aware of it recently.

The following sequence outlines the possible scenarios of race conditions:

Thread#1 (Our glue Driver Sequence)
===================================
->USB VBUS notification
->Start/Stop gadget
->dwc->ev_buf->flags |= BIT(20); (It's for our reference)
->Call dwc3 exynos runtime suspend/resume
->dwc->ev_buf->flags &= ~BIT(20);
->Call dwc3 core runtime suspend/resume

Thread#2
========
->dwc3_interrupt()
->evt->flags |= DWC3_EVENT_PENDING;
->dwc3_thread_interrupt()
->evt->flags &= ~DWC3_EVENT_PENDING;



After our internal discussions, we have decided to remove the 
unnecessary access to evt->flag in our glue driver. We have made these 
changes and initiated testing.

Thank you for your help so far to understand more into our glue driver code.

And We are thinking that it would be fine to reset evt->flag when the 
USB controller is started, along with the changes you suggested earlier. 
This additional measure will help prevent similar issues from occurring 
in the future.

Please let us know your thoughts on this proposal. If it is not 
necessary, we understand and will proceed accordingly.


Thanks,
Selva


