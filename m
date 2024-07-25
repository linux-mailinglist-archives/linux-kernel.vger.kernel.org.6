Return-Path: <linux-kernel+bounces-262301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E5A93C3CF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3863E1C2174A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5254319CD0D;
	Thu, 25 Jul 2024 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmkjug9L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FD3C8DF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 14:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721916755; cv=none; b=Z16aCOAK5a74EAqxOeQ35bFWWwNs0MNGTgXA8L4Aim0lZqqdyNDKQ/s0FnxBs2jTOg5G0H/VyA6S6NbpM+IfjJd5ZDcso3w3z7hJQpU/AHt8YuShhE+2Z77UM7KEUZiPUJ9o496iEbXwTu6Cy8MXTLL6ASh8R5WtXRwh9DNQu34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721916755; c=relaxed/simple;
	bh=YpwqHwqCxbfGR5XXSyE8NyczHvTRd1aASBcmjNjGQQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CDBYIzZheLTPKu4Hx/YSwZNbHE/xv/k0+aMIeAsfv/WPiIrjhqxr2WsUJcsqGT4LkyOjvSRztn343uG1hzBauj8rb6ZRxxYdCyD8BcVR+jQB+b1PT+xLPOwo1wn0Xpw+DA1QO6NYP8WN4Fl5GEuw668rxhHyX6J/nUvggniRAFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmkjug9L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B63C32782;
	Thu, 25 Jul 2024 14:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721916755;
	bh=YpwqHwqCxbfGR5XXSyE8NyczHvTRd1aASBcmjNjGQQE=;
	h=From:To:Cc:Subject:Date:From;
	b=hmkjug9L8/38AbPc3btxpTvCLxDuEkibXU4G0LhcmOsaWvhd4hV7YNYU5ko1nkEXe
	 Ti3FNCOBa7gF+MbPAYIFgSYqfgFvPEJlQp/R486ap/LGJzb3vO3NT22G41443SK5MG
	 b/Z9XHA5eyEefs9yCB6/ZNfKeozgv+s8OizIAovj+tiwwGi2YbwAZNQHUmBVsn3Fb7
	 zVI52lzbHrpKUkmFHCoEbKKPeqwJpDUMk68R0DMjHVSeXPF66TZ7KnJ9+cgdFCa8kf
	 RKdLnG19G9CYP2gnw2glgTEQC1HCwLRbLFaGXy9MfAhexdosXm/l86GFXRc6AX4zys
	 olbjmKMGHAWhw==
From: Danilo Krummrich <dakr@kernel.org>
To: akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org
Cc: mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH] mm: vrealloc: fix missing nommu implementation
Date: Thu, 25 Jul 2024 16:11:59 +0200
Message-ID: <20240725141227.13954-1-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5ec6d992f460 ("mm: vmalloc: implement vrealloc()") introduces
vrealloc(), but lacks the implementation of the nommu version of this
function.

Note that currently nommu isn't actually broken without this. The only
user, kvrealloc(), never actually calls into vrealloc() with nommu, since
it's guarded by is_vmalloc_addr(), which for nommu always returns false.

However, since this becomes a real issue once vrealloc() is used by
other code, fix this.

Fixes: 5ec6d992f460 ("mm: vmalloc: implement vrealloc()")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
@Andrew: I picked up the commit id from mm/mm-unstable, which probably
isn't correct / will change.

Please let me know if you'll take care or if you want me to just send a
v3 of the original series.
---
 mm/nommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/nommu.c b/mm/nommu.c
index 7296e775e04e..40cac1348b40 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -126,6 +126,11 @@ void *__vmalloc_noprof(unsigned long size, gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(__vmalloc_noprof);
 
+void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
+{
+	return krealloc_noprof(p, size, (flags | __GFP_COMP) & ~__GFP_HIGHMEM);
+}
+
 void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 		unsigned long start, unsigned long end, gfp_t gfp_mask,
 		pgprot_t prot, unsigned long vm_flags, int node,

base-commit: d270beaca6818349b2aed7e6034b800a777087cc
-- 
2.45.2


