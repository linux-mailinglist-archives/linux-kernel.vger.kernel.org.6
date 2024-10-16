Return-Path: <linux-kernel+bounces-368017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C79229A09D9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85BE228620F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F86207A33;
	Wed, 16 Oct 2024 12:34:51 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D75173357
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 12:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082091; cv=none; b=sB70KVfFD1XObyhBW2XUR6DuP8uj7K7UaLkSRueOuX2LlhPsiG9Fj1pt+93ZmRUUA8dtrhs2IOmfnccl83cbK8fpvZA1nOEHafgDuEDX+d9PSB5L4Prju8SSIu/FUXPTSRgXY8IqpQyxDrJfqPOK/iNT62htWAND2Y717DsuVNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082091; c=relaxed/simple;
	bh=q2FjjIfhL52fwzxnepSd24OhoTHv7x+vgtz+msKcKGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GyfdLDhxiARihW/1wXbDHjbFDdsEJYjhttwWQmlCPM7aPCZvTpBnoZEp9w9ycINiAqXoa78qL2efsE98CYmLlHhDhMUrbu/eP9Dhd80uO8bhokfJ+/rkdyL8B9a9PqWn1JSUoW1PkZM0kWZwnjeR2GsrFuaiv6ArMUU/F1nzzEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XT9Qg4gMtz1xxBG;
	Wed, 16 Oct 2024 20:34:51 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id C176D1A016C;
	Wed, 16 Oct 2024 20:34:45 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 16 Oct 2024 20:34:45 +0800
Message-ID: <584e60dd-8a3b-46d5-87ec-aa7032d3a572@huawei.com>
Date: Wed, 16 Oct 2024 20:34:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: shmem: update iocb->ki_pos directly to simplify
 tmpfs read logic
To: Baolin Wang <baolin.wang@linux.alibaba.com>, <akpm@linux-foundation.org>,
	<hughd@google.com>
CC: <willy@infradead.org>, <david@redhat.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <cover.1729072803.git.baolin.wang@linux.alibaba.com>
 <c390879ab020c44be25de8a07e3f1f87402350e0.1729072803.git.baolin.wang@linux.alibaba.com>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <c390879ab020c44be25de8a07e3f1f87402350e0.1729072803.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/10/16 18:09, Baolin Wang wrote:
> Use iocb->ki_pos to check if the read bytes exceeds the file size and to
> calculate the bytes to be read can help simplify the code logic. Meanwhile,
> this is also a preparation for improving tmpfs large folios read performace
> in the following patch.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   mm/shmem.c | 36 ++++++++++++------------------------
>   1 file changed, 12 insertions(+), 24 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 66eae800ffab..edab02a26aac 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3106,26 +3106,18 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   	unsigned long offset;
>   	int error = 0;
>   	ssize_t retval = 0;
> -	loff_t *ppos = &iocb->ki_pos;
>   
> -	index = *ppos >> PAGE_SHIFT;
> -	offset = *ppos & ~PAGE_MASK;
> +	index = iocb->ki_pos >> PAGE_SHIFT;

index calculate could be moved before shmem_get_folio(), then...

> +	offset = iocb->ki_pos & ~PAGE_MASK;
>   
>   	for (;;) {
>   		struct folio *folio = NULL;
>   		struct page *page = NULL;
> -		pgoff_t end_index;
>   		unsigned long nr, ret;
> -		loff_t i_size = i_size_read(inode);
> +		loff_t end_offset, i_size = i_size_read(inode);
>   
> -		end_index = i_size >> PAGE_SHIFT;
> -		if (index > end_index)
> +		if (unlikely(iocb->ki_pos >= i_size))
>   			break;
> -		if (index == end_index) {
> -			nr = i_size & ~PAGE_MASK;
> -			if (nr <= offset)
> -				break;
> -		}
>   
>   		error = shmem_get_folio(inode, index, 0, &folio, SGP_READ);
>   		if (error) {
> @@ -3148,18 +3140,14 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   		 * We must evaluate after, since reads (unlike writes)
>   		 * are called without i_rwsem protection against truncate
>   		 */
> -		nr = PAGE_SIZE;
>   		i_size = i_size_read(inode);
> -		end_index = i_size >> PAGE_SHIFT;
> -		if (index == end_index) {
> -			nr = i_size & ~PAGE_MASK;
> -			if (nr <= offset) {
> -				if (folio)
> -					folio_put(folio);
> -				break;
> -			}
> +		if (unlikely(iocb->ki_pos >= i_size)) {
> +			if (folio)
> +				folio_put(folio);
> +			break;
>   		}
> -		nr -= offset;
> +		end_offset = min_t(loff_t, i_size, iocb->ki_pos + to->count);
> +		nr = min_t(loff_t, end_offset - iocb->ki_pos, PAGE_SIZE - offset);
>   
>   		if (folio) {
>   			/*
> @@ -3199,8 +3187,9 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   
>   		retval += ret;
>   		offset += ret;
> -		index += offset >> PAGE_SHIFT;
>   		offset &= ~PAGE_MASK;
> +		iocb->ki_pos += ret;
> +		index = iocb->ki_pos >> PAGE_SHIFT;

remove this line.

>   
>   		if (!iov_iter_count(to))
>   			break;
> @@ -3211,7 +3200,6 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   		cond_resched();
>   	}
>   
> -	*ppos = ((loff_t) index << PAGE_SHIFT) + offset;
>   	file_accessed(file);
>   	return retval ? retval : error;
>   }


