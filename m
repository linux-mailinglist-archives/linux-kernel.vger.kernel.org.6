Return-Path: <linux-kernel+bounces-396276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A54C89BCAA1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C93B1F21A49
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF261D2B3E;
	Tue,  5 Nov 2024 10:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnxecJvq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218302EB1F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 10:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730803172; cv=none; b=e2n6XIj5FQnwyv2masYA/mOI21SXdrMQThnboZWhym32kpO1iCPiN8u9gqdAtud7KAzT4Vn0Q2Y2bV72+Btta6FBa5iBwgTb6iusMI7StnUH5J00I9UxmIh4G2x6PnQU980hpCsSonxUS0JvrUfVffLa72+GAdKafa5edFOMWP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730803172; c=relaxed/simple;
	bh=3/xAX4B7Wj8zuIXV6aOmApU6XauE3kcnSEIfW53M1Gg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y88yc9Gq/0OXmWkkWQQTk8I0DlXGfA1qjAvAL2OsBmBMSoIcIVdcQQttwPjLcjTSpH7ql7OCLY3TrFaOQ+pMt5pNO4HzGKxNf/LMlOsuyYB41/AdsMRyKca/TMCtEz2MeHr70tGn90c35v9+eyQL2yDOlA8klYVjv1YM1cFWLVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnxecJvq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43ABC4CECF;
	Tue,  5 Nov 2024 10:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730803171;
	bh=3/xAX4B7Wj8zuIXV6aOmApU6XauE3kcnSEIfW53M1Gg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=rnxecJvql01bCuAChTZME/JJL8upUBjFgdncpmNuW8lwhBv+cJRaGBj+giiHbtAeu
	 B/wEBXO38BlW/kTBqOIfRVEM7a+32z84uHjUCQygS3Hb4hsk3C0OTcUJTsRAR1ZDwi
	 q7JiA5v0uN880PYCw0MQb5a2IZlsCzM3U3s1fNuVN2JNtODySh+7lHjCJvAM3VmpMM
	 3IHAAv3t1SDDp8aUWq/5w5Cvlby0F5pbEPR6TwsfIxFSP7XpY0qiO/1u8s7b0xBO1h
	 mPn0JaGVkMKFSAkBtOVyFRmzk9fd32xKVN+Tf8MHIGCsN60oHq6GtqZbCz9UpAKn+m
	 zZF+fIhXrgGQQ==
Message-ID: <22873055-370b-4240-83ff-96bcfa91413a@kernel.org>
Date: Tue, 5 Nov 2024 18:39:27 +0800
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
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3L9o2RJgV=TtUf_MPj36wasgPn7bn9FnGPXu=TgpE7ATQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/11/5 15:28, Zhiguo Niu wrote:
> Chao Yu <chao@kernel.org> 于2024年11月5日周二 15:04写道：
>>
>> On 2024/11/4 9:56, Zhiguo Niu wrote:
>>> If user give a file size as "length" parameter for fiemap
>>> operations, but if this size is non-block size aligned,
>>> it will show 2 segments fiemap results even this whole file
>>> is contiguous on disk, such as the following results:
>>>
>>>    ./f2fs_io fiemap 0 19034 ylog/analyzer.py
>>> Fiemap: offset = 0 len = 19034
>>>           logical addr.    physical addr.   length           flags
>>> 0       0000000000000000 0000000020baa000 0000000000004000 00001000
>>> 1       0000000000004000 0000000020bae000 0000000000001000 00001001
>>>
>>> after this patch:
>>> ./f2fs_io fiemap 0 19034 ylog/analyzer.py
>>> Fiemap: offset = 0 len = 19034
>>>       logical addr.    physical addr.   length           flags
>>> 0    0000000000000000 00000000315f3000 0000000000005000 00001001
>>>
>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>>> ---
>>> V2: correct commit msg according to Chao's questions
>>> f2fs_io has been modified for testing, the length for fiemap is
>>> real file size, not block number
>>> ---
>>>    fs/f2fs/data.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index 306b86b0..9fc229d 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -1966,8 +1966,8 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>>>                        goto out;
>>>        }
>>>
>>> -     if (bytes_to_blks(inode, len) == 0)
>>> -             len = blks_to_bytes(inode, 1);
>>> +     if (len & (blks_to_bytes(inode, 1) - 1))
>>> +             len = round_up(len, blks_to_bytes(inode, 1));
>>
>> How do you think of getting rid of above alignment for len?
>>
>>>
>>>        start_blk = bytes_to_blks(inode, start);
>>>        last_blk = bytes_to_blks(inode, start + len - 1);
>>
>> And round up end position w/:
>>
>> last_blk = bytes_to_blks(inode, round_up(start + len - 1, F2FS_BLKSIZE));
> Hi Chao,
> I think this will change the current code logic
> -------------
> if (start_blk > last_blk)
>      goto out;
> -------------
> for example, a file with size 19006, but the length from the user is 16384.
> before this modification,  last_blk =  bytes_to_blks(inode, start +
> len - 1) = (inode, 16383) = 3
> after the first f2fs_map_blocks(). start_blk change to be 4,
> after the second f2fs_map_blocks(), fiemap_fill_nex_exten will be
> called to fill user parameter and then
> will goto out because start_blk > last_blk, then fiemap flow finishes.
> but after this modification, last_blk will be 4
> will do f2fs_map_blocks() until reach the max_file_blocks(inode)

Yes, you're right, however, w/ this patch, it may change last_blk, e.g.

xfs_io file -c "fiemap -v 0 19006" vs xfs_io file -c "fiemap -v 2 19006"
start_blk and last_blk will be: 0, 4 and 0, 5.

Should we round_up len after start_blk & last_blk calculation?

Thanks,

> thanks！
>>
>> Thanks,
>>


