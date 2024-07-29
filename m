Return-Path: <linux-kernel+bounces-265649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E5993F406
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09340B21847
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7F1145B12;
	Mon, 29 Jul 2024 11:28:58 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDACB13DDAA
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252538; cv=none; b=Zw5gyvQeKCRkOjosB3NMcmFm8a+5T0qwiv0GS+PANUkDNFs10CfJk/uDUadmqHmg9aLRmJV73pObVwzssEFddWH7Q8t30bdxxHuO2e8lhJKojEBZS9lWL8MNlYDTVuDjSL6qMUNsMYOkULVXn/x2G6IMJapPKZ+MR2SAdTeDd0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252538; c=relaxed/simple;
	bh=jGZICm5Yh0dno5ciac0lyY4bvB6Z0hi6Yz9HtOgBPiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TNRbDC5qJoM0wVCYF5LB0/BMJUjyJB49QEIr5esOqZvu1rXoft3+kIrhR3SPMFcCpg3BQ9lqZazz81z8Muohmj3UhQS9pnLSXJGsJaikKOL5mPQsN37ofYAwkvYY7rOONd5zkFWLbjan25qKSl+/c9ZFC8F3udElgICam1um1pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WXbgv5hxKznbLP;
	Mon, 29 Jul 2024 19:27:55 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CF461800D0;
	Mon, 29 Jul 2024 19:28:52 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 19:28:51 +0800
Message-ID: <96aae430-1bbf-1274-d6d1-262e93b5fe7d@huawei.com>
Date: Mon, 29 Jul 2024 19:28:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v5] crash: Fix crash memory reserve exceed system memory
 bug
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
CC: <akpm@linux-foundation.org>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<rppt@kernel.org>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20240723020746.3945016-1-ruanjinjie@huawei.com>
 <Zp8859QW+YV1KqQ9@MiWiFi-R3L-srv>
 <564e362d-5e8c-5d23-9c54-bfb811794169@huawei.com>
 <ZqcMqsMo8SYVv4Tl@MiWiFi-R3L-srv>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ZqcMqsMo8SYVv4Tl@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/7/29 11:29, Baoquan He wrote:
> On 07/29/24 at 11:24am, Jinjie Ruan wrote:
>>
>>
>> On 2024/7/23 13:17, Baoquan He wrote:
>>> On 07/23/24 at 10:07am, Jinjie Ruan wrote:
>>>> On x86_32 Qemu machine with 1GB memory, the cmdline "crashkernel=4G" is ok
>>>> as below:
>>>> 	crashkernel reserved: 0x0000000020000000 - 0x0000000120000000 (4096 MB)
>>>>
>>>> It's similar on other architectures, such as ARM32 and RISCV32.
>>>>
>>>> The cause is that the crash_size is parsed and printed with "unsigned long
>>>> long" data type which is 8 bytes but allocated used with "phys_addr_t"
>>>> which is 4 bytes in memblock_phys_alloc_range().
>>>>
>>>> Fix it by checking if crash_size is greater than system RAM size and
>>>> return error if so.
>>>>
>>>> After this patch, there is no above confusing reserve success info.
>>>>
>>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>>> Suggested-by: Baoquan He <bhe@redhat.com>
>>>> Suggested-by: Mike Rapoport <rppt@kernel.org>
>>>
>>>
>>> My Suggested-by can be taken off because I suggested to check the parsed
>>> value after parse_crashkernel(), Mike's suggestion is better.
>>
>> Hi, Can the suggested-by be removed when this version is merged, or a
>> new version needs to be sent?
> 
> You can send a new one and CC Andrew.

Thank you!

> 
> 

