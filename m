Return-Path: <linux-kernel+bounces-419378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0679D6D1D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 09:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ACFB1618B2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 08:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2861183CD9;
	Sun, 24 Nov 2024 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YjeBGtSw"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB4744375
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 08:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732437405; cv=none; b=g72DrPj4MPF676ot7a8VHYD/6LTnQDAt8HrV6QYfVHZwQU2njSTRf5QTIAeU/5L72tkn60oJfEd+eSsnr/8BW3USgXJHXyS6dljqc/XQLW05iZN1vpAwEd4ZUsMuE1dEoMon8j0HT7/0Z9VaxCF5Nch5boO47SHB0UK15FKIVks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732437405; c=relaxed/simple;
	bh=+CWBj7uejc7DnA9rcWa0+bctzwGNzqax+sYwVhEwiLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oBFHl+QwsadkUOisKpM7xsRldowGkzAPaYwZe8IpAOPdin+H0BAuURivxO0TwhVWcAJnfWLkJuu4CfkKm/y8ZgYwQjd+K9fC8Pc6rHpbKek5fNel7EopYkewdVXwZnPcz9vN6P6BuAga6dJVePRtrcgKftmcVJ67WGAlfJnq/P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YjeBGtSw; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732437394; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=I3WHn4//LTmtTo4tQJwfIjafWRiAfKaDSeGtTrDrAVQ=;
	b=YjeBGtSw3TzrpGhulTXJuZBZ2711+bgjJm25Dj8QXqdbrGQqCC2lwBV0Y6cHMVcQtMJ6jy6a56y840McnVogC+R+GP+zW4K6rcSR9sOsrpALLV7l/fhxiqsWsFHjcskRvmhU97+jPpIS94he/nct2bXc37XiGj9OUagxsmpC6e0=
Received: from 30.15.212.173(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WK3akUz_1732437392 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 24 Nov 2024 16:36:33 +0800
Message-ID: <9ab2ceb5-1450-4207-b6bb-2a09432799d4@linux.alibaba.com>
Date: Sun, 24 Nov 2024 16:36:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: free inode when ocfs2_get_init_inode() fails
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 akpm <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Junxiao Bi <junxiao.bi@oracle.com>,
 Jan Kara <jack@suse.com>,
 "ocfs2-devel@lists.linux.dev" <ocfs2-devel@lists.linux.dev>
References: <e68c0224-b7c6-4784-b4fa-a9fc8c675525@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <e68c0224-b7c6-4784-b4fa-a9fc8c675525@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/23/24 9:28 PM, Tetsuo Handa wrote:
> syzbot is reporting busy inodes after unmount, for commit 9c89fe0af826
> ("ocfs2: Handle error from dquot_initialize()") forgot to call iput()
> when new_inode() succeeded and dquot_initialize() failed.
> 
> Reported-by: syzbot+0af00f6a2cba2058b5db@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=0af00f6a2cba2058b5db
> Tested-by: syzbot+0af00f6a2cba2058b5db@syzkaller.appspotmail.com
> Fixes: 9c89fe0af826 ("ocfs2: Handle error from dquot_initialize()")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/namei.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
> index 59c92353151a..5550f8afa438 100644
> --- a/fs/ocfs2/namei.c
> +++ b/fs/ocfs2/namei.c
> @@ -200,8 +200,10 @@ static struct inode *ocfs2_get_init_inode(struct inode *dir, umode_t mode)
>  	mode = mode_strip_sgid(&nop_mnt_idmap, dir, mode);
>  	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
>  	status = dquot_initialize(inode);
> -	if (status)
> +	if (status) {
> +		iput(inode);
>  		return ERR_PTR(status);
> +	}
>  
>  	return inode;
>  }


