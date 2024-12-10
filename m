Return-Path: <linux-kernel+bounces-439732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049989EB359
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71AD162BE9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9531AA1F2;
	Tue, 10 Dec 2024 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c3WnWziI"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC4919D082
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841092; cv=none; b=P2Y2Jb9rI4Zhz6VdAi0myY3qhF9I1q2evpX7U/0U1hX1//sPVL9wJiTLmfIYYiRYB8FpIP9FFw+Ffd+7b8d8vOZ7TTewU/9i0lHKSqCqJTwq5t9t2P77ILDw3sJEud+t8M/P5/YQLaRahW7wj+mzs8AwUuGpTqesmwxMfe3tcgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841092; c=relaxed/simple;
	bh=zYZDj7O/8DXdi0j7XT2JtP18Uihoc3dU1VSA7zl8IoQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JvARE4W+T3u8QRJGIJ9z3fA2KyRKmrkR72PPkVlDYvZeVEuYfS3vxeHwiOaxZk0+TF+8rKyl9LCJvdIEi/T8ZX7G4NhVXvPUna+T3B/T0o7RtizrYsanw4cpN8u6wY2NXtLV+kJZpcQjL8TWPwzy7VlvKePGOPToT5D4S6zqY1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c3WnWziI; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7273a901821so1239094b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733841090; x=1734445890; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FmkuUx57s1JTE0N+CeLB+QLHHJrGEBZsK0YmB2Jx/TQ=;
        b=c3WnWziIQOhtZqdGE/WztSg2DIIDLl2rVonfj5HyrXI28JkGUXLBzdNIqEpyfeg+EA
         6CwEBtbz3lBW3rJ+UMNw/M7gTiHhauIen0Qv22p70RwOhnvrHPrHFxdR6yx+35H2xvyU
         KBNqcwkDYEJg9+yWGQBXlGeMV8pOsyxGIddlJhwq1JJCn6np78pquMeM34fvyKNqL5mT
         EUlAJoomSCofH9MCPDNdZQupbn6BweUU5Ddy4U4ZYTfo/xM8ZDh6rJc0g2ddjtvQHHA4
         9Xe2XySOfRTEOyjiH2wTScoaP8Tj9u3Jor3hzHx0GCkGvEpNLBnB7VRKVV4+CAFdekLr
         HASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733841090; x=1734445890;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FmkuUx57s1JTE0N+CeLB+QLHHJrGEBZsK0YmB2Jx/TQ=;
        b=aj2yi8zrxg7m1xpHgszGqheHiXqUNSf1fYnOQz5VTF0O2G/mrbC28SI1U+hz6tULlW
         /JCyzSZjVTn1w3tjG/gL5+yOwP3aa5HZ1TaZe16yhLy0JH/+7BsmHXn7FiaV3GIaKp1T
         lgVXYnSUVVOCljADqKVRNF9FxWbJvxcsxTCYGC2WzX6NNy9wu8OOcs8uzUVm2+Maqkse
         5rvacEqGI1GHTT3rjRO06G18sc/bB9WLg5PLy+a+ZnmAAoLl/5vky9J4tQ5vLUDotQoT
         KdUX4kQnoDgvk+fvDy/8suuDg7C/AmOcKb9NdKX5m+id7nhWsjTa7WzI9XltYBZxHDhS
         BbxA==
X-Gm-Message-State: AOJu0YyPaPGOSvwMZJk8pwEpxFznG0hQrWetZDqETldDwu0fyRM0GFdD
	DM2BPdfztdttkc6Y1MyEiGDpQ5+xdAyaTzh6/YyrxqMMv6PUK7F52p6DH8IuJ92i4fsKXbeh0DS
	9xaMBwghcWg==
X-Google-Smtp-Source: AGHT+IERstfed3cTRUdoWfYl0M0tt8spZ01BbsX0hfdnkmkzLPfHpKiYri2Lc/wwnTc8Dcj/UqOJtWImYx8r3g==
X-Received: from pfav15.prod.google.com ([2002:a05:6a00:ab0f:b0:728:aad0:33a4])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1399:b0:728:e906:e466 with SMTP id d2e1a72fcca58-728e906e795mr1198882b3a.21.1733841089875;
 Tue, 10 Dec 2024 06:31:29 -0800 (PST)
Date: Tue, 10 Dec 2024 14:30:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241210143114.661252-1-cmllamas@google.com>
Subject: [PATCH v7 0/9] binder: faster page installations
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

v7:
* cast page->private to struct binder_shrinker_mdata before kfree()

v6:
https://lore.kernel.org/all/20241203215452.2820071-1-cmllamas@google.com/
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


