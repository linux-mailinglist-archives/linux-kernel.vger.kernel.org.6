Return-Path: <linux-kernel+bounces-204110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AB78FE451
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE121F27865
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA07194ADB;
	Thu,  6 Jun 2024 10:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJaitnj1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45C513E048
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669885; cv=none; b=M9l2lzOlvofl3uYFJBD9WhXsEHQgkyeELrBdzE+Rm/vlVxrsaK/H6tGbLPyXq3fOIp9fynY/nbaKn7bWpAgr6vaDHhG8CA6sW/yHzeGS82raZO9yUcf+CPxmWsf6k+EA3sOJPiL4pBWcjbQRbxfCmkVY4gfpIXMwlnI+b8s5tIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669885; c=relaxed/simple;
	bh=GYdrlfDE3VBqGRrQYoVOCv+j+7jIOcaApwD/kEhgQ8k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CG3el87qzgBRouKtUQ1uZek1GpKaEzgaIe04YB60HrrzcyVoWDu12E5lMfvsyTNulMDT3zN7yW7oJSdyc7wjFXaBlGduSo3VzEHfKkay1cbB961w7EOULNzyDVE+X2wWHJ59qMucTdD/1ZvxTLBO1kpEW8T8+Zl1GcpeTcSJdUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJaitnj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF89C4AF0D;
	Thu,  6 Jun 2024 10:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717669885;
	bh=GYdrlfDE3VBqGRrQYoVOCv+j+7jIOcaApwD/kEhgQ8k=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=mJaitnj1dJzmCbP8CRWNLe0a5BbDsL1yNy9y/B0XEpO00si0z5fpIs7E2PEuI2+nW
	 azhjXmxl+pwfjhs3tsvHg4gAtjqIhz5RkaRhiUQLAuy6Dn23+Cm+3beHEB3B6qn/j5
	 pb6QDwZpezaugwf5PMnDR7b+oIzKIn8bbwFWuhIhgHUvISHzweGzVp8JqItS6l4xYx
	 F6U8Gu7jvj35MX2yy3Pwc3Dl6P89ueNK/pZayCBaLhjrlHb/56ZioqyfJXQLXuXS1Y
	 2owRg4/+mMe6dQD1JzbDof+eMTtO72FiyhSZAE7KI561GO2fmNAzLOlSuBWVrEY8QB
	 C0Ilnv+Cy2nJQ==
Message-ID: <4ac4f5cf-7748-4ee4-8d68-8842d8bf1753@kernel.org>
Date: Thu, 6 Jun 2024 18:31:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to avoid racing in between read
 and OPU dio write
From: Chao Yu <chao@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20240510023906.281700-1-chao@kernel.org>
 <ZkOMwKAcKmEPQ4Xz@google.com>
 <fc0d8b1f-0c54-4447-8ceb-3722645f71c2@kernel.org>
 <ZkQ9Uo5713Xpr2n7@google.com>
 <efae597c-d334-498b-9050-1a21bf40e21d@kernel.org>
