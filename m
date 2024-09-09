Return-Path: <linux-kernel+bounces-320896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5949711BA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BDB51C22734
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF401B253B;
	Mon,  9 Sep 2024 08:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJmCaXTz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DB11509AE
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725869914; cv=none; b=Hyv9utvwgnb3GjbhZIeOVo2SSWI441kZ6ODtxn9LUZ5GCUgivbLhnPuzfLmP/rENnVmwjq3VMONqNQ3YDLif8M9FhGQCLyE+QSRFleGUPzzik0R+TdZoH+UYJcNgQxjQkOYdE40X7GeblStD7dPz7aRfyTRxuVdXqV7l8gGcgmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725869914; c=relaxed/simple;
	bh=6pIhKBMX99ed6ZhOuprT0MWJ+i/32rCsFoA36gmoqC4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q65RJxmTTHQmYtdgy/ycMB4lMiSiZ4AfFFTFD6mC3zlE0p/HqwG09vEhBWq0jJJwTSQMmMH9yZgIZnby7mLGZX0EqTGuifWFaF5ONSnE4UR3qCgfWrODRL4ZX+hZOVr1hy3+uLchg0Knf4TyqJ68wcHTAtu/akdKhvtmEubf/yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJmCaXTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E770C4CEC5;
	Mon,  9 Sep 2024 08:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725869913;
	bh=6pIhKBMX99ed6ZhOuprT0MWJ+i/32rCsFoA36gmoqC4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=YJmCaXTz9zqdihJDqbF7BWQPA7eMOtVvg7N4NoTsQcHTVt0kfD2AMqIh4gXJqgsIw
	 ObbXUku90wH2+Z2EN5p+q+PZ2XWEq0mnI9wXE3IROvgq3OCjdPepGKiO8g4fy8aduv
	 iq6bxkjnzw9cy3jQri1xxue64Wwym2Z+tH5d9B25CmrZBd/Zde2OZljRpAzVJAX5lS
	 yXMdd2y2QqBBsI6FgpLERDUchAGIbZTiPdr3RSIyQf7QRwG3s+sAYDRkts4unqZvkq
	 Ebw/aD2uUV+5673peA79lFatZlT4gJEO+cxj0YXZIPQCLb86gt1mH72p2Y5AC7csv4
	 xMnDysPg7MOAQ==
Message-ID: <7559a11a-f234-418c-880b-34a0ecd1c9a9@kernel.org>
Date: Mon, 9 Sep 2024 16:18:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
 Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH 2/7] f2fs: read summary blocks with the correct
 amount for migration_granularity
To: Daeho Jeong <daeho43@gmail.com>
References: <20240829215242.3641502-1-daeho43@gmail.com>
 <20240829215242.3641502-2-daeho43@gmail.com>
 <501416af-b08c-448b-881d-0915575e22f5@kernel.org>
 <CACOAw_wgTOAQGJ3vbvp_Dqi_J0ZEsqWRFny-iczpyMD=kpxG-w@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CACOAw_wgTOAQGJ3vbvp_Dqi_J0ZEsqWRFny-iczpyMD=kpxG-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/9/7 4:23, Daeho Jeong wrote:
> On Thu, Sep 5, 2024 at 7:56 PM Chao Yu <chao@kernel.org> wrote:
>>
>> On 2024/8/30 5:52, Daeho Jeong wrote:
>>> From: Daeho Jeong <daehojeong@google.com>
>>>
>>> Now we do readahead for a full section by not considering
>>> migration_granularity and it triggers unnecessary read. So, make it read
>>> with the correct amount.
>>>
>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
>>> ---
>>>    fs/f2fs/gc.c | 33 ++++++++++++++++++++-------------
>>>    1 file changed, 20 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>> index 46e3bc26b78a..b5d3fd40b17a 100644
>>> --- a/fs/f2fs/gc.c
>>> +++ b/fs/f2fs/gc.c
>>> @@ -1708,24 +1708,33 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>>>        struct blk_plug plug;
>>>        unsigned int segno = start_segno;
>>>        unsigned int end_segno = start_segno + SEGS_PER_SEC(sbi);
>>> +     unsigned int sec_end_segno;
>>>        int seg_freed = 0, migrated = 0;
>>>        unsigned char type = IS_DATASEG(get_seg_entry(sbi, segno)->type) ?
>>>                                                SUM_TYPE_DATA : SUM_TYPE_NODE;
>>>        unsigned char data_type = (type == SUM_TYPE_DATA) ? DATA : NODE;
>>>        int submitted = 0;
>>>
>>> -     if (__is_large_section(sbi))
>>> -             end_segno = rounddown(end_segno, SEGS_PER_SEC(sbi));
>>> +     if (__is_large_section(sbi)) {
>>> +             sec_end_segno = rounddown(end_segno, SEGS_PER_SEC(sbi));
>>>
>>> -     /*
>>> -      * zone-capacity can be less than zone-size in zoned devices,
>>> -      * resulting in less than expected usable segments in the zone,
>>> -      * calculate the end segno in the zone which can be garbage collected
>>> -      */
>>> -     if (f2fs_sb_has_blkzoned(sbi))
>>> -             end_segno -= SEGS_PER_SEC(sbi) -
>>> +             /*
>>> +              * zone-capacity can be less than zone-size in zoned devices,
>>> +              * resulting in less than expected usable segments in the zone,
>>> +              * calculate the end segno in the zone which can be garbage
>>> +              * collected
>>> +              */
>>> +             if (f2fs_sb_has_blkzoned(sbi))
>>> +                     sec_end_segno -= SEGS_PER_SEC(sbi) -
>>>                                        f2fs_usable_segs_in_sec(sbi, segno);
>>>
>>> +             if (gc_type == BG_GC)
>>> +                     end_segno = start_segno + sbi->migration_granularity;
>>> +
>>> +             if (end_segno > sec_end_segno)
>>> +                     end_segno = sec_end_segno;
>>> +     }
>>> +
>>>        sanity_check_seg_type(sbi, get_seg_entry(sbi, segno)->type);
>>>
>>>        /* readahead multi ssa blocks those have contiguous address */
>>> @@ -1762,9 +1771,6 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>>>
>>>                if (get_valid_blocks(sbi, segno, false) == 0)
>>>                        goto freed;
>>> -             if (gc_type == BG_GC && __is_large_section(sbi) &&
>>> -                             migrated >= sbi->migration_granularity)
>>
>> It seems we change the logic from migrating "migration_granularity" segments which
>> has valid blocks to scanning "migration_granularity" segments and try migrating
>> valid blocks in those segments.
>>
>> IIUC, when background GC recycle sparse zone, it will take gc thread more round,
>> it seems low efficient. How do you think of keeping previous implementation?
> 
> I got your point. However, with zoned devices having 1GB sections, per
> every round, we should
> touch almost 2MB size of ssa block pages, even though we didn't need
> to do it. Maybe, we can introduce

Yes, or can we:
a) just read SSA block for segment which has valid blocks;
b) limit readahead size to a threshold as you proposed.

Thanks,

> another sysfs node like migration_window_limit, which can be set as
> double as migration_granuality by default,
> limiting the size of scanning.
> 
>>
>> Thanks,
>>
>>> -                     goto skip;
>>>                if (!PageUptodate(sum_page) || unlikely(f2fs_cp_error(sbi)))
>>>                        goto skip;
>>>
>>> @@ -1803,7 +1809,8 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>>>
>>>                if (__is_large_section(sbi))
>>>                        sbi->next_victim_seg[gc_type] =
>>> -                             (segno + 1 < end_segno) ? segno + 1 : NULL_SEGNO;
>>> +                             (segno + 1 < sec_end_segno) ?
>>> +                                     segno + 1 : NULL_SEGNO;
>>>    skip:
>>>                f2fs_put_page(sum_page, 0);
>>>        }
>>


