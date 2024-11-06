Return-Path: <linux-kernel+bounces-397683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A172B9BDEF9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9821F239B8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 06:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72272191F9E;
	Wed,  6 Nov 2024 06:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DN34RfFz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B064317995E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 06:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730875531; cv=none; b=m/xUiBWWFXTZnZmUljZ4Sfq9qkMp0pU70PXPN0dpuPVIOfn2p1/ExwYveNmGJVEZjgR14dLiHwRW7KYXHNFuLNcLCm5YE5J3nqzv1UoiqNhC/92krPUB7zXaCo5XCKm46X/ocC0N161Z2pwL2MTSuwoFWSLEUufP1S1+MhNVZkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730875531; c=relaxed/simple;
	bh=GlLf6Hkk7e1AVLiSHShAMeoAmXTmcLqtDSDRg8afEZ4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WqNSfazg6ZmE2mlfwQsmy3NJsb7b4nU/gkAHpESypMlN0w28OKnTbAetOAvtQ2BM9H3bbXhB8IngJaza0OKn62hIL7X7/cZI4acb+PpStIYfmXjAgRcSTWvr3V5y/cflFKGw4Bap9D4/EZsbvfegoe4sGb6yz1deo6Jjsz/PiVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DN34RfFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D26C4CECD;
	Wed,  6 Nov 2024 06:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730875531;
	bh=GlLf6Hkk7e1AVLiSHShAMeoAmXTmcLqtDSDRg8afEZ4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=DN34RfFzkmOt3xEZ0RGYpp4SlZ9/eE9g5MVaFilQz+pJQ83Wm6tdqoYqoCquBO2xa
	 L+vbCow54WXNEYq7UO2FjMndkD8K1EJmSLidh/nXNR79Ab7Kcw7T4f79ezCVF4HnVl
	 31aos3EGA5mwRz29wyQMfEd7QNzQoCXzpgyfVR/sAQO/YFOFqrRVgQrUU1T6f2HoDC
	 7u6hvE1WZVvzid1JGjns6TTXKhnu2KDTU/J5Xs7+xnMOxScR4oVY/GTt/Q0KRvgSAV
	 BPWeoxA5+GefMbt0DGBiCGJQsaevjOhVEjnI0DYg12k7dpSIpPGAdxkS+tms1C57G4
	 1E9JYf0NfLz0Q==
Message-ID: <c2aa0e38-84ff-4fd6-97ca-cba966eba768@kernel.org>
Date: Wed, 6 Nov 2024 14:45:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, Zhiguo Niu <zhiguo.niu@unisoc.com>,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com
Subject: Re: [PATCH V2] f2fs: fix to adjust appropriate length for fiemap
To: Zhiguo Niu <niuzhiguo84@gmail.com>
References: <1730685372-2995-1-git-send-email-zhiguo.niu@unisoc.com>
 <ab9f63b2-8d02-411b-8d2f-bc1b5b748ffe@kernel.org>
 <CAHJ8P3L9o2RJgV=TtUf_MPj36wasgPn7bn9FnGPXu=TgpE7ATQ@mail.gmail.com>
 <22873055-370b-4240-83ff-96bcfa91413a@kernel.org>
 <CAHJ8P3LddwapGLV5nKmw1ULTm7qp5OMk-kFBK3s_UptPPeph7w@mail.gmail.com>
 <9199e9fc-7b5b-4069-b79b-65ba5ae1b0f6@kernel.org>
 <CAHJ8P3L68mKAcSdrgk-5VZQh4cW+BBroh+50ymvuzO0f5x5kMw@mail.gmail.com>
 <c070fd2d-6480-4833-b03c-ec032ee37a28@kernel.org>
 <CAHJ8P3Jm1+BdGsHNB03tDug8JgEtxkM9A3BE9wectE_khGgDhQ@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3Jm1+BdGsHNB03tDug8JgEtxkM9A3BE9wectE_khGgDhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/11/6 10:54, Zhiguo Niu wrote:
