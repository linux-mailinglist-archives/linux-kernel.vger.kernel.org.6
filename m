Return-Path: <linux-kernel+bounces-219429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FBF90D146
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DFEE287DF0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501431586F2;
	Tue, 18 Jun 2024 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F03gMMaq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68B213C673
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716090; cv=none; b=dXkABScnYM/C9Zz04rx2hE0uGvZV5r5DDVTRr1aaDanYJRT9pSU5xk40gFLspknV128OGx3pY50aq5E8E3++B+GGOBeGm6Js2NYGJTviOmh4lL+q8+qKjjM4Vm4FSj2+fsl2V1Uulc4v+FVeT+sa7I2lmqxkBH+e88EDXiexaZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716090; c=relaxed/simple;
	bh=bLpId0JKQOK4hGoXt+SwJlU9WDXtxHak7ccDkw+FL8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hNNyFa1/l3qNHvCSwAosi102ofibu3QW5UNHyIMMk8smIPAClhcQpdWruSx3caONGnX0+BjvMaxaEaL4R7RjKUfgci+z7fWVOxHzka/v5jrSXWJr8FagTbc9qXy2arQLM+Qo6eYNwM63weJ72ITMVcRqWXYqYhKBZFsOnpEnfaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F03gMMaq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718716087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rDI13r/zgmF3YUpsVokDN5xtfAJiHrQPJKKAxYZjMOg=;
	b=F03gMMaqKv6XbyObH4M6GUnV4TwXonoMqXhS3CW9O7xoZzVe/Eb2Hm85hiqUOlDNxiF0C2
	a5cOVKjgMQxuBSCSIfe6w5pL3WIDXxMdQL7Ct9ebZpERX9SGPqyNw6+kQ3asDN7JHb3xef
	yI+HvI9ObhLcSQFd0lSg7KsJUMiyU9s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-Ft2a85NUNSmoe_akWGQPLg-1; Tue, 18 Jun 2024 09:08:06 -0400
X-MC-Unique: Ft2a85NUNSmoe_akWGQPLg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-421292df2adso34429295e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718716085; x=1719320885;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rDI13r/zgmF3YUpsVokDN5xtfAJiHrQPJKKAxYZjMOg=;
        b=pemFjtMbSPrfGayCfxSEVHm6Pp9GRPz13h54kK1YEZDtcVSLJQz6hmJxWwNdJRvB4C
         bPSlNBjcqXGSb87qK6wwxgL4heDsuofbcIzr2z1ABkJnS9Qh6k+IZyd1FEEHiE/k6qM2
         AngrupONUyqz6Y5vxUm3k3lLSdRhNAhG3L9XrSqOa3YrlMDn1B1k8sIBiIYMJ8iWlkCr
         WlLFvXuxpWstJ2jdUqhQgY55Kc79zxq3GthAhJieOWBMJvc//5juepHCh+eIfcgVsktI
         RaF53HPSnmZ5VgBT8ZIGed8y+ymhDk/ddEuANomqTWETm/EWu/DgVdKVk9f6twBBVcfO
         6tDg==
X-Forwarded-Encrypted: i=1; AJvYcCWRKlvO8taWONt8M38l8Ps0RrNsFCPT38/24xX4tuHNcaGjPxVYR3fdoEJKNr27aSwhRq5/uZlgI1iPKzYfliMpkskkaS5py86Hrs8c
X-Gm-Message-State: AOJu0Yzh4y+DfliCY15ZZUUFPXz6k2n0zNBXnMAgLYv/awjuSM610A3D
	PJUpC39/tGN8JOVK88qhj1s2NQc3G42Prg0PWbQQ1nmHI9Z4eMojQKOIDyt+b+XxSQ6HoLxZBkc
	IxdmLYPreCd7iQQDkagnA1WApFENcM2TFsGCP+bpGTPzEZV+bb/1vQ6pxyUkpQA==
X-Received: by 2002:a05:600c:4b23:b0:422:47a:15c8 with SMTP id 5b1f17b1804b1-42304820d71mr102574665e9.12.1718716084864;
        Tue, 18 Jun 2024 06:08:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpxm3J8D7YuKoMV98S3k8xb4FTtVTg1NRGuuoPKxbPPSCYa3N7rtb4jV+3HF2FtwfXiGly0g==
X-Received: by 2002:a05:600c:4b23:b0:422:47a:15c8 with SMTP id 5b1f17b1804b1-42304820d71mr102574505e9.12.1718716084393;
        Tue, 18 Jun 2024 06:08:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:1400:78ba:c2d2:22a1:8858? (p200300cbc705140078bac2d222a18858.dip0.t-ipconnect.de. [2003:cb:c705:1400:78ba:c2d2:22a1:8858])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6320c21sm192894355e9.34.2024.06.18.06.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 06:08:03 -0700 (PDT)
Message-ID: <ce9cb3c5-be63-45f0-91ad-4f7ab335d3b2@redhat.com>
Date: Tue, 18 Jun 2024 15:08:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] mm: swap: mTHP swap allocator base on swap cluster
 order
To: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>,
 "Huang, Ying" <ying.huang@intel.com>, Kalesh Singh <kaleshsingh@google.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Barry Song <baohua@kernel.org>
