Return-Path: <linux-kernel+bounces-402239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6849C2559
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C62771C21960
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B5E1AA1C7;
	Fri,  8 Nov 2024 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1vesDG/t"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A531233D80
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731093066; cv=none; b=lWnzTQ9ZR7cmKDH03TWTQ94BMwAcvK43rjiNQE27yMS3A8FuGMB+f0SjOmqFJ51KVpgItDZ9UnDSgpH7C0fxo8TBkDPTDBmyZmg3u+V1JIBb95ur6CFKCaqdWKqXoM8pPycrbsGEUGfbDToRbX/rFRa3jbkVKnzEIig9szqQiFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731093066; c=relaxed/simple;
	bh=WZ2Kom1+nKRUkogibCurGIYHVyMacDQpBSryM40R0ic=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iJG7V/8SyqchRoCNy/MAFHNr9ipk2uPnLhCcDq0yw6TSuLJAswXeFIkQlFe/9HeU+2c9yV2IAPTeW7nXrXJzKVYD5n4F+uc0VaXW6qxqISISpABIBDM/f6gGlL5DFh4tgk0CLERa5+3UoMDZ7g+Aj16Cdn6Szjka3aapA5fGtQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1vesDG/t; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2e2cc47ce63so2352378a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 11:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731093064; x=1731697864; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UIvrcsytp6y/OFvn35fOD1JjYfc/dIdqlG85sSKRsQY=;
        b=1vesDG/tcBnoF16zX3BFmQsQ06WNhjYncpfDWfdEBB6DnruzwC5Z/onBzw1i0mPFV9
         5DsG3YW3QloR6h8kZjK5dAQsEDb7xjvHBN9lOtydCD60I83+wlP3PYLMm79Tsu1XJPk/
         pKZGMJgVmPG0YrwqbWSNmQB3LUKfSUuZgjIxEkTyHPUpcgy+dw+bShyYO8R6d0OrTUCA
         z+KUK6Hvhjs3Xwq3KtK2fBwTWbHQmwHzUSjsdWPBJ3EST8tgC4x1FXqOR4VFMUOCVOB2
         cyFO6OaNwfW+gP/zPZLi4JHtZYc7VHT7dFtwt+Hdzp3YS5wp0XenxSOIWVszNRGL4WGC
         jDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731093064; x=1731697864;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UIvrcsytp6y/OFvn35fOD1JjYfc/dIdqlG85sSKRsQY=;
        b=gr3KpxU1ddCAyU/utH+HS3lu4NEfWbiS0ArE++i7tvDlT0KZb2lebup04CmIqpg/JS
         VmMP99nkgq6xLTsOKtQsgnGi4aXIR0VDNLR00lAfLJDS9ANDHMbMrm7FoQ3cskwprYB6
         VA+om9ObNNmeIgt9lobrixEbADvLLFuYWGQjQ+2rTmDlB7l9w8UoMGk/WftsWACvNFlG
         dMubLhbKDtaQcfEQizunOfOjcnhu991Pjcek5mgGh43HXAN4JX080cusN/HLKhUPs6PK
         reV2NulBIBWF1+Wd06NRfQLb7djtPvAKKJM9BO00UoBbSa9w9sk4P9oN42whrFNrcfak
         dajQ==
X-Gm-Message-State: AOJu0YzuNf6JL/wZz/Dn2u+WsWW6nugSm2iA1IlVgEf22X16UdHLwqqC
	EygY3930+A3mLFo4DgWjjWfC3AlaAVdgY+v4pNVdo5AVH2+cjgWg4reK8u4MNFptEtmL79GDIIJ
	f4Wr9LFPScg==
X-Google-Smtp-Source: AGHT+IEk+U98aQg/lav2dMNcIpK//tliXjuzwSyzcwpSZvej2rEOqI3J0BWqr7cSfHHRkPQOCGtmbu5l705pfQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:90b:3b44:b0:2e9:b45e:32e5 with SMTP
 id 98e67ed59e1d1-2e9b45e3384mr18243a91.2.1731093064427; Fri, 08 Nov 2024
 11:11:04 -0800 (PST)
Date: Fri,  8 Nov 2024 19:10:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241108191057.3288442-1-cmllamas@google.com>
Subject: [PATCH v3 0/8] binder: faster page installations
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

v3:
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

Carlos Llamas (8):
  Revert "binder: switch alloc->mutex to spinlock_t"
  binder: concurrent page installation
  binder: select correct nid for pages in LRU
  binder: remove struct binder_lru_page
  binder: replace alloc->vma with alloc->mapped
  binder: rename alloc->buffer to vm_start
  binder: use per-vma lock in page installation
  binder: propagate vm_insert_page() errors

 drivers/android/binder.c                |   2 +-
 drivers/android/binder_alloc.c          | 313 ++++++++++++++----------
 drivers/android/binder_alloc.h          |  36 +--
 drivers/android/binder_alloc_selftest.c |  18 +-
 drivers/android/binder_trace.h          |   2 +-
 5 files changed, 207 insertions(+), 164 deletions(-)

-- 
2.47.0.277.g8800431eea-goog


