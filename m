Return-Path: <linux-kernel+bounces-281154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D84B94D3B5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9693285348
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A481922CD;
	Fri,  9 Aug 2024 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0xIGGh0b"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747541990C0
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 15:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217829; cv=none; b=ViqDtBlLkTP+qaUj6JKKaI/GHFt/cOjpyB+0lyPskYAgvr48+BE8loRn+JXOIbdyl7oZ6m7eUpVcoT/Tf8roXyYANHMUKua8hYQHPL0a1tqVTtNjjD1gdsrsZ89ST5qYoy0F2DlRcjmipdtA0APz/3FoYCUTpwjHUzbrVccuaeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217829; c=relaxed/simple;
	bh=uFiBYlbkxdigQenIMp5nAwwqrh4S/9K2gPEQtQ2EsiI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tp85iZPs527sKzAO6QYLOcS6zoZIkj3qdxi271Uk1ekTHZIQhGiIdnCqgTOHTTFjK8uePBg7Mpz3276922ae7B7S5+Zzxr7qbmX5lC+/T5hwK3fEVPar6IgffEzut0EIIpO1SWqr3Hojwd+UXW8eXPSWVwQ0ST4FFm4JiLra30I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0xIGGh0b; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42807cb6afdso52045e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 08:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723217826; x=1723822626; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NwDMdzsGShHJ6e9jLnQFlgFGGOswIylgETD5oLDX1VI=;
        b=0xIGGh0bk3R2kqogtcJTtrNeFS0iEicw6u6/g9mHlzLa0pRdrsi/7WXj0D0T8pfOVL
         rrea0sxoiBNM8qLUuRaa2K8ekYivmMvaQalLMqLJRpbB1pCSYnT0I2yKRA2tVer54YO/
         tNarzjahmJrMEJd2OQxL4XMkKpXxSUv7t2BstjGtcdhGqFg4TSTJvojP9mLyhu2LyeK7
         UrTzKH/OodcO6DKJwDy7j4QK0a85iF2EBgcRzLUovQBVPhCLDG/Tt9883eLarT4yMvwv
         2ZU26f+0kuyITI0hu9FWOrc6199jVkudSLm0LH6HQPk2k/oVTIMcRiPfOxBZ/KdVBaDY
         28dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723217826; x=1723822626;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NwDMdzsGShHJ6e9jLnQFlgFGGOswIylgETD5oLDX1VI=;
        b=oHWD86Pc/a6j9tBApkqor8Llq4PEV34+Fqe9oyOnbjYNQD/x9ZE4P+nMJ949djn5m9
         IZAhNv9iCMIVTudnnzUm8Ys+0vv3p4T8RTIbocYY3DaQaXqd79kIgTFNDqFm87sjIrww
         oXEzszbDdHWtCTHY8QghsFU8kaiSW3HLCeSJczY5NVbC6ejmg2rnaaKPqWspmk9loj/+
         TTXN+FNZGc7Blh3nI8r2YNBcAtuM6rO5dzmnZOQNfh48zHmiEbKU0zU2LH0X2MedkYYL
         9CJV0o7HN35Sjznkvl4C3IRJo/TexLx9RPUVTFnAdCkhNUH8YjCaJXrLfnhOgjOTet42
         YWeg==
X-Forwarded-Encrypted: i=1; AJvYcCVHNTUXv6sIQOTJV2pkAwBDbDYezR9kWAntjuqleEvorV6DVMxVjaqft5wGPdyLCts6jBqyK3OxOHl8XfVhnU66UyjrDhaiGHsBWwHr
X-Gm-Message-State: AOJu0YxuliI3SeHZ51kHg9fTpwj1/bTASkFhLdSWeYEd7kdFNdo4m6aU
	5S8FynUTNGygWEYOIM8eQck1DA6UxeCoIY0ylGLQuZTv47WVMH42NSsBsV/ekQ==
X-Google-Smtp-Source: AGHT+IF9SW1oRTPIzo1yEqiGOy+OXB/pUCTzDVM0WFzb9TNHbINjPNCzCPEg7+bT1Mcve9Kc21c2Fg==
X-Received: by 2002:a05:600c:1f0a:b0:426:68ce:c97a with SMTP id 5b1f17b1804b1-429c23553ecmr1336575e9.7.1723217824918;
        Fri, 09 Aug 2024 08:37:04 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:1cbc:ea05:2b3e:79e6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d27156c8asm5607035f8f.24.2024.08.09.08.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 08:37:04 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Subject: [PATCH v8 0/2] allow KASAN to detect UAF in SLAB_TYPESAFE_BY_RCU
 slabs
Date: Fri, 09 Aug 2024 17:36:54 +0200
Message-Id: <20240809-kasan-tsbrcu-v8-0-aef4593f9532@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJY3tmYC/2XOTU7DMBCG4atUXmM0/p+w4h6IhTOxUwuIUVwiU
 JW741RCpM7ys/S84ysrYU6hsKfTlc1hSSXlqQ58ODE6+2kMPA11MwlSg5OKv/niJ34p/UxfvHf
 C+A5EdM6ySj7nENP3LffyWvc5lUuef271RW6vfyF9H1okB65NxA7Bam3xecx5fA+PlD/YVlrUX
 ptGq6qNoE5GjEKAOGi9112j9aZdIDQhIpA9aLPTChpttp/joKgfIhGZg7b/GkE22lZtYUAbvEM
 tjrfdXmOjXdUwgOmAjPbhXq/r+guCXmJx3wEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723217820; l=7406;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=uFiBYlbkxdigQenIMp5nAwwqrh4S/9K2gPEQtQ2EsiI=;
 b=W+3X6Fz2LJ4n6j7/pAhLNqx5v9SnrjJHYeGuApT6jH3QQbmWECsCaYqYbZQwG0dttTGpFq8fk
 PYkNcnijIsKCEYeR9ykvHN/3MJdvRUKIXxr+cQnX/95ui/fyc4cIhAg
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
Changes in v8:
- in patch 2/2:
  - move rcu_barrier() out of locked region (vbabka)
  - rearrange code in slab_free_after_rcu_debug (vbabka)
- Link to v7: https://lore.kernel.org/r/20240808-kasan-tsbrcu-v7-0-0d0590c54ae6@google.com

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
 mm/kasan/common.c     | 62 ++++++++++++++++++++++---------------
 mm/kasan/kasan_test.c | 46 +++++++++++++++++++++++++++
 mm/slab_common.c      | 16 ++++++++++
 mm/slub.c             | 86 ++++++++++++++++++++++++++++++++++++++++++++++-----
 6 files changed, 267 insertions(+), 38 deletions(-)
---
base-commit: 94ede2a3e9135764736221c080ac7c0ad993dc2d
change-id: 20240723-kasan-tsbrcu-b715a901f776
-- 
Jann Horn <jannh@google.com>