> Chao Yu <chao@kernel.org> 于2024年11月6日周三 10:40写道：
>>
>> On 2024/11/6 10:26, Zhiguo Niu wrote:
>>> Chao Yu <chao@kernel.org> 于2024年11月6日周三 10:16写道：
>>>>
>>>> On 2024/11/5 19:02, Zhiguo Niu wrote:
>>>>> Chao Yu <chao@kernel.org> 于2024年11月5日周二 18:39写道：
>>>>>>
>>>>>> On 2024/11/5 15:28, Zhiguo Niu wrote:
>>>>>>> Chao Yu <chao@kernel.org> 于2024年11月5日周二 15:04写道：
>>>>>>>>
>>>>>>>> On 2024/11/4 9:56, Zhiguo Niu wrote:
>>>>>>>>> If user give a file size as "length" parameter for fiemap
>>>>>>>>> operations, but if this size is non-block size aligned,
>>>>>>>>> it will show 2 segments fiemap results even this whole file
>>>>>>>>> is contiguous on disk, such as the following results:
>>>>>>>>>
>>>>>>>>>       ./f2fs_io fiemap 0 19034 ylog/analyzer.py
>>>>>>>>> Fiemap: offset = 0 len = 19034
>>>>>>>>>              logical addr.    physical addr.   length           flags
>>>>>>>>> 0       0000000000000000 0000000020baa000 0000000000004000 00001000
>>>>>>>>> 1       0000000000004000 0000000020bae000 0000000000001000 00001001
>>>>>>>>>
>>>>>>>>> after this patch:
>>>>>>>>> ./f2fs_io fiemap 0 19034 ylog/analyzer.py
>>>>>>>>> Fiemap: offset = 0 len = 19034
>>>>>>>>>          logical addr.    physical addr.   length           flags
>>>>>>>>> 0    0000000000000000 00000000315f3000 0000000000005000 00001001
>>>>>>>>>
>>>>>>>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>>>>>>>>> ---
>>>>>>>>> V2: correct commit msg according to Chao's questions
>>>>>>>>> f2fs_io has been modified for testing, the length for fiemap is
>>>>>>>>> real file size, not block number
>>>>>>>>> ---
>>>>>>>>>       fs/f2fs/data.c | 4 ++--
>>>>>>>>>       1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>>>>>>> index 306b86b0..9fc229d 100644
>>>>>>>>> --- a/fs/f2fs/data.c
>>>>>>>>> +++ b/fs/f2fs/data.c
>>>>>>>>> @@ -1966,8 +1966,8 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>>>>>>>>>                           goto out;
>>>>>>>>>           }
>>>>>>>>>
>>>>>>>>> -     if (bytes_to_blks(inode, len) == 0)
>>>>>>>>> -             len = blks_to_bytes(inode, 1);
>>>>>>>>> +     if (len & (blks_to_bytes(inode, 1) - 1))
>>>>>>>>> +             len = round_up(len, blks_to_bytes(inode, 1));
>>>>>>>>
>>>>>>>> How do you think of getting rid of above alignment for len?
>>>>>>>>
>>>>>>>>>
>>>>>>>>>           start_blk = bytes_to_blks(inode, start);
>>>>>>>>>           last_blk = bytes_to_blks(inode, start + len - 1);
>>>>>>>>
>>>>>>>> And round up end position w/:
>>>>>>>>
>>>>>>>> last_blk = bytes_to_blks(inode, round_up(start + len - 1, F2FS_BLKSIZE));
>>>>>>> Hi Chao,
>>>>>>> I think this will change the current code logic
>>>>>>> -------------
>>>>>>> if (start_blk > last_blk)
>>>>>>>         goto out;
>>>>>>> -------------
>>>>>>> for example, a file with size 19006, but the length from the user is 16384.
>>>>>>> before this modification,  last_blk =  bytes_to_blks(inode, start +
>>>>>>> len - 1) = (inode, 16383) = 3
>>>>>>> after the first f2fs_map_blocks(). start_blk change to be 4,
>>>>>>> after the second f2fs_map_blocks(), fiemap_fill_nex_exten will be
>>>>>>> called to fill user parameter and then
>>>>>>> will goto out because start_blk > last_blk, then fiemap flow finishes.
>>>>>>> but after this modification, last_blk will be 4
>>>>>>> will do f2fs_map_blocks() until reach the max_file_blocks(inode)
>>>>>>
>>>>>> Yes, you're right, however, w/ this patch, it may change last_blk, e.g.
>>>>>>
>>>>>> xfs_io file -c "fiemap -v 0 19006" vs xfs_io file -c "fiemap -v 2 19006"
>>>>>> start_blk and last_blk will be: 0, 4 and 0, 5.
>>>>> Hi Chao,
>>>>> yes, but w/o this patch , the original code still has the same situation??
>>>>> for example
>>>>> xfs_io file -c "fiemap -v 0 16384" vs xfs_io file -c "fiemap -v 2 16384"
>>>>> start_blk and last_blk will be: 0, 3 and 0, 4.
>>>>
>>>> For the case "fiemap -v 2 19006", offset is 2, and length is 19006, so last_offset
>>>> is 19008, and last_blk should be 4 rather than 5, right?
>>> hi Chao,
>>> it is right w/o my patch.
>>>>
>>>> And for you case, it calculates last_blk correctly.
>>> So you suggest that "Should we round_up len after start_blk & last_blk
>>> calculation?"
>>
>> Zhiguo,
>>
>> Yes, I think alignment of len should not affect calculation of last_blk.
>>
>> I mean this,
>>
>> ---
>>    fs/f2fs/data.c          | 6 +++---
>>    include/linux/f2fs_fs.h | 3 ++-
>>    2 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 7d1bb9518a40..cbbb956f420d 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -1967,12 +1967,12 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>>                          goto out;
>>          }
>>
>> -       if (bytes_to_blks(inode, len) == 0)
>> -               len = blks_to_bytes(inode, 1);
>> -
>>          start_blk = bytes_to_blks(inode, start);
>>          last_blk = bytes_to_blks(inode, start + len - 1);
>>
>> +       if (len & F2FS_BLKSIZE_MASK)
>> +               len = round_up(len, F2FS_BLKSIZE);
>> +
> Hi Chao,
> It looks well and clear, Let me verify this.
> another unimportant questions, do we need to use macor
> F2FS_BLKSIZE_xxx for round_up?

