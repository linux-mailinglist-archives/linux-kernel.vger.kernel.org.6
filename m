Return-Path: <linux-kernel+bounces-177771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDF18C4471
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922A51C2138F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC5D154427;
	Mon, 13 May 2024 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U1Iu9+pq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746AE179A3
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614866; cv=none; b=cGsdq8e1eFENpbNosWCx/46I8QYKJL8ZNv/vvHvm/H48gpVk+EH2xUWj5JTCQtxJjFfwgoywtHyLPjl1bQecBw2RM+ywy73taNxfcnzBVgVo6cNDSmhuYdBmI+8CFClpxwm4ycxbhcTZdgo6chIUwgnjApUO8lvX7CHW8xh3kb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614866; c=relaxed/simple;
	bh=3RLNyMAl6E4+ZUnPzZ8hyg4dcLnf5D4TO0ccA0hqmh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZfBvBAFL+bJNzJhyPsawP6VP59+FmR2Wbzkf+qd1tPeOunc4T/G1R8S5zVnbU+d1Ki1UsGGYqTcyjytzgz+nwfNOgzrIBRDjAOA1cL/Eh17waayqXHvfQpb6Q1QpTd5/MwDDB1vQe5G87Cjtt8GMGvSSV+5Y3ZST5R3iDOffl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U1Iu9+pq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715614863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+29AtKu2k/Sht8c2nyguijrm1ypAMsegz7g8gzvpdrY=;
	b=U1Iu9+pqUdxdnLG/0RdlmNFDtk1kbh6ez4pBH6uRFTSIfAi1zLgWFsqsI5m71bEeGoQ+eA
	sgyb9CNRJNK5FEvPu9+a1cfGqcoowPX1TqwV6/nwAf7ZcM2FJZB/0Wx8U92rKC8cJgW3uq
	Z7aMmtzlvPElIL87HPRw+iWSTdBAyqE=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-g_YP0iMBPHC1xD2-xIP7XQ-1; Mon, 13 May 2024 11:40:52 -0400
X-MC-Unique: g_YP0iMBPHC1xD2-xIP7XQ-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5acd51e4692so5760708eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715614851; x=1716219651;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+29AtKu2k/Sht8c2nyguijrm1ypAMsegz7g8gzvpdrY=;
        b=uJrlrFBGATJvTv9hzomq6/Eie4sBRdfK281ENB3IpSF8xFwNtp1YtaQV5dEMqvZHuK
         IOoy/DakpRkMtLaEFdOFRqFkGB84gkradV+BQtTnoNfG8fXTmO9azOSVQkepVgWAcfJk
         Rx/FO8A8KELyIYkaass4sQicrbUU/oECCIZ9Ss2uasyG1VVidMLrpNxfuICqgjWxyjlo
         5LPymBhmn9Zn6U2wp2+80b2oZHQ+xpQWgVQ/PBXLE5JDYNp6XZFXnx6Lrb7qNS/iViD3
         LWlT02/OWxALnv0AOfPR7YCitqSf7D9fYlNF8S230wQgTiXwenVFZ+LqxmjnaVyFKiMq
         O5Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUcprhPrJLOmpnUjrH0yJzVvuPFaHGcWwwb0EL11ZzvSmXpYh7kcOTQDF00ksHyREX5hTX6O1cmxheb7mzMwxDyjgZuhUzPX/N7nWOy
X-Gm-Message-State: AOJu0YyO6hwDpxkM70jOjJHhzsfLYB0Z/pfNvViAcH1Z9Z1Dtv0TPxW8
	5Ukk8/Ln+PrQR5graEjlCC68g/hcyvbF5T6EtDcn1PSJ3O6nA6MhKnHjHzeAiHTfpQSGMfITjvs
	8XWGlEJOOzkIBSNlTtQghYB03cB34STj24hpfH5eiDNquVw4/a1tHhuE+32oO1IbhUW7VOg==
X-Received: by 2002:a05:6358:33a4:b0:190:a78a:f066 with SMTP id e5c5f4694b2df-193bcff5c0cmr1201877355d.32.1715614850888;
        Mon, 13 May 2024 08:40:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEc9iz3bBaRTo21rucZheNsTblCsYjFnZAHU+5LukzO5DAQNv/1yybt6DDF51SknX66cn57Hg==
X-Received: by 2002:a05:6358:33a4:b0:190:a78a:f066 with SMTP id e5c5f4694b2df-193bcff5c0cmr1201875155d.32.1715614850359;
        Mon, 13 May 2024 08:40:50 -0700 (PDT)
Received: from [172.21.1.2] ([50.204.89.31])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-634103f6a80sm6887309a12.74.2024.05.13.08.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 08:40:49 -0700 (PDT)
Message-ID: <1ca64fc3-1b96-466e-aa25-a8f9f6805edc@redhat.com>
Date: Mon, 13 May 2024 17:40:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: mark huge_zero_folio reserved
To: Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc: shy828301@gmail.com, nao.horiguchi@gmail.com, xuyu@linux.alibaba.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240511032801.1295023-1-linmiaohe@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240511032801.1295023-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.05.24 05:28, Miaohe Lin wrote:
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
> Fix this issue by marking huge_zero_folio reserved. So unpoison_memory()
> will skip this page. This will make it consistent with ZERO_PAGE case too.
> 
> Fixes: 478d134e9506 ("mm/huge_memory: do not overkill when splitting huge_zero_page")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: <stable@vger.kernel.org>
> ---
>   mm/huge_memory.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 317de2afd371..d508ff793145 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -212,6 +212,7 @@ static bool get_huge_zero_page(void)
>   		folio_put(zero_folio);
>   		goto retry;
>   	}
> +	__folio_set_reserved(zero_folio);

We want to limit/remove the use of PG_reserve. Please find a different 
way (e.g., simply checking for the huge zero page directly).

-- 
Cheers,

David / dhildenb