Content-Language: en-US
In-Reply-To: <efae597c-d334-498b-9050-1a21bf40e21d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/5/15 14:38, Chao Yu wrote:
> On 2024/5/15 12:42, Jaegeuk Kim wrote:
>> On 05/15, Chao Yu wrote:
>>> On 2024/5/15 0:09, Jaegeuk Kim wrote:
>>>> On 05/10, Chao Yu wrote:
>>>>> If lfs mode is on, buffered read may race w/ OPU dio write as below,
>>>>> it may cause buffered read hits unwritten data unexpectly, and for
>>>>> dio read, the race condition exists as well.
>>>>>
>>>>> Thread A                      Thread B
>>>>> - f2fs_file_write_iter
>>>>>    - f2fs_dio_write_iter
>>>>>     - __iomap_dio_rw
>>>>>      - f2fs_iomap_begin
>>>>>       - f2fs_map_blocks
>>>>>        - __allocate_data_block
>>>>>         - allocated blkaddr #x
>>>>>          - iomap_dio_submit_bio
>>>>>                                 - f2fs_file_read_iter
>>>>>                                  - filemap_read
>>>>>                                   - f2fs_read_data_folio
>>>>>                                    - f2fs_mpage_readpages
>>>>>                                     - f2fs_map_blocks
>>>>>                                      : get blkaddr #x
>>>>>                                     - f2fs_submit_read_bio
>>>>>                                 IRQ
>>>>>                                 - f2fs_read_end_io
>>>>>                                  : read IO on blkaddr #x complete
>>>>> IRQ
>>>>> - iomap_dio_bio_end_io
>>>>>    : direct write IO on blkaddr #x complete
>>>>>
>>>>> This patch introduces a new per-inode i_opu_rwsem lock to avoid
>>>>> such race condition.
>>>>
>>>> Wasn't this supposed to be managed by user-land?
>>>
>>> Actually, the test case is:
>>>
>>> 1. mount w/ lfs mode
>>> 2. touch file;
>>> 3. initialize file w/ 4k zeroed data; fsync;
>>> 4. continue triggering dio write 4k zeroed data to file;
>>> 5. and meanwhile, continue triggering buf/dio 4k read in file,
>>> use md5sum to verify the 4k data;
>>>
>>> It expects data is all zero, however it turned out it's not.
>>
>> Can we check outstanding write bios instead of abusing locks?

Jaegeuk, seems it can solve partial race cases, not all of them.

Do you suggest to use this compromised solution?

Thanks,

