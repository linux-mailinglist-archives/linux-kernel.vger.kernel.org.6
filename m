Return-Path: <linux-kernel+bounces-180925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B312A8C74F0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A95F1F23B5F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D4D145352;
	Thu, 16 May 2024 10:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OpWVdIwJ"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BFB143747
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715857088; cv=none; b=ebS+ETxmwIDsI1zJnvJZez8+rTqkOlY8abs4Q1LSz21lau/sif1IGeZs6mA0OK2JsTqFkqsEqIgOTUx+dF2267Z79dAlpb1jNbjpMeuEoF8uVc9c2uuBr4HaHzgdW0RUhTKuMqu6Aj6s4jZvrif7mBGs5ddwBwL3gKyDJGjl9p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715857088; c=relaxed/simple;
	bh=14XKAqGJJ7efuAKjdOGKIrcSj/dQ64odSwJbyfxAhjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=rM+DMmHzL+MG5vj41XXf/4sX+zx6u34ZV8KK/SmFwiexitEq4xYpwyAtg0B/AmadAzoGjYXb1v1TaDZxQNKXG36I3RbxlcJwJpoxyS3BxHwbhxy7GOCvnjbXXlssbsH1ZVplv01syNnpIzkWJX1H6/2DZ6CIwZCcQKMMOjLqFwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OpWVdIwJ; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240516105755euoutp0267b6a49b97d3d1f901340e3212ab7a43~P8us6ztCQ2689526895euoutp02D
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:57:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240516105755euoutp0267b6a49b97d3d1f901340e3212ab7a43~P8us6ztCQ2689526895euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1715857075;
	bh=AzsFVgT9ZtACfhnjkNzCBMnfOWVmsAJhweMEuyRHJwk=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=OpWVdIwJFLqtMY3OmhJQ7w9tJIUFY5ZhXiWudFtjcVDyMQdpIWFFuy59b04SHBWh0
	 FhpPWRfheAPSWIoNWc164Mn4WH2HSh2WLx25YtMvdQgxDHuitfEl2TPDENeVaTD28h
	 pyN1ioWu5mI+wZ3AApbnwsi61pBVTOTGtbZZBj0A=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240516105754eucas1p14aafa43dc59b01537ccdb54aea7c98c6~P8usjh2yv0654806548eucas1p1R;
	Thu, 16 May 2024 10:57:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 19.31.09620.2B6E5466; Thu, 16
	May 2024 11:57:54 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240516105754eucas1p29073691f41788465de22d59008b95932~P8usGPH5T1610316103eucas1p21;
	Thu, 16 May 2024 10:57:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240516105754eusmtrp2d0427052643d706bbe2dcc5712ec3586~P8usE_r9h1817218172eusmtrp2J;
	Thu, 16 May 2024 10:57:54 +0000 (GMT)
X-AuditID: cbfec7f5-d31ff70000002594-cc-6645e6b22a39
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 8E.3D.08810.2B6E5466; Thu, 16
	May 2024 11:57:54 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240516105753eusmtip1c6ced12055351978f721781ff4dd75e1~P8urc3BYk0913809138eusmtip19;
	Thu, 16 May 2024 10:57:53 +0000 (GMT)
Message-ID: <29f30eda-deba-4092-9b4c-8cb101b8691d@samsung.com>
Date: Thu, 16 May 2024 12:57:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: clkdev: report over-sized strings when creating clkdev entries
To: Naresh Kamboju <naresh.kamboju@linaro.org>, "Russell King (Oracle)"
	<linux@armlinux.org.uk>
