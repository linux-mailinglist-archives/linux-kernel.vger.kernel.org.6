Return-Path: <linux-kernel+bounces-447996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 268179F39AD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6DFA188C779
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB9B207E10;
	Mon, 16 Dec 2024 19:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4RS3r0mk"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC8E148314
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734377066; cv=none; b=FWWQRZsbGVhmDQ/TSt4XCDL5sTj1rp97ZW9tOzxvxTkNnF4JtNSAUmwFNCd9wUHWVjE7pkSM0/2nAlXulQwXaw9WCkGECsNO+VJXDK4P3+JKvVeoAxKRNx6ywrKGknJZwNMkjGSw/tQKLY7aB17U1GKlS1ksi4kzClqVmXrckDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734377066; c=relaxed/simple;
	bh=i4Bny9SBcGw3ZAI7XkeBeLxDCh5GAJ0KyJxJ6P++Ano=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=C+kZ8ft/mu2MnYP+2RK5KSBp9HMojpbGAouYN3IoMpqA510T+L2duD72AU5dyeKP/eQZ6wM5r0RvRRIJi2LL0JJeoBtZAgABVZAjU6nZTgDUNzilH1N/e+ClotfV8oGlPEv3ahNBMPlWhQ3s8EaXZJvXbbycZe38HW3xuKZ5WNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4RS3r0mk; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2efa74481fdso4203877a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734377063; x=1734981863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LeGomQCdTlzqmvFZ6fy5rq2UtmzZcMIBE5Kh+oHkUdg=;
        b=4RS3r0mk7gobEpS8uUycKEIskaSvvsOFWoKCwBMci3ZpQMd/GRp5z0Qtl1RHBjeTYB
         Ve0utMr+5PvnMF2LnQgAnee7raZM+q8jtE12F6MRXy3sAFZUkraEfQAz8YnsY9w+DYb4
         JvnokzKav9lOUJid9DPXPCvZwyFO6HXSdYlzYGY9tQ3SN/R7M7qJ2XZ5cjZyoaIyy/mL
         cHzTH3evQ2To5XoRz2llmEAja7Ald6lYjS6rJDvOuwro4bBVvol8+rHNkcOj5Al9VMNb
         UAqfkFX+lxG+zT4uL6sUJbus2WG4eo5eQ8ZUvcyJJxqH8gn8BX6J4MPsbk/xmAomp3yF
         JlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734377063; x=1734981863;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LeGomQCdTlzqmvFZ6fy5rq2UtmzZcMIBE5Kh+oHkUdg=;
        b=Q7m45D+U5k1Bty+AUEEFhqlyJ0a98dvfRiIpDec8p2zbZN0XE/JRCV3aR+ncB4iBqJ
         coztOXUK6AFWERIu2v0ne1lXMAv199xMw/zC0d4uXcszudRxgIkvSpQg8+d3xmnv7oxU
         bnfYv5wOy0KdpkN/ucOemOcGOe4kPh+F1oPaRp8RkKPxao4OgkbBc9Lh0Bf2tse0dSKj
         M1oNnyH9/WdR7htaycgtT4HDlQJLdDP6PXJzd5otahZSSbm2X3EnVF1BGJ12RLgeBrGX
         usbWKNSr45dvwpvbhNV4XWlqod2MJWTeabUaeMMzqxEQqOR1KT7ZvpD1v9tnQfIejqJY
         /Zuw==
X-Forwarded-Encrypted: i=1; AJvYcCVSzaFYqDXK8HX52un3mzir8DX9Q7uO0LDTlw423H41WmfDVP6UBVW2kcR7P90SIQvi3TKxhRZsKmQIS+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu+wP41WqvuiwT3rAsuQufCLhGNCXWACtN2FQGC6oFVmolIjDN
	aoKdAA577AesO4fg6Ea1R/StR6TcadG6CV8/7mrvX2+GvP2MdRe5UzbX3E5phpnmiSvd2AMCxB0
	4vQ==
X-Google-Smtp-Source: AGHT+IEdDvpLmKrEQvDiFjGzeYKKUg0/T8qcx1CuYCjryvPmhtOLq4Mr6xjJ+BU35VHJ2P4yHAcB9T2GqoI=
X-Received: from pjbsy3.prod.google.com ([2002:a17:90b:2d03:b0:2ef:8d43:14d8])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:ec84:b0:2ee:f80c:6889
 with SMTP id 98e67ed59e1d1-2f290dbce03mr20770436a91.33.1734377063393; Mon, 16
 Dec 2024 11:24:23 -0800 (PST)
Date: Mon, 16 Dec 2024 11:24:03 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216192419.2970941-1-surenb@google.com>
Subject: [PATCH v6 00/16] move per-vma lock into vm_area_struct
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: peterz@infradead.org, willy@infradead.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	lokeshgidra@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	klarasmodin@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Back when per-vma locks were introduces, vm_lock was moved out of
vm_area_struct in [1] because of the performance regression caused by
false cacheline sharing. Recent investigation [2] revealed that the
regressions is limited to a rather old Broadwell microarchitecture and
even there it can be mitigated by disabling adjacent cacheline
prefetching, see [3].
Splitting single logical structure into multiple ones leads to more
complicated management, extra pointer dereferences and overall less
maintainable code. When that split-away part is a lock, it complicates
things even further. With no performance benefits, there are no reasons
for this split. Merging the vm_lock back into vm_area_struct also allows
vm_area_struct to use SLAB_TYPESAFE_BY_RCU later in this patchset.
This patchset:
1. moves vm_lock back into vm_area_struct, aligning it at the cacheline
boundary and changing the cache to be cacheline-aligned to minimize
cacheline sharing;
2. changes vm_area_struct initialization to mark new vma as detached until
it is inserted into vma tree;
3. replaces vm_lock and vma->detached flag with a reference counter;
4. changes vm_area_struct cache to SLAB_TYPESAFE_BY_RCU to allow for their
reuse and to minimize call_rcu() calls.

