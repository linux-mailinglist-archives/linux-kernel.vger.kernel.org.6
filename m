Return-Path: <linux-kernel+bounces-331913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B6297B2ED
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 18:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176E31C215B3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 16:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0098E175D33;
	Tue, 17 Sep 2024 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="B99buMtM"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A101B2EAEA
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726590133; cv=none; b=DPEH8gRhPTataXN5Sx3GEOMQZ3FAk1jUhjOHWoiNSfcZJrFXosZ99ER8pSTBQaxZkHQpA/+Swf6b81WbpdWf/zEHRg8TwVRE368d5yJ/7ZFNM67iugMBgFWO1VhDP2pqVrv22g6/Cdp7HMgeqvuLKjUVDZ0I1tD1lf5fql3vxEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726590133; c=relaxed/simple;
	bh=IBAc7Et+n4VYCK9+p393VjHjiVEy4G3zG9joVXhMc/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=SceVrcPdvf9Kv7aBoncnN2QxNRdnNhk/7VkyqJpPz6Bvw5GW/zJgEg9C8+Q0Gl/DmiiY2cDihPSYNhEGkgPSoVLZWRhiEIibA5W0v6TppCREgFJisZCi80v7oGukwXhA0hrlF1coS7knsqN0SbJ2DjNM5EUIklABWaiDyL0gcoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=B99buMtM; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240917162207epoutp034fc1d8f7666750d331cd8c46b38fa83c~2FJK-aixJ0568705687epoutp03O
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 16:22:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240917162207epoutp034fc1d8f7666750d331cd8c46b38fa83c~2FJK-aixJ0568705687epoutp03O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726590127;
	bh=AkvLWYQt/CE4wS94Lzo2iJIySkF3sjVM/X6037Wed+8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=B99buMtMQkTLNqzrEc8uYlyYtFD8UwCAFq6Xq6ObmzpUoP+eAfjFsTnwrPOQ6VaDp
	 NYUi6lxPvgJMNI09YmdDiuNLnDw/qGfXvOCIpi5gQFUlytKeY/6MtdtHQyOzuqjstZ
	 pnvUi7OO6gxKC1BTtE83gkb/ybeZYe8oLOM0v/pQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240917162206epcas5p30a5aff5e1a3e716a3f935d4540aa85f0~2FJJwP8ZI1661916619epcas5p3J;
	Tue, 17 Sep 2024 16:22:06 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4X7RrD5KDnz4x9Pv; Tue, 17 Sep
	2024 16:22:04 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B5.19.08855.CACA9E66; Wed, 18 Sep 2024 01:22:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240917162204epcas5p252d46fd21b2a2f0744b6549ba0c04ae3~2FJHsFth-2561625616epcas5p29;
	Tue, 17 Sep 2024 16:22:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240917162204epsmtrp292c397d3fbe9eb3f4f747f8600145612~2FJHrI9xh0254702547epsmtrp2L;
	Tue, 17 Sep 2024 16:22:04 +0000 (GMT)
X-AuditID: b6c32a44-107ff70000002297-94-66e9acac0187
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BA.A1.08964.BACA9E66; Wed, 18 Sep 2024 01:22:03 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240917162201epsmtip21499845cc227df5869d38d8f6f4307cc~2FJFmZ5LG1339713397epsmtip2a;
	Tue, 17 Sep 2024 16:22:01 +0000 (GMT)
