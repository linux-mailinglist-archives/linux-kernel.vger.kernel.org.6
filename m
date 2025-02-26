Return-Path: <linux-kernel+bounces-532958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EA4A45424
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 04:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CA3B172F8B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AB7266F04;
	Wed, 26 Feb 2025 03:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="po+cAviU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5988F218821
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 03:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740541786; cv=none; b=nk4TNi4fc/6aSxiLGjwXS3PTTLAsM0fRGF+KcDZ1joltwSVmBkfIYK7MXTWEK8QF8TLJjVabktu/ObSMBZVrI4ukJ1kOLZGdN3Xxe2wObM3MJzYG9tQHCSHB5LTZyPTdodvHhW7uW9la7qJLyTCm7vSRjSrLzr7JO2RHblTWK/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740541786; c=relaxed/simple;
	bh=smdSWu/7w/UJeur1fo+oz/WRApeT+wO6uic4lBedw7E=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m/+7l8EkPAAy7ykhyXfASFAfZhAmEDe0HjwTfAhBnfxV5cBymJ3CfNYE3+i6hI4howhy+1VSMQPExnMUXyQtV5YHpesW0UUC4KCTG9gIzN4CXrgB9ATrwPBKLYq5jbd4ufU7/OtJ9EGbF0thVPsPEMXkEd2iWlG1koTtUCm2Nrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=po+cAviU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D13BC4CED6;
	Wed, 26 Feb 2025 03:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740541784;
	bh=smdSWu/7w/UJeur1fo+oz/WRApeT+wO6uic4lBedw7E=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=po+cAviUd7OkfDBOtWbooia5FMbYIbAqB/BgKPcQrNg+F6DGwUj4mj2aL273JkvGY
	 d2DgQx7I19o2e+2PrwkofSkuxHefRB9TpQ55TIOMl0gAKd6gtDC+svloEyNsChQmc3
	 Ops/qbLbkaY5i3O1bWYR4q5NSxWRkyyPGoz3X/wWeXYz0ovo0KTQ0KYFLv9V/+zvYA
	 CHKaGnGIwdB2rx1RTq53qPSqDI8pNtDx4L7Sl8qbONDWypNHWRI3aFeMBah7nVy9Q8
	 G5qm7Phfuy7gPIV2AsBkggHgu2nqop1AiuxAWfJaG5CQtCtpCWG9+R5yD/4iQEvu9D
	 LeXROTsMS20/A==
Message-ID: <7fb3ffcb-4513-45da-8f83-eebe8f5e008b@kernel.org>
Date: Wed, 26 Feb 2025 11:49:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, Leo Stone <leocstone@gmail.com>,
 syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com
Subject: Re: [PATCH v4] f2fs: add check for deleted inode
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250212072742.977248-1-chao@kernel.org>
 <Z6zQoyNp5td-Wgd1@google.com>
 <d8be79a2-9470-45b7-9df1-b571f2219c30@kernel.org>
 <Z64uA2ys4nhV54lI@google.com>
 <666e62d1-3446-485e-bac9-0cc8089b04de@kernel.org>
 <5f390129-1b93-42d2-8db7-276c370db90f@kernel.org>
 <Z76KaW6iAsafDDbB@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <Z76KaW6iAsafDDbB@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/25 11:28, Jaegeuk Kim wrote:
> On 02/24, Chao Yu wrote:
>> On 2/14/25 09:44, Chao Yu wrote:
>>> On 2/14/25 01:38, Jaegeuk Kim wrote:
>>>> On 02/13, Chao Yu wrote:
>>>>> On 2/13/25 00:47, Jaegeuk Kim wrote:
>>>>>> On 02/12, Chao Yu wrote:
>>>>>>> From: Leo Stone <leocstone@gmail.com>
>>>>>>>
>>>>>>> The syzbot reproducer mounts a f2fs image, then tries to unlink an
>>>>>>> existing file. However, the unlinked file already has a link count of 0
>>>>>>> when it is read for the first time in do_read_inode().
>>>>>>>
>>>>>>> Add a check to sanity_check_inode() for i_nlink == 0.
>>>>>>>
>>>>>>> [Chao Yu: rebase the code and fix orphan inode recovery issue]
>>>>>>> Reported-by: syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com
>>>>>>> Closes: https://syzkaller.appspot.com/bug?extid=b01a36acd7007e273a83
>>>>>>> Fixes: 39a53e0ce0df ("f2fs: add superblock and major in-memory structure")
>>>>>>> Signed-off-by: Leo Stone <leocstone@gmail.com>
>>>>>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>>>>>> ---
>>>>>>>  fs/f2fs/checkpoint.c | 4 ++++
>>>>>>>  fs/f2fs/f2fs.h       | 1 +
>>>>>>>  fs/f2fs/inode.c      | 6 ++++++
>>>>>>>  3 files changed, 11 insertions(+)
>>>>>>>
>>>>>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>>>>>> index bd890738b94d..ada2c548645c 100644
>>>>>>> --- a/fs/f2fs/checkpoint.c
>>>>>>> +++ b/fs/f2fs/checkpoint.c
>>>>>>> @@ -751,6 +751,8 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
>>>>>>>  	if (is_sbi_flag_set(sbi, SBI_IS_WRITABLE))
>>>>>>>  		f2fs_info(sbi, "orphan cleanup on readonly fs");
>>>>>>>  
>>>>>>> +	set_sbi_flag(sbi, SBI_ORPHAN_RECOVERY);
>>>>>>
>>>>>> What about using SBI_POR_DOING?
>>>>>
>>>>> SBI_POR_DOING will cover most flow of f2fs_fill_super(), I think we can add a
>>>>> separated flag just covering f2fs_recover_orphan_inodes(), so that we can allow
>>>>> iget() of root_inode and all inodes during roll-forward recovery to do sanity
>>>>> check nlink w/ zero. What do you think?
>>>>
>>>> Can we do this sanity check after f2fs_iget in the f2fs_unlink() only?
>>>
>>> Sure, we need to cover f2fs_rename() as well, please check this:
>>>
>>> https://lore.kernel.org/all/67450f9a.050a0220.21d33d.0003.GAE@google.com
>>
>> Hi Jaegeuk,
>>
>> I'm testing this, seems there is a problem, once we opened an inode that
>> has zeroed nlink, in f2fs_evict_inode(), the inode and all its data will be
>> deleted, then leaving its stale dir entry in parent directory.
>>
>> What do you think using v4? so that we may has chance to repair it w/ fsck
>> rather than just deleting it?
> 
> Do you mean v4 as the below change?

I mean this v4 patch:

---
 fs/f2fs/checkpoint.c | 4 ++++
 fs/f2fs/f2fs.h       | 1 +
 fs/f2fs/inode.c      | 6 ++++++
 3 files changed, 11 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index bd890738b94d..ada2c548645c 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -751,6 +751,8 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 	if (is_sbi_flag_set(sbi, SBI_IS_WRITABLE))
 		f2fs_info(sbi, "orphan cleanup on readonly fs");

+	set_sbi_flag(sbi, SBI_ORPHAN_RECOVERY);
+
 	start_blk = __start_cp_addr(sbi) + 1 + __cp_payload(sbi);
 	orphan_blocks = __start_sum_addr(sbi) - 1 - __cp_payload(sbi);

@@ -778,9 +780,11 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 		}
 		f2fs_put_page(page, 1);
 	}
+
 	/* clear Orphan Flag */
 	clear_ckpt_flags(sbi, CP_ORPHAN_PRESENT_FLAG);
 out:
+	clear_sbi_flag(sbi, SBI_ORPHAN_RECOVERY);
 	set_sbi_flag(sbi, SBI_IS_RECOVERED);

 	return err;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 05879c6dc4d6..1c75081c0c14 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1322,6 +1322,7 @@ enum {
 	SBI_IS_CLOSE,				/* specify unmounting */
 	SBI_NEED_FSCK,				/* need fsck.f2fs to fix */
 	SBI_POR_DOING,				/* recovery is doing or not */
+	SBI_ORPHAN_RECOVERY,			/* orphan inodes recovery is doing */
 	SBI_NEED_SB_WRITE,			/* need to recover superblock */
 	SBI_NEED_CP,				/* need to checkpoint */
 	SBI_IS_SHUTDOWN,			/* shutdown by ioctl */
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index d6ad7810df69..02f1b69d03d8 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -386,6 +386,12 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		}
 	}

+	if (inode->i_nlink == 0 && !is_sbi_flag_set(sbi, SBI_ORPHAN_RECOVERY)) {
+		f2fs_warn(sbi, "%s: inode (ino=%lx) has a link count of 0",
+			  __func__, inode->i_ino);
+		return false;
+	}
+
 	return true;
 }

Thanks,

