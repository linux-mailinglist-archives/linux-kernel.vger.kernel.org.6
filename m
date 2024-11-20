Return-Path: <linux-kernel+bounces-415078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3549D3150
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 01:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9831F23036
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 00:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79101876;
	Wed, 20 Nov 2024 00:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KsV3aqlQ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFE3193
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 00:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732061313; cv=none; b=Vsk42V2j3I6V63DHLRCsYEyq+DsiKBHyng9XLII833XCHzG4WIEzDx1boznNrjs9FfbyA39ptofcuO2L44Xs7a1sfhpXmxEV8acabFKghxU2WN1YxZ8Eu5uOyVWOdVaJ+5+zmOTmzFoZjL8psFp8O0URVjDZYFr/q9ruqdk8Po8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732061313; c=relaxed/simple;
	bh=gT9+Manddpdas8wL4YAf6mG6SljC5580iOL9QHHp3K8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=peR44u1Xkpn9DL8lAy9mlmzAa+GC7CjJBaKqbEmgn7hMXPoWUTYpE8Qkls30hqYLcZRHlld91KRLylnHg7CJb6reCsaiFkzc4sl/QG9YP/bAI++VCpk3wh0hfHrjZ7zLEmJw4JR9sQDmRz8USMAhyHtaQz1Y/9PEZEfswIyKccI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KsV3aqlQ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6eeb5ee73f0so16870577b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 16:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732061311; x=1732666111; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HhkVFKaKFpcTeqNIviXTm8CkZrPqzcwTU1/BoH3xVxg=;
        b=KsV3aqlQGEJ8nYtxNtJG1YFgvAgpW869H6eogtXsX+e5/Tz7Bh4rl0Pl2FxcjXViUk
         YunxG4qL3FI4dgfta9LoUoHAnIbl+7mslcFOQjwuMFLmcFdtO2kHWcJffIQJouqD7ngD
         1/j+O5hVj6yq6a8wD93bqjD+cU/HlHDOGWa6GFHA4ZNS8pk1vb1x64Wmn4lq10sc0eyU
         KvFpF2X9nLzyTaG2Dq7IzNJQ+c9YuosCt1z2wR6o67U4jhM4zM6fr2/uugp8B9ZQy7qf
         L4PYpus2RH6FDy7pi6cVesrdXyfAVrwc3KjPS33uVJbT+LrIR4BJtFZtmzY1FSmv0txz
         Argg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732061311; x=1732666111;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HhkVFKaKFpcTeqNIviXTm8CkZrPqzcwTU1/BoH3xVxg=;
        b=PKWSJ08nip10XYjg8oyfHE+63iobl+Ddxs8M4pUI9M3ZDRV5Xm9YTBaewJ9RKOA5GY
         PHSmU/AYBVSQtl+hj9jlOBhVsgHD7ahEilQRj6RqrqJ1rcpjxeLV1xiMJRrWHKv8UcCQ
         KfD4C35ExSZr2KC/F50Iw+rcbYGv3r7Z2PnVey1EBgtAFEABjYCd6vG4b20z7qx+hMW3
         cx9IcKwZEwOL1fFjinsr5aoN/zu1ym/oPjneGeTwJIhpmiwNlW64C1ukg5zQ+nY5qg1I
         qSLQ2tmQPttRFTMYLirAC2nwXEOamWPyo3veoAdGYKNg4C2laY3QhwbEoa8duGoSUY4Z
         U8xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi3l8cL9W+laS95tkKzCllhBjE12RuI7Ptag6hmEhLGgPZhhcgjOM9fC4lsQIXWe2EJZ3xxgTk+1DZDT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuGx2d44+4DA0oeY6kv8GcST/HDGRcN98X20RCkaBggCU0IEo+
	st+3TxYzy+/1NkgdMpsFsSPLg8DqfF9JHorjWPlElYcj4xnDDfG3epd1m1woCPWoY0LbDzyxDzZ
	seg==
X-Google-Smtp-Source: AGHT+IFYtV6elF80k+BXreudN05LyJlyHTc3YJNvvK+QdV7SDD9vZ+RL+IezB0evCebjjGetlGWDr+ddLDI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:af45:bbc1:fc75:e695])
 (user=surenb job=sendgmr) by 2002:a05:690c:209f:b0:6e2:12e5:356f with SMTP id
 00721157ae682-6eebd2b6dbamr4027b3.3.1732061310472; Tue, 19 Nov 2024 16:08:30
 -0800 (PST)
Date: Tue, 19 Nov 2024 16:08:21 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241120000826.335387-1-surenb@google.com>
Subject: [PATCH v4 0/5] move per-vma lock into vm_area_struct
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
reuse and to minimize call_rcu() calls.
Pagefault microbenchmarks do not show noticeable performance change.

Changes since v3 [4]
- Added SOBs, per Lorenzo Stoakes and Davidlohr Bueso;
- Replaced vma write-locking in vma_mark_attached() with memory barriers to
order accesses to vma->detached vs vm_mm/vm_start/vm_end

Patch applies over mm-unstable

[1] https://lore.kernel.org/all/20230227173632.3292573-34-surenb@google.com/
[2] https://lore.kernel.org/all/ZsQyI%2F087V34JoIt@xsang-OptiPlex-9020/
[3] https://lore.kernel.org/all/CAJuCfpEisU8Lfe96AYJDZ+OM4NoPmnw9bP53cT_kbfP_pR+-2g@mail.gmail.com/
[4] https://lore.kernel.org/all/20241117080931.600731-1-surenb@google.com/

Suren Baghdasaryan (5):
  mm: introduce vma_start_read_locked{_nested} helpers
  mm: move per-vma lock into vm_area_struct
  mm: mark vma as detached until it's added into vma tree
  mm: make vma cache SLAB_TYPESAFE_BY_RCU
  docs/mm: document latest changes to vm_lock

 Documentation/mm/process_addrs.rst |  10 ++-
 include/linux/mm.h                 | 129 ++++++++++++++++++++++++-----
 include/linux/mm_types.h           |  19 ++---
 kernel/fork.c                      |  88 +++++++-------------
 mm/memory.c                        |  17 ++--
 mm/userfaultfd.c                   |  22 ++---
 mm/vma.c                           |   8 +-
 mm/vma.h                           |   2 +
 tools/testing/vma/vma_internal.h   |  55 +++++-------
 9 files changed, 198 insertions(+), 152 deletions(-)


base-commit: 5a7056135bb69da2ce0a42eb8c07968c1331777b
-- 
2.47.0.338.g60cca15819-goog


