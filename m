Return-Path: <linux-kernel+bounces-435761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7FC9E7BF8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498DC18853A8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E505A1F9EC6;
	Fri,  6 Dec 2024 22:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g0gDBH5R"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83E822C6D9
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 22:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733525529; cv=none; b=px52tWXNk8VdgoF18gwUpBvom04W5IP24nkrs4EOAApzXrzZ/VRGv8iBI0f/slFSAzFy9fTrIoap0dhOnpR7INK8CgdX9hRY4B2n62u1iOMiab6jDbOD/iwJIhjfgkJZHWSx9HZSF7OWSTZmL04MbX2slMcJUpsoQEUeUfil+BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733525529; c=relaxed/simple;
	bh=drZdazJ6RZaupG7jZILdIBxNnuTfqQhtDuIpWB9v4Sw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dfgdVNcATYb4k7qAifYLYujLVsOroN44JRcn5o2vdbwFlk4NcezdLv8y2Eh70zypsP9HwHmU1DAqJutsgQZjP+0YTRf5nkBInpuO0dymSKGUcF3usSDHQUl816VEVtL9RAcP1ANMF+snpwJy5yjsoTQqO1ttOuS9erJaaVDyrAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g0gDBH5R; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-72527c426a2so2078123b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 14:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733525527; x=1734130327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dMTBtYHVwLTdC/ExbH0P/+wfgLQciB2EDIuylOcBn5Y=;
        b=g0gDBH5RJ6Hrh+egvLDNGvjrIY8anRLt04LWQhGSuUXw/YWTwLpZH1I6lzh9HNVlvT
         AB7TB5gJg3/vGx9aFzZBN68MGy3kIt9yExBxfEMKUtyTxYg+yfTcKUBEvlzsP88Kek3/
         sHsfnwqJj5GZRLV8B/+y2szOAwzlgRNmaEL//D/R1/NkdKj1BUyPbRenYt0k+Cso3BVQ
         ZqCFGh1wYxszsxXsj0CqLv7l3nrEMugoQManJcpHBe/Pwm6j2vX05JRHNn1FRBZ4MCiq
         LPB4ekPVqWx7iaVkCCC4O+0PvslL3S74FYSLzGqcH8NZnHsJ9YVR4FbLQGj/qX3S0Pae
         bLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733525527; x=1734130327;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dMTBtYHVwLTdC/ExbH0P/+wfgLQciB2EDIuylOcBn5Y=;
        b=hY7ZmfF4vBD1wd1adysG1O09S5xDA4kT35KRZsrYzZnL5dsj/9XBvW5dQBPLJwqPr9
         6u6hUXGhqeBOgSItfOynWp15jNIiLXuYyzBJnYrAqgpIpsAbUvSJ+ClQvdxg/lsorltI
         OiE9PmEJxnr6NyRJvW/qupBP3sIfPMxLa7IbEDkampD1vf+VO2X7Y53E94MOhAgZotU4
         64gYHycpTmE2tRUIEYgYzh2Iz3zo5AbrK1H/L+mRuoddvKuN0Fz/JQmO7/gQANPU/lGO
         12+eyxAxqCO7L+DUHehMVTOWaRgclb2GllbeJ0rW3HCjdpJPy6PY82QZZOPZ0AS84TCY
         88/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnm6QrXeFg956KVQ1+XXyEmzvKvO79vEUK5FtnKVj0poOivpmeNEUVvRQ2tliNIm8sOIjvWa8HifboQsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeBIgecwrjenpQVh8Tc3+PyqULXnh/TJRePSybIE1l/9MGWWMN
	0B+/MHR8IRSv812VIa900F/Qu71+ZokzKIVJXLFcUNECZTFlRCq1fyiw7nUwvkr3kGFePoKHJry
	Z5A==
X-Google-Smtp-Source: AGHT+IEfV06JzC0SiVnMxaptnUTDnfB304/9csh16+/GMcszHB4C/gm3cOQerG89/3g7z8wtX+YAxVhCLkE=
X-Received: from pfwy40.prod.google.com ([2002:a05:6a00:1ca8:b0:724:f17d:ebd7])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3016:b0:725:c8ea:b320
 with SMTP id d2e1a72fcca58-725c8eab756mr3012011b3a.14.1733525527205; Fri, 06
 Dec 2024 14:52:07 -0800 (PST)
Date: Fri,  6 Dec 2024 14:51:57 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206225204.4008261-1-surenb@google.com>
Subject: [PATCH v5 0/6] move per-vma lock into vm_area_struct
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, 
	oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com, 
	peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, 
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	minchan@google.com, jannh@google.com, shakeel.butt@linux.dev, 
	souravpanda@google.com, pasha.tatashin@soleen.com, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, surenb@google.com
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
3. changes vm_area_struct cache to SLAB_TYPESAFE_BY_RCU to allow for their
reuse and to minimize call_rcu() calls. To avoid bloating vm_area_struct,
we introduce unioned freeptr_t field and allow freeptr_offset to be used
with ctor in a separate patch.
Pagefault microbenchmarks do not show noticeable performance change.

Changes since v4 [4]
- Added SOBs, per Lorenzo Stoakes and Shakeel Butt;
- Changed vma_clear() and vma_copy() to set required vma members
individually, per Matthew Wilcox
- Added comments in vma_start_read() about new false locked result
possibilities, per Vlastimil Babka
- Added back freeptr_t into vm_area_struct, as it's harmless and can be
used in the future to shrink the structure, per Vlastimil Babka
- Fixed the race in vm_area_alloc() when vma->detached was temporarily
reset by memcpy() before setting it back, per Vlastimil Babka
- Added a patch allowing freeptr_offset to be used with ctor,
per Vlastimil Babka

Patch applies over linux-next (due to vm_lock change [5] not in mm tree).

[1] https://lore.kernel.org/all/20230227173632.3292573-34-surenb@google.com/
[2] https://lore.kernel.org/all/ZsQyI%2F087V34JoIt@xsang-OptiPlex-9020/
[3] https://lore.kernel.org/all/CAJuCfpEisU8Lfe96AYJDZ+OM4NoPmnw9bP53cT_kbfP_pR+-2g@mail.gmail.com/
[4] https://lore.kernel.org/all/20241120000826.335387-1-surenb@google.com/
[5] https://lore.kernel.org/all/20241122174416.1367052-2-surenb@google.com/

Suren Baghdasaryan (6):
  mm: introduce vma_start_read_locked{_nested} helpers
  mm: move per-vma lock into vm_area_struct
  mm: mark vma as detached until it's added into vma tree
  mm: make vma cache SLAB_TYPESAFE_BY_RCU
  mm/slab: allow freeptr_offset to be used with ctor
  docs/mm: document latest changes to vm_lock

 Documentation/mm/process_addrs.rst |  10 +-
 include/linux/mm.h                 | 107 ++++++++++++++----
 include/linux/mm_types.h           |  16 ++-
 include/linux/slab.h               |  11 +-
 kernel/fork.c                      | 168 ++++++++++++++++++++---------
 mm/memory.c                        |  17 ++-
 mm/slub.c                          |   2 +-
 mm/userfaultfd.c                   |  22 +---
 mm/vma.c                           |   8 +-
 mm/vma.h                           |   2 +
 tools/testing/vma/vma_internal.h   |  55 ++++------
 11 files changed, 267 insertions(+), 151 deletions(-)


base-commit: ebe1b11614e079c5e366ce9bd3c8f44ca0fbcc1b
-- 
2.47.0.338.g60cca15819-goog


