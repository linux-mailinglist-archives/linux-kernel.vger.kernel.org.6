Return-Path: <linux-kernel+bounces-368020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C149A09EF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F02FB28957
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48416208981;
	Wed, 16 Oct 2024 12:36:40 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8491DFF5
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 12:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082199; cv=none; b=dFJnUCcwzPSzCFb41tnx1GHnzBS6LghzxJgeFDSt9s9gz/AFyfIAaesroJVdllF8OSinxnSXyrjbkpVm+p2WD5uVArDdfoMFx5qYc7AcDq+Q5lRMUhk2ulf7yyMbavml1iP179S++/ojTFNv0HJ01XueLZ6UpYVeRlZzQdDMziw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082199; c=relaxed/simple;
	bh=sn+afpJl8UZcj3Gch6hsgDwKOuLAGyp9Gn8unJVmkho=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YfL0QrQROU2N4w1BMU/SHbZSqCJGNbXg+J1leqIyajzD2wqLwif2rqZ0nOayk4x9orOHyUBZN4Q5NpttpjXq0tTF7pOK5GmsmaUAyFx7wlPnJqPsEDabhjrUA1NpmwPHHNFyVQ78VYvhQ0vzBM22mpITDDgVvuYs4ibnjkzZFN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XT9R30ZfbzyTGW;
	Wed, 16 Oct 2024 20:35:11 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 15E231403D2;
	Wed, 16 Oct 2024 20:36:35 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 16 Oct 2024 20:36:34 +0800
Message-ID: <1cb50014-8678-40de-bca3-8a33555ec70e@huawei.com>
Date: Wed, 16 Oct 2024 20:36:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: shmem: improve the tmpfs large folio read
 performance
To: Baolin Wang <baolin.wang@linux.alibaba.com>, <akpm@linux-foundation.org>,
	<hughd@google.com>
CC: <willy@infradead.org>, <david@redhat.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <cover.1729072803.git.baolin.wang@linux.alibaba.com>
 <df801bca5026c4b06cb843b9366fba21f0d45981.1729072803.git.baolin.wang@linux.alibaba.com>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <df801bca5026c4b06cb843b9366fba21f0d45981.1729072803.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/10/16 18:09, Baolin Wang wrote:
> The tmpfs has already supported the PMD-sized large folios, but the tmpfs
> read operation still performs copying at the PAGE SIZE granularity, which
> is unreasonable. This patch changes to copy data at the folio granularity,
> which can improve the read performance, as well as changing to use folio
> related functions.
> 
> Use 'fio bs=64k' to read a 1G tmpfs file populated with 2M THPs, and I can
> see about 20% performance improvement, and no regression with bs=4k.
> Before the patch:
> READ: bw=10.0GiB/s
> 
> After the patch:
> READ: bw=12.0GiB/s
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   mm/shmem.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index edab02a26aac..7e79b6a96da0 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3108,13 +3108,12 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   	ssize_t retval = 0;
>   
>   	index = iocb->ki_pos >> PAGE_SHIFT;
> -	offset = iocb->ki_pos & ~PAGE_MASK;
>   
>   	for (;;) {
>   		struct folio *folio = NULL;
> -		struct page *page = NULL;
>   		unsigned long nr, ret;
>   		loff_t end_offset, i_size = i_size_read(inode);
> +		size_t fsize;
>   
>   		if (unlikely(iocb->ki_pos >= i_size))
>   			break;
> @@ -3128,8 +3127,9 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   		if (folio) {
>   			folio_unlock(folio);
>   
> -			page = folio_file_page(folio, index);
> -			if (PageHWPoison(page)) {
> +			if (folio_test_hwpoison(folio) ||
> +			    (folio_test_large(folio) &&
> +			     folio_test_has_hwpoisoned(folio))) {
>   				folio_put(folio);
>   				error = -EIO;
>   				break;
> @@ -3147,7 +3147,12 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   			break;
>   		}
>   		end_offset = min_t(loff_t, i_size, iocb->ki_pos + to->count);
> -		nr = min_t(loff_t, end_offset - iocb->ki_pos, PAGE_SIZE - offset);
> +		if (folio)
> +			fsize = folio_size(folio);
> +		else
> +			fsize = PAGE_SIZE;
> +		offset = iocb->ki_pos & (fsize - 1);
> +		nr = min_t(loff_t, end_offset - iocb->ki_pos, fsize - offset);
>   
>   		if (folio) {
>   			/*
> @@ -3156,7 +3161,7 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   			 * before reading the page on the kernel side.
>   			 */

We'd better to update all the comment from page to folio.

>   			if (mapping_writably_mapped(mapping))
> -				flush_dcache_page(page);
> +				flush_dcache_folio(folio);
>   			/*
>   			 * Mark the page accessed if we read the beginning.
>   			 */
> @@ -3166,9 +3171,8 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   			 * Ok, we have the page, and it's up-to-date, so
>   			 * now we can copy it to user space...
>   			 */
> -			ret = copy_page_to_iter(page, offset, nr, to);
> +			ret = copy_folio_to_iter(folio, offset, nr, to);
>   			folio_put(folio);
> -
>   		} else if (user_backed_iter(to)) {
>   			/*
>   			 * Copy to user tends to be so well optimized, but
> @@ -3186,8 +3190,6 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   		}
>   
>   		retval += ret;
> -		offset += ret;
> -		offset &= ~PAGE_MASK;
>   		iocb->ki_pos += ret;
>   		index = iocb->ki_pos >> PAGE_SHIFT;
>   