Cc: Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux
	ARM <linux-arm-kernel@lists.infradead.org>, linux-clk
	<linux-clk@vger.kernel.org>, lkft-triage@lists.linaro.org, open list
	<linux-kernel@vger.kernel.org>, Anders Roxell <anders.roxell@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>, Michael Turquette
	<mturquette@baylibre.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CA+G9fYurPNaW=u2E+h+segnXhY3cfWo3BJpfYDJxKRFPY4epsQ@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsWy7djPc7qbnrmmGeyYrm5xa8pvJou/k46x
	W3yY18pusenxNVaLjz33WC0u75rDZnFo6l5Gi633prFbXDzlanHrE7/Fv2sbWRy4PS5fu8js
	8fvXJEaP9zda2T02repk87hzbQ+bx+Yl9R63/z1m9vi8SS6AI4rLJiU1J7MstUjfLoErY+KX
	SYwFnQIV14/8Y2lg3MXbxcjJISFgItGzqZW5i5GLQ0hgBaPEuVlL2CGcL4wSHS9PsEI4nxkl
	LjbuZYZpedv0FKpqOVDVtDmMEM5HRolFh+aAVfEK2Emsn7+aFcRmEVCV+PVyOhNEXFDi5Mwn
	LCC2qIC8xP1bM9hBbGEBb4m+e71gvSICiRKPV/0E28As8I5J4vynHrAGZgFxiVtP5oMNYhMw
	lOh628UGYnMKBEr8ftrJBFEjL7H97RywjyQEujkljl09yQRxt4vEotdvoGxhiVfHt7BD2DIS
	/3eCDAVpaGeUWPD7PpQzgVGi4fktRogqa4k7534BreMAWqEpsX6XPkTYUeLX/y52kLCEAJ/E
	jbeCEEfwSUzaNp0ZIswr0dEmBFGtJjHr+Dq4tQcvXGKewKg0CylcZiF5cxaSd2Yh7F3AyLKK
	UTy1tDg3PbXYOC+1XK84Mbe4NC9dLzk/dxMjMJGd/nf86w7GFa8+6h1iZOJgPMQowcGsJMIr
	kuacJsSbklhZlVqUH19UmpNafIhRmoNFSZxXNUU+VUggPbEkNTs1tSC1CCbLxMEp1cBU8uev
	/OcrSysP72zJmjNjWiLvl1/cfsUuX51Kkz5ov7FfnHQhTuWf6qyMKwyHHjb6M//89JSL70/K
	50d7ri8ydbl2n3Vnu93SFR7l7D/bxYs+z7/rI2D69Zn0uwwLvycKk/L/CDGtObj10h+3mRdD
	3n1bEOHGeoJ/mkL4jNdpd8JXBd5WWHoye6KmxdFPH9kYEn443JV83PngZt2On4zfdLU1vYVW
	JP1evfH2tkXbNH64XMvb9CZTOlRFIGfTt64Fj+uS2X+pfZ+xJ+YzE6/BTrYu0ZOTqvcvP3jF
	hNEw2H3zl/iY0A9LPZqta5g8tQMWiIYEBoVIxTha3Co8wBNaasXN/Xuu34aEmu62w4ouSizF
	GYmGWsxFxYkAdX0GNdMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsVy+t/xu7qbnrmmGezYzmlxa8pvJou/k46x
	W3yY18pusenxNVaLjz33WC0u75rDZnFo6l5Gi633prFbXDzlanHrE7/Fv2sbWRy4PS5fu8js
	8fvXJEaP9zda2T02repk87hzbQ+bx+Yl9R63/z1m9vi8SS6AI0rPpii/tCRVISO/uMRWKdrQ
	wkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvY+KXSYwFnQIV14/8Y2lg3MXbxcjJ
	ISFgIvG26Sl7FyMXh5DAUkaJr983sUIkZCROTmuAsoUl/lzrYoMoes8ocafvLRNIglfATmL9
	/NVgRSwCqhK/Xk6HigtKnJz5hAXEFhWQl7h/awY7iC0s4C3Rd6+XuYuRg0NEIFHi138TkDCz
	wAcmiU/XNCDmtzFL3H/QyQiREJe49WQ+2Ew2AUOJrrcgR3BycAoESvx+2skEUWMm0bW1C6pe
	XmL72znMExiFZiE5YxaSUbOQtMxC0rKAkWUVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYNRu
	O/Zz8w7Gea8+6h1iZOJgPMQowcGsJMIrkuacJsSbklhZlVqUH19UmpNafIjRFBgWE5mlRJPz
	gWkjryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qBSXTqUj+R7H89
	i7ysjqmdffCJ3cQ6XctzeaLSxQqB71bt64zf+z/efMHP4s2UO6vzEw2YdPW/PnodnbpOafVB
	sfz8OdlZHAbm8i8OMwokLX3+tu1UwMIo4z0J/bsaP+qbeqR8t11vGG47aVfn8VfX3Q5HpH14
	6dYxuze7Vt05odF5lc7WwOclrHvc4vcsZPRlL3NhscldVxNwuTlznVi1vr/qoVMTzndUu5mu
	MvkYX8c5Ya7fjU9X1MT7Jv/XPrRu24S+MPvHJ66Yv+ktjmq6YXv+2LuoRVOfll6cXR79tNY+
	T+aFQoj51QVsbPoX43ZdZJK7/6w/29zkO8eSNVYfN35bLV1QN8Xyj9t/v+W/lViKMxINtZiL
	ihMB9h02VmMDAAA=
