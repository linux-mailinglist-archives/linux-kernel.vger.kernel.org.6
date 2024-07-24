Return-Path: <linux-kernel+bounces-261282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BA093B528
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 199ADB22FF4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB3B15F316;
	Wed, 24 Jul 2024 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eJZ3QKzq"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0375415EFAA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 16:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838862; cv=none; b=aYU8J5eRKFgNiIx13FeEUTEQtMYJ2gOVXTuu9A/vAQ3Y2T7iX5wMXk0Dlb4af83Ai4IeDyTP9QAhU2ZySbGMJXv8sjn9Cr3MnCd2A1sBsswh8+us9its9lOfidw3jtMfl7rixtUFKpAA09tdAKEXGlGcepkgB/Pj/usZt85yGRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838862; c=relaxed/simple;
	bh=KOkbrR8tWNW8iUSSPBFdT2kuONIDvB6nyJSFtbILmuA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qZFQgQ7o1A9U5kkcUiPOp0Vkobgc9+WDsnOq58PHH96gc/qjqTEQLy9tcGbHLShMdyi/zvKxtt7mhnUFHs9f0VDAQg14f0KhDC2mQ98Ly2hx+Bv15T4GR7+2a24gf4fjuMQOZAe6By8DepuyiiWiZ/5QF5bnSVwwf9p6HcJMGck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eJZ3QKzq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4266edcc54cso385e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 09:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721838859; x=1722443659; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BIn9I8OgB+Zl6a/4DmM7/3n8midQ/Rf950bAiHb/5Tg=;
        b=eJZ3QKzq7HAtQp4eXYc3o6wN6HfaAwawzXeo8XKNpuwAHhJ3Td3oSjIPkH2NsawnlM
         VjBg6vp9tmJhxNUpiSBzWdZbw9SfXWtnS+Aij5IREihHY5JtaYF1Z8QCxzFneGHKIeYn
         O1mdvuQyV2uExZcELlRZbOu8oE98ZGfJiiK5gX4HnHZeVcrNC2BsrGLRdGvgJa/6gcEm
         cfj2+zgo8hVt0CPpyj1Qy6UI7frm5u7U9FOrUE3f/eHOhnp1lbd0No2MAIQ48gwQqipL
         twOrdf9RvSDdsXxCEA6UCNbM8BkttDDmkNYAwyJ21HCFv2nI/oQC3QlZuLNC54nqhH7J
         KhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721838859; x=1722443659;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BIn9I8OgB+Zl6a/4DmM7/3n8midQ/Rf950bAiHb/5Tg=;
        b=OjdKq7HvC009d0ZcpPts0OSBntkrNu0VQrjQos8CamiaF/bTfcbYqSrYLYT+mDcfuV
         YrwVp3cVrZgifpH9+eCcYGcw5h6OXn4LOeKuo08GT2JyftvMyyg7PQosyaEnmrbkrvih
         RcGWztFr0wVo+RHbL2bDSGdXmSrmDXCC9tESGffOYyPbBcwXLvpg+WEO0D8GRzN/+FxE
         jaAWZqwikGFopDmgML65+OtfhXr5xIbuSo7+xhHQNNYLRXEKQ1uJwSEPNwFTZ6CTvxDp
         5hVaaQACgMtevZ1yn/RVxrc3F+H3cq1oL6QYtANc+/dkNurX82ESUXvGqXssSzP6pLfz
         zNMw==
X-Forwarded-Encrypted: i=1; AJvYcCX/DSkR6YlWF+nUlduDmdp48C4L8qOqLPylzMPAxL3pymAibsQ60BcU442YjWIQWPHAPW8b+npErHKW7bHDWjkI5frycjLFIGhD9/50
X-Gm-Message-State: AOJu0YzbZ7GsxGA1++sJJbXZXMf65oWR8uCyPp60D55Aa/NAW4EJLebc
	jJOpbA41qvU/PaMF/txlKtiDg+12/UVkvTC6NFCuE0a0cOc51/TlecqwRoggwg==
X-Google-Smtp-Source: AGHT+IFUq32k/v6xKrznqFulE1H8hzij3lXrZPymX6K6nlmp5ql94I5UcAr/tg+gIfy9BTIFR0DT1w==
X-Received: by 2002:a05:600c:3b8e:b0:426:6413:b681 with SMTP id 5b1f17b1804b1-427f7c550a3mr1839245e9.6.1721838858696;
        Wed, 24 Jul 2024 09:34:18 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:7aec:12da:2527:71ba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427fc95707esm11705295e9.0.2024.07.24.09.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 09:34:18 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Subject: [PATCH v2 0/2] allow KASAN to detect UAF in SLAB_TYPESAFE_BY_RCU
 slabs
