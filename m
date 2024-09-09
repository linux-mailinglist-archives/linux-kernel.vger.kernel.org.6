Return-Path: <linux-kernel+bounces-320486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C33C9970B2C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 03:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D65281E80
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33484D53C;
	Mon,  9 Sep 2024 01:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElRQWZXu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7474BAD55
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 01:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725845076; cv=none; b=FpFUV2VV8RuSL7zSPMSro7UQ5dmpNRCmwkHG5A8bbJr6eYU2TWIMYdqVwPmMYZYEYTKa0MOjnR2OKwQ3TUzB/xtVvdkdDovquHzy0DFTNtcWc8klLLDT28AIjgPxRf7fG5tfIa5vdlM44ibqoQ8PFYgWL50BDcfU3JSLqmtNflY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725845076; c=relaxed/simple;
	bh=YKZhEHCGlF9dx65kfivouqFr+WTDDU0a6y9vWlyBKak=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YeX75IBNfwKZplDgv5UirEfvWIT9U+3NzA1oImxSltsbgR7psITHY6liObTwTnzHpnyATPQ+5iik8WBxwEUTd+5uqbCZWPxtwjKnjD5Tz383Ruja0AGWwdJ+ldyMwHLBgTjo9Rt+q3imR7mKWv5MD6DEs/3jEUB3+rh9dI2cZ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElRQWZXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B472FC4CEC3;
	Mon,  9 Sep 2024 01:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725845076;
	bh=YKZhEHCGlF9dx65kfivouqFr+WTDDU0a6y9vWlyBKak=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ElRQWZXuugvLvlzhgE0HKVu6mTvfRPdkx94zxo6fzReUhgW8M0eRUoMNvQPVy4glc
	 vUjQrjjjQY/C2hOKv/CmUSHcqlVRABGdp8gPjuVhWwsWDTbDm+C9tkzjMJvXruOA87
	 BODIYnI3vIi+uxat7XSLwniX7xZR09DXHl2i2V0kSB+6sVCRh/cL28tePwYElqHS+Y
	 l923Xx8oAiDPyR+d0bquLuCelXzYXve5O9khA+4J17UfdJSOPt37G30FnZ/R8/Dbso
	 3et3KFXejdQnKui+nL89rGKs13z0cXMRETdiGDbfm519BrFgQKqRv79kHq4OUynrkC
	 HSVN87Db0vnKA==
Message-ID: <55f6fdba-f505-4557-8074-6bfa942c275d@kernel.org>
Date: Mon, 9 Sep 2024 09:24:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [RFC PATCH] f2fs: don't set SBI_QUOTA_NEED_REPAIR flag
 if receive SIGKILL
To: wangzijie <wangzijie1@honor.com>
References: <973e075b-7044-4448-9cd0-45b5a1ad1382@kernel.org>
 <20240908041202.2272053-1-wangzijie1@honor.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240908041202.2272053-1-wangzijie1@honor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/9/8 12:12, wangzijie wrote:
