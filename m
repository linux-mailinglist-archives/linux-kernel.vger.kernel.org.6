Return-Path: <linux-kernel+bounces-336958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A56984338
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04DA1F2130E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECFF16F0C1;
	Tue, 24 Sep 2024 10:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rkoBFQHd"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C49A1547C5
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727172860; cv=none; b=VkL3ayO8acT1v/moV0CP+CMnqipDRQRJpseD4/mLM3GtOW5IW3Q6KylJVtiEeVdjsHfI0HDN50QTOFQArKtgI0L5S/c755n7OvjPavSFGqsXAoCreoSS5FebPx8podJciiOt9W/ZMjTbVEufZ5rdY8AeSOLWjuorKroO5fKYKpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727172860; c=relaxed/simple;
	bh=CTZDiOXFd76tKyMiAJ15iMMvJCYHEOttm2QfzsHKteA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PLPjHu6xlepuWM362qopNxEQX5LVEkJAU5KvMP9eUaiUvp4KT9DAnnGbJjPMRH3Fhv85g1eWse1wMAMACn7rS1dntyn0QWkaiL8VD2I5Odi/LgSqVkdXRncWPqQSE26q/vnU/mSuDNCwd/sCrrshdIxCeCwRJiI5CU4pnyoLgcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rkoBFQHd; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727172855; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=mnh/yFaxLOWgYzQjjpP0UVVTSD8FSMj9SP3UgEKmbvg=;
	b=rkoBFQHdpvZTkFf53EACzj5KNW6fWKwQY9+RkL4vUYt+qOxjqUGxw0RQp7tbbUD6G6/Was/KmTUrpn7bXW2HJcZwEcxLSAMK72C5m4A+0umUBL29GIDhjwO5IT14fAmXNQXvPr8m0fw95ljHBh1jIp4A+cZTnRvZn96a9Kdv9qQ=
Received: from 30.221.128.243(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WFg2HLn_1727172854)
          by smtp.aliyun-inc.com;
          Tue, 24 Sep 2024 18:14:15 +0800
Message-ID: <8ee6270b-f496-4a8e-a7da-82040b8847e0@linux.alibaba.com>
Date: Tue, 24 Sep 2024 18:14:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ocfs2: Fix deadlock in ocfs2_get_system_file_inode
To: Mohammed Anees <pvmohammedanees2003@gmail.com>,
 akpm <akpm@linux-foundation.org>
Cc: Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 syzbot+e0055ea09f1f5e6fabdd@syzkaller.appspotmail.com,
 ocfs2-devel@lists.linux.dev,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240924093257.7181-1-pvmohammedanees2003@gmail.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20240924093257.7181-1-pvmohammedanees2003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/24/24 5:32 PM, Mohammed Anees wrote:
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
> ocfs2_mknod - lock(&ocfs2_file_ip_alloc_sem_key);
> .
> .
> .
> ocfs2_get_system_file_inode - lock(&osb->system_file_mutex);
> 
> CPU1 -
> ocfs2_fill_super - lock(&osb->system_file_mutex);
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

Cc:  <stable@vger.kernel.org>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
> v3:
> - Removed multiple if conditions
> ---
>  fs/ocfs2/extent_map.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
> index 70a768b62..f7672472f 100644
> --- a/fs/ocfs2/extent_map.c
> +++ b/fs/ocfs2/extent_map.c
> @@ -973,7 +973,13 @@ int ocfs2_read_virt_blocks(struct inode *inode, u64 v_block, int nr,
>  	}
>  
>  	while (done < nr) {
> -		down_read(&OCFS2_I(inode)->ip_alloc_sem);
> +		if (!down_read_trylock(&OCFS2_I(inode)->ip_alloc_sem)) {
> +			rc = -EAGAIN;
> +			mlog(ML_ERROR,
> +				 "Inode #%llu ip_alloc_sem is temporarily unavailable\n",
> +				 (unsigned long long)OCFS2_I(inode)->ip_blkno);
> +			break;
> +		}
>  		rc = ocfs2_extent_map_get_blocks(inode, v_block + done,
>  						 &p_block, &p_count, NULL);
>  		up_read(&OCFS2_I(inode)->ip_alloc_sem);


