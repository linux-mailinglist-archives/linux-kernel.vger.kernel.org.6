Return-Path: <linux-kernel+bounces-266296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915A293FDD4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5581C20AD3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86423187330;
	Mon, 29 Jul 2024 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dvXNpnEG"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E0C16DEDA
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 18:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722279387; cv=none; b=J15rpEZqTR/g0YxxZtW+IjAvxGuAqn+377baUGRv3rmZnbuu9KmbSNaR4tD8aFOuSJJMBHSctnIlvZiX6QJsopqa9hX9eqWT18DKn1i3ZknAuAuZCkDTXBwdTcGmOtsa+G7lOuaA8PZNYur6zQj6zlndTQqm+D1os6lU2tnt7oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722279387; c=relaxed/simple;
	bh=fKyI2N2r6erOfGytR8wMNRWgCgakHfq1+TmFgwhVR/8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=npk6qXHspmUj9fEdUedBmsqQwqkX1jj+TVftOeoz+YWIyUhn1KJYvxP1R1NXrqR1xJkXZxPFCGqVhjt259vTq/WcdETwQd1jckHW1pnv833Q6bwSpKYbddTd/R9cyfmUe46dIuM3CgCjjZnW47jcZXWUlKnKF79+5Xa9l1NVPo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dvXNpnEG; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a869e3e9dfso3085a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722279383; x=1722884183; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OJFBXmp2nnWSyPQ0vZXV6CH2fcDg2DG8vfwkkfKQGv4=;
        b=dvXNpnEGFcwFhXIGKXEuo+aVIBCQG+wfEX/Ko7vBFffEnpYPRd2WuvllsfpV2Ld9ec
         DJYKG2Mnu55rzI30hfZlYJHR/AF5lpKcq0uxdFBvjzqNrJ7Aa5KVSfjJjGUVbdBC78/8
         UBJbj3ewOqx7+6FAlBTNEBeS8YR7RY7tGHLSiBVqAs7+GBCwJtfnMmvJT9gJYaxF8yG1
         Yu8ccma6hmqjG+HTFVjX3Hs5pozW/WX+XcPiEccCoTh0BwFj8fj6/PyoBxdJlEkWyqkE
         iPSoS1KqFEGW+sVkYUf1EpbRwEyTvK0px6vbLV5C/w7htRkhIOfcgGitOjDeYdGquviw
         b4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722279383; x=1722884183;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJFBXmp2nnWSyPQ0vZXV6CH2fcDg2DG8vfwkkfKQGv4=;
        b=oLnr/yVoXTZTGSmKSy75wtXVcXQoWUnJAibXy/C5g7AgiLbtQGnbiPkIMQmKYlJQsf
         WPDXCtOscxLYwAFG5P9AkpYCGFOWwSyD0a1Plf3UZpN8Plely+Pf1bWR51a3YNuOg3Ml
         wcis5o54g/koij31e5SXK4O/D6ZvNRn7SaXJngNkIPrQp/lyjB2VzYOiFJmJOJkXlzVO
         2OsPCLkOmIIetBeecg/y0I4k/tOb8rd17tJSUBVuplCwohAaAVO8NwD5MCFnq1pzZN59
         H6ZfHtNY6ogem8hcjfe+PsAq/yWnQoU++lASbKQsKzTa7wOHgVmCXIVS5b6Zm6xbzQLs
         CqRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgSXr8efuU0r6f80lud7aqibr1R8oP1887SQ3CrMns/hbMuLHcyj1EpsAiK5GuLrHdXLp2WsFmLID9gw1ypMYBRDge8NIHPnxlTLRr
X-Gm-Message-State: AOJu0YyeKDjQFlNlJVP31Vmwb/BiSWlPxQXkwR7jZTcx9Ht9P6Uxpqed
	R4zznZD5xCCI3zRhrrJ8G/bH1lutKSNattOaD3EA+dP1/xj83jWavqg+hn2WKA==
X-Google-Smtp-Source: AGHT+IGHDAR6BfxXjOVdnoYWcpWOMI+YQdQQsZduiIDJgRJ/qHn3aYgnBzbWyENtpVxHf1LGg7bDNg==
X-Received: by 2002:a05:6402:1d4e:b0:57c:c3a7:dab6 with SMTP id 4fb4d7f45d1cf-5b40cede1e6mr72548a12.3.1722279382616;
        Mon, 29 Jul 2024 11:56:22 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:a1f4:32c9:4fcd:ec6c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857fdesm13151543f8f.75.2024.07.29.11.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 11:56:22 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Subject: [PATCH v4 0/2] allow KASAN to detect UAF in SLAB_TYPESAFE_BY_RCU
 slabs
Date: Mon, 29 Jul 2024 20:56:10 +0200
Message-Id: <20240729-kasan-tsbrcu-v4-0-57ec85ef80c6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMrlp2YC/13M0QrCIBiG4VsZ/3GGOp2uo+4jOnCmm1QauqQYu
 /fcIGgdfh+8zwTJRGcSHKoJoskuueDLYLsK9KB8b5C7lA0UU4YFrdFVJeXRmLqon6gThKsWEyt
 EAyV5RGPda+VO57IHl8YQ36ue6fJ+IbaFMkUYMW5lK3HDWCOPfQj9zex1uMMi5fq35n91XWpOd
 EuttIRgsqnnef4AQdb6v+cAAAA=
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
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev

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
Changes in v4:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v3: https://lore.kernel.org/r/20240725-kasan-tsbrcu-v3-0-51c92f8f1101@google.com

Changes in v2:
Patch 1/2 is new; it's some necessary prep work for the main patch to
work, though the KASAN integration maybe is a bit ugly.
Patch 2/2 is a rebased version of the old patch, with some changes to
how the config is wired up, with poison/unpoison logic added as
suggested by dvyukov@ back then, with cache destruction fixed using
rcu_barrier() as pointed out by dvyukov@ and the test robot, and a test
added as suggested by elver@.

Changes in v3:
- in patch 1/2, integrate akpm's fix for !CONFIG_KASAN build failure
- in patch 2/2, as suggested by vbabka, use dynamically allocated
  rcu_head to avoid having to add slab metadata
- in patch 2/2, add a warning in the kconfig help text that objects can
  be recycled immediately under memory pressure
- Link to v2: https://lore.kernel.org/r/20240724-kasan-tsbrcu-v2-0-45f898064468@google.com

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

---
Jann Horn (2):
      kasan: catch invalid free before SLUB reinitializes the object
      slub: Introduce CONFIG_SLUB_RCU_DEBUG

 include/linux/kasan.h | 50 +++++++++++++++++++++++++++----
 mm/Kconfig.debug      | 30 +++++++++++++++++++
 mm/kasan/common.c     | 60 +++++++++++++++++++++++--------------
 mm/kasan/kasan_test.c | 46 ++++++++++++++++++++++++++++
 mm/slab_common.c      | 12 ++++++++
 mm/slub.c             | 83 ++++++++++++++++++++++++++++++++++++++++++++++-----
 6 files changed, 245 insertions(+), 36 deletions(-)
---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240723-kasan-tsbrcu-b715a901f776
-- 
Jann Horn <jannh@google.com>


