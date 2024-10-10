Return-Path: <linux-kernel+bounces-358965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE829985D1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCE2BB20FFA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7741C461F;
	Thu, 10 Oct 2024 12:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WCfoejgX"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F151C578E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728562925; cv=none; b=cKcLZhku7nf7NbOHObCyEsCb1GlbBm6P465jJnDdTHi2XAFPg/3Coacy0AW+QPepBNzxAgBxqWuK90+gDNQbjjGX5s6kr9ypTUrXuZWaUQ41I4VXM9amdbIJAs8btOqoBUIXN96U1bHu9oXgGnpSldDJ1glzi4qW0BnoqkyDXmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728562925; c=relaxed/simple;
	bh=aSsLD/2YVlQ4ipaA0/wB4H7bnwyHOJzmXA71hqS/C0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jyqXnDv2X6oMKFSg3CmvhkEKrIJ1VluQQeqZ64wNrlw5A7V2lD8+Cpu15zBzTh0g0zrqadt5FSY1D9K05PgNBBlON7uLI3l1B3cedeC5EYhYSsatLIpf9ZP1L4DKeABs7cqPKfyx7kXzbUAk5JOosZxu/RwUSwO/2wUa+d8XUV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WCfoejgX; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728562921; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=H7AUSm5pX1sMuXp2biuJaMWKGAYiM60rDEEuvukFCl8=;
	b=WCfoejgXnMHeXJ7UOpMZM5JQQO6KdXTDU37uxGvlAZS5KwEGMnvGGHZd5g5IuThQVoXFKl4XVESkPJouU50kLOV3t7U9gk1NTNwc8LuCHouh4u0YQrhO9Pl8qOdULyqdUM6Wmdep3HDkvXYq4ShTiari/7NkWMAsiKpCmh16ytw=
Received: from 30.221.129.173(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WGmMX0f_1728562920 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Oct 2024 20:22:00 +0800
Message-ID: <4195446e-2d2b-442c-a1ad-b1498d243a70@linux.alibaba.com>
Date: Thu, 10 Oct 2024 20:21:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: pass u64 to ocfs2_truncate_inline maybe overflow
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+81092778aac03460d6b7@syzkaller.appspotmail.com
Cc: jlbec@evilplan.org, linux-kernel@vger.kernel.org, mark@fasheh.com,
 ocfs2-devel@lists.linux.dev, syzkaller-bugs@googlegroups.com
References: <67062030.050a0220.3f80e.0024.GAE@google.com>
 <tencent_B22CA96C8896C0E9FEEFD2CCAC795A6E500A@qq.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <tencent_B22CA96C8896C0E9FEEFD2CCAC795A6E500A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/9/24 11:05 PM, Edward Adam Davis wrote:
> Syzbot reported a kernel BUG in ocfs2_truncate_inline.
> There are two reasons for this: first, the parameter value passed is greater
> than UINT_MAX, second, the start and end parameters of ocfs2_truncate_inline
> are "unsigned int".
> 
> So, we need to add a sanity check for offset and len in ocfs2_fallocate, if
> they are greater than UINT_MAX return -EFBIG.

fallocate should accept loff_t (aka long long) offset and len.
I guess the reported bug is caused by a crafted image, which set
overflow offset and len in case of inline data (with flag
OCFS2_INLINE_DATA_FL set).
So IMO, the right place to add a sanity check is right before
ocfs2_truncate_inline() in ocfs2_remove_inode_range().

Thanks,
Joseph

> 
> Reported-and-tested-by: syzbot+81092778aac03460d6b7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=81092778aac03460d6b7
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/ocfs2/file.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
> index ad131a2fc58e..ed26ec8ac6b6 100644
> --- a/fs/ocfs2/file.c
> +++ b/fs/ocfs2/file.c
> @@ -2117,6 +2117,9 @@ static long ocfs2_fallocate(struct file *file, int mode, loff_t offset,
>  			return ret;
>  	}
>  
> +	if (offset > UINT_MAX || offset + len > UINT_MAX)
> +		return -EFBIG;
> +
>  	if (mode & FALLOC_FL_PUNCH_HOLE)
>  		cmd = OCFS2_IOC_UNRESVSP64;
>  


