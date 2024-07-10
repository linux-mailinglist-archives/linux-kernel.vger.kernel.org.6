Return-Path: <linux-kernel+bounces-248092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D07E492D84F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE301F2210D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6319C195FD1;
	Wed, 10 Jul 2024 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElRW+xY8"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FBC193077
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720636427; cv=none; b=CmoMZBy7aV5TlPobQ9+DLx+tah1md4Jw1BAJpX9o5+85oBAls4JgVLmnrtDoUnqvPsmATqEY5NEzLW0Yz/0QrFLB62fCDU8HfqXMpPrtkWsGurxsjXd9aNdkP+y/sPshqeo94qN+ErOABJYwFGrjiLrV2bRa38dme5GGl5IeKpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720636427; c=relaxed/simple;
	bh=lkasPtTh9HGKdKxvarNgcKgzY5fQ24ibjERKSiiRS7A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pYKQG6Lox/Vwt3Kk9ghrIKN76tXHg02Li8OrKmIww2oOAtjDRhHw3zyJFH/ZrF/336BgOMNzkr6f64cTaaURL/s97wzpoIZPbgu4s5rQwUD+qpmtEGOwSSH6F5rTH2M7aL87JefwnfgYKk/ewRZcs8WoOit3tpMjePLfEGeoNLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElRW+xY8; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52ea3e499b1so88505e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 11:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720636423; x=1721241223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sw9JFlakTr1jOInAfo+sjtfSDDufqiWatwOyro27bds=;
        b=ElRW+xY8ra+9JGBaHiUqmrftdDVwktzuu4h1HF/zwY1ayxl76egl8HBRO4SvDXfL6y
         RYFBAkTIZiZxP4c+RAQHitV1XG0meLNFPBsx+f3jGiCYTpSn07OVlV3vQB3EmerSzqWa
         KKOGpoQuswFVzFq/s5ryugoOqewVHfl47lHMHwKw8y4+t2UfyZC7tHeDHZbTuAih31kf
         2PxEtePdn7w4W+KSEO9P1QoY+rP6gDgolYLRvPgVF7sOFP3hcCFexZ5vTQEpUkR8UZXB
         dd6RkCfVgANiC9onzXcZDYPN0GzW2NUVeIdXwOCp0bISMpGfjmdAxE30y95sIm4wjXW3
         Oa4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720636423; x=1721241223;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sw9JFlakTr1jOInAfo+sjtfSDDufqiWatwOyro27bds=;
        b=GbOvZ+EJel4t6Shfd1ei9wpGLFt3JPrw/Sm7XCy2CTWlCP6CinSv6VquGYCgpa3hAa
         lW9cRl91Qc1fmL1PPjCMX58IzagRUehv6iX/5j5hCoBmWBZoV9TtRmb6x/sF79mJt8Ly
         q/2GK7zR2KpxvqERzl6WDC/VHWfFcFl5RXNr8bEgPz1HNPKoyzkYg3d53c8OF0pYWpAh
         92cLZC1bfyHliJyikRMm7SEKS1GDx19hy2YKDfFdSH+exR2XTI9sIwI1IPdsUDsdhTrM
         Jeu19a0+WSnNzHVm8rmGKjThodWDYUYVI7a5q83KYJ/uEhDk+dTnVhw7l+kLHzHXqxEu
         aIJw==
X-Forwarded-Encrypted: i=1; AJvYcCX+H+mJCfhdIUd5xZWOMAG8zG/rT+6r9885SZMifz5CxtA/pZdAu3O3mPP+wesvSR6iPa44m2aCImPISdp+bXc2HDhIZEF5xhh5dXb0
X-Gm-Message-State: AOJu0Yx1sVr2dsHNgxlJBOapXlUAltqLb3BVL1AfjYBjVdsuC0ng+MGX
	FORfzEBd8yLyP0v3IRMxf7j578/lzKTvik8bWeYSiJdh0XEeBM0H
