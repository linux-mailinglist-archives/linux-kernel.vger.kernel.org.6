Return-Path: <linux-kernel+bounces-285819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA81C951326
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ABC6284B49
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773743BB48;
	Wed, 14 Aug 2024 03:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4tfajyt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22912BB1C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723606417; cv=none; b=fJzWqinGWUFbVJSrpnKZRJxsZRUYBaB/ENoW2IbBa+GmOaSkRtu6UoWlsHukcZ2geeVSphxmGVT2lNvjYZvM1eQd08fLVqmfZWQnmVARvEjCnkVzFL47f+TjpNcYjQDcZGebxzHeIxfjeRHqYThhFQ1gBLNJCbEiNnhqLFKKvws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723606417; c=relaxed/simple;
	bh=EpuLSgfvUytePDBb/IQzp2Wnvo6eIoYC51acrnOgLbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EXEH8cRyxMiFAZRWZ54l2q6LINDLAMCmSPaZShQdX7xR4SZEq7uec8cttDkYNRvX4SGKMVIsFOn3Y9aSHY5vdldhw/OYq4eDNKMaEbP+qkjY11eCKdrnkwjo8ac1qXAkLYEP2Sx0oOL+/bulOMtf5yTrFvtUbgrWJZHJxYWrf8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4tfajyt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A14C32782;
	Wed, 14 Aug 2024 03:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723606416;
	bh=EpuLSgfvUytePDBb/IQzp2Wnvo6eIoYC51acrnOgLbE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t4tfajytKCQfAlcaVn6v+H1gnB28gQ2+8v/5q+SD+j+qRlXuHq69Ocr2BrGYTCslM
	 GRXL7pHRxjNDWmtsNaX/zgQF9zQJRlzDSGu6FG7ScnpTrMhE0cD5PgiG62Z++7YQOE
	 zR0ZtvRUyZPnedyqge4kXRmRm0GhHCYzEaQMHcBwRvBE25VW7rauPMYnmk+3xFtFle
	 N9jMqk18F8FCb/fo3BjG6yfDJR7wT6jWLpmAIMFHNvxGA2oEWauPogfzZ4ofWTCdU/
	 174q7vlDWIVKIg23YMGBYu+5zrsfxEJ/5d4pSSLuuxiMP3oLL/yky3WU+QO3Cg58YD
	 OJQNaQ96vp85Q==
Message-ID: <02214d48-6aee-40f7-9a40-60b4091b5bfa@kernel.org>
Date: Wed, 14 Aug 2024 11:33:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [f2fs?] WARNING: lock held when returning to user space
 in f2fs_commit_atomic_write
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+78ff2855f26377625419@syzkaller.appspotmail.com
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000ebae95061f96be85@google.com>
 <tencent_E51B7925E5BAF4BBCF33739E5E1BFA4B9F08@qq.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <tencent_E51B7925E5BAF4BBCF33739E5E1BFA4B9F08@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/14 8:48, Edward Adam Davis wrote:
> unlock i_gc_rwsem[WRITE] before quiting f2fs_commit_atomic_write
> 
> Fixes: 7566a155c666 ("f2fs: atomic: fix to not allow GC to pollute atomic_file")

Since original patch has not been merged, if you don't mind, I'd like to
fix this issue in original patch.

Thanks,

> Reported-by: syzbot+78ff2855f26377625419@syzkaller.appspotmail.com
> 
> #syz test: net-next 9e6869691724
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 741e46f9d0fd..a43054ab0cf1 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -389,13 +389,13 @@ int f2fs_commit_atomic_write(struct inode *inode)
>   
>   	err = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
>   	if (err)
> -		return err;
> +		goto out;
>   
>   	/* writeback GCing page of cow_inode */
>   	err = filemap_write_and_wait_range(fi->cow_inode->i_mapping,
>   							0, LLONG_MAX);
>   	if (err)
> -		return err;
> +		goto out;
>   
>   	filemap_invalidate_lock(inode->i_mapping);
>   
> @@ -407,6 +407,7 @@ int f2fs_commit_atomic_write(struct inode *inode)
>   	f2fs_unlock_op(sbi);
>   
>   	filemap_invalidate_unlock(inode->i_mapping);
> +out:
>   	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
>   
>   	return err;
> 


