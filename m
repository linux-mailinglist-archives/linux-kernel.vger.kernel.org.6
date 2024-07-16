Return-Path: <linux-kernel+bounces-253221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 984E1931E4D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A86F282E5B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 01:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCD84428;
	Tue, 16 Jul 2024 01:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nqEHI2vk"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8829187F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721092231; cv=none; b=Q3h39UsEyvT9nWN3ym5qRasjf2sujiD8qIntHt5DaMSFlwtIoWTQw6XLceDLKpk6PwTs3UNd8b7RfbM3yLv4xqaaLaRR33M+8CfHVRi/qWuyxb9h+3yQSFqugGyov0600eKMnwGGtRfZrTSkXzXI+UrGEdEhCubj1mK/ryy0u6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721092231; c=relaxed/simple;
	bh=x4ienU8575CT/oh9h/ruLYvvXKSyslfJoy+Cou03kmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QkFJM2Vhq40NR2RNxnpEWiiKO+QUanR7c1Gff9D0WAR9JmX/foUQ+6n2/Aoac/9k07CNjVvA4bpeTVU24emQlAvoZuR5CG7rGthLec6QE8kZS8+3EDN7O5tUcLTZOsGTv+5NwfAfsKw6Tgf9b3TvKcOiQ3J4DSLUQH+/lxLy/fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nqEHI2vk; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721092220; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=podFBawq3qUWxC6GJyKeZzxgJkUfZhMQQKmWCfiivqg=;
	b=nqEHI2vkVBuYAvbxa3AzffFCgL7kfHvH8JiuCfz3wSwkTMaJyPsN+GByvpEa7792I47WF7hKgwQLiParuIwAAxwPv7cbt+nb7HKY+G9COnZhiSmwrFRUKVl09BsPH33qmrThHXUMlagDtKBkY2IMvyqkvUPbXEb3dWOqF6kA/RI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0WAfKy4l_1721092218;
Received: from 30.221.128.129(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WAfKy4l_1721092218)
          by smtp.aliyun-inc.com;
          Tue, 16 Jul 2024 09:10:19 +0800
Message-ID: <afca4e22-7edd-494f-9a43-66d1098a3ec4@linux.alibaba.com>
Date: Tue, 16 Jul 2024 09:10:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] quota: avoid missing put_quota_format when
 DQUOT_SUSPENDED is passed
To: Kemeng Shi <shikemeng@huaweicloud.com>, jack@suse.com
Cc: mark@fasheh.com, jlbec@evilplan.org, hughd@google.com,
 akpm@linux-foundation.org, ocfs2-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240715130534.2112678-1-shikemeng@huaweicloud.com>
 <20240715130534.2112678-2-shikemeng@huaweicloud.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20240715130534.2112678-2-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/15/24 9:05 PM, Kemeng Shi wrote:
> Avoid missing put_quota_format when DQUOT_SUSPENDED is passed to
> dquot_load_quota_sb.
> 

It seems worth a 'Fixes' tag:
Fixes: d44c57663723 ("quota: Remove BUG_ON in dquot_load_quota_sb()")

Other looks good to me. So with the above addressed, feel free to add:
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/quota/dquot.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 627eb2f72ef3..23fcf9e9d6c5 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -2408,7 +2408,7 @@ static int vfs_setup_quota_inode(struct inode *inode, int type)
>  int dquot_load_quota_sb(struct super_block *sb, int type, int format_id,
>  	unsigned int flags)
>  {
> -	struct quota_format_type *fmt = find_quota_format(format_id);
> +	struct quota_format_type *fmt;
>  	struct quota_info *dqopt = sb_dqopt(sb);
>  	int error;
>  
> @@ -2418,6 +2418,7 @@ int dquot_load_quota_sb(struct super_block *sb, int type, int format_id,
>  	if (WARN_ON_ONCE(flags & DQUOT_SUSPENDED))
>  		return -EINVAL;
>  
> +	fmt = find_quota_format(format_id);
>  	if (!fmt)
>  		return -ESRCH;
>  	if (!sb->dq_op || !sb->s_qcop ||

