Return-Path: <linux-kernel+bounces-422725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 312A99D9D79
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C12A9165538
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6E41DDC10;
	Tue, 26 Nov 2024 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FwCvj5+O"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5075C1D63E8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732646425; cv=none; b=qLN3AfWzQxj9J4qZyDwI8y6nOCs0Z4SEDYjI53OhfkMUzQ7s6nBCIiTWBKG0lCEtFsT5BwPMzB2QSSMCt3mPXUWwtWLVhSvf4b0ADskKZzEJSY/qH7ZbQt2FwOB0P6bfNpwo6G1MpEo5Hz60WhWRozn02Uwa0TXXiZ+aANa5MH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732646425; c=relaxed/simple;
	bh=xHYdAinmb49nDt6GrvqD9upPKXS2wbpQCB3E6TLhxeU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XUZQEEQLnO5K9VbhKTFlj81EBhYCD/B4Ann1GmR2ZajpX09bD7sUpNYa/72H89HLEkfx8Tda84gHO5sfJ/dyHzp/mKQP9TW+d7EC4lcQ3k5ShPwXtjYCogESwcchn1Gz0yt4uqiZJCy5P4G18hS2enAs5hFBoMn4ecoIhY4LPjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FwCvj5+O; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71ec3392c25so6233009b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732646423; x=1733251223; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VwuKV0wbr8IMxN5bbhX8aEAgNFiSI9NXma6MCJRPvOE=;
        b=FwCvj5+OMfcifkvmNMlH97E+FEyhoyp5t7heC/mJblLSSPXYY1z21jkmCDj7Hs7vlj
         z3EmwS3+21SumYnIs57eJTD7cE9ouQmohKRgr1lzdfHrQUiAo1uDeanWHhK2FzLt/tR6
         RzOk7ozOmMhtW9e0DG8SutukOeH+cuqpO3P1l6+8L3DOPQdAZ6fAHJyGv+mB+RdxhIAL
         lt0J8MsQmE8tUk+rRexDFmKFlqub2Zd4P+xj4WPmLYB7fL21/UcUJP8yeTueJp6YEab6
         GeR67QlDuDmqaAH+lHBp6oBo2FRdF9axVfjNsf+tJ02AatT10FMT3qin3QOz4xO6LnCL
         c1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732646423; x=1733251223;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VwuKV0wbr8IMxN5bbhX8aEAgNFiSI9NXma6MCJRPvOE=;
        b=BnoZyf5Ib3DBSI1mR0d6krjoi4MOml37+KdU9flJnSY7HjGV2ROgGDNtHcMSPsFfew
         ngEqh+qRisNjdh44eTuDlp5QP3Z5VZkMuM5JsripMLxAqzp+R4FU3coRb1YAM06C9pBd
         JBoTZMXpxKqD1jQ74j23eoHBgsvjTFGK/M5Vz9TZw1XBOA1FgLABq7vk7cd4tV5oMDAx
         oXfZvDfEhfWOdbJ65sz1vjl+wGKBPrinjOO8ivXubCFNaG29iZN6pRx2GGVoKZj30cKS
         FYDwYvOEZtGuj5UoJgbR3RCv4w4t4UnZRxHToYsB21q66oyHy0UdhzEqq+ushGOtAGEa
         ZSCg==
X-Gm-Message-State: AOJu0Yw2owgh8msSc7y9WIOzVBir8kGKRtXcCCYELtoVdgaIjRgV5OSz
	hK4MaJe8x8E3p9M/8312z6JOXqL/FzLrYnBhcv8g1SVNecEj6bZXTkfKGP0mf/yuxCR3OBMRpOY
	h1rp2KXprKw==
X-Google-Smtp-Source: AGHT+IEM5hGHhmAVE9RGs0JriCZc/mLvJYHYsn9byz4/lVJXi2C6+IC3AAAU+/RYezZT1ynW+W4ut5xrLZDGVg==
X-Received: from pfbbt21.prod.google.com ([2002:a05:6a00:4395:b0:725:2d4:b5b])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:228b:b0:718:ea3c:35c3 with SMTP id d2e1a72fcca58-72530072163mr266196b3a.15.1732646423610;
 Tue, 26 Nov 2024 10:40:23 -0800 (PST)
Date: Tue, 26 Nov 2024 18:40:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241126184021.45292-1-cmllamas@google.com>
Subject: [PATCH v5 0/9] binder: faster page installations
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

v5:
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
  binder: remove struct binder_lru_page
  binder: replace alloc->vma with alloc->mapped
  binder: rename alloc->buffer to vm_start
  binder: use per-vma lock in page installation
  binder: propagate vm_insert_page() errors
  binder: use per-vma lock in page reclaiming

 drivers/android/binder.c                |   2 +-
 drivers/android/binder_alloc.c          | 346 +++++++++++++++---------
 drivers/android/binder_alloc.h          |  36 +--
 drivers/android/binder_alloc_selftest.c |  18 +-
 drivers/android/binder_trace.h          |   2 +-
 5 files changed, 234 insertions(+), 170 deletions(-)

-- 
2.47.0.338.g60cca15819-goog


