Return-Path: <linux-kernel+bounces-397519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9C79BDCEA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B521C23048
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E471D90AD;
	Wed,  6 Nov 2024 02:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSi0Z35M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C178318FC75
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 02:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859384; cv=none; b=BJrEKInLB3LoY7RKbkM3NQCzIiorVzM07N/ecyKDvIl9PzkViJ2On4cGvYjp/6QGae3ckkQAd6ArfonhSo4gU9zxj89pKT9YfJB4XE4q2eeCT8SIYSkXrAsMrNNInIfV1hUip2rL0e+dBIWZcKw7OyKS8+HTotknNteNwipc16U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859384; c=relaxed/simple;
	bh=06l34PWhvl4tdNiJSYbSZO4mr1xYv8cmwY77xvFqw2Q=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mKJxDnnXRS03FkYTTHuP77ybkdL00j3i0Mka3qhfflp11pDTQGM1aHNLVfHYVQ67UiCcrcxJHeF3UcbSgTrRMKEo2Juqw3vucgmwCS1L0cMpEcjzvag0HZ3Ikpi+EZRPL02BE4degI1MTjESCDnADNKkYY6vFuVD8ooreFM7O4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSi0Z35M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C423C4CED1;
	Wed,  6 Nov 2024 02:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859384;
	bh=06l34PWhvl4tdNiJSYbSZO4mr1xYv8cmwY77xvFqw2Q=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=dSi0Z35MYmjitvBnV1jBnhBWpPchp+wG3KFIZXuY8ya7S6M9P+DXegErXesVIvIBn
	 TgKj/SVY0vHbOh7TF1lgZnWeffWqby6TLMK1YsVwTojrMA8XFO1g+R7aCJTr5/ta9R
	 WIAoj4ekSnvQjVLmZ5gcrdFCqjeiw67/COz2TBUo+Cwu2EzD3AqfsPg28UbQ9b/ys4
	 TsYQd7p5i1/Hp6vnyIE4+P7azDxOcnov69XbBzS4U1YOtIgWRP1NVh46mH/LDnuW0X
	 Xn65pf2fCjxq5IYe81/c8azbLHykJSgSg5t9+o5HmWFI8HNOHqeS4xZruqZIMcTh2q
	 xq0/ic6Ai9GSg==
Message-ID: <9199e9fc-7b5b-4069-b79b-65ba5ae1b0f6@kernel.org>
Date: Wed, 6 Nov 2024 10:16:20 +0800
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
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3LddwapGLV5nKmw1ULTm7qp5OMk-kFBK3s_UptPPeph7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/11/5 19:02, Zhiguo Niu wrote:
> Chao Yu <chao@kernel.org> 于2024年11月5日周二 18:39写道：
>>
>> On 2024/11/5 15:28, Zhiguo Niu wrote:
>>> Chao Yu <chao@kernel.org> 于2024年11月5日周二 15:04写道：
>>>>
>>>> On 2024/11/4 9:56, Zhiguo Niu wrote:
>>>>> If user give a file size as "length" parameter for fiemap
>>>>> operations, but if this size is non-block size aligned,
>>>>> it will show 2 segments fiemap results even this whole file
>>>>> is contiguous on disk, such as the following results:
>>>>>
>>>>>     ./f2fs_io fiemap 0 19034 ylog/analyzer.py
>>>>> Fiemap: offset = 0 len = 19034
>>>>>            logical addr.    physical addr.   length           flags
>>>>> 0       0000000000000000 0000000020baa000 0000000000004000 00001000
>>>>> 1       0000000000004000 0000000020bae000 0000000000001000 00001001
>>>>>
>>>>> after this patch:
>>>>> ./f2fs_io fiemap 0 19034 ylog/analyzer.py
>>>>> Fiemap: offset = 0 len = 19034
>>>>>        logical addr.    physical addr.   length           flags
>>>>> 0    0000000000000000 00000000315f3000 0000000000005000 00001001
>>>>>
>>>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>>>>> ---
>>>>> V2: correct commit msg according to Chao's questions
>>>>> f2fs_io has been modified for testing, the length for fiemap is
>>>>> real file size, not block number
>>>>> ---
>>>>>     fs/f2fs/data.c | 4 ++--
>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>>> index 306b86b0..9fc229d 100644
>>>>> --- a/fs/f2fs/data.c
>>>>> +++ b/fs/f2fs/data.c
>>>>> @@ -1966,8 +1966,8 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>>>>>                         goto out;
>>>>>         }
>>>>>
>>>>> -     if (bytes_to_blks(inode, len) == 0)
>>>>> -             len = blks_to_bytes(inode, 1);
>>>>> +     if (len & (blks_to_bytes(inode, 1) - 1))
>>>>> +             len = round_up(len, blks_to_bytes(inode, 1));
>>>>
>>>> How do you think of getting rid of above alignment for len?
>>>>
>>>>>
>>>>>         start_blk = bytes_to_blks(inode, start);
>>>>>         last_blk = bytes_to_blks(inode, start + len - 1);
>>>>
>>>> And round up end position w/:
>>>>
>>>> last_blk = bytes_to_blks(inode, round_up(start + len - 1, F2FS_BLKSIZE));
>>> Hi Chao,
>>> I think this will change the current code logic
>>> -------------
>>> if (start_blk > last_blk)
>>>       goto out;
>>> -------------
>>> for example, a file with size 19006, but the length from the user is 16384.
>>> before this modification,  last_blk =  bytes_to_blks(inode, start +
>>> len - 1) = (inode, 16383) = 3
>>> after the first f2fs_map_blocks(). start_blk change to be 4,
>>> after the second f2fs_map_blocks(), fiemap_fill_nex_exten will be
>>> called to fill user parameter and then
>>> will goto out because start_blk > last_blk, then fiemap flow finishes.
>>> but after this modification, last_blk will be 4
>>> will do f2fs_map_blocks() until reach the max_file_blocks(inode)
>>
>> Yes, you're right, however, w/ this patch, it may change last_blk, e.g.
>>
>> xfs_io file -c "fiemap -v 0 19006" vs xfs_io file -c "fiemap -v 2 19006"
>> start_blk and last_blk will be: 0, 4 and 0, 5.
> Hi Chao,
> yes, but w/o this patch , the original code still has the same situation??
> for example
> xfs_io file -c "fiemap -v 0 16384" vs xfs_io file -c "fiemap -v 2 16384"
> start_blk and last_blk will be: 0, 3 and 0, 4.

For the case "fiemap -v 2 19006", offset is 2, and length is 19006, so last_offset
is 19008, and last_blk should be 4 rather than 5, right?

And for you case, it calculates last_blk correctly.

Thanks,

> but overall last_blk will change loop counts but has not affect on the results.
>>
>> Should we round_up len after start_blk & last_blk calculation?
> I thinks it is ok ,but just a little bit redundant with the following
> handling about len.
> 
> if (bytes_to_blks(inode, len) == 0)
>     len = blks_to_bytes(inode, 1);
> 
> Based on the above situation,
> do you have any other good suggestions? ^^
> thanks!
> 
>>
>> Thanks,
>>
>>> thanks！
>>>>
>>>> Thanks,
>>>>
>>