X-CMS-MailID: 20240516105754eucas1p29073691f41788465de22d59008b95932
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240516102738eucas1p2eee547d4b78c347308b0979fa98ede39
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240516102738eucas1p2eee547d4b78c347308b0979fa98ede39
References: <CA+G9fYuZd_ur56H8fwDSvUywopvn_b7ogprGkjEatQ7EPTLwYQ@mail.gmail.com>
	<11be44d3-0f32-49c6-b4ae-ba97a9f97763@app.fastmail.com>
	<820ddc2ec70780ae1ecd3af864dc8bd6.sboyd@kernel.org>
	<ZkUgqzUn1EmjrPdl@shell.armlinux.org.uk>
	<CGME20240516102738eucas1p2eee547d4b78c347308b0979fa98ede39@eucas1p2.samsung.com>
	<CA+G9fYurPNaW=u2E+h+segnXhY3cfWo3BJpfYDJxKRFPY4epsQ@mail.gmail.com>

On 16.05.2024 12:27, Naresh Kamboju wrote:
> On Wed, 15 May 2024 at 22:53, Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
>> On Tue, May 07, 2024 at 01:26:17PM -0700, Stephen Boyd wrote:
>>> Quoting Arnd Bergmann (2024-05-07 00:44:15)
>>>> On Tue, May 7, 2024, at 09:20, Naresh Kamboju wrote:
>>>>> The WinLink E850-96 board boot failed with Linux next-20240506 but there
>>>>> is no kernel crash log on the serial [1].
>>>>>
>>>>> Anders bisection results pointing to this commit,
>>>>> # first bad commit:
>>>>>    [4d11c62ca8d77cb1f79054844b598e0f4e92dabe]
>>>>>    clkdev: report over-sized strings when creating clkdev entrie
>>>>>
>>>>> After reverting the above patch the boot test passed [2].
>>>>>
>>>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>>>
>>> There are two fixes on the list: [1] and [2]. Perhaps one of those
>>> resolves this?
>>>
>>> [1] https://lore.kernel.org/r/20240507065317.3214186-1-m.szyprowski@samsung.com
>> This one has (I think) ended up in the patch system last week, but it's
>> not clkdev, it's only related. I'm also not Cc'd on its posting, and
>> it's not posted to any mailing list that I'm a part of. So I've not
>> been following any discussion on it.
>>
>> Digging in to the discussion, I see various attributations, and a final
>> message reporting an unused variable, and a promise to send v2. So,
>> I'm guessing that
>> https://protect2.fireeye.com/v1/url?k=946226d9-f5e933ef-9463ad96-74fe485fffe0-28286a0026513387&q=1&e=a16c1c53-9c99-475a-b144-8adf7852ebc0&u=http%3A%2F%2Fwww.home.armlinux.org.uk%2Fdeveloper%2Fpatches%2Fviewpatch.php%3Fid%3D9397%2F1
> I do not have access to this link ^.
>
>> is now superseded in some way... I wouldn't have known without locating
>> this email and checking the links.


The fix for drivers/clk/samsung/clk.c driver has been merged to clk-next:

https://lore.kernel.org/all/f7a877622829db499bf2bc65fe9ffbff.sboyd@kernel.org/

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


