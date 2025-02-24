Return-Path: <linux-kernel+bounces-529384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D75A424A3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF33A19C6217
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D0E24BC14;
	Mon, 24 Feb 2025 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ngj8+jop"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CC924A04F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408451; cv=none; b=Lxp+ej2XGhI/feRh0IF85HM+jjF89Arzo/XFAm6fWL9baUU0BWAcgfxR+AYHfFS3xd755oBQ5iOTLCL44b0odiTpPRhGWn3brbBZFDO0CDQVGRq9ne6a2a8XxAzxiSHAKG8omlKALWNDWYGu95NYa5dlxxcSf29iGX6smk0FFv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408451; c=relaxed/simple;
	bh=cbZQJPuw9LB3kopdVXNdHT1la83WDsHvIdWsY+Ks8Sk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UbSb0XuRlEhjAtKcURLOpRl7MtqCNMTAhLQt+x9WymJgXg/HPhsszFlnbZuXqmd6b/Q/WB8hAefifLLYtnnCnC+FRa0/2iJgjhDkGxvEAi597oR6chCUb4mfpsRk1lM8UDkreo0yFF7KE6S2amcnjOa8YH+NlaxQAcu4zmTEQ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ngj8+jop; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-38f4e47d0b2so2084659f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 06:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740408447; x=1741013247; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lY/f60hP8VWKJvO3bIE0M//2ttPDqncPJc81wpWwDM0=;
        b=ngj8+jopeECs9A+9zlAjBj7aHPPAcDLpNYVRWT3Xjlw5nGyq0qR7ebkWDtPbWOdtC2
         zWfgh0ne5mABBtUrAr/JLh7sXy0aFc4QJBub3kgnTqi7+Y74qfIJpuTw/nPL7/VoBAjy
         13dxdm+gTDXNoyvYsGpMQb6WT3TEVSwZDyKgdfmrz9AaRjNKcpK4JpDH+4KJZw+zujzH
         LXmND/YBNiL8tiRvCPC31VsCTufree6nNmzuyoWW+OBVx8uoZBxNY2224DzO+qdzaJlv
         L6aTCTpYejWOuK1lKilHKxXXHkoOUzmB2fgeOzsiutJH1XVHQXYbbbid7rgckuY8XtHI
         kpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740408447; x=1741013247;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lY/f60hP8VWKJvO3bIE0M//2ttPDqncPJc81wpWwDM0=;
        b=Pq6lnlrG8Dtc+19IfFThfwaiPhrKRyCnyfPXQ3x/P3LydKoBRGDv7JVKHUZNe3AtLU
         hGq2486xMrF2NFPors26jUqd6bOqvZnnAoM0ZGpGMUwarvyBA6IbyGi6ydfuVcYm+9fb
         0huwCPQcnTdwAKlwQLn8im2fjxDox8yOGAvS5a+EZHa6F5Ha7Qsmb8j1WyVZzj4bmsH2
         db113pbZQCf5+0qLnw2xoy8HSNSh536sAmu9laAYBC4wN7TdAEtuVYL4fjLB35vWUFnm
         1hpeAL7HhaW6AXwjVou91s6NOMMR7PadvyfiXDXTuTmJJIdqAv2xKX/BIXmND+7JQE88
         ZWjw==
X-Forwarded-Encrypted: i=1; AJvYcCXwFC3BLPKBvR9hCySGd7+HvCHE/6hKKo/0FpW2HrroH2JngOhjPQ40JJpiA8XzGSnIQmOQcx3ilZnbex4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJEM4e0+p2URLv1wX8i1N1OXTQZeCw5EOuPsv8GxaXMLl7yE/7
	c5tJ0DpwEUItOFk2JLjn+G9hau1qBp7gDGzbUL9gsW99RfU8TDF657EavYRZfMUQUf8sgVhvmhO
	Rc5faMiZONg==
X-Google-Smtp-Source: AGHT+IENgoTDlWe0ZNnHReuth/Sr7TVUqQE1u7CvzpuJvSEXob7jKOT1xXN1OI0qw1ZLFVKDzieKdDescRaUUQ==
X-Received: from wmbec10.prod.google.com ([2002:a05:600c:610a:b0:439:98ca:e39d])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:598d:0:b0:38f:3c8a:4c0a with SMTP id ffacd0b85a97d-38f6e7539b7mr7384989f8f.7.1740408447541;
 Mon, 24 Feb 2025 06:47:27 -0800 (PST)
