Return-Path: <linux-kernel+bounces-277375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3D7949FD4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 392B81C2256F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 06:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C340D4AEE6;
	Wed,  7 Aug 2024 06:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="X5lnk/+x"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E05F1AE053
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 06:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723012276; cv=none; b=cEWp6J6PLSwltfGnXdkK+4uI10lQaPnVTlYTFCw2gq+g6QN4OWOBYfm/VsNranzm8ccDLx60ZvKXwSCBpfPIeA7+hQFP0PHmhD97kRhux8vPUFroI/SDWEgDXlHVuCSqjH/pm1k1QiHZXq/c+uFf0z4YtxkLnN77yqQbLx+iDiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723012276; c=relaxed/simple;
	bh=S+lqcxp/TLkYYSF+8pmWifOBXbfRfybPzjD0OhqAiQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=K5BkTPwdP3H8s2jL4QOf4wiCHs/HaMnMVfa+a0wpd1bk0HuFab2VTuYympUjpnJtNfGlQVkXwIET+DvnUZNYtGM8RL65NRute9TQG1u7wwqPJ4KGzQgUOlcPamzt71sQg0l4ubGd5T7ARhx15bhKYRhQNv1PE/Xhuf2JsDbDGqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=X5lnk/+x; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240807063110epoutp014112ea638c99b87afc3d9b0876ef2b8e~pXogQo0RD1508515085epoutp01c
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 06:31:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240807063110epoutp014112ea638c99b87afc3d9b0876ef2b8e~pXogQo0RD1508515085epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723012270;
	bh=K1HzqGY3pX/2lGXokj+MO8jq16e2RSo1fF7SOq9N4XE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=X5lnk/+x5Qvb8bCYgYZP2CzYEaOsDKG/xRnRtuEBFbgZdUcWElWRPWyFWTvGFu5GI
	 GKJcvHGteD1FETboasvNpka6Cp12cwjOs9xkTVf7HGKTCYa93V7J+Sh36RAJEg6REB
	 /4DzJFcKnQcskmQQZHsuL2m/IO9CjDLNB71/oW5M=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240807063110epcas5p412c14312df1b7f260f1b91a9b2712679~pXofxED7D0475204752epcas5p4C;
	Wed,  7 Aug 2024 06:31:10 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Wf0gK1Lgrz4x9Pp; Wed,  7 Aug
	2024 06:31:09 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	31.AD.08855.DA413B66; Wed,  7 Aug 2024 15:31:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240807062015epcas5p3309ab63eef653eabd72a9ea6afaa0d5e~pXe909NVB1787917879epcas5p35;
	Wed,  7 Aug 2024 06:20:15 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240807062015epsmtrp1f5c00e3e24f0b8ded272b5818a4d7fd1~pXe9z-Izb0489804898epsmtrp1a;
	Wed,  7 Aug 2024 06:20:15 +0000 (GMT)
X-AuditID: b6c32a44-15fb870000002297-e3-66b314ad575c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	3F.09.19367.F1213B66; Wed,  7 Aug 2024 15:20:15 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240807062013epsmtip25bcd662953baa5f93467049014ef531c~pXe78Kv_Y0401604016epsmtip2d;
	Wed,  7 Aug 2024 06:20:13 +0000 (GMT)
