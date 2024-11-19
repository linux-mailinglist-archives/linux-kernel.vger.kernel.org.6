Return-Path: <linux-kernel+bounces-414830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0219D2E83
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81C0FB2B3A7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8F31D2F55;
	Tue, 19 Nov 2024 18:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="llSGXCo4"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60581D1E9C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732041176; cv=none; b=Q4bNjw0o9SpW1m7QM9eEqCEBTAzSGupY1cnWXtKRTiJxP3yVw9nd0EwZCgKJWfdcuNwQi4wPss0hq5TIwmfVV0YpIXBcykaXflMs5qyDn+bAAC/DpoBwXsdWjXRGAp97+eYKBpc8Y2ybtF6BzT/mLOkjzqYls8V+Pr2RjOOwnrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732041176; c=relaxed/simple;
	bh=8vP33LW5AaA9ZhGr/tfMb2k0un2s7luzhtaIDQEFvV4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=G1h8oTZUtp7D9hRNkXZFNs7mX6NMAb3jr4Rmrpp+OZnyRGGqsN9nDUI9tmNWEZ/7kkfMYUgvBtGyCSK45gKGwtHoLCDyLNDCqKmoLa/ilIlwAFuoCs6augCJX4HQjxrzWiWbi9NQGoauNYjFj/+BEGw85bSNYMblFLtUgvlOwn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=llSGXCo4; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7eb0a32fc5aso1014505a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732041174; x=1732645974; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nIb3A+/NUApiEgcym8ug5fBwSdfGE/gaXNrhMJv7u9Y=;
        b=llSGXCo4RcF6W9iCRqlHHJ9Tj0d7bbkzsT7GQp7by6VxDbCbdJ1WUda+RPEO4m3ItY
         7CpMKEuSDKA9d9KiQSK8/aXVrwEO/r6WDmxMr/PcQvw2anladIQA9VYTPPdblFy8fdVR
         MgiqyR3PcCHwYJpp49oUUWXnd7j2A/R89r1TgpF5XznlK18Ll2/iEEGxl1vilZdxleo6
         8wi5XQojlQeBDjA64z1t8C5Mv8Ualz/HhTAny0n940ON2PdzZbVvSKCP3LvZPJS4uiUP
         f8f2+X+ojhNu4ikIvZO8VwhbX8OQp4VWAVHa0YMI0tbq8SBG6/tWon+9K+GJqhTgrPpi
         0UnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732041174; x=1732645974;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nIb3A+/NUApiEgcym8ug5fBwSdfGE/gaXNrhMJv7u9Y=;
        b=xR9vaf66pK7IgbYgYDgdIQhQ/gryIUWdssq92eM8c6V59EqqX95rJyL72L7dqTUDPP
         50icdrOcs21gNJWSdpiJeoWM7hJU0AYj9+6+8RSC5Z0QVjkuhDHUnF1ULRRI8Hq12xHa
         HjyhAO4v6vPDFj+s7XPcNo1CHkpw/JrHdhy3w4w1tEilioCHP9/+X+tNzpFaiF1P1H5i
         sMjNJdTB+ICkn+A7b/9ywIEbH1EK2AzXB6QjVCif1MSBcgTRhLAGpEDSBWW6f2d1XTqu
         8D0CtGE51zZ5IztgBKINWjP5ONAnMQh3Lg36GV1GOooX/kJrpRnVac13SEBRFNTTR/pW
         1eaA==
X-Gm-Message-State: AOJu0Yw8OmADbgV8rSSmLlZEhPiC1KKoJvt0vucvIORNMGZEClH/bQ/T
	ZHcCw144sz+nuxoagZPNpSq2K0DT+0a9UjeWh9GzFH1lP/e6LicMdgHJDHp7OK4pEkRVUhPRFcG
	fTKj1On/Lpw==
X-Google-Smtp-Source: AGHT+IF+bAMnZmIF1zrKipMtPcsso+ZfXBVuC3SIny1asI+PPc93oPdaeq+T/WEDyeu9nBSOnpW89VHzvlbcMg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a63:77ce:0:b0:7ea:6bf4:3643 with SMTP id
 41be03b00d2f7-7f8c1e99549mr21953a12.0.1732041174096; Tue, 19 Nov 2024
 10:32:54 -0800 (PST)
Date: Tue, 19 Nov 2024 18:32:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241119183250.3497547-1-cmllamas@google.com>
Subject: [PATCH v4 0/9] binder: faster page installations
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

v4:
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
 drivers/android/binder_alloc.c          | 345 ++++++++++++++----------
 drivers/android/binder_alloc.h          |  36 +--
 drivers/android/binder_alloc_selftest.c |  18 +-
 drivers/android/binder_trace.h          |   2 +-
 5 files changed, 233 insertions(+), 170 deletions(-)

-- 
2.47.0.338.g60cca15819-goog


