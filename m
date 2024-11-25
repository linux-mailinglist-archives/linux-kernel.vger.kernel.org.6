Return-Path: <linux-kernel+bounces-420902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1929D85A4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36657B2D017
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8B1198A32;
	Mon, 25 Nov 2024 11:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGxN0JJ8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258D119645D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732533406; cv=none; b=JH+pmsI7CJffFVI2wKT5LViCoccOrrUl7tBAPloofzXpEwAypn2sMOloZrGe6DYCpj+7I0P7h1gmeqgSgoUgO2IcrS00/+Tgi3jka3deiqUDO4zHv+8hb80r7H2KKOgorfsFk9tKDfXCRudMABsrHOnb1I8Zk+8jCwnPtKUXAak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732533406; c=relaxed/simple;
	bh=MQjAuGpJVWbMJ1zAOHz6b/mSD730j2sw5ncxWR5rivY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IUZMTLT87PG8RnZNIy/G8nwrjYaKcS7E/zidEJF/wKHZnAWVUtQbAxfRPX8ZTxAuX+SmR9lUEwdAuhdv/31CEWu1TkOhUwR6Hpzk14qvfJOdepFu6MCaV+kfPc/nh4AscFW6oAuTF1SCMJ3/zqikNIlMPjfy7+MvynRn6pSQdPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGxN0JJ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6A7C4CED2;
	Mon, 25 Nov 2024 11:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732533405;
	bh=MQjAuGpJVWbMJ1zAOHz6b/mSD730j2sw5ncxWR5rivY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ZGxN0JJ8pb+aqiVRGlD0FH1DKLTavbUA3nhu6ujUI5x247t7kqr21gX1bGGbIB7Yy
	 RvkMMyA9RsyPa+Pfn/ZdV1qoyKEC0Z/3wZy5/2HOY/wYtBKVUDsJRv3ERvBpma83Rs
	 i0hu4f4BWpzsAkaZwOUgHGOXR9bNb/fglkRSA5k5ELe1SVbvtHCVObnLC55IAJ3LUW
	 d79hpXotSchIBfybxIdQaAFLVMMa9bz1ZvVeS8meW8kBNM00ho1nJ5TGw7mule+aWV
	 7y2YymZAGlQ6cQdQ1oJ5RTwUH6m1AF35LQZy3/m0Y7tDkY5Ub9f0lHo0qGI/X+aY64
	 +xEgGA806jnnw==
Message-ID: <1652260c-7657-4f40-ac79-027666f512f0@kernel.org>
Date: Mon, 25 Nov 2024 19:16:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: Add check for deleted inode
To: Leo Stone <leocstone@gmail.com>, jaegeuk@kernel.org
References: <20241124010459.23283-1-leocstone@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241124010459.23283-1-leocstone@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/11/24 9:04, Leo Stone wrote:
> The syzbot reproducer mounts a f2fs image, then tries to unlink an
> existing file. However, the unlinked file already has a link count of 0
> when it is read for the first time in do_read_inode().
> 
> Add a check to sanity_check_inode() for i_nlink == 0.
> 
> #syz test
> 
> Reported-by: syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b01a36acd7007e273a83
> Fixes: 4c8ff7095bef ("f2fs: support data compression")

Hello Leo,

I'm fine w/ this change, but I didn't get it, how did above commit introduce
this bug?

Thanks,

> Signed-off-by: Leo Stone <leocstone@gmail.com>
> ---
>   fs/f2fs/inode.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 1ed86df343a5..65f1dc32f173 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -372,6 +372,12 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
>   		return false;
>   	}
>   
> +	if (inode->i_nlink == 0) {
> +		f2fs_warn(sbi, "%s: inode (ino=%lx) has a link count of 0",
> +			  __func__, inode->i_ino);
> +		return false;
> +	}
> +
>   	return true;
>   }
>   


