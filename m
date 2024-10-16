Return-Path: <linux-kernel+bounces-368142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BED9A0BCE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BDDF1F24229
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC305208209;
	Wed, 16 Oct 2024 13:45:38 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1754E524B4
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729086338; cv=none; b=UwXJNOWLdjJnRsSwLR6q6giEk1sXfvhyQUQZL8t5MDOdEkChEJYs66GvNOjIso+2goCJKXZN0EyKy8HTsrhz5l14YzGviSPyBG7iu8xQm68opcsFK7q2notJjBAR17Te+a8OzEkfop8xVdvdK84xtoV3ErEJeb9jJ3p2SVq8l50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729086338; c=relaxed/simple;
	bh=mVNtxpGX0BU6BkcgeLmDnZouvF44w9LmQQ2xF50LKZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SAtS2GOFEsBUYKhTqF67IUFdlNlj4TGZSzvLr/OC0vEDlaF8v6yuDFMyjBPTZ/KdVX2jzpa4wxveWeXdiIm/tDRL9MsalV5sUonLJSv6pKToAbRgzsdCXvyt4Psjxbdf/agpg9PwNndczcZWpFDyhpELSJiuhMrMJx/qoMyEQTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XTBxw3ZtZz18N5p;
	Wed, 16 Oct 2024 21:43:32 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B1071401E0;
	Wed, 16 Oct 2024 21:45:25 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 16 Oct 2024 21:45:24 +0800
Message-ID: <6457b1fa-9afd-4552-ae5b-3a0379bcc3e5@huawei.com>
Date: Wed, 16 Oct 2024 21:45:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/4] Support large folios for tmpfs
To: Baolin Wang <baolin.wang@linux.alibaba.com>, <akpm@linux-foundation.org>,
	<hughd@google.com>
CC: <willy@infradead.org>, <david@redhat.com>, <21cnbao@gmail.com>,
	<ryan.roberts@arm.com>, <ioworker0@gmail.com>, <da.gomez@samsung.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
 <007880ac-d73f-4eef-9978-a4f844338522@huawei.com>
 <584662fb-cb1f-4b2c-9075-f70d31473c9d@linux.alibaba.com>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <584662fb-cb1f-4b2c-9075-f70d31473c9d@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/10/16 17:29, Baolin Wang wrote:
> 
> 
> On 2024/10/16 15:49, Kefeng Wang wrote:
>>
>>
>> On 2024/10/10 17:58, Baolin Wang wrote:
>>> Hi,
>>>
>>> This RFC patch series attempts to support large folios for tmpfs.
>>>
>>> Considering that tmpfs already has the 'huge=' option to control the THP
>>> allocation, it is necessary to maintain compatibility with the 'huge='
>>> option, as well as considering the 'deny' and 'force' option controlled
>>> by '/sys/kernel/mm/transparent_hugepage/shmem_enabled'.
>>>
>>> Add a new huge option 'write_size' to support large folio allocation 
>>> based
>>> on the write size for tmpfs write and fallocate paths. So the huge pages
>>> allocation strategy for tmpfs is that, if the 'huge=' option
>>> (huge=always/within_size/advise) is enabled or the 'shmem_enabled' 
>>> option
>>> is 'force', it need just allow PMD sized THP to keep backward 
>>> compatibility
>>> for tmpfs. While 'huge=' option is disabled (huge=never) or the 
>>> 'shmem_enabled'
>>> option is 'deny', it will still disable any large folio allocations. 
>>> Only
>>> when the 'huge=' option is 'write_size', it will allow allocating large
>>> folios based on the write size.
>>>
>>> And I think the 'huge=write_size' option should be the default behavior
>>> for tmpfs in future.
>>
>> Could we avoid new huge= option for tmpfs, maybe support other orders
>> for both read/write/fallocate if mount with huge?
> 
> Um, I am afraid not, as that would break the 'huge=' compatibility. That 
> is to say, users still want PMD-sized huge pages if 'huge=always'.

Yes, compatibility maybe an issue, but only write/fallocate side support
large folio is a little strange, maybe a new mode to support both read/
write/fallocate?