X-Google-Smtp-Source: AGHT+IELVOkR9/vv5CFoQGsT0N9HdTri9TRkiBwjhA9ewit1ps4DNJEuFhWFwFTZd7PfdAXfLiUMzg==
X-Received: by 2002:a05:6512:2349:b0:52e:6d71:e8f1 with SMTP id 2adb3069b0e04-52eb99d20f1mr4683386e87.53.1720636423009;
        Wed, 10 Jul 2024 11:33:43 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:b211:ad00:1490:6cc2:4d06:940f? ([2a01:4b00:b211:ad00:1490:6cc2:4d06:940f])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52eb8e4932dsm743456e87.91.2024.07.10.11.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 11:33:42 -0700 (PDT)
Message-ID: <4bc6400e-6199-4147-9399-4a54c94613fd@gmail.com>
Date: Wed, 10 Jul 2024 19:33:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [mm] 47325a5c88:
 WARNING:at_mm/slub.c:#free_large_kmalloc
From: Usama Arif <usamaarif642@gmail.com>
To: kernel test robot <oliver.sang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
 Linux Memory Management List <linux-mm@kvack.org>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
 David Hildenbrand <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>,
 Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Andi Kleen <ak@linux.intel.com>,
 linux-kernel@vger.kernel.org, ltp@lists.linux.it
References: <202407101031.c6c3c651-lkp@intel.com>
 <dd08adbb-6df5-4556-9fc4-cf37b6234aa1@gmail.com>
 <053bd429-ae19-4beb-a733-a7a838b1e010@gmail.com>
