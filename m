Return-Path: <linux-kernel+bounces-311442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2F7968947
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80DAC281CB0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B747120FAAE;
	Mon,  2 Sep 2024 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kkISU8Bc"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1501865F6
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725285503; cv=none; b=YjQtzKoJu043mXqfxJH6Rf9MWq8dibP43jJE3EJkzfqiH6UwEsAyL63mwllXaNWB42jRZRH8pNuyQ0iHCcrrmemAAxmZkG35q5PFl+Z0/A1sj3GHZmELNIHTQc6oiPzYXy6+i7EjO3E742WGi+qLnCaV9+qYxc6jtorHcO2+hjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725285503; c=relaxed/simple;
	bh=77Em/0+PwDa6cdDVhhukewOuiaJu+6okTjnMbbiKN60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Ww+1VDw5pPTDsyYCl+SeEX/u30/ecs8HKzJco/OIGhbooXOClSk9Dz1xMGg2zYXFfOpo0Fs4CTAzJf7iVkuHmlukUOXR2POGcLp24i/6HUHS1YMRzAbXGkRKqw2755UG9zR3+1DsbVfvLmCY1YnjqDf1KEYhY4dwr7HL3yC/EkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kkISU8Bc; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240902135818epoutp018dff4698cd66242dac91414ca5223217~xcgUynejy1277912779epoutp01P
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 13:58:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240902135818epoutp018dff4698cd66242dac91414ca5223217~xcgUynejy1277912779epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725285498;
	bh=2JdZmd0hXajsenejN+yfwg6Vczo0f37j8pc3Xi5gO38=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=kkISU8BcK2IsI9rWDSjSCpCMDKoQoesyiY95O58qLEaXa3DV6885+BojmRtbeTq+j
	 xGBjBgEPeDdIL66f0dJB/CnFByUolZPev32p2pjNgf3CGRSioEG/5N98X2LZH7SlEW
	 nN/mizaXJ3w3freLyNQPg/gx7fKwIYRVe6Q7i10o=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240902135818epcas5p2ce71ea836ec16ed9433e7639d07b312b~xcgUHBQse2672326723epcas5p2y;
	Mon,  2 Sep 2024 13:58:18 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Wy9M92Dkrz4x9Py; Mon,  2 Sep
	2024 13:58:13 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9F.43.19863.574C5D66; Mon,  2 Sep 2024 22:58:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240902134041epcas5p1f3c7e865fdcedb24bbd9ecfa9ca5e219~xcQ8d3qND3191131911epcas5p1s;
	Mon,  2 Sep 2024 13:40:41 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240902134041epsmtrp26930a7b02dadee34d16aa33f50f2b455~xcQ8cssRv3156631566epsmtrp2N;
	Mon,  2 Sep 2024 13:40:41 +0000 (GMT)
X-AuditID: b6c32a50-c73ff70000004d97-14-66d5c475ed32
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	51.E4.08456.950C5D66; Mon,  2 Sep 2024 22:40:41 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240902134038epsmtip1ad7521958994a7c7a975cc65f4eb3497~xcQ4wGpUj3139831398epsmtip1-;
	Mon,  2 Sep 2024 13:40:37 +0000 (GMT)