Date: Wed, 24 Jul 2024 18:34:11 +0200
Message-Id: <20240724-kasan-tsbrcu-v2-0-45f898064468@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAMtoWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIxMDcyNj3ezE4sQ83ZLipKLkUt0kc0PTREsDwzRzczMloJaCotS0zAqwcdG
 xtbUAu8f5PF4AAAA=
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

This is v2 of a series that I started, uuuh, almost a year ago.
(Sorry...)
v1 was at:
https://lore.kernel.org/lkml/20230825211426.3798691-1-jannh@google.com/

The purpose of the series is to allow KASAN to detect use-after-free
access in SLAB_TYPESAFE_BY_RCU slab caches, by essentially making them
behave as if the cache was not SLAB_TYPESAFE_BY_RCU but instead every
kfree() in the cache was a kfree_rcu().
This is gated behind a config flag that is supposed to only be enabled
in fuzzing/testing builds where the performance impact doesn't matter.

Patch 1/2 is new; it's some necessary prep work for the main patch to
work, though the KASAN integration maybe is a bit ugly.
Patch 2/2 is a rebased version of the old patch, with some changes to
how the config is wired up, with poison/unpoison logic added as
suggested by dvyukov@ back then, with cache destruction fixed using
rcu_barrier() as pointed out by dvyukov@ and the test robot, and a test
added as suggested by elver@.

Output of the new kunit testcase I added to the KASAN test suite:
==================================================================
BUG: KASAN: slab-use-after-free in kmem_cache_rcu_uaf+0x3ae/0x4d0
Read of size 1 at addr ffff88810d3c8000 by task kunit_try_catch/225

CPU: 7 PID: 225 Comm: kunit_try_catch Tainted: G    B            N 6.10.0-00003-gf0fc688e25ed #422
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

Allocated by task 225:
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
 __kasan_slab_free+0x47/0x70
 slab_free_after_rcu_debug+0xee/0x240
 rcu_core+0x676/0x15b0
 handle_softirqs+0x22f/0x690
 irq_exit_rcu+0x84/0xb0
 sysvec_apic_timer_interrupt+0x6a/0x80
 asm_sysvec_apic_timer_interrupt+0x1a/0x20

Last potentially related work creation:
 kasan_save_stack+0x33/0x60
 __kasan_record_aux_stack+0x8e/0xa0
 __call_rcu_common.constprop.0+0x70/0xa70
 kmem_cache_rcu_uaf+0x16e/0x4d0
 kunit_try_run_case+0x1b3/0x490
 kunit_generic_run_threadfn_adapter+0x80/0xe0
 kthread+0x2a5/0x370
 ret_from_fork+0x34/0x70
 ret_from_fork_asm+0x1a/0x30

The buggy address belongs to the object at ffff88810d3c8000
 which belongs to the cache test_cache of size 200
The buggy address is located 0 bytes inside of
 freed 200-byte region [ffff88810d3c8000, ffff88810d3c80c8)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10d3c8
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x200000000000040(head|node=0|zone=2)
page_type: 0xffffefff(slab)
raw: 0200000000000040 ffff88810d3c2000 dead000000000122 0000000000000000
raw: 0000000000000000 00000000801f001f 00000001ffffefff 0000000000000000
head: 0200000000000040 ffff88810d3c2000 dead000000000122 0000000000000000
head: 0000000000000000 00000000801f001f 00000001ffffefff 0000000000000000
head: 0200000000000001 ffffea000434f201 ffffffffffffffff 0000000000000000
head: 0000000000000002 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88810d3c7f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88810d3c7f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88810d3c8000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88810d3c8080: fb fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc
 ffff88810d3c8100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
    ok 38 kmem_cache_rcu_uaf

Signed-off-by: Jann Horn <jannh@google.com>
---
Jann Horn (2):
      kasan: catch invalid free before SLUB reinitializes the object
      slub: Introduce CONFIG_SLUB_RCU_DEBUG

 include/linux/kasan.h | 20 +++++++++++++
 mm/Kconfig.debug      | 25 ++++++++++++++++
 mm/kasan/common.c     | 63 +++++++++++++++++++++++++++++++--------
 mm/kasan/kasan_test.c | 44 +++++++++++++++++++++++++++
 mm/slab.h             |  3 ++
 mm/slab_common.c      | 12 ++++++++
 mm/slub.c             | 82 ++++++++++++++++++++++++++++++++++++++++++++++-----
 7 files changed, 229 insertions(+), 20 deletions(-)
---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240723-kasan-tsbrcu-b715a901f776
-- 
Jann Horn <jannh@google.com>


