Return-Path: <linux-kernel+bounces-563503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF912A6430B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1C33A8818
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD5621A45E;
	Mon, 17 Mar 2025 07:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LF62dsWd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7146F18A6B5
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 07:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742195576; cv=none; b=jbPY9MyIP/JzBEhxwb3pXEMvLfsgiAW4UV562YDh+NuId8BatlCrHI0YEhD4tnlOLKnA00cagIIgun+11a4oPSFWo4/fsX/1o7s+lI0Mp8ciaDST7g9MznWDz9ppYjb1dbb+wKbvt9H1YXJXTQEYIIYb3u3EsPQ+z6l/ORy0VpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742195576; c=relaxed/simple;
	bh=8CS4msPxk4DCirERvuRrksmNRWtm494ZCr116H0cv0I=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nI7AmLbWTQlB5R5lpBy1N+4qMg8X5L8prnyDdI4SQk8PKdFU7hQUbsxzZF7X0cjHxAbR+3ALhNkhrryMNkRHt8zqSA9hBRaO2LXi0B/3xeY7pX8H+bzEJgYhfvf0JkKssmc1GfKtyjPQpDaqc1tl9i6u/7Idh2/N3ZQUCv869Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LF62dsWd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2DFC4CEE3;
	Mon, 17 Mar 2025 07:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742195576;
	bh=8CS4msPxk4DCirERvuRrksmNRWtm494ZCr116H0cv0I=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=LF62dsWd9hmoMcCslTEilzyXJHFy/cmN8CxKod0XPZRyzzmfvTheXhT9/p+iFgH4B
	 v4UFJHUrh0HrqZfW8i0M3gL6Zlb9Ltw1VREPojlOiXryU0D4sFQI0AiXpPSosWHgnx
	 /Wq/AcGHdbB8M4JCsS2oDgPjDeFcHNukHBvFsggRIwoBdkQle6RWeNFN10doNU2A4+
	 SeRZLScE4awskkiblmxaoTBzbe7zQsroyGJvPIbmfU9hzwMuTE3ubrc5CxEDJyxTM3
	 BoxOCb9kIqH/UGs4Xes0EU/pYSauaVSI+yHvJObNIU6kfdnbu15muYAobrHOOdbEZ3
	 skboG043PBhOw==
Message-ID: <6ad02c17-a175-43fd-bce4-d3cd2dc01338@kernel.org>
Date: Mon, 17 Mar 2025 15:12:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] f2fs: fix missing discard for active segments
To: Chunhai Guo <guochunhai@vivo.com>, "jaegeuk@kernel.org"
 <jaegeuk@kernel.org>
References: <20250109122755.177926-1-guochunhai@vivo.com>
 <4270b213-e4f9-46b2-958a-df3dbaaed969@kernel.org>
 <95b8334a-45e6-496a-8b0b-ab7a7fe180b5@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <95b8334a-45e6-496a-8b0b-ab7a7fe180b5@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/13/25 10:25, Chunhai Guo wrote:
> 在 1/20/2025 8:25 PM, Chao Yu 写道:
>> On 1/9/25 20:27, Chunhai Guo wrote:
>>> During a checkpoint, the current active segment X may not be handled
>>> properly. This occurs when segment X has 0 valid blocks and a non-zero
>> How does this happen? Allocator selects a dirty segment w/ SSR? and the
>> left valid data blocks were deleted later before following checkpoint?
>>
>> If so, pending discard count in that segment should be in range of (0, 512)?
> 
> 
> This issue is found with LFS rather than SSR. Here's what happens: some
> data blocks are allocated for a file in the current active segment, and
> then the file is deleted, resulting in all valid data blocks in the
> current active segment being deleted before the following checkpoint.
> This issue is easy to reproduce with the following operations:
> 
> 
> # mkfs.f2fs -f /dev/nvme2n1
> # mount -t f2fs /dev/nvme2n1 /vtmp/mnt/f2fs
> # dd if=/dev/nvme0n1 of=/vtmp/mnt/f2fs/1.bin bs=4k count=256
> # sync
> # rm /vtmp/mnt/f2fs/1.bin
> # umount /vtmp/mnt/f2fs
> # dump.f2fs /dev/nvme2n1 | grep "checkpoint state"
> Info: checkpoint state = 45 :  crc compacted_summary unmount ----
> 'trimmed' flag is missing
> 
> The pending discard count in that segment indeed falls within the range
> of (0, 512).

Please add this testcase into commit message, otherwise it looks
good to me, feel free to add:

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
> Thanks,
>> Thanks,
>>
>>> number of discard blocks, for the following reasons:
>>>
>>> locate_dirty_segment() does not mark any active segment as a prefree
>>> segment. As a result, segment X is not included in dirty_segmap[PRE], and
>>> f2fs_clear_prefree_segments() skips it when handling prefree segments.
>>>
>>> add_discard_addrs() skips any segment with 0 valid blocks, so segment X is
>>> also skipped.
>>>
>>> Consequently, no `struct discard_cmd` is actually created for segment X.
>>> However, the ckpt_valid_map and cur_valid_map of segment X are synced by
>>> seg_info_to_raw_sit() during the current checkpoint process. As a result,
>>> it cannot find the missing discard bits even in subsequent checkpoints.
>>> Consequently, the value of sbi->discard_blks remains non-zero. Thus, when
>>> f2fs is umounted, CP_TRIMMED_FLAG will not be set due to the non-zero
>>> sbi->discard_blks.
>>>
>>> Relevant code process:
>>>
>>> f2fs_write_checkpoint()
>>>       f2fs_flush_sit_entries()
>>>            list_for_each_entry_safe(ses, tmp, head, set_list) {
>>>                for_each_set_bit_from(segno, bitmap, end) {
>>>                    ...
>>>                    add_discard_addrs(sbi, cpc, false); // skip segment X due to its 0 valid blocks
>>>                    ...
>>>                    seg_info_to_raw_sit(); // sync ckpt_valid_map with cur_valid_map for segment X
>>>                    ...
>>>                }
>>>            }
>>>       f2fs_clear_prefree_segments(); // segment X is not included in dirty_segmap[PRE] and is skipped
>>>
>>> Since add_discard_addrs() can handle active segments with non-zero valid
>>> blocks, it is reasonable to fix this issue by allowing it to also handle
>>> active segments with 0 valid blocks.
>>>
>>> Fixes: b29555505d81 ("f2fs: add key functions for small discards")
>>> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
>>> ---
>>> v1: https://lore.kernel.org/linux-f2fs-devel/20241203065108.2763436-1-guochunhai@vivo.com/
>>> v1->v2:
>>>    - Modify the commit message to make it easier to understand.
>>>    - Add fixes to the commit.
>>> ---
>>>    fs/f2fs/segment.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 86e547f008f9..13ee73a3c481 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -2090,7 +2090,9 @@ static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
>>>              return false;
>>>
>>>      if (!force) {
>>> -            if (!f2fs_realtime_discard_enable(sbi) || !se->valid_blocks ||
>>> +            if (!f2fs_realtime_discard_enable(sbi) ||
>>> +                    (!se->valid_blocks &&
>>> +                            !IS_CURSEG(sbi, cpc->trim_start)) ||
>>>                      SM_I(sbi)->dcc_info->nr_discards >=
>>>                              SM_I(sbi)->dcc_info->max_discards)
>>>                      return false;
> 
> 


