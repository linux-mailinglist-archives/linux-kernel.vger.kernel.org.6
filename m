Return-Path: <linux-kernel+bounces-314420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CB996B2F2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 949CDB2232C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFF71465AE;
	Wed,  4 Sep 2024 07:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BlJSSvGo"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BF53C17
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 07:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725435207; cv=none; b=nRzosEqpNB+DNE45BrJW45OnzlSvz8kXhF2J0l3g3F3lHDWCkVeuYuW+BY/cCAVDhroS3i2ngahyuNkNXH2un4g1CgerWkf0xiGZbCjcLqhJYr/L3iZPCBY5KXTkqfh5PwbHke3Gl8y48PNXuOl/z+L7KdcYmaJVVvX6uy3uyBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725435207; c=relaxed/simple;
	bh=kjIAHlj0EDBWM636Dd4zr8xoJZaVLjDUxE61JT+ORBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AsLWp1DqwSZY4Ad4b7QFqkjXYod9sw5olEw4lCHaNUaO8SFWohQT9PU+E79MneOwAe2c9c/0XXzafELvR6EyXPG/XByqcru6ihMLubKMoo3F7kRj2H8KLNf0C31fL5hN6PsGIKatr5AOdeWyHbwn6M0FHuw7T7i8HcmS7JxI9Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BlJSSvGo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42bafd879aeso8576405e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 00:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725435204; x=1726040004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hfkKF7no0L6k1YDWkMmS7m+5OSP6YGibpWHQWa7OBGM=;
        b=BlJSSvGoV+n+q1OCqW+Ct0moehIl9lPoX1t5kZbHIIdqx8xv+A0cqj5ViNE1pcKN1v
         lSF1iYVscDMxodzQfcgXF+J/ADXyk56SeodW1MR/bmCGTXwj45jsMWYwqiTce3MyIsnZ
         yrOJ9RKG8tIH/jBcIt569VrvTWYxytxkVjVcLoBaONunlCKS2SBaJ/h8rlm5I21m0D86
         WpLDI5DFthpWNOJjXa9PwyFCs6ygTa3WN6EUGDbNZS0ofOQHM8Jg1hrfBNVGIZZbjRJL
         PQP1UQ4uVwOuFFirEimlGkl5TWILhDh87Icg3pkWJluo/l8ukJvRzpHvKd31PysdXJZT
         p0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725435204; x=1726040004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hfkKF7no0L6k1YDWkMmS7m+5OSP6YGibpWHQWa7OBGM=;
        b=bVoaGG4GXhg1Qd4PpnpCBuCXdqiOF+N3LgyyeC4jkSoXltep52Jg04Aee3WWXoR7Gd
         XyWA6JZty7iIL7DcoJmI3jaXPG+sVEGwNyiSr9eIrPudlU5AwmwMFAzWo4N7wJCF43IC
         SkrtoqPTjW7HZz6eGUyc7D6xt2rfw+EXuoipgVCpYPeLUo7u1PqRWUccfebNykDhF6TR
         4yenr0LPpQL16O25gvIpj2l2fi51K9TlOCMu1IqomI+QMRls401wjlr4pIj0xNeGi5kt
         qAvsTiDfelPkBvj2NUsemeL5OrqYnkBoSP79lh0Bmsd2Io+bbq9qGb9GM+JF8H3ztQVj
         uXNg==
X-Forwarded-Encrypted: i=1; AJvYcCXXkuUSiRHQvWWXadYdOzS6qwv1GExToT6zfJjSJp5esoFuq9hCGlWPFxCZEWNiyKGaGW/HRdEqKQw1Pf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsB4F3Y9qox+I+HMZvWDzd3KGXXiW1V9FbXXmdRIF8rBjz9q/J
	XP0QIY19OvcBXcTJhsljcxlcSFWgz/nGi61scxzWkgq5gkyjmyKecVsy3qG/JBc=
