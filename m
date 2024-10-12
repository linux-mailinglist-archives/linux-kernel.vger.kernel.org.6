Return-Path: <linux-kernel+bounces-362024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A5899B00C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 04:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DDDF1C209E4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 02:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6145812E5D;
	Sat, 12 Oct 2024 02:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BO4k+qw0"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99FF17BB6
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 02:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728699402; cv=none; b=ocUmbj/bc45cehHgd6mP8y5HO+eEFxUkrMHlz0YGjkyvLJlvETcuQBoSE6GHA0eUNfS4MMf3kIk5Qwab32JJMBekiSnlcbrRokZN5aWFeNWSnbT0msxsZlb7HMkR9PG8Wyr15shDUr4KRHNSAcYA8nxsccJf5AnETryoibgNscY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728699402; c=relaxed/simple;
	bh=JEw3qMomfgQzA69BRmUZmsPsqL/cV5mhyuTOurGZk7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jh+RErjf0iq0mZaYFum/wyzKuqKHtB0uhUz3Epl9M9scrKMGMSKW86e4h1sJiXB9SQKVwgmrKDlzcsz7U4fETd9bG/UEBDBNMmq6xXmFLZelwZ6yVNVMW8QDjGIMKcDcdR0wihWvYfZQ9DCx7NFFRq1usZadZKM4Y6Ne5t6oPWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BO4k+qw0; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ea0ff74b15so1649623a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728699399; x=1729304199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JIpgGULhRMFB311FDWvWmP5IfvB3HTG59Wut79DELzU=;
        b=BO4k+qw0nh7SXdyzO4j5dEUD3ujqmFGzQU/kMZPTy6Ln6RaCvlwt9n0Z7ocDoGXXht
         MwnAFdH//d5ozimpTpez5PGjxvQwgM+e+BXb/IDRRlIlKSkADg0qbMp4tzO8DwQMNznB
         cbMPJ+6cRsuKf15JMWS3ftFYWNIwLeqVXdLd85KWMRuZtgh3DxPeTbIjR5wjqK2VLF0f
         F4rlf++b9kQKewShf0AlJAyL+l0tYmN2rGuyrQJR5SU9uLEvGl77h+vzVgpjCIE40LxF
         OBPrQ3jqURgJHWspQt1kuqW2Wdc8e4JtYZhDiAbrDBew/6aeLp4M2N0Dw/tMHKYIUYE+
         DOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728699399; x=1729304199;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JIpgGULhRMFB311FDWvWmP5IfvB3HTG59Wut79DELzU=;
        b=SLhat1mo+nr1VNdtbkNmpt1hI3BmjeplTxOW6Ee7JGw9XfoxbocC/CKjREqcwrebvu
         DHLe6vmxtJTD8o6i8UVR7OwWttGZXhmOnI4tVKdVgvH7lDhU5faD1UAVicsHBvpySyYa
         8N44mTc5M4H1w1RNn+jpt1mgAR6uKr99A4JUHgsHHB4gkNo2ypKxiYvl+OTRUgwZbPSY
         RqvuaCkTRRcD58YqEr8chgAllgPcIczWor+Br8jN+TAeBqh89OA93fSWKsPdR5ADGMGQ
         BuiRltjGWWM/X2gIqko8mQUQ/mzbCmgljYe90uCkU/s5nmEeIAhTPMMQNIhlqA/WLQXQ
         2hzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlsrWzStNMFL/Mow/Wz3Zcu8hsiYD1dIngvR5yVlNrZlRR7w3vx+OR6N2cVm2shT5OsWxLxukNQnyDRpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJXw5X46R2qCOApWaD7my/8lUZcvsltp+Vbi5TQEFxIaDZ5BlE
	UyYpFlAYe9xguQ3f6y/rUV07zgvkl3bMPDFiF1ykO/9/J0Vpr4UypEiT+Ni2avY=
X-Google-Smtp-Source: AGHT+IH9VIofSm2MjZ1/qlSwo6NShX9cLA2C/KbhDfW9rAR746IidW/T3BSEvyuDXnIpopM7RDxnPQ==
X-Received: by 2002:a05:6a20:c6ce:b0:1cf:3f2a:d1dd with SMTP id adf61e73a8af0-1d8bcf29a9bmr6890777637.12.1728699399062;
        Fri, 11 Oct 2024 19:16:39 -0700 (PDT)
Received: from [10.84.149.95] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9e98c1sm3319287b3a.9.2024.10.11.19.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 19:16:38 -0700 (PDT)
Message-ID: <3647f368-7901-4fd8-9eb0-edc35bffb520@bytedance.com>
Date: Sat, 12 Oct 2024 10:16:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] mm: shrinker: avoid memleak in alloc_shrinker_info
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, david@fromorbit.com, roman.gushchin@linux.dev,
 muchun.song@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 chenridong@huawei.com, wangweiyang2@huawei.com
References: <20241011142105.391157-1-chenridong@huaweicloud.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
Content-Language: en-US
In-Reply-To: <20241011142105.391157-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/11 22:21, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> A memleak was found as bellow:
> 
> unreferenced object 0xffff8881010d2a80 (size 32):
>    comm "mkdir", pid 1559, jiffies 4294932666
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  @...............
>    backtrace (crc 2e7ef6fa):
>      [<ffffffff81372754>] __kmalloc_node_noprof+0x394/0x470
>      [<ffffffff813024ab>] alloc_shrinker_info+0x7b/0x1a0
>      [<ffffffff813b526a>] mem_cgroup_css_online+0x11a/0x3b0
>      [<ffffffff81198dd9>] online_css+0x29/0xa0
>      [<ffffffff811a243d>] cgroup_apply_control_enable+0x20d/0x360
>      [<ffffffff811a5728>] cgroup_mkdir+0x168/0x5f0
>      [<ffffffff8148543e>] kernfs_iop_mkdir+0x5e/0x90
>      [<ffffffff813dbb24>] vfs_mkdir+0x144/0x220
>      [<ffffffff813e1c97>] do_mkdirat+0x87/0x130
>      [<ffffffff813e1de9>] __x64_sys_mkdir+0x49/0x70
>      [<ffffffff81f8c928>] do_syscall_64+0x68/0x140
>      [<ffffffff8200012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> In the alloc_shrinker_info function, when shrinker_unit_alloc return
> err, the info won't be freed. Just fix it.
> 
> Fixes: 307bececcd12 ("mm: shrinker: add a secondary array for shrinker_info::{map, nr_deferred}")

I think this also needs to be cc'd to the stable mailing list:

Cc: stable@vger.kernel.org

> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   mm/shrinker.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Other than that, LGTM.

Acked-by: Qi Zheng <zhengqi.arch@bytedance.com>

Thanks!

> 
> diff --git a/mm/shrinker.c b/mm/shrinker.c
> index dc5d2a6fcfc4..e4b795ee6d2e 100644
> --- a/mm/shrinker.c
> +++ b/mm/shrinker.c
> @@ -87,8 +87,10 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>   		if (!info)
>   			goto err;
>   		info->map_nr_max = shrinker_nr_max;
> -		if (shrinker_unit_alloc(info, NULL, nid))
> +		if (shrinker_unit_alloc(info, NULL, nid)) {
> +			kvfree(info);
>   			goto err;
> +		}
>   		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>   	}
>   	mutex_unlock(&shrinker_mutex);