Message-ID: <b6baeb45-1684-4fcb-8c71-392cb4788c85@samsung.com>
Date: Wed, 7 Aug 2024 11:50:12 +0530
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
In-Reply-To: <20240807003806.5owtgwgw2lczg4u5@synopsys.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmuu5akc1pBi/7WSzeXF3FanFnwTQm
	i1PLFzJZNC9ez2Yxac9WFou7D3+wWFzeNYfNYtGyVmaLT0f/s1qs6pwDFPu+k9li0kFRi1UL
	DrA78Hrsn7uG3aNvyypGjy37PzN6fN4kF8ASlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pm
	YKhraGlhrqSQl5ibaqvk4hOg65aZA3SekkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUg
	JafApECvODG3uDQvXS8vtcTK0MDAyBSoMCE748KmLUwFx9UrVl66zNbAuEGui5GTQ0LARGLp
	hO/sXYxcHEICuxklpj3+xgLhfGKU6Pk8hx3OubxmN2MXIwdYy9ppWhDxnYwSf0/PYIJw3jJK
	zGu6xgxSxCtgJ3FhkwjIChYBFYn3vy4yg9i8AoISJ2c+YQGxRQXkJe7fmsEOYgsLBEhcWTKD
	EcQWEdCROHDiPNhMZoEOVokF3W1MIAlmAXGJW0/mM4HMZxMwlHh2wgYkzClgLbH+aBMLRIm8
	RPPW2cwgvRICWzgkLr5YyQLxp4vEhR9X2CBsYYlXx7ewQ9hSEi/726DsaonVdz6yQTS3MEoc
	fvINKmEv8fjoI7DHmAU0Jdbv0ocIy0pMPbUO6jY+id7fT5gg4rwSO+bB2KoSpxovQ+2Vlri3
	5BorhO0hMenJdpYJjIqzkMJlFpI3ZyH5ZxbC5gWMLKsYJVMLinPTU5NNCwzzUsvhEZ6cn7uJ
	EZx6tVx2MN6Y/0/vECMTB+MhRgkOZiUR3ubwTWlCvCmJlVWpRfnxRaU5qcWHGE2BETSRWUo0
	OR+Y/PNK4g1NLA1MzMzMTCyNzQyVxHlft85NERJITyxJzU5NLUgtgulj4uCUamBSC8vbE3Xu
	6o1rWfInG9T7jj+z/DBvfkfS2t5plwUkt2X0rHyeOve/iKTaP35nl+w399LXb19bOSfASGRR
	4fOYaU+ioq6vsX//6rzGpMCLep6T+/ZMyuKWT+ldl2yZJpvM/2P+WumON5ckfY41zorJzGFU
	aT2s+/fU3nWW6zbO229zImL254dfklwe/560I8RnymPVSq4NaxWe7uteWxSxj/VkgNsWrYcm
	RWq3fjielpwdLzjzzrXmbonTIlWxLF7F9xL+alz46bhWzUic1Tf6cXJTE8/SorzpK174FJ74
	wPDP/+h8E7eH7sUcjLZy7tU8gbktvyUuuO9ia0ndHZ1zst/286KMo1kqHfma98uUWIozEg21
	mIuKEwEpGHSKRgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJXldeaHOawfzJYhZvrq5itbizYBqT
	xanlC5ksmhevZ7OYtGcri8Xdhz9YLC7vmsNmsWhZK7PFp6P/WS1Wdc4Bin3fyWwx6aCoxaoF
	B9gdeD32z13D7tG3ZRWjx5b9nxk9Pm+SC2CJ4rJJSc3JLEst0rdL4Mq4sGkLU8Fx9YqVly6z
	NTBukOti5OCQEDCRWDtNq4uRi0NIYDujRF/jC/YuRk6guLTE61ldjBC2sMTKf8/ZIYpeM0os
	m7WQEaSZV8BO4sImEZAaFgEVife/LjKD2LwCghInZz5hAbFFBeQl7t+aATZTWMBPYvqbE2Az
	RQR0JA6cOM8EMpNZoIdV4svXjywQC/YzSmybOh2sg1lAXOLWk/lMIMvYBAwlnp2wAQlzClhL
	rD/axAJRYibRtRXiUGagZc1bZzNPYBSaheSOWUgmzULSMgtJywJGllWMoqkFxbnpuckFhnrF
	ibnFpXnpesn5uZsYwdGlFbSDcdn6v3qHGJk4GA8xSnAwK4nwNodvShPiTUmsrEotyo8vKs1J
	LT7EKM3BoiTOq5zTmSIkkJ5YkpqdmlqQWgSTZeLglGpg6vh/ur7p+f4CO8/nLxI++gcvLjCf
	vPnPwvbIE057khddCHrhveVOZbUiz/zu2qvGu37Iry+W9HMz0jl+8VhL03OmSbseeHSU799+
	vXNjQ7fuPI3bU5Z8YXsw6RPXF6dX6StWyH35+r7Zkctj79UKteoYu2tPc2yqv++bnPZp/vfW
	XPMbV56telI0+Yd2WcstXr6VnSf4gjninZ24TsrvEq93jXa9+nD92fJn2ekJ140i/m7e82+x
	3hd9gdsRwhb7o9T4VyatD+LqenvA8vQRkWnbF1su1bS5wf7jpfrxGRvWtKwUlLwrYydf9lpo
	/6H7d50iDwQY/OitzDrw//zlU4czT58sep/8dqHslzLtM7uVWIozEg21mIuKEwEaLD1IHQMA
	AA==
X-CMS-MailID: 20240807062015epcas5p3309ab63eef653eabd72a9ea6afaa0d5e
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


