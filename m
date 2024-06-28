Return-Path: <linux-kernel+bounces-233326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC1791B57E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81B27B21D09
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E011CF8A;
	Fri, 28 Jun 2024 03:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="b5HClanP"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697451CD24
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719545554; cv=none; b=LKIs2DNAiraS4l1qABekVA0Pjp13idpvBZ/czT5AggMfqT6WBH3J14iOU9kHBpBHHWRCVctxNUF+OydOw4qGa0u6yT/CTcHNhzoDOocUdXkJk3kzKWhQg+HHa2CxTRPQ/p3kKyhUXkIdbstJPmfEMSE4uzLy9XoZ98/lLl8b608=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719545554; c=relaxed/simple;
	bh=+iTRGsJEwtDj7S5awPRVh3dECPqDJSFZXvvVtfejBic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkQonD6MTqhP/vsCi4EhL6drYKj2uuP63ll4KHHqfEIHTGdu17WcB7kPjG17eoZuQZr3l2DdIKNZxTdS7P2GX8fm3rxWtZE6AMTnKfoub+Wgsm1YXVrLZ2aY0ZVjUhynjVLmh1Q3L6Xg7wTT1xqmp7c00GLisZj9JKIrvdsK4hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=b5HClanP; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719545543; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=dDK6XfqdElW0YhTqpgvd5sdP3jB1jBOHpdWdxJ3BtW0=;
	b=b5HClanP72yPxHWcFNAflw2+28JaZKk0Nc2sDkkzCegjeZ527ITlR1hqjApQrAMMtePKuHnKiu8PlJW45Atq7WP8p8Ar9Ss6vRLDNImAgSbRT8BOnWGR3OXTxPi+t4Qi7kvsqBE0iEl8rltq8Jf0oXleeDE/8+mH9K0wsPX4jdQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033023225041;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W9Oogpa_1719545542;
Received: from 30.97.56.65(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W9Oogpa_1719545542)
          by smtp.aliyun-inc.com;
          Fri, 28 Jun 2024 11:32:22 +0800
Message-ID: <63aed837-21ae-4bc3-b327-ad2a005e6e4f@linux.alibaba.com>
Date: Fri, 28 Jun 2024 11:32:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/shmem: Fix input and output inconsistencies
To: Bang Li <libang.li@antgroup.com>, hughd@google.com,
 akpm@linux-foundation.org
Cc: david@redhat.com, ryan.roberts@arm.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240628032327.16987-1-libang.li@antgroup.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240628032327.16987-1-libang.li@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/28 11:23, Bang Li wrote:
> After the commit 19eaf44954df ("mm: thp: support allocation of
> anonymous multi-size THP"), add mTHP support for anonymous shmem.
> We can configure different policies through the multi-size THP
> sysfs interface for anonymous shmem.
> 
> But when we configure the "advise" policy of
> /sys/kernel/mm/transparent_hugepage/hugepages-xxxkB/shmem_enabled,
> we cannot write the "advise", but write the "madvise", which is
> unreasonable. We should keep the output and input values consistent,
> which is more convenient for users.
> 
> Fixes: 61a57f1b1da9 ("mm: shmem: add multi-size THP sysfs interface for anonymous shmem")
> Signed-off-by: Bang Li <libang.li@antgroup.com>

Good catch. Sorry for my typo. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/shmem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 13d139abe69a..d495c0701a83 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -4983,7 +4983,7 @@ static ssize_t thpsize_shmem_enabled_store(struct kobject *kobj,
>   		clear_bit(order, &huge_shmem_orders_madvise);
>   		set_bit(order, &huge_shmem_orders_within_size);
>   		spin_unlock(&huge_shmem_orders_lock);
> -	} else if (sysfs_streq(buf, "madvise")) {
> +	} else if (sysfs_streq(buf, "advise")) {
>   		spin_lock(&huge_shmem_orders_lock);
>   		clear_bit(order, &huge_shmem_orders_always);
>   		clear_bit(order, &huge_shmem_orders_inherit);

