Return-Path: <linux-kernel+bounces-278900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CD594B64F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C94EDB234F8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 05:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F70183CB8;
	Thu,  8 Aug 2024 05:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mcLFJ1lx"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AFC181BA8
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 05:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723095500; cv=none; b=MXfCxoq7MEj4cYYNbHrK8Rr2ERHlZcR/vNafAUGDaN8VE9BE3UHvAa9SF7vspLKPJ9sjIXMgZALxYXVfodI5QccKryB+L7KplKlaexl9VHzW37Jd2u/pVLkeuTUaf/62+E40I0QE5+21nczvn07MDybkQlHJmvL+WSKfO1rqg10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723095500; c=relaxed/simple;
	bh=p9cyZeY9KOohevR9OIet/pzjaDgh2nCSnnm0cNubx0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=YWCmzPWSx9IgM67352Q6sJ5ubLiBSpqAZh+pb2tpbrtKsPcllgKlNYy7cPbuSYTTY6XLENITkdSb20VIOiKJUZ1U3fIhUU+M3fHHsq2SCEcrJamFEMiUx32VrB3jzTHbKtGjTDOOJR+/n0YcdHv3Ln1rsk20ubQ3i4YWObaf93Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mcLFJ1lx; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240808053809epoutp0351fd1913bb3b1b27086808908eea8e3e~pqjfcbM4p0482904829epoutp03Z
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 05:38:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240808053809epoutp0351fd1913bb3b1b27086808908eea8e3e~pqjfcbM4p0482904829epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723095489;
	bh=5S578GGYZU+H5Rb4en08rZeFhHf2K/Ghuvq0eCFoZF4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=mcLFJ1lx79qZ7mwEdCSuaGpVLV82dvp3bGgWdUOrc0GPiP+LQS+3YwIotmQauV/Ce
	 OjRjGuq+75+6hAr7ug1T6qExfptirMTsSV7XzZdpriJHMPnafsStJ26RhG4ahJPB/D
	 4PZzhiYR3UGiuK7pNOwRKkbm/+RnJ3TTWUrZWcow=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240808053808epcas5p4d73ac44b75ab38df56b0d28bfe35fc77~pqjfFggYc1398313983epcas5p4K;
	Thu,  8 Aug 2024 05:38:08 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4WfbRg28tKz4x9Q0; Thu,  8 Aug
	2024 05:38:07 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FE.51.08855.FB954B66; Thu,  8 Aug 2024 14:38:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240808053534epcas5p20eee21ad0d03a31ac98b09579fb5bd3a~pqhPLS7-a2444924449epcas5p2_;
	Thu,  8 Aug 2024 05:35:34 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240808053534epsmtrp22dee105059f76e5b08aceeb60db5c050~pqhPKlPEN2266122661epsmtrp2V;
	Thu,  8 Aug 2024 05:35:34 +0000 (GMT)
X-AuditID: b6c32a44-15fb870000002297-74-66b459bfb678
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	ED.4A.19367.62954B66; Thu,  8 Aug 2024 14:35:34 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240808053532epsmtip1ae8bc1264196a2ed2307cb653833f55c~pqhNMLII10286902869epsmtip1I;
	Thu,  8 Aug 2024 05:35:32 +0000 (GMT)
