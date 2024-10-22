Return-Path: <linux-kernel+bounces-375415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 869C49A95A3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99EA2284612
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3021135A79;
	Tue, 22 Oct 2024 01:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1LXHf3y"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B81912FF72;
	Tue, 22 Oct 2024 01:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729561504; cv=none; b=Xoq7JbH5RA5sbsFjUY3U/PflZ4Uk6ezu9N+X9eTiO2RJfg6N9j1aHYWsxkXxgtFMcmNFW51v5tW/mD4/Y68kOdJ/FW78TqXsSg5XLhmvk+lW0vZfho7VbRLDGjr/pBHFSqzb+7/mVckDj0EgI7ZCMOnCEGrbGLs0h+UnbB5SDBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729561504; c=relaxed/simple;
	bh=ill1wOd5pl/H7TInSe3gdvnN8TKaEBaWDvfkOrO/ulM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iIlA2+W7uKeMZQ1A+jE70xA8k+IBLZ89Ifs1p7mrGGvDGXySvUa9XwO+90aYsy8cj6M0UWTCvFaROro0N1CvEhLQmAY/ZL9uchXPJjJ5FP4nOysOdQbDDOlZZTP3Yhe3gxH4MlGgEah9lhQIasU+wNGpuNjqdKqZHRLPjmQ5Hpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1LXHf3y; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e2e4237da4so46613797b3.1;
        Mon, 21 Oct 2024 18:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729561501; x=1730166301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VuKRGQ3bFUStWQPbkXvW339pz3J6NqBpg8n3124Xq6c=;
        b=k1LXHf3y/FaMiZJhg+hwizUpGKBaLnxnMj3Uqosxl7eG+Klr+M86ZGObcVkQxYeLbz
         HEkMsW0JyYRW2ztY5DXoO6V+jzeuWqwuhJM2GIcQDx/YyH2v4nNsMYtTpTBMLv3uzPXy
         E3JO+18EhYY35PIS0DN6hEEDhA8SlyxS3cIo/13UNSpseMRbZ0BtQDBeDKcLSMqo17LC
         cR8RMLyzYamTlqpxlLq4aofnBxUO+isSnj5bVkjXJJQw8Rku3jO7lGonE6QoqtBgJsBU
         2BbQVMl/+eyQtyysnRXQS7AClfumXwEOqf6sW2yLWmSN3K5jtKD0l5+eg0vVLDBgbUkz
         u2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729561501; x=1730166301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VuKRGQ3bFUStWQPbkXvW339pz3J6NqBpg8n3124Xq6c=;
        b=b/aTfvI2gzd8+dif0kD4C4G1H3ddp83rlD3BQfWvQQW6Kjod+L2d0BrvBpQy3Y+ITs
         Ls23ucB2Y/fA1QXbvcW3WLziEVXKaOEBCGYapAukXqSkUjMq8rjqxVTU7bAYURosrA83
         PSa2GGoI9/UVgtXPzI8GMS27nhzYd0Ey6hFrKfwqSdc6/6KGRzhPIITuhswXVxIluo4b
         H3ErB6euay7SBMUhEuaAitV1z1/k9xD6MzkOYLl2M9iVktX4mY5RnCxmApIBekWzT5Ly
         4FI63dS+JlZjVrG5kJ8AJavM5U/XTELX6XT+Umo4Ucb7ifOofZxXkfHgsbWVOhmBfBLc
         z2lg==
X-Forwarded-Encrypted: i=1; AJvYcCVdwwmzvfStLHQ2hF3/X/6LIKpWlNnNiE6iMgPUyIS4RfOVe5x9BWImryTbSZaBU2LovbpIPA6RPQE=@vger.kernel.org, AJvYcCXTHnmKegV0DsTkeq3C+SgqLcniKlmfX99mRHvqqBaotyH68/lsHodOKlVVy+aiuK/XicMyMZbQ5jZn2zYo@vger.kernel.org
X-Gm-Message-State: AOJu0YxjVGFl+WEgzLYF9+RU5XbkRm3Rag7P6tHWdTRdVU2cLWPAdIFQ
	Ql0eqE+Wd7PU3B6ysNtikTD04zEEadvdvsYa1nwQTQTfjIMwEKWO
X-Google-Smtp-Source: AGHT+IH4p0mpvdNz9xkFkZ3gA87yXt0dFCWnZq15lfitywdFFV62DAQpS5rYQLIwuzJbTQB+pcDygQ==
X-Received: by 2002:a05:690c:9693:b0:6e5:cb46:4641 with SMTP id 00721157ae682-6e7d3acdbafmr21227017b3.13.1729561501306;
        Mon, 21 Oct 2024 18:45:01 -0700 (PDT)
Received: from [192.168.2.226] ([107.175.133.150])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5a489d1sm9094977b3.33.2024.10.21.18.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 18:45:00 -0700 (PDT)
Message-ID: <289e0ccf-2671-46b4-aec9-0123e9a8eacb@gmail.com>
Date: Tue, 22 Oct 2024 09:44:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] docs/zh_CN: update the translation of
 mm/page_owner.rst
