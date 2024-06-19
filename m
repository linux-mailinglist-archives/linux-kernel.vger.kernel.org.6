Return-Path: <linux-kernel+bounces-221182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EECD90EFDF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366B01F236C8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBAF1509AF;
	Wed, 19 Jun 2024 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeNNPO0n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA59814F9F1
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806460; cv=none; b=iHA5bGkh3Utp7uNGlOf87bIF7WINOZ+L25kYvMcwIIpu8b4/lpv5cF5ctuLN3yIigfE9kASlRVEOlU9q3lYPiqNzaqKb3la2bCpZ8Ye2RngQhVPCS90BRXQCfgU97QhMwvP1v14AQ+sqgP9zogDmWhEakBmp5sCGokySfkq5ukg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806460; c=relaxed/simple;
	bh=5mGGDm0HnkYWrCDF9AkhkQYTTIQdgfo19VKts2ac/jM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Sui77jcLIQ3jTAU6kekOLAWb7ppph6AVgxu2Db3Vd4NR2mhGOwnlWzzTIEN0Lg2piRyvwf6zK0L2CkLWfouX5vvClwvuIDV9RkT7Q6gApbRqoy4Gzi0eeXXLMbJORHKaiqKxi3+DKOlR157MabXC+IaIuig1nMrZeaBOI8mmaS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeNNPO0n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC672C32786;
	Wed, 19 Jun 2024 14:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718806460;
	bh=5mGGDm0HnkYWrCDF9AkhkQYTTIQdgfo19VKts2ac/jM=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=NeNNPO0nUjIEgjC6MYiKT+1DS9ui2kMTYwEWveMbiLA0KtNLJVVd9QOk5aT1jxVgK
	 SzcEIzgkn7qaFR0SCMeoIh/GOjO2XPOVEbQmIcF0jWBRk9Az9b6iCui22aTX6IL0fx
	 HuF4nCkp7EBlu2GcQDL+3efngTFLXeivIpdkSVTQZfpL2OwfS71w0xazNGbRsgzzHK
	 Jq4aH27X19A2ivEKahR+nJkPf9+EJ+Z39S7roKfwZPVwwmn9gOGE3v072/eqPMTFpw
	 g2C26h41cQJvOkJ6lpYFPFDnZKncS7r9lRfw+658L1LpQmGBxMUD+yBA3SbC3Qsw8e
	 RY5jzpZ2yiLvA==
Message-ID: <3c262735-accf-41a8-aa74-a96a7ae05945@kernel.org>
Date: Wed, 19 Jun 2024 22:14:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: fix to use sb_{start,
 end}_intwrite{_trylock, }() in gc_thread_func()
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20240606095213.4087668-1-chao@kernel.org>
 <20240606095213.4087668-2-chao@kernel.org>
Content-Language: en-US
Autocrypt: addr=chao@kernel.org; keydata=
 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
In-Reply-To: <20240606095213.4087668-2-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/6 17:52, Chao Yu wrote:
> Since background GC is f2fs inner operation, so, let's use
> sb_{start,end}_intwrite{_trylock,}() instead of
> sb_{start,end}_write{_trylock,}() in gc_thread_func().

It may cause racing in between gc_thread and freeze_super(), result in
writeback of dirty page after ->freeze, so please ignore this patch.

- sb_wait_write(sb, SB_FREEZE_WRITE)
- sync_filesystem(sb)
				- sb_start_intwrite_trylock
				 - f2fs_gc
				  : dirty pages
- sb_wait_write(sb, SB_FREEZE_FS)

Thanks,

> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>   fs/f2fs/gc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index ef667fec9a12..004587ac5530 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -76,7 +76,7 @@ static int gc_thread_func(void *data)
>   			f2fs_stop_checkpoint(sbi, false,
>   					STOP_CP_REASON_FAULT_INJECT);
>   
> -		if (!sb_start_write_trylock(sbi->sb)) {
> +		if (!sb_start_intwrite_trylock(sbi->sb)) {
>   			stat_other_skip_bggc_count(sbi);
>   			continue;
>   		}
> @@ -163,7 +163,7 @@ static int gc_thread_func(void *data)
>   			}
>   			spin_unlock(&sbi->gc_remaining_trials_lock);
>   		}
> -		sb_end_write(sbi->sb);
> +		sb_end_intwrite(sbi->sb);
>   
>   	} while (!kthread_should_stop());
>   	return 0;

