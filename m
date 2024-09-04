Return-Path: <linux-kernel+bounces-314421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF13696B2F3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E63C1C22EC6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9F4146A79;
	Wed,  4 Sep 2024 07:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PrVJ7c2k"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B73146581
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 07:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725435229; cv=none; b=I2w25vBEaVoGUM1SKcphKbrRngAKEe4XnKy3Nhl4+R8ZkTpnDyjCGZk5jlZeEH+dg1U5sEmb7eObO5Kfzai0kD5MEVnXAZOwpZKvmOtvFE8iqzpN2EXdIx29C+vkFWbvUVYTPYKxhN+GOdT4UADkYVkkJOEOgk8ipKQAblanA3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725435229; c=relaxed/simple;
	bh=XfuFXzHuvHgfON9TmVxUj/PkKi7outOSrO18o9M42n0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FPLdJCFk77NOoOaaGOLWPwKqgWxhG4fbvClGCqh/gHB3V0NsmapEPf5HKA7Q1gAsmGHXkS0W5WZ0uLjEBeNM2rpMol0GrnhkpwuPVqpqImcQsYzXEvILVVUu3vlRumbBp8OZHMDaqCSmue9vVRNRJKZbQ0i1u0cVmcfdpbPFxlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PrVJ7c2k; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42bbbe94b88so7135505e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 00:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725435226; x=1726040026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lacV3LebicVP+vvxt81DAyEUrVBZ6FLlzY3Nkr6d5vk=;
        b=PrVJ7c2kwc8YspmEjei+Nw9iObeO3U6C/ZFK7r3HHm0Cekv12GJvtTCF8w/yvS19eE
         QKzT8cwMmvKb/YQBx/zScJnDQxgQIBC5cogUINfZs2mvLHLcPJv1VZgq0mZtcQCyKDPe
         exvHZU+kBSq/DKXKXGmcSjLSnEBcLh2kqM7ZBFYeYSxz2Ewgy2UI7zuAuBIC7+tOkO2j
         uqF/56NMYHVC5ZzILGBaLwdkQSOq/Rm+fVWrjOLcLoMbYU4oqZJsUZ+EhEzdCNkVdlQ+
         rHkCYzFHPuPIHFLzbiUFPCicutEC/A3R2vFGQ/yhBboF2eiP87YbqoRFXE/RFqGGGS1Z
         Zudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725435226; x=1726040026;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lacV3LebicVP+vvxt81DAyEUrVBZ6FLlzY3Nkr6d5vk=;
        b=kHJGXRTesTPyovGj3vvRSb1T7yI7vdPqdtkkM072bvM9xp3r+DXVmCuKeQMNr/MWfm
         TDSeL+otbyyRPuWQC/bvJY7tTGXx8vz1imt8vj7ijKfzA7SZlxEFVHgrVnI/zh3m5U9J
         2YzDJhlNzj8Uj5UX1DTe8X8qcauRnZEfCBcAQPMNGpTI6ohBF0QvyQraee6PGJB1E5JF
         i80lSbRSK18AwJJ1YOJXIlG1N/G3Xj4ordTERzCfYgLjK1w3WmP8lcPN+OXHFNHLMtJN
         7Zc3s+wTf6wt87mKBhThD0NOUWvA8/Yq5y+hJe24SMidk1E0zbNslQh0iHZZamEwCDs5
         zEgA==
X-Forwarded-Encrypted: i=1; AJvYcCWYFgk+ANjtqc5XB1ZQ4O/hc3+pAw27WJwtZrlhBa7M1twtR8xI3kq8GARDiebn+rNIT0T4ZeokiOuVbTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHqhGkT0XC7hRMEmfAqJqQ95OjT/ka6n7btLCRZOdqsuzzUHT/
	vfrqa3IdlwnsGG4WFcq2GfFhKI+Y+ss2fIxYX6MuWflXeondwKLOuvbD3FxWh4fE5N37LYhSLMU
	2KfA=
X-Google-Smtp-Source: AGHT+IG4OUx3NwMXDIrjN3lxQ/fGEdvOmLhh9jx1pGGzR4cOdaxUgu4cr6jYXPW85asreHt/IjkRcQ==
X-Received: by 2002:a5d:64ae:0:b0:374:cd01:8b73 with SMTP id ffacd0b85a97d-374cd018ecamr2982249f8f.10.1725435224588;
        Wed, 04 Sep 2024 00:33:44 -0700 (PDT)
Received: from [10.202.112.30] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2da53740084sm3649505a91.32.2024.09.04.00.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 00:33:44 -0700 (PDT)
Message-ID: <9f551194-6e86-41ae-86f7-e9387fbc4871@suse.com>
Date: Wed, 4 Sep 2024 15:33:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ocfs2: cleanup return value and mlog in
 ocfs2_global_read_info()
Content-Language: en-US
To: Joseph Qi <joseph.qi@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzbot+f7af59df5d6b25f0febd@syzkaller.appspotmail.com
References: <20240904071004.2067695-1-joseph.qi@linux.alibaba.com>
 <20240904071004.2067695-2-joseph.qi@linux.alibaba.com>
From: "heming.zhao@suse.com" <heming.zhao@suse.com>
In-Reply-To: <20240904071004.2067695-2-joseph.qi@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/4/24 15:10, Joseph Qi wrote:
> Return 0 instead of sizeof(ocfs2_global_disk_dqinfo) that .quota_read
> returns in normal case.
> Also cleanup mlog to make code more readable.
> 
> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>

Looks good to me.
Reviewed-by: Heming Zhao <heming.zhao@suse.com>

> ---
>   fs/ocfs2/quota_global.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ocfs2/quota_global.c b/fs/ocfs2/quota_global.c
> index 0575c2d060eb..2b0daced98eb 100644
> --- a/fs/ocfs2/quota_global.c
> +++ b/fs/ocfs2/quota_global.c
> @@ -371,12 +371,16 @@ int ocfs2_global_read_info(struct super_block *sb, int type)
>   
>   	status = ocfs2_extent_map_get_blocks(oinfo->dqi_gqinode, 0, &oinfo->dqi_giblk,
>   					     &pcount, NULL);
> -	if (status < 0)
> +	if (status < 0) {
> +		mlog_errno(status);
>   		goto out_unlock;
> +	}
>   
>   	status = ocfs2_qinfo_lock(oinfo, 0);
> -	if (status < 0)
> +	if (status < 0) {
> +		mlog_errno(status);
>   		goto out_unlock;
> +	}
>   	status = sb->s_op->quota_read(sb, type, (char *)&dinfo,
>   				      sizeof(struct ocfs2_global_disk_dqinfo),
>   				      OCFS2_GLOBAL_INFO_OFF);
> @@ -404,12 +408,11 @@ int ocfs2_global_read_info(struct super_block *sb, int type)
>   	schedule_delayed_work(&oinfo->dqi_sync_work,
>   			      msecs_to_jiffies(oinfo->dqi_syncms));
>   
> -out_err:
> -	return status;
> +	return 0;
>   out_unlock:
>   	ocfs2_unlock_global_qf(oinfo, 0);
> -	mlog_errno(status);
> -	goto out_err;
> +out_err:
> +	return status;
>   }
>   
>   /* Write information to global quota file. Expects exclusive lock on quota