Content-Language: en-US
In-Reply-To: <053bd429-ae19-4beb-a733-a7a838b1e010@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/07/2024 19:46, Usama Arif wrote:
> 
> 
> On 10/07/2024 13:29, Usama Arif wrote:
>>
>>
>> On 10/07/2024 05:51, kernel test robot wrote:
>>>
>>>
>>> Hello,
>>>
>>> kernel test robot noticed "WARNING:at_mm/slub.c:#free_large_kmalloc" on:
>>>
>>> commit: 47325a5c88c5ee373c973e47c27c7dadcfe88a32 ("mm-store-zero-pages-to-be-swapped-out-in-a-bitmap-v8")
>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>>
>>> [test failed on linux-next/master 82d01fe6ee52086035b201cfa1410a3b04384257]
>>>
>>> in testcase: ltp
>>> version: ltp-x86_64-14c1f76-1_20240706
>>> with following parameters:
>>>
>>> 	test: commands
>>>
>>>
>>>
>>> compiler: gcc-13
>>> test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz (Ivy Bridge) with 16G memory
>>>
>>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>>>
>>>
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>>> | Closes: https://lore.kernel.org/oe-lkp/202407101031.c6c3c651-lkp@intel.com
>>>
>>>
>>> The kernel config and materials to reproduce are available at:
>>> https://download.01.org/0day-ci/archive/20240710/202407101031.c6c3c651-lkp@intel.com
>>>
>>>
>>>
>>> kern  :warn  : [  455.633948] Swap area shorter than signature indicates
>>> kern  :warn  : [  455.634133] ------------[ cut here ]------------
>>> kern  :warn  : [  455.634268] WARNING: CPU: 3 PID: 8129 at mm/slub.c:4538 free_large_kmalloc+0x93/0xe0
>>> kern  :warn  : [  455.635173] Modules linked in: msdos minix vfat fat xfs ext2 netconsole btrfs blake2b_generic xor zstd_compress raid6_pq libcrc32c intel_rapl_msr intel_rapl_common sd_mod x86_pkg_temp_thermal t10_pi intel_powerclamp coretemp crc64_rocksoft_generic crc64_rocksoft crc64 kvm_intel sg ipmi_devintf ipmi_msghandler i915 kvm crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 drm_buddy intel_gtt firewire_ohci rapl mxm_wmi intel_cstate drm_display_helper firewire_core ahci libahci crc_itu_t i2c_i801 intel_uncore ttm libata drm_kms_helper i2c_smbus lpc_ich video wmi binfmt_misc drm loop fuse dm_mod ip_tables
>>> kern  :warn  : [  455.636742] CPU: 3 PID: 8129 Comm: swapon Not tainted 6.10.0-rc6-00357-g47325a5c88c5 #1
>>> kern  :warn  : [  455.636935] Hardware name:  /DZ77BH-55K, BIOS BHZ7710H.86A.0097.2012.1228.1346 12/28/2012
>>> kern  :warn  : [  455.637127] RIP: 0010:free_large_kmalloc+0x93/0xe0
>>> kern  :warn  : [  455.637267] Code: 00 41 f7 c4 00 02 00 00 74 01 fb f0 ff 4b 34 74 0b 5b 5d 41 5c 41 5d c3 cc cc cc cc 48 89 df 5b 5d 41 5c 41 5d e9 8d 3f eb ff <0f> 0b 80 3d 14 d8 06 04 00 74 1c 48 89 ef e8 ea b0 1d 02 48 8b 74
>>> kern  :warn  : [  455.637951] RSP: 0018:ffffc9000247fdd8 EFLAGS: 00010246
>>> kern  :warn  : [  455.638098] RAX: 0017ffffc0000000 RBX: ffffea00055cf900 RCX: 0000000000000000
>>> kern  :warn  : [  455.638273] RDX: ffffea0005bb6508 RSI: ffff8881573e4000 RDI: ffffea00055cf900
>>> kern  :warn  : [  455.638505] RBP: ffff8881573e4000 R08: 0000000000000001 R09: fffff5200048ffb5
>>> kern  :warn  : [  455.638679] R10: 0000000000000003 R11: 0000000000000001 R12: ffff8881ee6b2c28
>>> kern  :warn  : [  455.638853] R13: ffff8881393c7890 R14: 00000000ffffffea R15: ffff8881393c7800
>>> kern  :warn  : [  455.639028] FS:  00007fa00e70c840(0000) GS:ffff88833c580000(0000) knlGS:0000000000000000
>>> kern  :warn  : [  455.639218] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> kern  :warn  : [  455.639424] CR2: 00005624b13e8000 CR3: 00000003df01e002 CR4: 00000000001706f0
>>> kern  :warn  : [  455.639600] Call Trace:
>>> kern  :warn  : [  455.639695]  <TASK>
>>> kern  :warn  : [  455.639787]  ? __warn+0xcc/0x260
>>> kern  :warn  : [  455.639900]  ? free_large_kmalloc+0x93/0xe0
>>> kern  :warn  : [  455.640025]  ? report_bug+0x261/0x2c0
>>> kern  :warn  : [  455.640141]  ? handle_bug+0x6d/0x90
>>> kern  :warn  : [  455.640254]  ? exc_invalid_op+0x17/0x40
>>> kern  :warn  : [  455.640428]  ? asm_exc_invalid_op+0x1a/0x20
>>> kern  :warn  : [  455.640555]  ? free_large_kmalloc+0x93/0xe0
>>> kern  :warn  : [  455.640679]  __do_sys_swapon+0xaf3/0x1ea0
>>> kern  :warn  : [  455.640806]  ? poison_slab_object+0xc5/0x170
>>> kern  :warn  : [  455.640934]  ? __pfx___do_sys_swapon+0x10/0x10
>>> kern  :warn  : [  455.641063]  ? __x64_sys_close+0x7c/0xd0
>>> kern  :warn  : [  455.641184]  ? kmem_cache_free+0xd5/0x3e0
>>> kern  :warn  : [  455.641307]  do_syscall_64+0x5f/0x170
>>> kern  :warn  : [  455.641489]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>> kern  :warn  : [  455.641629] RIP: 0033:0x7fa00e8d7f97
>>> kern  :warn  : [  455.641746] Code: 73 01 c3 48 8b 0d 69 2e 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a7 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 2e 0d 00 f7 d8 64 89 01 48
>>> kern  :warn  : [  455.642117] RSP: 002b:00007ffc063cb6e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a7
>>> kern  :warn  : [  455.642302] RAX: ffffffffffffffda RBX: 00005624b13d89a0 RCX: 00007fa00e8d7f97
>>> kern  :warn  : [  455.642535] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00005624b13d89a0
>>> kern  :warn  : [  455.642709] RBP: 0000000000000000 R08: 0000000000000ff6 R09: 0000000000001000
>>> kern  :warn  : [  455.642882] R10: 4e45505355533253 R11: 0000000000000246 R12: 00007ffc063cb91c
>>> kern  :warn  : [  455.643056] R13: 00000000ffffffff R14: 0000000012c00000 R15: 00005624b13d95d0
>>> kern  :warn  : [  455.643231]  </TASK>
>>> kern  :warn  : [  455.643321] ---[ end trace 0000000000000000 ]---
>>> kern  :warn  : [  455.643507] object pointer: 0x000000003fde23f4
>>> kern  :err   : [  455.643635] ==================================================================
>>> kern  :err   : [  455.643807] BUG: KASAN: double-free in __do_sys_swapon+0xaf3/0x1ea0
>>> kern  :err   : [  455.643978] Free of addr ffff8881573e4000 by task swapon/8129
>>>
>>> kern  :err   : [  455.644198] CPU: 3 PID: 8129 Comm: swapon Tainted: G        W          6.10.0-rc6-00357-g47325a5c88c5 #1
>>> kern  :err   : [  455.644406] Hardware name:  /DZ77BH-55K, BIOS BHZ7710H.86A.0097.2012.1228.1346 12/28/2012
>>> kern  :err   : [  455.644590] Call Trace:
>>> kern  :err   : [  455.644681]  <TASK>
>>> kern  :err   : [  455.644768]  dump_stack_lvl+0x53/0x70
>>> kern  :err   : [  455.644883]  print_address_description+0x30/0x410
>>> kern  :err   : [  455.645033]  ? __do_sys_swapon+0xaf3/0x1ea0
>>> kern  :err   : [  455.645158]  print_report+0xb9/0x2b0
>>> kern  :err   : [  455.645275]  ? __do_sys_swapon+0xaf3/0x1ea0
>>> kern  :err   : [  455.645397]  ? kasan_addr_to_slab+0xd/0xb0
>>> kern  :err   : [  455.645516]  ? __do_sys_swapon+0xaf3/0x1ea0
>>> kern  :err   : [  455.645639]  kasan_report_invalid_free+0x94/0xc0
>>> kern  :err   : [  455.645769]  ? __do_sys_swapon+0xaf3/0x1ea0
>>> kern  :err   : [  455.645891]  free_large_kmalloc+0xb8/0xe0
>>> kern  :err   : [  455.646010]  __do_sys_swapon+0xaf3/0x1ea0
>>> kern  :err   : [  455.646130]  ? poison_slab_object+0xc5/0x170
>>> kern  :err   : [  455.646254]  ? __pfx___do_sys_swapon+0x10/0x10
>>> kern  :err   : [  455.646379]  ? __x64_sys_close+0x7c/0xd0
>>> kern  :err   : [  455.646498]  ? kmem_cache_free+0xd5/0x3e0
>>> kern  :err   : [  455.646619]  do_syscall_64+0x5f/0x170
>>> kern  :err   : [  455.646735]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>> kern  :err   : [  455.646871] RIP: 0033:0x7fa00e8d7f97
>>> kern  :err   : [  455.646985] Code: 73 01 c3 48 8b 0d 69 2e 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a7 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 2e 0d 00 f7 d8 64 89 01 48
>>> kern  :err   : [  455.647343] RSP: 002b:00007ffc063cb6e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a7
>>> kern  :err   : [  455.647521] RAX: ffffffffffffffda RBX: 00005624b13d89a0 RCX: 00007fa00e8d7f97
>>> kern  :err   : [  455.647692] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00005624b13d89a0
>>> kern  :err   : [  455.647863] RBP: 0000000000000000 R08: 0000000000000ff6 R09: 0000000000001000
>>> kern  :err   : [  455.648036] R10: 4e45505355533253 R11: 0000000000000246 R12: 00007ffc063cb91c
>>> kern  :err   : [  455.648208] R13: 00000000ffffffff R14: 0000000012c00000 R15: 00005624b13d95d0
>>> kern  :err   : [  455.648387]  </TASK>
>>>
>>> kern  :err   : [  455.648549] The buggy address belongs to the physical page:
>>> kern  :warn  : [  455.648692] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8881573e5b30 pfn:0x1573e4
>>> kern  :warn  : [  455.648902] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
>>> kern  :warn  : [  455.649065] raw: 0017ffffc0000000 ffffea0005bb6508 ffff88833c7cb600 0000000000000000
>>> kern  :warn  : [  455.649249] raw: ffff8881573e5b30 0000000000000000 00000000ffffffff 0000000000000000
>>> kern  :warn  : [  455.649430] page dumped because: kasan: bad access detected
>>>
>>> kern  :err   : [  455.649647] Memory state around the buggy address:
>>> kern  :err   : [  455.649777]  ffff8881573e3f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>> kern  :err   : [  455.649945]  ffff8881573e3f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>> kern  :err   : [  455.650115] >ffff8881573e4000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>> kern  :err   : [  455.650286]                    ^
>>> kern  :err   : [  455.650392]  ffff8881573e4080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>> kern  :err   : [  455.650563]  ffff8881573e4100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>> kern  :err   : [  455.650733] ==================================================================
>>> kern  :warn  : [  455.650954] Disabling lock debugging due to kernel taint
>>> user  :notice: [  455.655806] mkswap01 3 TINFO: Can not do swapon on /dev/loop0.
>>>
>>>
>>>
>>
>>
>> I believe the below diff should solve the warning and double-free. Could this be folded into the patch?
>>
> 
> Eventhough not needed, good to set it to NULL in swapoff as well. Next patch has been tested with the LKP test that gives the warning. Thanks.
> 
> 