Message-ID: <480d6e4e-0822-4f1c-8ffd-90b6d7e27de3@samsung.com>
Date: Thu, 8 Aug 2024 11:05:31 +0530
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
In-Reply-To: <20240808002106.uixkgga6lvyfdct3@synopsys.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmuu7+yC1pBgf2sVq8ubqK1eLOgmlM
	FqeWL2SyaF68ns1i0p6tLBZ3H/5gsbi8aw6bxaJlrcwWn47+Z7VY1TkHKPZ9J7PFpIOiFqsW
	HGB34PXYP3cNu0ffllWMHlv2f2b0+LxJLoAlKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTM
	wFDX0NLCXEkhLzE31VbJxSdA1y0zB+g8JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpB
	Sk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2xtLDM5kK2qQqZk79x97AeEOki5GDQ0LARGJ/
	h1wXIxeHkMBuRolLjyeyQjifGCWezZ3E3sXICeEsWCUKYoM0TDvdzgwR38ko8fp/CkTDW0aJ
	Uy8ugjXwCthJ3J+2G8xmEVCR6Lp0gQUiLihxcuYTMFtUQF7i/q0ZYDXCAjESD9ob2UBsEQEd
	iQMnzjOBDGUW6GCVWNDdxgSSYBYQl7j1ZD4TyNlsAoYSz07YgIQ5BawlrvzawwpRIi+x/e0c
	ZpBeCYGVHBIXbu5kh3jTReLP5BqIB4QlXh3fwg5hS0l8freXDcKullh95yMbRG8Lo8ThJ9+g
	iuwlHh99xAwyh1lAU2L9Ln2IsKzE1FProE7jk+j9/YQJIs4rsWMejK0qcarxMtR8aYl7S66x
	QtgeEiuXH2eZwKg4CylYZiH5chaSd2YhbF7AyLKKUTK1oDg3PTXZtMAwL7UcHt3J+bmbGMFp
	V8tlB+ON+f/0DjEycTAeYpTgYFYS4W0O35QmxJuSWFmVWpQfX1Sak1p8iNEUGD8TmaVEk/OB
	iT+vJN7QxNLAxMzMzMTS2MxQSZz3devcFCGB9MSS1OzU1ILUIpg+Jg5OqQamTaZFfdUXp5bv
	inI6F3U4hz1zT1Kyrg/vJIfdbkWzxPmvLUo8sPFsdK+c1eVTZUstVnaKG+x6sfzGqb8CnEm6
	sjzzjSZyf9my57acEKfhyX6mjI4Vn4T+GKVU6arIy7AvjGXunf6K/9CsjdJ/lwZckjo39Wwo
	T8R75YnHZjGdPJcmdmWKqs+ysAcCxzLXr93h+WarOLfvNsOd8WL/frcuD2GVcbIyzs3fuHMf
	/72uaReznmyd1L6BnU9zkvl+nWt3JyxZ07WmT6Xy7cuzV66qqp+cP/upU5hRge/i4+uuOT3y
	eye6wEFyW3klL1+8VBMTk0lQ4tLeT0YXpLOuf+24fV+af+1z8fkvNh52+W4jpsRSnJFoqMVc
	VJwIAAD/8zBEBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJTlctckuawf9f/BZvrq5itbizYBqT
	xanlC5ksmhevZ7OYtGcri8Xdhz9YLC7vmsNmsWhZK7PFp6P/WS1Wdc4Bin3fyWwx6aCoxaoF
	B9gdeD32z13D7tG3ZRWjx5b9nxk9Pm+SC2CJ4rJJSc3JLEst0rdL4MpYengmU0GbVMXMqf/Y
	GxhviHQxcnJICJhITDvdztzFyMUhJLCdUeLPrufMEAlpidezuhghbGGJlf+es0MUvWaUuLu8
	mQUkwStgJ3F/2m52EJtFQEWi69IFqLigxMmZT8BsUQF5ifu3ZoDVCAvESDxob2QDsUUEdCQO
	nDjPBDKUWaCHVeLL148sEBuWMkn87LzBClLFLCAucevJfKAqDg42AUOJZydsQMKcAtYSV37t
	gSoxk+jaCnEpM9Cy7W/nME9gFJqF5I5ZSCbNQtIyC0nLAkaWVYyiqQXFuem5yQWGesWJucWl
	eel6yfm5mxjBEaYVtINx2fq/eocYmTgYDzFKcDArifA2h29KE+JNSaysSi3Kjy8qzUktPsQo
	zcGiJM6rnNOZIiSQnliSmp2aWpBaBJNl4uCUamAKq2q/d+jtU5E7L7g8r2w18Rd1NNT7coQl
	xCnBTI67yOiK2bNrX9Sf5f48krjzuQpzWVz9Sdtp66xyr+m9Fu1L4lya4H2ya6rYNWdZH2/n
	RJfr/6w37ZnPMiFgtm0pw2kbg+SLb8wWcOocXRN3P3Hlh/0vdRc9Y+14n7W6Y/6rqgVhxe0m
	V05v+SDsvT/YyCB0yvN1tRX3I3/1xoa/Ek0tcZwQObuJ/2qAjcnm3vfRapt2cm6ffsehsUv9
	XOoMtrTFr/ruRO2+enyn3EWFpL2beLrU711a1LDDN8jgHrtbwNf1xhVKcUFzf/n8PbhSrraw
	cenmiE7ZPc/2/ucTsAufx5qzUuPwfb6YhpmhRg5KLMUZiYZazEXFiQA6y3T5HwMAAA==