Message-ID: <28b0a42c-2379-4844-ae18-9b0679263460@samsung.com>
Date: Mon, 2 Sep 2024 19:10:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: udc: Add null pointer check for udc in
 gadget_match_driver
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <gregkh@linuxfoundation.org>, royluo@google.com,
	paul@crapouillou.net, elder@kernel.org, yuanlinyu@hihonor.com,
	quic_kriskura@quicinc.com, crwulff@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jh0801.jung@samsung.com,
	dh10.jung@samsung.com, naushad@samsung.com, akash.m5@samsung.com,
	rc93.raju@samsung.com, taehyun.cho@samsung.com, hongpooh.kim@samsung.com,
	eomji.oh@samsung.com, shijie.cai@samsung.com, stable <stable@kernel.org>
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <fbf87ddf-6d8e-43b7-b9f5-65025395b170@rowland.harvard.edu>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCJsWRmVeSWpSXmKPExsWy7bCmpm7pkatpBltf8Fi8ubqK1WLu0d1s
	FncWTGOyuHd0NpvFqeULmSyaF69ns5i0ZyuLxd2HP1gsLu+aw2axaFkrs8Wno/9ZLfoXX2Kx
	+P76I6vFqs45LBbtDafYLC5/3wmUPX+BzWLCbyAx6aCoxddPlxgdRDxWX2pn89g56y67x4JN
	pR5zfk1m9ti0qpPNY//cNeweE/fUecy++4PRo2/LKkaPz5vkAriism0yUhNTUosUUvOS81My
	89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgL5TUihLzCkFCgUkFhcr6dvZFOWX
	lqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIVJmRnTHo3i6lgiWTFhaZdzA2M
	C0S7GDk5JARMJN7NmM3excjFISSwh1Hi6KJPrBDOJ0aJ5p7HLBDON0aJH+8WsMC0ND/oYYRI
	7AVK9HZCOW8ZJV7ems8IUsUrYCdxfcVpIJuDg0VARWJaDw9EWFDi5MwnYINEBeQl7t+awQ5i
	CwvESfSen8oMYosIaElsbnrJDDKTWeAOs0RjWzMTSIJZQFzi1pP5TCAz2QQMJZ6dsAEJcwq4
	S2x5co4ZokReonnrbLBeCYFuTommM/eZIa52kVi+7zoThC0s8er4FnYIW0ri87u9bBB2tcTq
	Ox/ZIJpbGCUOP/kGVWQv8fjoI2aQxcwCmhLrd+lDhGUlpp5aB3Ubn0Tv7ydQ83kldsyDsVUl
	TjVehpovLXFvyTVWCNtD4mrrdeYJjIqzkMJlFpI3ZyH5ZxbC5gWMLKsYpVILinPTU5NNCwx1
	81LL4VGenJ+7iRGc/LUCdjCu3vBX7xAjEwfjIUYJDmYlEd7YjVfThHhTEiurUovy44tKc1KL
	DzGaAiNoIrOUaHI+MP/klcQbmlgamJiZmZlYGpsZKonzvm6dmyIkkJ5YkpqdmlqQWgTTx8TB
	KdXAVJU5v3mpUvmyHz/+TtJQDHRnDHTsfvg24eTNv5MMT3T/8pyVcs+98drLySfS82zM9kkW
	5czQaPniUN7muWJuBEdAY6np7sv/Jf5t4jsZGLR3ap5X3/uVzKXnNVZfbuFYeCljbuCRw3kF
	xx6+0NXPaX0kkaP/iP0D97RjgW1uu3liXjBvC+X+bS7vyyHlVlV9U/Eg/xZ+by2/0tPnTgUI
	cue/7RaPXc0jtrAq5XtvGdOkRzoup4/9562cfN37ZfMRwRVFNmGPY8K+ukTkTHNPayjvjjWR
	aZjNub3y8qufnlWa71u+tgbMzf5uo39z0/3JUY6b2W53J269V6sg7eZ7v/TB6k91i7+H5Jox
	LspXYinOSDTUYi4qTgQAo935oocEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsWy7bCSnG7kgatpBttWGFu8ubqK1WLu0d1s
	FncWTGOyuHd0NpvFqeULmSyaF69ns5i0ZyuLxd2HP1gsLu+aw2axaFkrs8Wno/9ZLfoXX2Kx
	+P76I6vFqs45LBbtDafYLC5/3wmUPX+BzWLCbyAx6aCoxddPlxgdRDxWX2pn89g56y67x4JN
	pR5zfk1m9ti0qpPNY//cNeweE/fUecy++4PRo2/LKkaPz5vkAriiuGxSUnMyy1KL9O0SuDIm
	vZvFVLBEsuJC0y7mBsYFol2MnBwSAiYSzQ96GLsYuTiEBHYzShz6v5wJIiEt8XpWFyOELSyx
	8t9zdoii14wSmy4uAiviFbCTuL7iNFARBweLgIrEtB4eiLCgxMmZT1hAbFEBeYn7t2awg9jC
	AnESveenMoPYIgJaEpubXjKDzGQWuMMs8fD1GqgFb5gkrj/6DFbFLCAucevJfCaQBWwChhLP
	TtiAhDkF3CW2PDkHVWIm0bUV4lBmoGXNW2czT2AUmoXkjllIJs1C0jILScsCRpZVjJKpBcW5
	6bnFhgVGeanlesWJucWleel6yfm5mxjBUa6ltYNxz6oPeocYmTgYDzFKcDArifDGbryaJsSb
	klhZlVqUH19UmpNafIhRmoNFSZz32+veFCGB9MSS1OzU1ILUIpgsEwenVAMTz5uinEL7svvn
	Jke/OtE4TXW1luedG2GcS/7wRfr9Pc4++VJ6tvWBIy/8PzTMu3G/drPH7oxs/raJKxgPGa1b
	dzb+exzTX9m1zLxfd2SGrDk0yWkOQ+M1M5usJ/fyrp2dLJbe+nx7LZug5mYvg7KKOp3KqB97
	M05viC2RtmP20+NtYefti5+wOLnwmExO3VUe/pdFZ9XTz/7grdxj8MJGYsGdyVp/vqz8sJ89
	xZc1QYDh1pfVk2esCZ86L8RsGpeI87eqwE28Jb8kLY3m+Jjrt+qs9fh7XvPY/yWihuVTJae4
	J/wKec+gXdN2jWvFiVyWM7fN4xP+BOas0xT76SUa4tz4qHKB6Jk/N+dd8p2gxFKckWioxVxU
	nAgAHZzroWEDAAA=
