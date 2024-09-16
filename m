Return-Path: <linux-kernel+bounces-331186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A5697A96D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 00:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADED01C2127E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 22:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45D9153808;
	Mon, 16 Sep 2024 22:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fGBbtDxR"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E58E13C8F3
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726527262; cv=none; b=H/HuKkbnarSejb7wQuY0g5q9yr0FtM7JBfOAdHrHD/iO7jiuBhhQtilu8blKPcBpkaYtgIsFfyLQAz96AixGTVLxG6Tbkdg7vE+YIjI0J+v7tf7xR5SLpUxq/Dgg2Q/SXA4p94un2tprf6qq7rIonbbu0pkAAN/dV22DfcW8D6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726527262; c=relaxed/simple;
	bh=jAhBrVYoluyaqsybi2E8xENGRagHDVg9JLsB5Ig0Apo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=hn+vDTCeCCvpNONTk41iLLDXqVkeLiWQ1P7RCCXK5iiZzndra3nK0PICBCDtJtVAVs3Cp8ERCNppNoh5b1gIcjf+cde7bbptB4wvShyis5BDf2XB1phdC2isispUf7CQPn5Rk8P9tWcsQqQGNfkZYbp7W86oN/7F+6nst3ygNlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fGBbtDxR; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240916225417epoutp04a3da2cf493c669e1a12badc032acf885~122StCi1W0547605476epoutp04K
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:54:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240916225417epoutp04a3da2cf493c669e1a12badc032acf885~122StCi1W0547605476epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726527257;
	bh=4U45AWwW9pIBWcvWv3JZJ+PmTEKQCsH8vsyYcc/cj8M=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=fGBbtDxR3Ktcc3Mn+suXfhbIPMFHaKYahuSft3SXK6D53Tiuytp6VehiZT7sUs34f
	 DS2w67SJ4ResNeQQWKLfqpCd+yN5exHB2IVx/KujreijPafiQeTIzPusymRu/fupSY
	 sy0pO1814fF44Pc4q7uNllXrBQ8qailF0j0pD9cE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240916225417epcas5p4cfc11009984974263ed1c8b9ad470f24~122SWo_3I3255132551epcas5p4_;
	Mon, 16 Sep 2024 22:54:17 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4X70bD0bcLz4x9Pp; Mon, 16 Sep
	2024 22:54:16 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7C.C4.19863.717B8E66; Tue, 17 Sep 2024 07:54:15 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240916225415epcas5p1968703c07fb3102f42b9322460bb8404~122QqU1dx1967619676epcas5p1y;
	Mon, 16 Sep 2024 22:54:15 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240916225415epsmtrp2b2f61bcc303d4569bdb2ee8d48809894~122QpjAhm0408304083epsmtrp2v;
	Mon, 16 Sep 2024 22:54:15 +0000 (GMT)
X-AuditID: b6c32a50-ef5fe70000004d97-00-66e8b71730c8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	97.BB.08456.717B8E66; Tue, 17 Sep 2024 07:54:15 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240916225413epsmtip29cd70fca384d952f0dbdf2b12b6ad1f9~122OyuroR2812828128epsmtip2m;
	Mon, 16 Sep 2024 22:54:13 +0000 (GMT)