Pagefault microbenchmarks show performance improvement:
Hmean     faults/cpu-1    507926.5547 (   0.00%)   506519.3692 *  -0.28%*
Hmean     faults/cpu-4    479119.7051 (   0.00%)   481333.6802 *   0.46%*
Hmean     faults/cpu-7    452880.2961 (   0.00%)   455845.6211 *   0.65%*
Hmean     faults/cpu-12   347639.1021 (   0.00%)   352004.2254 *   1.26%*
Hmean     faults/cpu-21   200061.2238 (   0.00%)   229597.0317 *  14.76%*
Hmean     faults/cpu-30   145251.2001 (   0.00%)   164202.5067 *  13.05%*
Hmean     faults/cpu-48   106848.4434 (   0.00%)   120641.5504 *  12.91%*
Hmean     faults/cpu-56    92472.3835 (   0.00%)   103464.7916 *  11.89%*
Hmean     faults/sec-1    507566.1468 (   0.00%)   506139.0811 *  -0.28%*
Hmean     faults/sec-4   1880478.2402 (   0.00%)  1886795.6329 *   0.34%*
Hmean     faults/sec-7   3106394.3438 (   0.00%)  3140550.7485 *   1.10%*
Hmean     faults/sec-12  4061358.4795 (   0.00%)  4112477.0206 *   1.26%*
Hmean     faults/sec-21  3988619.1169 (   0.00%)  4577747.1436 *  14.77%*
Hmean     faults/sec-30  3909839.5449 (   0.00%)  4311052.2787 *  10.26%*
Hmean     faults/sec-48  4761108.4691 (   0.00%)  5283790.5026 *  10.98%*
Hmean     faults/sec-56  4885561.4590 (   0.00%)  5415839.4045 *  10.85%*

Changes since v5 [4]
- Added Reviewed-by, per Vlastimil Babka;
- Added replacement of vm_lock and vma->detached flag with vm_refcnt,
per Peter Zijlstra and Matthew Wilcox
- Marked vmas detached during exit_mmap;
- Ensureed vmas are in detached state before they are freed;
- Changed SLAB_TYPESAFE_BY_RCU patch to not require ctor, leading to a
much simpler code;
- Removed unnecessary patch [5]
- Updated documentation to reflect changes to vm_lock;

Patchset applies over mm-unstable after reverting v5 of this patchset [4]
(currently 687e99a5faa5-905ab222508a)

[1] https://lore.kernel.org/all/20230227173632.3292573-34-surenb@google.com/
[2] https://lore.kernel.org/all/ZsQyI%2F087V34JoIt@xsang-OptiPlex-9020/
[3] https://lore.kernel.org/all/CAJuCfpEisU8Lfe96AYJDZ+OM4NoPmnw9bP53cT_kbfP_pR+-2g@mail.gmail.com/
[4] https://lore.kernel.org/all/20241206225204.4008261-1-surenb@google.com/
[5] https://lore.kernel.org/all/20241206225204.4008261-6-surenb@google.com/

Suren Baghdasaryan (16):
  mm: introduce vma_start_read_locked{_nested} helpers
  mm: move per-vma lock into vm_area_struct
  mm: mark vma as detached until it's added into vma tree
  mm/nommu: fix the last places where vma is not locked before being
    attached
  types: move struct rcuwait into types.h
  mm: allow vma_start_read_locked/vma_start_read_locked_nested to fail
  mm: move mmap_init_lock() out of the header file
  mm: uninline the main body of vma_start_write()
  refcount: introduce __refcount_{add|inc}_not_zero_limited
  mm: replace vm_lock and detached flag with a reference count
  mm: enforce vma to be in detached state before freeing
  mm: remove extra vma_numab_state_init() call
  mm: introduce vma_ensure_detached()
  mm: prepare lock_vma_under_rcu() for vma reuse possibility
  mm: make vma cache SLAB_TYPESAFE_BY_RCU
  docs/mm: document latest changes to vm_lock

 Documentation/mm/process_addrs.rst |  44 ++++----
 include/linux/mm.h                 | 162 +++++++++++++++++++++++------
 include/linux/mm_types.h           |  37 ++++---
 include/linux/mmap_lock.h          |   6 --
 include/linux/rcuwait.h            |  13 +--
 include/linux/refcount.h           |  20 +++-
 include/linux/slab.h               |   6 --
 include/linux/types.h              |  12 +++
 kernel/fork.c                      |  88 ++++------------
 mm/init-mm.c                       |   1 +
 mm/memory.c                        |  75 +++++++++++--
 mm/mmap.c                          |   8 +-
 mm/nommu.c                         |   2 +
 mm/userfaultfd.c                   |  31 +++---
 mm/vma.c                           |  15 ++-
 mm/vma.h                           |   4 +-
 tools/testing/vma/linux/atomic.h   |   5 +
 tools/testing/vma/vma_internal.h   |  96 +++++++++--------
 18 files changed, 378 insertions(+), 247 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog


