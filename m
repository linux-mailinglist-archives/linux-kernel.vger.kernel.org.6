Return-Path: <linux-kernel+bounces-246861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8723C92C81C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42CAB283FBF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EE18494;
	Wed, 10 Jul 2024 01:52:29 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376575680
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720576349; cv=none; b=ZyXU2jDDYdCVnUUcspvvYacGlMS0x5687qYFke3BFwbHe6+bIosPbLwFwO1ek84CsSWeHtJSc6kIyEl5tYdRGZCvdnV2iHSdv1qGFAN1OQdSPB8H/pMsiYPjO3D+6EuuMB/sTd/G0PXmFisE+oLebtIdF2zbbNODgZPZzc6Rh5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720576349; c=relaxed/simple;
	bh=X0N1ckPfY/0i/XhUaQRWRLGjjaii9zD/8Jp3XwijEoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C+mLs43rV5+jm9Tqq/oI7gExAS3+hUjh3DqkaKgK6fjW1U40szCvQoTRPxsDg9dHvUjuF7Z+f5idsj6dQ293Bg/ek/U9gdwFy1We3ZM4UmsdRbwRi9SPxpgCOKSLgepgVfKyYBwW/RYec+MMpIhoDE9FQ+sbk2oi5tz2d3KpRQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WJgj91sZvzwWCq;
	Wed, 10 Jul 2024 09:47:41 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 726A2180088;
	Wed, 10 Jul 2024 09:52:23 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 10 Jul 2024 09:52:22 +0800
Message-ID: <8aed5c59-090b-ea7e-020c-dd2785ee3d7e@huawei.com>
Date: Wed, 10 Jul 2024 09:52:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 0/3] ARM: Use generic interface to simplify crashkernel
 reservation
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
CC: <linux@armlinux.org.uk>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<arnd@arndb.de>, <afd@ti.com>, <akpm@linux-foundation.org>,
	<rmk+kernel@armlinux.org.uk>, <linus.walleij@linaro.org>,
	<eric.devolder@oracle.com>, <gregkh@linuxfoundation.org>, <deller@gmx.de>,
	<javierm@redhat.com>, <robh@kernel.org>, <thunder.leizhen@huawei.com>,
	<austindh.kim@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>
References: <20240708133348.3592667-1-ruanjinjie@huawei.com>
 <Zo0DCVXvCryDr7WN@MiWiFi-R3L-srv>
 <3157befe-431f-69ac-b9d3-7a8685ba3a4d@huawei.com>
 <Zo0TbmSnHbiz5YQn@MiWiFi-R3L-srv>
 <01869981-b1de-32cb-bd25-d6ea09752b3d@huawei.com>
 <Zo1D9sB0UTOIrApP@MiWiFi-R3L-srv>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <Zo1D9sB0UTOIrApP@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/7/9 22:06, Baoquan He wrote:
> On 07/09/24 at 07:06pm, Jinjie Ruan wrote:
>>
>>
>> On 2024/7/9 18:39, Baoquan He wrote:
>>> On 07/09/24 at 05:50pm, Jinjie Ruan wrote:
>>>>
>>>>
>>>> On 2024/7/9 17:29, Baoquan He wrote:
>>>>> On 07/08/24 at 09:33pm, Jinjie Ruan wrote:
>>>>>> Currently, x86, arm64, riscv and loongarch has been switched to generic
>>>>>> crashkernel reservation. Also use generic interface to simplify crashkernel
>>>>>> reservation for arm32, and fix two bugs by the way.
>>>>>
>>>>> I am not sure if this is a good idea. I added the generic reservation
>>>>> itnerfaces for ARCH which support crashkernel=,high|low and normal
>>>>> crashkernel reservation, with this, the code can be simplified a lot.
>>>>> However, arm32 doesn't support crashkernel=,high, I am not sure if it's
>>>>> worth taking the change, most importantly, if it will cause
>>>>> misunderstanding or misoperation.
>>>>
>>>> Yes, arm32 doesn't support crashkernel=,high.
>>>>
>>>> However, a little enhancement to the generic code (please see the first
>>>> patch), the generic reservation interfaces can also be applicable to
>>>> architectures that do not support "high" such as arm32, and it can also
>>>> simplify the code (please see the third patch).
>>>
>>> Yeah, I can see the code is simplified. When you specified
>>> 'crashkernel=xM,high', do you think what should be warn out? Because
>>> it's an unsupported syntax on arm32, we should do something to print out
>>> appropriate message.
>>
>> Yes, you are right! In this patch it will print "crashkernel high memory
>> reservation failed." message and out for arm32 if you specify
> 
> That message may mislead people to believe crashkernel=,high is
> supported but reservation is failed, then a bug need be filed for this?
> We may expect a message telling this syntax is not supported on this
> ARCH.

"CRASH_ADDR_LOW_MAX >= CRASH_ADDR_HIGH_MAX" indicate that the arm32 does
not support "crashkernel=,high", I wonder if this is generic for similar
architecture. If so, the first patch can print such as
"crashkernel=,high is not supported on this ARCH" message.

> 
>> 'crashkernel=xM,high because "CRASH_ADDR_LOW_MAX" and
>> "CRASH_ADDR_HIGH_MAX" is identical for arm32. And it should also warn
>> out for other similar architecture.
>>
>>
>>>
>>>
>>
> 
> 

