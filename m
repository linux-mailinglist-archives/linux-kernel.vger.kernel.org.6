Return-Path: <linux-kernel+bounces-565262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CFEA664CD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 02:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437FE189690B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94117081F;
	Tue, 18 Mar 2025 01:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbQtkQ8s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24163219FC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 01:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742260725; cv=none; b=ZyOM79UAPKBD1nFrqRyELGTiqURNhbR5jag7TSX3So2EdXR8ttO6OyggqRG5M8HFnYmXbqoz5mhOtPjclrqv4Po/DvnVZHMCC22lDjaBH38rnS5si/LwXX8CiMkGqcZcGkfQNQqYU7mrYLAhfG4bC+yvN8WeupsSAXKOx4bREiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742260725; c=relaxed/simple;
	bh=YSMbJQm0dtkQCgXKxD1IBYJdlWjjJpfSyCN7la2UKg8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=vEouM6TlxrPwl2x7TB0EgEnTwDWTAXBJuQbVNo20zznnGhvCx71NR6vclAcFuFZrvsSAgKgTPuLIkUB70Cgdx2VFXu8X/15daB0AG4OG87tMxDd7NK/9sYxQIoIhCt6CMJWv0+KCVQyW7e2d0IRT7B9T7RF+VgURktS//yRfLXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbQtkQ8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AD1C4CEE3;
	Tue, 18 Mar 2025 01:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742260723;
	bh=YSMbJQm0dtkQCgXKxD1IBYJdlWjjJpfSyCN7la2UKg8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=NbQtkQ8sdbI2EhaGjfAO8JcdK/s5hZsL/zi0FGzYsodq27nzkUlP+cVHPWxqnt/dr
	 4ZbbTMlB/Ce/7GAo65RwTnz4P71hcrileui7yCA/NZSsn+uMPUKPZ5QcCZ0mMOdUg+
	 M1pA7DjA58/4fH6DJZCPX7yQUJfF4wcLe5cM5Sm7GPb+8kSf2dRzisdiOcz8NE8hom
	 K8QWHzOPt9CZo1i628dvt1KosDWVUGo0O3tjwTx2/n2J7+6OrFmF23KEysFGhlz2am
	 PwYLxJNnQeyJyWuw8HRvVPMVVT4gFxdi74tUNnBSsj1RkbO1oNHSHuGyFfgX4zU4E7
	 3qZxCtQIv80Ow==
Message-ID: <0cbe2a82-6e1c-425d-a967-85e4de44067d@kernel.org>
Date: Tue, 18 Mar 2025 09:18:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] f2fs: fix missing discard for active segments
To: Chunhai Guo <guochunhai@vivo.com>, jaegeuk@kernel.org
References: <20250317101624.3223575-1-guochunhai@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250317101624.3223575-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/25 18:16, Chunhai Guo wrote:
> During a checkpoint, the current active segment X may not be handled
> properly. This occurs when segment X has 0 valid blocks and a non-zero
> number of discard blocks, for the following reasons:
> 
> locate_dirty_segment() does not mark any active segment as a prefree
> segment. As a result, segment X is not included in dirty_segmap[PRE], and
> f2fs_clear_prefree_segments() skips it when handling prefree segments.
> 
> add_discard_addrs() skips any segment with 0 valid blocks, so segment X is
> also skipped.
> 
> Consequently, no `struct discard_cmd` is actually created for segment X.
> However, the ckpt_valid_map and cur_valid_map of segment X are synced by
> seg_info_to_raw_sit() during the current checkpoint process. As a result,
> it cannot find the missing discard bits even in subsequent checkpoints.
> Consequently, the value of sbi->discard_blks remains non-zero. Thus, when
> f2fs is umounted, CP_TRIMMED_FLAG will not be set due to the non-zero
> sbi->discard_blks.
> 
> Relevant code process:
> 
> f2fs_write_checkpoint()
>     f2fs_flush_sit_entries()
>          list_for_each_entry_safe(ses, tmp, head, set_list) {
>              for_each_set_bit_from(segno, bitmap, end) {
>                  ...
>                  add_discard_addrs(sbi, cpc, false); // skip segment X due to its 0 valid blocks
>                  ...
>                  seg_info_to_raw_sit(); // sync ckpt_valid_map with cur_valid_map for segment X
>                  ...
>              }
>          }
>     f2fs_clear_prefree_segments(); // segment X is not included in dirty_segmap[PRE] and is skipped
> 
> This issue is easy to reproduce with the following operations:
> 
> root # mkfs.f2fs -f /dev/f2fs_dev
> root # mount -t f2fs /dev/f2fs_dev /mnt_point
> root # dd if=/dev/blk_dev of=/mnt_point/1.bin bs=4k count=256
> root # sync
> root # rm /mnt_point/1.bin
> root # umount /mnt_point
> root # dump.f2fs /dev/f2fs_dev | grep "checkpoint state"
> Info: checkpoint state = 45 :  crc compacted_summary unmount ---- 'trimmed' flag is missing
> 
> Since add_discard_addrs() can handle active segments with non-zero valid
> blocks, it is reasonable to fix this issue by allowing it to also handle
> active segments with 0 valid blocks.
> 
> Fixes: b29555505d81 ("f2fs: add key functions for small discards")
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