X-Google-Smtp-Source: AGHT+IGTDHNmRY27FGRkvlr1FFv3Cwz3KxeqpbLT6HtZpUFNvLImVB4OWYlUp7zXggyCxWHrji7snQ==
X-Received: by 2002:a5d:5987:0:b0:374:c4c9:d502 with SMTP id ffacd0b85a97d-374c4c9d93fmr4813460f8f.9.1725435203237;
        Wed, 04 Sep 2024 00:33:23 -0700 (PDT)
Received: from [10.202.112.30] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2da53740084sm3649505a91.32.2024.09.04.00.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 00:33:22 -0700 (PDT)
Message-ID: <7c468963-56a8-4d78-b691-ddf0793f40bf@suse.com>
Date: Wed, 4 Sep 2024 15:33:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ocfs2: cancel dqi_sync_work before freeing oinfo
To: Joseph Qi <joseph.qi@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzbot+f7af59df5d6b25f0febd@syzkaller.appspotmail.com
References: <20240904071004.2067695-1-joseph.qi@linux.alibaba.com>
Content-Language: en-US
From: "heming.zhao@suse.com" <heming.zhao@suse.com>
In-Reply-To: <20240904071004.2067695-1-joseph.qi@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/4/24 15:10, Joseph Qi wrote:
> ocfs2_global_read_info() will initialize and schedule dqi_sync_work at
> the end, if error occurs after successfully reading global quota, it
> will trigger the following warning with CONFIG_DEBUG_OBJECTS_* enabled:
> 
> ODEBUG: free active (active state 0) object: 00000000d8b0ce28 object type: timer_list hint: qsync_work_fn+0x0/0x16c
> 
> This blames there is an active delayed work when freeing oinfo in error
> handling, so cancel dqi_sync_work first. BTW, return status instead of
> -1 when .read_file_info fails.
> 
> Link: https://syzkaller.appspot.com/bug?extid=f7af59df5d6b25f0febd
> Reported-by: syzbot+f7af59df5d6b25f0febd@syzkaller.appspotmail.com
> Tested-by: syzbot+f7af59df5d6b25f0febd@syzkaller.appspotmail.com
> Fixes: 171bf93ce11f ("ocfs2: Periodic quota syncing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>

looks good to me.
Reviewed-by: Heming Zhao <heming.zhao@suse.com>

> ---
>   fs/ocfs2/quota_local.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
> index 8ce462c64c51..73d3367c533b 100644
> --- a/fs/ocfs2/quota_local.c
> +++ b/fs/ocfs2/quota_local.c
> @@ -692,7 +692,7 @@ static int ocfs2_local_read_info(struct super_block *sb, int type)
>   	int status;
>   	struct buffer_head *bh = NULL;
>   	struct ocfs2_quota_recovery *rec;
> -	int locked = 0;
> +	int locked = 0, global_read = 0;
>   
>   	info->dqi_max_spc_limit = 0x7fffffffffffffffLL;
>   	info->dqi_max_ino_limit = 0x7fffffffffffffffLL;
> @@ -700,6 +700,7 @@ static int ocfs2_local_read_info(struct super_block *sb, int type)
>   	if (!oinfo) {
>   		mlog(ML_ERROR, "failed to allocate memory for ocfs2 quota"
>   			       " info.");
> +		status = -ENOMEM;
>   		goto out_err;
>   	}
>   	info->dqi_priv = oinfo;
> @@ -712,6 +713,7 @@ static int ocfs2_local_read_info(struct super_block *sb, int type)
>   	status = ocfs2_global_read_info(sb, type);
>   	if (status < 0)
>   		goto out_err;
> +	global_read = 1;
>   
>   	status = ocfs2_inode_lock(lqinode, &oinfo->dqi_lqi_bh, 1);
>   	if (status < 0) {
> @@ -782,10 +784,12 @@ static int ocfs2_local_read_info(struct super_block *sb, int type)
>   		if (locked)
>   			ocfs2_inode_unlock(lqinode, 1);
>   		ocfs2_release_local_quota_bitmaps(&oinfo->dqi_chunk);
> +		if (global_read)
> +			cancel_delayed_work_sync(&oinfo->dqi_sync_work);
>   		kfree(oinfo);
>   	}
>   	brelse(bh);
> -	return -1;
> +	return status;
>   }
>   
>   /* Write local info to quota file */

