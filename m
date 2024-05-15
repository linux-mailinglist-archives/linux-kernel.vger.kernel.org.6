Return-Path: <linux-kernel+bounces-180095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976358C6A0B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E697AB21FC3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CF9156231;
	Wed, 15 May 2024 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MxVfkhJt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973CA155723
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 15:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715788557; cv=none; b=og4zmuHNt2tp0Xg/9XVdXMaLaZiu+SgdV9HhP0PDNwuTfBIx42/yLshtHWf6qJZyATugbqGuzaw3bt8wYZjszn0XXW5Xk+tUPR+rADdN0iQ9i2IXzizmWoPtiEEsaRkuCqtSVA9sNLZG8EiZmgkY/n13VJSWqJPL/KsndCOdT8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715788557; c=relaxed/simple;
	bh=8xlBkhhEyzq6cwnGg1Gz8KBBxtuUCD3LGTU5gDZXFaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VhbByYuRwsGssjH5Wxsfe7ZouVBZbPwREvDkirhMB+S2u29hJ3PCU1aPBuvPY747m/lhlVAGao/qF9jQeq/Ud5QpuIYusQlkIASv82HyRJyPD4tBKuCEpm4/ka4RS/OVAcpPcAMv/LYtARjZdkzGY+zCv10X7Eu1neuX0uN7ygA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MxVfkhJt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715788554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TAWZMXmTJYWTp1Ik3wwpYrspfaT129ks4Pu75IdYbQc=;
	b=MxVfkhJtDrupWTfsyYNhw9uvnhLq6rXNMNHbsW54GQxnZ2Z3y2D8dez3B4Dg0PB9VNFQE0
	yDXn4no15zur9eodY0wR3Imhmc73W2D/Pl3leJqGZyPHbc7c+quO3BlLSdAdSBf/KugnDN
	2yDz3sn5dm3ZWtJXwKCS3U3EcP3Xowc=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-mAZOe3c6MOCT3koZwvkEgg-1; Wed, 15 May 2024 11:55:53 -0400
X-MC-Unique: mAZOe3c6MOCT3koZwvkEgg-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6f452eb2035so6618172b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 08:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715788552; x=1716393352;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TAWZMXmTJYWTp1Ik3wwpYrspfaT129ks4Pu75IdYbQc=;
        b=CGkYeq7+35DKjAJulnlW9q4jcR3Eme0NxU62lwNuJBQtCxlkLoxCXzg6iFGMuC2gpN
         U3I742ajr9fh9jrc80Qbmjdo6c2WEsniY/APyGWGtMRaem9vL69J9UhXksWBBY5tYk2m
         BGt7lKiUzP1ByyFgDmk5xcStPf6jtyjDdF/GCmYeCwyEDNqS02rCbtn9J2K4C/mLbzHl
         PKk1kVGQpuM6OBU+YONfyx6ykkebQN8lKL/Hy/9uhr48mq2gVrnaSQcvSTNG7KbXuOSq
         82N0VUkI+0vGn7C7Q1wXYFJIolcpKvGOFT+lk9UAPKMnpd0msiFXFJDlYTHlLkKcGfo9
         WShg==
X-Forwarded-Encrypted: i=1; AJvYcCVs/MBkaZOUn+iSogbTHibo2zkuSRdXDq76l+Njr9++CureWbdBPBjhx5SD/xgiE3x2B6gXD3fRU1iZBXXA78N0WY+cV91E2YT2SEEr
X-Gm-Message-State: AOJu0YwN1Qyj8SX5ve0va1WPkl9o71r/kNaG2Es7OfrsSMF9t4kMA+Im
	xDIl8M4QzAR0LTsfB2+70Yrv1ftSyQNLqgf75nd40bAtxKUSrThpHKW7J33bP0TDY70WAPVYveR
	LEh30uhWZwsLJ4Mnhf7TfWDYnucb8VaPhvUYZHOiR+KbsyKNt2cjz2Bnt4gIAig==
X-Received: by 2002:a05:6a20:7285:b0:1af:ce5e:ca5e with SMTP id adf61e73a8af0-1afde0b0de0mr17590536637.22.1715788552013;
        Wed, 15 May 2024 08:55:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAvB5GA4/OSIIbT6anacvHssH7mMV88hhkGKM1mVD9L5b2Cvaf1r+obCn743lpt+jR4gjvGQ==
X-Received: by 2002:a05:6a20:7285:b0:1af:ce5e:ca5e with SMTP id adf61e73a8af0-1afde0b0de0mr17590501637.22.1715788551502;
        Wed, 15 May 2024 08:55:51 -0700 (PDT)
