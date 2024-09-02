Return-Path: <linux-kernel+bounces-311243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB38996867D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820EC1F22486
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B57F1D6195;
	Mon,  2 Sep 2024 11:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KThnB83G"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381191D54FD
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725277431; cv=none; b=jnb+jfICBGbaGa2UltJhzbObGH6wM/t5+OUKN2U0braKvBg9tCTKMvVmgDph5AyNwW3hQbocsxzNAn2mc/jOUHBj+BblEQ/aPFi8hxgm0psORu5j0PTFBKe6pr0dqu+ufelnzaDzDE/xZmOYgyN82SDLAez72IDgJl8slX6ePZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725277431; c=relaxed/simple;
	bh=x5tMgBrEEKlLU5Afk9WaUgS4zcJ+RyoQmJW8thN7O3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FllB4c0vBCex3pt5eNZO2lIoqD7yR9fUgBl8iAQdnecXnyP7OqT7ds5EKJP5bmXbAqKUbS0j7ZiEKuNW7VKHtgZp1/ULPmnXtxdbeNRhx1e/q0qAsYhilwc+6MquvsYos6L84hjBtiMg2HcPZaxHaIcEEOSVB0DxBflQuwWnZE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KThnB83G; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725277426; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=EpaDzX0hYxnpqXgfjqgj8769zqdOSOrb6l5mvkWaOeQ=;
	b=KThnB83GAFyZ9d2Ub3nBmePC35QnjYkhbmR2FXtAUMjaEweVAEOtasXHegvaj8pLSEKVATRLicc/EFHdtHxiVPa8lQCsBqgx3iPTcKC7uCVTDps3SrByp/ZwrQId10v9D914T6Qd6HC0x+ob48p6WBY+PgAYvyQlvjYJ0lVGxeU=
Received: from 30.221.129.135(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WE8Dc19_1725277424)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 19:43:45 +0800
Message-ID: <d7d8fb47-c32e-4764-9c96-5d22cb278cb0@linux.alibaba.com>
Date: Mon, 2 Sep 2024 19:43:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ocfs2: detect released suballocator bg for
 fh_to_[dentry|parent]
To: Heming Zhao <heming.zhao@suse.com>, glass.su@suse.com
Cc: ocfs2-devel@lists.linux.dev,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240729080454.12771-1-heming.zhao@suse.com>
 <20240729080454.12771-3-heming.zhao@suse.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20240729080454.12771-3-heming.zhao@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/29/24 4:04 PM, Heming Zhao wrote:
> After ocfs2 has the ability to reclaim suballoc free bg, the
> suballocator block group may be released. This change makes xfstest
> case 426 failed.
> 
> The existed code call stack:
> 
> ocfs2_fh_to_dentry //or ocfs2_fh_to_parent
>  ocfs2_get_dentry
>   ocfs2_test_inode_bit
>    ocfs2_test_suballoc_bit
>     ocfs2_read_group_descriptor
>      + read released bg, triggers validate fails, then cause -EROFS
> 
> how to fix:
> The read bg failure is expectation, we should ignore this error.
> 
> Signed-off-by: Heming Zhao <heming.zhao@suse.com>
> ---
>  fs/ocfs2/suballoc.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
> index 1b64f4c87607..dc421f55ed8f 100644
> --- a/fs/ocfs2/suballoc.c
> +++ b/fs/ocfs2/suballoc.c
> @@ -3037,7 +3037,7 @@ static int ocfs2_test_suballoc_bit(struct ocfs2_super *osb,
>  	struct ocfs2_group_desc *group;
>  	struct buffer_head *group_bh = NULL;
>  	u64 bg_blkno;
> -	int status;
> +	int status, quiet = 0;
>  
>  	trace_ocfs2_test_suballoc_bit((unsigned long long)blkno,
>  				      (unsigned int)bit);
> @@ -3053,11 +3053,16 @@ static int ocfs2_test_suballoc_bit(struct ocfs2_super *osb,
>  
>  	bg_blkno = group_blkno ? group_blkno :
>  		   ocfs2_which_suballoc_group(blkno, bit);
> -	status = ocfs2_read_group_descriptor(suballoc, alloc_di, bg_blkno,
> +	status = ocfs2_read_hint_group_descriptor(suballoc, alloc_di, bg_blkno,
>  					     &group_bh);
>  	if (status < 0) {
> -		mlog(ML_ERROR, "read group %llu failed %d\n",
> -		     (unsigned long long)bg_blkno, status);
> +		if (status == -EIDRM) {

I don't think EIDRM is a proper error code in this case.
We can pass a output parameter or a flag to indicate a released one.
And please explicitly specify that this can be treated normally in
the related code logic of ocfs2_read_hint_group_descriptor().

Thanks,
Joseph

> +			quiet = 1;
> +			status = -EINVAL;
> +		} else {
> +			mlog(ML_ERROR, "read group %llu failed %d\n",
> +					(unsigned long long)bg_blkno, status);
> +		}
>  		goto bail;
>  	}
>  
> @@ -3067,7 +3072,7 @@ static int ocfs2_test_suballoc_bit(struct ocfs2_super *osb,
>  bail:
>  	brelse(group_bh);
>  
> -	if (status)
> +	if (status && (!quiet))
>  		mlog_errno(status);
>  	return status;
>  }
> @@ -3087,7 +3092,7 @@ static int ocfs2_test_suballoc_bit(struct ocfs2_super *osb,
>   */
>  int ocfs2_test_inode_bit(struct ocfs2_super *osb, u64 blkno, int *res)
>  {
> -	int status;
> +	int status, quiet = 0;
>  	u64 group_blkno = 0;
>  	u16 suballoc_bit = 0, suballoc_slot = 0;
>  	struct inode *inode_alloc_inode;
> @@ -3129,8 +3134,12 @@ int ocfs2_test_inode_bit(struct ocfs2_super *osb, u64 blkno, int *res)
>  
>  	status = ocfs2_test_suballoc_bit(osb, inode_alloc_inode, alloc_bh,
>  					 group_blkno, blkno, suballoc_bit, res);
> -	if (status < 0)
> -		mlog(ML_ERROR, "test suballoc bit failed %d\n", status);
> +	if (status < 0) {
> +		if (status == -EINVAL)
> +			quiet = 1;
> +		else
> +			mlog(ML_ERROR, "test suballoc bit failed %d\n", status);
> +	}
>  
>  	ocfs2_inode_unlock(inode_alloc_inode, 0);
>  	inode_unlock(inode_alloc_inode);
> @@ -3138,7 +3147,7 @@ int ocfs2_test_inode_bit(struct ocfs2_super *osb, u64 blkno, int *res)
>  	iput(inode_alloc_inode);
>  	brelse(alloc_bh);
>  bail:
> -	if (status)
> +	if (status && !quiet)
>  		mlog_errno(status);
>  	return status;
>  }