On 8/7/2024 6:08 AM, Thinh Nguyen wrote:
> On Fri, Jul 19, 2024, Selvarasu Ganesan wrote:
>> In certain scenarios, there is a chance that the CPU may not be
>> scheduled the bottom half of dwc3 interrupt. This is because the CPU
>> may hang up where any work queue lockup has happened for the same CPU
>> that is trying to schedule the dwc3 thread interrupt. In this scenario,
>> the USB can enter runtime suspend as the bus may idle for a longer time
>> , or user can reconnect the USB cable. Then, the dwc3 event interrupt
>> can be enabled when runtime resume is happening with regardless of the
>> previous event status. This can lead to a dwc3 IRQ storm due to the
>> return from the interrupt handler by checking only the evt->flags as
>> DWC3_EVENT_PENDING, where the same flag was set as DWC3_EVENT_PENDING
>> in previous work queue lockup.
>> Let's consider the following sequences in this scenario,
>>
>> Call trace of dwc3 IRQ after workqueue lockup scenario
>> ======================================================
>> IRQ #1:
>> ->dwc3_interrupt()
>>    ->dwc3_check_event_buf()
>>          ->if (evt->flags & DWC3_EVENT_PENDING)
>>                       return IRQ_HANDLED;
>>          ->evt->flags |= DWC3_EVENT_PENDING;
>>          ->/* Disable interrupt by setting DWC3_GEVNTSIZ_INTMASK  in
>>                                                          DWC3_GEVNTSIZ
>>          ->return IRQ_WAKE_THREAD; // No workqueue scheduled for dwc3
>>                                       thread_fu due to workqueue lockup
>>                                       even after return IRQ_WAKE_THREAD
>>                                       from top-half.
>>
>> Thread #2:
>> ->dwc3_runtime_resume()
>>   ->dwc3_resume_common()
>>     ->dwc3_gadget_resume()
>>        ->dwc3_gadget_soft_connect()
>>          ->dwc3_event_buffers_setup()
>>             ->/*Enable interrupt by clearing  DWC3_GEVNTSIZ_INTMASK in
>>                                                          DWC3_GEVNTSIZ*/
>>
>> Start IRQ Storming after enable dwc3 event in resume path
>> =========================================================
>> CPU0: IRQ
>> dwc3_interrupt()
>>   dwc3_check_event_buf()
>>          if (evt->flags & DWC3_EVENT_PENDING)
>>           return IRQ_HANDLED;
>>
>> CPU0: IRQ
>> dwc3_interrupt()
>>   dwc3_check_event_buf()
>>          if (evt->flags & DWC3_EVENT_PENDING)
>>           return IRQ_HANDLED;
>> ..
>> ..
>>
>> To fix this issue by avoiding enabling of the dwc3 event interrupt in
>> the runtime resume path if dwc3 event processing is in progress.
>>
>> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
>> ---
>>   drivers/usb/dwc3/core.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index cb82557678dd..610792a70805 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -549,8 +549,12 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
>>   			lower_32_bits(evt->dma));
>>   	dwc3_writel(dwc->regs, DWC3_GEVNTADRHI(0),
>>   			upper_32_bits(evt->dma));
>> -	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
>> -			DWC3_GEVNTSIZ_SIZE(evt->length));
>> +
>> +	/* Skip enable dwc3 event interrupt if event is processing in middle */
>> +	if (!(evt->flags & DWC3_EVENT_PENDING))
>> +		dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
>> +				DWC3_GEVNTSIZ_SIZE(evt->length));
>> +
>>   	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), 0);
>>   
>>   	return 0;
>> -- 
>> 2.17.1
>>
> We're not waking up from a hibernation. So after a soft-reset and
> resume, the events that weren't processed are stale. They should be
> processed prior to entering suspend or be discarded before resume.
>
> The synchronize_irq() during suspend() was not sufficient to prevent
> this? What are we missing here.
>
> Thanks,
> Thinh
I don’t think the triggering of interrupt would not be stopped even if 
do soft reset. It's because of event count is may be valid .
Let consider the scenarios where SW is not acknowledge the event count 
after getting a interrupt with disable GEVNTSIZ_INTMASK =0. It will 
triggering the spurious interrupts until enable GEVNTSIZ_INTMASK=1 or 
acknowledge the event count by SW. This is happening here because of We 
just return from interrupt handler by checking if evt->flags as 
DWC3_EVENT_PENDING. Clearing of DWC3_EVENT_PENDING flag is done in 
dwc3_thread_interrupt. In some scenario it's not happening due to cpu 
hangup or work queue lockup.

The same issue was reported earlier and not derived actual root cause 
from USB dwc3 driver point of view, and somehow we managing fix with our 
vendor kernel by using kretprobe.

To fix this issue, We have to reset the evt->flags or stop disable  
GEVNTSIZ_INTMASK=0
https://lore.kernel.org/linux-usb/20230102050831.105499-1-jh0801.jung@samsung.com/
https://lore.kernel.org/linux-usb/1646630679-121585-1-git-send-email-jh0801.jung@samsung.com/

Thanks
Selva