X-CMS-MailID: 20240902134041epcas5p1f3c7e865fdcedb24bbd9ecfa9ca5e219
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
	<3c75924e-ed1d-4b1d-8d4e-fb4dfe4f363b@samsung.com>
	<fbf87ddf-6d8e-43b7-b9f5-65025395b170@rowland.harvard.edu>


On 8/31/2024 9:59 AM, Alan Stern wrote:
> On Fri, Aug 30, 2024 at 06:16:12PM +0530, Selvarasu Ganesan wrote:
>> Hi Alan,
>>
>> Thanks for your comments. I understand your suggestions. We already have
>> a similar reference check with the udc name before calling
>> usb_gadget_register_driver.
>> In the drivers/usb/gadget/configfs.c file, I am wondering if there might
>> be an issue with the check of udc_name before
>> usb_gadget_register_driver. This is the only way to allow
>> gadget_register to be called before releasing or unregistering an
>> existing udc. Do you think we need to add an additional check here,
>> referencing the UDC, to prevent gadget_register from being called before
>> the existing UDC is released?
> I don't understand what you're saying.  There is no routine named
> "gadget_register".  (And there is no variable named "udc_name" in the
> code below, although there is gi->composite.gadget_driver.udc_name --
> but that's not a variable, it is a field in a structure.)
>
>> drivers/usb/gadget/configfs.c : gadget_dev_desc_UDC_store()
>> ===========================================================
>> if (gi->composite.gadget_driver.udc_name) {
>>                           ret = -EBUSY;
>>                           goto err;
>>                   }
>> gi->composite.gadget_driver.udc_name = name;
> Are you talking about this check and assignment?  Why do you think there
> might be a problem here?
>
> Are you worried that some UDC might be released while this code is
> running?  If that happens, why would it be a problem?


I am talking here based on the call traces, we are observing the 
following call traces at the time of failures. One specific point of 
interest is the gadget_match_driver() function, which is called as part 
of the usb_gadget_register_driver() function. I am wondering how the 
usb_gadget_register_driver() function allows the registration of a new 
driver even when an existing same UDC is not releasing. One possibility 
is that gi->composite.gadget_driver.udc_name becomes NULL before the UDC 
is released. However, as of now, we do not have any evidence to support 
this theory. We are still trying to reproduce the same issue with added 
more debugging logs.

CPU0: (ROLE SWITCH DEVICE <-> HOST)
==================================

->usb_role_switch_set_role()
  ->dwc3_usb_role_switch_set()
   ->dwc3_set_mode()
    ->__dwc3_set_mode()
     ->dwc3_gadget_exit()
      ->usb_del_gadget()
       ->device_unregister()
        ->put_device(dev)
         ->usb_udc_release()


  CPU1 (echo "<dwc3 device name>" > <path of udc 
config>/config/usb_gadget/g1/UDC)
=================================================================================
->configfs_write_iter()
  ->gadget_dev_desc_UDC_store()
   ->usb_gadget_register_driver()
    ->driver_register()
     ->bus_add_driver()
      ->driver_attach()
       ->bus_for_each_dev()
        ->__driver_attach()
         ->gadget_match_driver()

>
>> ret = usb_gadget_register_driver(&gi->composite.gadget_driver);
> Alan Stern
>

