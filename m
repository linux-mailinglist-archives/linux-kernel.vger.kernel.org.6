Return-Path: <linux-kernel+bounces-246706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D277B92C562
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7501F22FB4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110FD182A62;
	Tue,  9 Jul 2024 21:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2sQbdUL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5902E185611
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 21:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720561073; cv=none; b=km3glISLcBnWC8hEuWw6korna24Kl9RzBDEzFGTYDgs96CACovKd4tS96Z/yTIdQ0r3zAQjR9/ggqzbgrj15O/AkIlGTLVnOjqnyjfS886zutpUHha8ew8VSTJRQGBfJepTEqUelrN4/e5j3pn35BwHdnrV8c8aBMOBZcyQsQ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720561073; c=relaxed/simple;
	bh=gsLdDddWkHg5lq2YwUFU5nuknJozwpUymGvYM9nQiIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2vV5fVbibA0VoGFOoTWIf+Czm9eg+8CyqAvmZNHNAE9jM6153uBgRxQ4Pnr5qz2nhMdEIy5MOFwFY+KXjwoXhjtvBCb/14+rwGvrCakwjrk+u4xtoAest8dhiPq/At9agtaH9+RvlV0T3iiJ5ysuASm3m89Xlms0TPb3FaRUs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2sQbdUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2F0C32786;
	Tue,  9 Jul 2024 21:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720561073;
	bh=gsLdDddWkHg5lq2YwUFU5nuknJozwpUymGvYM9nQiIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u2sQbdUL2DveWVPjld3UkF5xK9RsJt0/zgw/DBnaUDWI5oRY+neLWb02TwwXgQ8f8
	 PQWbp1O8UTT4yC4s6Va2/skbZyiLALG6N2YfsYkJpuSACpqHCSR7V0egmQX3FN21Yo
	 41W7jGc0Juiwu0IeT9J6YYL3CH0PcrXlr8XEitaFSFXKjiMmuagYlljioeJr4Y2lvC
	 JSwIjbhTJcyDSDl1rrex62LjiFPG6SlsANrQrK7tVN+5CAbQyiC9+66k1lsBdAX4XQ
	 VI9g76/9wdEsVfGbHNr50mKUoasEGmpI6DHWQm+aqQeyvT+Cm1lH19k1zDsgAWERU/
	 s8dxAIzFp+QVg==
Date: Tue, 9 Jul 2024 21:37:51 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Sheng Yong <shengyong@oppo.com>
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, daehojeong@google.com
Subject: Re: [PATCH v2] f2fs: only fragment segment in the same section
Message-ID: <Zo2tr92oxPEuKBFm@google.com>
References: <20240625075839.3750112-1-shengyong@oppo.com>
 <20240625121512.3877754-1-shengyong@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625121512.3877754-1-shengyong@oppo.com>

On 06/25, Sheng Yong wrote:
> When new_curseg() is allocating a new segment, if mode=fragment:xxx is
> switched on in large section scenario, __get_next_segno() will select
> the next segno randomly in the range of [0, maxsegno] in order to
> fragment segments.
> 
> If the candidate segno is free, get_new_segment() will use it directly
> as the new segment.
> 
> However, if the section of the candidate is not empty, and some other
> segments have already been used, and have a different type (e.g NODE)
> with the candidate (e.g DATA), GC will complain inconsistent segment
> type later.
> 
> This could be reproduced by the following steps:
> 
>   dd if=/dev/zero of=test.img bs=1M count=10240
>   mkfs.f2fs -s 128 test.img
>   mount -t f2fs test.img /mnt -o mode=fragment:block
>   echo 1 > /sys/fs/f2fs/loop0/max_fragment_chunk
>   echo 512 > /sys/fs/f2fs/loop0/max_fragment_hole
>   dd if=/dev/zero of=/mnt/testfile bs=4K count=100
>   umount /mnt
> 
>   F2FS-fs (loop0): Inconsistent segment (4377) type [0, 1] in SSA and SIT
> 
> In order to allow simulating segment fragmentation in large section
> scenario, this patch reduces the candidate range:
>  * if curseg is the last segment in the section, return curseg->segno
>    to make get_new_segment() itself find the next free segment.
>  * if curseg is in the middle of the secion, select candicate randomly in
>    the range of [curseg + 1, last_seg_in_the_same_section] to keep type
>    consistent.
> 
> Signed-off-by: Sheng Yong <shengyong@oppo.com>
> ---
> v2: update commit msg
> ---
>  fs/f2fs/segment.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index a0ce3d080f80a..55d474f5c2103 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2782,10 +2782,21 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
>  {
>  	struct curseg_info *curseg = CURSEG_I(sbi, type);
>  	unsigned short seg_type = curseg->seg_type;
> +	unsigned int hint;
>  
>  	sanity_check_seg_type(sbi, seg_type);
> -	if (f2fs_need_rand_seg(sbi))
> -		return get_random_u32_below(MAIN_SECS(sbi) * SEGS_PER_SEC(sbi));
> +	if (f2fs_need_rand_seg(sbi)) {
> +		if (__is_large_section(sbi)) {
> +			hint = GET_SEC_FROM_SEG(sbi, curseg->segno);
> +			if (GET_SEC_FROM_SEG(sbi, curseg->segno + 1) != hint)
> +				return curseg->segno;
> +			return get_random_u32_inclusive(curseg->segno + 1,
> +					GET_SEG_FROM_SEC(sbi, hint + 1) - 1);
> +		} else {
> +			return get_random_u32_below(MAIN_SECS(sbi) *
> +						SEGS_PER_SEC(sbi));
> +		}
> +	}
>  
>  	if (__is_large_section(sbi))
>  		return curseg->segno;

	if (__is_large_section(sbi)) {
		if (f2fs_need_rand_seg(sbi)) {
			unsigned int hint = GET_SEC_FROM_SEG(sbi, curseg->segno);
			if (GET_SEC_FROM_SEG(sbi, curseg->segno + 1) != hint)
				return curseg->segno;
			return get_random_u32_inclusive(curseg->segno + 1,
					GET_SEG_FROM_SEC(sbi, hint + 1) - 1);
		}
		return curseg->segno;
	} else if (f2fs_need_rand_seg(sbi)) {
		return get_random_u32_below(MAIN_SECS(sbi) * SEGS_PER_SEC(sbi));
	}

> -- 
> 2.40.1