X-CMS-MailID: 20240808053534epcas5p20eee21ad0d03a31ac98b09579fb5bd3a
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
	<0b985241-31a4-4d12-80be-4e211d21dfd6@samsung.com>
	<20240808002106.uixkgga6lvyfdct3@synopsys.com>


On 8/8/2024 5:51 AM, Thinh Nguyen wrote:
> On Wed, Aug 07, 2024, Selvarasu Ganesan wrote:
>> On 8/7/2024 5:44 AM, Thinh Nguyen wrote:
>>> On Mon, Jul 22, 2024, Selvarasu Ganesan wrote:
>>>> This commit addresses an issue where the USB core could access an
>>>> invalid event buffer address during runtime suspend, potentially causing
>>>> SMMU faults and other memory issues. The problem arises from the
>>>> following sequence.
>>>> 	1. In dwc3_gadget_suspend, there is a chance of a timeout when
>>>> 	moving the USB core to the halt state after clearing the
>>>> 	run/stop bit by software.
>>>> 	2. In dwc3_core_exit, the event buffer is cleared regardless of
>>>> 	the USB core's status, which may lead to an SMMU faults and
>>>> 	other memory issues. if the USB core tries to access the event
>>>> 	buffer address.
>>>>
>>>> To prevent this issue, this commit ensures that the event buffer address
>>>> is not cleared by software  when the USB core is active during runtime
>>>> suspend by checking its status before clearing the buffer address.
>>> What happen after adding this check? Can the device resume and function
>>> properly afterward? If not, do you know if a soft-reset will recover the
>>> issue?
>>>
>>> Thanks,
>>> Thinh
>> Yes, we can see the proper resume with this fix even if the USB IP core
>> not entered into halted during suspend.
>>
>> And we not tried soft reset as this fix is working fine.
>>
>> Anyway soft reset is part of resume sequence and it will reset or
>> recover the USB IP state machine.
>>
> Ok.
>
> Just wonder, what condition does the buffer access become invalid?

Its very hard to conclude the condition here as this issue is happening 
in some random scenario when do connect/disconnect USB cable 
continuously to Host PC with some time interval by using test scripts.

> While it makes sense that we should not cleanup the buffer while the
> controller is in run state, I don't think SMMU fault will always occur
> when (!(reg & DWC3_DSTS_DEVCTRLHLT)) right?

Yes are correct. We are not always getting SMMU fault.
>
>> Thanks,
>>
>> Selva
>>
>>>> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
>>>> ---
>>>>    drivers/usb/dwc3/core.c | 4 +++-
>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>>> index cb82557678dd..c7c1a253862e 100644
>>>> --- a/drivers/usb/dwc3/core.c
>>>> +++ b/drivers/usb/dwc3/core.c
>>>> @@ -559,8 +559,10 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
>>>>    void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
>>>>    {
>>>>    	struct dwc3_event_buffer	*evt;
>>>> +	u32				reg;
>>>>    
>>>> -	if (!dwc->ev_buf)
>>>> +	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
>>>> +	if (!dwc->ev_buf || !(reg & DWC3_DSTS_DEVCTRLHLT))
>>>>    		return;
> Can you separate the checks so we don't have to read register for all
> conditions?


Sure, will update in next version.

>
> if (!dwc->ev_buf)
> 	return;
>
> /*
>   * If dwc3_core_exit() fails, event buffer is not
>   * accessible for <XYZ> platforms.
>   */
> reg = dwc3_readl(dwc->regs, DWC3_DSTS);
> if (!(reg & DWC3_DSTS_DEVCTRLHLT))
> 	return;
>
> Thanks,
> Thinh
>
>>>>    
>>>>    	evt = dwc->ev_buf;
>>>> -- 
>>>> 2.17.1

