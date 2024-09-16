Return-Path: <linux-kernel+bounces-330667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 161D897A278
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971DF1F21E9F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB53C154C04;
	Mon, 16 Sep 2024 12:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tgEMJzIh"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95E281AD2
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 12:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726490621; cv=none; b=N2dBt8xkt/G4lK32eJ/Bx7Ah0pLEK2cCYGuSumJn9ndsCZeHRQ7EU1bAipDdIGOXDncxloUJNGYAmavvz/xIJy4xL+kMYzxqLyyu9ikjZ1BIhfQmh3MH6WrM3dZ2wHFK1t1laPM1cxB3t1FCmdPxCJbNvArMsK8DRjVfiUNDQ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726490621; c=relaxed/simple;
	bh=L+Mojg1uICePlLJvCLetzxaQmkjxuQieXMDwPTL5zf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=M4uvCGwMNKwfPwQiajAE0sAytbpswHxkD/iL6vus5+obf16+y4TDf1R4D3CWbjlIW1sQh4NmbqonWwLQIMPPqzJWFu7VCbRWQVq+dpAHMxZc/74A8dLp6vPCfZqixfSp/1pNp9zBMM0DJcbf8RY41fZ6WcqyDzfp/SEaGDoXGi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tgEMJzIh; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240916124336epoutp03f826dcac07fd4f358216e66a3de16029~1uhGBvVwc0320003200epoutp03c
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 12:43:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240916124336epoutp03f826dcac07fd4f358216e66a3de16029~1uhGBvVwc0320003200epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726490616;
	bh=L+Mojg1uICePlLJvCLetzxaQmkjxuQieXMDwPTL5zf0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=tgEMJzIhM/KSq9REz6Cpm4uV8U/vAyN+JumAtfkgDVBptdaequv5KJjH+9tog3bPx
	 x3qiS7nfUENGMpVoqRnXsnQKGeC99iwQbc3B/TpIj5ueBi/+ScvO/bzDpqGHhUtc0e
	 HaYkM4lJYZWSnlihSrAkoHi8mNfGPnPXQPwpLIkM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240916124336epcas5p4889ad835c9e7b5697a9f78bedd1c65db~1uhFwHkqq0317503175epcas5p4i;
	Mon, 16 Sep 2024 12:43:36 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4X6l2Z6y1Tz4x9Pr; Mon, 16 Sep
	2024 12:43:34 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	82.CB.09743.6F728E66; Mon, 16 Sep 2024 21:43:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240916124334epcas5p220ad18426c2575e4b262caf4975fb8fe~1uhEHWLq31118211182epcas5p2w;
	Mon, 16 Sep 2024 12:43:34 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240916124334epsmtrp1f335c255a8d0afe3c5af9b267415c260~1uhEGsG2T0228202282epsmtrp1c;
	Mon, 16 Sep 2024 12:43:34 +0000 (GMT)
X-AuditID: b6c32a4a-14fff7000000260f-15-66e827f66dc5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	C9.82.19367.6F728E66; Mon, 16 Sep 2024 21:43:34 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240916124332epsmtip117b749c77b6bc0261727777a2383f52f~1uhCOPg6x0113201132epsmtip1i;
	Mon, 16 Sep 2024 12:43:32 +0000 (GMT)
