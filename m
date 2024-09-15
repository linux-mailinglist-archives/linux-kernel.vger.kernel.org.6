Return-Path: <linux-kernel+bounces-329897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B1097973B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 16:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9555D282700
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 14:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9C01C6F53;
	Sun, 15 Sep 2024 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="oMN3SUW1"
Received: from ci74p00im-qukt09090302.me.com (ci74p00im-qukt09090302.me.com [17.57.156.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84221EB31
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726411013; cv=none; b=VjZJmUDlr3AkbNy3oTflh2bzybzTBaAork0lqd/f1fZhAk6tdSRqAAUhAqwhRT4YzT1DwVHR1QPF/RwD8st7GyqjAShI4dzqyqwdN4sRn8+AEgNBOBSP1yiVkqYGNss8ri3AyeY80ErWC8r+flFltIqJ2fYurMXzGJ02CtxTwUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726411013; c=relaxed/simple;
	bh=wj2pmhXTeqqH+P7nAES7vhM923fqTcNAvawf49E0mEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hIrfH2AWI30nrBLR51Hli5nECZfWJRk3g6Ok6MH+Vcz1abbN0Wu+IrDrQI5RivJwmhGzou9CMUwJHRLXny+GDBjMscqb/frEmSGOF1KbZQT/hq4KDSooUW1zcqvEZnON+L2mumyDnMvLaEs19hqW4g7A3LcWSOBSJCQkNc8I4Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=oMN3SUW1; arc=none smtp.client-ip=17.57.156.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1726411010;
	bh=9HFTlBlbkQp/3070DYW8Jut6fR1McfS3daxGKCDsDUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=oMN3SUW1NWzF8KvvBuQQfrvsyy88Fgk7ZmuctU7HR3TDPZ0iyz7PSlbO+oCGs0vaL
	 pmowihwClFs3lEsoxFOAydfFnh017tcTotchsAWAGauvhKPIxJblkx2AXvqgYANV9d
	 Ro9+YqmuBUh270PpJy80Gtme5qreAPgKUezwghUHnkYuDxG/RdmEAU+V1+G/3K66V6
	 KgrZL+zBBDzLvaW73Sh2tEw5v/nLvXVObf28A7eCmkaYoJfgDTBc/cGQUspcHrmBKh
	 nk0izcbx0R6M1Vtbji1JRJIvmuivgBBj319vA6mK4VVTvX3Qj0i6spYmjGDt+bjwp1
	 /VrOqSV87RfvA==
Received: from [192.168.1.26] (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09090302.me.com (Postfix) with ESMTPSA id 72F0C5BC03DE;
	Sun, 15 Sep 2024 14:36:48 +0000 (UTC)
Message-ID: <506644dc-4ca2-4284-a557-eb0ef4bf36bd@icloud.com>
Date: Sun, 15 Sep 2024 22:36:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: bus: Mark an impossible error path with
 WARN_ON() in bus_add_driver()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240915-bus_add_driver_fix-v1-1-ce5cf1f66601@quicinc.com>
 <2024091530-antacid-magical-8302@gregkh>
 <8620a8a6-9101-4f53-858f-2e09aa310d16@icloud.com>
 <2024091540-scrubber-navigator-4aae@gregkh>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2024091540-scrubber-navigator-4aae@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: VVorR_8QU6fXZokKfb_5bcoQc-djjpGi
X-Proofpoint-ORIG-GUID: VVorR_8QU6fXZokKfb_5bcoQc-djjpGi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-15_06,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409150111

On 2024/9/15 21:55, Greg Kroah-Hartman wrote:
> On Sun, Sep 15, 2024 at 09:38:15PM +0800, Zijun Hu wrote:
>> On 2024/9/15 21:00, Greg Kroah-Hartman wrote:
>>> On Sun, Sep 15, 2024 at 06:22:05PM +0800, Zijun Hu wrote:
>>>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>
>>>> driver_attach() called by bus_add_driver() always returns 0, so its
>>>> corresponding error path will never happen, hence mark the impossible
>>>> error path with WARN_ON() to remind readers to disregard it.
>>>
>>> So you just caused the machine to crash and reboot if that happens
>>> (remember, panic-on-warn is enabled in a few billion Linux systems...)
>>>
>> are there good way to mark a if condition which is always or mostly
>> evaluated to false currently without any side effect?
> 
> If always, then remove the code involved.  If mostly, just do it
> normally.
> 
>> i think this is a generic requirement since readers may not want to
>> care about things which will never or rarely happen, below link
>> involves such discussion:
>> https://lore.kernel.org/all/2024090444-earmark-showpiece-b3dc@gregkh/
> 
> Yes, but likely/unlikely is for performance, not for documentation.

if you git grep unlikely in current kernel tree, you will find
that there are too many unlikely usages which should be irrelevant
performance. you maybe look at drivers/base/devres.c.

so i think one of purpose of unlikely may be for the requirement i
mentioned.

> 
>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>> ---
>>>>  drivers/base/bus.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
>>>> index 657c93c38b0d..59a48edda267 100644
>>>> --- a/drivers/base/bus.c
>>>> +++ b/drivers/base/bus.c
>>>> @@ -673,7 +673,7 @@ int bus_add_driver(struct device_driver *drv)
>>>>  	klist_add_tail(&priv->knode_bus, &sp->klist_drivers);
>>>>  	if (sp->drivers_autoprobe) {
>>>>  		error = driver_attach(drv);
>>>> -		if (error)
>>>> +		if (WARN_ON(error))
>>>
>>> What exactly are you trying to show here?  If this really can never
>>> fail, then let's just remove the check entirely.
>>>
>> what i want to show is that this error patch will never happen here
>> currently, so readers can disregard it.
> 
> Then just remove it, and document in the changelog text why it can never
> happen.  But if it can never happen, then why is the function returning
> anything at all?
> 
> thanks,
> 
> greg k-h


