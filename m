Return-Path: <linux-kernel+bounces-288824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E242E953F2B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 03:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0434282F27
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47102BD0D;
	Fri, 16 Aug 2024 01:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdflQGqH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C5C1D69E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 01:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723773391; cv=none; b=irZo2+pMsLtVFGNXCUWHxBgKWJFQjmMU+UHZU8yUeggo2wS2VM4gIi6+tojvhAoL4eXzGc0aQeLs0qZglpMifZXfl4oDA9w6j+SH3S4HYKP6hJzGce8sI7X4T5uIMjKaVL6+MQLe5QJOd6AS4bksSg/5xMAqcrQM2/3yWyowLIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723773391; c=relaxed/simple;
	bh=dZIWTkbqG9CE4eee0cwu5JPhJzQVRrcUFkrIXFMHhXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=calpK+q93efqYFeSu4drlXz/LXVFXgcLMfqQJ3orbqgH9i8cIsLK7Jt+IjPZ+GhCYVeyiiDOZT4auLZzCHJQzXOqycuDIrYgvij9LHDYpUxa8kipaqsR3Wv4UiOcu19ipsax2DIxAN8KUDLsTukogntogru2dsWWoi6eP3Y/N8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdflQGqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0B5C32786;
	Fri, 16 Aug 2024 01:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723773390;
	bh=dZIWTkbqG9CE4eee0cwu5JPhJzQVRrcUFkrIXFMHhXg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YdflQGqHWKcmAxnISCI3IZxHAaluNUWQVi9Pa/NDbz96xkysrjIaxluFMUc+nU4Bq
	 mEQTkEocIsMART1ZnO63nEu5o/lBGlzk9n698E+jYviO8ToHKG6Ehe1oo5GbYJDDKN
	 ZyHJC80kpP4/hzalSLjmxqw5vAEdKSvkNMM5Wyxvmr2EPKnRdOtMCYzuhi96u1ha0u
	 D9eOEcTai6pvy8kovOoOj3IzZMOkzqxu82ZMBc7jP/Fw4sphxfx4JyjxmlyZbaI+P/
	 uxV9l+f3pnOXwLVhfWJ3YCDO0/deU/EcSH6Zz3eYwOOQ2mCFCyAp/QI7FNxBdbbr+F
	 vRJK0FCNJlmKg==
Message-ID: <5b892d6a-620d-47f4-b870-214dcf4bc480@kernel.org>
Date: Fri, 16 Aug 2024 09:56:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (2) [PATCH] f2fs: avoid unused block when dio write in LFS mode
To: daejun7.park@samsung.com, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Seokhwan Kim <sukka.kim@samsung.com>,
 Dongjin Kim <dongjin_.kim@samsung.com>,
 Yonggil Song <yonggil.song@samsung.com>,
 Jaeyoon Choi <j_yoon.choi@samsung.com>, Jeuk Kim <jeuk20.kim@samsung.com>,
 Nayeon Kim <nayeoni.kim@samsung.com>, Siwoo Jung <siu.jung@samsung.com>
References: <7860b050-3948-4e23-b40f-a3df522477cd@kernel.org>
 <20240801074715epcms2p788934486cd0e8090f67ed0d7cffbc91b@epcms2p7>
 <CGME20240801074715epcms2p788934486cd0e8090f67ed0d7cffbc91b@epcms2p3>
 <20240816001700epcms2p37f406e9cd3a1d6438a866e7a7a3d5c31@epcms2p3>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240816001700epcms2p37f406e9cd3a1d6438a866e7a7a3d5c31@epcms2p3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/8/16 8:17, Daejun Park wrote:
> Hi Chao Yu,
>>   
>> --------- Original Message ---------
>> Sender : Chao Yu <chao@kernel.org>
>> Date : 2024-08-14 18:50 (GMT+9)
>> Title : Re: [PATCH] f2fs: avoid unused block when dio write in LFS mode
>>   
>> On 2024/8/1 15:47, Daejun Park wrote:
>>> This patch addresses the problem that when using LFS mode, unused blocks
>>> may occur in f2fs_map_blocks() during block allocation for dio writes.
>>>
>>> If a new section is allocated during block allocation, it will not be
>>> included in the map struct by map_is_mergeable() if the LBA of the
>>
>> I didn't get it, why below condition in map_is_mergeable() can not catch this
>> case? Can you please explain more?
>>
>>         if (map->m_pblk != NEW_ADDR && blkaddr == (map->m_pblk + ofs))
>>                 return true;
>>
> 
> Thank you for your review.
> map_is_mergeable() returns true when the last block in the section is merged.
> The problem is the next block allocation, which happens consecutively.
> Since it will be allocated a new section, its block will be the first
> block in the section.
> If the newly allocated section is not contiguous with the previous section,
> map_is_mergeable() will return false.
> So the block is allocated but unused.
> However, it is not freed, so the block is unusable.
> If my explanation was not clear enough, please feel free to ask questions.

It's clear to me now, thanks for your explanation.

> 
> Thanks
> Daejun
> 
>> Thanks,
>>
>>> allocated block is not contiguous. However, the block already allocated
>>> in this process will remain unused due to the LFS mode.
>>>
>>> This patch avoids the possibility of unused blocks by escaping
>>> f2fs_map_blocks() when allocating the last block in a section.
>>>
>>> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
>>> ---
>>>    fs/f2fs/data.c 13 +++++++++++++
>>>    1 file changed, 13 insertions(+)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index b6dcb3bcaef7..b27a3f448f32 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -1711,6 +1711,19 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
>>>                     dn.ofs_in_node = end_offset;
>>>             }
>>>   
>>> +        if (flag == F2FS_GET_BLOCK_DIO && f2fs_lfs_mode(sbi)) {

The condition should check map->m_may_create as well, otherwise f2fs_map_blocks()
from read path will break here?

>>> +                int segno = GET_SEGNO(sbi, blkaddr);
>>> +                bool last_seg, last_blk;
>>> +
>>> +                last_seg = !((segno + 1) % SEGS_PER_SEC(sbi));

Should consider the case that segno #(SEGS_PER_SEC - 1) is not valid?
e.g. SEGS_PER_SEC is 4, CAP_SEGS_PER_SEC is 2?

>>> +                last_blk = (f2fs_usable_blks_in_seg(sbi, segno) - 1) ==
>>> +                                GET_BLKOFF_FROM_SEG0(sbi, blkaddr);

if (GET_SEGOFF_FROM_SEG0() % BLKS_PER_SEC() == CAP_BLKS_PER_SEC() - 1)
	goto sync_out;

Thanks,

>>> +
>>> +                /* LBA of the next block to be allocated may not be contiguous. */
>>> +                if (last_seg && last_blk)
>>> +                        goto sync_out;
>>> +        }
>>> +
>>>             if (pgofs >= end)
>>>                     goto sync_out;
>>>             else if (dn.ofs_in_node < end_offset)


