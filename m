Return-Path: <linux-kernel+bounces-381127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B099AFAB7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07DA51F249C0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F591B21AE;
	Fri, 25 Oct 2024 07:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="A1PBr+Pl"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F2118BB9A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729840337; cv=none; b=kXxKi7+4IPyXY7X96leBl6645SIQRv1jhx8IsX9MMRLVwEA5i/YoeX+n5KE6FeueacfVn2RreBNCZobf8PiC3bP4vhvmugOVJc9z2zyT2piDFE/N9ffP+c+3wUDgRcid+W9TMV4dNcmaxXlaaxKeZgURzjyeiv6o+VvuhYbxkm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729840337; c=relaxed/simple;
	bh=7i7ka3KzkamKJmAgkbylB2u+ivI+OWNLfAVGoiPgEtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mg4tJc+ohZ3Z0fl+HIb6jMhg+mY0QseaXRAtn6EO0OMYj0GLmvTZul38OHAsXUJnLDGrO6XoMP9jL5bQ26Xoboj23125bBnZnUWL13XEKCrChbL4kCVIol2WGuaerZSYxaWa02l8ec7VPLuXjr1XuSuZuLl1GMOTkIkZzqtIhNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=A1PBr+Pl; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e2ed59a35eso1368785a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 00:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729840333; x=1730445133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B/cCbKNuKB3gronXLhNY7Z0mGjddFinoZE4u7tpjqcQ=;
        b=A1PBr+Pl7VX6pnwRHGZBHx8+HUy1j3XQCnqzpF6ZsNzYBBLnvBBMhP0hc71hkfre3O
         dHh00Lc1N9zAfyWr4pJIVdbULKQvDOb+h6w1Vecq18MKoAfXkFpExOiX3i78aAn0cQF0
         zFliDWoXt0fPw57gPXVqHI8/MoHFeYG5VDQPSKyJHPmcIcXRvxEAOrFPdVsUuVaL3812
         bol1rHEleooC/U6cN7+7EdeXtAil0wVRclz6T3NzSonO74x43MQWBG1QwnRMWOaKDD4s
         mupZP2uyAf2/7eC8xsD7bvHsVuMVT69+OJX0Wtdky/9NO7liDBfyMCWY9WvZc1UA599g
         Xr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729840333; x=1730445133;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B/cCbKNuKB3gronXLhNY7Z0mGjddFinoZE4u7tpjqcQ=;
        b=QGATS4YtopElwL9YSvccxNWxhFbLyEVjkMqeM+yB46PhZqkEP6YJBi0919zMRgOQRN
         L8qW14UfsvgiU/cNhpVbLyQVSLe2E04EjjBYhnBzoL8w2Di7d2i2yZ2Ly7ZlJSIWWN6c
         e+KY++ZnqgTPKQpER2Mc7acuVFRBSpAXdx/Z407urEj9RtZBO3LjVG5n3LeUqqXHsLeH
         NgLIIjxXdML7sGwlCpYVAlzZujI8O9eSMg8ph/BEAViOpKaf1K+yMQpCHRZCxdlOWrlE
         Y/QuczdSMSdMjzGUJdwdE9+BAp4mwgR9Sp3M1uONN9Hzwco6M8HRQ9CxsMD0bK6Zn3Zz
         7Fiw==
X-Forwarded-Encrypted: i=1; AJvYcCVfqqZO63N9e5bCrA1kY/on4FRxSMT6rxFKPgCFWxUdMYWifYmzmvPl5ssCyplYAeRVALr43dIAwpIIBoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoJs6bzNAt0ao/I9dw9EynvFArvfWIizXOC14FRNYsK2K8DD9D
	Q27ASceN/eanw2ZNDY/6UZw6Kiokrgy6cphxq3ypNHSPw2IVOX6fDjl613mAv9c=
X-Google-Smtp-Source: AGHT+IGhkMBbXaJu0HAzi5N/CRI5uaJ6PKnhoP/gUop/fnR0Kchxwudsu8opRczYoCn/Ys9J0p54QQ==
X-Received: by 2002:a17:90b:17cf:b0:2e2:cc47:f1b0 with SMTP id 98e67ed59e1d1-2e77f321aa7mr5463083a91.3.1729840332999;
        Fri, 25 Oct 2024 00:12:12 -0700 (PDT)
Received: from [10.84.149.95] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e377179asm666395a91.53.2024.10.25.00.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 00:12:12 -0700 (PDT)
Message-ID: <b9f5c74a-acc5-42b4-bb7e-0b4f487486c6@bytedance.com>
Date: Fri, 25 Oct 2024 15:12:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: shrinker: avoid memleak in alloc_shrinker_info
Content-Language: en-US
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, david@fromorbit.com, roman.gushchin@linux.dev,
 muchun.song@linux.dev, anshuman.khandual@arm.com, vbabka@suse.cz,
 kirill@shutemov.name, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 chenridong@huawei.com, wangweiyang2@huawei.com
References: <20241025060942.1049263-1-chenridong@huaweicloud.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20241025060942.1049263-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/25 14:09, Chen Ridong wrote:
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

Again, please:

Cc: stable@vger.kernel.org

I think Andrew can help add that. ;)

Thanks!

> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> Acked-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>   mm/shrinker.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/shrinker.c b/mm/shrinker.c
> index dc5d2a6fcfc4..4a93fd433689 100644
> --- a/mm/shrinker.c
> +++ b/mm/shrinker.c
> @@ -76,19 +76,21 @@ void free_shrinker_info(struct mem_cgroup *memcg)
>   
>   int alloc_shrinker_info(struct mem_cgroup *memcg)
>   {
> -	struct shrinker_info *info;
>   	int nid, ret = 0;
>   	int array_size = 0;
>   
>   	mutex_lock(&shrinker_mutex);
>   	array_size = shrinker_unit_size(shrinker_nr_max);
>   	for_each_node(nid) {
> -		info = kvzalloc_node(sizeof(*info) + array_size, GFP_KERNEL, nid);
> +		struct shrinker_info *info = kvzalloc_node(sizeof(*info) + array_size,
> +							   GFP_KERNEL, nid);
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

