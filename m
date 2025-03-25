Return-Path: <linux-kernel+bounces-574871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D20EA6EAF4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601E13B0373
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAAF19F12D;
	Tue, 25 Mar 2025 08:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOytFZy0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3862E3399
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742889673; cv=none; b=cI53ro4ALYeNWNQTkG/d9MdKzxm4+LoTskujC1Epr88lX45g2GfYqQNKE03mZVOT6IYPMEWbtPpSP7BtbW5/c/RcCNUjBl+gEPwcjIG5uyIivib7eJRAvuF0cEGRMwtw/RLX90Sx4KBrXjynlGDn/GrH0b8x/nqYAZQrILvRODw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742889673; c=relaxed/simple;
	bh=nBzODTaNJWiJV4/XWp0uU9JMHDqmhaxlxmuw1FZbtrk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MlrlP1VwvKIuzDa17uRl38wutW7vBbs4Bz7SACii3QSfChaycy5jW2G7peo1V0+02YljI2gqrJgxEeW9mlyvhBpvSqmtV5f30H9/19/k2b9U6UoXL/tUTOaubFKkt7MbyUeu1s1PSxHHGzUcwYW9fZCdKylU/sVOuL2V9Fc+TX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOytFZy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B15CC4CEE4;
	Tue, 25 Mar 2025 08:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742889673;
	bh=nBzODTaNJWiJV4/XWp0uU9JMHDqmhaxlxmuw1FZbtrk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=jOytFZy0qGEH9OQiN6+BWoYbhCsUJFebsk2njokSsMb7U49sLONdDcaZ3FuSxTpK/
	 G7qzX2xJ4YNHJffaZH9vXknSR2ygFBQaCCzJ2ncA+jjyvUmurg/nG6oWcam+lKTabz
	 4+RjQ2vCRBP+6WOZRj/MS8gUSVXvaT6du67LFbUGv70Wuku/jdFaUuVJ6ZMuvoaBqH
	 oaKl0W6/+MLrb+Rr+cUPrwQwdPhTOW39E1KupY3frQMIN87JAnliQNL7oPJIYS4xOo
	 3d4A184mjPQ/ZI2vnNFXN2yB0eVIx7mUlpCJVm2CTXzq9AS3wZ9z5gapRTaqBAxlEd
	 DmAnd2wDZplYg==
Message-ID: <6b130bed-a18c-4786-bb7f-3588dc8742ab@kernel.org>
Date: Tue, 25 Mar 2025 16:01:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, jaegeuk@kernel.org, Daeho Jeong <daehojeong@google.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: zone: fix to calculate
 first_zoned_segno correctly
To: Daeho Jeong <daeho43@gmail.com>
References: <20250324114935.3087821-1-chao@kernel.org>
 <CACOAw_zQ1+yMknJ76B+H2-N=BfY4a85Yjwicip5UTQu9GLZQdA@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CACOAw_zQ1+yMknJ76B+H2-N=BfY4a85Yjwicip5UTQu9GLZQdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/25/25 04:49, Daeho Jeong wrote:
> On Mon, Mar 24, 2025 at 4:54 AM Chao Yu via Linux-f2fs-devel
> <linux-f2fs-devel@lists.sourceforge.net> wrote:
>>
>> A zoned device can has both conventional zones and sequential zones,
>> so we should not treat first segment of zoned device as first_zoned_segno,
>> instead, we need to check zone type for each zone during traversing zoned
>> device to find first_zoned_segno.
>>
>> Otherwise, for below case, first_zoned_segno will be 0, which could be
>> wrong.
>>
>> create_null_blk 512 2 1024 1024
>> mkfs.f2fs -m /dev/nullb0
>>
>> Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
>> Cc: Daeho Jeong <daehojeong@google.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>  fs/f2fs/f2fs.h    | 18 +++++++++++++-----
>>  fs/f2fs/segment.c |  2 +-
>>  fs/f2fs/super.c   | 32 +++++++++++++++++++++++++++-----
>>  3 files changed, 41 insertions(+), 11 deletions(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index ca884e39a5ff..3dea037faa55 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -4630,12 +4630,16 @@ F2FS_FEATURE_FUNCS(readonly, RO);
>>  F2FS_FEATURE_FUNCS(device_alias, DEVICE_ALIAS);
>>
>>  #ifdef CONFIG_BLK_DEV_ZONED
>> -static inline bool f2fs_blkz_is_seq(struct f2fs_sb_info *sbi, int devi,
>> -                                   block_t blkaddr)
>> +static inline bool f2fs_zone_is_seq(struct f2fs_sb_info *sbi, int devi,
>> +                                                       unsigned int zone)
>>  {
>> -       unsigned int zno = blkaddr / sbi->blocks_per_blkz;
>> +       return test_bit(zone, FDEV(devi).blkz_seq);
>> +}
>>
>> -       return test_bit(zno, FDEV(devi).blkz_seq);
>> +static inline bool f2fs_blkz_is_seq(struct f2fs_sb_info *sbi, int devi,
>> +                                                               block_t blkaddr)
>> +{
>> +       return f2fs_zone_is_seq(sbi, devi, blkaddr / sbi->blocks_per_blkz);
>>  }
>>  #endif
>>
>> @@ -4711,9 +4715,13 @@ static inline bool f2fs_valid_pinned_area(struct f2fs_sb_info *sbi,
>>                                           block_t blkaddr)
>>  {
>>         if (f2fs_sb_has_blkzoned(sbi)) {
>> +#ifdef CONFIG_BLK_DEV_ZONED
>>                 int devi = f2fs_target_device_index(sbi, blkaddr);
>>
>> -               return !bdev_is_zoned(FDEV(devi).bdev);
>> +               return !f2fs_blkz_is_seq(sbi, devi, blkaddr);
>> +#else
>> +               return true;
>> +#endif
>>         }
>>         return true;
>>  }
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 396ef71f41e3..dc360b4b0569 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -3311,7 +3311,7 @@ int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi)
>>
>>         if (f2fs_sb_has_blkzoned(sbi) && err == -EAGAIN && gc_required) {
>>                 f2fs_down_write(&sbi->gc_lock);
>> -               err = f2fs_gc_range(sbi, 0, GET_SEGNO(sbi, FDEV(0).end_blk),
>> +               err = f2fs_gc_range(sbi, 0, sbi->first_zoned_segno - 1,
>>                                 true, ZONED_PIN_SEC_REQUIRED_COUNT);
>>                 f2fs_up_write(&sbi->gc_lock);
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 011925ee54f8..b2342366020a 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -4307,12 +4307,26 @@ static void f2fs_record_error_work(struct work_struct *work)
>>
>>  static inline unsigned int get_first_zoned_segno(struct f2fs_sb_info *sbi)
>>  {
>> -       int devi;
>> +#ifdef CONFIG_BLK_DEV_ZONED
>> +       unsigned int segno;
>> +       int devi, i;
>>
>> -       for (devi = 0; devi < sbi->s_ndevs; devi++)
>> -               if (bdev_is_zoned(FDEV(devi).bdev))
>> -                       return GET_SEGNO(sbi, FDEV(devi).start_blk);
>> -       return 0;
>> +       if (!f2fs_sb_has_blkzoned(sbi))
>> +               return NULL_SEGNO;
>> +
>> +       for (devi = 0; devi < sbi->s_ndevs; devi++) {
>> +               if (!bdev_is_zoned(FDEV(devi).bdev))
>> +                       continue;
>> +
>> +               segno = GET_SEGNO(sbi, FDEV(devi).start_blk);
>> +               for (i = 0; i < FDEV(devi).total_segments; i++) {
>> +                       if (f2fs_zone_is_seq(sbi, devi,
>> +                               GET_ZONE_FROM_SEG(sbi, segno + i)))
> 
> Maybe we can check it with a zone unit?

Yeah, better, let me update it in v2.

Thanks,

> 
>> +                               return segno + i;
>> +               }
>> +       }
>> +#endif
>> +       return NULL_SEGNO;
>>  }
>>
>>  static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>> @@ -4349,6 +4363,14 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>>  #endif
>>
>>         for (i = 0; i < max_devices; i++) {
>> +               if (max_devices == 1) {
>> +                       FDEV(i).total_segments =
>> +                               le32_to_cpu(raw_super->segment_count_main);
>> +                       FDEV(i).start_blk = 0;
>> +                       FDEV(i).end_blk = FDEV(i).total_segments *
>> +                                               BLKS_PER_SEG(sbi);
>> +               }
>> +
>>                 if (i == 0)
>>                         FDEV(0).bdev_file = sbi->sb->s_bdev_file;
>>                 else if (!RDEV(i).path[0])
>> --
>> 2.48.1
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


