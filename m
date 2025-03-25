Return-Path: <linux-kernel+bounces-574886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F190AA6EB20
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4731890D35
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770191A8F6E;
	Tue, 25 Mar 2025 08:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F27BsnLZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D872319E98A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742890165; cv=none; b=fqLEHxF6NGaLbLz62Wpnrv5bi8mDktSWsj4MC6jgY5RDxWMGCPaus6EzXLSswMq3YHRt/mG5HxbsyCDdEfSznRdY1fJP5ibT1HQpM4fZI3DrD86rwug360+CHB0rLK3Jk9VbnIprlhb2U/a9wigDwJ7PsY2jQ6bu8gVY2czGMPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742890165; c=relaxed/simple;
	bh=t7ku1Yjv6c5+qa7d3xQ27A85ZDF0wVyffRWddMb6pmo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oIGiN6wW1Ik9p13iTspK76uENFtTyJY+ZRDiGKqyqSSTDFQVLEhL6rvWoFD8BGbEwbhTMNM3qL0lq5DDnSUeYfRZ/UoiKOUmRRPoxnxmFCFMjwFsO9Gxhq3l5ZkUXGVeKZWWrOI3AJ34O6gJmonz+CxUO4f/g7b1bqdzAFiASAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F27BsnLZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF85C4CEE4;
	Tue, 25 Mar 2025 08:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742890165;
	bh=t7ku1Yjv6c5+qa7d3xQ27A85ZDF0wVyffRWddMb6pmo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=F27BsnLZ88Cj6eKSR/GsIDu9JFjnbDybcenIapq4WyFl4xsd18gDrlRAYTIgD02AH
	 YEibtBuB2WH9nIeFD0ZTa7LPIISwlap82XdK8VOHlnDmRl/vdsd62SctAVTe0T+2b4
	 4ULNZytLTrHBK4hbPKALe3B1STUE0yR1/Zjz1ct08DfJbaCI56RLg9SjXQX+0PsFJm
	 7Lwu1g65OB3VcD5xWKdKGLaiUpwzXuzo7IwChNkViaLPw7++SeJbW72JL6gCl7Sf5K
	 3AR5/b7lF+w1K0Mon/974n0UC9xANZAsjGCk+2MeefkkieCqu0uU9zMCsdagaSUTfT
	 PKc5zMDBmFAcg==
Message-ID: <1afd3158-19bb-472b-905e-6ae0c6e7a416@kernel.org>
Date: Tue, 25 Mar 2025 16:09:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: add a fast path in
 finish_preallocate_blocks()
To: Zhiguo Niu <niuzhiguo84@gmail.com>
References: <20250324113249.3084413-1-chao@kernel.org>
 <CAHJ8P3L0vJKdLQMSGGQJuDD3_++8BhV1b4cvL4PCFu0WY+EWwg@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3L0vJKdLQMSGGQJuDD3_++8BhV1b4cvL4PCFu0WY+EWwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/25/25 14:31, Zhiguo Niu wrote:
> Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
> 于2025年3月24日周一 19:36写道：
>>
>> This patch uses i_sem to protect access/update on f2fs_inode_info.flag
>> in finish_preallocate_blocks(), it avoids grabbing inode_lock() in
>> each open().
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>  fs/f2fs/file.c | 40 +++++++++++++++++++++++-----------------
>>  1 file changed, 23 insertions(+), 17 deletions(-)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index abbcbb5865a3..bb6ba3269de0 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -554,19 +554,24 @@ static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
>>
>>  static int finish_preallocate_blocks(struct inode *inode)
>>  {
>> -       int ret;
>> +       int ret = 0;
>> +       bool opened;
>>
>> -       inode_lock(inode);
>> -       if (is_inode_flag_set(inode, FI_OPENED_FILE)) {
>> -               inode_unlock(inode);
>> +       f2fs_down_read(&F2FS_I(inode)->i_sem);
>> +       opened = is_inode_flag_set(inode, FI_OPENED_FILE);
>> +       f2fs_up_read(&F2FS_I(inode)->i_sem);
>> +       if (opened)
>>                 return 0;
>> -       }
>>
>> -       if (!file_should_truncate(inode)) {
>> -               set_inode_flag(inode, FI_OPENED_FILE);
>> -               inode_unlock(inode);
>> -               return 0;
>> -       }
>> +       inode_lock(inode);
>> +       f2fs_down_read(&F2FS_I(inode)->i_sem);
>> +       opened = is_inode_flag_set(inode, FI_OPENED_FILE);
>> +       f2fs_up_read(&F2FS_I(inode)->i_sem);
> Hi Chao,
> F2FS_I(inode)->i_sem is not needed for this judgment FI_OPENED_FILE area?
> because inode_lock has been hold and this is a write lock, if process
> A get inode_lock,
> other proccesses will be blocked inode_lock until inode_unlock with
> FI_OPENED_FILE  been set?
> how do you think?

Zhiguo,

Agreed, let me update it. Thank you.

Thanks,

> thanks！
>> +       if (opened)
>> +               goto out_unlock;
>> +
>> +       if (!file_should_truncate(inode))
>> +               goto out_update;
>>
>>         f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>         filemap_invalidate_lock(inode->i_mapping);
>> @@ -576,16 +581,17 @@ static int finish_preallocate_blocks(struct inode *inode)
>>
>>         filemap_invalidate_unlock(inode->i_mapping);
>>         f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>> -
>> -       if (!ret)
>> -               set_inode_flag(inode, FI_OPENED_FILE);
>> -
>> -       inode_unlock(inode);
>>         if (ret)
>> -               return ret;
>> +               goto out_unlock;
>>
>>         file_dont_truncate(inode);
>> -       return 0;
>> +out_update:
>> +       f2fs_down_write(&F2FS_I(inode)->i_sem);
>> +       set_inode_flag(inode, FI_OPENED_FILE);
>> +       f2fs_up_write(&F2FS_I(inode)->i_sem);
>> +out_unlock:
>> +       inode_unlock(inode);
>> +       return ret;
>>  }
>>
>>  static int f2fs_file_open(struct inode *inode, struct file *filp)
>> --
>> 2.48.1
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


