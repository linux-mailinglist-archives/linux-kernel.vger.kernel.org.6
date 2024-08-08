Return-Path: <linux-kernel+bounces-278923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE7C94B6A8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A061F22B73
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 06:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6A8186E36;
	Thu,  8 Aug 2024 06:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Yr5FVoCj"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FA9186E26
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 06:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723098325; cv=none; b=tiy35aUPKNfGQ3qt4rTWSdjtwbFCwXfxR9pD2elLLkfTdKH6KW23E0L1xEhILsh+7Rzrn1W/JZyP3nvQzGLHt8zjO79omdV+znsQa7lUF6yo8mU6jkKmctUEAQoErvP8cSFHJnFUdikGeg2O6Glo46rI6p7qMryG/FZt07L4xD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723098325; c=relaxed/simple;
	bh=W+tszjI3M6S+GULUhH8fLVUn8500lSSQQyHj5ikEZqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=LBdqn0ANdJvMXPnjG2wI3b6TSZ/cousktccwDbZABqIw+sgK+OBGic3qNtyiIctvTZ8pKv7J4x/2yBpvaoe55MJaERwiuc3u6eW7tA2BymurznsLUmzz77OBhqzyJAl5IEaDIJB6oHEpP70M21pT0ntxJo7sNkTYCAY1C/sNK9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Yr5FVoCj; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240808062519epoutp033049d756f3d9c2b36582f80fd5af271b~prMrKoO5y1746917469epoutp03k
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 06:25:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240808062519epoutp033049d756f3d9c2b36582f80fd5af271b~prMrKoO5y1746917469epoutp03k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723098319;
	bh=UMN9JrxycNC1E+3cPzhJZJazPcBviKFH1En4O5UlpGc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Yr5FVoCjAy2+J9W4qduGw614mQxRwDMPXMjKqtrE853Y9Ohxk36joSyTCZYOiz+rp
	 qzewnsm+4V2091Qc+zXWNoLHihPPyqJb6AwdUYOY+EYkBJgGJ4/7QK8976bFQ+d2Mj
	 rdNby4pUml9SZMk4UsoPQk7D4jFz/GpEtBpeYjEU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240808062518epcas5p345496c15861e73961d552b1ea5a84925~prMqt-kyF0691106911epcas5p3m;
	Thu,  8 Aug 2024 06:25:18 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4WfcV53l2Xz4x9Q6; Thu,  8 Aug
	2024 06:25:17 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0F.5C.08855.DC464B66; Thu,  8 Aug 2024 15:25:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240808062329epcas5p173827dfef27a7c482f5c2ea574369548~prLElJtoc1595215952epcas5p1F;
	Thu,  8 Aug 2024 06:23:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240808062329epsmtrp1466977829d3a727f313b771d52e01340~prLEkZ1OO1689916899epsmtrp1G;
	Thu,  8 Aug 2024 06:23:29 +0000 (GMT)
X-AuditID: b6c32a44-15fb870000002297-32-66b464cd93a4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	01.1E.08964.16464B66; Thu,  8 Aug 2024 15:23:29 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240808062327epsmtip16200e94a294ecbfb5b06747b47c3ccc9~prLCg6wh02919829198epsmtip1R;
	Thu,  8 Aug 2024 06:23:26 +0000 (GMT)
