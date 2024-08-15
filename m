Return-Path: <linux-kernel+bounces-288493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15091953AC6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 21:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9DC2284F0F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB0B6F2F6;
	Thu, 15 Aug 2024 19:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krVq3CO2"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A748F55897;
	Thu, 15 Aug 2024 19:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723749421; cv=none; b=V+xOZCgw1SZSTrVu3v5D9xtJbV53Iz8gPEDG2vNJ4We9jkFxt2tTF6bS/2WL/jH9gjMmhVuXb8kZt9WhVo9VDBRLd4xFYfAq/fhT8uxbmNffp6qXJw0KJ7DkU0Cj4Ukbwm1GDmnJCfuB6EBAZvkgf49Gc+E5U0/w7cthWvKCtf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723749421; c=relaxed/simple;
	bh=abyBIUJsLlL3YFctZgnQoJztF2jnSZOcMBem0JS/4fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qjOlXUXBEyQbdFNUCvEo89uO8f7YMCA8nxMb00e5EGDvDCGPZClUHNP2ZDn9bIFySJvpbEQX7WIc1az3AxyE2RBf0caHzbufJMc3k9DdqyPFRFTn5T9bM4sJ9cXAE+6Lynq3KC8gMx7aVATzDOwKq12QU3alZcMTruG/0bSuC8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krVq3CO2; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3687f91af40so750196f8f.0;
        Thu, 15 Aug 2024 12:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723749418; x=1724354218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=12Z31+a15503HqE1J4tj6gMw+kccttTQ8cLqeplfxrY=;
        b=krVq3CO2GgH4HTQH48o8NvvXhx7kvyutLP+LaEr+IK3O3kUrd4PviOlgKiK7NNWQiV
         KFkdMO+dxIB2GMQsl7tN9W1WEbSvMLkE1jVoy+TNehqurxQWIMTjDvGHElb3oaUo061m
         CsklgExt61hLGen3tOsKeadMSVm8wfrmIP2AFjLP4jHpE9g3xTWUvcRPljWMH5WMh1rm
         hbw5b6Tod/zjK71WaZNEPWDhKD5bOqwcmbN0d1FJOyG90aEB3PZEA0tuLtDfJFAfXfd0
         ZJjJERHby56nxAiu1GsPmycT+RcX5E5J/plI6e9JZGvyW4nFcLskycegtUYWsXXMJH5T
         pWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723749418; x=1724354218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12Z31+a15503HqE1J4tj6gMw+kccttTQ8cLqeplfxrY=;
        b=ieNs/Hjde/fXUR5/YYfku3VJlrZ04bJSI8GFkibxxEiLzjdAVGDleEhLF7raJ2Jz1p
         YCS96Fg4GaKudlFgHnvnbSNDShqJuENUdLnuKSiRYr2r/ITzQi5zNeHFfKmoNxSXkxtT
         c5PhYmdqgMkZmHv/HX7IROwJHISdu2Z0/RlAEYHvbYVTBWVAVt04fZ9fj0MnKPVqmtJw
         MA4GAYVMmg5gsWQBCjrszFfgCbM9pNCNzELSLtY4Ax1sapHZsMdysOVILCRE0VMg54jP
         tZQYHebDm5VemYRvZ7r78kRSvlJ/KwIf4chzQslfvWQwsFxmkvbm9i3CPFJAVl6tRQfo
         WJBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTlgx4ychMKc8cVQTTcM/k7kTIke6BgsaUuxvfUJIluMbptiVRNZdtgSF7/oXBUhovgpcKCdvb3wjR7Mny3ORC6jtmaEhLMzDrtHgxCS0NKN657qj5Vl97DZ1aC0Rg4gVcmW4QjE/k
X-Gm-Message-State: AOJu0YxV8ygh8DiGAhK14vT8NT66ov50VFwk2k16qZ0w08cOWXbx5BZt
	Gf3IATOapswbE3a7hBfMS/5kBINXfWt+VEv0tx1ewPaaA8IQwj42