Message-ID: <da717b2e-e8dc-461f-bef7-d3d9e5df3632@samsung.com>
Date: Tue, 17 Sep 2024 21:52:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc3: core: Stop processing of pending events
 if controller is halted
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>
Cc: "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jh0801.jung@samsung.com" <jh0801.jung@samsung.com>, "dh10.jung@samsung.com"
	<dh10.jung@samsung.com>, "naushad@samsung.com" <naushad@samsung.com>,
	"akash.m5@samsung.com" <akash.m5@samsung.com>, "rc93.raju@samsung.com"
	<rc93.raju@samsung.com>, "taehyun.cho@samsung.com"
	<taehyun.cho@samsung.com>, "hongpooh.kim@samsung.com"
	<hongpooh.kim@samsung.com>, "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
	"shijie.cai@samsung.com" <shijie.cai@samsung.com>, stable
	<stable@kernel.org>
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <2024091758-devotion-clutter-29f6@gregkh>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIJsWRmVeSWpSXmKPExsWy7bCmlu6aNS/TDOZvUbN4c3UVq8WdBdOY
	LE4tX8hkMf9mkkXz4vVsFpP2bGWxuPvwB4vF5V1z2CwWLWtltvh09D+rxarOOUCx7zuB3PMX
	gOoOilqsWnCA3YHfY9OqTjaPeScDPfbPXcPu0bdlFaPHlv2fGT0+b5ILYIvKtslITUxJLVJI
	zUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBOlhJoSwxpxQoFJBYXKyk
	b2dTlF9akqqQkV9cYquUWpCSU2BSoFecmFtcmpeul5daYmVoYGBkClSYkJ0xf39JwQGeiq4j
	FxkbGGdydTFycEgImEh0dpV1MXJxCAnsZpSYfe0ZE4TziVFixvk5zBDON0aJrycWsXQxcoJ1
	LG84ww6R2MsocefMBVYI5y2jxLdjU9hB5vIK2En8OM0F0sAioCox9dlyRhCbV0BQ4uTMJ2CD
	RAXkJe7fmsEOYgsLpEhMP3YerEZEIFPi2Z8GFpCZzAKrWCW+X5kMVsQsIC5x68l8JpD5bAKG
	Es9O2ICEOQXMJJ6decwMUSIvsf3tHGaIQ09wSEycHwfxpovEy349iLCwxKvjW9ghbCmJz+/2
	skHY1RKr73xkA1krIdDCKHH4yTeoInuJx0cfMYPMYRbQlFi/Sx9iFZ9E7+8nTBDjeSU62oQg
	qlUlTjVehhopLXFvyTVWCNtDYtLR22AThQSOMkmcnck1gVFhFlKgzELy4ywkz8xCWLyAkWUV
	o2RqQXFuemqyaYFhXmo5PLKT83M3MYLTspbLDsYb8//pHWJk4mA8xCjBwawkwmv7+2maEG9K
	YmVValF+fFFpTmrxIUZTYOxMZJYSTc4HZoa8knhDE0sDEzMzMxNLYzNDJXHe161zU4QE0hNL
	UrNTUwtSi2D6mDg4pRqY/EsWqCZbZ2reC65tP/Fw0ZMZsbUPCw/rPE0tL+/uUpc/6xLwu0NB
	33z7LmYD0dnnflb5O0+wO6O5Pi9gyfOJdZWsR/+UVzWa+h5aJs+1bemKUxKLxa7kZhSt7Xh6
	byOr96F1Nlc3Buy88OWk1tGbDQa1HFZ+vkkZ/rr2/wv+KD5c9/rEE4ntZ66UtslFGvutfRZ8
	3HWJFXfTxQ0F6VV91xc87rPmK51pn3LrWa7LJr2UiVfkAs0ba1WOXG4QmP3h58s3XR9W/331
	UUFKZYeEU165Zi/ngpOKHUt3XyrnMl//vWCXr35DOVtX+fvVK0u2z/iT4VVcZh0jUD+/WMrL
	wuFlTsKS7R6JmU/fzX+gxFKckWioxVxUnAgAFnGU6FQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsWy7bCSvO7qNS/TDL4csLF4c3UVq8WdBdOY
	LE4tX8hkMf9mkkXz4vVsFpP2bGWxuPvwB4vF5V1z2CwWLWtltvh09D+rxarOOUCx7zuB3PMX
	gOoOilqsWnCA3YHfY9OqTjaPeScDPfbPXcPu0bdlFaPHlv2fGT0+b5ILYIvisklJzcksSy3S
	t0vgypi/v6TgAE9F15GLjA2MM7m6GDk5JARMJJY3nGHvYuTiEBLYzShx6monI0RCWuL1rC4o
	W1hi5b/n7CC2kMBrRonLcyu6GDk4eAXsJH6cBpvDIqAqMfXZcrByXgFBiZMzn7CA2KIC8hL3
	b80AaxUWSJF4fus6G4gtIpAp8WrHbDaQvcwCa1glPm9/xAZxxFEmiV9PnoJ1MwuIS9x6Mp8J
	ZBmbgKHEsxM2IGFOATOJZ2ceM0OUmEl0bYW4kxlo2fa3c5gnMArNQnLHLCSTZiFpmYWkZQEj
	yypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOA41NLcwbh91Qe9Q4xMHIyHGCU4mJVE
	eG1/P00T4k1JrKxKLcqPLyrNSS0+xCjNwaIkziv+ojdFSCA9sSQ1OzW1ILUIJsvEwSnVwJR2
	4M+bKXNWXXp3r3WNwSn5Kxy1tzj0mSqK/ljOSO3KuRozqbovbHKj6/KNm7iSp2w99ixPrCBC
	1KL5jEbB9wfbl9bPs9ZsEJ63LGFy6+Ob1899nSxvt7kz0PlPUa+L8Z61i40Xhy71X9N6ssR0
	roXkMfZAQTXnX5+7qpL7+hrCF9mY2JnIL9Bo+Liu/9mPZ9vC8t719lfFsGarZyy2ZrI72+Ov
	W+rFnHjF3GQ978206y9frj/AstYiQ2fCcq5PE6VWTZE9ky3A3hK4eoXl8q4prWzbdolMWmbM
	NceOw2ODQwZDs/lE98rUy88VTj7c/u/rSWuXIPMLDP+nyKsfPB/desBAy+fHiqdmoWpVwUos
	xRmJhlrMRcWJAIb9p8syAwAA
