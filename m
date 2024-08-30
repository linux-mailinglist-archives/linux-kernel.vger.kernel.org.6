Return-Path: <linux-kernel+bounces-308803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EDD9661FE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108C21F25C66
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD4619ABDE;
	Fri, 30 Aug 2024 12:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="twxhO5Dj"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D2219ABA3
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725022059; cv=none; b=q70kHnHNGAo6iNOSIniGa14sIBFgsp0BuPfapyR8hr8SRz2wb/q3ky5DUHV1xnSBEEVr3VKyu+sNdTo5LrmAmbhE56MD8hQHurAmim8rurVLRw5PRHAaKu/rSnEsiNGq4cYAs5N6Mu5SKKjLZHCDs2I+Cg1X5QkjSE8BqUHhxg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725022059; c=relaxed/simple;
	bh=dP9NVuLNanoOHFWu/53iaXsqK8aAUk3b3toWliDvIow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=kjN7AEfx8uqKx2wOCdoRQNzswFJVz9L+qwzlAIZ60bKDOgtQrII5cfpSH5CEq6eKCrV2Tdd+C+V/TWW7qrz+1CXb752/FXD2MsPjFzuGUszAk4uC1HnqsYyTlRvFRWeR0Y6jig6PRDaKufG75MstxKCRywWlBAVK78PP339n6mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=twxhO5Dj; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240830124734epoutp033775e3e9cccbad3d7966315849ed1b11~wgmtNnx6q1476114761epoutp03T
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 12:47:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240830124734epoutp033775e3e9cccbad3d7966315849ed1b11~wgmtNnx6q1476114761epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725022054;
	bh=hd430z0O4yh/Csdy7Ny5j36rJo3ljTgoDZbzDgn/sH4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=twxhO5Dj2ft9KG6cfLgsINc0jyMsLVAxf+jSH1WtY37uZ+mn6EG0JpBN1CqbBryXc
	 H/25Xxqo+N/4eBwHw6LZ8btVq8Pjp8e10Ht8/TsjWjFizWWsl8AW/XVqQD+htZi+Px
	 nCumyx8wgMsnErPlcW0xWLATeyVx8r6pSpTwcbeY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240830124733epcas5p2d4cb031e78420e056859b3fc465df2f3~wgmsX8KiO0464104641epcas5p2r;
	Fri, 30 Aug 2024 12:47:33 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4WwHx04HY3z4x9Pr; Fri, 30 Aug
	2024 12:47:32 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	81.59.09642.46FB1D66; Fri, 30 Aug 2024 21:47:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240830124617epcas5p1505c433a3cb154b508bfe6855ea2ca63~wgllgBOiu0076900769epcas5p1r;
	Fri, 30 Aug 2024 12:46:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240830124617epsmtrp153f13e1f5fe505dfe3711d3a6d53dbd4~wgllfIIwE1823818238epsmtrp1G;
	Fri, 30 Aug 2024 12:46:17 +0000 (GMT)
X-AuditID: b6c32a4b-879fa700000025aa-fd-66d1bf64af9e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3E.9B.08964.91FB1D66; Fri, 30 Aug 2024 21:46:17 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240830124613epsmtip132e4938edcca18b2adf22fe8c0544545~wglhy4RK12194621946epsmtip1f;
	Fri, 30 Aug 2024 12:46:13 +0000 (GMT)
Message-ID: <3c75924e-ed1d-4b1d-8d4e-fb4dfe4f363b@samsung.com>
Date: Fri, 30 Aug 2024 18:16:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: udc: Add null pointer check for udc in
 gadget_match_driver
To: Alan Stern <stern@rowland.harvard.edu>, Greg KH
	<gregkh@linuxfoundation.org>
