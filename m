Return-Path: <linux-kernel+bounces-557203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0040CA5D4E4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 05:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C2E3B4133
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 04:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806971D79A6;
	Wed, 12 Mar 2025 04:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktv14dhd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69A5154426
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 04:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741752208; cv=none; b=Dgd5ZvTkhG4NNmjGju1jNZln5Uw3t5b/hxSkkcnkMlqPji3mdrOYsxtJWZejpA3HmHkN33adVWhurmefMxs+RETr1x2CpaDhhRUCT74PBGXlDi4Y7eYgq14Igr6GX2m2HwkVkJJr34pZM5tYqOsDd28JyjUCUzURbF5uKJg5h/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741752208; c=relaxed/simple;
	bh=DSIMBFNsY1w4xtxumS2VbvzlE4iL0ICS9Rp8Ydr7DS4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y6PZ9mRC3Q0jicYCBCNr9bkRy6Bejk8fXii28bmPI3qZugZzIzg1yme9uPUM6bl+IkLNH8y/SCLMb8Ufx7gQ/eZD8u8/gh6rZQZU+upiMV2iakp73lEED9uKeTWDV1jp+0cM3jB588Lw/jle9njVqeOHd4BHJFN+5uSRLZqFeTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktv14dhd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA67C4CEE3;
	Wed, 12 Mar 2025 04:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741752208;
	bh=DSIMBFNsY1w4xtxumS2VbvzlE4iL0ICS9Rp8Ydr7DS4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ktv14dhdTjmcCCeMlLMQn8NFoOjnwA/Z+kN6QrXbZ5+mAfFQ9F0GnDcmICr43WIHj
	 0qOkNcg4knR4ES2XWt9V3jZd4n6KI3KRzDhKKmezNjVbOG0cVt/AGYFLP2sZ94WCi6
	 Gb1ZU8JK9okzB4J6vQi9O5gppynD/9B6dP0tvkC2P539ied6RQ3O9BAxY9Uc1Pzv0z
	 foaCg1sLTzYVD4k9vK8ZBuXKB3FseA24ysl4/vEjQO6SJzNXUdyAdrhRDpbHmG17f4
	 riEFvwJZ+6jX1quPPyo1YVQLRvy2xwZIyYxezBUCLRtR0o6Ku7o8HvwHPGiW6tM4Iv
	 RqdTVfLfv0h+Q==
Message-ID: <381ac49a-25e9-4c37-9855-e2adb64fa81d@kernel.org>
Date: Wed, 12 Mar 2025 12:03:04 +0800
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
Subject: Re: [PATCH v2] f2fs: fix missing discard candidates in fstrim
To: Chunhai Guo <guochunhai@vivo.com>, "jaegeuk@kernel.org"
 <jaegeuk@kernel.org>
References: <20250119140834.1061145-1-guochunhai@vivo.com>
 <77fa4633-f7db-4daa-a9e1-3fdb5bf9dd1d@kernel.org>
 <74811428-9fee-467b-802f-dcb9f9dbb5a5@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <74811428-9fee-467b-802f-dcb9f9dbb5a5@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/12/25 11:19, Chunhai Guo wrote:
> 在 1/20/2025 7:45 PM, Chao Yu 写道:
>> On 1/19/25 22:08, Chunhai Guo wrote:
>>> fstrim may miss candidates that need to be discarded, as shown in the
>>> examples below.
>>>
>>> The root cause is that when cpc->reason is set with CP_DISCARD,
>>> add_discard_addrs() expects that ckpt_valid_map and cur_valid_map have
>>> been synced by seg_info_to_raw_sit() [1], and it tries to find the
>>> candidates based on ckpt_valid_map and discard_map. However,
>>> seg_info_to_raw_sit() does not actually run before
>>> f2fs_exist_trim_candidates(), resulting in the failure.
>>>
>>> The code logic can be simplified for all cases by finding all the
>>> discard blocks based only on discard_map. This might result in more
>>> discard blocks being sent for the segment during the first checkpoint
>>> after mounting, which were originally expected to be sent only in
>>> fstrim. Regardless, these discard blocks should eventually be sent, and
>>> the simplified code makes sense in this context.
>>>
>>> root# cp testfile /f2fs_mountpoint
>>>
>>> root# f2fs_io fiemap 0 1 /f2fs_mountpoint/testfile
>>> Fiemap: offset = 0 len = 1
>>>           logical addr.    physical addr.   length           flags
>>> 0       0000000000000000 0000000406a00000 000000003d800000 00001000
>>>
>>> root# rm /f2fs_mountpoint/testfile
>>>
>>> root# fstrim -v -o 0x406a00000 -l 1024M /f2fs_mountpoint -- no candidate is found
>>> /f2fs_mountpoint: 0 B (0 bytes) trimmed
>>>
>>> Relevant code process of the root cause:
>>> f2fs_trim_fs()
>>>       f2fs_write_checkpoint()
>>>           ...
>>>           if (cpc->reason & CP_DISCARD) {
>>>                   if (!f2fs_exist_trim_candidates(sbi, cpc)) {
>>>                       unblock_operations(sbi);
>>>                       goto out; // No candidates are found here, and it exits.
>>>                   }
>>>               ...
>>>           }
>>>
>>> [1] Please refer to commit d7bc2484b8d4 ("f2fs: fix small discards not
>>> to issue redundantly") for the relationship between
>>> seg_info_to_raw_sit() and add_discard_addrs().
>>>
>>> Fixes: 25290fa5591d ("f2fs: return fs_trim if there is no candidate")
>>> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
>>> ---
>>> v1: https://lore.kernel.org/linux-f2fs-devel/20250102101310.580277-1-guochunhai@vivo.com/
>>> v1->v2: Find all the discard blocks based only on discard_map in add_discard_addrs().
>>> ---
>>>    fs/f2fs/segment.c | 5 +----
>>>    1 file changed, 1 insertion(+), 4 deletions(-)
>>>
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 13ee73a3c481..25ea892a42dd 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -2074,8 +2074,6 @@ static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
>>>    {
>>>      int entries = SIT_VBLOCK_MAP_SIZE / sizeof(unsigned long);
>>>      struct seg_entry *se = get_seg_entry(sbi, cpc->trim_start);
>>> -    unsigned long *cur_map = (unsigned long *)se->cur_valid_map;
>>> -    unsigned long *ckpt_map = (unsigned long *)se->ckpt_valid_map;
>>>      unsigned long *discard_map = (unsigned long *)se->discard_map;
>>>      unsigned long *dmap = SIT_I(sbi)->tmp_map;
>>>      unsigned int start = 0, end = -1;
>>> @@ -2100,8 +2098,7 @@ static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
>>>
>>>      /* SIT_VBLOCK_MAP_SIZE should be multiple of sizeof(unsigned long) */
>>>      for (i = 0; i < entries; i++)
>>> -            dmap[i] = force ? ~ckpt_map[i] & ~discard_map[i] :
>>> -                            (cur_map[i] ^ ckpt_map[i]) & ckpt_map[i];
>>> +            dmap[i] = ~discard_map[i];
>> discard is critical, we need more sanity check here, maybe:
>>
>> /* never issue discard to valid data's block address */
>> f2fs_bug_on(sbi, (cur_map[i] ^ discard_map[i]) & cur_map[i]);
>>
>> Can you please check this?
> 
> Sure. I have added the BUG_ON check and performed the following tests
> without issue:
> 1. Ran xfstests and fsstress in the QEMU environment.
> 
> 2. Ran monkey and reboot tests on ARM64 Android devices with the 6.6 kernel.

Thanks, so it looks fine now, can you please update the patch w/ above
f2fs_bug_on check?

Thanks,

> 
> Thanks,
> 
> 
>>
>> Thanks,
>>
>>>
>>>      while (force || SM_I(sbi)->dcc_info->nr_discards <=
>>>                              SM_I(sbi)->dcc_info->max_discards) {
> 
> 


