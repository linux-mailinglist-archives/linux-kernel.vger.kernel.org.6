Return-Path: <linux-kernel+bounces-339779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FF0986A70
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 03:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962AF1C216EB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 01:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F0117334E;
	Thu, 26 Sep 2024 01:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hrlx4+i2"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503FD1714CB
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 01:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727314518; cv=none; b=suqWgPPs0NJU/RM65z2dPtPfians7ROLBR3NLMBgiKvGSXsLuOqV5VsyyUzZODwpV9epJHz0M95QarYdJXrWXbeNlaAR4C/aHnIX01Xrmk9c+hF+fmCA+zdMNntKlI8HG2qlU1/CT8PJTEWptoU2uaZQnyLaZ6MhY144BsBvvJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727314518; c=relaxed/simple;
	bh=3V7g/BeR1Ppicr/9SbMMwaV0q1o6SyThAHL8JhoDbmM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sGiMHYISGUVAg/AoIz+WfPkUeqz7bYwm/ZhKCO1GO4rfg9nNtbl8lZkDdwq4EQ3AEbxPaJln1PAF+sCICNMyB0URvSnG6WAOZ51yj1hAI6bKsAYYjLDVMjxhiCcA+qw8GhW5YV4UYosTkjbkz3P24qMcN/2WgFziVUudiK6Gft4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hrlx4+i2; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1159159528so2256650276.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 18:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727314515; x=1727919315; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VU04rMbBG4hQZH66KIJbz/36hQ90QEQKf0kwa/exU7s=;
        b=hrlx4+i2Gzqa5E8rZvEE6+bE5W47q4nUpn/Q/UuGr3jdZ6C4Ck0fUcwmEnoHgIe0Bw
         uw3EOMLGzdiEPuEl2Y+BWKkqRhlagG8GLCXWRn75KcEu+Im13t82VVQHjFfwhEmN42V+
         Wo2NqPo4FjjDslJnLiorK0/uuFiS+GZcAneidItSrW36QDQjApsCn3MSYq/djb9XVgmE
         Ifg41LMETVnllQbgI7nZ9kHd6xQaKfB1v5sH9eVb6dln7sUdadA0vCdDS38NaLdXmKby
         x6UE5EgMBY4FDcoMiY3qhdGLuP6iX4ZzXUAZKG/Y04zpGBdIZ4Aplyrq0rzy0CGINJ7b
         WbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727314515; x=1727919315;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VU04rMbBG4hQZH66KIJbz/36hQ90QEQKf0kwa/exU7s=;
        b=RIBjTP0MxsRAwKI0ERSkzL/cyCrb+zInEzgFjAhWyEfdA9tpia9IckgJv1nfbOMhVa
         P3vYgw1AJ8WXgBIXMOlWZhcSRmeAwZyuH+AB6BN2TrIlBpwUrll+erPNiZ2q74d8qWDW
         qJgetM/+/s/7Zy9d4qTUSCxF1hBc/0ToXGJNobMFSdfmuTUcc5cEz9oWqwpmBdjqlQR0
         RnvTqjyfVN3mDmY1Gc574Pcd2NQb95c2sqFHmm3QzruYB+56XpWNrit5MR5UsUvxEhot
         tzinKDsHVhZ9Emq9BNldNydt1j0UYQFYiylt5PV4Fh+Qo1fS32UpSOaCiXOSX9TyGwN4
         U+uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxzXrpKd0t2DoTRYqLCLs+xqVgkCI2Uf07vMmBCw3xeGvRjj2AFNAZp/dw0UYisoiOx7Oye+O4LoSdt/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM9+aEF7cV1jYUJOA6Pt6mJ89AL0A2DAdhNHEVIK/qi/Kmtowe
	FWvZGiU8gwKGYvkBKV1n8yYdjCVYAtl5WrIOZINu14M3vK2wr58Ac/Hakks4iKn2CTV/nkQ8eO7
	5vtWrSjyuBYzoC96i+A==
X-Google-Smtp-Source: AGHT+IFp/msJsj4288R/ygmqz/AmN2G/ZyRf++8GaxDH1j7Mu8CzY0R/FPvCXduMLUW1do9JgPGzUuM+NCjd3k9+
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:13d:fb22:ac12:a84b])
 (user=jthoughton job=sendgmr) by 2002:a05:6902:2287:b0:e1d:9ac3:a2ee with
 SMTP id 3f1490d57ef6-e25ca952192mr22515276.4.1727314515061; Wed, 25 Sep 2024
 18:35:15 -0700 (PDT)
