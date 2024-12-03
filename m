Return-Path: <linux-kernel+bounces-430247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8939E2E78
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA84816517E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AA3208997;
	Tue,  3 Dec 2024 21:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uD+Xx8Gz"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D44207A33
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 21:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262915; cv=none; b=ZAwvtB2TfjPdYJVBVVejqOYdyqOGlqHQhOASpCyCiFEn1GLNhwGxZwTB2HtiJjDC1AlCXLpz/NE9amaXSTze1bIwiAQfpHp5FKwxYCIfDrGvMTQjwMF6VFKIz57VHP8ZHdoyIXu3X0pUsovmCiOWZ41CZ02BE8iik8WIPOsiyJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262915; c=relaxed/simple;
	bh=DbB3+W+zR9mlEmXNSQGkwNefwgj0THI1ntUEs5OyIHU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=H5C0rgXCvoGKsGjuW7WVIRVGc+xfmJZyfEIRxC/TFWSiguyQ9bWTjV2A1pK6anLCHhLt2kpPmytSkjf0s7/UG2w+OZ4HUF1lISAgTfwP28EUKevMNajk7aU6yoIR7m459GfEyMtBnQeJAovfa3hHTlkege8x5+ml66WHtfyJTSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uD+Xx8Gz; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7251818c6f0so6897170b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 13:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733262913; x=1733867713; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QSD8wgkYRyCuJ2c9VkWyywpWuyzKvbksPVDwvVq6f5w=;
        b=uD+Xx8GzOIdsPwyRqp8zukQKBC58kiBGMmsjuQ/xQ7HnfSN46sDdC2B9OJuf7cZHhK
         mE3idHtWjmiIl3knKes85ItDRkBmsfbVHCpNDq5xpMqd3lsNYTsGih5HA5+VTL/NRdFm
         SooKAvP9YraD4NyQn2XRbxqj30EHAzu4IvUcjCTsOuejfJkbYqqO8IUIrB3V88GeKDkS
         Cd+Ti9wOY4sXuJtgxOs0UOOjHzYRnq9bnl1W3sA+UKx1D044nqhsZ0URULSCkbAjQZUA
         /LIienWSwPsiI3hjevKY+4vyRkkE9BLL/Ct3gEYWb5Rm7zMq1KBUfNjKuhqqPmBYyUuo
         UXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262913; x=1733867713;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QSD8wgkYRyCuJ2c9VkWyywpWuyzKvbksPVDwvVq6f5w=;
        b=ruPxBOCagzS8tG90KBtwrUPfPatdCIMB3yZqMStUVweBsDwDSTB7S9IpdtDXoNDkS2
         U/hczW08Evr4gS5iZXLBcFspPsrYC1Ag5B7Ki/hFGTE3EeQ9/kfPlyCRNIghPyJVn7NY
         5SvJKXRVD1/5ScZkMC/V4172hVaFh432AUXSX9LHn3mLirvPKlLJ8SL0PseyvpUE/9wZ
         Qs3MGYlJ6+t1ed/WCO3Hx6lVKdDVHQ5JhC/qfb6K7bD6ewe53PH7I1GPwjvJo7dD4kxH
         SayZfEak0kI2z7fRowgfhvcdsCHnEUI/S3A1zNFFzxfA7j7L2t3PEOZxyYQke4Qg+4wO
         Ilxg==
X-Gm-Message-State: AOJu0YxQiDxfp9Yy01W2OLXdZjqHYlMnChLzHhmDkyXcbBGcYARNL135
	dH/m/sAZE1uIL445ivUsuJosZqOvnP3l8YFa1R/ad0/D0dTKQowgy16yOwMiZvS2c0pwrfIHvY/
	ZQMeD0e9KCw==
X-Google-Smtp-Source: AGHT+IHu2upML0o6ibssx9CPRRY9jsUN0JUMtLhuaj39uYxow8Mynm7f6GPBp3/ci0L1uOXxVDOzfByPFdlVWw==
X-Received: from pfbca16.prod.google.com ([2002:a05:6a00:4190:b0:725:30c8:793d])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4654:b0:725:6f2:f160 with SMTP id d2e1a72fcca58-7257fcc5a48mr5442208b3a.24.1733262913571;
 Tue, 03 Dec 2024 13:55:13 -0800 (PST)