References: <20240614-swap-allocator-v2-0-2a513b4a7f2f@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240614-swap-allocator-v2-0-2a513b4a7f2f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.06.24 01:48, Chris Li wrote:
> This is the short term solutiolns "swap cluster order" listed
> in my "Swap Abstraction" discussion slice 8 in the recent
> LSF/MM conference.
> 
> When commit 845982eb264bc "mm: swap: allow storage of all mTHP
> orders" is introduced, it only allocates the mTHP swap entries
> from new empty cluster list.  It has a fragmentation issue
> reported by Barry.
> 
> https://lore.kernel.org/all/CAGsJ_4zAcJkuW016Cfi6wicRr8N9X+GJJhgMQdSMp+Ah+NSgNQ@mail.gmail.com/
> 
> The mTHP allocation failure rate raises to almost 100% after a few
> hours in Barry's test run.
> 
> The reason is that all the empty cluster has been exhausted while
> there are planty of free swap entries to in the cluster that is
> not 100% free.
> 
> Remember the swap allocation order in the cluster.
> Keep track of the per order non full cluster list for later allocation.
> 
> This greatly improve the sucess rate of the mTHP swap allocation.
> 
> There is some test number in the V1 thread of this series:
> https://lore.kernel.org/r/20240524-swap-allocator-v1-0-47861b423b26@kernel.org
> 
> Reported-by: Barry Song <21cnbao@gmail.com>
> Signed-off-by: Chris Li <chrisl@kernel.org>
> ---

Running the cow.c selftest with a bunch of debug config
settings enabled, I get on mm-unstable:

[   25.236555] list_add corruption. prev->next should be next (ffff888105b5ad08), but was ffff888105b5ae78. (prev=ffff88812580b048).
[   25.237432] ------------[ cut here ]------------
[   25.237702] kernel BUG at lib/list_debug.c:32!
[   25.237962] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[   25.238288] CPU: 23 PID: 1264 Comm: cow Tainted: G        W          6.10.0-rc4+ #301
[   25.238720] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   25.239335] RIP: 0010:__list_add_valid_or_report+0x78/0xa0
[   25.239646] Code: 6b ff 0f 0b 48 89 c1 48 c7 c7 c0 30 0e 83 e8 7f e5 6b ff 0f 0b 48 89 d1 48 89 c6 4c 89 c2 48 c7 c7 18 31 0e 83 e8 68 e5 6b ff <0f> 0b 48 89 f2 48 89 c1 48 89 fe 48 c7 c7 70 31 0e 83 e8 51 e5b
[   25.240670] RSP: 0000:ffffc90002c87bd0 EFLAGS: 00010246
[   25.240964] RAX: 0000000000000075 RBX: ffff888105b5ac00 RCX: 0000000000000000
[   25.241362] RDX: 0000000000000000 RSI: ffff88885f9a1a00 RDI: ffff88885f9a1a00
[   25.241762] RBP: ffff88810624de20 R08: 0000000000000000 R09: 0000000000000003
[   25.242158] R10: ffffc90002c87a78 R11: ffffffff83b5b808 R12: 0000000000044000
[   25.242556] R13: 0000000000044000 R14: ffff88810624e000 R15: ffff88812580bb00
[   25.242960] FS:  00007f4fb364b740(0000) GS:ffff88885f980000(0000) knlGS:0000000000000000
[   25.243413] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   25.243737] CR2: 00007f4fb343c000 CR3: 000000010a5dc000 CR4: 0000000000750ef0
[   25.244145] PKRU: 55555554
[   25.244303] Call Trace:
[   25.244445]  <TASK>
[   25.244572]  ? die+0x36/0x90
[   25.244742]  ? do_trap+0xdd/0x100
[   25.244935]  ? __list_add_valid_or_report+0x78/0xa0
[   25.245211]  ? __list_add_valid_or_report+0x78/0xa0
[   25.245488]  ? do_error_trap+0x81/0x110
[   25.245710]  ? __list_add_valid_or_report+0x78/0xa0
[   25.245988]  ? exc_invalid_op+0x50/0x70
[   25.246211]  ? __list_add_valid_or_report+0x78/0xa0
[   25.246488]  ? asm_exc_invalid_op+0x1a/0x20
[   25.246737]  ? __list_add_valid_or_report+0x78/0xa0
[   25.247016]  swapcache_free_entries+0x1ec/0x240
[   25.247286]  free_swap_slot+0xcc/0xe0
[   25.247498]  put_swap_folio+0xf3/0x3b0
[   25.247720]  delete_from_swap_cache+0x68/0x90
[   25.247972]  folio_free_swap+0xd0/0x200
[   25.248201]  do_swap_page+0xd95/0x12d0
[   25.248418]  ? __entry_text_end+0x101e45/0x101e49
[   25.248695]  ? srso_alias_return_thunk+0x5/0xfbef5
[   25.248969]  ? srso_alias_return_thunk+0x5/0xfbef5
[   25.249246]  ? __pte_offset_map+0x18e/0x270
[   25.249490]  __handle_mm_fault+0x915/0xf80
[   25.249731]  ? srso_alias_return_thunk+0x5/0xfbef5
[   25.250010]  handle_mm_fault+0x1d1/0x400
[   25.250242]  do_user_addr_fault+0x16f/0x790
[   25.250485]  exc_page_fault+0x83/0x260
[   25.250706]  asm_exc_page_fault+0x26/0x30



Maybe what Hugh reported already. I'll try reverting your patches
to see if that fixes these issues.

-- 
Cheers,

David / dhildenb


