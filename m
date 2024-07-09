Return-Path: <linux-kernel+bounces-245690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B4E92B628
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB390284C3E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EEF158201;
	Tue,  9 Jul 2024 11:06:18 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFD115746B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 11:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523177; cv=none; b=etk53nQ0on3vcMekLkN/fn8/5qBEi9SqWLvaKg8Rp7RvJksgdxP+4QKoiA7AHaV9UHe+sh2LzV1LUXaF/xDdQCn+JF6B8Psu88k4/lWN0Rn61Cor1bQgGVl4PWl2sJnimT6kVoKMYqQkbc2Sjkpbs+nkec/eJf4deKc0lheVIzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523177; c=relaxed/simple;
	bh=iin81viQ24XB3tAi7OE5LW9AH/E/YBNNetWrIcuUAfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L/6+tPwQhW6EWFPeyUzg/EVMaWHeENSnqFaKP6h+49eIdjbFXJdC5GnurGoUI1vXhny69EoyeTxKfsT9Vz7INErgZKyeMRLO9voqWK9HqhQ5i+MD0USdNDBHwGtwRUmQzUhBjv1InI8ndXIpl4S+aUG7nQsFCACNegtEtWAuuQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WJJ7Y6nVDzcpHh;
	Tue,  9 Jul 2024 19:05:45 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id EA4E31400D1;
	Tue,  9 Jul 2024 19:06:11 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 19:06:10 +0800
Message-ID: <01869981-b1de-32cb-bd25-d6ea09752b3d@huawei.com>
Date: Tue, 9 Jul 2024 19:06:09 +0800
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
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <Zo0TbmSnHbiz5YQn@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/7/9 18:39, Baoquan He wrote:
> On 07/09/24 at 05:50pm, Jinjie Ruan wrote:
>>
>>
>> On 2024/7/9 17:29, Baoquan He wrote:
>>> On 07/08/24 at 09:33pm, Jinjie Ruan wrote:
>>>> Currently, x86, arm64, riscv and loongarch has been switched to generic
>>>> crashkernel reservation. Also use generic interface to simplify crashkernel
>>>> reservation for arm32, and fix two bugs by the way.
>>>
>>> I am not sure if this is a good idea. I added the generic reservation
>>> itnerfaces for ARCH which support crashkernel=,high|low and normal
>>> crashkernel reservation, with this, the code can be simplified a lot.
>>> However, arm32 doesn't support crashkernel=,high, I am not sure if it's
>>> worth taking the change, most importantly, if it will cause
>>> misunderstanding or misoperation.
>>
>> Yes, arm32 doesn't support crashkernel=,high.
>>
>> However, a little enhancement to the generic code (please see the first
>> patch), the generic reservation interfaces can also be applicable to
>> architectures that do not support "high" such as arm32, and it can also
>> simplify the code (please see the third patch).
> 
> Yeah, I can see the code is simplified. When you specified
> 'crashkernel=xM,high', do you think what should be warn out? Because
> it's an unsupported syntax on arm32, we should do something to print out
> appropriate message.

Yes, you are right! In this patch it will print "crashkernel high memory
reservation failed." message and out for arm32 if you specify
'crashkernel=xM,high because "CRASH_ADDR_LOW_MAX" and
"CRASH_ADDR_HIGH_MAX" is identical for arm32. And it should also warn
out for other similar architecture.


> 
> 