Message-ID: <b48e7aba-6c54-431f-bbb5-3e5490df0c1a@samsung.com>
Date: Thu, 8 Aug 2024 11:53:25 +0530
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
In-Reply-To: <20240808011536.oid627ez4ppdfkhp@synopsys.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmpu7ZlC1pBhP2iFm8ubqK1eLOgmlM
	FqeWL2SyaF68ns1i0p6tLBZ3H/5gsbi8aw6bxaJlrcwWn47+Z7VY1TkHKPZ9J7PFpIOiFqsW
	HGB34PXYP3cNu0ffllWMHlv2f2b0+LxJLoAlKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTM
	wFDX0NLCXEkhLzE31VbJxSdA1y0zB+g8JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpB
	Sk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2Rlf/WtaC3yYVzX1f2BoY32p2MXJySAiYSBz5
	v4qti5GLQ0hgN6PE0pXboJxPjBIPP62Acr4xSpw6eooVpuXv8acsEIm9jBLPvvxlhXDeMkrM
	eraWEaSKV8BOYu+KD2AdLAIqErdnvGGCiAtKnJz5hAXEFhWQl7h/awY7iC0sECBxZckMsF4R
	AR2JAyfOM4EMZRboYJVY0N0G1swsIC5x68l8IJuDg03AUOLZCRsQk1PAWuLmtDKICnmJ5q2z
	mUFaJQTWckj8fXecGeJqF4n2/98ZIWxhiVfHt7BD2FISL/vboOxqidV3PrJBNLcwShx+8g0q
	YS/x+OgjZpBlzAKaEut36UOEZSWmnloHdRqfRO/vJ0wQcV6JHfNgbFWJU42X2SBsaYl7S65B
	Q9FDYtKT7SwTGBVnIQXLLCRfzkLyzyyEzQsYWVYxSqYWFOempyabFhjmpZbDYzw5P3cTIzj5
	arnsYLwx/5/eIUYmDsZDjBIczEoivM3hm9KEeFMSK6tSi/Lji0pzUosPMZoC42cis5Rocj4w
	/eeVxBuaWBqYmJmZmVgamxkqifO+bp2bIiSQnliSmp2aWpBaBNPHxMEp1cC07m7CwvMpV85o
	5E4/t+D8mpO//uWdnSB7/lCMMWfkU9X6Ts0VItsNVvyOzTXa093HxuZ82+ydzTSPN6+qWMu/
	FCpwX94SXK/4WqRobvPtlqfLju9m1GtytfoaOXXNOdOUkBnJd9aVpe76eeyMQOuu9ZWid3xf
	TTPvfvviyA6Jut27ysz8b8S3NWZvmxqa817qDt/G548VbX5GNtVcZF9Yv6fnyU/WfW033l96
	fz03UeI867z5Anw66+d2BbDpO8gmX+V/ky8u7vVegUOldU3TuYijRyWvH03/4RG5hsn2yDfV
	xk3Or889iW/jf/ryN9vRKct2n34p9nZiLIu6+UYDl19MX6fum3xlY6nBHUmbVUosxRmJhlrM
	RcWJAGaDZCpHBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZdlhJTjcxZUuawZZLLBZvrq5itbizYBqT
	xanlC5ksmhevZ7OYtGcri8Xdhz9YLC7vmsNmsWhZK7PFp6P/WS1Wdc4Bin3fyWwx6aCoxaoF
	B9gdeD32z13D7tG3ZRWjx5b9nxk9Pm+SC2CJ4rJJSc3JLEst0rdL4Mro6l/LWvDbpKK57wtb
	A+NbzS5GTg4JAROJv8efsnQxcnEICexmlLg4q40ZIiEt8XpWFyOELSyx8t9zdhBbSOA1o8S0
	iVYgNq+AncTeFR9YQWwWARWJ2zPeMEHEBSVOznzCAmKLCshL3L81A6xXWMBPYvqbE2AzRQR0
	JA6cOM8EsphZoIdV4svXj1BXLGWSeHr2OFgVs4C4xK0n84GqODjYBAwlnp2wATE5Bawlbk4r
	g6gwk+ja2gVVLS/RvHU28wRGoVlIzpiFZNAsJC2zkLQsYGRZxSiZWlCcm55bbFhgmJdarlec
	mFtcmpeul5yfu4kRHGVamjsYt6/6oHeIkYmD8RCjBAezkghvc/imNCHelMTKqtSi/Pii0pzU
	4kOM0hwsSuK84i96U4QE0hNLUrNTUwtSi2CyTBycUg1M/SXHLx36/u+se9B5nd7mOTIKwn6i
	h85KSyz6I3tIa311gIDzL4GSb5pu9/nbrk7ulAnqWW5xtaohtX/u1mW7RbcU6u2J1Hl8V9/o
	7cNDGSfWSX/Xurn5/YqIwD5nrYPFLd5iQRrVnuvZfU3q/XJzNr/zNNiy3+pN/CWODU9d6r5s
	37HB5ujG8ytOfov6P92qQCB7ruIztryfgb7ZNw/bTy1a5Noktczu+dns5m+6zC9DbzCsjbok
	3uQWsFjirp1fY5m8zsoitav9qfFvF/1Wne6ad+AhU93rhu9r97arq2zSDF7EvUm9bJVe9Np9
	jwomXNu5+IPWml1XVFWjN/303bF3qkmjwiwlvjntNdfZlFiKMxINtZiLihMBmAyPZSEDAAA=
