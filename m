Return-Path: <linux-kernel+bounces-288460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD87953A58
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC8F2861C8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B081F47F6B;
	Thu, 15 Aug 2024 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZ7VH2gN"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB6C38382;
	Thu, 15 Aug 2024 18:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723747669; cv=none; b=rveyPO2AxZ9e75LST7/xiPL/P/rtugM4MzGNSDeujp77p99Mry10FIpZqyvVhDMyV4nhH9dVRgt8L9gS/fcTHSkEj3rU1lp4H+mmm15NxzR53WkQReg9Tl1NfXUu2Iyf5bRav92pJu/lquXvYEREU16S/CeITdqF6MfceLpU2R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723747669; c=relaxed/simple;
	bh=lidfUTxK6Bza1AGntqg6Za5roAfvlqZZ0qfEv6eQQR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEFMxCAc1GUE13QXx5kgXHUMySAQr6IBhynMPD+kaTtfD9ASMQgOxlr2Wtpup0U/XY5BfUsnCWHT7OTtdPovHXqV0waEpHl6UOOlNt1V0xaIYMFIQgB9UmxSThLZMi9L1tzYsnIQxcZxycAAjkWc3JBDmR0i6yiqwYlZHqjuS9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZ7VH2gN; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ef7fef3ccfso14263141fa.3;
        Thu, 15 Aug 2024 11:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723747666; x=1724352466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=000/N2rfsity7gtDbLUmE3L8eRNpnAUmpQF4kSO37nM=;
        b=OZ7VH2gNHWUPjJQ2zE4W6MQJMLLghF5xRY8eTxhN0OTke/4Sb9bN/dqOa00ek1Pzy6
         ZIlz3LZOZBzwIB831nflGTrdQ6kATt4x9oFoS4PCn7wl4ZJOX6SNmuttAJXoDjaeQo9W
         USgUociWwbt/P/DkMO02XUnetFVDTSqnUYfkuVzm6wd5NGbXHzNTF55aN3yIzX5BiuEe
         ax2CS6hni1GN3eb2okLy0VI8LokZE5+OwVqE/UB/EA0KGJum4eXZbFrQ/dqV4kPDr92j
         EpjWuKCuGi+rUNbAyt/uyHCvVIQH4oECcv83MJM4NNuOi/t26G7m45Q3tmGJqPj8j+8i
         flvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723747666; x=1724352466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=000/N2rfsity7gtDbLUmE3L8eRNpnAUmpQF4kSO37nM=;
        b=GBnz0KRP0rx1DFKz/cKp04rzdS0KuJ/AZnqxVYg7mJL8xBBLzlrV6k4OowwNXzs4n+
         aSEbwQf8pTbGQHK9Bn4tIsKTd7PG+LTi99R6rSMs0IE5S01V0np67VegP4Mvkg2sTkSr
         kmNfCKMNg+3qUXpe0Ldk0RehmyZsrkmVYoH6fEHF4BIx+RILgQRZqpEZdBYmmvQ0XwI4
         9BMb7LoaftJMKN6SAB+IpJJJ0/OBNSH7AHZP+uRMEP0G76JRm58Jdf6RbO+8zReto6kO
         qdBt9p5DpU5UB+u0aaZlIWcUzEhX3tv2EEZsCMhyZnuH1LA7odj3oT6X/onucPEpBYt6
         7VHA==
X-Forwarded-Encrypted: i=1; AJvYcCXGBow4musIKudm3XHqaKX2hWM2MNHtbEBz9n6fokr98vhFCBGGC66AqAcsxEjozwbAEKuTfG7zRzAdCqDeK3j+gl/XTe9pULQ2Y+xVD3CKdHWNzEg9NxSDXUjWX4ehrx3Rvra2qSze
X-Gm-Message-State: AOJu0YyTwABUb0W5NAlxuoN7E8t26fYQBRMsvFtuhOTa/c/jQJJTfOrb
	p0ee7B9nDQPWWG+iE5z7sGOB3kddC10JFx3z2/PxlPpZ8PxK8h/VDro2wsxHmkryczQaE5fyOcH
	pXZ+LErOasAMjdXwoz2hVSOk/Lyg=
