Return-Path: <linux-kernel+bounces-262390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D42A793C670
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F412817DD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993D619D064;
	Thu, 25 Jul 2024 15:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YGVWWUD3"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41491D545
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921531; cv=none; b=kGr9po0/AIHmRHiselCgoMUf+odoQ3/d2rmH3pWSFz4Irl61vb094J/5D0rc9qDG5y4v+h39Ms2lvzv2CoJbST16MhrxJCBqc4JZ5YbHtLMK22pyZokElgs+lIFekDCtUWR4GTXADYAZeWMRFuxTGD2MKaINnXKRHxBLXv5I9zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921531; c=relaxed/simple;
	bh=REKYk/VhpurPGwxf6gFJoHbOcpJy3+0DhIRpGswIEUE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pHfZgLbZRMHbU7O3EA+7bhDcPLekFpPdJTsjhsrNwIAtkAKSh+K+cOreS2ZSxIOdAMr2n6gK1Iq5YuXE0VlAsStX8Zz8PVY9f+FxnpaQ6yG8eO5Gxo0J65RDnsV5WTSS2d6Tij727EdhOjtkwjEKYJQVOvnXKt6aG+Dol9VEy1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YGVWWUD3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-428078ebeb9so33885e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721921528; x=1722526328; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=abZrxQokkz2pYLFW8Emrfi2Wptsc7Kc1VGz7XRPEMEU=;
        b=YGVWWUD3VJOoWvr/8iLjeGV5iQyhqlEqPEsAzERZi+9ISPQ6lNOsBhmUd+6oukeJpo
         LlCtT9X3JQvymLRVnhGuG38BT3QsqOSi1SYgmGJMvuuk4sovNGIQ5tp2Hzl+dciTDcHY
         CUGBgUR3vYOntYQsYxqMAvUwAGuRdznqGXrKr4GATn4VpUrXRvzQVq4W5vQ8ZPKvkKAK
         HYXpl5h/wQZNpSaIW1LT+Yv1lIvjoVQvsm8oyALYciJRm9vyQ4LduBwtSEQqvvi6Wdok
         QkzRLWayGWCUhog4fVIe1YR8zghLtKKq8V2V4gDmA4Z8dzjhYVgTHfFF9bs/Zpom7Ddv
         EErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721921528; x=1722526328;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=abZrxQokkz2pYLFW8Emrfi2Wptsc7Kc1VGz7XRPEMEU=;
        b=Zu+h8tfWorS5r7ljRmSRv61xZY/6LAORhlpQ9e+v+nJO+EUR06pi88ofnnbqwVrTyM
         lQfgvoEOH6ZC4CHgTEIyCqf5QXbOU0iadDayj+COGmK1LFJ+oPwKVhQAQRXZVVz1h19u
         8heIJB8Ry3jx0YlpKYvm+92QVvuPozEim9Qr3fB24IYttcwe0eOQlRBzH80NZldNCUvk
         hjkssC87HmvV/ZswzkLARHhbnNiKVYZDyeM9d1TDAK5WsUQxLwqMAAPOWC6qeo+P7NH3
         w9nQFK8OXJRW8gjztyVoCT4XYUeYiw+7rMIGYNqhaxLQoPBECsAJ9Y6Kmq+jPMlRs5di
         2/IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWeAOSK6sn6nAcsATkywc5Lwxqwwm88/mwH6BPaQ2DUgozMoyQQwENxqBkzV3YG9JnjrjnXLQ1VGBAKvVkhxsirD1DQnLyKd/l+xzX
X-Gm-Message-State: AOJu0Yz3+WO6KhxGPibkAhpAjtf8DcQjRfrvtVH3n2LmzOREWbLkeBQb
	6QkX9MjB1qtmCZB4CL1FMHyoL2vEYZFyTBBvwwlqoY9TgAThLXgaA1S1p9mZM+bJAXKiBiNVVZR
	7zTjwAdU=
X-Google-Smtp-Source: AGHT+IE/H9XDkG2Q5ACqFGfvWQBys4MMpCedRzQf9hCedIC5QW1I2hJ7DWfcARrlioaiNHX+6R+w7A==
X-Received: by 2002:a05:600c:3b05:b0:426:5ef2:cd97 with SMTP id 5b1f17b1804b1-42803ffa18amr1547735e9.2.1721921526693;
        Thu, 25 Jul 2024 08:32:06 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:8b71:b285:2625:c911])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428079448d0sm30274615e9.21.2024.07.25.08.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 08:32:06 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Subject: [PATCH v3 0/2] allow KASAN to detect UAF in SLAB_TYPESAFE_BY_RCU
 slabs
Date: Thu, 25 Jul 2024 17:31:33 +0200
Message-Id: <20240725-kasan-tsbrcu-v3-0-51c92f8f1101@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANVvomYC/1XMQQ7CIBRF0a00fyyGUgq0I/dhOqAIlKhgoBJNw
 97FJg4c3pe8s0HS0ekEY7NB1NklF3yN7tCAWqS3GrlLbSCYUMxJh64ySY/WNEf1RDNvezng1nD
 OoF4eURv32rnzVHtxaQ3xveuZfNcfRP+hTBBGtDdiEJhRysTJhmBv+qjCHaZSyge6iIx9qQAAA
 A==
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

---
Jann Horn (2):
      kasan: catch invalid free before SLUB reinitializes the object
      slub: Introduce CONFIG_SLUB_RCU_DEBUG

 include/linux/kasan.h | 30 +++++++++++++++----
 mm/Kconfig.debug      | 29 ++++++++++++++++++
 mm/kasan/common.c     | 60 +++++++++++++++++++++++++++----------
 mm/kasan/kasan_test.c | 44 +++++++++++++++++++++++++++
 mm/slab_common.c      | 12 ++++++++
 mm/slub.c             | 83 ++++++++++++++++++++++++++++++++++++++++++++++-----
 6 files changed, 230 insertions(+), 28 deletions(-)
---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240723-kasan-tsbrcu-b715a901f776
-- 
Jann Horn <jannh@google.com>