X-CMS-MailID: 20240808062329epcas5p173827dfef27a7c482f5c2ea574369548
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


On 8/8/2024 6:45 AM, Thinh Nguyen wrote:
> On Wed, Aug 07, 2024, Selvarasu Ganesan wrote:
>> On 8/7/2024 6:08 AM, Thinh Nguyen wrote:
>>> On Fri, Jul 19, 2024, Selvarasu Ganesan wrote:
>>>> In certain scenarios, there is a chance that the CPU may not be
>>>> scheduled the bottom half of dwc3 interrupt. This is because the CPU
>>>> may hang up where any work queue lockup has happened for the same CPU
>>>> that is trying to schedule the dwc3 thread interrupt. In this scenario,
>>>> the USB can enter runtime suspend as the bus may idle for a longer time
>>>> , or user can reconnect the USB cable. Then, the dwc3 event interrupt
>>>> can be enabled when runtime resume is happening with regardless of the
>>>> previous event status. This can lead to a dwc3 IRQ storm due to the
>>>> return from the interrupt handler by checking only the evt->flags as
>>>> DWC3_EVENT_PENDING, where the same flag was set as DWC3_EVENT_PENDING
>>>> in previous work queue lockup.
>>>> Let's consider the following sequences in this scenario,
>>>>
>>>> Call trace of dwc3 IRQ after workqueue lockup scenario
>>>> ======================================================
>>>> IRQ #1:
>>>> ->dwc3_interrupt()
>>>>     ->dwc3_check_event_buf()
>>>>           ->if (evt->flags & DWC3_EVENT_PENDING)
>>>>                        return IRQ_HANDLED;
>>>>           ->evt->flags |= DWC3_EVENT_PENDING;
>>>>           ->/* Disable interrupt by setting DWC3_GEVNTSIZ_INTMASK  in
>>>>                                                           DWC3_GEVNTSIZ
>>>>           ->return IRQ_WAKE_THREAD; // No workqueue scheduled for dwc3
>>>>                                        thread_fu due to workqueue lockup
>>>>                                        even after return IRQ_WAKE_THREAD
>>>>                                        from top-half.
>>>>
>>>> Thread #2:
>>>> ->dwc3_runtime_resume()
>>>>    ->dwc3_resume_common()
>>>>      ->dwc3_gadget_resume()
>>>>         ->dwc3_gadget_soft_connect()
>>>>           ->dwc3_event_buffers_setup()
>>>>              ->/*Enable interrupt by clearing  DWC3_GEVNTSIZ_INTMASK in
>>>>                                                           DWC3_GEVNTSIZ*/
>>>>
>>>> Start IRQ Storming after enable dwc3 event in resume path
>>>> =========================================================
>>>> CPU0: IRQ
>>>> dwc3_interrupt()
>>>>    dwc3_check_event_buf()
>>>>           if (evt->flags & DWC3_EVENT_PENDING)
>>>>            return IRQ_HANDLED;
>>>>
>>>> CPU0: IRQ
>>>> dwc3_interrupt()
>>>>    dwc3_check_event_buf()
>>>>           if (evt->flags & DWC3_EVENT_PENDING)
>>>>            return IRQ_HANDLED;
>>>> ..
>>>> ..
>>>>
>>>> To fix this issue by avoiding enabling of the dwc3 event interrupt in
>>>> the runtime resume path if dwc3 event processing is in progress.
>>>>
>>>> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
>>>> ---
>>>>    drivers/usb/dwc3/core.c | 8 ++++++--
>>>>    1 file changed, 6 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>>> index cb82557678dd..610792a70805 100644
>>>> --- a/drivers/usb/dwc3/core.c
>>>> +++ b/drivers/usb/dwc3/core.c
>>>> @@ -549,8 +549,12 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
>>>>    			lower_32_bits(evt->dma));
>>>>    	dwc3_writel(dwc->regs, DWC3_GEVNTADRHI(0),
>>>>    			upper_32_bits(evt->dma));
>>>> -	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
>>>> -			DWC3_GEVNTSIZ_SIZE(evt->length));
>>>> +
>>>> +	/* Skip enable dwc3 event interrupt if event is processing in middle */
>>>> +	if (!(evt->flags & DWC3_EVENT_PENDING))
>>>> +		dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
>>>> +				DWC3_GEVNTSIZ_SIZE(evt->length));
>>>> +
>>>>    	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), 0);
>>>>    
>>>>    	return 0;
>>>> -- 
>>>> 2.17.1
>>>>
>>> We're not waking up from a hibernation. So after a soft-reset and
>>> resume, the events that weren't processed are stale. They should be
>>> processed prior to entering suspend or be discarded before resume.
>>>
>>> The synchronize_irq() during suspend() was not sufficient to prevent
>>> this? What are we missing here.
>>>
>>> Thanks,
>>> Thinh
>> I don’t think the triggering of interrupt would not be stopped even if
>> do soft reset. It's because of event count is may be valid .
> Ok. I think I see what you're referring to when you say "event is
> processing in the middle" now.
>
> What you want to check is probably this in dwc3_event_buffers_setup().
> Please confirm:
>
> if (dwc->pending_events)
> 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
> 			DWC3_GEVNTSIZ_INTMASK | DWC3_GEVNTSIZ_SIZE(evt->length));
> else
> 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0), DWC3_GEVNTSIZ_SIZE(evt->length));

