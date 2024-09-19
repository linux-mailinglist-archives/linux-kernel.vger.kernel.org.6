Return-Path: <linux-kernel+bounces-333227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C6397C5A5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11B601C21C68
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD08D198A34;
	Thu, 19 Sep 2024 08:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AbhsuSy6"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AAC198A32
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 08:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726733620; cv=none; b=ZaVpwC9BVMpHUgOqfTMD0hq1V3eINDkVcT9sZDhX58XjzXuqH7z6Wim86OLRI6MhNS/sOAJxpx80x2IRxXKswfWyHoczepWRJLRqj2OV1/4JoqQLdwkboT4PKLRvNxb5pXbWlxBrzQ1s3w1lKJqmvLDPtFMGw9t8Zh96RxZE9rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726733620; c=relaxed/simple;
	bh=/K69nVLEcIWxNDNpRWx7rCcqnjzJo3uCpRufVr1clJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DDEtTBqz0Y3WSHXNYIn+d0ssKJZduahss/l9ta2ZQF/f2mNnZm4c7HssB5VeEEAzUndxV3ippj9lwDEl2yeieIIWk7s2MS5HHfjsm+iTmeGwZ02BnYNLKhXbdHqIlCcculBWlB9oL4pGfnZQG0WQqXStIxn4Uglpx20dO5tq050=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AbhsuSy6; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-378c2f1d0f2so12911f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726733616; x=1727338416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DiM72tMP3gxKJwMlvFMrAxAdtPBT77eodGymGn5dVag=;
        b=AbhsuSy6sTLzLWiVZHN5aPpCJvcZeJIaAT8Bm9cD/u8scKdymhwU+dWuhF/vft+4Cq
         JdcJ59XrP2EGWemHYZpIuwK96NTo07ehLRIaFcUc62kAXmga9WMmIyMmwSSod9zc1AXl
         iG1SLr9pKRENjegqG5DSRm1SdtG0C/J06/JP0YyZ5C8BiOOx3fUmgg9uRWlfhdqfZvap
         k79YF3X9Rlz5Uz2X5XsxRvs7NZkEU1HsTCkwnPgnSqFHKDhbpx0yzz6YTjW+T3LcCRtC
         p8to5pY03XEGrZsIaLbL8j2MHPSccsL4VnAKB5rG7A/hF5Hbn6d4dSrWGZI/uiYHXnrD
         psGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726733616; x=1727338416;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DiM72tMP3gxKJwMlvFMrAxAdtPBT77eodGymGn5dVag=;
        b=S9d+N/QrSdGeeE6a0KTYIi+Dsj6hgB+rITqXjPNjTuxbd8gvD3OSuqjpn/h3sbCekY
         Mt5rWL8+NiXH1XEbPFVeJ4uyyGF2G3XXuhHU4GL+HNV7kOSgvGxXfbljvkzIAegnBy2B
         aqaMsQ3VnWwsdF2dq+hTzuRS2KUnEbLIjPJ+po0AxWQJ9zUu53Hq6PUo6SmMyv5g8XXT
         6eGVxpk5z/eslCilYapXN7y7vjNCPCFx9HVsIXoyJYqQCmiOVOJD470aCfnudXPxm6Tx
         AyeiR7q4wcD42udqSYXUWqklCtenQANeSUAFv8H5dXgHCbBwQMdDXiLuhtlCW4qlr5l0
         Uc5A==
X-Forwarded-Encrypted: i=1; AJvYcCWToklpVpW50k907RnSG8tBjRoZTqcFoZlAy/hh7iQ8l19mO6w2h2Rpa+ljshVk4stfQB0nvO13gH8N8pA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIBBrbmkbat5imIt77C28Q62nOR72vtzAuh11CqDb9EmzEIejc
	Csg1fRALdGxYYpqnf+vG8vJMQH5/LSbN8oLksG6MfdrSf8FYP/boAD/1Q4cn6E4=
X-Google-Smtp-Source: AGHT+IEcmmdy/00oElpFksWs4lsAsMJXe4ZQ0aVnGocJkWEcop5ZUHKg12MuKLRImgdJxyEubGoH+A==
X-Received: by 2002:a05:6000:1f89:b0:374:d2b4:d9d0 with SMTP id ffacd0b85a97d-378c295451cmr7365205f8f.0.1726733616350;
        Thu, 19 Sep 2024 01:13:36 -0700 (PDT)
