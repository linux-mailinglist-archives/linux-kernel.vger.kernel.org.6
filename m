Return-Path: <linux-kernel+bounces-315459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AD496C2F8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7AF1C21A34
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B545D1E0B7D;
	Wed,  4 Sep 2024 15:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PvRENX2d"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5041E00AC
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465038; cv=none; b=GYg+arltMTiqmz6Ro5dH1TYDbDXHgCJdYAd13WPAhBC2cyd0PuleXYJg10Y1sorceIPRiIOIet3/HA/mONBSvq5CRNnNU0fIdRAtddb8wTe0lbeeTc4idS0bokTx2oEkH1R46TSvSZ3vviz1XPAXDwVzuaMGRhb8NNDB4Lw0VEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465038; c=relaxed/simple;
	bh=2EbKamjWGanLk4gaA1p7oW+yhEBN/7lCs/ggabPvqXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=uCOCD8AjLxZlWBBwU0OLfEDjyUudrP2iQ1LXCxZEt7EgFD0nkeDJ/J2Zg0r9FvLKy5980zDfMZBRs+PFfl/Cm2Z5kOOlzbCSqUtGfzQIrsMhg7B2ih5aWlfBPKw94S8DoUkxYgZVpu0cLGyJyOdJ/dySm2Qqsj5NK8yeaRlCvII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=PvRENX2d; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240904155034epoutp02decbf7f57412a8cc56b45495583d651e~yFU6UscvV0795607956epoutp029
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:50:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240904155034epoutp02decbf7f57412a8cc56b45495583d651e~yFU6UscvV0795607956epoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725465034;
	bh=y4PzzypbOZh7CnAK0uxG8BpFMQOGa7hIJcoIlyAjJVw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=PvRENX2dH/u/G/qa3SooR6GqrdQQ0ImLrDVcAd6FHvZbwr93a9x/aLbFqDQJToElG
	 CQpMdU1AeJzanuEUiKbxCO79QvPl2PSLXXdVj5dLWxyUVS+eGaN4NHZDTqzmXaTzVz
	 iiqDpHFMV5Aro30NQ6ysLFxt3q9LXfbIMx2ACCAg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240904155033epcas5p368373ed8cbde351ee0e84379b47da793~yFU5ilTYj0435004350epcas5p3E;
	Wed,  4 Sep 2024 15:50:33 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4WzRlr2nCSz4x9Pr; Wed,  4 Sep
	2024 15:50:32 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	41.E4.09642.8C188D66; Thu,  5 Sep 2024 00:50:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240904155031epcas5p1a31edffa50f8902377a0709e9a41f9c3~yFU3zL_M62987129871epcas5p1Z;
	Wed,  4 Sep 2024 15:50:31 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240904155031epsmtrp27df29316dc0af8ff80826f03a9dbea29~yFU3xxH1M0155601556epsmtrp2M;
	Wed,  4 Sep 2024 15:50:31 +0000 (GMT)
X-AuditID: b6c32a4b-879fa700000025aa-15-66d881c87852
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	20.41.07567.7C188D66; Thu,  5 Sep 2024 00:50:31 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240904155029epsmtip10c41ab5e27c66ef941b04d8bcf363771~yFU1VhmXJ0107501075epsmtip1k;
	Wed,  4 Sep 2024 15:50:28 +0000 (GMT)
