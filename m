Return-Path: <linux-kernel+bounces-333074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F92D97C31A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 05:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7903B21067
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 03:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EB8134AB;
	Thu, 19 Sep 2024 03:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHwKijca"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04776125A9
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 03:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726716239; cv=none; b=eSvwpQAhQWpq0hsGNQGmIHLwyN/z1TduJRtZa7rWs+WW4myizYqwrXiux1bfnds6TmGEUJdWmNZ430ybAnG7Ydmv1NNAIguCgstUCjLaLj4Dfa+LHrovpEkJWRgAwMcKnJQ2TgZ0VknVZGwfMCXpxw9TO+SKuPeppDahOg5B6o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726716239; c=relaxed/simple;
	bh=gnn1ELW9CxKmPfvgVTE6Z1ouhHxmjc7arPy/y1gMlNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ermWGd9sIGcT5Vl5Pfw4gjqRsv85tAzpnevTx8iGuEV9MQ9dBZ1bZmR9oaNIh60n0qnJG5jH9HCZ6R8JzDOlRS+CRaSJbNPmtp+B9PaBRrNJjNPA8cfoJ1Gvmo/YXPljyDImmHGZZFOU70ZD9qsJ59fhs5JDokSnoQ4bIogF9y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHwKijca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA6FC4CEC4;
	Thu, 19 Sep 2024 03:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726716238;
	bh=gnn1ELW9CxKmPfvgVTE6Z1ouhHxmjc7arPy/y1gMlNQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jHwKijcax0ssTYdlIlCkS/ztXDbVg5NrRk8dbMHY4yWYefBEQBvg0v93Xzi77XTSw
	 tOYJOgzOHJMBGA+ztjLuHkxrZoPJxNHUBLhPjp7vYOfFEgWoNRKotyGj3X84dDG/+s
	 paU2gKEIQp/QsFjlLTKq5u9QvqZml0si/myWfOQeJUbaeZtDEJqXPZtzUK8BTzfLKI
	 0STPtxY7zfOnWWQM4r9LJL33mlb+imBXAR4jFVbT6TfHb98dFxC5VWMtyed7goTtnF
	 BytCPiVkR/oIgbot1Kq6cAuC42+EmAnczTRnVhjeh17rU9eLhJ2hjrIPugZbRwtbRL
	 mw0o2Ka6LZCIw==
Message-ID: <1447a1bb-7c8e-4c9f-bf4d-cd61cd3652e7@kernel.org>
Date: Thu, 19 Sep 2024 11:23:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: introduce get_section_mtime
To: Zhiguo Niu <niuzhiguo84@gmail.com>, Chao Yu <chao@kernel.org>
Cc: liuderong@oppo.com, jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <1726123214-208356-1-git-send-email-liuderong@oppo.com>
 <1726123214-208356-3-git-send-email-liuderong@oppo.com>
 <17ceed17-b17f-42d9-8c82-79f1f4814c1a@kernel.org>
 <CAHJ8P3LNpZamiva_Ktck+tRKXvyAAYK0dg_z2Mwjiq41aeMF0Q@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3LNpZamiva_Ktck+tRKXvyAAYK0dg_z2Mwjiq41aeMF0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/9/19 10:23, Zhiguo Niu wrote:
> Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
> 于2024年9月18日周三 14:45写道：
>>
>> On 2024/9/12 14:40, liuderong@oppo.com wrote:
>>> From: liuderong <liuderong@oppo.com>
>>>
>>> When segs_per_sec is larger than 1, section may contain free segments,
>>> mtime should be the mean value of each valid segments,
>>> so introduce get_section_mtime to exclude free segments in a section.
>>>
>>> Signed-off-by: liuderong <liuderong@oppo.com>
>>> ---
>>>    fs/f2fs/f2fs.h    |  2 ++
>>>    fs/f2fs/gc.c      | 15 ++-------------
>>>    fs/f2fs/segment.c | 41 ++++++++++++++++++++++++++++++++++++-----
>>>    3 files changed, 40 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index 4dcdcdd..d6adf0f 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -3762,6 +3762,8 @@ enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
>>>    unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi);
>>>    unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
>>>                        unsigned int segno);
>>> +unsigned long long get_section_mtime(struct f2fs_sb_info *sbi,
>>> +                     unsigned int segno);
>>
>> Hi Derong,
>>
>> It needs to add "f2fs_" prefix for get_section_mtime() to avoid global
>> namespace pollution.
>>
>>>
>>>    #define DEF_FRAGMENT_SIZE   4
>>>    #define MIN_FRAGMENT_SIZE   1
>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>> index 6299639..03c6117 100644
>>> --- a/fs/f2fs/gc.c
>>> +++ b/fs/f2fs/gc.c
>>> @@ -332,20 +332,14 @@ static unsigned int check_bg_victims(struct f2fs_sb_info *sbi)
>>>    static unsigned int get_cb_cost(struct f2fs_sb_info *sbi, unsigned int segno)
>>>    {
>>>        struct sit_info *sit_i = SIT_I(sbi);
>>> -     unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
>>> -     unsigned int start = GET_SEG_FROM_SEC(sbi, secno);
>>>        unsigned long long mtime = 0;
>>>        unsigned int vblocks;
>>>        unsigned char age = 0;
>>>        unsigned char u;
>>> -     unsigned int i;
>>>        unsigned int usable_segs_per_sec = f2fs_usable_segs_in_sec(sbi);
>>>
>>> -     for (i = 0; i < usable_segs_per_sec; i++)
>>> -             mtime += get_seg_entry(sbi, start + i)->mtime;
>>> +     mtime = get_section_mtime(sbi, segno);
>>>        vblocks = get_valid_blocks(sbi, segno, true);
>>> -
>>> -     mtime = div_u64(mtime, usable_segs_per_sec);
>>>        vblocks = div_u64(vblocks, usable_segs_per_sec);
>>>
>>>        u = BLKS_TO_SEGS(sbi, vblocks * 100);
>>> @@ -485,10 +479,7 @@ static void add_victim_entry(struct f2fs_sb_info *sbi,
>>>                                struct victim_sel_policy *p, unsigned int segno)
>>>    {
>>>        struct sit_info *sit_i = SIT_I(sbi);
>>> -     unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
>>> -     unsigned int start = GET_SEG_FROM_SEC(sbi, secno);
>>>        unsigned long long mtime = 0;
>>> -     unsigned int i;
>>>
>>>        if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
>>>                if (p->gc_mode == GC_AT &&
>>> @@ -496,9 +487,7 @@ static void add_victim_entry(struct f2fs_sb_info *sbi,
>>>                        return;
>>>        }
>>>
>>> -     for (i = 0; i < SEGS_PER_SEC(sbi); i++)
>>> -             mtime += get_seg_entry(sbi, start + i)->mtime;
>>> -     mtime = div_u64(mtime, SEGS_PER_SEC(sbi));
>>> +     mtime = get_section_mtime(sbi, segno);
>>>
>>>        /* Handle if the system time has changed by the user */
>>>        if (mtime < sit_i->min_mtime)
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 6627394..e62e722 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -5389,6 +5389,41 @@ unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi)
>>>        return SEGS_PER_SEC(sbi);
>>>    }
>>>
>>> +unsigned long long get_section_mtime(struct f2fs_sb_info *sbi,
>>> +     unsigned int segno)
>>> +{
>>> +     unsigned int usable_segs_per_sec = f2fs_usable_segs_in_sec(sbi);
>>> +     unsigned int secno = 0, start = 0;
>>> +     struct free_segmap_info *free_i = FREE_I(sbi);
>>> +     unsigned int valid_seg_count = 0;
>>> +     unsigned long long mtime = 0;
>>> +     unsigned int i = 0;
>>> +
>>> +     if (segno == NULL_SEGNO)
>>> +             return 0;
>>
>> No needed.
>>
>>> +
>>> +     secno = GET_SEC_FROM_SEG(sbi, segno);
>>> +     start = GET_SEG_FROM_SEC(sbi, secno);
>>> +
>>> +     if (!__is_large_section(sbi))
>>> +             return get_seg_entry(sbi, start + i)->mtime;
>>> +
>>> +     for (i = 0; i < usable_segs_per_sec; i++) {
>>> +             /* for large section, only check the mtime of valid segments */
>>> +             spin_lock(&free_i->segmap_lock);
>>> +             if (test_bit(start + i, free_i->free_segmap)) {
>>> +                     mtime += get_seg_entry(sbi, start + i)->mtime;
>>> +                     valid_seg_count++;
>>> +             }
>>> +             spin_unlock(&free_i->segmap_lock);
>>> +     }
>>
>> After commit 6f3a01ae9b72 ("f2fs: record average update time of segment"),
>> mtime of segment starts to indicate average update time of segment.
>>
>> So it needs to change like this?
>>
>> for (i = 0; i < usable_segs_per_sec; i++) {
>>          struct seg_entry *se = get_seg_entry(sbi, start + i);
>>
>>          mtime += se->mtime * se->valid_blocks;
>>          total_valid_blocks += se->valid_blocks;
>> }
> hi Chao,
> after I read this patch from Derong and base on your this comment,
> I have some doubts：
> mtime is update in update_segment_mtime, and this API is called by
> more than one path， such as f2fs_invalidate_blocks and f2fs_allocate_data_block,
> and se->mtime is calculated by the following  flow if se->mtime is not null.
> --------------------------------
> se->mtime = div_u64(se->mtime * se->valid_blocks + mtime,
> se->valid_blocks + 1);
> --------------------------------
> if this is called from f2fs_invalidate_blocks, se->mtime is still calculated by
> mtime / se->valid_blocks + 1, but the real value of se->valid_blocks will
> will be reduced  1，So isn’t it a bit inaccurate just calculating valid
> blocks in this patch?

When target block was invalidated, I want to superpose its mtime into
average mtime of segment, so that segment mtime can indicate there are
still updates on this segment, and the segment will not become too elder
to be selected by BGGC, so, I used that calculation method.

Thanks,

> thanks!
>>
>> if (total_valid_blocks == 0)
>>          return 0;
>>
>> return div_u64(mtime, total_valid_blocks);
>>
>> Thanks,
>>
>>> +
>>> +     if (valid_seg_count == 0)
>>> +             return 0;
>>> +
>>> +     return div_u64(mtime, valid_seg_count);
>>> +}
>>> +
>>>    /*
>>>     * Update min, max modified time for cost-benefit GC algorithm
>>>     */
>>> @@ -5402,13 +5437,9 @@ static void init_min_max_mtime(struct f2fs_sb_info *sbi)
>>>        sit_i->min_mtime = ULLONG_MAX;
>>>
>>>        for (segno = 0; segno < MAIN_SEGS(sbi); segno += SEGS_PER_SEC(sbi)) {
>>> -             unsigned int i;
>>>                unsigned long long mtime = 0;
>>>
>>> -             for (i = 0; i < SEGS_PER_SEC(sbi); i++)
>>> -                     mtime += get_seg_entry(sbi, segno + i)->mtime;
>>> -
>>> -             mtime = div_u64(mtime, SEGS_PER_SEC(sbi));
>>> +             mtime = get_section_mtime(sbi, segno);
>>>
>>>                if (sit_i->min_mtime > mtime)
>>>                        sit_i->min_mtime = mtime;
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


