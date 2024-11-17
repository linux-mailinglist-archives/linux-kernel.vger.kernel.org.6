Return-Path: <linux-kernel+bounces-412014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BA29D0266
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 09:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2222DB246CB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 08:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D1041C69;
	Sun, 17 Nov 2024 08:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FuMc62CH"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF202A8E5
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731830977; cv=none; b=bBZpLYHx3v26hF9BvxqvHZIonPO1gAXeEPHkHbHx+o6nzwavusNZf+v3AYLMzWdvO5DN+Y+CO2EKcqAJTCy1HASEdOr14FY6HCXdxBUGNzPzKvWorHxCJrZZW8xAgPTCk1IdCAMsUlJIBP27WSpkFUYdyKFjYOEkUZjt7l85xAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731830977; c=relaxed/simple;
	bh=JVjdxIAOylzI3vGfYIYWj1s1Lcucv/izfPzPJ3GkXSw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fEh6FS/t/6bs+bZqrAZb/5axtR5KmuoDIlNrOAapgc2LaCbic8CTHPoFIIX703ZD0S0KLBLg0mP3L/uy69lnjajYNXE5WRvOHrfk9avfIGc2ZyDn2WoZgHggBLU4b1lX9mibKfajXDGbR571CzWe4jiqKoieYZc5ec5qTl2reSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FuMc62CH; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e330f65bcd9so3958079276.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 00:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731830975; x=1732435775; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T+OFugD+gETNb7vhEAsrG1OgRlzuAtkUoQYa8geci98=;
        b=FuMc62CHWH2n6AMlI4TWeTzwGtn8Xp2faxrIy6gbhrRLF4oW2+GoTdaCS2jFxeuve1
         SjNjVLbjvjQ6jAs5V6HyywwQKdGPFzk0aOxD/CtyAysljHOHu21qI2HakG+zLTR4nFmS
         ROJviCNJcIp3wyBX9PyBXv5A1Wqw+4aIyel5kRpC4s/la6l8DvGiOPHnA4S6B0ZqnCbP
         TtjaN2NVAE9LULduSFcLWQ6qadFAZp50MUZMxFISGmYKJTWh1a6jbfS5Js3o95kf3UTY
         Ii0wIYEUtWQCLdoraSa/ohimj+mTf2V3iD8Q74UBa5CjVn6g2x6lKTJ631lBh2ATFV8m
         xXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731830975; x=1732435775;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T+OFugD+gETNb7vhEAsrG1OgRlzuAtkUoQYa8geci98=;
        b=ZA0cID7W6RZpUUUWoiFGVE6ZyAqbBODRK1hqT8yuCiE8vgdco1jUKXFzctW+jvJTLE
         7FHocDlKxkv+QZVu/tCj07j2HKG/DBQG7ySzCidZtyRog+ySDeZ4KZIH2XynUiWHCv3Y
         prsKtufG5lISc73Uvlb/puUh2NJ+FjqoznxrbmxSI1I0V0edAjYHwAxvTW+MXM3L4FX6
         QDnwXqmXh/u6Avy+zruZy7gFRUY1L9fy9w30j8Vm+sCO+AwtJzvXXWIMgm9LSr/hd9o8
         /86gov1RpDqdjQ5nC6DUbv7vKhzrAT8MOxifh2SP+WI20C+PXV8EDNzC9aIHkeFyFblQ
         OyPw==
X-Forwarded-Encrypted: i=1; AJvYcCUOc+WljWOEApz9yOPbeTKGYpHw4ggBdX+g/n77MZzJlXLBG+4Tp7JnW0HgSnlTVC6CQSnKtf0lcjWSYKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/fsVdb5mtvmb6MrGdaMcRYXMayvjhCfqBprQL1xgYoDFVqOi9
	4Z0epNgJzuWOJ0SUgrqomvAwix8QGyLzSdCjrr9BBkOgQGeuco6LFKe9WZagbtCQd9aBLEEPdGA
	pOA==
X-Google-Smtp-Source: AGHT+IG4dmb/uQ+GXi1P4l9n6RvmmZk+SVBQpXYBunsXvRdr7iFW+KRUCnhiMQ1KfmEq7maeTeWIGGpGl/E=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:bafc:6633:f766:6415])
 (user=surenb job=sendgmr) by 2002:a05:6902:2808:b0:e26:3788:9ea2 with SMTP id
 3f1490d57ef6-e3824775f45mr228432276.0.1731830974816; Sun, 17 Nov 2024
 00:09:34 -0800 (PST)
Date: Sun, 17 Nov 2024 00:09:26 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241117080931.600731-1-surenb@google.com>
Subject: [PATCH v3 0/5] move per-vma lock into vm_area_struct
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

Changes since v2 [4]
- Updated vma_start_read_locked and vma_start_read_locked_nested comments,
per Lorenzo Stoakes;
- Undated patch 2 description to include motivation for moving vm_lock
into vm_area_struct, per Lorenzo Stoakes, Vlastimil Babka, Mateusz Guzik;
- Undated description to include a note about memory overhead dependency
on kernel config options, per Lorenzo Stoakes and Vlastimil Babka;
- Updated vma tests;
- Introduced vma_mark_attached();
- Moved vma_mark_attached() calls into vma_iter_store{_gfp},
per Lorenzo Stoakes
- Moved vma_lock_init() into vm_area_cachep constructor, per Hugh Dickins;
- Ensure vm_lock is preserved when clearing or copying vm_area_struct;
- Pass mm to vma_start_read() to avoid use of vma->vm_mm, which might be
changed by a racing vma_init() if the vma gets reused;
- Added vma write-locking in vma_mark_attached() to prevent races with
vma->detached check in lock_vma_under_rcu().

Patch applies over mm-unstable

[1] https://lore.kernel.org/all/20230227173632.3292573-34-surenb@google.com/
[2] https://lore.kernel.org/all/ZsQyI%2F087V34JoIt@xsang-OptiPlex-9020/
[3] https://lore.kernel.org/all/CAJuCfpEisU8Lfe96AYJDZ+OM4NoPmnw9bP53cT_kbfP_pR+-2g@mail.gmail.com/
[4] https://lore.kernel.org/all/20241112194635.444146-1-surenb@google.com/

Suren Baghdasaryan (5):
  mm: introduce vma_start_read_locked{_nested} helpers
  mm: move per-vma lock into vm_area_struct
  mm: mark vma as detached until it's added into vma tree
  mm: make vma cache SLAB_TYPESAFE_BY_RCU
  docs/mm: document latest changes to vm_lock

 Documentation/mm/process_addrs.rst |  10 ++-
 include/linux/mm.h                 | 121 +++++++++++++++++++++++------
 include/linux/mm_types.h           |  19 ++---
 kernel/fork.c                      |  88 ++++++++-------------
 mm/memory.c                        |   9 ++-
 mm/userfaultfd.c                   |  22 ++----
 mm/vma.c                           |   8 +-
 mm/vma.h                           |   2 +
 tools/testing/vma/vma_internal.h   |  55 ++++++-------
 9 files changed, 183 insertions(+), 151 deletions(-)


base-commit: 84f7f75fda11c147979984755011c6e2b71e97e1
-- 
2.47.0.338.g60cca15819-goog