Johannes pointed out that we can just keep it simple and set it to NULL after kvfree(p->zeromap). This would be the patch with proper commit message and kernel test robot tags:

commit 63f8e7aae47042d14a24f14997ae916df7433358 (HEAD)
Author: Usama Arif <usamaarif642@gmail.com>
Date:   Wed Jul 10 18:37:57 2024 +0100

    mm: set p->zeromap to NULL after freeing it
    
    alloc_swap_info can reuse swap_info_struct from previously
    used swap. Reset p->zeromap to NULL so that its not set to
    a corrupted pointer from previous swap.
    
    Reported-by: kernel test robot <oliver.sang@intel.com>
    Closes: https://lore.kernel.org/oe-lkp/202407101031.c6c3c651-lkp@intel.com
    Signed-off-by: Usama Arif <usamaarif642@gmail.com>

diff --git a/mm/swapfile.c b/mm/swapfile.c
index e263511dbb6e..1ee83fcf66ee 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2654,6 +2654,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
        p->cluster_next_cpu = NULL;
        vfree(swap_map);
        kvfree(p->zeromap);
+       p->zeromap = NULL;
        kvfree(cluster_info);
        /* Destroy swap account information */
        swap_cgroup_swapoff(p->type);
@@ -3346,6 +3347,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
        spin_unlock(&swap_lock);
        vfree(swap_map);
        kvfree(p->zeromap);
+       p->zeromap = NULL;
        kvfree(cluster_info);
        if (inced_nr_rotate_swap)
                atomic_dec(&nr_rotate_swap);