>>> From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
>>>
>>>> On 2024/8/27 14:22, wangzijie wrote:
>>>>> Thread A
>>>>> -dquot_initialize
>>>>>    -dqget
>>>>>     -f2fs_dquot_acquire
>>>>>      -v2_read_dquot
>>>>>       -qtree_read_dquot
>>>>>        -find_tree_dqentry
>>>>>         -f2fs_quota_read
>>>>>          -read_cache_page_gfp
>>>>>           -do_read_cache_folio
>>>>>            -fiemap_read_folio
>>>>>             -folio_wait_locked_killable
>>>>>              -receive SIGKILL : return -EINTR
>>>>>          -set SBI_QUOTA_NEED_REPAIR
>>>>>      -set SBI_QUOTA_NEED_REPAIR
>>>>>
>>>>> When calling read_cache_page_gfp in quota read, thread may receive SIGKILL and
>>>>> set SBI_QUOTA_NEED_REPAIR, should we set SBI_QUOTA_NEED_REPAIR in this error path?
>>>>
>>>> f2fs_quota_read() can be called in a lot of contexts, can we just ignore -EINTR
>>>> for f2fs_dquot_initialize() case?
>>>>
>>>> Thanks,
>>>
>>> Yes, in many contexts f2fs_quota_read() can be called and may return -EINTR, we need to ignore this errno for more cases. If we need to do so, I will check it and resend patch.
>>> Or do you have other suggestions to avoid unnecessary SBI_QUOTA_NEED_REPAIR flag set?
>>
>> How about this?
>>
>> ---
>>   fs/f2fs/f2fs.h  |  1 +
>>   fs/f2fs/inode.c |  3 +--
>>   fs/f2fs/super.c | 17 +++++++++++++----
>>   3 files changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index dfed1974eda5..a1704a19dfe9 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -810,6 +810,7 @@ enum {
>>   	FI_ATOMIC_DIRTIED,	/* indicate atomic file is dirtied */
>>   	FI_ATOMIC_REPLACE,	/* indicate atomic replace */
>>   	FI_OPENED_FILE,		/* indicate file has been opened */
>> +	FI_INIT_DQUOT,		/* indicate it's initializing dquot */
>>   	FI_MAX,			/* max flag, never be used */
>>   };
>>
>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>> index 008f01348afa..b1dbaeda306f 100644
>> --- a/fs/f2fs/inode.c
>> +++ b/fs/f2fs/inode.c
>> @@ -827,8 +827,7 @@ void f2fs_evict_inode(struct inode *inode)
>>
>>   	err = f2fs_dquot_initialize(inode);
>>   	if (err) {
>> -		if (err != -EINTR)
>> -			set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
>> +		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
>>   		err = 0;
>>   	}
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 8e29aba4b7a4..e774bdf875b2 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -2644,8 +2644,11 @@ static ssize_t f2fs_quota_read(struct super_block *sb, int type, char *data,
>>   			if (PTR_ERR(page) == -ENOMEM) {
>>   				memalloc_retry_wait(GFP_NOFS);
>>   				goto repeat;
>> -			} else if (PTR_ERR(page) != -EINTR)
>> -				set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
>> +			} else if (PTR_ERR(page) == -EINTR &&
>> +				is_inode_flag_set(inode, FI_INIT_DQUOT)) {
>> +				return PTR_ERR(page);
>> +			}
>> +			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
>>   			return PTR_ERR(page);
>>   		}
>>
>> @@ -2721,10 +2724,16 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
>>
>>   int f2fs_dquot_initialize(struct inode *inode)
>>   {
>> +	int ret;
>> +
>>   	if (time_to_inject(F2FS_I_SB(inode), FAULT_DQUOT_INIT))
>>   		return -ESRCH;
>>
>> -	return dquot_initialize(inode);
>> +	set_inode_flag(inode, FI_INIT_DQUOT);
>> +	ret = dquot_initialize(inode);
>> +	clear_inode_flag(inode, FI_INIT_DQUOT);
>> +
>> +	return ret;
>>   }
>>
>>   static struct dquot __rcu **f2fs_get_dquots(struct inode *inode)
>> @@ -3064,7 +3073,7 @@ static int f2fs_dquot_acquire(struct dquot *dquot)
>>
>>   	f2fs_down_read(&sbi->quota_sem);
>>   	ret = dquot_acquire(dquot);
>> -	if (ret < 0 && ret != -EINTR)
>> +	if (ret < 0)
>>   		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
>>   	f2fs_up_read(&sbi->quota_sem);
>>   	return ret;
>> -- 
>> 2.40.1
> 
> Hi, Chao
> If we dont't ignore -EINTR in f2fs_dquot_acquire(), we will still set SBI_QUOTA_NEED_REPAIR flag
> in f2fs_dquot_acquire() if f2fs_quota_read return -EINTR. I think we need more cases in addition to
> dquot initializing and I will check it again.

Maybe we can cover this case w/ below diff?

---
  fs/f2fs/super.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e774bdf875b2..7fc970121a3f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3073,7 +3073,8 @@ static int f2fs_dquot_acquire(struct dquot *dquot)

  	f2fs_down_read(&sbi->quota_sem);
  	ret = dquot_acquire(dquot);
-	if (ret < 0)
+	if (ret < 0 &&
+		(ret != -EINTR || !is_inode_flag_set(inode, FI_INIT_DQUOT)))
  		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
  	f2fs_up_read(&sbi->quota_sem);
  	return ret;
-- 
2.40.1

Thanks,

> Thank you for your suggestion!
> 
>>>
>>> Thank you for review.
>>>
>>>>>
>>>>> Signed-off-by: wangzijie <wangzijie1@honor.com>
>>>>> ---
>>>>>    fs/f2fs/inode.c | 3 ++-
>>>>>    fs/f2fs/super.c | 6 +++---
>>>>>    2 files changed, 5 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>>>>> index ed629dabb..2af98e2b7 100644
>>>>> --- a/fs/f2fs/inode.c
>>>>> +++ b/fs/f2fs/inode.c
>>>>> @@ -837,8 +837,9 @@ void f2fs_evict_inode(struct inode *inode)
>>>>>        err = f2fs_dquot_initialize(inode);
>>>>>        if (err) {
>>>>> +        if (err != -EINTR)
>>>>> +            set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
>>>>>            err = 0;
>>>>> -        set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
>>>>>        }
>>>>>        f2fs_remove_ino_entry(sbi, inode->i_ino, APPEND_INO);
>>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>>>> index 1f1b3647a..f99a36ff3 100644
>>>>> --- a/fs/f2fs/super.c
>>>>> +++ b/fs/f2fs/super.c
>>>>> @@ -2650,8 +2650,8 @@ static ssize_t f2fs_quota_read(struct super_block *sb, int type, char *data,
>>>>>                if (PTR_ERR(page) == -ENOMEM) {
>>>>>                    memalloc_retry_wait(GFP_NOFS);
>>>>>                    goto repeat;
>>>>> -            }
>>>>> -            set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
>>>>> +            } else if (PTR_ERR(page) != -EINTR)
>>>>> +                set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
>>>>>                return PTR_ERR(page);
>>>>>            }
>>>>> @@ -3070,7 +3070,7 @@ static int f2fs_dquot_acquire(struct dquot *dquot)
>>>>>        f2fs_down_read(&sbi->quota_sem);
>>>>>        ret = dquot_acquire(dquot);
>>>>> -    if (ret < 0)
>>>>> +    if (ret < 0 && ret != -EINTR)
>>>>>            set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
>>>>>        f2fs_up_read(&sbi->quota_sem);
>>>>>        return ret;
>>>
>>>
> 
> 


