Return-Path: <linux-kernel+bounces-324679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F66974FA3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CDE6B260FA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD4117DFFC;
	Wed, 11 Sep 2024 10:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPsfzm+c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371082EB10
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050180; cv=none; b=iLHr9L5z1m9qft+rz6ptxiQ4fcSozi9EpKM/G7UmeAKo1xVOJU1gJ1iD66wZqBWbZG/lZ5SplVtkx1aiuRhXi4qwYY5WbOqW1muinT9L/Y9GFOPbzpNnC569bCw9RfUlwIsnGuCcSzQO4fsYw5X31D77K6aV/zJFU1Ypm8N515M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050180; c=relaxed/simple;
	bh=f0S4FUmNZzyRmAxdsEPeHrzAY8IG+/3ETr++B8BFpw0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HwD+vPkHwsOci/TWHGHHWAOeKUlWCB7g8V5oW+h2Dt3AHv9e9M7erHOpa4+W5+N4IrrE6DHJ4k0G/QwIDpkbsNSt8yRBLra/Gq1WS3Oemtk3Et/4YmdmJljymVm5YIC5EVL+q2d1BhUefGFDN6H3giZi3ITBn+Cpqh/GYrihpjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPsfzm+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703FCC4CEC5;
	Wed, 11 Sep 2024 10:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726050179;
	bh=f0S4FUmNZzyRmAxdsEPeHrzAY8IG+/3ETr++B8BFpw0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=vPsfzm+cEdLxRShf6ekewpfkStsxG20DZZpTLsKG6zj9Ws2tqHUzJhOTGqO31JlxG
	 hw2ChIf6Tvu4IVskUeCcnmtbF2Rv+LSTLLiAD8bzW6EeVO6rMLMQPF6IstTrJvX/4I
	 fdWeTSchwFRKQ7UIj8oB9W7LzJ2LHUGx1PFHiRlpP0SPnobFXdxZz0EO56nLMUpXje
	 1E7a/HvRxOcuF3OpbP5aSEE+0AkrmvGvm4fnbKiiuUB9M3bW5YvZcCOzDHPzxcn3dP
	 hfLpesyAKc3Ogv/BV0iLt/O7vf9ybvdeM1ZgjfXW19M61Kg4cdGJbN60VKnGifi/7n
	 sjwIZMpY3ntKw==
Message-ID: <56e4e969-12d3-45c7-bb6a-27207ae4bf4c@kernel.org>
Date: Wed, 11 Sep 2024 18:22:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] f2fs: introduce get_section_mtime
To: liuderong@oppo.com, jaegeuk@kernel.org
References: <1726022421-58677-1-git-send-email-liuderong@oppo.com>
 <1726022421-58677-3-git-send-email-liuderong@oppo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1726022421-58677-3-git-send-email-liuderong@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/11 10:40, liuderong@oppo.com wrote:
> From: liuderong <liuderong@oppo.com>
> 
> When segs_per_sec is larger than 1, section may contain free segments,
> mtime should be the mean value of each valid segments,
> so introduce get_section_mtime to exclude free segments in a section.
> 
> Signed-off-by: liuderong <liuderong@oppo.com>
> ---
>   fs/f2fs/f2fs.h    |  2 ++
>   fs/f2fs/gc.c      | 15 ++-------------
>   fs/f2fs/segment.c | 49 ++++++++++++++++++++++++++++++++++++++++++++-----
>   3 files changed, 48 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 4dcdcdd..d6adf0f 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3762,6 +3762,8 @@ enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
>   unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi);
>   unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
>                          unsigned int segno);
> +unsigned long long get_section_mtime(struct f2fs_sb_info *sbi,
> +                       unsigned int segno);
> 
>   #define DEF_FRAGMENT_SIZE      4
>   #define MIN_FRAGMENT_SIZE      1
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 6299639..03c6117 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -332,20 +332,14 @@ static unsigned int check_bg_victims(struct f2fs_sb_info *sbi)
>   static unsigned int get_cb_cost(struct f2fs_sb_info *sbi, unsigned int segno)
>   {
>          struct sit_info *sit_i = SIT_I(sbi);
> -       unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
> -       unsigned int start = GET_SEG_FROM_SEC(sbi, secno);
>          unsigned long long mtime = 0;
>          unsigned int vblocks;
>          unsigned char age = 0;
>          unsigned char u;
> -       unsigned int i;
>          unsigned int usable_segs_per_sec = f2fs_usable_segs_in_sec(sbi);
> 
> -       for (i = 0; i < usable_segs_per_sec; i++)
> -               mtime += get_seg_entry(sbi, start + i)->mtime;
> +       mtime = get_section_mtime(sbi, segno);
>          vblocks = get_valid_blocks(sbi, segno, true);
> -
> -       mtime = div_u64(mtime, usable_segs_per_sec);
>          vblocks = div_u64(vblocks, usable_segs_per_sec);
> 
>          u = BLKS_TO_SEGS(sbi, vblocks * 100);
> @@ -485,10 +479,7 @@ static void add_victim_entry(struct f2fs_sb_info *sbi,
>                                  struct victim_sel_policy *p, unsigned int segno)
>   {
>          struct sit_info *sit_i = SIT_I(sbi);
> -       unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
> -       unsigned int start = GET_SEG_FROM_SEC(sbi, secno);
>          unsigned long long mtime = 0;
> -       unsigned int i;
> 
>          if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
>                  if (p->gc_mode == GC_AT &&
> @@ -496,9 +487,7 @@ static void add_victim_entry(struct f2fs_sb_info *sbi,
>                          return;
>          }
> 
> -       for (i = 0; i < SEGS_PER_SEC(sbi); i++)
> -               mtime += get_seg_entry(sbi, start + i)->mtime;
> -       mtime = div_u64(mtime, SEGS_PER_SEC(sbi));
> +       mtime = get_section_mtime(sbi, segno);
> 
>          /* Handle if the system time has changed by the user */
>          if (mtime < sit_i->min_mtime)
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 6627394..b63f35fa 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -5389,6 +5389,49 @@ unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi)
>          return SEGS_PER_SEC(sbi);
>   }
> 
> +unsigned long long get_section_mtime(struct f2fs_sb_info *sbi,
> +       unsigned int segno)
> +{
> +       unsigned int usable_segs_per_sec = f2fs_usable_segs_in_sec(sbi);
> +       unsigned int secno = 0, start = 0;
> +       struct free_segmap_info *free_i = FREE_I(sbi);
> +       unsigned int valid_seg_count = 0;
> +       unsigned long long mtime = 0;
> +       unsigned int i;
> +
> +       if (segno == NULL_SEGNO)
> +               return 0;
> +
> +       secno = GET_SEC_FROM_SEG(sbi, segno);
> +       start = GET_SEG_FROM_SEC(sbi, secno);
> +
> +       for (i = 0; i < usable_segs_per_sec; i++) {
> +               /* for large section, only check the mtime of valid segments */
> +               if (__is_large_section(sbi)) {
> +                       spin_lock(&free_i->segmap_lock);
> +                       if (test_bit(start + i, free_i->free_segmap)) {
> +                               mtime += get_seg_entry(sbi, start + i)->mtime;
> +                               valid_seg_count++;
> +                       }
> +                       spin_unlock(&free_i->segmap_lock);
> +               } else {
> +                       mtime += get_seg_entry(sbi, start + i)->mtime;
> +               }
> +       }
> +
> +       if (__is_large_section(sbi)) {
> +               if (!valid_seg_count)
> +                       goto out;
> +               mtime = div_u64(mtime, valid_seg_count);
> +       } else {
> +               mtime = div_u64(mtime, usable_segs_per_sec);
> +       }

What about:

if (!__is_large_section(sbi))
	return get_seg_entry(sbi, start + i)->mtime;

for (i = 0; i < usable_segs_per_sec; i++) {
	/* for large section, only check the mtime of valid segments */
	...
}

return div_u64(mtime, usable_segs_per_sec);

Thanks,

> +
> +out:
> +       return mtime;
> +}
> +
>   /*
>    * Update min, max modified time for cost-benefit GC algorithm
>    */
> @@ -5402,13 +5445,9 @@ static void init_min_max_mtime(struct f2fs_sb_info *sbi)
>          sit_i->min_mtime = ULLONG_MAX;
> 
>          for (segno = 0; segno < MAIN_SEGS(sbi); segno += SEGS_PER_SEC(sbi)) {
> -               unsigned int i;
>                  unsigned long long mtime = 0;
> 
> -               for (i = 0; i < SEGS_PER_SEC(sbi); i++)
> -                       mtime += get_seg_entry(sbi, segno + i)->mtime;
> -
> -               mtime = div_u64(mtime, SEGS_PER_SEC(sbi));
> +               mtime = get_section_mtime(sbi, segno);
> 
>                  if (sit_i->min_mtime > mtime)
>                          sit_i->min_mtime = mtime;
> --
> 2.7.4