Message-ID: <11535d95-c972-4dbe-afb5-de3a44bc4a21@samsung.com>
Date: Wed, 4 Sep 2024 21:20:27 +0530
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
In-Reply-To: <20240904010322.leqt3pap6lguivg4@synopsys.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmuu6JxhtpBuuu8Vm8ubqK1eLOgmlM
	FqeWL2SyaF68ns1i0p6tLBZ3H/5gsbi8aw6bxaJlrcwWn47+Z7VY1TkHKPZ9J7PFpIOiFqsW
	HGB34PXYP3cNu0ffllWMHlv2f2b0+LxJLoAlKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTM
	wFDX0NLCXEkhLzE31VbJxSdA1y0zB+g8JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpB
	Sk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2xs5VVxgL+qQrjr/sYGpgnC3WxcjJISFgInFz
	3j32LkYuDiGB3YwSRy63MoIkhAQ+MUrMeeAJkfjGKNHy7jkzTMeyjm8sEEV7GSVuXOGHKHoL
	1D1/ARNIglfATmLVp81sIDaLgIrElUNT2SDighInZz4BaxYVkJe4f2sGO4gtLBAgcWXJDLDN
	IgI6EgdOnGcCGcos0MEqsaC7DWwos4C4xK0n84FsDg42AUOJZydsQMKcAtYSdzb+ZYEokZdo
	3jqbGaRXQmALh8SSTx9ZIa52keg78p8FwhaWeHV8CzuELSXx+d1eNgi7WmL1nY9sEM0tjBKH
	n3yDKrKXeHz0ETPIYmYBTYn1u/QhlvFJ9P5+AnaPhACvREebEES1qsSpxstQI6Ul7i25BnWC
	h8SkJ9tZIIF1nUVi96ROxgmMCrOQwmUWkjdnIflnFsLmBYwsqxglUwuKc9NTi00LjPNSy+ER
	npyfu4kRnHq1vHcwPnrwQe8QIxMH4yFGCQ5mJRHe1yI30oR4UxIrq1KL8uOLSnNSiw8xmgIj
	aCKzlGhyPjD555XEG5pYGpiYmZmZWBqbGSqJ875unZsiJJCeWJKanZpakFoE08fEwSnVwLQm
	6ZD0lNmGbcy+P/oOnBVJdzrwbpKeolnBNGGVzCkKhy2fOcbNbHvbdkan2vCAA3fXnqwrhwuX
	fNnHc+TPdfXLt85uj/LadsvtxNTAe4oy9fdL19deuRUR8nuK5Q8FFy7tKMGDpmvaFu29dOCR
	xkmrsrTp3PU2m4+t2PoyQNh//6rzc/dsnRr/91WUxV3N49snsnG1lOdttardxP3P9CDLEkmn
	65+VFmYdqr2vfvzDnuX1Pud+cbAvi9rDGiW1KrwmwPHoXQYzjr0vgwtcLP8WOv4MyJlXInLz
	oZ/f332HKkRepf8P5DvDm/Z1+VGVqRdEK/TNe7S/pQZvS7/YoBK5Z6e/wIn7VyRldlrv5ONV
	YinOSDTUYi4qTgQAf0vEFEYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJTvd44400g7XflC3eXF3FanFnwTQm
	i1PLFzJZNC9ez2Yxac9WFou7D3+wWFzeNYfNYtGyVmaLT0f/s1qs6pwDFPu+k9li0kFRi1UL
	DrA78Hrsn7uG3aNvyypGjy37PzN6fN4kF8ASxWWTkpqTWZZapG+XwJWxc9UVxoI+6YrjLzuY
	Ghhni3UxcnJICJhILOv4xgJiCwnsZpT4tMMCIi4t8XpWFyOELSyx8t9z9i5GLqCa14wShxZ3
	giV4BewkVn3azAZiswioSFw5NJUNIi4ocXLmE7ChogLyEvdvzWAHsYUF/CSmvzkB1isioCNx
	4MR5JpChzAI9rBJfvn5kgdhwnUVi2pc2ZpAqZgFxiVtP5gNVcXCwCRhKPDthAxLmFLCWuLPx
	LwtEiZlE11aIS5mBljVvnc08gVFoFpI7ZiGZNAtJyywkLQsYWVYxSqYWFOem5yYbFhjmpZbr
	FSfmFpfmpesl5+duYgTHmZbGDsZ78//pHWJk4mA8xCjBwawkwvta5EaaEG9KYmVValF+fFFp
	TmrxIUZpDhYlcV7DGbNThATSE0tSs1NTC1KLYLJMHJxSDUx2LTUbTb8tvvHtY295xPpVrEm2
	5xy3Z+85cTtb9ID4TNZKlZ+lb7j8Xgvv3N6138Ph92eLRc/ezdqyVHJp130np7P5H3SbTTfE
	bfmw7XVtVqrp/7sVwW6vxCWrVE6d+7l9wlmFhQtOSbidtm/3EJHIZzykEfROb8X+bzwWNSHz
	zuxjKDy3Ofd8hgffZodwfpOPR+dPLJFP/7lcefrDF9fON1dlzQgT+hzn/fR4zNcFPYsfe+nP
	fJC1sOBP7/dHEawFq1SOL3gYJnS/ckul4rEbp370hL5tSbgwszyBNSHcbIfywyQPhb7lRw4+
	XStyfVma7Jfpx885T34e0+Bz7ZDO3SwP440lIgfSbrqf3ReUr8RSnJFoqMVcVJwIACRB3DEi
	AwAA
