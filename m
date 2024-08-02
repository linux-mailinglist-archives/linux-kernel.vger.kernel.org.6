Return-Path: <linux-kernel+bounces-273084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A714594646C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C031B20D20
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E1249634;
	Fri,  2 Aug 2024 20:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GxAmu+PP"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4371ABEB3
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 20:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722630736; cv=none; b=AOR1he1G/Vbjytq4bUEqxj7qjPnsoLstF7eNgZ7RQDMJn99p7WjXQhXmeTgJn3mRBLEWX1BjO1w2QjmbbpiBz2NDKXnJxi+lIu2XQ5xSZSWWxaX6xVypfMGIU7pdu2VoMnTe8zohFllT/adw8zSVYRvfhvPwuTfELpqSabeD/4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722630736; c=relaxed/simple;
	bh=6m7b7k4S8KWZIyDEYtTqqzHl0D1lSK3y59XxPtdM71k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NgkMZEXt/BsofXxomNawHEwjAZde5tM1w7RrUn9v8wxW4ym1xXvH01GW8iSW3RbMj2LerjOj6I+6B93mH/E0i0xau4+EdapLf9qVIUKDuHAc7wJCTaQo9i4+nLHyo66VFPHeV2jKnw4cAOyj262oY3VvKknC0QafKd1+ngn54SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GxAmu+PP; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so59068a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 13:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722630733; x=1723235533; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9tpvdJVeACeB5qkpDGLZPHMZmPZisvxXSMDixUJOlJA=;
        b=GxAmu+PPFHUOqFi9YlTxwNrZxBfR1l6kLFxPipF/AgMaHns2eSp6VQ09DuZAqgew+f
         dyPCuB4me4C/75uM6eamKU4UvWjNRopKSiE15OVmkYh3EKRdrjiijchCYWy6HsHTgbvS
         Jsu7EzlED/zpurkMxciZfKqhfHggdfMSPxM7I1jYzgHl2Vck+liGMSTAkGAgN0HAxl4X
         GLIHRgH45rYAksn4wkhe+uxDCNmzHnVe24oKZGWJ8i+AqFLLqyDowo2rEh+1n3H5x4No
         WKLsmInlW4fVjpxIUUMTmcAH1R448X3MiRv2JNTszhUzBLtubOpFRtaMqu8FY2NzinTx
         tFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722630733; x=1723235533;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9tpvdJVeACeB5qkpDGLZPHMZmPZisvxXSMDixUJOlJA=;
        b=CX3CkYmOf0NaSw+yZ/exyD0fbDej6BmviWEl72G1cqTu3lwQtIiZzUu6DppQw1YT60
         cl2LIAL2sfou5GOjk2xVmdAS1u8Ua2eLpZ6Iz/yf3ige0Z+gNkWAw4bAUIFMx+ioenwy
         eMLWUpJsXvW1p55Sa5CUM+x4hqxjQNlNEcbSkcjXG44xiRLct8UraL6OTuSsE9Cb+h+H
         YcrV2QWbu1bSO8CR7fON/Ue2ufzMT4ATlvdDISbYQnYaBNnHOGPGumAl1kVOht0kzCCZ
         cOzgkrIOPH3Gz/kTVIpHuDHN5Q3haWdwjf66kUwhRVT0Rm6HO7Won5J3QwUY9HR6+KrS
         th+w==
X-Forwarded-Encrypted: i=1; AJvYcCW/teOZspKjXh9xOdltCMun0NcvT1RKVUdq3CtzdOUdQ8suGMJTEAwRs9wL6vwAEW8ycer84zFjreUayVrf7LpUUkDgvi8gfqYFxxXP
X-Gm-Message-State: AOJu0YwuiQk+VRnE9HuURLCl4YnhUNgtoeRQk8uZ1v6FS1Hjm7D2YqGe
	I89ey3U6RqlMYog9QiRkzinnObfarmi0+98+NCka2fQmHrfniltg+5Kpx0Hv2Q==
X-Google-Smtp-Source: AGHT+IFKezzjniHDzNfK5lWdIyO0mUIv4bFhFicChoUyM/ZhxnkL4BLuHlX8swJTNNcyIPpAo2eTDw==
X-Received: by 2002:a05:6402:2816:b0:58b:b1a0:4a2d with SMTP id 4fb4d7f45d1cf-5b9bebbc4ebmr17961a12.1.1722630732323;
        Fri, 02 Aug 2024 13:32:12 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:9337:bd1:a20d:682d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd26fc0bsm2700267f8f.117.2024.08.02.13.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 13:32:11 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Subject: [PATCH v6 0/2] allow KASAN to detect UAF in SLAB_TYPESAFE_BY_RCU
 slabs
Date: Fri, 02 Aug 2024 22:31:52 +0200
Message-Id: <20240802-kasan-tsbrcu-v6-0-60d86ea78416@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADhCrWYC/2XOTQrCMBCG4atI1kbyn9SV9xAX7TRpg9pIokGR3
 t1UEGq7/Aael3mjZKO3Ce03bxRt9smHoQy13SDo66Gz2LdlI0aYIJpxfK5TPeB7aiI8cKOprCt
 CndYKFXKL1vnnN3c8ld37dA/x9a1nNl1/IfEfygwTLKQzlSFKCGUOXQjdxe4gXNFUynyu5ULzo
 iWFijnjKCV0pcVcVwstJq0tGGmdIaBWWs40Jwstp89Ny6FpHQDIPz2O4wfi2NX6YwEAAA==
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, 
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Marco Elver <elver@google.com>, kasan-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Jann Horn <jannh@google.com>, 
 syzbot+263726e59eab6b442723@syzkaller.appspotmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722630727; l=6723;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=6m7b7k4S8KWZIyDEYtTqqzHl0D1lSK3y59XxPtdM71k=;
 b=ROnheg8tvs64V5aBE3C/N6iTsCrkOSnws3DYdQsxny3FmQBfdmH9iXSA+l0ZCG8iSfWllv24d
 WhfHmS099E8AKLS35y3E0a7JdnTW9eV4R7Oq5fL43NvVgOV2T/6Tl+v
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Hi!

The purpose of the series is to allow KASAN to detect use-after-free
access in SLAB_TYPESAFE_BY_RCU slab caches, by essentially making them
behave as if the cache was not SLAB_TYPESAFE_BY_RCU but instead every
kfree() in the cache was a kfree_rcu().
This is gated behind a config flag that is supposed to only be enabled
in fuzzing/testing builds where the performance impact doesn't matter.

Output of the new kunit testcase I added to the KASAN test suite:
==================================================================
BUG: KASAN: slab-use-after-free in kmem_cache_rcu_uaf+0x3ae/0x4d0
Read of size 1 at addr ffff888106224000 by task kunit_try_catch/224

CPU: 7 PID: 224 Comm: kunit_try_catch Tainted: G    B            N 6.10.0-00003-g065427d4b87f #430
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x53/0x70
 print_report+0xce/0x670
[...]
 kasan_report+0xa5/0xe0
[...]
 kmem_cache_rcu_uaf+0x3ae/0x4d0
[...]
 kunit_try_run_case+0x1b3/0x490
[...]
 kunit_generic_run_threadfn_adapter+0x80/0xe0
 kthread+0x2a5/0x370
[...]
 ret_from_fork+0x34/0x70
[...]
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Allocated by task 224:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 __kasan_slab_alloc+0x6e/0x70
 kmem_cache_alloc_noprof+0xef/0x2b0
 kmem_cache_rcu_uaf+0x10d/0x4d0
 kunit_try_run_case+0x1b3/0x490
 kunit_generic_run_threadfn_adapter+0x80/0xe0
 kthread+0x2a5/0x370
 ret_from_fork+0x34/0x70
 ret_from_fork_asm+0x1a/0x30

Freed by task 0:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x60
 __kasan_slab_free+0x57/0x80
 slab_free_after_rcu_debug+0xe3/0x220
 rcu_core+0x676/0x15b0
 handle_softirqs+0x22f/0x690
 irq_exit_rcu+0x84/0xb0
 sysvec_apic_timer_interrupt+0x6a/0x80
 asm_sysvec_apic_timer_interrupt+0x1a/0x20

Last potentially related work creation:
 kasan_save_stack+0x33/0x60
 __kasan_record_aux_stack+0x8e/0xa0
 kmem_cache_free+0x10c/0x420
 kmem_cache_rcu_uaf+0x16e/0x4d0
 kunit_try_run_case+0x1b3/0x490
 kunit_generic_run_threadfn_adapter+0x80/0xe0
 kthread+0x2a5/0x370
 ret_from_fork+0x34/0x70
 ret_from_fork_asm+0x1a/0x30

