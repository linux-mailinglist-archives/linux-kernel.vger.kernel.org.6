Return-Path: <linux-kernel+bounces-259202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3A893928F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5361F2330B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B090816EB63;
	Mon, 22 Jul 2024 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhrdBaZI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F378526ACD;
	Mon, 22 Jul 2024 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721665903; cv=none; b=rGVTo/e7y9xbAHxtJQrNlfYow3tyT6xbPnPuY6YdI376ZpoBQsKh5NA6myQIQuwmNV5KvrpCFmoE1/ElHb/5yk9fNCJBLe9X0BfapKJ+JggnF3gnTk+RARS8LXqA1AqpjKgtSHuL4FoDgk8q5p61LOE39QsAk+jtVkC6/J6imGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721665903; c=relaxed/simple;
	bh=CkDc4sr4ZxAi/U/UIXbOEimKRnQn1vJDruoUwJilY5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mXf3KxT9L4cjpI5bQAkLUN0AQmiwG/+wpv9vVon+iyd3dNmGbX6PtDFNTn0fdzGvpL8OmlH6sVs/23Rg2IH9YcHZIuxtOcqbnSw/Y1EKGiQE8hmjtntKT9Gtb4PvFAyHHD0wWWgC+DJHZb8mRRAeXi2Eepybd+X9KoxbvAqiVKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhrdBaZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6ECC116B1;
	Mon, 22 Jul 2024 16:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721665902;
	bh=CkDc4sr4ZxAi/U/UIXbOEimKRnQn1vJDruoUwJilY5E=;
	h=From:To:Cc:Subject:Date:From;
	b=QhrdBaZIfTLINR2GFGCAUAZHlmj3VghRtvcAZr6ak8+xjsLM9/4WV8cW7lKrhI3Iu
	 +hZ4dQkGdUKt251MhyyuQQBPOcEBF8FZHkIs4luk1CdYg4fuaNTyOsSD2DUO/2vqyZ
	 FKiMpdfd/sW5ltp3BCjcZiDzhNyfHB0f1mgK0WYk5AuKhn+Pywnc7BCaZyi4NQ3V3x
	 5qqqtr1/3/Uz5mQNWdNvfT20OdRyhiAqUaSD5hTPCK6NlbTM6L1J1l1gc7GgsUnk4s
	 u51wSKTLz6pp90GldWhJSFEM8k+Ut4eg+nhEKtXssCAbzWFTpAmVMTXT82IwFO0wr4
	 Es6ICwRpaQI3w==
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
	christian.koenig@amd.com,
	maz@kernel.org,
	oliver.upton@linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 0/2] Align kvrealloc() with krealloc()
Date: Mon, 22 Jul 2024 18:29:22 +0200
Message-ID: <20240722163111.4766-1-dakr@kernel.org>
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
shrink) allocations more efficiently. For instance, vrealloc() can be optimized
to allocate and map additional pages to grow the allocation or unmap and free
unused pages to shrink the allocation.

Besides the above, those functions are required by Rust's allocator abstractons
[1] (rework based on this series in [2]). With `Vec` or `KVec` respectively,
potentially growing (and shrinking) data structures are rather common.

The patches of this series can also be found in [3].

[1] https://lore.kernel.org/lkml/20240704170738.3621-1-dakr@redhat.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/mm
[3] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=mm/krealloc

Changes in v2:
 - remove unnecessary extern and move __realloc_size to a new line for
   vrealloc_noprof() and kvrealloc_noprof()
 - drop EXPORT_SYMBOL for vrealloc_noprof()
 - rename to_kmalloc_flags() to kmalloc_gfp_adjust()
 - fix missing NULL check in vrealloc_noprof()
 - rephrase TODO comments in vrealloc_noprof()

Danilo Krummrich (2):
  mm: vmalloc: implement vrealloc()
  mm: kvmalloc: align kvrealloc() with krealloc()

 arch/arm64/kvm/nested.c                   |  1 -
 arch/powerpc/platforms/pseries/papr-vpd.c |  5 +-
 drivers/gpu/drm/drm_exec.c                |  3 +-
 fs/xfs/xfs_log_recover.c                  |  2 +-
 include/linux/slab.h                      |  4 +-
 include/linux/vmalloc.h                   |  4 +
 kernel/resource.c                         |  3 +-
 lib/fortify_kunit.c                       |  3 +-
 mm/util.c                                 | 89 +++++++++++++++--------
 mm/vmalloc.c                              | 59 +++++++++++++++
 10 files changed, 129 insertions(+), 44 deletions(-)


base-commit: 933069701c1b507825b514317d4edd5d3fd9d417
-- 
2.45.2


