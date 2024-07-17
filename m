Return-Path: <linux-kernel+bounces-255762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DCD9344CF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0CF1F223F9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8277710F;
	Wed, 17 Jul 2024 22:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVb1qGaN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC2E770E1;
	Wed, 17 Jul 2024 22:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721255118; cv=none; b=BwSAUgZ4PYHUyp8FoBjtuGimCsDR2tIfHEvJegt0irgmxY7rWwXLNfoa2qWjOuwp+A9aXr1WuJD/fQFPjEHpP8TxclCgOa8+d2ZTbWPmmOxte6s80MsGEAo77LLGNFnJmHmsiho49+ozsAC8P+laEOc1nzALq9biAMaiTLxJnqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721255118; c=relaxed/simple;
	bh=OH7w4hEU9ChwjQWvmRyr95FS1DYgivolB3TlsPr5q2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=piAbhj7Got71o4y8ctuKmKLPGbwvF36PXr5SfYCKmYyHrWuqsj1Ab3PN2aHVD7NwtR5NChSy6TO7xIby2wjjFlfTek3V1QSAy/YGiM2FcK0xH+QODe/tUL2N7WSznOR1R8N5ck4yyAkClgMYm/HpTIlIHVqehyVvhAlPpSnpGy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVb1qGaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6C3C2BD10;
	Wed, 17 Jul 2024 22:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721255117;
	bh=OH7w4hEU9ChwjQWvmRyr95FS1DYgivolB3TlsPr5q2g=;
	h=From:To:Cc:Subject:Date:From;
	b=sVb1qGaNdjANFyXnfEpOeB+aGu0hyTo1BiSu7LkDmNq0K+fNX97TjKF13kvYElFVP
	 IZcWC1NnBW50uLWI1Ge5ViB1d/nU3IINis5Pz3gqbzJdZtayMsMz/lHywchCfbCx0N
	 IfX8LpbJZQNLGoz/XXxeRuYWMgcKWri/tfq7OnfpL6tg+k57GtI4JK/UCSV3wjOtzd
	 3cx4IiHjdcQ3B3he81CVrZOTBvYMEDU375wxcyZsEpYWj49wSPLaRovN9NwWj1MCfr
	 tixPHXgf58WKAXnSfxdDk68DJ1UMiorFjLo1R2J30zKe8KhATBzHlxbrIr6RjYhhZc
	 ossw8PjcbNA+A==
From: Danilo Krummrich <dakr@kernel.org>
To: cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com,
	urezki@gmail.com,
	hch@infradead.org,
	kees@kernel.org,
	ojeda@kernel.org,
	wedsonaf@gmail.com,
	mhocko@kernel.org,
	mpe@ellerman.id.au,
	chandan.babu@oracle.com,
	christian.koenig@amd.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 0/2] Align kvrealloc() with krealloc()
Date: Thu, 18 Jul 2024 00:24:00 +0200
Message-ID: <20240717222427.2211-1-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Besides the obvious (and desired) difference between krealloc() and kvrealloc(),
there is some inconsistency in their function signatures and behavior:

 - krealloc() frees the memory when the requested size is zero, whereas
   kvrealloc() simply returns a pointer to the existing allocation.

 - krealloc() behaves like kmalloc() if a NULL pointer is passed, whereas
   kvrealloc() does not accept a NULL pointer at all and, if passed, would fault
   instead.

 - krealloc() is self-contained, whereas kvrealloc() relies on the caller to
   provide the size of the previous allocation.

Inconsistent behavior throughout allocation APIs is error prone, hence make
kvrealloc() behave like krealloc(), which seems superior in all mentioned
aspects.

In order to be able to get rid of kvrealloc()'s oldsize parameter, introduce
vrealloc() and make use of it in kvrealloc().

Making use of vrealloc() in kvrealloc() also provides oppertunities to grow (and
shrink) allocations more efficiently. For instance, vrealloc() could be
optimized to extend the existing allocation if there is enough contiguous space
left in the virtual address space at the end of the existing allocation.

Besides the above, those functions are required by Rust's allocator abstractons
[1] (rework based on this series in [2]). With `Vec` or `KVec` respectively,
potentially growing (and shrinking) data structures are rather common.

The patches of this series can also be found in [3].

[1] https://lore.kernel.org/lkml/20240704170738.3621-1-dakr@redhat.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/mm
[3] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=mm/krealloc

Danilo Krummrich (2):
  mm: vmalloc: implement vrealloc()
  mm: kvmalloc: align kvrealloc() with krealloc()

 arch/powerpc/platforms/pseries/papr-vpd.c |  5 +-
 drivers/gpu/drm/drm_exec.c                |  3 +-
 fs/xfs/xfs_log_recover.c                  |  2 +-
 include/linux/slab.h                      |  3 +-
 include/linux/vmalloc.h                   |  4 ++
 kernel/resource.c                         |  3 +-
 lib/fortify_kunit.c                       |  3 +-
 mm/util.c                                 | 72 ++++++++++++++++-------
 mm/vmalloc.c                              | 58 ++++++++++++++++++
 9 files changed, 118 insertions(+), 35 deletions(-)


base-commit: 51835949dda3783d4639cfa74ce13a3c9829de00
-- 
2.45.2


