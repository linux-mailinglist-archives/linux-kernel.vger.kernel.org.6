Return-Path: <linux-kernel+bounces-369578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A019A1F16
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC2C1C2646B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BA91DA31F;
	Thu, 17 Oct 2024 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Tw4Q0Maa"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD07D189906
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158790; cv=none; b=n1zpRCLV0BST85sn9669eC+/S9VZFxbCpoxtt4Cy85CF8znU2ZnulrqMmpHupK25iBhGel5T9NE/L6ivJ2Fa7UjT4WTkBQiW2282LyAWOl5yH4+wwMhON3C0up6v5mX5u0NxZjkwpHgWej78aOHnjQN1YiPi9V3HocbIfKteMfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158790; c=relaxed/simple;
	bh=aSn1DxFgty9KFdXF4g7pB1H62zIx0oL6UUhV8GOdQXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LmnHEHq6WpNrBxttNn+PNUgfpC++vcjjqmP1X7mmxx4TqEO98TGbq7WilLhll0fIOXHtsCmYKyVSytMx281+T+slieV7qBxuI6SWRsSazMsJd/jzoFw+LweaqkF0HXZV4kcCI4uC285mkj8J1FHPz9wCgH/ZCQn+l3zPcbCuW1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Tw4Q0Maa; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729158779; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ofxGs6YeS3jUTLuk1L96YlB7Ior4G7eilHwR7pw/b9Q=;
	b=Tw4Q0Maaj2ycUxfTB1ZlZI1C4BFCc/osgJyLoLwQnbn+kUCmlHiuOoeT3deD18JeIfunadd6YXsC5L7I/2mhucSOa3bgAtBvdhhlIhHk4CwBjeuVfXK7IgnNG+k1VXc1Lu6d50YPqagkJSlj+r4Fb/IfRuRBgujE4rkRVf0QavM=
Received: from 30.74.144.140(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WHKPoqa_1729158776 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Oct 2024 17:52:58 +0800
Message-ID: <fba6d03c-950f-4c5b-a8f0-eb760a4e8795@linux.alibaba.com>
Date: Thu, 17 Oct 2024 17:52:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/4] Support large folios for tmpfs
To: Kefeng Wang <wangkefeng.wang@huawei.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, ioworker0@gmail.com, da.gomez@samsung.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
 <007880ac-d73f-4eef-9978-a4f844338522@huawei.com>
 <584662fb-cb1f-4b2c-9075-f70d31473c9d@linux.alibaba.com>
 <6457b1fa-9afd-4552-ae5b-3a0379bcc3e5@huawei.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <6457b1fa-9afd-4552-ae5b-3a0379bcc3e5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/16 21:45, Kefeng Wang wrote:
> 
> 
> On 2024/10/16 17:29, Baolin Wang wrote:
>>
>>
>> On 2024/10/16 15:49, Kefeng Wang wrote:
>>>
>>>
>>> On 2024/10/10 17:58, Baolin Wang wrote:
>>>> Hi,
>>>>
>>>> This RFC patch series attempts to support large folios for tmpfs.
>>>>
>>>> Considering that tmpfs already has the 'huge=' option to control the 
>>>> THP
>>>> allocation, it is necessary to maintain compatibility with the 'huge='
>>>> option, as well as considering the 'deny' and 'force' option controlled
>>>> by '/sys/kernel/mm/transparent_hugepage/shmem_enabled'.
>>>>
>>>> Add a new huge option 'write_size' to support large folio allocation 
>>>> based
>>>> on the write size for tmpfs write and fallocate paths. So the huge 
>>>> pages
>>>> allocation strategy for tmpfs is that, if the 'huge=' option
>>>> (huge=always/within_size/advise) is enabled or the 'shmem_enabled' 
>>>> option
>>>> is 'force', it need just allow PMD sized THP to keep backward 
>>>> compatibility
>>>> for tmpfs. While 'huge=' option is disabled (huge=never) or the 
>>>> 'shmem_enabled'
>>>> option is 'deny', it will still disable any large folio allocations. 
>>>> Only
>>>> when the 'huge=' option is 'write_size', it will allow allocating large
>>>> folios based on the write size.
>>>>
>>>> And I think the 'huge=write_size' option should be the default behavior
>>>> for tmpfs in future.
>>>
>>> Could we avoid new huge= option for tmpfs, maybe support other orders
>>> for both read/write/fallocate if mount with huge?
>>
>> Um, I am afraid not, as that would break the 'huge=' compatibility. 
>> That is to say, users still want PMD-sized huge pages if 'huge=always'.
> 
> Yes, compatibility maybe an issue, but only write/fallocate side support
> large folio is a little strange, maybe a new mode to support both read/
> write/fallocate?

Because tmpfs read() will not allocate folios for tmpfs holes, and will 
use ZERO_PAGE instead. If the shmem folios are swapped out, and now we 
will always swapin base page, which is another story...

For tmpfs mmap() read, we do not have a length to indicate how large the 
folio should be allocated. Moreover, we have decided against adding any 
mTHP interfaces for tmpfs in the previous discussion[1].

[1] https://lore.kernel.org/all/ZvVRiJYfaXD645Nh@casper.infradead.org/

