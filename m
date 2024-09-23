Return-Path: <linux-kernel+bounces-335382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A7E97E4DB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 04:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D88DA1C20FF9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 02:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE0833D1;
	Mon, 23 Sep 2024 02:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JUdDdNDD"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E75635
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 02:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727059931; cv=none; b=AKKfZZmK0cCNscW+pisI2OX6gZ2xCD4l0qD+BRv1Lu4ue4y2YlEpi++9gI1KTrdVVafCl8oeeZmN+GTewvQKo711GWluLUsLFX8tFGMXAzocMQbWvs3MBkOgO6PKJb3EfloW4IxoGH4I3MXjk90nd2iuGVhLmFybNa58lV8sumA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727059931; c=relaxed/simple;
	bh=T95bhtE4ahzeAXj9o+UbB8jJyiaq+V9Y+k+RIg5NH3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s8cxPUMZjgbc8PNi6Ed5c0BvGXGmJTrxo9dACGwGKnyGrUhJ6k9sWDczAhz+ev3KGY0h/YjNGI6Ke3vrTwmD7OsInIJRfyQiXrgiXanmggTMSX7AgpZyKUOy3u2AcmC/N0gKQPbEpKVZsfZP68sAQRMkksnBZoX2o3VqB82FDwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JUdDdNDD; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727059920; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=r4XJOtNI53//80tJmFNGm+o5EdJOnmpi3+8PaJ8QvK8=;
	b=JUdDdNDDGY6+5nhAvYwwgL6210Wn8HvURx757tOX48IYkGihj2sbczdJwhuofDxci88KEaIFkBClUPHeLFhRzHw1a0tlq/imr4RiDv7pHXo3QE0VjbnJARA2f5ATaz6IclhGOeRMFia4vNp/cv2bFlgY4oRJyIIuc5TRZvn9vxI=
Received: from 30.221.132.125(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WFRyaS8_1727059919)
          by smtp.aliyun-inc.com;
          Mon, 23 Sep 2024 10:52:00 +0800
Message-ID: <e758ca0a-0ee7-4dff-8379-6d43397fddf0@linux.alibaba.com>
Date: Mon, 23 Sep 2024 10:51:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: Fix deadlock in ocfs2_get_system_file_inode
To: Mohammed Anees <pvmohammedanees2003@gmail.com>,
 ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 syzbot+e0055ea09f1f5e6fabdd@syzkaller.appspotmail.com
References: <20240921175034.11222-1-pvmohammedanees2003@gmail.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20240921175034.11222-1-pvmohammedanees2003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/22/24 1:50 AM, Mohammed Anees wrote:
> syzbot has found a possible deadlock in ocfs2_get_system_file_inode [1].
> 
> The scenario is depicted here,
> 
> 	CPU0					CPU1
> lock(&ocfs2_file_ip_alloc_sem_key);
>                                lock(&osb->system_file_mutex);
>                                lock(&ocfs2_file_ip_alloc_sem_key);
> lock(&osb->system_file_mutex);
> 
> The function calls which could lead to this are:
> 
> CPU0
> ocfs2_write_begin - lock(&ocfs2_file_ip_alloc_sem_key);
> .


From the report link, it's ocfs2_mknod(), but not
ocfs2_write_begin().

> .
> .
> ocfs2_get_system_file_inode - lock(&osb->system_file_mutex);
> 
> CPU1 -
> ocfs2_get_system_file_inode - lock(&osb->system_file_mutex);

From the report link, it is in the flow of ocfs2_fill_super().
I'm not sure how it actually happens since user has to mount ocfs2
before doing any operations, e.g. create a file.
Anyway, since many flows will call ocfs2_get_system_file_inode(),
so it will theoretically happen.

> .
> .
> .
> ocfs2_read_virt_blocks - lock(&ocfs2_file_ip_alloc_sem_key);
> 
> This issue can be resolved by making the down_read -> down_read_try
> in the ocfs2_read_virt_blocks.
> 
> [1] https://syzkaller.appspot.com/bug?extid=e0055ea09f1f5e6fabdd
> 
> Reported-and-tested-by: syzbot+e0055ea09f1f5e6fabdd@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e0055ea09f1f5e6fabdd
> Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
> ---
>  fs/ocfs2/extent_map.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
> index 70a768b62..f83d0a3b6 100644
> --- a/fs/ocfs2/extent_map.c
> +++ b/fs/ocfs2/extent_map.c
> @@ -12,6 +12,7 @@
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/fiemap.h>
> +#include <linux/delay.h>
>  
>  #include <cluster/masklog.h>
>  
> @@ -961,6 +962,8 @@ int ocfs2_read_virt_blocks(struct inode *inode, u64 v_block, int nr,
>  	int rc = 0;
>  	u64 p_block, p_count;
>  	int i, count, done = 0;
> +	int retries, max_retries = 5;
> +	int retry_delay_ms = 30;
>  
>  	trace_ocfs2_read_virt_blocks(
>  	     inode, (unsigned long long)v_block, nr, bhs, flags,
> @@ -973,7 +976,18 @@ int ocfs2_read_virt_blocks(struct inode *inode, u64 v_block, int nr,
>  	}
>  
>  	while (done < nr) {
> -		down_read(&OCFS2_I(inode)->ip_alloc_sem);
> +		retries = 0;
> +		while (retries < max_retries) {
> +			if (down_read_trylock(&OCFS2_I(inode)->ip_alloc_sem))
> +				break; // Lock acquired
> +			msleep(retry_delay_ms);
> +			retries++;
> +		}

I'd like just use down_read_trylock() and fail directly if can't.

Thanks,
Joseph

> +		if (retries == max_retries) {
> +			rc = -EAGAIN;
> +			mlog(ML_ERROR, "Cannot acquire lock\n");
> +			break;
> +		}
>  		rc = ocfs2_extent_map_get_blocks(inode, v_block + done,
>  						 &p_block, &p_count, NULL);
>  		up_read(&OCFS2_I(inode)->ip_alloc_sem);


