Return-Path: <linux-kernel+bounces-399296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2489BFD23
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 05:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10F01B22190
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 04:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78001422AB;
	Thu,  7 Nov 2024 04:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r6Szh8dG"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A890915E97
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 04:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730952174; cv=none; b=tXFs0KlCXKyZyxEEM9eBVc9ajQVynIf0LJ3/et/xXmempWCF2T3DqsIHyPbAcpziGSEWoy5cnp/D8ZmcUfJ2DsR7k2gePLgBI95aHMHuF6+7hsu9kKZ8fQdZm2sE7CP2qtpuiMGNQLhmDiEc9QDrhsGHFGkbtbK9CFm4K2s47O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730952174; c=relaxed/simple;
	bh=h5ek5PKdveSRFX4ZHn99sMFLj8YUMdvJK6Ax9AsJHEM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ltqjqL9g5ym/0xTjMHqr1NnEnkMmtkOFw+TS6e1itaU/bSaQauYgyTmHMniAm532IVkBTE68uT3ElOERfm2gj5jJcI6e/Q3oWjRk/CIARCW/KEN1a6PpkZ3LPPRGBp6Ufo6ybeRrp738Gl7uaTQi2X4iyzYXZLZnwS4nB6zt9sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r6Szh8dG; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7eaa7b24162so579396a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 20:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730952172; x=1731556972; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=toXPrqzKY2fAoY/4jTHdOTO9egDn324JXuTJHfPR1ro=;
        b=r6Szh8dG8zQz6HokGTr6zdoBkBG5IuHmJB/ZrcPXoYp5QiDQolJtwwqZPCpFucs//Z
         Os+UpFxBEGgEmz4q6USOhz1zq7hbv/z2cKY6VPZn3kSe6dsXWsSpM92urgrQ0gn4OZWN
         39Vt8lenc7sKptIMX4xHKMkT4yWs2iMTz8CCi4cWRo9JO3y66aUjhXd97aYzREqnSm3y
         Ln8bxmCYw6et+GuTAw3LUmQ99HOytEgBE10nWarpd3FfMQIiy+7z4+6vz8FM2K1Px609
         CTAV7spds1GsH1uxnHcWAWhoAhlZ6KRz5JRUhn1SFNyPmFdhFAogauKv7ojUFF/c3M6Q
         ZSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730952172; x=1731556972;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=toXPrqzKY2fAoY/4jTHdOTO9egDn324JXuTJHfPR1ro=;
        b=PfkZipnOSSZVDH6dNlNEVkQUdDIeHmSRBLtmr/aWn2DejHW7w1MNvvimxjSPt5NxUP
         k+K0hWuiLTmtfFn9cv+dPoWrpbncUfbdIykjayyjpoA3G81Kchhb4EjD++IkTJhlCfja
         bQHFs16R176xcuCXlWM7cQ0VWGUHkCQ7IyLvmlICPg2ckzpzWojb4Sy6bTesT2IK/LeA
         poBKjkcYmiUDkgrovePdkdR+rrZS5+i+1x01V07Rit2OKiCGu5x+fs2bVwh3lID4g0pI
         tkNNc62D6Mc9U+AgKBRh0uQ5eH5LkgnNk8neHaUVHkScoJaX8jkjI1jo41qd/7Wr1NwJ
         gUDw==
X-Gm-Message-State: AOJu0Yyk4Kx1ACE9yd4CbbwyFcFOZil6zw4T0eSvNKGJ0XnEJGoTKjKb
	es7PUkMb4knNfFZ5ec+zlZbpp/Dc7n35DRKayfDuwmBam1LRAvLGtXVF8hoW6ql/Dei0+pqNyfj
	c/mmorO1IKg==
X-Google-Smtp-Source: AGHT+IGSiDZLaR3A3Qff//eLxuZuHr2DpQ4Ou+0UlK9Q+2Wu0exJOwO0695j0RmFWRmRIsOLY43HPld68bmPLw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a02:4488:b0:694:4311:6eb4 with SMTP
 id 41be03b00d2f7-7f4210e67b6mr7111a12.8.1730952171867; Wed, 06 Nov 2024
 20:02:51 -0800 (PST)
Date: Thu,  7 Nov 2024 04:02:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241107040239.2847143-1-cmllamas@google.com>
Subject: [PATCH v2 0/8] binder: faster page installations
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Carlos Llamas <cmllamas@google.com>, Alice Ryhl <aliceryhl@google.com>, 
	David Hildenbrand <david@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, Minchan Kim <minchan@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
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

v2:
 * fix locking order when upgrading from vma lock to mmap lock
 * switch folio_walk_start() for get_user_pages_remote()
 * release vma/mmap locks and mmput() right after vm_insert_page()
 * add binder_page_alloc() helper for binder_install_single_page()

v1:
https://lore.kernel.org/all/20241105200258.2380168-1-cmllamas@google.com/

Cc: Alice Ryhl <aliceryhl@google.com>
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

Carlos Llamas (8):
  Revert "binder: switch alloc->mutex to spinlock_t"
  binder: concurrent page installation
  binder: select correct nid for pages in LRU
  binder: remove struct binder_lru_page
  binder: use alloc->mapped to save the vma state
  binder: remove cached alloc->vma pointer
  binder: rename alloc->buffer to vm_start
  binder: use per-vma lock in page installation

 drivers/android/binder.c                |   2 +-
 drivers/android/binder_alloc.c          | 322 ++++++++++++++----------
 drivers/android/binder_alloc.h          |  35 +--
 drivers/android/binder_alloc_selftest.c |  18 +-
 drivers/android/binder_trace.h          |   2 +-
 5 files changed, 212 insertions(+), 167 deletions(-)

-- 
2.47.0.199.ga7371fff76-goog