Date: Tue,  3 Dec 2024 21:54:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203215452.2820071-1-cmllamas@google.com>
Subject: [PATCH v6 0/9] binder: faster page installations
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Carlos Llamas <cmllamas@google.com>, Alice Ryhl <aliceryhl@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, David Hildenbrand <david@redhat.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Minchan Kim <minchan@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Suren Baghdasaryan <surenb@google.com>, Todd Kjos <tkjos@google.com>, 
	Viktor Martensson <vmartensson@google.com>, Hillf Danton <hdanton@sina.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"

The main focus of these patches is to improve the performance of binder
page installations, primarily by reducing contention on the mmap_lock.
The idea is to allow concurrent page insertion by leveraging per-vma
locking and get_user_pages_remote().

Unfortunately, this required reverting the alloc->lock spinlock back
into a mutex in order to serialize with the shrinker. At least until
finding a better solution e.g. support page zapping with a spinlock.
The trade off is still quite worth it though.

Other patches are also included that remove unsafe and redundant things
such as the alloc->vma pointer or the struct binder_lru_page concept.

Note: I'll work on setting up a page fault handler for binder next.
I believe an idea from Alice Ryhl to deferred the page insertions will
make this finally feasible. I only need to figure out a few performance
bits but if/when done most of the manual page insertion code in binder
could be dropped. :)

Changelog:

v6:
* rework the usage of page->lru and page->index into only page->private
* expanded comments aobut vma validation using alloc->mapped per Suren

v5:
https://lore.kernel.org/all/20241126184021.45292-1-cmllamas@google.com/
* rebase and resolve conflicts with commit da0c02516c50 ("mm/list_lru:
  simplify the list_lru walk callback function")
* add comment to binder_alloc_is_mapped() about valid vma check
* add note to commit log about future page->lru removal
* collect Reviewed-by tags from Suren

v4:
https://lore.kernel.org/all/20241119183250.3497547-1-cmllamas@google.com/
 * add explicit FOLL_NOFAULT to get_user_pages_remote()
 * per-vma locking to shrinker path (per Liam)

v3:
https://lore.kernel.org/all/20241108191057.3288442-1-cmllamas@google.com/
 * collect "Reviewed-by" tags from Suren
 * use full commit subject in revert (not only sha1)
 * add "goto unlock" label for vma_lookup() failures
 * address -ENOMEM error override in separate patch
 * squash "remove alloc->vma" patch into alloc->mapped patch
 * pass 'struct binder_alloc *' to  binder_page_lookup() too
 * factor out individual mmget_not_zero()/mmput_async() calls
 * cleanup binder_page_insert() to avoid using goto
 * document only one mapping allowed per binder instance
 * check binder_alloc_is_mapped() in binder_page_lookup()
 * remove no longer need local page_to_free pointer

v2:
https://lore.kernel.org/all/20241107040239.2847143-1-cmllamas@google.com/
 * fix locking order when upgrading from vma lock to mmap lock
 * switch folio_walk_start() for get_user_pages_remote()
 * release vma/mmap locks and mmput() right after vm_insert_page()
 * add binder_page_alloc() helper for binder_install_single_page()

v1:
https://lore.kernel.org/all/20241105200258.2380168-1-cmllamas@google.com/

Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Barry Song <v-songbaohua@oppo.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Viktor Martensson <vmartensson@google.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Carlos Llamas (9):
  Revert "binder: switch alloc->mutex to spinlock_t"
  binder: concurrent page installation
  binder: select correct nid for pages in LRU
  binder: store shrinker metadata under page->private
  binder: replace alloc->vma with alloc->mapped
  binder: rename alloc->buffer to vm_start
  binder: use per-vma lock in page installation
  binder: propagate vm_insert_page() errors
  binder: use per-vma lock in page reclaiming

 drivers/android/binder.c                |   2 +-
 drivers/android/binder_alloc.c          | 366 +++++++++++++++---------
 drivers/android/binder_alloc.h          |  45 +--
 drivers/android/binder_alloc_selftest.c |  18 +-
 drivers/android/binder_trace.h          |   2 +-
 5 files changed, 269 insertions(+), 164 deletions(-)

-- 
2.47.0.338.g60cca15819-goog