Message-ID: <2aa4bfd4-b7ce-4b00-b21e-781936c4a0fd@samsung.com>
Date: Tue, 17 Sep 2024 04:24:00 +0530
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
In-Reply-To: <20240916211819.ulvmre4o57bhrr6q@synopsys.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmlq749hdpBrtWWli8ubqK1eLOgmlM
	FqeWL2SyaF68ns1i0p6tLBZ3H/5gsbi8aw6bxaJlrcwWn47+Z7VY1TkHKPZ9J7PFpIOiFqsW
	HGB34PXYP3cNu0ffllWMHlv2f2b0+LxJLoAlKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTM
	wFDX0NLCXEkhLzE31VbJxSdA1y0zB+g8JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpB
	Sk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2xoLJj1gLZrhXLN2/krGBcY5NFyMnh4SAicSD
	ZW+Yuhi5OIQE9jBKnN+9ig3C+cQo8aBrNzuE841R4t3iR8wwLdfuXINq2csoMa1tNiOE85ZR
	onnqA3aQKl4BO4lLLatZQGwWAVWJjYc+s0LEBSVOznwCFhcVkJe4f2sGWL2wQIDElSUzGEFs
	EQEdiQMnzoNtYBboYJVY0N3GBJJgFhCXuPVkPpDNwcEmYCjx7ATYE5wC1hKNV06xQpTISzRv
	nc0M0ishsJZD4s7uk+wQZ7tIXLh9mgXCFpZ4dXwLVFxK4vO7vWwQdrXE6jsf2SCaWxglDj/5
	BlVkL/H4KMj/HEAbNCXW79KHWMYn0fv7Cdg9EgK8Eh1tQhDVqhKnGi9DjZSWuLfkGiuE7SHx
	5Op8aGDdZpFYffwm+wRGhVlI4TILyZuzkPwzC2HzAkaWVYxSqQXFuempyaYFhrp5qeXwOE/O
	z93ECE7AWgE7GFdv+Kt3iJGJg/EQowQHs5IIr+3vp2lCvCmJlVWpRfnxRaU5qcWHGE2BMTSR
	WUo0OR+YA/JK4g1NLA1MzMzMTCyNzQyVxHlft85NERJITyxJzU5NLUgtgulj4uCUamBSve/i
	FW/kMqFoh7JrcA1vdn+3VmJEoHD85WWnV5WfbrE/qcTEKpIUu66rY++Tbn+ZZ+vUme6FnXXd
	7Pa5YarEk1m104R/cfCxHL5yX0a9pOrZIvbAIm+N6kouhmKTjdkbFG/NyWFyEXJ7KHbimv3k
	Px+OVOmLMHjtlNi1LryzuTgv5cfZq3aRpQJMUgadXCtPKwmEvQ99F3xS/0LJ6lTRWFlxqxrf
	HYstslu4KjNjNrf/+f3m8qUPU+TeSK2sLurvk5koGHi98l3l8b8XuffJe5kHa3+PPBlatTRm
	/t3mrWtusi8qEQmaVGSSnl4odOKVvN7xuuyu+bMfuaz9tf232qariooL3Gr1F5WuV2Ipzkg0
	1GIuKk4EANOS6JlJBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJXld8+4s0g4MfhS3eXF3FanFnwTQm
	i1PLFzJZNC9ez2Yxac9WFou7D3+wWFzeNYfNYtGyVmaLT0f/s1qs6pwDFPu+k9li0kFRi1UL
	DrA78Hrsn7uG3aNvyypGjy37PzN6fN4kF8ASxWWTkpqTWZZapG+XwJWxYPIj1oIZ7hVL969k
	bGCcY9PFyMkhIWAice3ONaYuRi4OIYHdjBKdl+8zQySkJV7P6mKEsIUlVv57zg5R9JpR4k/j
	U3aQBK+AncSlltUsIDaLgKrExkOfWSHighInZz4Bi4sKyEvcvzUDrF5YwE9i+psTYENFBHQk
	Dpw4D7aZWaCHVeLL149gDUICt1kk1kwQAbGZBcQlbj2ZD1TEwcEmYCjx7ATY1ZwC1hKNV06x
	QpSYSXRthTiUGWhX89bZzBMYhWYhOWMWkkmzkLTMQtKygJFlFaNkakFxbnpusWGBUV5quV5x
	Ym5xaV66XnJ+7iZGcJxpae1g3LPqg94hRiYOxkOMEhzMSiK8tr+fpgnxpiRWVqUW5ccXleak
	Fh9ilOZgURLn/fa6N0VIID2xJDU7NbUgtQgmy8TBKdXApNT+MSFWYBbjzM3rGndPf2Gkp358
	4cuWXBtlxbkdNjqnGtk3sj380DTl6wPhazMv7iqs6nzhvpj1DveZP8ff+7DGT5NZdYKp/f6R
	K7leF69veHfMPT9369upuSdUWDKW/Uv8vze9jvnL1MyZnZfTuL2zs3cuWNGn3rjl1dE8j62b
	BHwsJNdf8PPk6//ocrnxULsGoxCbAqvamift6woll2lfdvmyTF95bdpNu4j+sL2zOLJUeoyK
	BZKbTrG8/19pVOIuYr/00zxD5jffk/5u9OYUODXR8onUwa7794L3fVhetF1vT9/jzhdfn8Qu
	LGh6y+Min7lpzgkeBhe7mI/Zv+5y3v8UpNCVvNyF/YbsPCWW4oxEQy3mouJEANY4sJ8iAwAA
