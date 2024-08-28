Return-Path: <linux-kernel+bounces-305109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2939629A6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA95282D0F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A665E188CC8;
	Wed, 28 Aug 2024 14:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ACyMqVz3"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D67113BAC3
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853852; cv=none; b=T3xp9imOqf/2jBWJ2cO0TLyWTz9bGIrHMGC0jHeDewkexDyGdwpnYYFpLOFTayHPlkKho3ZZObY5L0cWz7vhUxOCLiTFxqOz+dg/VR+l7iT5c5LFynekQblsElMt46gLjAxE8mmZqkC1B4MHgC1sZDmWtZ5mXuXaFH02Vaxga1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853852; c=relaxed/simple;
	bh=625nPABDAsbYpcGVQ/1W/YAg0vPcnflJvc/EZPD8tLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=goP1xVUhGkZiSM2f3LEqTKzuku4nzH1usJaSYMYNqfFkXovIoCHWjRPuORCOdfuj/hqMz9mg639LEKmv7ZB04VAuNsPU8Kwqq+a9XhPFYAtUYwvAbxoiKMRDYw1B0BoNK3yE7y6IggRtUmjxCN0warubHdqzJeusLma/3ZKfPuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ACyMqVz3; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240828140408epoutp02b5b79a76b60b92f1eb1a3c7f1e69c2dd~v6W_vgMWt1546615466epoutp02X
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:04:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240828140408epoutp02b5b79a76b60b92f1eb1a3c7f1e69c2dd~v6W_vgMWt1546615466epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724853848;
	bh=UBIHwfOH5u/IlQ+B1K3l4RbT3dJKmyIOdW9JVzVTArg=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ACyMqVz3zjrkd442+0FHj/u2vSCRwEJqL+scso2RxHWKb0gnUeM792cPkhS+Ypqvm
	 Gh2+ihzGpAThpuSJoAzeTgRTKwRAUZ2F94V96Fvk7JMJV6TEki2hcq2UuSakHO+L+W
	 KrsDOIJmTjDDiZQEGKRL6NepucfI+GsgVDoT41pY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240828140407epcas5p2e191364bc7e5cd8fbed9d1103525a6ea~v6W_LrXXO0383003830epcas5p2M;
	Wed, 28 Aug 2024 14:04:07 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Wv5kG15lnz4x9Pr; Wed, 28 Aug
	2024 14:04:06 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2D.BE.09743.55E2FC66; Wed, 28 Aug 2024 23:04:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240828140055epcas5p1f69e5e9d00db08c1e28f184f4c250fc7~v6UK8acPH1574815748epcas5p1F;
	Wed, 28 Aug 2024 14:00:55 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240828140055epsmtrp1b918d7d2d3b147b64487b211f5ecf469~v6UK7j_kL0452404524epsmtrp1S;
	Wed, 28 Aug 2024 14:00:55 +0000 (GMT)
X-AuditID: b6c32a4a-14fff7000000260f-dc-66cf2e5574d8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	95.CF.19367.69D2FC66; Wed, 28 Aug 2024 23:00:54 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240828140051epsmtip17d187f7e56113552fe0b036c01e1dfa1~v6UHQkWjw2041720417epsmtip1S;
	Wed, 28 Aug 2024 14:00:51 +0000 (GMT)
Message-ID: <4379d7fb-9f80-429b-a81a-12760a527cae@samsung.com>
Date: Wed, 28 Aug 2024 19:30:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: udc: Add null pointer check for udc in
 gadget_match_driver
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stern@rowland.harvard.edu, royluo@google.com, paul@crapouillou.net,
	elder@kernel.org, yuanlinyu@hihonor.com, quic_kriskura@quicinc.com,
	crwulff@gmail.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	akash.m5@samsung.com, rc93.raju@samsung.com, taehyun.cho@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com, shijie.cai@samsung.com,
	stable <stable@kernel.org>
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <2024082801-dissuade-starlight-e5ad@gregkh>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEJsWRmVeSWpSXmKPExsWy7bCmpm6Y3vk0g6vzGC3eXF3FajH36G42
	izsLpjFZ3Ds6m83i1PKFTBbNi9ezWUzas5XF4u7DHywWl3fNYbNYtKyV2eLT0f+sFv2LL7FY
	fH/9kdViVeccFov2hlNsFpe/7wTKnr/AZjHhN5CYdFDU4uunS4wOIh6rL7WzeeycdZfdY8Gm
	Uo85vyYze2xa1cnmsX/uGnaPiXvqPGbf/cHo0bdlFaPH501yAVxR2TYZqYkpqUUKqXnJ+SmZ
	eem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QN8pKZQl5pQChQISi4uV9O1sivJL
	S1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7IzLu3ZyVZwU61i2Ue3BsYT
	Cl2MnBwSAiYSbxo2M3YxcnEICexmlGje2scG4XxilNjTfpQRpArM6bgWBtPxfl0bC0TRTkaJ
	S+cnsEI4bxkl/u1cANbBK2An0XdvCjOIzSKgKrG7/R8TRFxQ4uTMJywgtqiAvMT9WzPYQWxh
	gTiJ3vNTwepFBDQkXh69BbaBWeAis8Tc509YQRLMAuISt57MBxrEwcEmYCjx7IQNSJhTwEJi
	ze9WNogSeaAXZjOD9EoINHNKfPvzlhHibBeJ9+u3MEPYwhKvjm9hh7ClJF72t0HZ1RKr73xk
	g2huYZQ4/OQbVMJe4vHRR8wgi5kFNCXW79KHCMtKTD21jgliMZ9E7+8nTBBxXokd82BsVYlT
	jZfZIGxpiXtLrrFC2B4SV1uvM09gVJyFFC6zkLw5C8k/sxA2L2BkWcUomVpQnJueWmxaYJSX
	Wg6P8OT83E2M4MSv5bWD8eGDD3qHGJk4GA8xSnAwK4nwnjh+Nk2INyWxsiq1KD++qDQntfgQ
	oykwgiYyS4km5wNzT15JvKGJpYGJmZmZiaWxmaGSOO/r1rkpQgLpiSWp2ampBalFMH1MHJxS
	DUx7AwOkVfwOfN13Rsq7YKvieY705zd8cl3P32f+KCYy6fWtr/nPdT2EnqR8UjypFLAqK056
	/awdvkezb/xz5vb17Fs9S+Pt5bYdjEtil7kdMDnE9m66Z1Z3zZnXTpO3OfHZ8BQtOXBdcitX
	jeXvg9bRtze4Z8x313ryYUafdEEw9xzJcpvY5BoFtz72xcr1XebFu/y/Rs1S5OFP+bRzQROT
	tKKUrnrTuXWvqkP6C1Kytdhn8fJd9dd8srj8fdV6pW9Fs2beVItdoVsiydV1I/f/dWnltA3q
	236djVmulHN4buFFjmbeya+eqj9b/HDu5pTMA4p9/hmTP6r2f3wo6sa5O+ZDq8z7HWGTPghv
	KFJiKc5INNRiLipOBAB32lP/hQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsWy7bCSnO403fNpBo8nWVm8ubqK1WLu0d1s
	FncWTGOyuHd0NpvFqeULmSyaF69ns5i0ZyuLxd2HP1gsLu+aw2axaFkrs8Wno/9ZLfoXX2Kx
	+P76I6vFqs45LBbtDafYLC5/3wmUPX+BzWLCbyAx6aCoxddPlxgdRDxWX2pn89g56y67x4JN
	pR5zfk1m9ti0qpPNY//cNeweE/fUecy++4PRo2/LKkaPz5vkAriiuGxSUnMyy1KL9O0SuDIu
	7dnJVnBTrWLZR7cGxhMKXYycHBICJhLv17WxdDFycQgJbGeUaFg0kRUiIS3xelYXI4QtLLHy
	33N2iKLXjBInTreBFfEK2En03ZvCDGKzCKhK7G7/xwQRF5Q4OfMJC4gtKiAvcf/WDHYQW1gg
	TqL3/FSwehEBDYmXR2+BbWYWuMgsMenZSiaIDXsZJe7svwrWwSwgLnHryXygBAcHm4ChxLMT
	NiBhTgELiTW/W9kgSswkurZCXMoMtKx562zmCYxCs5DcMQvJpFlIWmYhaVnAyLKKUTS1oDg3
	PTe5wFCvODG3uDQvXS85P3cTIzi6tYJ2MC5b/1fvECMTB+MhRgkOZiUR3hPHz6YJ8aYkVlal
	FuXHF5XmpBYfYpTmYFES51XO6UwREkhPLEnNTk0tSC2CyTJxcEo1MElMy9tnKrmAO1ArUtFp
	2rKUUqWk0N/L7VoP3G+ZzRbSkbSv8XRI+jt+7ssq7dO0uHqz5d4Kr6ot52o94n9np+29K/wP
	fBT3nll83PPwqWntvXNtn71c8Nb8w7kpgTMVZi5SkvH3/jq9TUnPYtVdc6X8uTKhd09OVN7T
	cPz8JFXDE6dunHHckRygtjTP3IYxXvTK6jXSWrPMORKtpz/lzkqb+Nq04J9FfZ5Eftz30MyT
	mzaeFLqYrfv/XGH2RteqrlxDFs5ayVXJDtLHxSavP62vNOmVRM4Kw4iMiXYpGo/vlDxImfhs
	7boXH4RXCh3+/vZ3eMseEaNNX44z+HorzXqUesIz4HUTm5xCsFbBbiWW4oxEQy3mouJEAAkU
	O69dAwAA
X-CMS-MailID: 20240828140055epcas5p1f69e5e9d00db08c1e28f184f4c250fc7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240828070538epcas5p2ce9b001afd4588139070d01f0fb2ac37
References: <CGME20240828070538epcas5p2ce9b001afd4588139070d01f0fb2ac37@epcas5p2.samsung.com>
	<20240828070507.2047-1-selvarasu.g@samsung.com>
	<2024082801-dissuade-starlight-e5ad@gregkh>


On 8/28/2024 3:09 PM, Greg KH wrote:
> On Wed, Aug 28, 2024 at 12:35:04PM +0530, Selvarasu Ganesan wrote:
>> This commit adds a null pointer check for udc in gadget_match_driver to
>> prevent the below potential dangling pointer access. The issue arises
>> due to continuous USB role switch and simultaneous UDC write operations
>> performed by init.rc from user space through configfs.  In these
>> scenarios, there was a possibility of usb_udc_release being done before
>> gadget_match_driver.
>>
>> [27635.233849]  BUG: KASAN: invalid-access in gadget_match_driver+0x40/0x94
>> [27635.233871]  Read of size 8 at addr d7ffff8837ead080 by task init/1
>> [27635.233881]  Pointer tag: [d7], memory tag: [fe]
>> [27635.233888]
>> [27635.233917]  Call trace:
>> [27635.233923]   dump_backtrace+0xec/0x10c
>> [27635.233935]   show_stack+0x18/0x24
>> [27635.233944]   dump_stack_lvl+0x50/0x6c
>> [27635.233958]   print_report+0x150/0x6b4
>> [27635.233977]   kasan_report+0xe8/0x148
>> [27635.233985]   __hwasan_load8_noabort+0x88/0x98
>> [27635.233995]   gadget_match_driver+0x40/0x94
>> [27635.234005]   __driver_attach+0x60/0x304
>> [27635.234018]   bus_for_each_dev+0x154/0x1b4
>> [27635.234027]   driver_attach+0x34/0x48
>> [27635.234036]   bus_add_driver+0x1ec/0x310
>> [27635.234045]   driver_register+0xc8/0x1b4
>> [27635.234055]   usb_gadget_register_driver_owner+0x7c/0x140
>> [27635.234066]   gadget_dev_desc_UDC_store+0x148/0x19c
>> [27635.234075]   configfs_write_iter+0x180/0x1e0
>> [27635.234087]   vfs_write+0x298/0x3e4
>> [27635.234105]   ksys_write+0x88/0x100
>> [27635.234115]   __arm64_sys_write+0x44/0x5c
>> [27635.234126]   invoke_syscall+0x6c/0x17c
>> [27635.234143]   el0_svc_common+0xf8/0x138
>> [27635.234154]   do_el0_svc+0x30/0x40
>> [27635.234164]   el0_svc+0x38/0x68
>> [27635.234174]   el0t_64_sync_handler+0x68/0xbc
>> [27635.234184]   el0t_64_sync+0x19c/0x1a0
>>
>> Fixes: fc274c1e9973 ("USB: gadget: Add a new bus for gadgets")
>> Cc: stable <stable@kernel.org>
>> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
>> ---
>>   drivers/usb/gadget/udc/core.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
>> index cf6478f97f4a..77dc0f28ff01 100644
>> --- a/drivers/usb/gadget/udc/core.c
>> +++ b/drivers/usb/gadget/udc/core.c
>> @@ -1338,6 +1338,7 @@ static void usb_udc_release(struct device *dev)
>>   	udc = container_of(dev, struct usb_udc, dev);
>>   	dev_dbg(dev, "releasing '%s'\n", dev_name(dev));
>>   	kfree(udc);
>> +	udc = NULL;
> That's not ok, as what happens if you race right between freeing it and
> accessing it elsewhere?

Hi Greg,

Thanks for your comments.
Agree This race can occur at any time, and we are investigating the 
possibility of this issue through the following call trace. In our 
entire test sequence, the only place where we encounter UDC null is in 
the gadget_match_driver. It seems difficult to use locking to prevent 
this race, so we believe it would be acceptable to implement a NULL 
pointer check. We would appreciate any alternative solutions you may 
suggest.


CPU0: (ROLE SWITCH DEVICE -> HOST) CPU1 (echo "<dwc3 device name>" > UDC)
============================================================================== 

VENDOR usb notify driver()
VENDOR USB glue driver()              configfs_write_iter()
    usb_role_switch_set_role() gadget_dev_desc_UDC_store()
      dwc3_usb_role_switch_set()           driver_register()
        dwc3_set_mode()                     bus_add_driver()
         __dwc3_set_mode()                    driver_attach()
            dwc3_gadget_exit()                  bus_for_each_dev()
             usb_put_gadget(dwc->gadget); __driver_attach()
               usb_udc_release()
gadget_match_driver()
>
>>   }
>>   
>>   static const struct attribute_group *usb_udc_attr_groups[];
>> @@ -1574,7 +1575,7 @@ static int gadget_match_driver(struct device *dev, const struct device_driver *d
>>   			struct usb_gadget_driver, driver);
>>   
>>   	/* If the driver specifies a udc_name, it must match the UDC's name */
>> -	if (driver->udc_name &&
>> +	if (driver->udc_name && udc &&
> I agree this isn't good, but you just made the window smaller, please
> fix this properly.
>
> thanks,
>
> greg k-h


Sorry i did not understand on the above statement. Could you please 
provide more details on this?. Please correct me if i am wrong, Based on 
your statement, it seems that the time between the role switch and the 
write UDC is shorter than what is required, and you believe that we need 
to fix our glue driver itself where trigger the 
usb_role_switch_set_role(). Is that correct understanding?

Thanks,
Selva
>

