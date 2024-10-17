Return-Path: <linux-kernel+bounces-369085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8502B9A18BF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 04:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 488A728469C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DE922075;
	Thu, 17 Oct 2024 02:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oSFafYbb"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F41101F2
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729133204; cv=none; b=U/VDAg2A+fggfdLNmnNA0DH8OzEABTW9F1mTDXtY1jOegioNkdOPu8JWrpH5ShQD+LVLMKjwoeT4PHPcQNCSTLHKLU/9e4CxlNxErVXxYJd3w3QU6T1V0aiqYn+4RnNFYBQDsNaJ/N4+A/7PDsTQdkZgF8R6gCSvpTnFqLfsgS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729133204; c=relaxed/simple;
	bh=Y1aLW//kXJU+euZFR6EvbEJ2wrpGngY+V1+LGhYM9nM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KIaUmW5yq8r7etCry3sn3bde/rpunsEmZMWASejRYVaa5UTCp49kpRsJqVFHBI8XDYgnYX47BjJh+/ybfco38d6mDUyJsj8PqZN4CPXT4juO4xFxYY0860ahf8ML1KZrbqMEebBs2rtBP/f1duVVcO71fkX9blYdA6jRp03a6pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oSFafYbb; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729133193; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zuoMwQP84WOT3tANGdBEYdnawZrJ+4mRxBerCGeVXmQ=;
	b=oSFafYbb7GK4l6eBgYlsMQ5aJAfUjPkwrb+OC4LPc/DyDpeC7dj2prLMQPejZBjT0RVrpTX5qUb11NDJ8KoroWrRRSf3lmhOGt4+jh79ieHSm8SO5eYjmC0d9u1XAv43sQn+vxpQlW32AbifGlbKJhzJ7xn8Xus99RzdNwCY+4U=
Received: from 30.74.144.140(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WHJ713d_1729133192 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Oct 2024 10:46:33 +0800
Message-ID: <254f1c38-b2ce-4c83-a13d-54e7c0271dcb@linux.alibaba.com>
Date: Thu, 17 Oct 2024 10:46:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: shmem: improve the tmpfs large folio read
 performance
To: Kefeng Wang <wangkefeng.wang@huawei.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1729072803.git.baolin.wang@linux.alibaba.com>
 <df801bca5026c4b06cb843b9366fba21f0d45981.1729072803.git.baolin.wang@linux.alibaba.com>
 <1cb50014-8678-40de-bca3-8a33555ec70e@huawei.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <1cb50014-8678-40de-bca3-8a33555ec70e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/10/16 20:36, Kefeng Wang wrote:
> 
> 
> On 2024/10/16 18:09, Baolin Wang wrote:
>> The tmpfs has already supported the PMD-sized large folios, but the tmpfs
>> read operation still performs copying at the PAGE SIZE granularity, which
>> is unreasonable. This patch changes to copy data at the folio 
>> granularity,
>> which can improve the read performance, as well as changing to use folio
>> related functions.
>>
>> Use 'fio bs=64k' to read a 1G tmpfs file populated with 2M THPs, and I 
>> can
>> see about 20% performance improvement, and no regression with bs=4k.
>> Before the patch:
>> READ: bw=10.0GiB/s
>>
>> After the patch:
>> READ: bw=12.0GiB/s
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/shmem.c | 22 ++++++++++++----------
>>   1 file changed, 12 insertions(+), 10 deletions(-)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index edab02a26aac..7e79b6a96da0 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -3108,13 +3108,12 @@ static ssize_t shmem_file_read_iter(struct 
>> kiocb *iocb, struct iov_iter *to)
>>       ssize_t retval = 0;
>>       index = iocb->ki_pos >> PAGE_SHIFT;
>> -    offset = iocb->ki_pos & ~PAGE_MASK;
>>       for (;;) {
>>           struct folio *folio = NULL;
>> -        struct page *page = NULL;
>>           unsigned long nr, ret;
>>           loff_t end_offset, i_size = i_size_read(inode);
>> +        size_t fsize;
>>           if (unlikely(iocb->ki_pos >= i_size))
>>               break;
>> @@ -3128,8 +3127,9 @@ static ssize_t shmem_file_read_iter(struct kiocb 
>> *iocb, struct iov_iter *to)
>>           if (folio) {
>>               folio_unlock(folio);
>> -            page = folio_file_page(folio, index);
>> -            if (PageHWPoison(page)) {
>> +            if (folio_test_hwpoison(folio) ||
>> +                (folio_test_large(folio) &&
>> +                 folio_test_has_hwpoisoned(folio))) {
>>                   folio_put(folio);
>>                   error = -EIO;
>>                   break;
>> @@ -3147,7 +3147,12 @@ static ssize_t shmem_file_read_iter(struct 
>> kiocb *iocb, struct iov_iter *to)
>>               break;
>>           }
>>           end_offset = min_t(loff_t, i_size, iocb->ki_pos + to->count);
>> -        nr = min_t(loff_t, end_offset - iocb->ki_pos, PAGE_SIZE - 
>> offset);
>> +        if (folio)
>> +            fsize = folio_size(folio);
>> +        else
>> +            fsize = PAGE_SIZE;
>> +        offset = iocb->ki_pos & (fsize - 1);
>> +        nr = min_t(loff_t, end_offset - iocb->ki_pos, fsize - offset);
>>           if (folio) {
>>               /*
>> @@ -3156,7 +3161,7 @@ static ssize_t shmem_file_read_iter(struct kiocb 
>> *iocb, struct iov_iter *to)
>>                * before reading the page on the kernel side.
>>                */
> 
> We'd better to update all the comment from page to folio.

Ack.

