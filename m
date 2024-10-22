Return-Path: <linux-kernel+bounces-375476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 838939A966E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 04:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1761F2324F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 02:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26E884D34;
	Tue, 22 Oct 2024 02:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2rfxzi4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D18F23A9
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 02:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729565597; cv=none; b=JxkIWdksGyWZ0YaVX4WKTdhia1uKTA8weE6C2DuX04GgxDHP8R1ON2Ivyaa9QcuYRgyyH+dgCZrbXYVOF/KNzxOYt9ZYJUuC0WlUp/Ba7gBrBncfZP//8rsmFb63hGvZutnm8uw6SD/RVaAmgB7ZaZTyrHwHlaf13jfgJYMHWaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729565597; c=relaxed/simple;
	bh=sNTXpWjfoKvwLxtmQeFQxt8wmx98bEnvCNRQlkYhr7M=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X4HWyVg5GV6dJfCg41orcQd2sVweuFzevsWDsdtbtj6VPiqU2hqV/eKRipZkp+mJ0nQdp0sM3NNW/0u7UW5BbD69rCCxLPtM8uiFEpkycT098cYzChgvLWJbr95feVH7YkIyCwdUjXg5NKugr2yVa3N8YvJJKehgo25hZ1NRPjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2rfxzi4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B26C4CEC3;
	Tue, 22 Oct 2024 02:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729565596;
	bh=sNTXpWjfoKvwLxtmQeFQxt8wmx98bEnvCNRQlkYhr7M=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=p2rfxzi4qTw+Pxla/E70st1xsXxeytMvQwgbOf9JyPSP/rlz3z/RJxiJ9WUEWZlsc
	 gAbYc/tICz8A+3CEmhivclaIzR43Y73xFTWtrlwWE2UPPkGej1AIw8rZIcyjAmZGPp
	 VEl+MMeHArPR5cFyfJ43z3G4rmpBUSa2n7hscGBHSFL7tqbanhQvrTYN8rgimP1xsV
	 Hrrc4zYSfZc/qkkP8gdKUwg25KFJibAyJlk07YMzRXa4f8E2nEph7R4Fq2Ak5qPvAr
	 GsniNGY0k4xXbDvqmeRQiwmnOnD8/00zX9dy/9n+GbbyzvELnqeT2qivxlJ2NiwI4k
	 RWmz0FwMS0p0Q==
Message-ID: <3fdd8fdd-8b80-4989-8cfd-78051bd85936@kernel.org>
Date: Tue, 22 Oct 2024 10:53:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: modify f2fs_is_checkpoint_ready logic to allow more
 data to be written with the CP disable
To: Qi Han <hanqi@vivo.com>, jaegeuk@kernel.org
References: <20241009102745.1390935-1-hanqi@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241009102745.1390935-1-hanqi@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/9 18:27, Qi Han wrote:
> When the free segment is used up during CP disable, many write or
> ioctl operations will get ENOSPC error codes, even if there are
> still many blocks available. We can reproduce it in the following
> steps:
> 
> dd if=/dev/zero of=f2fs.img bs=1M count=55
> mkfs.f2fs -f f2fs.img
> mount f2fs.img f2fs_dir -o checkpoint=disable:10%
> cd f2fs_dir
> dd if=/dev/zero of=bigfile bs=1M count=50
> sync
> rm bigfile
> i=1; while [[ $i -lt 10000000 ]]; do (file_name=./file$i; dd \
> if=/dev/random of=$file_name bs=1M count=0); i=$((i+1)); done
> stat -f ./
> 
> In f2fs_need_SSR() function, it is allowed to use SSR to allocate
> blocks when CP is disabled, so in f2fs_is_checkpoint_ready function,
> can we judge the number of invalid blocks when free segment is not
> enough, and return ENOSPC only if the number of invalid blocks is
> also not enough?
> 
> Signed-off-by: Qi Han <hanqi@vivo.com>
> ---
>   fs/f2fs/segment.h | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 71adb4a43bec..9bf0cf3a6a31 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -637,12 +637,33 @@ static inline bool has_enough_free_secs(struct f2fs_sb_info *sbi,
>   	return !has_not_enough_free_secs(sbi, freed, needed);
>   }
>   
> +static inline bool has_enough_available_blocks(struct f2fs_sb_info *sbi)
> +{
> +	unsigned int total_free_blocks = sbi->user_block_count -
> +					valid_user_blocks(sbi) -
> +					sbi->current_reserved_blocks;
> +
> +	if (total_free_blocks <= sbi->unusable_block_count)
> +		total_free_blocks = 0;
> +	else
> +		total_free_blocks -= sbi->unusable_block_count;
> +
> +	if (total_free_blocks > F2FS_OPTION(sbi).root_reserved_blocks)
> +		total_free_blocks -= F2FS_OPTION(sbi).root_reserved_blocks;
> +	else
> +		total_free_blocks = 0;
> +
> +	return (total_free_blocks > 0) ? true : false;

Can you please reuse get_available_block_count() as much as possible?
and cover it w/ stat_lock?

Thanks,

> +}
> +
>   static inline bool f2fs_is_checkpoint_ready(struct f2fs_sb_info *sbi)
>   {
>   	if (likely(!is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
>   		return true;
>   	if (likely(has_enough_free_secs(sbi, 0, 0)))
>   		return true;
> +	if (likely(has_enough_available_blocks(sbi)))
> +		return true;
>   	return false;
>   }
>   