Date: Thu, 26 Sep 2024 01:34:48 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240926013506.860253-1-jthoughton@google.com>
Subject: [PATCH v7 00/18] mm: multi-gen LRU: Walk secondary MMU page tables
 while aging
From: James Houghton <jthoughton@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, James Houghton <jthoughton@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Wei Xu <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

This patchset makes it possible for MGLRU to consult secondary MMUs
while doing aging, not just during eviction. This allows for more
accurate reclaim decisions, which is especially important for proactive
reclaim.

This series includes:
1. Cleanup, add support for locklessly memslot walks in KVM (patches
   1-2).
2. Support for lockless aging for x86 TDP MMU (patches 3-4).
3. Further small optimizations (patches 5-6).
4. Support for lockless harvesting of access information for the x86
   shadow MMU (patches 7-10).
5. Some mm cleanup (patch 11).
6. Add fast-only aging MMU notifiers (patches 12-13).
7. Support fast-only aging in KVM/x86 (patches 14-16).
8. Have KVM participate in MGLRU aging (patch 17).
9. Updates to the access_tracking_perf_test to verify MGLRU
   functionality (patch 18).

Patches 1-10 are pure optimizations and could be applied without the
rest of the series, though the lockless shadow MMU lockless patches
become more useful in the context of MGLRU aging.

Please note that mmu_notifier_test_young_fast_only() is added but not
used in this series. I am happy to remove it if that would be
appropriate.

The fast-only notifiers serve a particular purpose: for aging, we
neither want to delay other operations (e.g. unmapping for eviction)
nor do we want to be delayed by these other operations ourselves. By
default, the implementations of test_young() and clear_young() are meant
to be *accurate*, not fast. The fast-only notifiers will only give age
information that can be gathered fast.

The fast-only notifiers are non-trivially implemented for only x86. The
TDP MMU and the shadow MMU are both supported, but the shadow MMU will
not actually age sptes locklessly if A/D bits in the spte have been
disabled (i.e., if L1 disables them).

access_tracking_perf_test now has a mode (-p) to check performance of
MGLRU aging while the VM is faulting memory in.

This series has been tested with access_tracking_perf_test and Sean's
mmu_stress_test[6], both with tdp_mmu=0 and tdp_mmu=1.

=== Previous Versions ===

Since v6[1]:
 - Rebased on top of kvm-x86/next and Sean's lockless rmap walking
   changes[6].
 - Removed HAVE_KVM_MMU_NOTIFIER_YOUNG_FAST_ONLY (thanks DavidM).
 - Split up kvm_age_gfn() / kvm_test_age_gfn() optimizations (thanks
   DavidM and Sean).
 - Improved new MMU notifier documentation (thanks DavidH).
 - Dropped arm64 locking change.
 - No longer retry for CAS failure in TDP MMU non-A/D case (thanks
   Sean).
 - Added some R-bys and A-bys.

Since v5[2]:
 - Reworked test_clear_young_fast_only() into a new parameter for the
   existing notifiers (thanks Sean).
 - Added mmu_notifier.has_fast_aging to tell mm if calling fast-only
   notifiers should be done.
 - Added mm_has_fast_young_notifiers() to inform users if calling
   fast-only notifier helpers is worthwhile (for look-around to use).
 - Changed MGLRU to invoke a single notifier instead of two when
   aging and doing look-around (thanks Yu).
 - For KVM/x86, check indirect_shadow_pages > 0 instead of
   kvm_memslots_have_rmaps() when collecting age information
   (thanks Sean).
 - For KVM/arm, some fixes from Oliver.
 - Small fixes to access_tracking_perf_test.
 - Added missing !MMU_NOTIFIER version of mmu_notifier_clear_young().

Since v4[3]:
 - Removed Kconfig that controlled when aging was enabled. Aging will
   be done whenever the architecture supports it (thanks Yu).
 - Added a new MMU notifier, test_clear_young_fast_only(), specifically
   for MGLRU to use.
 - Add kvm_fast_{test_,}age_gfn, implemented by x86.
 - Fix locking for clear_flush_young().
 - Added KVM_MMU_NOTIFIER_YOUNG_LOCKLESS to clean up locking changes
   (thanks Sean).
 - Fix WARN_ON and other cleanup for the arm64 locking changes
   (thanks Oliver).