Zhiguo,

Well, f2fs doesn't support different blksize in one instance, so
bytes_to_blks() is equal to F2FS_BYTES_TO_BLK(), I guess we can
use F2FS_BYTES_TO_BLK() instead of bytes_to_blks() for cleanup,
let me figure out a patch for that.

Thanks,

> because in fiemap, it all use bytes_to_blks(inode, xxx) /
> blks_to_bytes(inode, xxx)
> thanks!
>>    next:
>>          memset(&map, 0, sizeof(map));
>>          map.m_lblk = start_blk;
>> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
>> index b0b821edfd97..954e8e8344b7 100644
>> --- a/include/linux/f2fs_fs.h
>> +++ b/include/linux/f2fs_fs.h
>> @@ -24,10 +24,11 @@
>>    #define NEW_ADDR              ((block_t)-1)   /* used as block_t addresses */
>>    #define COMPRESS_ADDR         ((block_t)-2)   /* used as compressed data flag */
>>
>> +#define F2FS_BLKSIZE_MASK              (F2FS_BLKSIZE - 1)
>>    #define F2FS_BYTES_TO_BLK(bytes)      ((bytes) >> F2FS_BLKSIZE_BITS)
>>    #define F2FS_BLK_TO_BYTES(blk)                ((blk) << F2FS_BLKSIZE_BITS)
>>    #define F2FS_BLK_END_BYTES(blk)               (F2FS_BLK_TO_BYTES(blk + 1) - 1)
>> -#define F2FS_BLK_ALIGN(x)                      (F2FS_BYTES_TO_BLK((x) + F2FS_BLKSIZE - 1))
>> +#define F2FS_BLK_ALIGN(x)              (F2FS_BYTES_TO_BLK((x) + F2FS_BLKSIZE - 1))
>>
>>    /* 0, 1(node nid), 2(meta nid) are reserved node id */
>>    #define F2FS_RESERVED_NODE_NUM                3
>> --
>> 2.40.1
>>
>>
>>
>>> Thanks
>>>>
>>>> Thanks,
>>>>
>>>>> but overall last_blk will change loop counts but has not affect on the results.
>>>>>>
>>>>>> Should we round_up len after start_blk & last_blk calculation?
>>>>> I thinks it is ok ,but just a little bit redundant with the following
>>>>> handling about len.
>>>>>
>>>>> if (bytes_to_blks(inode, len) == 0)
>>>>>       len = blks_to_bytes(inode, 1);
>>>>>
>>>>> Based on the above situation,
>>>>> do you have any other good suggestions? ^^
>>>>> thanks!
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>>> thanks！
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>>
>>>>>>
>>>>
>>