> 
> I didn't figure out a way to solve this w/o lock, due to:
> - write bios can be issued after outstanding write bios check condition,
> result in the race.
> - once read() detects that there are outstanding write bios, we need to
> delay read flow rather than fail it, right? It looks using a lock is more
> proper here?
> 
> Any suggestion?
> 
> Thanks,
> 
>>
>>>
>>> Thanks,
>>>
>>>>
>>>>>
>>>>> Fixes: f847c699cff3 ("f2fs: allow out-place-update for direct IO in LFS mode")
>>>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>>>> ---
>>>>> v2:
>>>>> - fix to cover dio read path w/ i_opu_rwsem as well.
>>>>>    fs/f2fs/f2fs.h  |  1 +
>>>>>    fs/f2fs/file.c  | 28 ++++++++++++++++++++++++++--
>>>>>    fs/f2fs/super.c |  1 +
>>>>>    3 files changed, 28 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>> index 30058e16a5d0..91cf4b3d6bc6 100644
>>>>> --- a/fs/f2fs/f2fs.h
>>>>> +++ b/fs/f2fs/f2fs.h
>>>>> @@ -847,6 +847,7 @@ struct f2fs_inode_info {
>>>>>         /* avoid racing between foreground op and gc */
>>>>>         struct f2fs_rwsem i_gc_rwsem[2];
>>>>>         struct f2fs_rwsem i_xattr_sem; /* avoid racing between reading and changing EAs */
>>>>> +     struct f2fs_rwsem i_opu_rwsem;  /* avoid racing between buf read and opu dio write */
>>>>>
>>>>>         int i_extra_isize;              /* size of extra space located in i_addr */
>>>>>         kprojid_t i_projid;             /* id for project quota */
>>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>>> index 72ce1a522fb2..4ec260af321f 100644
>>>>> --- a/fs/f2fs/file.c
>>>>> +++ b/fs/f2fs/file.c
>>>>> @@ -4445,6 +4445,7 @@ static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
>>>>>         const loff_t pos = iocb->ki_pos;
>>>>>         const size_t count = iov_iter_count(to);
>>>>>         struct iomap_dio *dio;
>>>>> +     bool do_opu = f2fs_lfs_mode(sbi);
>>>>>         ssize_t ret;
>>>>>
>>>>>         if (count == 0)
>>>>> @@ -4457,8 +4458,14 @@ static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
>>>>>                         ret = -EAGAIN;
>>>>>                         goto out;
>>>>>                 }
>>>>> +             if (do_opu && !f2fs_down_read_trylock(&fi->i_opu_rwsem)) {
>>>>> +                     f2fs_up_read(&fi->i_gc_rwsem[READ]);
>>>>> +                     ret = -EAGAIN;
>>>>> +                     goto out;
>>>>> +             }
>>>>>         } else {
>>>>>                 f2fs_down_read(&fi->i_gc_rwsem[READ]);
>>>>> +             f2fs_down_read(&fi->i_opu_rwsem);
>>>>>         }
>>>>>
>>>>>         /*
>>>>> @@ -4477,6 +4484,7 @@ static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
>>>>>                 ret = iomap_dio_complete(dio);
>>>>>         }
>>>>>
>>>>> +     f2fs_up_read(&fi->i_opu_rwsem);
>>>>>         f2fs_up_read(&fi->i_gc_rwsem[READ]);
>>>>>
>>>>>         file_accessed(file);
>>>>> @@ -4523,7 +4531,13 @@ static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>>>>>         if (f2fs_should_use_dio(inode, iocb, to)) {
>>>>>                 ret = f2fs_dio_read_iter(iocb, to);
>>>>>         } else {
>>>>> +             bool do_opu = f2fs_lfs_mode(F2FS_I_SB(inode));
>>>>> +
>>>>> +             if (do_opu)
>>>>> +                     f2fs_down_read(&F2FS_I(inode)->i_opu_rwsem);
>>>>>                 ret = filemap_read(iocb, to, 0);
>>>>> +             if (do_opu)
>>>>> +                     f2fs_up_read(&F2FS_I(inode)->i_opu_rwsem);
>>>>>                 if (ret > 0)
>>>>>                         f2fs_update_iostat(F2FS_I_SB(inode), inode,
>>>>>                                                 APP_BUFFERED_READ_IO, ret);
>>>>> @@ -4748,14 +4762,22 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
>>>>>                         ret = -EAGAIN;
>>>>>                         goto out;
>>>>>                 }
>>>>> +             if (do_opu && !f2fs_down_write_trylock(&fi->i_opu_rwsem)) {
>>>>> +                     f2fs_up_read(&fi->i_gc_rwsem[READ]);
>>>>> +                     f2fs_up_read(&fi->i_gc_rwsem[WRITE]);
>>>>> +                     ret = -EAGAIN;
>>>>> +                     goto out;
>>>>> +             }
>>>>>         } else {
>>>>>                 ret = f2fs_convert_inline_inode(inode);
>>>>>                 if (ret)
>>>>>                         goto out;
>>>>>
>>>>>                 f2fs_down_read(&fi->i_gc_rwsem[WRITE]);
>>>>> -             if (do_opu)
>>>>> +             if (do_opu) {
>>>>>                         f2fs_down_read(&fi->i_gc_rwsem[READ]);
>>>>> +                     f2fs_down_write(&fi->i_opu_rwsem);
>>>>> +             }
>>>>>         }
>>>>>
>>>>>         /*
>>>>> @@ -4779,8 +4801,10 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
>>>>>                 ret = iomap_dio_complete(dio);
>>>>>         }
>>>>>
>>>>> -     if (do_opu)
>>>>> +     if (do_opu) {
>>>>> +             f2fs_up_write(&fi->i_opu_rwsem);
>>>>>                 f2fs_up_read(&fi->i_gc_rwsem[READ]);
>>>>> +     }
>>>>>         f2fs_up_read(&fi->i_gc_rwsem[WRITE]);
>>>>>
>>>>>         if (ret < 0)
>>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>>>> index daf2c4dbe150..b4ed3b094366 100644
>>>>> --- a/fs/f2fs/super.c
>>>>> +++ b/fs/f2fs/super.c
>>>>> @@ -1428,6 +1428,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
>>>>>         init_f2fs_rwsem(&fi->i_gc_rwsem[READ]);
>>>>>         init_f2fs_rwsem(&fi->i_gc_rwsem[WRITE]);
>>>>>         init_f2fs_rwsem(&fi->i_xattr_sem);
>>>>> +     init_f2fs_rwsem(&fi->i_opu_rwsem);
>>>>>
>>>>>         /* Will be used by directory only */
>>>>>         fi->i_dir_level = F2FS_SB(sb)->dir_level;
>>>>> -- 
>>>>> 2.40.1
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