Message-ID: <1aa3c54a-7dcf-4cc4-9b05-96c67dda4fdb@samsung.com>
Date: Mon, 16 Sep 2024 18:13:31 +0530
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
In-Reply-To: <20240913175951.ahtlhkc5cycu6vjs@synopsys.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmhu439RdpBl9OGFm8ubqK1eLOgmlM
	FqeWL2SyaF68ns1i0p6tLBZ3H/5gsbi8aw6bxaJlrcwWn47+Z7VY1TkHKPZ9J7PFpIOiFqsW
	HGB34PXYP3cNu0ffllWMHlv2f2b0+LxJLoAlKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTM
	wFDX0NLCXEkhLzE31VbJxSdA1y0zB+g8JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpB
	Sk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2xqODHSwFN0QqrjadYW9gvCvQxcjBISFgInFo
	k04XIxeHkMBuRonVUzpYIJxPQM63TkY4Z9KyG0AZTrCOw5u+MkEkdjJKNB7ZwwySEBJ4yyix
	87AziM0rYCfx7NxDdhCbRUBV4mvLU0aIuKDEyZlPwAaJCshL3L81A6xGWCBA4sqSGWA1IgI6
	EgdOnAdbwCzQwSqxoLuNCSTBLCAucevJfCaQu9kEDCWenbABCXMKWEssnnaTGaJEXmL72znM
	IL0SAis5JG5vX8sIcbWLxOTXi6E+EJZ4dXwLO4QtJfGyvw3KrpZYfecjG0RzC6PE4SffoBL2
	Eo+PPmIGWcwsoCmxfpc+xDI+id7fT5gg4cgr0dEmBFGtKnGq8TIbhC0tcW/JNVYI20PiydX5
	0BC9ziKxcFkjywRGhVlI4TILyZuzkPwzC2HzAkaWVYySqQXFuempxaYFRnmp5fAIT87P3cQI
	Tr1aXjsYHz74oHeIkYmD8RCjBAezkgiv7e+naUK8KYmVValF+fFFpTmpxYcYTYERNJFZSjQ5
	H5j880riDU0sDUzMzMxMLI3NDJXEeV+3zk0REkhPLEnNTk0tSC2C6WPi4JRqYGLcOev0xjjf
	S7YWaxwMCiP39vrMT/m45MmW+lUNHeLPbl8M1q+IXVmxe0JhcNOMQ1vm5wuULhc1mFkxU2dL
	bpzkoeZWkYt8nCKXjvi3Tmw5H6i6cv+Bo53yStcStrz/Zmvf7bGgadP9xJW7jL+smRd4eWH2
	5ktTX1ZGu/hKzzw63XWe+bINMk/OPdhz416Yu1FEL++ZXdqbDnS+6NvZsi524seOhw/O37e8
	cDGB/f+25/skdKWZ7KYHPZM8ysiy9ortjxx3PTupzZkSbtdiUu7lr3pfv/T+lZl6CjXRHTUT
	H9acbT7h7OW11zzra52WWWZjj6VYw3TN6k0dYpdt3DkmKL1wesbeZcq+guUsc7gSS3FGoqEW
	c1FxIgBuL6uPRgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJTveb+os0g6OLJCzeXF3FanFnwTQm
	i1PLFzJZNC9ez2Yxac9WFou7D3+wWFzeNYfNYtGyVmaLT0f/s1qs6pwDFPu+k9li0kFRi1UL
	DrA78Hrsn7uG3aNvyypGjy37PzN6fN4kF8ASxWWTkpqTWZZapG+XwJXx6GAHS8ENkYqrTWfY
	GxjvCnQxcnJICJhIHN70lamLkYtDSGA7o8TaxV8ZIRLSEq9ndUHZwhIr/z1nB7GFBF4zSkzb
	HgJi8wrYSTw79xAsziKgKvG15SkjRFxQ4uTMJywgtqiAvMT9WzPAaoQF/CSmvzkBViMioCNx
	4MR5sMXMAj2sEl++fmSBuOI6i8TriVPAupkFxCVuPZkPVMXBwSZgKPHshA1ImFPAWmLxtJvM
	ECVmEl1bIQ5lBlq2/e0c5gmMQrOQ3DELyaRZSFpmIWlZwMiyilE0taA4Nz03ucBQrzgxt7g0
	L10vOT93EyM4vrSCdjAuW/9X7xAjEwfjIUYJDmYlEV7b30/ThHhTEiurUovy44tKc1KLDzFK
	c7AoifMq53SmCAmkJ5akZqemFqQWwWSZODilGpgEa/nEFfNqAhbJ7PvuPjP3Tm/1rDl+PHPy
	LBcqPzz5VOrA/FNrGxr7lsdrGJ5+nyxg9HDKrSKRwK7pDIZp1nUvZqixT97/aLvsvqWHZvo/
	mfeMaZJREv+v07zxpw9rrvvuv7UlqXz+1qUTfeMux23xWDu78UQiJ5/tbpY3GWcffbLSzPn9
	6et99yWX01uXHMrLd5KI7enQr1JSmHhhTgT3pmuP0zolTItrZr2PEv5bc+rZefcrdSryVUzx
	rzQsdl58f1i4amLUesYA4YJnhroKT8wkvCRzSoJvzT4mt/zfCq1fbve3SKzd9nTaFqs6tX//
	Jx2vaHXp3F5mvtz+U7Sfmvq14x0bp184M/VqPv8+JZbijERDLeai4kQA+QjkRR4DAAA=
