Return-Path: <linux-kernel+bounces-394123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC159BAACB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB701B20E72
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 02:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360AD16EBE6;
	Mon,  4 Nov 2024 02:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="q1y8Iv9q"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92D65661;
	Mon,  4 Nov 2024 02:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730687140; cv=none; b=AjNxxSIwFXcV8+f3+gfvWEzhi3WQJR7wYza3boVAo9iyrloDzFP/RHu6IGmVCkcoipPTdLEljMgUUlqsChVBj5Grk0eOsI0d+HQdu+qxzCJHC/bblfo6z1CBg6Jhkfcxr+m9Tr3y+pICYcYOevhFgwGm11U8uLk4rRE4nvcaS6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730687140; c=relaxed/simple;
	bh=h//F8PXuM2FQEQeIN5bQbGYRWoAFbiGtiAt2cr3sGho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPboKxU75ZiSjXOq9tnemoWNr1Uod5pHOpbbh+bXEauSdwHfjYVr4Ec1gY3xASMAYbeJ7XJj2yB9R/lUX530WT/adgsyIvJlW+XyV4R/qEeDWZIAs44pJf3FL0hAfo7mLPImWh9JSspCxguKa966tdEKieAX37CaNdbAISyCrMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=q1y8Iv9q; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730687134; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/9cmlej8OATRi4lM94Y98/vOaVDU8BB5/PiYbgOOWY8=;
	b=q1y8Iv9qlMuCBtSIc1qDcginctrfTcvhhdmRUdLyNpSfIVz8U7wgETaNOJ6bk1S3kVNz5XjuPZVa9DgKbSj74yYArNzpCjk8oC17VjT4V0FsAulsoKQN1Kx0kBtoEp9QvUJ30qH0svZoclUtyTr2UhSsDuSv2v1AAoNG01sxXms=
Received: from 30.74.144.113(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WIZl5VU_1730687132 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 Nov 2024 10:25:32 +0800
Message-ID: <9d5ce0af-6fca-422f-b1f8-650879f8ff5a@linux.alibaba.com>
Date: Mon, 4 Nov 2024 10:25:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] mm: move ``get_order_from_str()`` to internal.h
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>,
 David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Lance Yang <ioworker0@gmail.com>
Cc: linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com
References: <20241101165719.1074234-2-mcanal@igalia.com>
 <20241101165719.1074234-5-mcanal@igalia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20241101165719.1074234-5-mcanal@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/2 00:54, Maíra Canal wrote:
> In order to implement a kernel parameter similar to ``thp_anon=`` for
> shmem, we'll need the function ``get_order_from_str()``.
> 
> Instead of duplicating the function, move the function to a shared
> header, in which both mm/shmem.c and mm/huge_memory.c will be able to
> use it.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   mm/huge_memory.c | 38 +++++++++++++++-----------------------
>   mm/internal.h    | 22 ++++++++++++++++++++++
>   2 files changed, 37 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f92068864469..a6edbd8c4f49 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -958,26 +958,6 @@ static int __init setup_transparent_hugepage(char *str)
>   }
>   __setup("transparent_hugepage=", setup_transparent_hugepage);
>   
> -static inline int get_order_from_str(const char *size_str)
> -{
> -	unsigned long size;
> -	char *endptr;
> -	int order;
> -
> -	size = memparse(size_str, &endptr);
> -
> -	if (!is_power_of_2(size))
> -		goto err;
> -	order = get_order(size);
> -	if (BIT(order) & ~THP_ORDERS_ALL_ANON)
> -		goto err;
> -
> -	return order;
> -err:
> -	pr_err("invalid size %s in thp_anon boot parameter\n", size_str);
> -	return -EINVAL;
> -}
> -
>   static char str_dup[PAGE_SIZE] __initdata;
>   static int __init setup_thp_anon(char *str)
>   {
> @@ -1007,10 +987,22 @@ static int __init setup_thp_anon(char *str)
>   				start_size = strsep(&subtoken, "-");
>   				end_size = subtoken;
>   
> -				start = get_order_from_str(start_size);
> -				end = get_order_from_str(end_size);
> +				start = get_order_from_str(start_size, THP_ORDERS_ALL_ANON);
> +				end = get_order_from_str(end_size, THP_ORDERS_ALL_ANON);
>   			} else {
> -				start = end = get_order_from_str(subtoken);
> +				start_size = end_size = subtoken;
> +				start = end = get_order_from_str(subtoken,
> +								 THP_ORDERS_ALL_ANON);
> +			}
> +
> +			if (start == -EINVAL) {
> +				pr_err("invalid size %s in thp_anon boot parameter\n", start_size);
> +				goto err;
> +			}
> +
> +			if (end == -EINVAL) {
> +				pr_err("invalid size %s in thp_anon boot parameter\n", end_size);
> +				goto err;
>   			}

There are already checks for ‘start’ and ‘end’ below, and will print 
error messages if error occurs. So I suspect whether these repeated 
checks and error infor are helpful.

Anyway, I don't have a strong preference.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