To: Dongliang Mu <dzm91@hust.edu.cn>, si.yanteng@linux.dev, alexs@kernel.org,
 corbet@lwn.net, Yanteng Si <siyanteng@loongson.cn>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1729327831.git.dzm91@hust.edu.cn>
 <38a9d8868e0f98dc5d2a08fb865313cc4db943a3.1729327831.git.dzm91@hust.edu.cn>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <38a9d8868e0f98dc5d2a08fb865313cc4db943a3.1729327831.git.dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Reviewed-by: Alex Shi <alexs@kernel.org>

On 10/19/24 16:54, Dongliang Mu wrote:
> Update to commit f5c12105c15f ("mm,page_owner: fix refcount imbalance")
> 
> Documentation/translations/zh_CN/mm/page_owner.rst
> commit f5c12105c15f ("mm,page_owner: fix refcount imbalance")
> commit ba6fe5377244 ("mm,page_owner: update Documentation regarding
> page_owner_stacks")
> 2 commits needs resolving in total
> 
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  .../translations/zh_CN/mm/page_owner.rst      | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/Documentation/translations/zh_CN/mm/page_owner.rst b/Documentation/translations/zh_CN/mm/page_owner.rst
> index b72a972271d9..c0d1ca4b9695 100644
> --- a/Documentation/translations/zh_CN/mm/page_owner.rst
> +++ b/Documentation/translations/zh_CN/mm/page_owner.rst
> @@ -26,6 +26,9 @@ page owner是用来追踪谁分配的每一个页面。它可以用来调试内
>  页面所有者也可以用于各种目的。例如，可以通过每个页面的gfp标志信息获得精确的碎片
>  统计。如果启用了page owner，它就已经实现并激活了。我们非常欢迎其他用途。
>  
> +它也可以用来显示所有的栈以及它们当前分配的基础页面数，这让我们能够快速了解内存的
> +使用情况，而无需浏览所有页面并匹配分配和释放操作。
> +
>  page owner在默认情况下是禁用的。所以，如果你想使用它，你需要在你的启动cmdline
>  中加入"page_owner=on"。如果内核是用page owner构建的，并且由于没有启用启动
>  选项而在运行时禁用page owner，那么运行时的开销是很小的。如果在运行时禁用，它不
> @@ -60,6 +63,49 @@ page owner在默认情况下是禁用的。所以，如果你想使用它，你
>  
>  4) 分析来自页面所有者的信息::
>  
> +	cat /sys/kernel/debug/page_owner_stacks/show_stacks > stacks.txt
> +	cat stacks.txt
> +	 post_alloc_hook+0x177/0x1a0
> +	 get_page_from_freelist+0xd01/0xd80
> +	 __alloc_pages+0x39e/0x7e0
> +	 allocate_slab+0xbc/0x3f0
> +	 ___slab_alloc+0x528/0x8a0
> +	 kmem_cache_alloc+0x224/0x3b0
> +	 sk_prot_alloc+0x58/0x1a0
> +	 sk_alloc+0x32/0x4f0
> +	 inet_create+0x427/0xb50
> +	 __sock_create+0x2e4/0x650
> +	 inet_ctl_sock_create+0x30/0x180
> +	 igmp_net_init+0xc1/0x130
> +	 ops_init+0x167/0x410
> +	 setup_net+0x304/0xa60
> +	 copy_net_ns+0x29b/0x4a0
> +	 create_new_namespaces+0x4a1/0x820
> +	nr_base_pages: 16
> +	...
> +	...
> +	echo 7000 > /sys/kernel/debug/page_owner_stacks/count_threshold
> +	cat /sys/kernel/debug/page_owner_stacks/show_stacks> stacks_7000.txt
> +	cat stacks_7000.txt
> +	 post_alloc_hook+0x177/0x1a0
> +	 get_page_from_freelist+0xd01/0xd80
> +	 __alloc_pages+0x39e/0x7e0
> +	 alloc_pages_mpol+0x22e/0x490
> +	 folio_alloc+0xd5/0x110
> +	 filemap_alloc_folio+0x78/0x230
> +	 page_cache_ra_order+0x287/0x6f0
> +	 filemap_get_pages+0x517/0x1160
> +	 filemap_read+0x304/0x9f0
> +	 xfs_file_buffered_read+0xe6/0x1d0 [xfs]
> +	 xfs_file_read_iter+0x1f0/0x380 [xfs]
> +	 __kernel_read+0x3b9/0x730
> +	 kernel_read_file+0x309/0x4d0
> +	 __do_sys_finit_module+0x381/0x730
> +	 do_syscall_64+0x8d/0x150
> +	 entry_SYSCALL_64_after_hwframe+0x62/0x6a
> +	nr_base_pages: 20824
> +	...
> +
>  	cat /sys/kernel/debug/page_owner > page_owner_full.txt
>  	./page_owner_sort page_owner_full.txt sorted_page_owner.txt
>  