X-CMS-MailID: 20240916124334epcas5p220ad18426c2575e4b262caf4975fb8fe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240911002436epcas5p19be55e1144edd6f77184192c7f22a85e
References: <20240905231825.6r2sp2bapxidur7a@synopsys.com>
	<64d049cc-d55d-4376-b6b9-402eb6f170c0@samsung.com>
	<20240906005935.caugoe3mqqdqwqao@synopsys.com>
	<30ca8527-419b-4e44-a21b-18e494b39076@samsung.com>
	<20240907003946.qn6t3xw65qwl2cn7@synopsys.com>
	<dff83c7d-56b8-481f-af69-8d4262bd54e4@samsung.com>
	<CGME20240911002436epcas5p19be55e1144edd6f77184192c7f22a85e@epcas5p1.samsung.com>
	<20240911002408.gr4fv5vkst7ukxd5@synopsys.com>
	<dd7965fa-9266-46b9-9219-1ef726480a9b@samsung.com>
	<20240913175106.qbav2aigzwaj7pvd@synopsys.com>
	<20240913175951.ahtlhkc5cycu6vjs@synopsys.com>


On 9/13/2024 11:30 PM, Thinh Nguyen wrote:
> On Fri, Sep 13, 2024, Thinh Nguyen wrote:
>> On Fri, Sep 13, 2024, Selvarasu Ganesan wrote:
>>> Hi Thinh,
>>>
>>> So far, there have been no reported error instances. But, we suspecting
>>> that the issue may be related to our glue driver. In our glue driver, we
>>> access the reference of evt->flags when starting or stopping the gadget
>>> based on a VBUS notification. We apologize for sharing this information
>>> so late, as we only became aware of it recently.
>>>
>>> The following sequence outlines the possible scenarios of race conditions:
>>>
>>> Thread#1 (Our glue Driver Sequence)
>>> ===================================
>>> ->USB VBUS notification
>>> ->Start/Stop gadget
>>> ->dwc->ev_buf->flags |= BIT(20); (It's for our reference)
>>> ->Call dwc3 exynos runtime suspend/resume
>>> ->dwc->ev_buf->flags &= ~BIT(20);
>>> ->Call dwc3 core runtime suspend/resume
>>>
>>> Thread#2
>>> ========
>>> ->dwc3_interrupt()
>>> ->evt->flags |= DWC3_EVENT_PENDING;
>>> ->dwc3_thread_interrupt()
>>> ->evt->flags &= ~DWC3_EVENT_PENDING;
>>>
>> This is great! That's likely the problem. Glad you found it.
>>
>>>
>>> After our internal discussions, we have decided to remove the
>>> unnecessary access to evt->flag in our glue driver. We have made these
>>> changes and initiated testing.
>>>
>>> Thank you for your help so far to understand more into our glue driver code.
>>>
>>> And We are thinking that it would be fine to reset evt->flag when the
>>> USB controller is started, along with the changes you suggested earlier.
>>> This additional measure will help prevent similar issues from occurring
>>> in the future.
>>>
>>> Please let us know your thoughts on this proposal. If it is not
>>> necessary, we understand and will proceed accordingly.
>>>
>> You can submit the change I suggested. That's a valid change. However,
>> we should not include the reset of the DWC3_EVENT_PENDING flag. Had we
>> done this, you may not found the issue above. It serves no purpose for
>> the core driver logic and will be an extra burden for us to maintain. (I
>> don't want to scratch my head in the future to figure out why that
>> change was needed or concern whether it can be removed without causing
>> regression).
>>
> Also, perhaps you may want to revisit and review the change below to see
> if the glue driver may be the culprit:
>
> 14e497183df2 ("usb: dwc3: core: Prevent USB core invalid event buffer address access")

Hi Thinh,

We reconfirmed that this issue not due to our glue driver.


Thanks,
Selva
> Thanks,
> Thinh