X-CMS-MailID: 20240917162204epcas5p252d46fd21b2a2f0744b6549ba0c04ae3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240916224630epcas5p42b355e2884c665e19d3c9c3a5afd428e
References: <CGME20240916224630epcas5p42b355e2884c665e19d3c9c3a5afd428e@epcas5p4.samsung.com>
	<20240916224543.187-1-selvarasu.g@samsung.com>
	<20240916230032.ugw23x7gijamrf5x@synopsys.com>
	<2024091716-snide-mashing-2c21@gregkh>
	<20240917054703.w47rfo7x4lhzgccn@synopsys.com>
	<2024091758-devotion-clutter-29f6@gregkh>


On 9/17/2024 12:38 PM, gregkh@linuxfoundation.org wrote:
> On Tue, Sep 17, 2024 at 05:47:05AM +0000, Thinh Nguyen wrote:
>> On Tue, Sep 17, 2024, gregkh@linuxfoundation.org wrote:
>>> On Mon, Sep 16, 2024 at 11:00:30PM +0000, Thinh Nguyen wrote:
>>>> On Tue, Sep 17, 2024, Selvarasu Ganesan wrote:
>>>>> This commit addresses an issue where events were being processed when
>>>>> the controller was in a halted state. To fix this issue by stop
>>>>> processing the events as the event count was considered stale or
>>>>> invalid when the controller was halted.
>>>>>
>>>>> Fixes: fc8bb91bc83e ("usb: dwc3: implement runtime PM")
>>>>> Cc: stable <stable@kernel.org>
>>>> Checkpatch doesn't like that format. Fix the Cc stable tag to below:
>>>>
>>>> Cc: stable@kernel.org
>>> What?  Why?  That should be fine, exactly what is the warning that this
>>> gives?  That should be fine, as it's what my scripts put into patches
>>> that I create :)
>>>
>> This is what checkpatch complains:
>>
>> WARNING:BAD_STABLE_ADDRESS_STYLE: Invalid email format for stable: 'stable <stable@kernel.org>', prefer 'stable@kernel.org'
>> #23:
>> Cc: stable <stable@kernel.org>
>>
>> total: 0 errors, 1 warnings, 0 checks, 72 lines checked
> Ugh, that's wrong, whatever you want to do here is fine.
>
> Someone should send a patch for checkpatch...
>
> thanks,
>
> greg k-h

Hi Greg,

However I already posted new version with address a typo mistake as 
well. Kindly review the same.

https://lore.kernel.org/lkml/20240916231813.206-1-selvarasu.g@samsung.com/

Thanks,
Selva
>

