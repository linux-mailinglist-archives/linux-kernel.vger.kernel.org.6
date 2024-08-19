Return-Path: <linux-kernel+bounces-292564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBA4957153
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989BC280FAE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C011836D9;
	Mon, 19 Aug 2024 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="InCkFM1M"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B21B4965C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086798; cv=none; b=dd13EaT2QiKeNBxQmRTec7Nti+2+dV8iqTZRGHiDmGpVlgEIbPHisgQZeU5GRMVBCBLgc2AHy1foY+XUb+F5MhAeHVmlt1Te9HKptZsryo94bQWWY1o42jNWaG/9Q4/i7ceybVvj7Nk9wRRQhQAmxrd6lzsHNaXX31CtsZhMU9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086798; c=relaxed/simple;
	bh=qOuZdWRaYDtDFie7Yrv2Cpm1w9fywWO2Be43vt3s0Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jle6vSglg6XxeuhH93h8DqdLT8tDxovRogoQSuBJNi1owvpvuPvAPOzm+pVERlRklULuF3SFvJZOLWlIzEq5UoWkV0t8RP6gk2OKTZb6ZBb4NsY2mbHhcyj5cCTbFk4u6sugDp7zXwNZUyUf/NvqMkCAFuUDZlZW5n2vx5sNFyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=InCkFM1M; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724086791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kKuznSHVKOAD8W6MNwYSvOJK+gK2BxjqJ5/MxUgG64A=;
	b=InCkFM1MbvNvcveMR+59By9WKxgpUCCys2KFJTnIurA48rd1UMASUYbD584yNzmXpxNt7Z
	0trcOtedtpakc+kCFQwTPawRAvhh/Pj59COB4MOtbf44+c3YZAzy8D++wBe4JkblhkNI4C
	iG5phKNb9ZiYRKLfB52f9IZTny/r42U=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: rcu@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] rcu_pending
Date: Mon, 19 Aug 2024 12:59:26 -0400
Message-ID: <20240819165939.745801-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

New data structure for tracking objects waiting on an RCU grace period.
Supports regular RCU and SRCU, and possibly other RCU flavors in the
future. Uses radix trees for tracking pending objects, falling back to
linked lists on allocation failure.

This gets us a more general replacement for SLAB_TYPESAFE_BY_RCU, and a
cleaner and slightly faster backend for kvfree_call_rcu(), and
in the future a faster backend for call_rcu() as well.

There's still some small todo items, mentioned in the relevant patches.

Paul - I'm considering putting this into 6.11 for bcachefs (not the
patch that switches kvfree_rcu, of course), as I need it rather
pressingly. Thoughts? I can put it in fs/bcachefs/ if you hate it :)

Kent Overstreet (9):
  lib/generic-radix-tree.c: genradix_ptr_inlined()
  lib/generic-radix-tree.c: add preallocation
  darray: lift from bcachefs
  vmalloc: is_vmalloc_addr_inlined()
  rcu: delete lockdep_assert_irqs_enabled() assert in
    start_poll_synchronize_rcu_common()
  rcu: rcu_pending
  bcachefs: Rip out freelists from btree key cache
  bcachefs: key cache can now allocate from pending
  rcu: Switch kvfree_rcu() to new rcu_pending

 MAINTAINERS                             |   7 +
 fs/bcachefs/Makefile                    |   1 -
 fs/bcachefs/btree_key_cache.c           | 406 +++----------
 fs/bcachefs/btree_key_cache_types.h     |  18 +-
 fs/bcachefs/btree_node_scan_types.h     |   2 +-
 fs/bcachefs/btree_types.h               |   5 +-
 fs/bcachefs/btree_update.c              |   2 +
 fs/bcachefs/btree_write_buffer_types.h  |   2 +-
 fs/bcachefs/disk_accounting_types.h     |   2 +-
 fs/bcachefs/fsck.c                      |   2 +-
 fs/bcachefs/journal_io.h                |   2 +-
 fs/bcachefs/journal_sb.c                |   2 +-
 fs/bcachefs/sb-downgrade.c              |   3 +-
 fs/bcachefs/sb-errors_types.h           |   2 +-
 fs/bcachefs/sb-members.h                |   2 +-
 fs/bcachefs/subvolume.h                 |   1 -
 fs/bcachefs/subvolume_types.h           |   2 +-
 fs/bcachefs/thread_with_file_types.h    |   2 +-
 fs/bcachefs/util.h                      |  29 +-
 {fs/bcachefs => include/linux}/darray.h |  59 +-
 include/linux/darray_types.h            |  22 +
 include/linux/generic-radix-tree.h      | 106 +++-
 include/linux/mm.h                      |   7 +
 include/linux/rcu_pending.h             |  27 +
 init/main.c                             |   2 +
 kernel/rcu/Makefile                     |   2 +-
 kernel/rcu/pending.c                    | 623 ++++++++++++++++++++
 kernel/rcu/tree.c                       | 747 ------------------------
 kernel/rcu/update.c                     |   1 -
 lib/Makefile                            |   2 +-
 {fs/bcachefs => lib}/darray.c           |  12 +-
 lib/generic-radix-tree.c                |  80 +--
 mm/vmalloc.c                            |   4 +-
 33 files changed, 962 insertions(+), 1224 deletions(-)
 rename {fs/bcachefs => include/linux}/darray.h (66%)
 create mode 100644 include/linux/darray_types.h
 create mode 100644 include/linux/rcu_pending.h
 create mode 100644 kernel/rcu/pending.c
 rename {fs/bcachefs => lib}/darray.c (57%)

-- 
2.45.2


