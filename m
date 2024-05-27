Return-Path: <linux-kernel+bounces-189995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 218DD8CF835
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 05:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4014B20DE4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 03:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42E379E1;
	Mon, 27 May 2024 03:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/ST8/4y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E743B10E5
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 03:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716781754; cv=none; b=oS5Da9RBVtuwdKF16SkSgOnJwuvcIvk+7p1JSB2S27aR08k+2Y9GKH4Rgt3zAuradICUCeG+sC0OK/OJwWFkn1Twh/Gofi5y3O6xxB/ZNa5laK9KXiMv384G2kA52YuJn0pUNcXp6ftV8yhAf4NR+EGBzzIN00L6a9Kj6LsihCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716781754; c=relaxed/simple;
	bh=1roAnXoBpmfOOOh02YvPm+SdLLwFEfO7YksTC91triA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5JNtdZ+ctirIo64yhyr+ctPd9q01jcmzDfY1GwWQqhjSotXSsOQrx7XkoLHyHNs/nKJE19SK+nE1JENuIXBSBP/PMnRKry694ceC08vouxI8nbADqGPzFLYRzcLtZBHYD/pUWEiNtgWIP02umjLrs4yXUpfOLbc+aDfojwFf2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/ST8/4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51419C2BBFC;
	Mon, 27 May 2024 03:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716781753;
	bh=1roAnXoBpmfOOOh02YvPm+SdLLwFEfO7YksTC91triA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U/ST8/4yylKhLjgKzkNG/1idVDlnSQjdKf3hMftU6u3hkmLp6IynYgeoWIPIHexsS
	 PqniFw1wqP2gm4lKPn8VkrwcLbjgqfHGhgbw0VBy9Xhdy288jKmaBJvsjHZbACae9t
	 ujQ8S5x643S0t4sqxNRRnkk/kE0Omb7aEtypSd8rqiZQEvT1GBWxbXK13v6LthwsvC
	 Wi3rH4igYS7eXlkXpYS6PC29I1AF5OgktwPmDtr8kZhp4mwT+qqUX7zZj9K7S3yZFW
	 LqDxUZf0YZ+Ol4AE8+EnKyLyxO+whGpx212VpUzFg4PcRBJMdocPHylV7TztZqBO/9
	 dUJv/2Y+t0OMw==
Message-ID: <1d67715b-5f88-4940-969d-e098fd80ae2a@kernel.org>
Date: Mon, 27 May 2024 11:49:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: enable atgc if atgc_age_threshold from user is less
 than elapsed_time
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com
References: <1716204978-29455-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1716204978-29455-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/20 19:36, Zhiguo Niu wrote:
> Now atgc can be enabled based on the following conditions:
> -ATGC mount option is set
> -elapsed_time is more than atgc_age_threshold already
> but these conditions are check when umounted->mounted device again.
> If the device has not be umounted->mounted for a long time, atgc can
> not work even the above conditions met.

Zhiguo, I didn't get it, can you please explain more about this issue?

Thanks,

> 
> It is better to enable atgc dynamiclly when user change atgc_age_threshold
> meanwhile this vale is less than elapsed_time and ATGC mount option is on.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>   fs/f2fs/f2fs.h    |  1 +
>   fs/f2fs/segment.c |  9 ++++-----
>   fs/f2fs/sysfs.c   | 16 ++++++++++++++++
>   3 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 1974b6a..e441d2d 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3694,6 +3694,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>   int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
>   void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
>   void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
> +int f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi);
>   int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
>   					unsigned int start, unsigned int end);
>   int f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, bool force);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 71dc8042..44923d4 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2931,14 +2931,11 @@ static int get_atssr_segment(struct f2fs_sb_info *sbi, int type,
>   	return ret;
>   }
>   
> -static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
> +int f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
>   {
>   	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_ALL_DATA_ATGC);
>   	int ret = 0;
>   
> -	if (!sbi->am.atgc_enabled)
> -		return 0;
> -
>   	f2fs_down_read(&SM_I(sbi)->curseg_lock);
>   
>   	mutex_lock(&curseg->curseg_mutex);
> @@ -2955,7 +2952,9 @@ static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
>   }
>   int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi)
>   {
> -	return __f2fs_init_atgc_curseg(sbi);
> +	if (!sbi->am.atgc_enabled)
> +		return 0;
> +	return f2fs_init_atgc_curseg(sbi);
>   }
>   
>   static void __f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi, int type)
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 09d3ecf..72676c5 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -673,6 +673,22 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   		return count;
>   	}
>   
> +	if (!strcmp(a->attr.name, "atgc_age_threshold")) {
> +		if (t < 0)
> +			return -EINVAL;
> +		sbi->am.age_threshold = t;
> +		if (sbi->am.atgc_enabled)
> +			return count;
> +
> +		if (test_opt(sbi, ATGC) &&
> +			le64_to_cpu(sbi->ckpt->elapsed_time) >= t) {
> +			if (f2fs_init_atgc_curseg(sbi))
> +				return -EINVAL;
> +			sbi->am.atgc_enabled = true;
> +		}
> +		return count;
> +	}
> +
>   	if (!strcmp(a->attr.name, "gc_segment_mode")) {
>   		if (t < MAX_GC_MODE)
>   			sbi->gc_segment_mode = t;