Cc: royluo@google.com, paul@crapouillou.net, elder@kernel.org,
	yuanlinyu@hihonor.com, quic_kriskura@quicinc.com, crwulff@gmail.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	akash.m5@samsung.com, rc93.raju@samsung.com, taehyun.cho@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com, shijie.cai@samsung.com,
	stable <stable@kernel.org>
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <4c64791e-a2f0-4878-8025-4ced94da6bc3@rowland.harvard.edu>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEJsWRmVeSWpSXmKPExsWy7bCmlm7K/otpBg2fxS3eXF3FajH36G42
	izsLpjFZ3Ds6m83i1PKFTBbNi9ezWUzas5XF4u7DHywWl3fNYbNYtKyV2eLT0f+sFv2LL7FY
	fH/9kdViVeccFov2hlNsFpe/7wTKnr/AZjHhN5CYdFDU4uunS4wOIh6rL7WzeeycdZfdY8Gm
	Uo85vyYze2xa1cnmsX/uGnaPiXvqPGbf/cHo0bdlFaPH501yAVxR2TYZqYkpqUUKqXnJ+SmZ
	eem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QN8pKZQl5pQChQISi4uV9O1sivJL
	S1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7IzVn/tZyq4oVOx5ItpA+Ns
	1S5GTg4JAROJ10tamUFsIYHdjBJXPnN3MXIB2Z8YJU6/esMI4XxjlJjz4iQTTMfjg9fZIBJ7
	GSU2bXzDDuG8ZZR4f3o5G0gVr4CdxIvjf1hAbBYBVYnum60sEHFBiZMzn4DZogLyEvdvzWAH
	sYUF4iR6z08Fu0NEIEii7dd0ZpChzALbmCWeflsItppZQFzi1pP5QDYHB5uAocSzEzYgYU4B
	d4npTS8YIUrkJZq3zgbrlRD4zyGx51MLO8TZLhJXX65jhLCFJV4d3wIVl5J42d8GZVdLrL7z
	kQ2iuYVR4vCTb1AJe4nHRx8xgyxmFtCUWL9LHyIsKzH11Dqo2/gken8/gQYRr8SOeTC2qsSp
	xstsELa0xL0l11ghbA+Jq63XmScwKs5CCpdZSN6cheSfWQibFzCyrGKUTC0ozk1PLTYtMM5L
	LYdHeHJ+7iZGcOLX8t7B+OjBB71DjEwcjIcYJTiYlUR4l+65mCbEm5JYWZValB9fVJqTWnyI
	0RQYQROZpUST84G5J68k3tDE0sDEzMzMxNLYzFBJnPd169wUIYH0xJLU7NTUgtQimD4mDk6p
	BqaJjLs6ZnEelDRi8nXlCu1X816pJFr8Wq6t6GBTKEfCnL0z19muX65dI6hTenfLXN065m/s
	Lr84Fr3TiY5+eOaV2/OZSzWVTvCXB19W4uF1OjzDQvvgjajEZTPTuZoVA3yWeBdr/uVle2qZ
	Ejq7lqnGLyBy9c1Vu/85X7D2ZwloTCrP4fn7tcTa8Fp2sdeqy0K2ZUd2aVjsjN8f+OXz/z2C
	hRpRXzSyVqgH6oo4M3kdrj/DvtfTf0mtRE1wtyNj2Vk2HonmspB4qVuFVa2++vnPby2yS2hQ
	2WIevDDRyinyrNWt+Mav/hlTVr67f3FDco3GYqGCQ4/zP/qr3kmXPDvPNm55u8PlW2r9Hy8r
	sRRnJBpqMRcVJwIAbwhKiIUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsWy7bCSnK7k/otpBjfeylq8ubqK1WLu0d1s
	FncWTGOyuHd0NpvFqeULmSyaF69ns5i0ZyuLxd2HP1gsLu+aw2axaFkrs8Wno/9ZLfoXX2Kx
	+P76I6vFqs45LBbtDafYLC5/3wmUPX+BzWLCbyAx6aCoxddPlxgdRDxWX2pn89g56y67x4JN
	pR5zfk1m9ti0qpPNY//cNeweE/fUecy++4PRo2/LKkaPz5vkAriiuGxSUnMyy1KL9O0SuDJW
	f+1nKrihU7Hki2kD42zVLkZODgkBE4nHB6+zdTFycQgJ7GaUOHNuBSNEQlri9awuKFtYYuW/
	5+wQRa8ZJS5ehkjwCthJvDj+hwXEZhFQlei+2coCEReUODnzCZgtKiAvcf/WDHYQW1ggTqL3
	/FRmEFtEIEhi9VGIOLPANmaJq3O4IRb8YpRYuv85E0RCXOLWk/lANgcHm4ChxLMTNiBhTgF3
	ielNLxghSswkurZ2QdnyEs1bZzNPYBSaheSMWUgmzULSMgtJywJGllWMkqkFxbnpucWGBYZ5
	qeV6xYm5xaV56XrJ+bmbGMExrqW5g3H7qg96hxiZOBgPMUpwMCuJ8C7dczFNiDclsbIqtSg/
	vqg0J7X4EKM0B4uSOK/4i94UIYH0xJLU7NTUgtQimCwTB6dUA1OK8RqtCb7C+e2l4Yx/eU4q
	WmwsfmbHmfB87nWdXbE3TkQ0aDkzGwgr7P3KdNxt8fuPPRY531Y1TrI+LhPn9SHy6W9TwSwj
	jk9BOnZZedzfFjJ7y920qvwlfOd064yt8juln1lGLfA1MmQTPloicvot5/oa148f7u4wnWlm
	vMMt7aulm61Pt37OHf+Ua2c6uzqOVYvuM070mnJT5NLpXe452gkVfWdKy2xfsmirX3HbmWlY
	YHcwdOchNrcG/v9drlyyrdXX363h0nstoXl9xo0MC+k9Xyc81VU7dqeW/+LG9J0Ni+Sma5oV
	zNY3UXh4IHMpywcL1qobZq9KD+y9E625s+LJuZSPfGurlbiKlViKMxINtZiLihMBTVv4zGAD
	AAA=