X-CMS-MailID: 20240916225415epcas5p1968703c07fb3102f42b9322460bb8404
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240911002436epcas5p19be55e1144edd6f77184192c7f22a85e
References: <64d049cc-d55d-4376-b6b9-402eb6f170c0@samsung.com>
	<20240906005935.caugoe3mqqdqwqao@synopsys.com>
	<30ca8527-419b-4e44-a21b-18e494b39076@samsung.com>
	<20240907003946.qn6t3xw65qwl2cn7@synopsys.com>
	<dff83c7d-56b8-481f-af69-8d4262bd54e4@samsung.com>
	<CGME20240911002436epcas5p19be55e1144edd6f77184192c7f22a85e@epcas5p1.samsung.com>
	<20240911002408.gr4fv5vkst7ukxd5@synopsys.com>
	<dd7965fa-9266-46b9-9219-1ef726480a9b@samsung.com>
	<20240913175106.qbav2aigzwaj7pvd@synopsys.com>
	<2cf9624b-8612-46aa-a528-a8948ef4f5e1@samsung.com>
	<20240916211819.ulvmre4o57bhrr6q@synopsys.com>


On 9/17/2024 2:48 AM, Thinh Nguyen wrote:
> On Mon, Sep 16, 2024, Selvarasu Ganesan wrote:
>> On 9/13/2024 11:21 PM, Thinh Nguyen wrote:
>>> Hi,
>>>
>>> On Fri, Sep 13, 2024, Selvarasu Ganesan wrote:
>>>> Hi Thinh,
>>>>
>>>> So far, there have been no reported error instances. But, we suspecting
>>>> that the issue may be related to our glue driver. In our glue driver, we
>>>> access the reference of evt->flags when starting or stopping the gadget
>>>> based on a VBUS notification. We apologize for sharing this information
>>>> so late, as we only became aware of it recently.
>>>>
>>>> The following sequence outlines the possible scenarios of race conditions:
>>>>
>>>> Thread#1 (Our glue Driver Sequence)
>>>> ===================================
>>>> ->USB VBUS notification
>>>> ->Start/Stop gadget
>>>> ->dwc->ev_buf->flags |= BIT(20); (It's for our reference)
>>>> ->Call dwc3 exynos runtime suspend/resume
>>>> ->dwc->ev_buf->flags &= ~BIT(20);
>>>> ->Call dwc3 core runtime suspend/resume
>>>>
>>>> Thread#2
>>>> ========
>>>> ->dwc3_interrupt()
>>>> ->evt->flags |= DWC3_EVENT_PENDING;
>>>> ->dwc3_thread_interrupt()
>>>> ->evt->flags &= ~DWC3_EVENT_PENDING;
>>>>
>>> This is great! That's likely the problem. Glad you found it.
>>>
>>>> After our internal discussions, we have decided to remove the
>>>> unnecessary access to evt->flag in our glue driver. We have made these
>>>> changes and initiated testing.
>>>>
>>>> Thank you for your help so far to understand more into our glue driver code.
>>>>
>>>> And We are thinking that it would be fine to reset evt->flag when the
>>>> USB controller is started, along with the changes you suggested earlier.
>>>> This additional measure will help prevent similar issues from occurring
>>>> in the future.
>>>>
>>>> Please let us know your thoughts on this proposal. If it is not
>>>> necessary, we understand and will proceed accordingly.
>>>>
>>> You can submit the change I suggested. That's a valid change. However,
>>> we should not include the reset of the DWC3_EVENT_PENDING flag. Had we
>>> done this, you may not found the issue above. It serves no purpose for
>>> the core driver logic and will be an extra burden for us to maintain. (I
>>> don't want to scratch my head in the future to figure out why that
>>> change was needed or concern whether it can be removed without causing
>>> regression).
>> Yeah I understand.
>>
>> Please reconfirm the below changes once with commit message. I will post
>> new version if this changes are fine.
>>
>>
>> [PATCH] usb: dwc3: core: Stop processing of pending events if controller
>> is halted
>>
>> This commit addresses an issue where events were being processed when
>> the controller was in a halted state. To fix this issue by stop
>> processing the events as the event count was considered stale or
>> invalid when the controller was halted.
>>
>> Fixes: fc8bb91bc83e ("usb: dwc3: implement runtime PM")
>> Cc: stable <stable@kernel.org>
>> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
>> Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>> ---
>>    drivers/usb/dwc3/core.c   | 17 +++++++++++++++--
>>    drivers/usb/dwc3/core.h   |  4 ----
>>    drivers/usb/dwc3/gadget.c | 22 +++++++++++-----------
>>    3 files changed, 26 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 9eb085f359ce..f47b20bc2d1f 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -544,6 +544,7 @@ static int dwc3_alloc_event_buffers(struct dwc3
>> *dwc, unsigned int length)
>>    int dwc3_event_buffers_setup(struct dwc3 *dwc)
>>    {
>>           struct dwc3_event_buffer        *evt;
>> +       u32                             reg;
>>
>>           if (!dwc->ev_buf)
>>                   return 0;
>> @@ -556,8 +557,10 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
>>                           upper_32_bits(evt->dma));
>>           dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
>>                           DWC3_GEVNTSIZ_SIZE(evt->length));
>> -       dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), 0);
>>
>> +       /* Clear any stale event */
> Do the same thing here as in dwc3_event_buffers_cleanup().
done in new version.
>
>> +       reg = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
>> +       dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), reg);
>>           return 0;
>>    }
>>
>> @@ -2499,7 +2502,11 @@ static int dwc3_runtime_resume(struct device *dev)
>>
>>           switch (dwc->current_dr_role) {
>>           case DWC3_GCTL_PRTCAP_DEVICE:
>> -               dwc3_gadget_process_pending_events(dwc);
>> +               if (dwc->pending_events) {
>> +                       pm_runtime_put(dwc->dev);
>> +                       dwc->pending_events = false;
>> +                       enable_irq(dwc->irq_gadget);
>> +               }
>>                   break;
>>           case DWC3_GCTL_PRTCAP_HOST:
>>           default:
>> @@ -2589,6 +2596,12 @@ static void dwc3_complete(struct device *dev)
>>    static const struct dev_pm_ops dwc3_dev_pm_ops = {
>>           SET_SYSTEM_SLEEP_PM_OPS(dwc3_suspend, dwc3_resume)
>>           .complete = dwc3_complete,
>> +
>> +       /*
>> +        * Runtime suspend halts the controller on disconnection. It
>> replies on
>> +        * platforms with custom connection notification to start the
>> controller
>> +        * again.
>> +        */
>>           SET_RUNTIME_PM_OPS(dwc3_runtime_suspend, dwc3_runtime_resume,
>>                           dwc3_runtime_idle)
>>    };
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index c71240e8f7c7..9c508e0c5cdf 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -1675,7 +1675,6 @@ static inline void dwc3_otg_host_init(struct dwc3
>> *dwc)
>>    #if !IS_ENABLED(CONFIG_USB_DWC3_HOST)
>>    int dwc3_gadget_suspend(struct dwc3 *dwc);
>>    int dwc3_gadget_resume(struct dwc3 *dwc);
>> -void dwc3_gadget_process_pending_events(struct dwc3 *dwc);
>>    #else
>>    static inline int dwc3_gadget_suspend(struct dwc3 *dwc)
>>    {
>> @@ -1687,9 +1686,6 @@ static inline int dwc3_gadget_resume(struct dwc3 *dwc)
>>           return 0;
>>    }
>>
>> -static inline void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
>> -{
>> -}
>>    #endif /* !IS_ENABLED(CONFIG_USB_DWC3_HOST) */
>>
>>    #if IS_ENABLED(CONFIG_USB_DWC3_ULPI)
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 291bc549935b..a32c3a292353 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -4483,6 +4483,17 @@ static irqreturn_t dwc3_check_event_buf(struct
>> dwc3_event_buffer *evt)
>>                   return IRQ_HANDLED;
>>
>>           count = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
> If we properly cleanup event count in dwc3_event_buffers_cleanup() as
> noted above, then you don't need this condition below. You can remove
> the below check:
done in new version.
>
>> +
>> +       /*
>> +        * If the controller is halted, the event count is
>> stale/invalid. Ignore
>> +        * them. This happens if the interrupt assertion is from an
>> out-of-band
>> +        * resume notification.
>> +        */
>> +       if (!dwc->pullups_connected && count) {
>> +               dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), count);
>> +               return IRQ_HANDLED;
>> +       }
>> +
>>           count &= DWC3_GEVNTCOUNT_MASK;
>>           if (!count)
>>                   return IRQ_NONE;
>> @@ -4728,14 +4739,3 @@ int dwc3_gadget_resume(struct dwc3 *dwc)
>>
>>           return dwc3_gadget_soft_connect(dwc);
>>    }
>> -
>> -void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
>> -{
>> -       if (dwc->pending_events) {
>> -               dwc3_interrupt(dwc->irq_gadget, dwc->ev_buf);
>> -               dwc3_thread_interrupt(dwc->irq_gadget, dwc->ev_buf);
>> -               pm_runtime_put(dwc->dev);
>> -               dwc->pending_events = false;
>> -               enable_irq(dwc->irq_gadget);
>> -       }
>> -}

Hi Thinh,

Thanks for your suggestions. I posted a updated version in the below 
link. SO, kindly review the same.

https://lore.kernel.org/lkml/20240916224543.187-1-selvarasu.g@samsung.com/

Thanks,
Selva
> The rest looks fine.
>
> Thanks,
> Thinh