X-Google-Smtp-Source: AGHT+IHpd/ooZF4JGJ3IX1yrgySP7VyhGDXtZy/A0T8RkWktaSGfQ8BBDm01aePCmQ5pb9N6/YD07coiAmrNi7gs+pQ=
X-Received: by 2002:a2e:741:0:b0:2ef:22e6:234b with SMTP id
 38308e7fff4ca-2f3be5a6a70mr2921151fa.26.1723747665566; Thu, 15 Aug 2024
 11:47:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813120328.1275952-1-usamaarif642@gmail.com> <20240813120328.1275952-2-usamaarif642@gmail.com>
In-Reply-To: <20240813120328.1275952-2-usamaarif642@gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 16 Aug 2024 02:47:29 +0800
Message-ID: <CAMgjq7DhdSXMHPLa3AHgAtcRN0A7pemTFFd1h19w4H_qyUMZMQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] mm: free zapped tail pages when splitting isolated thp
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev, 
	yuzhao@google.com, david@redhat.com, baohua@kernel.org, ryan.roberts@arm.com, 
	rppt@kernel.org, willy@infradead.org, cerasuolodomenico@gmail.com, 
	corbet@lwn.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kernel-team@meta.com, Shuang Zhai <zhais@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 8:03=E2=80=AFPM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
> From: Yu Zhao <yuzhao@google.com>
>
> If a tail page has only two references left, one inherited from the
> isolation of its head and the other from lru_add_page_tail() which we
> are about to drop, it means this tail page was concurrently zapped.
> Then we can safely free it and save page reclaim or migration the
> trouble of trying it.
>
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Tested-by: Shuang Zhai <zhais@google.com>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/huge_memory.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)

Hi, Usama, Yu

This commit is causing the kernel to panic very quickly with build
kernel test on top of tmpfs with all mTHP enabled, the panic comes
after:

[  207.147705] BUG: Bad page state in process tar  pfn:14ae70
[  207.149376] page: refcount:3 mapcount:2 mapping:0000000000000000
index:0x562d23b70 pfn:0x14ae70
[  207.151750] flags:
0x17ffffc0020019(locked|uptodate|dirty|swapbacked|node=3D0|zone=3D2|lastcpu=
pid=3D0x1fffff)
[  207.154325] raw: 0017ffffc0020019 dead000000000100 dead000000000122
0000000000000000
[  207.156442] raw: 0000000562d23b70 0000000000000000 0000000300000001
0000000000000000
[  207.158561] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
[  207.160325] Modules linked in:
[  207.161194] CPU: 22 UID: 0 PID: 2650 Comm: tar Not tainted
6.11.0-rc3.ptch+ #136
[  207.163198] Hardware name: Red Hat KVM/RHEL-AV, BIOS 0.0.0 02/06/2015
[  207.164946] Call Trace:
[  207.165636]  <TASK>
[  207.166226]  dump_stack_lvl+0x53/0x70
[  207.167241]  bad_page+0x70/0x120
[  207.168131]  free_page_is_bad+0x5f/0x70
[  207.169193]  free_unref_folios+0x3a5/0x620
[  207.170320]  ? __mem_cgroup_uncharge_folios+0x7e/0xa0
[  207.171705]  __split_huge_page+0xb02/0xcf0
[  207.172839]  ? smp_call_function_many_cond+0x105/0x4b0
[  207.174250]  ? __pfx_flush_tlb_func+0x10/0x10
[  207.175410]  ? on_each_cpu_cond_mask+0x29/0x50
[  207.176603]  split_huge_page_to_list_to_order+0x857/0x9b0
[  207.178052]  shrink_folio_list+0x4e1/0x1200
[  207.179198]  evict_folios+0x468/0xab0
[  207.180202]  try_to_shrink_lruvec+0x1f3/0x280
[  207.181394]  shrink_lruvec+0x89/0x780
[  207.182398]  ? mem_cgroup_iter+0x66/0x290
[  207.183488]  shrink_node+0x243/0xb00
[  207.184474]  do_try_to_free_pages+0xbd/0x4e0
[  207.185621]  try_to_free_mem_cgroup_pages+0x107/0x230
[  207.186994]  try_charge_memcg+0x184/0x5d0
[  207.188092]  charge_memcg+0x3a/0x60
[  207.189046]  __mem_cgroup_charge+0x2c/0x80
[  207.190162]  shmem_alloc_and_add_folio+0x1a3/0x470
[  207.191469]  shmem_get_folio_gfp+0x24a/0x670
[  207.192635]  shmem_write_begin+0x56/0xd0
[  207.193703]  generic_perform_write+0x140/0x330
[  207.194919]  shmem_file_write_iter+0x89/0x90
[  207.196082]  vfs_write+0x2f3/0x420
[  207.197019]  ksys_write+0x5d/0xd0
[  207.197914]  do_syscall_64+0x47/0x110
[  207.198915]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  207.200293] RIP: 0033:0x7f2e6099c784
[  207.201278] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f
84 00 00 00 00 00 f3 0f 1e fa 80 3d c5 08 0e 00 00 74 13 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 $
8 89 e5 48 83 ec 20 48 89
[  207.206280] RSP: 002b:00007ffdb1a0e7d8 EFLAGS: 00000202 ORIG_RAX:
0000000000000001
[  207.208312] RAX: ffffffffffffffda RBX: 00000000000005e7 RCX: 00007f2e609=
9c784
[  207.210225] RDX: 00000000000005e7 RSI: 0000562d23b77000 RDI: 00000000000=
00004
[  207.212145] RBP: 00007ffdb1a0e820 R08: 00000000000005e7 R09: 00000000000=
00007
[  207.214064] R10: 0000000000000180 R11: 0000000000000202 R12: 0000562d23b=
77000
[  207.215974] R13: 0000000000000004 R14: 00000000000005e7 R15: 00000000000=
00000
[  207.217888]  </TASK>