Received: from ?IPV6:2408:8409:2432:371d:7607:a570:bf1c:aad6? ([2408:8409:2432:371d:7607:a570:bf1c:aad6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7b59csm7772163b3a.103.2024.09.19.01.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 01:13:35 -0700 (PDT)
Message-ID: <2690bc1f-049f-4a27-823e-5da0ae1bdcda@suse.com>
Date: Thu, 19 Sep 2024 16:13:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ocfs2: Fix deadlock in ocfs2_read_virt_blocks
Content-Language: en-US
To: Mohammed Anees <pvmohammedanees2003@gmail.com>,
 ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>,
 syzbot+18a87160c7d64ba2e2f6@syzkaller.appspotmail.com
References: <20240918172026.2532-1-pvmohammedanees2003@gmail.com>
 <20240918172026.2532-2-pvmohammedanees2003@gmail.com>
From: "heming.zhao@suse.com" <heming.zhao@suse.com>
In-Reply-To: <20240918172026.2532-2-pvmohammedanees2003@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/19/24 01:20, Mohammed Anees wrote:
> syzbot has found a kernel BUG in ocfs2_write_cluster_by_desc,
> while the next patch in the series resolves this, another
> bug has been detected due to a potential deadlock [1].
> 
> The scenario is depicted here,
> 
> 	CPU0					CPU1
> lock(&ocfs2_file_ip_alloc_sem_key);
>                                 lock(&osb->system_file_mutex);
>                                 lock(&ocfs2_file_ip_alloc_sem_key);
> lock(&osb->system_file_mutex);
> 
> The function calls which could lead to this are:
> 
> CPU0
> ocfs2_write_begin - lock(&ocfs2_file_ip_alloc_sem_key);
> .
> .
> .
> ocfs2_get_system_file_inode - lock(&osb->system_file_mutex);
> 
> CPU1 -
> ocfs2_get_system_file_inode - lock(&osb->system_file_mutex);
> .
> .
> .
> ocfs2_read_virt_blocks - lock(&ocfs2_file_ip_alloc_sem_key);
> 
> This issue can be resolved by making the down_read -> down_read_try
> in the ocfs2_read_virt_blocks.
> 
> [1] https://syzkaller.appspot.com/bug?extid=18a87160c7d64ba2e2f6

I haven't checked this patch, but in my view, following URL is correct.
https://syzkaller.appspot.com/bug?extid=e0055ea09f1f5e6fabdd

Heming
> 
> Reported-and-tested-by: syzbot+18a87160c7d64ba2e2f6@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=18a87160c7d64ba2e2f6
> Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
> ---
>   fs/ocfs2/extent_map.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
> index 70a768b62..f83d0a3b6 100644
> --- a/fs/ocfs2/extent_map.c
> +++ b/fs/ocfs2/extent_map.c
> @@ -12,6 +12,7 @@
>   #include <linux/slab.h>
>   #include <linux/types.h>
>   #include <linux/fiemap.h>
> +#include <linux/delay.h>
>   
>   #include <cluster/masklog.h>
>   
> @@ -961,6 +962,8 @@ int ocfs2_read_virt_blocks(struct inode *inode, u64 v_block, int nr,
>   	int rc = 0;
>   	u64 p_block, p_count;
>   	int i, count, done = 0;
> +	int retries, max_retries = 5;
> +	int retry_delay_ms = 30;
>   
>   	trace_ocfs2_read_virt_blocks(
>   	     inode, (unsigned long long)v_block, nr, bhs, flags,
> @@ -973,7 +976,18 @@ int ocfs2_read_virt_blocks(struct inode *inode, u64 v_block, int nr,
>   	}
>   
>   	while (done < nr) {
> -		down_read(&OCFS2_I(inode)->ip_alloc_sem);
> +		retries = 0;
> +		while (retries < max_retries) {
> +			if (down_read_trylock(&OCFS2_I(inode)->ip_alloc_sem))
> +				break; // Lock acquired
> +			msleep(retry_delay_ms);
> +			retries++;
> +		}
> +		if (retries == max_retries) {
> +			rc = -EAGAIN;
> +			mlog(ML_ERROR, "Cannot acquire lock\n");
> +			break;
> +		}
>   		rc = ocfs2_extent_map_get_blocks(inode, v_block + done,
>   						 &p_block, &p_count, NULL);
>   		up_read(&OCFS2_I(inode)->ip_alloc_sem);