Since v3[4]:
 - Vastly simplified the series (thanks David). Removed mmu notifier
   batching logic entirely.
 - Cleaned up how locking is done for mmu_notifier_test/clear_young
   (thanks David).
 - Look-around is now only done when there are no secondary MMUs
   subscribed to MMU notifiers.
 - CONFIG_LRU_GEN_WALKS_SECONDARY_MMU has been added.
 - Fixed the lockless implementation of kvm_{test,}age_gfn for x86
   (thanks David).
 - Added MGLRU functional and performance tests to
   access_tracking_perf_test (thanks Axel).
 - In v3, an mm would be completely ignored (for aging) if there was a
   secondary MMU but support for secondary MMU walking was missing. Now,
   missing secondary MMU walking support simply skips the notifier
   calls (except for eviction).
 - Added a sanity check for that range->lockless and range->on_lock are
   never both provided for the memslot walk.

For the changes since v2[5], see v3.

Based on latest kvm-x86/next.

[1]: https://lore.kernel.org/linux-mm/20240724011037.3671523-1-jthoughton@google.com/
[2]: https://lore.kernel.org/linux-mm/20240611002145.2078921-1-jthoughton@google.com/
[3]: https://lore.kernel.org/linux-mm/20240529180510.2295118-1-jthoughton@google.com/
[4]: https://lore.kernel.org/linux-mm/20240401232946.1837665-1-jthoughton@google.com/
[5]: https://lore.kernel.org/kvmarm/20230526234435.662652-1-yuzhao@google.com/
[6]: https://lore.kernel.org/kvm/20240809194335.1726916-1-seanjc@google.com/

James Houghton (14):
  KVM: Remove kvm_handle_hva_range helper functions
  KVM: Add lockless memslot walk to KVM
  KVM: x86/mmu: Factor out spte atomic bit clearing routine
  KVM: x86/mmu: Relax locking for kvm_test_age_gfn and kvm_age_gfn
  KVM: x86/mmu: Rearrange kvm_{test_,}age_gfn
  KVM: x86/mmu: Only check gfn age in shadow MMU if
    indirect_shadow_pages > 0
  mm: Add missing mmu_notifier_clear_young for !MMU_NOTIFIER
  mm: Add has_fast_aging to struct mmu_notifier
  mm: Add fast_only bool to test_young and clear_young MMU notifiers
  KVM: Pass fast_only to kvm_{test_,}age_gfn
  KVM: x86/mmu: Locklessly harvest access information from shadow MMU
  KVM: x86/mmu: Enable has_fast_aging
  mm: multi-gen LRU: Have secondary MMUs participate in aging
  KVM: selftests: Add multi-gen LRU aging to access_tracking_perf_test

Sean Christopherson (4):
  KVM: x86/mmu: Refactor low level rmap helpers to prep for walking w/o
    mmu_lock
  KVM: x86/mmu: Add infrastructure to allow walking rmaps outside of
    mmu_lock
  KVM: x86/mmu: Add support for lockless walks of rmap SPTEs
  KVM: x86/mmu: Support rmap walks without holding mmu_lock when aging
    gfns

 Documentation/admin-guide/mm/multigen_lru.rst |   6 +-
 arch/x86/include/asm/kvm_host.h               |   4 +-
 arch/x86/kvm/Kconfig                          |   1 +
 arch/x86/kvm/mmu/mmu.c                        | 355 ++++++++++++----
 arch/x86/kvm/mmu/tdp_iter.h                   |  27 +-
 arch/x86/kvm/mmu/tdp_mmu.c                    |  57 ++-
 include/linux/kvm_host.h                      |   2 +
 include/linux/mmu_notifier.h                  |  82 +++-
 include/linux/mmzone.h                        |   6 +-
 include/trace/events/kvm.h                    |  19 +-
 mm/damon/vaddr.c                              |   2 -
 mm/mmu_notifier.c                             |  38 +-
 mm/rmap.c                                     |   9 +-
 mm/vmscan.c                                   | 148 +++++--
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/access_tracking_perf_test.c | 369 +++++++++++++++--
 .../selftests/kvm/include/lru_gen_util.h      |  55 +++
 .../testing/selftests/kvm/lib/lru_gen_util.c  | 391 ++++++++++++++++++
 virt/kvm/Kconfig                              |   3 +
 virt/kvm/kvm_main.c                           | 124 +++---
 20 files changed, 1451 insertions(+), 248 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/lru_gen_util.h
 create mode 100644 tools/testing/selftests/kvm/lib/lru_gen_util.c


base-commit: 3cc25d5adcfd2a2c33baa0b2a1979c2dbc9b990b
-- 
2.46.0.792.g87dc391469-goog