The buggy address belongs to the object at ffff888106224000
 which belongs to the cache test_cache of size 200
The buggy address is located 0 bytes inside of
 freed 200-byte region [ffff888106224000, ffff8881062240c8)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x106224
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x200000000000040(head|node=0|zone=2)
page_type: 0xffffefff(slab)
raw: 0200000000000040 ffff88810621c140 dead000000000122 0000000000000000
raw: 0000000000000000 00000000801f001f 00000001ffffefff 0000000000000000
head: 0200000000000040 ffff88810621c140 dead000000000122 0000000000000000
head: 0000000000000000 00000000801f001f 00000001ffffefff 0000000000000000
head: 0200000000000001 ffffea0004188901 ffffffffffffffff 0000000000000000
head: 0000000000000002 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888106223f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888106223f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888106224000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888106224080: fb fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc
 ffff888106224100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
    ok 38 kmem_cache_rcu_uaf

Signed-off-by: Jann Horn <jannh@google.com>
---
Changes in v6:
- in patch 1/2:
  - fix commit message (Andrey)
  - change comments (Andrey)
  - fix mempool handling of kfence objects (Andrey)
- in patch 2/2:
  - fix is_kfence_address argument (syzbot and Marco)
  - refactor slab_free_hook() to create "still_accessible" variable
  - change kasan_slab_free() hook argument to "still_accessible"
  - add documentation to kasan_slab_free() hook
- Link to v5: https://lore.kernel.org/r/20240730-kasan-tsbrcu-v5-0-48d3cbdfccc5@google.com

Changes in v5:
- rebase to latest origin/master (akpm), no other changes from v4
- Link to v4: https://lore.kernel.org/r/20240729-kasan-tsbrcu-v4-0-57ec85ef80c6@google.com

Changes in v4:
- note I kept vbabka's ack for the SLUB changes in patch 1/2 since the
  SLUB part didn't change, even though I refactored a bunch of the
  KASAN parts
- in patch 1/2 (major rework):
  - fix commit message (Andrey)
  - add doc comments in header (Andrey)
  - remove "ip" argument from __kasan_slab_free()
  - rework the whole check_slab_free() thing and move code around (Andrey)
- in patch 2/2:
  - kconfig description and dependency changes (Andrey)
  - remove useless linebreak (Andrey)
  - fix comment style (Andrey)
  - fix do_slab_free() invocation (kernel test robot)
- Link to v3: https://lore.kernel.org/r/20240725-kasan-tsbrcu-v3-0-51c92f8f1101@google.com

Changes in v3:
- in patch 1/2, integrate akpm's fix for !CONFIG_KASAN build failure
- in patch 2/2, as suggested by vbabka, use dynamically allocated
  rcu_head to avoid having to add slab metadata
- in patch 2/2, add a warning in the kconfig help text that objects can
  be recycled immediately under memory pressure
- Link to v2: https://lore.kernel.org/r/20240724-kasan-tsbrcu-v2-0-45f898064468@google.com

Changes in v2:
Patch 1/2 is new; it's some necessary prep work for the main patch to
work, though the KASAN integration maybe is a bit ugly.
Patch 2/2 is a rebased version of the old patch, with some changes to
how the config is wired up, with poison/unpoison logic added as
suggested by dvyukov@ back then, with cache destruction fixed using
rcu_barrier() as pointed out by dvyukov@ and the test robot, and a test
added as suggested by elver@.

---
Jann Horn (2):
      kasan: catch invalid free before SLUB reinitializes the object
      slub: Introduce CONFIG_SLUB_RCU_DEBUG

 include/linux/kasan.h | 63 ++++++++++++++++++++++++++++++++++---
 mm/Kconfig.debug      | 30 ++++++++++++++++++
 mm/kasan/common.c     | 62 ++++++++++++++++++++++---------------
 mm/kasan/kasan_test.c | 46 +++++++++++++++++++++++++++
 mm/slab_common.c      | 12 +++++++
 mm/slub.c             | 86 ++++++++++++++++++++++++++++++++++++++++++++++-----
 6 files changed, 261 insertions(+), 38 deletions(-)
---
base-commit: 94ede2a3e9135764736221c080ac7c0ad993dc2d
change-id: 20240723-kasan-tsbrcu-b715a901f776
-- 
Jann Horn <jannh@google.com>


