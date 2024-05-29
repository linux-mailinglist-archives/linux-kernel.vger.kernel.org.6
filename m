Return-Path: <linux-kernel+bounces-193996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123608D353A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B891C2194A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B73169383;
	Wed, 29 May 2024 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOwngCH0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB21167DBD
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 11:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981215; cv=none; b=VqWSeWm/s1sglribn3yo/J4mNDCjMOaan9j60wRuRzOOwzyGRLO3UfiIswfzJSte015Jtu6USWWUTAD2MfPwJXD+cJhE0AlnSZBSj9OijrtRvWRQOiN1uODayqsl8XA/jjXdcXRYb1U+evBoWfECDyaUNA2fJQmhzoNdI4DldQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981215; c=relaxed/simple;
	bh=b7FjpDnBjzb3hqaviXRWE3Ie4w+SaRNZu55hMptmPaA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=afJ9OpuJhUceb5tAzeV35jHUL9IsEXIUmgRYR/iMA80W2BZtJTnF87chveampk+ZS0qPmibw3RpXd8VQpIApcNe/y37iVE6zgDUcE33M6p0Ap2EEw3EH/6SW2/KGPx7pozISgZ1xnrhZdEGUdef/Njc7v7pRrfSEJmaXogHqlYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOwngCH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D459C32786;
	Wed, 29 May 2024 11:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716981215;
	bh=b7FjpDnBjzb3hqaviXRWE3Ie4w+SaRNZu55hMptmPaA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=aOwngCH0HIPpHe0Mclknzuv8OKq5zUPew3cN2CwZtZE3/EmaLg+B0hx9E2LurWdvX
	 UTOAhs+11C9dsWr1+YNWVwWLUggS9gTCWDPO8Ph6zZU0mweZ3JF9baDW2olIatSyOl
	 HYOTVWbEeFXiJDoMh9bqsQ0lzhZx4oSKKhTJvRmdOZ+6+Vj18rCIbVxJvnzJO7q1RR
	 zJO/LL7nWvoUheSBEND+q8BEGAthMtrHOvlqoeVEqEZfHF4Kzf6XWPtOR1PHFKHQvD
	 14z/EtjU09zwB8f6ICVbM0DI2ctRpU5U+zMdeLFWx/WA122w9VAw/WReV14fxBRz+J
	 DyOl2+9p6S2KQ==
Message-ID: <03647897-8b1f-4c82-b2b6-0aa0704bed05@kernel.org>
Date: Wed, 29 May 2024 19:13:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: use per-log target_bitmap to
 improve lookup performace of ssr allocation
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20240411082354.1691820-1-chao@kernel.org>
 <11d5d736-bae5-4a71-b400-087b8722893c@kernel.org>
Content-Language: en-US
In-Reply-To: <11d5d736-bae5-4a71-b400-087b8722893c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Ping,

