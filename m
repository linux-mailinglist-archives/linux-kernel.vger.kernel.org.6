Return-Path: <linux-kernel+bounces-277285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3965A949EEA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 06:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F7E1C216A0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 04:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40FC1917F2;
	Wed,  7 Aug 2024 04:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kYjO8dv9"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DA922334
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 04:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723006171; cv=none; b=NAdHboveA5JGvpuk6PeJVXQv+1gODNIa1361Pahthydy1RHNfuUpERgDC4E5E8Ij76ul+IHR4AsKsy8sZlw8odES1GbdAc54TWsprPflA33WRMgXmKIXLyXIOtkGYku2KnFY+PMqmNv8rQ35CRxEJTvZmKcS/AFLe64ulATXG4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723006171; c=relaxed/simple;
	bh=vTMGwzGllpI593MOBh2U/WE/MfImFLidc2MEQMU95Xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=gUqp1ajfOF/S2Vcf4X/6KFKImQlr++O4Qg2iXtAp/HCPY4vE9m1HYV4eKeomYGKBBQDKLEv++HHnX3cg9D3psXyT82xbMmmEIFZpEngqZcZOstGMNGMty35hSBXjI2mZkBree/nUtrpAtt9emvgw4E1astb6IECobw2zP+mGDGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kYjO8dv9; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240807044925epoutp02569de1cfbc254f3411dbae49fbfabeae~pWPqbkgrk1442614426epoutp02q
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 04:49:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240807044925epoutp02569de1cfbc254f3411dbae49fbfabeae~pWPqbkgrk1442614426epoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723006165;
	bh=L7tmfLCS2WLXes2uX9zlMzkZDW8XcCZBHwgW5D8IXU4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=kYjO8dv9tYqi2/7ZLqMM53QksUqEjefTZvy4LYlEwF+I/pN5zj6X9shth84Af8W1n
	 vp8XOgij6Cct5gRox5zBthzl+EOu6F/Bv8GW5IZUE5CV0MpN5c7bEnkdFD1fO+eK2W
	 kVGGQNH6kfYY7WAAGV6w+NufEIn8NAwOu9DPANk4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240807044925epcas5p2689c423ed2ce767c04388535190206fb~pWPp9HeBI1333813338epcas5p20;
	Wed,  7 Aug 2024 04:49:25 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4WdyPv0xwJz4x9QK; Wed,  7 Aug
	2024 04:49:23 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F2.E6.08855.DCCF2B66; Wed,  7 Aug 2024 13:49:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240807044659epcas5p1a34295c510f27fcef81e6b2856d72803~pWNiJ3nYk0564305643epcas5p1h;
	Wed,  7 Aug 2024 04:46:59 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240807044659epsmtrp2181001bd68b851a88ff859886762fa94~pWNiIwmc71759417594epsmtrp2h;
	Wed,  7 Aug 2024 04:46:59 +0000 (GMT)
X-AuditID: b6c32a44-107ff70000002297-a7-66b2fccdb2f4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	25.ED.08456.34CF2B66; Wed,  7 Aug 2024 13:46:59 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240807044657epsmtip2832d2d6321d83d84cb10a01c650f5bf4~pWNgIVl5P1159211592epsmtip2-;
	Wed,  7 Aug 2024 04:46:57 +0000 (GMT)
