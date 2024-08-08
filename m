Return-Path: <linux-kernel+bounces-279997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A161B94C458
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA3F1F26773
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE690146A60;
	Thu,  8 Aug 2024 18:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jZ5uc/TA"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68F29479
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723141870; cv=none; b=gjktHlb72G/FWX6Nen63irWq1o4yCZNVgD3LEmFQMjU/lnL07JKOMmK7wEkwnS4/lyEvERojVD/UKEEXcnR105Vgwn4GcWfGhpqDUVndgIuan99HHnfxL9LR+vFnSQvMryBNh0RqZ3Ufm/UaD4ZbVcqZ92q36s5iXe6/vmWuz1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723141870; c=relaxed/simple;
	bh=ifhhMKUq3wZYmlKPhfOQuDlC/AkSNxHfHxamMzAf6II=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Gj5laUL9XNPGK5voDkOo+bEtkT4xmzRvYZMFQGHvktxYeXNFlLoCGQ0Cu862e7yPZ6fL6/CDyGW/T1hVJeV3DdExKvoeEcGz7NZcc4emWVObv+7NLRuGIG0vfFz8wMmQwCm1k8/YVlYxNU3SIUd6SbERj4SGrEo7rZE+FZ1mh+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jZ5uc/TA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42807cb6afdso1745e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 11:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723141867; x=1723746667; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DLW6erLEdD1RJkfioQR08NW01BP8YceiCQUjS50VurI=;
        b=jZ5uc/TAlL8Mf/vAVXTeMYg3FPfpCDzMbuJfoycWXttG631VMzpeoNGTJvDIAI98Jn
         3naSVV1gwr7A0Ec0eCjXxTcYXpXvAny4/RF482OddSicZeAkecaZELf8x4y5YvMqpBQU
         cJ0uXGJPYWn42ziTsMtf6y6yIZO8sjoQFz2p/h3gKgkTOpbQP+di1YX2GvmpYPlawM5K
         +IjcSIot4sz9PQ4SR7hdAcYzPZFJbV5mzMtKAFa+pY5v9QMroh3kG3CG11WRZVXDenTP
         sjx9772yHukNRkWOcECzkpAK5IRWFOlNzP+v9WF/AbU5InIHGCDB/VnhFJrSCnUNHf3Z
         1AlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723141867; x=1723746667;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DLW6erLEdD1RJkfioQR08NW01BP8YceiCQUjS50VurI=;
        b=pJqSuo0CaCAkxyDAKnl3mZw00K4Nkgie7u4fukj13fIRNeDOTVniolvgC9tOgil5ua
         lduOqCOP2QhGZyGQ0KfAlLqlPl9q+u6h4KNtmFUJq+kH/ijaRyfqcJ6bcXc72KgZouI8
         25zxVWQt01osJPq1em2dCRJPiX9WGMKG2y584jn/eEeML3TZpo8roRpZ1XbMEYDcGAA5
         qXApL6vFUkHW7hnsn8olUj4U/rLJrfchRcnWIabDR58NW60SNle6quvMY2AHDubkiYxm
         laa0roTEzVpXm75BCPuQ9JCJ5YBILEyiX1Jy3SSXy1Z5bINowFE0rvM1kbsiOmMuLIcV
         Bweg==
X-Forwarded-Encrypted: i=1; AJvYcCWbOx9lkbDh6lADbEe32M5Rv2sieT/9PqDzrWXOXh9UEUI2/nssupYfhRq+RYrOM8k6Rz7fw9Qy6OVf7Dx06gkBNFCJ0nL5Dv78WIs0
X-Gm-Message-State: AOJu0YwBt/bkORgkuqWDg5tkd5H6cKoVdxLyrtu34rZsOauZa7K5E3Xt
	2U0U5Y7QoRNagLj0tKSw8gql0N3GjZ6CH+FW00wRXsNQ0SWG6+4iDlIOs4fgig==
X-Google-Smtp-Source: AGHT+IEes4I4p3Fnb4Injx44lWLQVTr1WKKg+sngYdrFL/lTimO2lDONHMBTA/ilsUgj8WAiaMWvLg==
X-Received: by 2002:a05:600c:1e16:b0:428:31c:5a42 with SMTP id 5b1f17b1804b1-429c17bb78fmr111085e9.3.1723141866523;
        Thu, 08 Aug 2024 11:31:06 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:fc0e:258b:99ae:88ba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c79f345sm34845495e9.39.2024.08.08.11.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 11:31:05 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Subject: [PATCH v7 0/2] allow KASAN to detect UAF in SLAB_TYPESAFE_BY_RCU
 slabs
Date: Thu, 08 Aug 2024 20:30:44 +0200
Message-Id: <20240808-kasan-tsbrcu-v7-0-0d0590c54ae6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANQOtWYC/2XOTU7DMBCG4atUXmM0/p+w4h6IhTOxUwuIkV0iU
 JW741RCpMnys/S84yuroaRQ2dPpykqYU015asM9nBid/TQGnoa2mQSpwUnF33z1E7/UvtAX750
 wvgMRnbOskc8SYvq+5V5e2z6nesnl51af5fr6F9L3oVly4NpE7BCs1hafx5zH9/BI+YOtpVltt
 dlp1bQR1MmIUQgQB623uttpvWoXCE2ICGQP2my0gp02689xUNQPkYjMQdt/jSB32jZtYUAbvEM
 t7m8vy/ILNCRnOKEBAAA=
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
 David Sterba <dsterba@suse.cz>, Jann Horn <jannh@google.com>, 
 syzbot+263726e59eab6b442723@syzkaller.appspotmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723141862; l=7163;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=ifhhMKUq3wZYmlKPhfOQuDlC/AkSNxHfHxamMzAf6II=;
 b=2aRS0R6BoACVWuuRvijlpPNLmH0ucoBGDBTgCdvc6f0r9/4Ft9gdMXDBQEo9ihbyrZK2ppxJK
 OguwRRT1ftBCFRFsZPbdjylmtvCUY6szc+i4JLXWejdDPMROUVi361k
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
Changes in v7:
- in patch 2/2:
  - clarify kconfig comment (Marco)
  - fix memory leak (vbabka and dsterba)
  - move rcu_barrier() call up into kmem_cache_destroy() to hopefully
    make the merge conflict with vbabka's
    https://lore.kernel.org/all/20240807-b4-slab-kfree_rcu-destroy-v2-1-ea79102f428c@suse.cz/
    easier to deal with
- Link to v6: https://lore.kernel.org/r/20240802-kasan-tsbrcu-v6-0-60d86ea78416@google.com

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
 mm/Kconfig.debug      | 32 +++++++++++++++++++
 mm/kasan/common.c     | 62 +++++++++++++++++++++---------------
 mm/kasan/kasan_test.c | 46 +++++++++++++++++++++++++++
 mm/slab_common.c      | 12 +++++++
 mm/slub.c             | 87 ++++++++++++++++++++++++++++++++++++++++++++++-----
 6 files changed, 264 insertions(+), 38 deletions(-)
---
base-commit: 94ede2a3e9135764736221c080ac7c0ad993dc2d
change-id: 20240723-kasan-tsbrcu-b715a901f776
-- 
Jann Horn <jannh@google.com>


