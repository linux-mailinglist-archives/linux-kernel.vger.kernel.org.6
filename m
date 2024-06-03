Return-Path: <linux-kernel+bounces-198729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432038D7CA0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74CA51C215C7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 07:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A661482E2;
	Mon,  3 Jun 2024 07:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3TDhQx+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3CE3BBD5
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 07:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717400470; cv=none; b=Ej/Jnjl65YMaBA3rcqTZizv0PcfJF3i/9tu0JaBIBkH9dqSvzdnliEWS7fvKQe4TcPoba9VABQ6hOOmFQ/5YaSbnZ+2Pmc659OX06pDv7/+Ocp6wRLCT6nXumrboyESqF/IOfNAp5UnIOziJmJwFmPcUz5OoVbXTbR+vMM8tY4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717400470; c=relaxed/simple;
	bh=m5aSQfeZKfHg4vKuPqJxxkdm7ckdPdrNRTojWDxZfOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FptPyv4CTFSIAiIshiSpYa/JNNUU51moe5/IHJ6fj/krVHOo/xQjzQ50ZdflIKhasTEdvTYmKFzz8pwhA60TfXvu6/8rbuBcQ/GOSqhS9CYVz+R6/sJhBjw3KhLG3n5swNAaPNvBjNdYLqhXzaVAGqRu7Pdmw+w+h+b2a6uYZqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3TDhQx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A737DC2BD10;
	Mon,  3 Jun 2024 07:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717400470;
	bh=m5aSQfeZKfHg4vKuPqJxxkdm7ckdPdrNRTojWDxZfOU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D3TDhQx+ikubtIpRN6HbWJrEsSKFgxpx74aSdSV4vzZebcfSLn7jRnGagBGQFym+W
	 5F6XCQwNaAlj8WUEdXF79haI/TTxYA7bO7Z1izqOspW+pbxmwYW9vAp8BdYD5S95ks
	 Lv4r8i5k7JaIoXJZdqvHRuu2UdtBIGh41fDpyvrH5aA8SBJoJZzHVCdUlq4+eSuBuj
	 BdtJg/x/Lcj7WmUyFJwUmJBx4Tp/F6T3rOsZx1UklazxSj7u6UqMHZ8xr4Hvr9+dtS
	 UKIGTbrWPuL56sm2f7nKr/sBuw0nwwAYgKLfza6S5O0uyrK7akHwFxY596r5gFVGGy
	 8GAOXTC/9nbYA==
Message-ID: <446c7e4a-2a1e-402d-8238-2eee7cdfd5c2@kernel.org>
Date: Mon, 3 Jun 2024 15:41:06 +0800
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

Oh, I guess you want to fix this:

static void init_atgc_management(struct f2fs_sb_info *sbi)
{
...
	if (test_opt(sbi, ATGC) &&
		SIT_I(sbi)->elapsed_time >= DEF_GC_THREAD_AGE_THRESHOLD)
		am->atgc_enabled = true;

What about enabling atgc_enabled during checkpoint once elapsed time is
satisfed w/ the condition? I guess this can give another chance whenever
CP is been triggered, and it can avoid the racing condition as well.

Thanks,

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