Message-ID: <0b985241-31a4-4d12-80be-4e211d21dfd6@samsung.com>
Date: Wed, 7 Aug 2024 10:16:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: core: Prevent USB core invalid event buffer
 address access
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
In-Reply-To: <20240807001408.fby2mjug3jym2lqs@synopsys.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmpu65P5vSDK5cZ7J4c3UVq8WdBdOY
	LE4tX8hk0bx4PZvFpD1bWSzuPvzBYnF51xw2i0XLWpktPh39z2qxqnMOUOz7TmaLSQdFLVYt
	OMDuwOuxf+4ado++LasYPbbs/8zo8XmTXABLVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZ
	gaGuoaWFuZJCXmJuqq2Si0+ArltmDtB5SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSC
	lJwCkwK94sTc4tK8dL281BIrQwMDI1OgwoTsjB//LrAUNAhWtGzcztLAeIC3i5GTQ0LARGJ5
	617GLkYuDiGB3YwSmz/fZoVwPjFKPHjyjAXC+cYocX7aHSaYlpkPT0El9jJKPP01BywhJPCW
	UaL3qAqIzStgJ/G9qZUFxGYRUJFY2fCCCSIuKHFy5hOwuKiAvMT9WzPYQWxhgRiJB+2NbCC2
	iICOxIET55lAFjALdLBKLOhuA2tmFhCXuPVkPpDNwcEmYCjx7IQNSJhTwFri+voGVogSeYnt
	b+cwg/RKCKzlkDg6eRojxNUuEp+arrBC2MISr45vYYewpSQ+v9vLBmFXS6y+85ENormFUeLw
	k29QRfYSj48+YgZZzCygKbF+lz5EWFZi6ql1ULfxSfT+fgINIV6JHfNgbFWJU42XoeZLS9xb
	cg3qBg+JlcuPs0xgVJyFFC6zkLw5C8k/sxA2L2BkWcUomVpQnJuemmxaYJiXWg6P8eT83E2M
	4OSr5bKD8cb8f3qHGJk4GA8xSnAwK4nwNodvShPiTUmsrEotyo8vKs1JLT7EaAqMoInMUqLJ
	+cD0n1cSb2hiaWBiZmZmYmlsZqgkzvu6dW6KkEB6YklqdmpqQWoRTB8TB6dUA5O08c7dEXvr
	Mlmf9e/4HmOUr2gp/9TEXT+rp8/Aa6HIWZ2yKa0bYlt2e1zg3L3Vce7vYkullHQZpneHu3e+
	Uq5kX7b/k9HkD1rOB513v/Plk6yWSVsR+Fv9+OKzqTt9M5SPvQxS3r7w05U1b5YZeWzx5ggQ
	Wd0vV3FS/lbHp3ORjxdujYzTuvhi1Y2FB6a6v1pqW+D2/1PJe/VdC6XNlztUL19ic9Zukr4m
	t085m1LO+qOrU28Y7l7O4RZ/b9HF5oka9Ruk1lSIPE07mWml/Ngq00os32OBWMjvhTfmmqct
	U1nV0/vnusobdc0Mu+m7LWI99IKeMj2x2L7eaePnKUxnLWdEt0f2TOoQffoyTl6JpTgj0VCL
	uag4EQDVSu1SRwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJXtf5z6Y0g9c7xSzeXF3FanFnwTQm
	i1PLFzJZNC9ez2Yxac9WFou7D3+wWFzeNYfNYtGyVmaLT0f/s1qs6pwDFPu+k9li0kFRi1UL
	DrA78Hrsn7uG3aNvyypGjy37PzN6fN4kF8ASxWWTkpqTWZZapG+XwJXx498FloIGwYqWjdtZ
	GhgP8HYxcnJICJhIzHx4igXEFhLYzShx+HksRFxa4vWsLkYIW1hi5b/n7F2MXEA1rxklFrb3
	MoEkeAXsJL43tYI1swioSKxseAEVF5Q4OfMJWFxUQF7i/q0Z7CC2sECMxIP2RjYQW0RAR+LA
	ifNMIEOZBXpYJb58/cgCsWE/o8TDJZPAupkFxCVuPZkPVMXBwSZgKPHshA1ImFPAWuL6+gZW
	iBIzia6tEJcyAy3b/nYO8wRGoVlI7piFZNIsJC2zkLQsYGRZxSiZWlCcm55bbFhglJdarlec
	mFtcmpeul5yfu4kRHGdaWjsY96z6oHeIkYmD8RCjBAezkghvc/imNCHelMTKqtSi/Pii0pzU
	4kOM0hwsSuK83173pggJpCeWpGanphakFsFkmTg4pRqYTDjTeCWFpPkmbomc1B6z/ejrb9Ii
	s1McrhqJOyTeq25sFDu9ZMXZDOE8tQWPpsY9nX1ZsdpRe2vG5vnepa8+3Fd+puyVeTBn2hO2
	Z3NkeZl+KDoHXuLkaJ2T9H6nLc99h0sLTvkd6E15ob5ly7pufbPdKowvFdOcNx29JnDNS0TP
	f1bVh4oSnjSZt41LrGKtf8U++PLxYaj86oe7O6xOPje1mXf34ZWJRjE181UXM1/t/r1HVi6e
	Rzq0tEV6WUJ7WJfkk+dPHa7JfFHkObr1f0pP1eKOVfWpS52W8zay7/xzqPbyU/c13xoWiFu+
	0HParxoVZnN0uRLrlP21s+KPnCnh7T+78uIs+2b2jjtmSizFGYmGWsxFxYkA11E9uyIDAAA=
X-CMS-MailID: 20240807044659epcas5p1a34295c510f27fcef81e6b2856d72803
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240722145728epcas5p38f8ecf57278b4a89c0b09430518c8599
References: <CGME20240722145728epcas5p38f8ecf57278b4a89c0b09430518c8599@epcas5p3.samsung.com>
	<20240722145617.537-1-selvarasu.g@samsung.com>
	<20240807001408.fby2mjug3jym2lqs@synopsys.com>


On 8/7/2024 5:44 AM, Thinh Nguyen wrote:
> On Mon, Jul 22, 2024, Selvarasu Ganesan wrote:
>> This commit addresses an issue where the USB core could access an
>> invalid event buffer address during runtime suspend, potentially causing
>> SMMU faults and other memory issues. The problem arises from the
>> following sequence.
>> 	1. In dwc3_gadget_suspend, there is a chance of a timeout when
>> 	moving the USB core to the halt state after clearing the
>> 	run/stop bit by software.
>> 	2. In dwc3_core_exit, the event buffer is cleared regardless of
>> 	the USB core's status, which may lead to an SMMU faults and
>> 	other memory issues. if the USB core tries to access the event
>> 	buffer address.
>>
>> To prevent this issue, this commit ensures that the event buffer address
>> is not cleared by software  when the USB core is active during runtime
>> suspend by checking its status before clearing the buffer address.
> What happen after adding this check? Can the device resume and function
> properly afterward? If not, do you know if a soft-reset will recover the
> issue?
>
> Thanks,
> Thinh

Yes, we can see the proper resume with this fix even if the USB IP core 
not entered into halted during suspend.

And we not tried soft reset as this fix is working fine.

Anyway soft reset is part of resume sequence and it will reset or 
recover the USB IP state machine.


Thanks,

Selva

>
>> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
>> ---
>>   drivers/usb/dwc3/core.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index cb82557678dd..c7c1a253862e 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -559,8 +559,10 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
>>   void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
>>   {
>>   	struct dwc3_event_buffer	*evt;
>> +	u32				reg;
>>   
>> -	if (!dwc->ev_buf)
>> +	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
>> +	if (!dwc->ev_buf || !(reg & DWC3_DSTS_DEVCTRLHLT))
>>   		return;
>>   
>>   	evt = dwc->ev_buf;
>> -- 
>> 2.17.1