X-CMS-MailID: 20240830124617epcas5p1505c433a3cb154b508bfe6855ea2ca63
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
	<4c64791e-a2f0-4878-8025-4ced94da6bc3@rowland.harvard.edu>


On 8/28/2024 8:24 PM, Alan Stern wrote:
> On Wed, Aug 28, 2024 at 11:39:58AM +0200, Greg KH wrote:
>> On Wed, Aug 28, 2024 at 12:35:04PM +0530, Selvarasu Ganesan wrote:
>>> This commit adds a null pointer check for udc in gadget_match_driver to
>>> prevent the below potential dangling pointer access. The issue arises
>>> due to continuous USB role switch and simultaneous UDC write operations
>>> performed by init.rc from user space through configfs.  In these
>>> scenarios, there was a possibility of usb_udc_release being done before
>>> gadget_match_driver.
>>>
>>> [27635.233849]  BUG: KASAN: invalid-access in gadget_match_driver+0x40/0x94
>>> [27635.233871]  Read of size 8 at addr d7ffff8837ead080 by task init/1
>>> [27635.233881]  Pointer tag: [d7], memory tag: [fe]
>>> [27635.233888]
>>> [27635.233917]  Call trace:
>>> [27635.233923]   dump_backtrace+0xec/0x10c
>>> [27635.233935]   show_stack+0x18/0x24
>>> [27635.233944]   dump_stack_lvl+0x50/0x6c
>>> [27635.233958]   print_report+0x150/0x6b4
>>> [27635.233977]   kasan_report+0xe8/0x148
>>> [27635.233985]   __hwasan_load8_noabort+0x88/0x98
>>> [27635.233995]   gadget_match_driver+0x40/0x94
>>> [27635.234005]   __driver_attach+0x60/0x304
>>> [27635.234018]   bus_for_each_dev+0x154/0x1b4
>>> [27635.234027]   driver_attach+0x34/0x48
>>> [27635.234036]   bus_add_driver+0x1ec/0x310
>>> [27635.234045]   driver_register+0xc8/0x1b4
>>> [27635.234055]   usb_gadget_register_driver_owner+0x7c/0x140
>>> [27635.234066]   gadget_dev_desc_UDC_store+0x148/0x19c
>>> [27635.234075]   configfs_write_iter+0x180/0x1e0
>>> [27635.234087]   vfs_write+0x298/0x3e4
>>> [27635.234105]   ksys_write+0x88/0x100
>>> [27635.234115]   __arm64_sys_write+0x44/0x5c
>>> [27635.234126]   invoke_syscall+0x6c/0x17c
>>> [27635.234143]   el0_svc_common+0xf8/0x138
>>> [27635.234154]   do_el0_svc+0x30/0x40
>>> [27635.234164]   el0_svc+0x38/0x68
>>> [27635.234174]   el0t_64_sync_handler+0x68/0xbc
>>> [27635.234184]   el0t_64_sync+0x19c/0x1a0
>>>
>>> Fixes: fc274c1e9973 ("USB: gadget: Add a new bus for gadgets")
>>> Cc: stable <stable@kernel.org>
>>> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
>>> ---
>>>   drivers/usb/gadget/udc/core.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
>>> index cf6478f97f4a..77dc0f28ff01 100644
>>> --- a/drivers/usb/gadget/udc/core.c
>>> +++ b/drivers/usb/gadget/udc/core.c
>>> @@ -1338,6 +1338,7 @@ static void usb_udc_release(struct device *dev)
>>>   	udc = container_of(dev, struct usb_udc, dev);
>>>   	dev_dbg(dev, "releasing '%s'\n", dev_name(dev));
>>>   	kfree(udc);
>>> +	udc = NULL;
>> That's not ok, as what happens if you race right between freeing it and
>> accessing it elsewhere?
> In fact, this assignment does nothing at all.  This is at the end of the
> function and udc is a local variable, so it's not going to be used
> again.  The compiler won't even generate any code for this.
>
>>>   }
>>>   
>>>   static const struct attribute_group *usb_udc_attr_groups[];
>>> @@ -1574,7 +1575,7 @@ static int gadget_match_driver(struct device *dev, const struct device_driver *d
>>>   			struct usb_gadget_driver, driver);
>>>   
>>>   	/* If the driver specifies a udc_name, it must match the UDC's name */
>>> -	if (driver->udc_name &&
>>> +	if (driver->udc_name && udc &&
>> I agree this isn't good, but you just made the window smaller, please
>> fix this properly.
> I don't see how udc can possibly be NULL here.  It gets initialized to a
> non-NULL value when usb_add_gadget() does:
>
> 	gadget->udc = udc;
>
> and nothing changes its value thereafter.  It seems much more likely
> that the error shown above is an invalid pointer access because
> gadget->udc points to a location that has been deallocated.  Adding this
> NULL check won't fix the bug.
>
> Apparently the problem is caused by the fact that bus_for_each_dev(),
> iterating over the things on the gadget bus, is still using gadget after
>
> 	device_del(&gadget->dev);
>
> in usb_del_gadget() returns and while
>
> 	device_unregister(&udc->dev);
>
> runs and the udc structure is deallocated.  The only solution I can
> think of is for the gadget to take a reference to the udc and drop the
> reference when the gadget is released.  Unfortunately, several UDC
> drivers define their own gadget-release routines; they will all need to
> be modified.  And the core will need its own gadget-release routine for
> use when the UDC driver does not specify its own.
>
> Alan Stern
Hi Alan,

Thanks for your comments. I understand your suggestions. We already have 
a similar reference check with the udc name before calling 
usb_gadget_register_driver.
In the drivers/usb/gadget/configfs.c file, I am wondering if there might 
be an issue with the check of udc_name before 
usb_gadget_register_driver. This is the only way to allow 
gadget_register to be called before releasing or unregistering an 
existing udc. Do you think we need to add an additional check here, 
referencing the UDC, to prevent gadget_register from being called before 
the existing UDC is released?



drivers/usb/gadget/configfs.c : gadget_dev_desc_UDC_store()
===========================================================
if (gi->composite.gadget_driver.udc_name) {
                         ret = -EBUSY;
                         goto err;
                 }
gi->composite.gadget_driver.udc_name = name;
ret = usb_gadget_register_driver(&gi->composite.gadget_driver);


Thanks,
Selva
>