Test is done using ZRAM as SWAP, 1G memcg, and run:
cd /mnt/tmpfs
time tar zxf "$linux_src"
make -j64 clean
make defconfig
/usr/bin/time make -j64

>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 04ee8abd6475..85a424e954be 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3059,7 +3059,9 @@ static void __split_huge_page(struct page *page, st=
ruct list_head *list,
>         unsigned int new_nr =3D 1 << new_order;
>         int order =3D folio_order(folio);
>         unsigned int nr =3D 1 << order;
> +       struct folio_batch free_folios;
>
> +       folio_batch_init(&free_folios);
>         /* complete memcg works before add pages to LRU */
>         split_page_memcg(head, order, new_order);
>
> @@ -3143,6 +3145,26 @@ static void __split_huge_page(struct page *page, s=
truct list_head *list,
>                 if (subpage =3D=3D page)
>                         continue;
>                 folio_unlock(new_folio);
> +               /*
> +                * If a folio has only two references left, one inherited
> +                * from the isolation of its head and the other from
> +                * lru_add_page_tail() which we are about to drop, it mea=
ns this
> +                * folio was concurrently zapped. Then we can safely free=
 it
> +                * and save page reclaim or migration the trouble of tryi=
ng it.
> +                */
> +               if (list && folio_ref_freeze(new_folio, 2)) {
> +                       VM_WARN_ON_ONCE_FOLIO(folio_test_lru(new_folio), =
new_folio);
> +                       VM_WARN_ON_ONCE_FOLIO(folio_test_large(new_folio)=
, new_folio);
> +                       VM_WARN_ON_ONCE_FOLIO(folio_mapped(new_folio), ne=
w_folio);
> +
> +                       folio_clear_active(new_folio);
> +                       folio_clear_unevictable(new_folio);
> +                       if (!folio_batch_add(&free_folios, folio)) {
> +                               mem_cgroup_uncharge_folios(&free_folios);
> +                               free_unref_folios(&free_folios);
> +                       }
> +                       continue;
> +               }
>
>                 /*
>                  * Subpages may be freed if there wasn't any mapping
> @@ -3153,6 +3175,11 @@ static void __split_huge_page(struct page *page, s=
truct list_head *list,
>                  */
>                 free_page_and_swap_cache(subpage);
>         }
> +
> +       if (free_folios.nr) {
> +               mem_cgroup_uncharge_folios(&free_folios);
> +               free_unref_folios(&free_folios);
> +       }
>  }
>
>  /* Racy check whether the huge page can be split */
> --
> 2.43.5
>
>