On 2024/4/23 10:07, Chao Yu wrote:
> Jaegeuk, any comments for this serials?
> 
> On 2024/4/11 16:23, Chao Yu wrote:
>> After commit 899fee36fac0 ("f2fs: fix to avoid data corruption by
>> forbidding SSR overwrite"), valid block bitmap of current openned
>> segment is fixed, let's introduce a per-log bitmap instead of temp
>> bitmap to avoid unnecessary calculation overhead whenever allocating
>> free slot w/ SSR allocator.
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v2:
>> - rebase to last dev-test branch.
>>   fs/f2fs/segment.c | 30 ++++++++++++++++++++++--------
>>   fs/f2fs/segment.h |  1 +
>>   2 files changed, 23 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 6474b7338e81..af716925db19 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -2840,31 +2840,39 @@ static int new_curseg(struct f2fs_sb_info *sbi, int type, bool new_sec)
>>       return 0;
>>   }
>> -static int __next_free_blkoff(struct f2fs_sb_info *sbi,
>> -                    int segno, block_t start)
>> +static void __get_segment_bitmap(struct f2fs_sb_info *sbi,
>> +                    unsigned long *target_map,
>> +                    int segno)
>>   {
>>       struct seg_entry *se = get_seg_entry(sbi, segno);
>>       int entries = SIT_VBLOCK_MAP_SIZE / sizeof(unsigned long);
>> -    unsigned long *target_map = SIT_I(sbi)->tmp_map;
>>       unsigned long *ckpt_map = (unsigned long *)se->ckpt_valid_map;
>>       unsigned long *cur_map = (unsigned long *)se->cur_valid_map;
>>       int i;
>>       for (i = 0; i < entries; i++)
>>           target_map[i] = ckpt_map[i] | cur_map[i];
>> +}
>> +
>> +static int __next_free_blkoff(struct f2fs_sb_info *sbi, unsigned long *bitmap,
>> +                    int segno, block_t start)
>> +{
>> +    __get_segment_bitmap(sbi, bitmap, segno);
>> -    return __find_rev_next_zero_bit(target_map, BLKS_PER_SEG(sbi), start);
>> +    return __find_rev_next_zero_bit(bitmap, BLKS_PER_SEG(sbi), start);
>>   }
>>   static int f2fs_find_next_ssr_block(struct f2fs_sb_info *sbi,
>> -        struct curseg_info *seg)
>> +                    struct curseg_info *seg)
>>   {
>> -    return __next_free_blkoff(sbi, seg->segno, seg->next_blkoff + 1);
>> +    return __find_rev_next_zero_bit(seg->target_map,
>> +                BLKS_PER_SEG(sbi), seg->next_blkoff + 1);
>>   }
>>   bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno)
>>   {
>> -    return __next_free_blkoff(sbi, segno, 0) < BLKS_PER_SEG(sbi);
>> +    return __next_free_blkoff(sbi, SIT_I(sbi)->tmp_map, segno, 0) <
>> +                            BLKS_PER_SEG(sbi);
>>   }
>>   /*
>> @@ -2890,7 +2898,8 @@ static int change_curseg(struct f2fs_sb_info *sbi, int type)
>>       reset_curseg(sbi, type, 1);
>>       curseg->alloc_type = SSR;
>> -    curseg->next_blkoff = __next_free_blkoff(sbi, curseg->segno, 0);
>> +    curseg->next_blkoff = __next_free_blkoff(sbi, curseg->target_map,
>> +                            curseg->segno, 0);
>>       sum_page = f2fs_get_sum_page(sbi, new_segno);
>>       if (IS_ERR(sum_page)) {
>> @@ -4635,6 +4644,10 @@ static int build_curseg(struct f2fs_sb_info *sbi)
>>                   sizeof(struct f2fs_journal), GFP_KERNEL);
>>           if (!array[i].journal)
>>               return -ENOMEM;
>> +        array[i].target_map = f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE,
>> +                                GFP_KERNEL);
>> +        if (!array[i].target_map)
>> +            return -ENOMEM;
>>           if (i < NR_PERSISTENT_LOG)
>>               array[i].seg_type = CURSEG_HOT_DATA + i;
>>           else if (i == CURSEG_COLD_DATA_PINNED)
>> @@ -5453,6 +5466,7 @@ static void destroy_curseg(struct f2fs_sb_info *sbi)
>>       for (i = 0; i < NR_CURSEG_TYPE; i++) {
>>           kfree(array[i].sum_blk);
>>           kfree(array[i].journal);
>> +        kfree(array[i].target_map);
>>       }
>>       kfree(array);
>>   }
>> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
>> index e1c0f418aa11..10f3e44f036f 100644
>> --- a/fs/f2fs/segment.h
>> +++ b/fs/f2fs/segment.h
>> @@ -292,6 +292,7 @@ struct curseg_info {
>>       struct f2fs_summary_block *sum_blk;    /* cached summary block */
>>       struct rw_semaphore journal_rwsem;    /* protect journal area */
>>       struct f2fs_journal *journal;        /* cached journal info */
>> +    unsigned long *target_map;        /* bitmap for SSR allocator */
>>       unsigned char alloc_type;        /* current allocation type */
>>       unsigned short seg_type;        /* segment type like CURSEG_XXX_TYPE */
>>       unsigned int segno;            /* current segment number */
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

