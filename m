Return-Path: <linux-kernel+bounces-377199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 141119ABB24
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 03:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42A711C2263E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 01:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DDD335D3;
	Wed, 23 Oct 2024 01:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KicYyBG9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8E112B73
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 01:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729648217; cv=none; b=C30AChIhPIPN7MK/HbfWt9Oy56CCBbsZTlg/jkez6cTKiUHQ97t7q9O22GG89kAMYl1E4JZT8Js4AsILXtzezu/jF9UD1Nt7quxcoPHb+1ns1AukBS0dKsel4URdch1WSLwZFcJihyGjzVymVmhHnava/NRHFHjAyv5Wv1b4GS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729648217; c=relaxed/simple;
	bh=fuIHtiUsA+MbgN9XYHvhFtdP/SML3ljCvOyUzUZ4WFg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KGXj/zLZWhKjEFnStPmSUcw1D4MzpjFMvt4uPzyFX+kDnpTKDu+e4BcvNAxHpICwo3/hKzDENtqp8uQfCIU9djMmlJEaQ+w0Z3NR+Pg6N8cBXmmLopbiY8J0A6CGqnCHgjxG9vdU4sYosWvuILzbN4+N0qy8fHDzPzgd6sNnSww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KicYyBG9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB6BC4CEC3;
	Wed, 23 Oct 2024 01:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729648217;
	bh=fuIHtiUsA+MbgN9XYHvhFtdP/SML3ljCvOyUzUZ4WFg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=KicYyBG9ekvv+qo87BnfJFJOQio1HD0iqzYU4dDgc2+In5PaQDsiHnB4hfXAH44h/
	 dUWDLrLiQFErw+ufvqQMDTweJ6Eb7sXGFN2kT3MPd/Bj0FJF/SaBlAVe7rMJjfS5+s
	 jC5DnQX4xLIVuAqi8IDUWRq6oV72Dzxu1LQ2uyIhjov3+Z0iczSBJEzn1DvLYv9yJn
	 uIN0kz5sU/UHw9yW8Dq1gU8WX3GDdkahUAYiRXNNHyvRsP93+sn9Hgnx4dXmAP382v
	 /c/WYuxSW99RFKxpGBX3KCbwU0qYNtTBTrp2MwK32qGw3uiiKw2p1bEK/sUkd50SUo
	 mHfQskTq4rSkw==
Message-ID: <88cc50d5-b793-4faa-b29e-b9cf291dadde@kernel.org>
Date: Wed, 23 Oct 2024 09:50:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: modify f2fs_is_checkpoint_ready logic to allow
 more data to be written with the CP disable
To: Qi Han <hanqi@vivo.com>, jaegeuk@kernel.org
References: <20241022091525.1808542-1-hanqi@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241022091525.1808542-1-hanqi@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/22 17:15, Qi Han wrote:
> When the free segment is used up during CP disable, many write or
> ioctl operations will get ENOSPC error codes, even if there are
> still many blocks available. We can reproduce it in the following
> steps:
> 
> dd if=/dev/zero of=f2fs.img bs=1M count=65
> mkfs.f2fs -f f2fs.img
> mount f2fs.img f2fs_dir -o checkpoint=disable:10%
> cd f2fs_dir
> i=1 ; while [[ $i -lt 50 ]] ; do (file_name=./2M_file$i ; dd \
> if=/dev/random of=$file_name bs=1M count=2); i=$((i+1)); done
> sync
> i=1 ; while [[ $i -lt 50 ]] ; do (file_name=./2M_file$i ; truncate \
> -s 1K $file_name); i=$((i+1)); done
> sync
> i=1; while [[ $i -lt 10000000 ]]; do (file_name=./file$i; dd \
> if=/dev/random of=$file_name bs=1M count=0); i=$((i+1)); done

'dd if=/dev/zero of=./file bs=1M count=20' will be more quick to
trigger SSR allocation.

> 
> In f2fs_need_SSR() function, it is allowed to use SSR to allocate
> blocks when CP is disabled, so in f2fs_is_checkpoint_ready function,
> can we judge the number of invalid blocks when free segment is not
> enough, and return ENOSPC only if the number of invalid blocks is
> also not enough?
> 
> Signed-off-by: Qi Han <hanqi@vivo.com>
> ---
>   fs/f2fs/segment.h | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 71adb4a43bec..b7af84a07435 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -637,12 +637,31 @@ static inline bool has_enough_free_secs(struct f2fs_sb_info *sbi,
>   	return !has_not_enough_free_secs(sbi, freed, needed);
>   }
>   
> +static inline bool has_enough_free_blks(struct f2fs_sb_info *sbi)
> +{
> +	long long total_free_blocks = 0;
> +	block_t avail_user_block_count;

long long avail_user_block_count;

> +	block_t valid_block_count;
> +
> +	spin_lock(&sbi->stat_lock);
> +
> +	avail_user_block_count = get_available_block_count(sbi, NULL, true);
> +	valid_block_count = valid_user_blocks(sbi);
> +	total_free_blocks = avail_user_block_count - valid_block_count;

total_free_blocks =
	avail_user_block_count - (long long)valid_user_blocks(sbi);

Then, we can avoid allocating & assigning valid_block_count variable.

> +
> +	spin_unlock(&sbi->stat_lock);
> +
> +	return (total_free_blocks > 0) ? true : false;

return total_free_blocks > 0;

Thanks,

> +}
> +
>   static inline bool f2fs_is_checkpoint_ready(struct f2fs_sb_info *sbi)
>   {
>   	if (likely(!is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
>   		return true;
>   	if (likely(has_enough_free_secs(sbi, 0, 0)))
>   		return true;
> +	if (likely(has_enough_free_blks(sbi)))
> +		return true;
>   	return false;
>   }
>   