Date: Mon, 24 Feb 2025 14:47:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAG6GvGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0NL3YJEoFhiTk5+sm52aV5miW5KmrlZappFikVqkqUSUFtBUWpaZgX YyGilIDdnpdjaWgA2v9x7ZwAAAA==
X-Change-Id: 20250219-page-alloc-kunit-df76ef8d8eb9
X-Mailer: b4 0.15-dev
Message-ID: <20250224-page-alloc-kunit-v1-0-d337bb440889@google.com>
Subject: [PATCH RFC 0/4] mm: KUnit tests for the page allocator
From: Brendan Jackman <jackmanb@google.com>
To: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Michal Hocko <mhocko@kernel.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Brendan Jackman <jackmanb@google.com>, Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="utf-8"

The page allocator does a lot of stuff that is not visible to the user
in any deterministic way. But this stuff is still important and it would
be nice to test that behaviour.

KUnit is a tool for unit-testing kernel-internal APIs. This is an
attempt to adopt it the page allocator.

I have been hacking on this as a way to try and test the code I'm
writing for my ASI page_alloc integration proposal [0]. It's been
extremely useful to be able to "just call it and see what it does". So I
wanna gather some feedback on whether this basic idea is of interest
before I invest too much more time in it.

You can run these tests like this:

tools/testing/kunit/kunit.py run \
	--arch=x86_64 --kernel_args="movablecore=2G" \
	--qemu_args="-m 4G" --kunitconfig mm/.kunitconfig

Unit-testing code that has mutable global variables can be a pain.
Unit-testing code with mutable global variables _that can change
concurrently with the tests_ is basically impossible. So, we need some
way to isolate an "instance" of the allocator that doesn't refer to any
such concurrently-mutated state.

Luckily, the allocator only has one really important global variable:
node_data. So, the approach here is to carve out a subset of that
variable which is as isolated as possible from the rest of rthe system,
which can be used for deterministic testing. This is achieved by crating
a fake "isolated" node at boot, and plugging in memory at test init
time.

This is an RFC and not a PATCH because:

1. I have not taken much care to ensure the isolation is complete.
   There are probably sources of flakiness and nondeterminism in here.

2. I suspect the the basic idea might be over-complicated: do we really
   need memory hotplug here? Do we even need the instance of the
   allocator we're testing to actual memory behind the pages it's
   allocating, or could we just hallucinate a new region of vmemmap
   without any of that awkwardness?

   One significant downside of relying on memory hotplug is that the
   test won't run if we can't hotplug anything out. That means you have
   to fiddle with the platform to even run the tests - see the
   --kernel_args and --qemu_args I had to add to my kunit.py command
   above.

   So yeah, other suggestions welcome.

   2b. I'm not very confident I'm using the hotplug API properly.

3. There's no point in merging this without actually having at least a
   few tests that are actually interesting!

   Maybe a "build it and they will come" approach can be justified to
   some extent, but there's a nonzero cost to the infrastructure so we
   should probably have some confidence that they will indeed come.

[0] https://lore.kernel.org/linux-mm/20250129144320.2675822-1-jackmanb@google.com/ 

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Brendan Jackman (4):
      kunit: Allocate assertion data with GFP_ATOMIC
      mm/page_alloc_test: Add empty KUnit boilerplate
      mm/page_alloc_test: Add logic to isolate a node for testing
      mm/page_alloc_test: Add smoke-test for page allocation

 drivers/base/memory.c    |   5 +-
 include/linux/memory.h   |   4 +
 include/linux/nodemask.h |  13 +++
 kernel/kthread.c         |   3 +
 lib/kunit/assert.c       |   2 +-
 lib/kunit/resource.c     |   2 +-
 lib/kunit/test.c         |   2 +-
 mm/.kunitconfig          |  10 ++
 mm/Kconfig               |   8 ++
 mm/Makefile              |   2 +
 mm/internal.h            |  11 ++
 mm/memory_hotplug.c      |  26 +++--
 mm/numa_memblks.c        |  22 ++++
 mm/page_alloc.c          |  37 +++++-
 mm/page_alloc_test.c     | 296 +++++++++++++++++++++++++++++++++++++++++++++++
 15 files changed, 429 insertions(+), 14 deletions(-)
---
base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
change-id: 20250219-page-alloc-kunit-df76ef8d8eb9

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