> 
>>
>> ---
>>  fs/f2fs/namei.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>> index a278c7da8177..949621bc0d07 100644
>> --- a/fs/f2fs/namei.c
>> +++ b/fs/f2fs/namei.c
>> @@ -547,6 +547,16 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
>>  		goto fail;
>>  	}
>>
>> +	if (unlikely(S_ISDIR(inode->i_mode) ?
>> +			inode->i_nlink <= 1 : inode->i_nlink == 0)) {
>> +		f2fs_err_ratelimited(sbi, "%s: inode (ino=%lx) has inconsistent nlink: %u, isdir: %d",
>> +				__func__, inode->i_ino, inode->i_nlink,
>> +				S_ISDIR(inode->i_mode));
>> +		err = -EFSCORRUPTED;
>> +		set_sbi_flag(sbi, SBI_NEED_FSCK);
>> +		goto fail;
>> +	}
>> +
>>  	err = f2fs_dquot_initialize(dir);
>>  	if (err)
>>  		goto fail;
>> @@ -968,6 +978,15 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>>  	}
>>
>>  	if (new_inode) {
>> +		if (unlikely(old_is_dir ?
>> +			new_inode->i_nlink <= 1 : new_inode->i_nlink == 0)) {
>> +			f2fs_err_ratelimited(sbi, "%s: inode (ino=%lx) has inconsistent nlink: %u, isdir: %d",
>> +				__func__, new_inode->i_ino, new_inode->i_nlink,
>> +				S_ISDIR(new_inode->i_mode));
>> +			err = -EFSCORRUPTED;
>> +			set_sbi_flag(sbi, SBI_NEED_FSCK);
>> +			goto out_dir;
>> +		}
>>
>>  		err = -ENOTEMPTY;
>>  		if (old_is_dir && !f2fs_empty_dir(new_inode))
>> -- 
>> 2.48.1.601.g30ceb7b040-goog
>>
>>>
>>> Thanks,
>>>
>>>>
>>>>>
>>>>> Thanks,
>>>>>
>>>>>>
>>>>>>> +
>>>>>>>  	start_blk = __start_cp_addr(sbi) + 1 + __cp_payload(sbi);
>>>>>>>  	orphan_blocks = __start_sum_addr(sbi) - 1 - __cp_payload(sbi);
>>>>>>>  
>>>>>>> @@ -778,9 +780,11 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
>>>>>>>  		}
>>>>>>>  		f2fs_put_page(page, 1);
>>>>>>>  	}
>>>>>>> +
>>>>>>>  	/* clear Orphan Flag */
>>>>>>>  	clear_ckpt_flags(sbi, CP_ORPHAN_PRESENT_FLAG);
>>>>>>>  out:
>>>>>>> +	clear_sbi_flag(sbi, SBI_ORPHAN_RECOVERY);
>>>>>>>  	set_sbi_flag(sbi, SBI_IS_RECOVERED);
>>>>>>>  
>>>>>>>  	return err;
>>>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>>>> index 05879c6dc4d6..1c75081c0c14 100644
>>>>>>> --- a/fs/f2fs/f2fs.h
>>>>>>> +++ b/fs/f2fs/f2fs.h
>>>>>>> @@ -1322,6 +1322,7 @@ enum {
>>>>>>>  	SBI_IS_CLOSE,				/* specify unmounting */
>>>>>>>  	SBI_NEED_FSCK,				/* need fsck.f2fs to fix */
>>>>>>>  	SBI_POR_DOING,				/* recovery is doing or not */
>>>>>>> +	SBI_ORPHAN_RECOVERY,			/* orphan inodes recovery is doing */
>>>>>>>  	SBI_NEED_SB_WRITE,			/* need to recover superblock */
>>>>>>>  	SBI_NEED_CP,				/* need to checkpoint */
>>>>>>>  	SBI_IS_SHUTDOWN,			/* shutdown by ioctl */
>>>>>>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>>>>>>> index d6ad7810df69..02f1b69d03d8 100644
>>>>>>> --- a/fs/f2fs/inode.c
>>>>>>> +++ b/fs/f2fs/inode.c
>>>>>>> @@ -386,6 +386,12 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
>>>>>>>  		}
>>>>>>>  	}
>>>>>>>  
>>>>>>> +	if (inode->i_nlink == 0 && !is_sbi_flag_set(sbi, SBI_ORPHAN_RECOVERY)) {
>>>>>>> +		f2fs_warn(sbi, "%s: inode (ino=%lx) has a link count of 0",
>>>>>>> +			  __func__, inode->i_ino);
>>>>>>> +		return false;
>>>>>>> +	}
>>>>>>> +
>>>>>>>  	return true;
>>>>>>>  }
>>>>>>>  
>>>>>>> -- 
>>>>>>> 2.48.1.502.g6dc24dfdaf-goog
>>>