X-Google-Smtp-Source: AGHT+IFdEdE3KWUUL8vExPd+XrzXIfiFGkvD4jYe1ElM70l5kxZ/0D3Fj9TIi3wRnYnhIL+BF9tIIg==
X-Received: by 2002:adf:f70c:0:b0:371:8a8f:3baf with SMTP id ffacd0b85a97d-37194314c25mr246980f8f.9.1723749417414;
        Thu, 15 Aug 2024 12:16:57 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:7600:c5:51ce:2b5:970b? ([2a02:6b6f:e750:7600:c5:51ce:2b5:970b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a2eesm2175767f8f.19.2024.08.15.12.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 12:16:57 -0700 (PDT)
Message-ID: <a4b1b34f-0d8c-490d-ab00-eaedbf3fe780@gmail.com>
Date: Thu, 15 Aug 2024 20:16:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] mm: free zapped tail pages when splitting isolated
 thp
To: Kairui Song <ryncsn@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev,
 yuzhao@google.com, david@redhat.com, baohua@kernel.org,
 ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org,
 cerasuolodomenico@gmail.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com,
 Shuang Zhai <zhais@google.com>
References: <20240813120328.1275952-1-usamaarif642@gmail.com>
 <20240813120328.1275952-2-usamaarif642@gmail.com>
 <CAMgjq7DhdSXMHPLa3AHgAtcRN0A7pemTFFd1h19w4H_qyUMZMQ@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAMgjq7DhdSXMHPLa3AHgAtcRN0A7pemTFFd1h19w4H_qyUMZMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 15/08/2024 19:47, Kairui Song wrote:
> On Tue, Aug 13, 2024 at 8:03 PM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>> From: Yu Zhao <yuzhao@google.com>
>>
>> If a tail page has only two references left, one inherited from the
>> isolation of its head and the other from lru_add_page_tail() which we
>> are about to drop, it means this tail page was concurrently zapped.
>> Then we can safely free it and save page reclaim or migration the
>> trouble of trying it.
>>
>> Signed-off-by: Yu Zhao <yuzhao@google.com>
>> Tested-by: Shuang Zhai <zhais@google.com>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>> ---
>>  mm/huge_memory.c | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
> 
> Hi, Usama, Yu
> 
> This commit is causing the kernel to panic very quickly with build
> kernel test on top of tmpfs with all mTHP enabled, the panic comes
> after:
> 

Hi,

Thanks for pointing this out. It is a very silly bug I have introduced going from v1 page version to the folio version of the patch in v3.

Doing below over this patch will fix it:

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 907813102430..a6ca454e1168 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3183,7 +3183,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 
                        folio_clear_active(new_folio);
                        folio_clear_unevictable(new_folio);
-                       if (!folio_batch_add(&free_folios, folio)) {
+                       if (!folio_batch_add(&free_folios, new_folio)) {
                                mem_cgroup_uncharge_folios(&free_folios);
                                free_unref_folios(&free_folios);
                        }


I will include it in the next revision.

> [  207.147705] BUG: Bad page state in process tar  pfn:14ae70
> [  207.149376] page: refcount:3 mapcount:2 mapping:0000000000000000
> index:0x562d23b70 pfn:0x14ae70
> [  207.151750] flags:
> 0x17ffffc0020019(locked|uptodate|dirty|swapbacked|node=0|zone=2|lastcpupid=0x1fffff)
> [  207.154325] raw: 0017ffffc0020019 dead000000000100 dead000000000122
> 0000000000000000
> [  207.156442] raw: 0000000562d23b70 0000000000000000 0000000300000001
> 0000000000000000
> [  207.158561] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
> [  207.160325] Modules linked in:
> [  207.161194] CPU: 22 UID: 0 PID: 2650 Comm: tar Not tainted
> 6.11.0-rc3.ptch+ #136
> [  207.163198] Hardware name: Red Hat KVM/RHEL-AV, BIOS 0.0.0 02/06/2015
> [  207.164946] Call Trace:
> [  207.165636]  <TASK>
> [  207.166226]  dump_stack_lvl+0x53/0x70
> [  207.167241]  bad_page+0x70/0x120
> [  207.168131]  free_page_is_bad+0x5f/0x70
> [  207.169193]  free_unref_folios+0x3a5/0x620
> [  207.170320]  ? __mem_cgroup_uncharge_folios+0x7e/0xa0
> [  207.171705]  __split_huge_page+0xb02/0xcf0
> [  207.172839]  ? smp_call_function_many_cond+0x105/0x4b0
> [  207.174250]  ? __pfx_flush_tlb_func+0x10/0x10
> [  207.175410]  ? on_each_cpu_cond_mask+0x29/0x50
> [  207.176603]  split_huge_page_to_list_to_order+0x857/0x9b0
> [  207.178052]  shrink_folio_list+0x4e1/0x1200
> [  207.179198]  evict_folios+0x468/0xab0
> [  207.180202]  try_to_shrink_lruvec+0x1f3/0x280
> [  207.181394]  shrink_lruvec+0x89/0x780
> [  207.182398]  ? mem_cgroup_iter+0x66/0x290
> [  207.183488]  shrink_node+0x243/0xb00
> [  207.184474]  do_try_to_free_pages+0xbd/0x4e0
> [  207.185621]  try_to_free_mem_cgroup_pages+0x107/0x230
> [  207.186994]  try_charge_memcg+0x184/0x5d0
> [  207.188092]  charge_memcg+0x3a/0x60
> [  207.189046]  __mem_cgroup_charge+0x2c/0x80
> [  207.190162]  shmem_alloc_and_add_folio+0x1a3/0x470
> [  207.191469]  shmem_get_folio_gfp+0x24a/0x670
> [  207.192635]  shmem_write_begin+0x56/0xd0
> [  207.193703]  generic_perform_write+0x140/0x330
> [  207.194919]  shmem_file_write_iter+0x89/0x90
> [  207.196082]  vfs_write+0x2f3/0x420
> [  207.197019]  ksys_write+0x5d/0xd0
> [  207.197914]  do_syscall_64+0x47/0x110
> [  207.198915]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  207.200293] RIP: 0033:0x7f2e6099c784
> [  207.201278] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f
> 84 00 00 00 00 00 f3 0f 1e fa 80 3d c5 08 0e 00 00 74 13 b8 01 00 00
> 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 $
> 8 89 e5 48 83 ec 20 48 89
> [  207.206280] RSP: 002b:00007ffdb1a0e7d8 EFLAGS: 00000202 ORIG_RAX:
> 0000000000000001
> [  207.208312] RAX: ffffffffffffffda RBX: 00000000000005e7 RCX: 00007f2e6099c784
> [  207.210225] RDX: 00000000000005e7 RSI: 0000562d23b77000 RDI: 0000000000000004
> [  207.212145] RBP: 00007ffdb1a0e820 R08: 00000000000005e7 R09: 0000000000000007
> [  207.214064] R10: 0000000000000180 R11: 0000000000000202 R12: 0000562d23b77000
> [  207.215974] R13: 0000000000000004 R14: 00000000000005e7 R15: 0000000000000000
> [  207.217888]  </TASK>
> 
> Test is done using ZRAM as SWAP, 1G memcg, and run:
> cd /mnt/tmpfs
> time tar zxf "$linux_src"
> make -j64 clean
> make defconfig
> /usr/bin/time make -j64
> 
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 04ee8abd6475..85a424e954be 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3059,7 +3059,9 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>>         unsigned int new_nr = 1 << new_order;
>>         int order = folio_order(folio);
>>         unsigned int nr = 1 << order;
>> +       struct folio_batch free_folios;
>>
>> +       folio_batch_init(&free_folios);
>>         /* complete memcg works before add pages to LRU */
>>         split_page_memcg(head, order, new_order);
>>
>> @@ -3143,6 +3145,26 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>>                 if (subpage == page)
>>                         continue;
>>                 folio_unlock(new_folio);
>> +               /*
>> +                * If a folio has only two references left, one inherited
>> +                * from the isolation of its head and the other from
>> +                * lru_add_page_tail() which we are about to drop, it means this
>> +                * folio was concurrently zapped. Then we can safely free it
>> +                * and save page reclaim or migration the trouble of trying it.
>> +                */
>> +               if (list && folio_ref_freeze(new_folio, 2)) {
>> +                       VM_WARN_ON_ONCE_FOLIO(folio_test_lru(new_folio), new_folio);
>> +                       VM_WARN_ON_ONCE_FOLIO(folio_test_large(new_folio), new_folio);
>> +                       VM_WARN_ON_ONCE_FOLIO(folio_mapped(new_folio), new_folio);
>> +
>> +                       folio_clear_active(new_folio);
>> +                       folio_clear_unevictable(new_folio);
>> +                       if (!folio_batch_add(&free_folios, folio)) {
>> +                               mem_cgroup_uncharge_folios(&free_folios);
>> +                               free_unref_folios(&free_folios);
>> +                       }
>> +                       continue;
>> +               }
>>
>>                 /*
>>                  * Subpages may be freed if there wasn't any mapping
>> @@ -3153,6 +3175,11 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>>                  */
>>                 free_page_and_swap_cache(subpage);
>>         }
>> +
>> +       if (free_folios.nr) {
>> +               mem_cgroup_uncharge_folios(&free_folios);
>> +               free_unref_folios(&free_folios);
>> +       }
>>  }
>>
>>  /* Racy check whether the huge page can be split */
>> --
>> 2.43.5
>>
>>

