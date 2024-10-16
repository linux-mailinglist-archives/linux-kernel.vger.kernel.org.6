Return-Path: <linux-kernel+bounces-367738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8EB9A0616
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B47928197E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66824205E33;
	Wed, 16 Oct 2024 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aRsqQh/+"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F71204F94
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072199; cv=none; b=cdpxaydMjzU2zfY6JrA49Nr9LrDyOTPBCRYPGob8cWM3YMimo8ydRX9BEJzT010aTDPycyHBrIQOxjljU9RIdiJlYUqC/ZvPI6roVH8+2fY9oBI7pFpiYk7BaB8yAkWE0t5VIO8AlVnQAYn6qHi1f9w4haErXpaQFg0k7WS+1kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072199; c=relaxed/simple;
	bh=76GkyjvRf8ZM+zC5JE/ZCrzUbyQL4oEhporGeOiFHlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mBRxwHQMu9XDwqr5U8z4m6m/vLIDzs6b/6sNW9nHRCneJi4kQyZN4QNN3GzroWV+s/7SPqV/P59b2qvCsG87gnvTwuu61T2grWI7NkSql7qMvyWINPXIUmtTkMFDjHwGLqE+y+/OzSGDWHaK3dV2m15Gsl37rVoI/p/iHmoe9D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aRsqQh/+; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729072194; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Zcl1IYVRFU/6R1zDE4PCk3VFU83Czlrba1JPXCqZJgM=;
	b=aRsqQh/+hrBlou0rhOaEI9I1tsdVJjDXFANyuXhaVwcFFp8Uw6UEZWCGSYXL9Ws2rACgq6ZDTWACnogMfaNtJ6MOCGygwjTjz/HO8a4nDxWZwesOFJcpuszPtwDvumyhNHrKXjiYP2zHBlKDNPDVcmLcmfyy/D+qmDLRWR6/6eE=
Received: from 30.221.129.144(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WHH-MXo_1729072192 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Oct 2024 17:49:54 +0800
Message-ID: <21d7a0d6-faac-4914-8907-1d7d983953f2@linux.alibaba.com>
Date: Wed, 16 Oct 2024 17:49:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] ocfs2: pass u64 to ocfs2_truncate_inline maybe
 overflow
To: Edward Adam Davis <eadavis@qq.com>
Cc: jlbec@evilplan.org, l@damenly.org, linux-kernel@vger.kernel.org,
 mark@fasheh.com, ocfs2-devel@lists.linux.dev,
 syzbot+81092778aac03460d6b7@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <40f48906-09fd-4695-aef0-7647de46ea42@linux.alibaba.com>
 <tencent_2D332A9E751B474B521BD22569BA27BB0D08@qq.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <tencent_2D332A9E751B474B521BD22569BA27BB0D08@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/16/24 11:22 AM, Edward Adam Davis wrote:
> Syzbot reported a kernel BUG in ocfs2_truncate_inline.
> There are two reasons for this: first, the parameter value passed is greater
> than UINT_MAX, second, the start and end parameters of ocfs2_truncate_inline
> are "unsigned int".
> 
> So, we need to add a sanity check for byte_start and byte_len right before
> ocfs2_truncate_inline() in ocfs2_remove_inode_range(), if they are greater
> than ocfs2_max_inline_data_with_xattr return -EFBIG.
> 
> Reported-by: syzbot+81092778aac03460d6b7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=81092778aac03460d6b7
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
> V1 -> V2: move sanity check to ocfs2_remove_inode_range
> V2 -> V3: use ocfs2_max_inline_data_with_xattr return value replace UINT_MAX
> 
>  fs/ocfs2/file.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
> index ad131a2fc58e..9327aa2f1bf4 100644
> --- a/fs/ocfs2/file.c
> +++ b/fs/ocfs2/file.c
> @@ -1784,6 +1784,12 @@ int ocfs2_remove_inode_range(struct inode *inode,
>  		return 0;
>  
>  	if (OCFS2_I(inode)->ip_dyn_features & OCFS2_INLINE_DATA_FL) {
> +		int max_inl = ocfs2_max_inline_data_with_xattr(inode->i_sb, di);

Or rename it to 'id_count' refer to 'struct ocfs2_inline_data'.
Better to leave a blank line here.

> +		if (byte_start > max_inl || byte_start + byte_len > max_inl) {
> +			ret = -EFBIG;

Seems 'EINVAL' is more proper here.
Please do corresponding change in commit log.

> +			mlog_errno(ret);
> +			goto out;
> +		}

Better to leave a blank line.

Thanks,
Joseph

>  		ret = ocfs2_truncate_inline(inode, di_bh, byte_start,
>  					    byte_start + byte_len, 0);
>  		if (ret) {


