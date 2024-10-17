Return-Path: <linux-kernel+bounces-369084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 250219A18BE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 04:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1601F2759C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CDA4084C;
	Thu, 17 Oct 2024 02:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hO5EoDT0"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CCB101F2
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729133168; cv=none; b=CWuuSoaqNafJkPUWpBt4Rh8ILQesXdI1tQNh0DHHjI1hMQcSt//ggDCcaBsliWCXlGJHzaUT2rOEjlCvq/F5oJGcBdjxtTnfzpWNWeC/u+MeXC8r6hsFx8yq3lzt0yQU7YHtb99afYtW6nj58j8prK0O16zEnzGWyMKnl1u5Mj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729133168; c=relaxed/simple;
	bh=Z02II3Z3ULHOY40F1NrUEiG5gyTJgfTQO8ceWJiBAOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZjWBVYYkQst8mDomjGCsWPx5sG7DfShSO62JTDFSkfHsjZw0sba8m1PayODCsWAZSCf2rQgSYZ78HzlJW8px7dpPGAYGo4VF78MAEk0dTAPDEEqTnAX4I8Ma8e/0rMy3yE3yrWKOBOj4HmmJquyzMfrZgqJisAyxnlksy++q5mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hO5EoDT0; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729133155; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=93bIldeAiM5c9kiOXacXJD8R78HQFEM3F98jsFeiBNs=;
	b=hO5EoDT0Fm4kKQ0m3La5ba504WEj93YE7hEQcqgoWi0WbUlNeVO6QWdIVbfRSui2lOlTgWKjV9UIOoGp8MtbDRbRDHmgjKaPbPkBld6DcHdQboz0ZJ2BskuDe9wEHgzqd6omLzpG2cgstCGdvdlc8zDo4g0qoRO5SBxlqdq9kJQ=
Received: from 30.74.144.140(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WHJ4neC_1729133154 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Oct 2024 10:45:55 +0800
Message-ID: <646157ce-5aa5-44e7-b3a2-b3d39f83d349@linux.alibaba.com>
Date: Thu, 17 Oct 2024 10:45:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: shmem: update iocb->ki_pos directly to simplify
 tmpfs read logic
To: Kefeng Wang <wangkefeng.wang@huawei.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1729072803.git.baolin.wang@linux.alibaba.com>
 <c390879ab020c44be25de8a07e3f1f87402350e0.1729072803.git.baolin.wang@linux.alibaba.com>
 <584e60dd-8a3b-46d5-87ec-aa7032d3a572@huawei.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <584e60dd-8a3b-46d5-87ec-aa7032d3a572@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/10/16 20:34, Kefeng Wang wrote:
> 
> 
> On 2024/10/16 18:09, Baolin Wang wrote:
>> Use iocb->ki_pos to check if the read bytes exceeds the file size and to
>> calculate the bytes to be read can help simplify the code logic. 
>> Meanwhile,
>> this is also a preparation for improving tmpfs large folios read 
>> performace
>> in the following patch.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/shmem.c | 36 ++++++++++++------------------------
>>   1 file changed, 12 insertions(+), 24 deletions(-)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 66eae800ffab..edab02a26aac 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -3106,26 +3106,18 @@ static ssize_t shmem_file_read_iter(struct 
>> kiocb *iocb, struct iov_iter *to)
>>       unsigned long offset;
>>       int error = 0;
>>       ssize_t retval = 0;
>> -    loff_t *ppos = &iocb->ki_pos;
>> -    index = *ppos >> PAGE_SHIFT;
>> -    offset = *ppos & ~PAGE_MASK;
>> +    index = iocb->ki_pos >> PAGE_SHIFT;
> 
> index calculate could be moved before shmem_get_folio(), then...

Yes. Will do.