X-CMS-MailID: 20240904155031epcas5p1a31edffa50f8902377a0709e9a41f9c3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240719110149epcas5p3dd468685a095c094ed2e540279bf3ec2
References: <CGME20240719110149epcas5p3dd468685a095c094ed2e540279bf3ec2@epcas5p3.samsung.com>
	<20240719110100.329-1-selvarasu.g@samsung.com>
	<20240807003806.5owtgwgw2lczg4u5@synopsys.com>
	<b6baeb45-1684-4fcb-8c71-392cb4788c85@samsung.com>
	<20240808011536.oid627ez4ppdfkhp@synopsys.com>
	<b48e7aba-6c54-431f-bbb5-3e5490df0c1a@samsung.com>
	<20240809234227.eriwy5e6leatzdyh@synopsys.com>
	<b273201d-c589-4c57-9d57-ad2affaeade0@samsung.com>
	<20240831005046.5lndwdr7cfm3k3to@synopsys.com>
	<2e678109-8399-48d5-9567-033eab910bca@samsung.com>
	<20240904010322.leqt3pap6lguivg4@synopsys.com>


On 9/4/2024 6:33 AM, Thinh Nguyen wrote:
> On Mon, Sep 02, 2024, Selvarasu Ganesan wrote:
>> I would like to reconfirm from our end that in our failure scenario, we
>> observe that DWC3_EVENT_PENDING is set in evt->flags when the dwc3
>> resume sequence is executed, and the dwc->pending_events flag is not
>> being set.
>>
> If the controller is stopped, no event is generated until it's restarted
> again. (ie, you should not see GEVNTCOUNT updated after clearing
> DCTL.run_stop). If there's no event, no interrupt assertion should come
> from the controller.
>
> If the pending_events is not set and you still see this failure, then
> likely that the controller had started, and the interrupt is generated
> from the controller event. This occurs along with the interrupt
> generated from your connection notification from your setup.


I completely agree. My discussion revolves around the handling of the 
DWC3_EVENT_PENDING flag in all situations. The purpose of using this 
flag is to prevent the processing of new events if an existing event is 
still being processed. This flag is set in the top-half interrupt 
handler and cleared at the end of the bottom-half handler.

Now, let's consider scenarios where the bottom half is not scheduled, 
and a USB reconnect occurs. In this case, there is a possibility that 
the interrupt line is unmasked in dwc3_event_buffers_setup, and the USB 
controller begins posting new events. The top-half interrupt handler 
checks for the DWC3_EVENT_PENDING flag and returns IRQ_HANDLED without 
processing any new events. However, the USB controller continues to post 
interrupts until they are acknowledged.

Please review the complete sequence once with DWC3_EVENT_PENDING flag.

My proposal is to clear or reset the DWC3_EVENT_PENDING flag when 
unmasking the interrupt line dwc3_event_buffers_setup, apart from 
bottom-half handler. Clearing the DWC3_EVENT_PENDING flag in 
dwc3_event_buffers_setup does not cause any harm, as we have implemented 
a temporary workaround in our test setup to prevent IRQ storms.



Working scenarios:
==================
1. Top-half handler:
     a. if (evt->flags & DWC3_EVENT_PENDING)
         return IRQ_HANDLED;
     b. Set DWC3_EVENT_PENDING flag
     c. Masking interrupt line

2. Bottom-half handler:
     a. Un-masking interrupt line
     b. Clear DWC3_EVENT_PENDING flag

Failure scenarios:
==================
1. Top-half handler:
     a. if (evt->flags & DWC3_EVENT_PENDING)
                 return IRQ_HANDLED;
     b. Set DWC3_EVENT_PENDING flag
     c. Masking interrupt line

2. No Bottom-half scheduled:

3. USB reconnect: dwc3_event_buffers_setup
     a. Un-masking interrupt line

4. Continuous interrupts : Top-half handler:
     a. if (evt->flags & DWC3_EVENT_PENDING)
                 return IRQ_HANDLED;

     a. if (evt->flags & DWC3_EVENT_PENDING)
                 return IRQ_HANDLED;

     a. if (evt->flags & DWC3_EVENT_PENDING)
                 return IRQ_HANDLED;
.....

.....

.....

Thanks,
Selva

>
> Check your platform and internal team, what condition would cause the
> setup to generate the interrupt and what condition would stop this
> custom connection interrupt assertion? This is outside of what's defined
> by the flow of the controller.
>
> BR,
> Thinh

