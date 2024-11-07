Return-Path: <linux-kernel+bounces-399497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41B19BFFD7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37C5283A14
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107981D1E64;
	Thu,  7 Nov 2024 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+fK3VTq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ADA18754F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 08:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730967738; cv=none; b=HlIklRVDXiJQGuN3Bl7odwq6CBlRJt8lBqyTvxH0HHZK1R+TGpbqs+Odr9V1QopmI6XYEihvp60OielBFsQ05HS6OROFO92/vTjdhdDGOWvsvDdH2HPwkUci3dFlojHJWMm7UHalYXIARSYZBNMMecHlQylRDZkoaCV/2tJzAjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730967738; c=relaxed/simple;
	bh=Yn538S3pFBGMZoyjFkAqcB6Oj05/WmRjrE/cShIc47M=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VANnDm5nvEpt0O6ana48DGlcwh3qZ5CsoDNAjEJoAAPPrCwbwyg0lk1k/5JKRft9DtxroC/araPJX01A6QlmbKqu5nF080kf/TCNQUQd20vIO+veGFr4KuabKrfjHdMFHaZnqA0SBZNL9uhXv+QFVbiDq/OVZlee7fJqnuow0Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+fK3VTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423E7C4CECC;
	Thu,  7 Nov 2024 08:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730967737;
	bh=Yn538S3pFBGMZoyjFkAqcB6Oj05/WmRjrE/cShIc47M=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=J+fK3VTqcyO60+pNASjgJl19pNigwru7qHxlHlUFowOiT0dszLL7B/4X0+DEuuTNA
	 TlJ0RAl5tjKZHLj95Ih1K1qj60jrB6oqzrQ1EHz2z2ube1uEsyAwRCPGo00Wp9JhJc
	 QX7FeVC+MuMwedoM2waTzVRf1RnFiBjDJMj8WLR0xSvZgv9ClLqlYRLEiCh8MQXO3O
	 izl3ENzrKX0IiURJY6QiH+2SNfwYqS880pw7mFf3dF1T0atrK+J1HG8Rx1E/fnzWot
	 6pA90oFgshROfkWBgpkZxUXIkIuLbJ15y6qw1uyGP0gtLP6+i21pLtJv1honqAwXZ+
	 fHibQBkDSna+g==
Message-ID: <45cec698-2679-435b-b62a-ebe22d361955@kernel.org>
Date: Thu, 7 Nov 2024 16:22:10 +0800
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
 <CAHJ8P3L4Q4Pia66o1RQGw5NnUOVxzNgFXUPO33jtqfQ-Oc=G_g@mail.gmail.com>
 <0a8f96da-302d-4d6c-9ab6-0b66a05cbcfd@kernel.org>
 <CAHJ8P3JTY=DFQRMd0zNGy6a3Hdq1y045ri9QKM8NGn8bNhHJfA@mail.gmail.com>
 <d5ef36a3-1bcb-40a0-a963-c6d1887c4e4e@kernel.org>
 <CAHJ8P3JARkFxkyz-FLWN2PSZb2AL3=dSqF1v-SR-oU9z6tm+Rg@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3JARkFxkyz-FLWN2PSZb2AL3=dSqF1v-SR-oU9z6tm+Rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/11/7 14:54, Zhiguo Niu wrote:
> Chao Yu <chao@kernel.org> 于2024年11月7日周四 14:18写道：
>>
>> On 2024/11/6 16:41, Zhiguo Niu wrote:
>>> Chao Yu <chao@kernel.org> 于2024年11月6日周三 15:40写道：
>>>>
>>>> On 2024/11/6 14:08, Zhiguo Niu wrote:
>>>>> Chao Yu <chao@kernel.org> 于2024年11月6日周三 10:40写道：
>>>>>>
>>>>>> On 2024/11/6 10:26, Zhiguo Niu wrote:
>>>>>>> Chao Yu <chao@kernel.org> 于2024年11月6日周三 10:16写道：
>>>>>>>>
>>>>>>>> On 2024/11/5 19:02, Zhiguo Niu wrote:
>>>>>>>>> Chao Yu <chao@kernel.org> 于2024年11月5日周二 18:39写道：
>>>>>>>>>>
>>>>>>>>>> On 2024/11/5 15:28, Zhiguo Niu wrote:
>>>>>>>>>>> Chao Yu <chao@kernel.org> 于2024年11月5日周二 15:04写道：
>>>>>>>>>>>>
>>>>>>>>>>>> On 2024/11/4 9:56, Zhiguo Niu wrote:
>>>>>>>>>>>>> If user give a file size as "length" parameter for fiemap
>>>>>>>>>>>>> operations, but if this size is non-block size aligned,
>>>>>>>>>>>>> it will show 2 segments fiemap results even this whole file
>>>>>>>>>>>>> is contiguous on disk, such as the following results:
>>>>>>>>>>>>>
>>>>>>>>>>>>>         ./f2fs_io fiemap 0 19034 ylog/analyzer.py
>>>>>>>>>>>>> Fiemap: offset = 0 len = 19034
>>>>>>>>>>>>>                logical addr.    physical addr.   length           flags
>>>>>>>>>>>>> 0       0000000000000000 0000000020baa000 0000000000004000 00001000
>>>>>>>>>>>>> 1       0000000000004000 0000000020bae000 0000000000001000 00001001
>>>>>>>>>>>>>
>>>>>>>>>>>>> after this patch:
>>>>>>>>>>>>> ./f2fs_io fiemap 0 19034 ylog/analyzer.py
>>>>>>>>>>>>> Fiemap: offset = 0 len = 19034
>>>>>>>>>>>>>            logical addr.    physical addr.   length           flags
>>>>>>>>>>>>> 0    0000000000000000 00000000315f3000 0000000000005000 00001001
>>>>>>>>>>>>>
>>>>>>>>>>>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>> V2: correct commit msg according to Chao's questions
>>>>>>>>>>>>> f2fs_io has been modified for testing, the length for fiemap is
>>>>>>>>>>>>> real file size, not block number
>>>>>>>>>>>>> ---
>>>>>>>>>>>>>         fs/f2fs/data.c | 4 ++--
>>>>>>>>>>>>>         1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>>>>>>>
>>>>>>>>>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>>>>>>>>>>> index 306b86b0..9fc229d 100644
>>>>>>>>>>>>> --- a/fs/f2fs/data.c
>>>>>>>>>>>>> +++ b/fs/f2fs/data.c
>>>>>>>>>>>>> @@ -1966,8 +1966,8 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>>>>>>>>>>>>>                             goto out;
>>>>>>>>>>>>>             }
>>>>>>>>>>>>>
>>>>>>>>>>>>> -     if (bytes_to_blks(inode, len) == 0)
>>>>>>>>>>>>> -             len = blks_to_bytes(inode, 1);
>>>>>>>>>>>>> +     if (len & (blks_to_bytes(inode, 1) - 1))
>>>>>>>>>>>>> +             len = round_up(len, blks_to_bytes(inode, 1));
>>>>>>>>>>>>
>>>>>>>>>>>> How do you think of getting rid of above alignment for len?
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>             start_blk = bytes_to_blks(inode, start);
>>>>>>>>>>>>>             last_blk = bytes_to_blks(inode, start + len - 1);
>>>>>>>>>>>>
>>>>>>>>>>>> And round up end position w/:
>>>>>>>>>>>>
>>>>>>>>>>>> last_blk = bytes_to_blks(inode, round_up(start + len - 1, F2FS_BLKSIZE));
>>>>>>>>>>> Hi Chao,
>>>>>>>>>>> I think this will change the current code logic
>>>>>>>>>>> -------------
>>>>>>>>>>> if (start_blk > last_blk)
>>>>>>>>>>>           goto out;
>>>>>>>>>>> -------------
>>>>>>>>>>> for example, a file with size 19006, but the length from the user is 16384.
>>>>>>>>>>> before this modification,  last_blk =  bytes_to_blks(inode, start +
>>>>>>>>>>> len - 1) = (inode, 16383) = 3
>>>>>>>>>>> after the first f2fs_map_blocks(). start_blk change to be 4,
>>>>>>>>>>> after the second f2fs_map_blocks(), fiemap_fill_nex_exten will be
>>>>>>>>>>> called to fill user parameter and then
>>>>>>>>>>> will goto out because start_blk > last_blk, then fiemap flow finishes.
>>>>>>>>>>> but after this modification, last_blk will be 4
>>>>>>>>>>> will do f2fs_map_blocks() until reach the max_file_blocks(inode)
>>>>>>>>>>
>>>>>>>>>> Yes, you're right, however, w/ this patch, it may change last_blk, e.g.
>>>>>>>>>>
>>>>>>>>>> xfs_io file -c "fiemap -v 0 19006" vs xfs_io file -c "fiemap -v 2 19006"
>>>>>>>>>> start_blk and last_blk will be: 0, 4 and 0, 5.
>>>>>>>>> Hi Chao,
>>>>>>>>> yes, but w/o this patch , the original code still has the same situation??
>>>>>>>>> for example
>>>>>>>>> xfs_io file -c "fiemap -v 0 16384" vs xfs_io file -c "fiemap -v 2 16384"
>>>>>>>>> start_blk and last_blk will be: 0, 3 and 0, 4.
>>>>>>>>
>>>>>>>> For the case "fiemap -v 2 19006", offset is 2, and length is 19006, so last_offset
>>>>>>>> is 19008, and last_blk should be 4 rather than 5, right?
>>>>>>> hi Chao,
>>>>>>> it is right w/o my patch.
>>>>>>>>
>>>>>>>> And for you case, it calculates last_blk correctly.
>>>>>>> So you suggest that "Should we round_up len after start_blk & last_blk
>>>>>>> calculation?"
>>>>>>
>>>>>> Zhiguo,
>>>>>>
>>>>>> Yes, I think alignment of len should not affect calculation of last_blk.
>>>>>>
>>>>>> I mean this,
>>>>>>
>>>>>> ---
>>>>>>      fs/f2fs/data.c          | 6 +++---
>>>>>>      include/linux/f2fs_fs.h | 3 ++-
>>>>>>      2 files changed, 5 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>>>> index 7d1bb9518a40..cbbb956f420d 100644
>>>>>> --- a/fs/f2fs/data.c
>>>>>> +++ b/fs/f2fs/data.c
>>>>>> @@ -1967,12 +1967,12 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>>>>>>                            goto out;
>>>>>>            }
>>>>>>
>>>>>> -       if (bytes_to_blks(inode, len) == 0)
>>>>>> -               len = blks_to_bytes(inode, 1);
>>>>>> -
>>>>>>            start_blk = bytes_to_blks(inode, start);
>>>>>>            last_blk = bytes_to_blks(inode, start + len - 1);
>>>>>>
>>>>>> +       if (len & F2FS_BLKSIZE_MASK)
>>>>>> +               len = round_up(len, F2FS_BLKSIZE);
>>>>>> +
>>>>> Hi Chao,
>>>>> this verion verify pass with my test case.
>>>>>
>>>>> but there is still another issue in orginal code:
>>>>> ylog/analyzer.py  size = 19034
>>>>> if I input the following cmd(start/length are both real size, not block number)
>>>>> /f2fs_io fiemap 2 16384 ylog/analyzer.py
>>>>> and the results shows:
>>>>> Fiemap: offset = 2 len = 16384
>>>>>        logical addr.    physical addr.   length           flags
>>>>> 0    0000000000000000 0000000e2ebca000 0000000000004000 00001000
>>>>> 1    0000000000004000 0000000e2ebce000 0000000000001000 00001001
>>>>> so start_blk/last_blk should be calculate it in the following way?
>>>>
>>>> IIUC, the root cause is f2fs_map_blocks() will truncate size of
>>>> returned extent to F2FS_BYTES_TO_BLK(len), so whenever parameter
>>>> @len doesn't cover last extent, it triggers this bug.
>>>>
>>>> next:
>>>>           memset(&map, 0, sizeof(map));
>>>>           map.m_lblk = start_blk;
>>>>           map.m_len = F2FS_BYTES_TO_BLK(len);  --- limit max size of extent it founds
>>> yes, I think so too.
>>>>           map.m_next_pgofs = &next_pgofs;
>>>>           map.m_seg_type = NO_CHECK_TYPE;
>>>> ...
>>>>           ret = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_FIEMAP);
>>>>
>>>> xfs_io file -c "fiemap -v 2 16384"
>>>> file:
>>>>     EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>>>>       0: [0..31]:         139272..139303      32 0x1000
>>>>       1: [32..39]:        139304..139311       8 0x1001
>>>> xfs_io file -c "fiemap -v 0 16384"
>>>> file:
>>>>     EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>>>>       0: [0..31]:         139272..139303      32 0x1000
>>>> xfs_io file -c "fiemap -v 0 16385"
>>>> file:
>>>>     EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>>>>       0: [0..39]:         139272..139311      40 0x1001
>>>
>>> But  If the correct last_blk is calculated correctly, fiemap can be
>>> ended as soon as possible?  so the results shown is also right?
>>
>> Zhiguo,
>>
>> IMO, it's not, due to 1) if the extent is last one, FIEMAP_EXTENT_LAST
>> must be tagged to notice user that it doesn't need further fiemap on
>> latter LBA, 2) one continuous extent should not be split to two.
>>
>> Let me figure out a fix for that.
> Hi Chao,
> OK, thanks for your explaination.
> btw, Do I need to update a patch about the original issue we disscussed?
> or you will modify it together?

Zhiguo, let me send a patchset including your patch, now, I'm testing this:

 From c67cb4782a3f1875865f9ae24cce80a59752d600 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Thu, 7 Nov 2024 14:52:17 +0800
Subject: [PATCH] f2fs: fix to requery extent which cross boundary of inquiry

dd if=/dev/zero of=file bs=4k count=5
xfs_io file -c "fiemap -v 2 16384"
file:
    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
      0: [0..31]:         139272..139303      32 0x1000
      1: [32..39]:        139304..139311       8 0x1001
xfs_io file -c "fiemap -v 0 16384"
file:
    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
      0: [0..31]:         139272..139303      32 0x1000
xfs_io file -c "fiemap -v 0 16385"
file:
    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
      0: [0..39]:         139272..139311      40 0x1001

There are two problems:
- continuous extent is split to two
- FIEMAP_EXTENT_LAST is missing in last extent

The root cause is: if upper boundary of inquiry crosses extent,
f2fs_map_blocks() will truncate length of returned extent to
F2FS_BYTES_TO_BLK(len), and also, it will stop to query latter
extent or hole to make sure current extent is last or not.

In order to fix this issue, once we found an extent locates
in the end of inquiry range by f2fs_map_blocks(), we need to
expand inquiry range to requiry.

Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
  fs/f2fs/data.c | 20 +++++++++++++++-----
  1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 69f1cb0490ee..ee5614324df0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1896,7 +1896,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
  		u64 start, u64 len)
  {
  	struct f2fs_map_blocks map;
-	sector_t start_blk, last_blk;
+	sector_t start_blk, last_blk, blk_len, max_len;
  	pgoff_t next_pgofs;
  	u64 logical = 0, phys = 0, size = 0;
  	u32 flags = 0;
@@ -1940,14 +1940,13 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,

  	start_blk = F2FS_BYTES_TO_BLK(start);
  	last_blk = F2FS_BYTES_TO_BLK(start + len - 1);
-
-	if (len & F2FS_BLKSIZE_MASK)
-		len = round_up(len, F2FS_BLKSIZE);
+	blk_len = last_blk - start_blk + 1;
+	max_len = F2FS_BYTES_TO_BLK(maxbytes) - start_blk;

  next:
  	memset(&map, 0, sizeof(map));
  	map.m_lblk = start_blk;
-	map.m_len = F2FS_BYTES_TO_BLK(len);
+	map.m_len = blk_len;
  	map.m_next_pgofs = &next_pgofs;
  	map.m_seg_type = NO_CHECK_TYPE;

@@ -1970,6 +1969,17 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
  		flags |= FIEMAP_EXTENT_LAST;
  	}

+	/*
+	 * current extent may cross boundary of inquiry, increase len to
+	 * requery.
+	 */
+	if (!compr_cluster && (map.m_flags & F2FS_MAP_MAPPED) &&
+				map.m_lblk + map.m_len - 1 == last_blk &&
+				blk_len != max_len) {
+		blk_len = max_len;
+		goto next;
+	}
+
  	compr_appended = false;
  	/* In a case of compressed cluster, append this to the last extent */
  	if (compr_cluster && ((map.m_flags & F2FS_MAP_DELALLOC) ||
-- 
2.40.1

> thanks!
>>
>> Thanks,
>>
>>> such as this special case "xfs_io file -c "fiemap -v 2 16384" we discussed.
>>> but it is fine for me to keep the current codes.
>>> thanks!
>>>>
>>>> Thoughts?
>>>>
>>>> Thanks,
>>>>
>>>>> before:
>>>>> start_blk = bytes_to_blks(inode, start);
>>>>> last_blk = bytes_to_blks(inode, start + len - 1);
>>>>> after:
>>>>>
>>>>> start_blk = bytes_to_blks(inode, start);
>>>>> last_blk = start_blk + bytes_to_blks(inode, len - 1);
>>>>> thanks!
>>>>>>      next:
>>>>>>            memset(&map, 0, sizeof(map));
>>>>>>            map.m_lblk = start_blk;
>>>>>> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
>>>>>> index b0b821edfd97..954e8e8344b7 100644
>>>>>> --- a/include/linux/f2fs_fs.h
>>>>>> +++ b/include/linux/f2fs_fs.h
>>>>>> @@ -24,10 +24,11 @@
>>>>>>      #define NEW_ADDR              ((block_t)-1)   /* used as block_t addresses */
>>>>>>      #define COMPRESS_ADDR         ((block_t)-2)   /* used as compressed data flag */
>>>>>>
>>>>>> +#define F2FS_BLKSIZE_MASK              (F2FS_BLKSIZE - 1)
>>>>>>      #define F2FS_BYTES_TO_BLK(bytes)      ((bytes) >> F2FS_BLKSIZE_BITS)
>>>>>>      #define F2FS_BLK_TO_BYTES(blk)                ((blk) << F2FS_BLKSIZE_BITS)
>>>>>>      #define F2FS_BLK_END_BYTES(blk)               (F2FS_BLK_TO_BYTES(blk + 1) - 1)
>>>>>> -#define F2FS_BLK_ALIGN(x)                      (F2FS_BYTES_TO_BLK((x) + F2FS_BLKSIZE - 1))
>>>>>> +#define F2FS_BLK_ALIGN(x)              (F2FS_BYTES_TO_BLK((x) + F2FS_BLKSIZE - 1))
>>>>>>
>>>>>>      /* 0, 1(node nid), 2(meta nid) are reserved node id */
>>>>>>      #define F2FS_RESERVED_NODE_NUM                3
>>>>>> --
>>>>>> 2.40.1
>>>>>>
>>>>>>
>>>>>>
>>>>>>> Thanks
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>>
>>>>>>>>> but overall last_blk will change loop counts but has not affect on the results.
>>>>>>>>>>
>>>>>>>>>> Should we round_up len after start_blk & last_blk calculation?
>>>>>>>>> I thinks it is ok ,but just a little bit redundant with the following
>>>>>>>>> handling about len.
>>>>>>>>>
>>>>>>>>> if (bytes_to_blks(inode, len) == 0)
>>>>>>>>>         len = blks_to_bytes(inode, 1);
>>>>>>>>>
>>>>>>>>> Based on the above situation,
>>>>>>>>> do you have any other good suggestions? ^^
>>>>>>>>> thanks!
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>>
>>>>>>>>>>> thanks！
>>>>>>>>>>>>
>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>
>>>>>>
>>>>
>>


