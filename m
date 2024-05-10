Return-Path: <linux-kernel+bounces-175255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286628C1D15
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 05:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE49283EF5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 03:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F126149C43;
	Fri, 10 May 2024 03:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBP8m2hQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99310524C4
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 03:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715312217; cv=none; b=aMZQ3ODzvaA/IXFw76+Z7cXPhAInyo6WeeoL2gWwHYB9F79/IhlXAtYKO5WW69FZpBo3fkGzz1GnLe1xWwybVNqbRHI2sCshFW7wQsP4NPBReRTQ9Nzrme5yd1HTv7TbfqE5qVuOxrDJxa1LdRywu8D37cjdfXgowb12e77Kf90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715312217; c=relaxed/simple;
	bh=1KviGYd5beyNX2PBlLyIIAQ0SMbAih+SYoo5RKeNBEE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Rtv+O6A5iKpbW98O7kOJhjLGpdyPVjhWE8HLR+q3hZrv5k64t8LyNo+ZKBreKn8ji3A8nIc/0WIVpVO3ZWMy7rXiyFKl97CICDy6Mrw3BibhQWOMXoMXQc1zEpGMDQCnkKogGYk5oETEZlPnjR+pN7Kh5C4xp1B43IE0Jy0+GrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBP8m2hQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9137DC113CC;
	Fri, 10 May 2024 03:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715312217;
	bh=1KviGYd5beyNX2PBlLyIIAQ0SMbAih+SYoo5RKeNBEE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=hBP8m2hQxhieQldc8KDb6vku9VRUD5vfmOv6LIxyK18cKM8+DqLMF/LmKoZXwVwz6
	 bIOmr+nPSe9hZ+8tfjV5080kM100ppP4/QghvFkZoNdbdwCfvo7zk9LT8yw2Zxxfq5
	 iXfwpgKihp90C8K4Lii7hB1Q0xbo5fDvtKrUTx4DoRKcFY0DbGOryRYorHW0IlvEBu
	 ulS8j5OIsfEfapYP0XtG/9dvXQv2pkqKlz56uwdaugCTt1YEqhPRaSlbUcpL6kRXDa
	 d1OxZnwDVdj58W7vE6tUzSlUJgugIILJpXRCEjnn16/qGqmjE+IWw4kxWXYI4fHKpc
	 JOdkeAsUnNDaA==
Message-ID: <a67948c7-6268-4c25-990d-8946814c7c4e@kernel.org>
Date: Fri, 10 May 2024 11:36:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: fix to add missing iput() in
 gc_data_segment()
From: Chao Yu <chao@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20240506103313.773503-1-chao@kernel.org>
 <20240506103313.773503-2-chao@kernel.org> <Zjwc5QGJfm6XXzOX@google.com>
 <32e097e6-67f1-4f06-bad0-0c7b3afb46f0@kernel.org>
Content-Language: en-US
In-Reply-To: <32e097e6-67f1-4f06-bad0-0c7b3afb46f0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/5/9 10:49, Chao Yu wrote:
> On 2024/5/9 8:46, Jaegeuk Kim wrote:
>> On 05/06, Chao Yu wrote:
>>> During gc_data_segment(), if inode state is abnormal, it missed to call
>>> iput(), fix it.
>>>
>>> Fixes: 132e3209789c ("f2fs: remove false alarm on iget failure during GC")

Oh, this line should be replaced w/ below one, let me revise the patch.

Fixes: b73e52824c89 ("f2fs: reposition unlock_new_inode to prevent accessing invalid inode").

Thanks,

>>> Fixes: 9056d6489f5a ("f2fs: fix to do sanity check on inode type during garbage collection")
>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>> ---
>>>   fs/f2fs/gc.c | 9 +++++++--
>>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>> index 8852814dab7f..e86c7f01539a 100644
>>> --- a/fs/f2fs/gc.c
>>> +++ b/fs/f2fs/gc.c
>>> @@ -1554,10 +1554,15 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>>>               int err;
>>>               inode = f2fs_iget(sb, dni.ino);
>>> -            if (IS_ERR(inode) || is_bad_inode(inode) ||
>>> -                    special_file(inode->i_mode))
>>> +            if (IS_ERR(inode))
>>>                   continue;
>>> +            if (is_bad_inode(inode) ||
>>> +                    special_file(inode->i_mode)) {
>>> +                iput(inode);
>>
>> iget_failed() called iput()?
> 
> It looks the bad inode was referenced in this context, it needs to be iput()ed
> here.
> 
> The bad inode was made in other thread, please check description in commit
> b73e52824c89 ("f2fs: reposition unlock_new_inode to prevent accessing invalid
> inode").
> 
> Thanks,
> 
>>
>>
>>> +                continue;
>>> +            }
>>> +
>>>               err = f2fs_gc_pinned_control(inode, gc_type, segno);
>>>               if (err == -EAGAIN) {
>>>                   iput(inode);
>>> -- 
>>> 2.40.1
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