Yes, we are expecting the same. But, we must verify the status of 
evt->flags, which will indicate whether the event is currently 
processing in middle or not. The below code is for the reference.

if (!(evt->flags & DWC3_EVENT_PENDING))
	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
			 DWC3_GEVNTSIZ_SIZE(evt->length));
else
	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
			DWC3_GEVNTSIZ_INTMASK | DWC3_GEVNTSIZ_SIZE(evt->length));

>> Let consider the scenarios where SW is not acknowledge the event count
>> after getting a interrupt with disable GEVNTSIZ_INTMASK =0. It will
>> triggering the spurious interrupts until enable GEVNTSIZ_INTMASK=1 or
>> acknowledge the event count by SW. This is happening here because of We
>> just return from interrupt handler by checking if evt->flags as
>> DWC3_EVENT_PENDING. Clearing of DWC3_EVENT_PENDING flag is done in
>> dwc3_thread_interrupt. In some scenario it's not happening due to cpu
>> hangup or work queue lockup.
> This can be mitigated by adjusting the imod_interval (interrupt
> moderation). Have you tried that?


Yes we tried to play around the changing of imod interval value but no 
improvements.
>
> Thanks,
> Thinh
>
>> The same issue was reported earlier and not derived actual root cause
>> from USB dwc3 driver point of view, and somehow we managing fix with our
>> vendor kernel by using kretprobe.
>>
>> To fix this issue, We have to reset the evt->flags or stop disable
>> GEVNTSIZ_INTMASK=0
>> https://urldefense.com/v3/__https://lore.kernel.org/linux-usb/20230102050831.105499-1-jh0801.jung@samsung.com/__;!!A4F2R9G_pg!b0Uj7NvYzWqrvNKOrkkXaY-g4Uaso-pW520AY2fBdlqmJeudUnmdsgpnL1YxAZaw2ydyg2M-XzhetbCraKxJa5C3NBQ$
>> https://urldefense.com/v3/__https://lore.kernel.org/linux-usb/1646630679-121585-1-git-send-email-jh0801.jung@samsung.com/__;!!A4F2R9G_pg!b0Uj7NvYzWqrvNKOrkkXaY-g4Uaso-pW520AY2fBdlqmJeudUnmdsgpnL1YxAZaw2ydyg2M-XzhetbCraKxJ2d2qDqA$
>>
> Thanks,
> Thinh

