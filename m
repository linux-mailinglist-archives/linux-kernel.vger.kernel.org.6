Return-Path: <linux-kernel+bounces-287381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2046695272B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 02:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5442F1C217DD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FA34A3E;
	Thu, 15 Aug 2024 00:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KH5ey9aW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E847B4A04
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 00:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723683097; cv=none; b=PnRUGRLf3gSXRKMaG0pTSXpJCkOsbAkQrDPvU/POylg98KbG62XddSG7L8RCTI/HbxRUyqkP4Jf1+pEmeroAnG0NktWDigINH6ApgvSjWhyo0jSYdEsP+xl4A0Of0rA9X5o9gUoXcEqLiinqvY4UNP+cw6XisZTmwNlT1kYyEeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723683097; c=relaxed/simple;
	bh=pPzJvLK4QhT/YIFBLvsdlqwEKbdcS1cslS2BGsUwV1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RNffJRW1dEtzcRixv3mP55p6J+WtxXJH91+qC8cE5R3WtTkLivYMU9jvq64Xm6MVaSmf/FdkWdQpm9KU9N5BioDUXGHMmIB3vESlNVtXSzgjtd48Dm2aaQzPLQl9HpsJuOpRKYBIuBhOOXxCEq4Ha/uhkmR0fYeKaLWgKCodWd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KH5ey9aW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5707C116B1;
	Thu, 15 Aug 2024 00:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723683096;
	bh=pPzJvLK4QhT/YIFBLvsdlqwEKbdcS1cslS2BGsUwV1s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KH5ey9aWoFgXYB82sXPybGE6NIClJr9ElHCv5l24WRTZ3YVYYy96e8VsbXGuJVtNS
	 kgiAC4qX8TDB1+h0lf3sLhR1yfCmfruXlNUKkNCZbfSdSY+9f5E8TRHIb7+IKLnAhV
	 DnzwVHtNUFGfAJsZ98IMemn/qjBDwZUu2/sufX62z+Wr9rUTJFBqAhqrzcKJpWy2OI
	 /VgSotL9jOMeLAe44KmQlRntNetVTCdLATvBFtPGmUs+5lEYqUWuZyNFVbF6n5plLu
	 Rm+TibJtiX/HkR6nrM/crWXVD3fOX0yZZE3zqbz8NEv9vBJVJIK7tnKmoo8l4lWQov
	 QfnKpZhw/2Yyg==
Message-ID: <efcc15bf-0248-4690-b4d4-11022d12cffd@kernel.org>
Date: Thu, 15 Aug 2024 08:51:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: fix unreleased reader lock on return
To: Diogo Jahchan Koike <djahchankoike@gmail.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org,
 syzbot+733300ca0a9baca7e245@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <20240814211640.167728-1-djahchankoike@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240814211640.167728-1-djahchankoike@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/15 5:16, Diogo Jahchan Koike wrote:
> fix reader lock unreleased in error path.

Thank you for catching this, if you don't mind, I'd like to merge it to
original patch, since it is still in dev-test branch.

Thanks,

> 
> Fixes: 374a8881ce4c ("f2fs: atomic: fix to forbid dio in atomic_file")
> Reported-by: syzbot+733300ca0a9baca7e245@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=733300ca0a9baca7e245
> Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
> ---
>   fs/f2fs/file.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 51f6ffd5f4e2..c9eda5dbd11f 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2172,6 +2172,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
>   	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
>   	if (ret) {
>   		f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> +		f2fs_up_write(&fi->i_gc_rwsem[READ]);
>   		goto out;
>   	}
>   
> @@ -2181,6 +2182,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
>   		pinode = f2fs_iget(inode->i_sb, fi->i_pino);
>   		if (IS_ERR(pinode)) {
>   			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> +			f2fs_up_write(&fi->i_gc_rwsem[READ]);
>   			ret = PTR_ERR(pinode);
>   			goto out;
>   		}
> @@ -2189,6 +2191,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
>   		iput(pinode);
>   		if (ret) {
>   			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> +			f2fs_up_write(&fi->i_gc_rwsem[READ]);
>   			goto out;
>   		}
>   
> @@ -2202,6 +2205,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
>   		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
>   		if (ret) {
>   			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> +			f2fs_up_write(&fi->i_gc_rwsem[READ]);
>   			goto out;
>   		}
>   	}