Received: from [172.21.1.2] ([50.204.89.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c038733sm122626045ad.215.2024.05.15.08.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 08:55:51 -0700 (PDT)
Message-ID: <e1c93779-8cde-4986-85d3-2134fb8970b3@redhat.com>
Date: Wed, 15 May 2024 17:55:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/huge_memory: don't unpoison huge_zero_folio
To: Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc: shy828301@gmail.com, nao.horiguchi@gmail.com, xuyu@linux.alibaba.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240515023607.870022-1-linmiaohe@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240515023607.870022-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.05.24 04:36, Miaohe Lin wrote:
> When I did memory failure tests recently, below panic occurs:
> 
>   kernel BUG at include/linux/mm.h:1135!
>   invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>   CPU: 9 PID: 137 Comm: kswapd1 Not tainted 6.9.0-rc4-00491-gd5ce28f156fe-dirty #14
>   RIP: 0010:shrink_huge_zero_page_scan+0x168/0x1a0
>   RSP: 0018:ffff9933c6c57bd0 EFLAGS: 00000246
>   RAX: 000000000000003e RBX: 0000000000000000 RCX: ffff88f61fc5c9c8
>   RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff88f61fc5c9c0
>   RBP: ffffcd7c446b0000 R08: ffffffff9a9405f0 R09: 0000000000005492
>   R10: 00000000000030ea R11: ffffffff9a9405f0 R12: 0000000000000000
>   R13: 0000000000000000 R14: 0000000000000000 R15: ffff88e703c4ac00
>   FS:  0000000000000000(0000) GS:ffff88f61fc40000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 000055f4da6e9878 CR3: 0000000c71048000 CR4: 00000000000006f0
>   Call Trace:
>    <TASK>
>    do_shrink_slab+0x14f/0x6a0
>    shrink_slab+0xca/0x8c0
>    shrink_node+0x2d0/0x7d0
>    balance_pgdat+0x33a/0x720
>    kswapd+0x1f3/0x410
>    kthread+0xd5/0x100
>    ret_from_fork+0x2f/0x50
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
>   Modules linked in: mce_inject hwpoison_inject
>   ---[ end trace 0000000000000000 ]---
>   RIP: 0010:shrink_huge_zero_page_scan+0x168/0x1a0
>   RSP: 0018:ffff9933c6c57bd0 EFLAGS: 00000246
>   RAX: 000000000000003e RBX: 0000000000000000 RCX: ffff88f61fc5c9c8
>   RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff88f61fc5c9c0
>   RBP: ffffcd7c446b0000 R08: ffffffff9a9405f0 R09: 0000000000005492
>   R10: 00000000000030ea R11: ffffffff9a9405f0 R12: 0000000000000000
>   R13: 0000000000000000 R14: 0000000000000000 R15: ffff88e703c4ac00
>   FS:  0000000000000000(0000) GS:ffff88f61fc40000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 000055f4da6e9878 CR3: 0000000c71048000 CR4: 00000000000006f0
> 
> The root cause is that HWPoison flag will be set for huge_zero_folio
> without increasing the folio refcnt. But then unpoison_memory() will
> decrease the folio refcnt unexpectly as it appears like a successfully
> hwpoisoned folio leading to VM_BUG_ON_PAGE(page_ref_count(page) == 0)
> when releasing huge_zero_folio.
> 
> Skip unpoisoning huge_zero_folio in unpoison_memory() to fix this issue.
> We're not prepared to unpoison huge_zero_folio yet.
> 
> Fixes: 478d134e9506 ("mm/huge_memory: do not overkill when splitting huge_zero_page")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: <stable@vger.kernel.org>
> ---
> v2:
>   Change to simply check for the huge zero page. Thanks.
> ---
>   mm/memory-failure.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 16ada4fb02b7..68bc8d7ff53d 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2558,6 +2558,12 @@ int unpoison_memory(unsigned long pfn)
>   		goto unlock_mutex;
>   	}
>   
> +	if (is_huge_zero_folio(folio)) {
> +		unpoison_pr_info("Unpoison: huge zero page is not supported %#lx\n",
> +				 pfn, &unpoison_rs);
> +		goto unlock_mutex;
> +	}
> +
>   	if (folio_test_slab(folio) || folio_test_pgtable(folio) ||
>   	    folio_test_reserved(folio) || folio_test_offline(folio))
>   		goto unlock_mutex;

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


