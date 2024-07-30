Return-Path: <linux-kernel+bounces-268068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E81942002
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE461F2431A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB13318C909;
	Tue, 30 Jul 2024 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOgF+9qB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093AA18B494
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 18:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365460; cv=none; b=LCS7CKJBKQnoNIuc/N/nMknDnCULAKAnHuvmYUH0Hre76sZfHM9A1TwSoPi1+FUUTsPp5sl2OvFCRr9rxizxtVgewApWLJxuq6lcdO3CH0/4fcNmMBrc35o03xU7qMSc+zsD7KTBLMChCauHz1MgWnXrerlsudLyRmGKZBGZVuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365460; c=relaxed/simple;
	bh=pqmv76F1WcFutmWjI3wHquYQ2ukivLAaozJiVBwDm7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i85Kb95LBWXMjqO87xGfFGNI7/Tm4J7aT+LURq+sZIxJPT0O37fDkXSBK3wyX04NEGhxT33ELWSdDaZmSKd6Ah5yJnLD1B098w9P2KkWjTRRdodWVGpQjCZ+xxsXYlQKoliwZv9D12FTbH+JX33kfjag2lwbMuCDoUEHv1VUnns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOgF+9qB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C974BC4AF0A;
	Tue, 30 Jul 2024 18:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722365459;
	bh=pqmv76F1WcFutmWjI3wHquYQ2ukivLAaozJiVBwDm7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AOgF+9qBGFqKxJ8z4A6PgTFI5uYlUNekNx9SPS/SqWo35zBpPaiN87qT3ktO1zdzc
	 QMYeHnTcqQxbUhysQGYmIJuey8q1zASAdVZHZpDbQ4KXgeW8lS5IAeIzAW5X/JpYj0
	 b7QuzOIKrpAu8L5rZHQzMcFcCt7JqP852MttQgYl1iRORwFDUhmGoLvRzpOjR6etsA
	 XrX9PPOBBOMCeKCm517hKCADyt6UPMZwI+v7THiGeG8m4+I1h7XwuwyfVv6zs0JqLW
	 6pQZCszlfzoYzSgVnhz4MwQ1sQJINCMAjFtLcTETveHdGHdo7+v/nb1ukBSVJrfJKt
	 EpnCk755lK3gA==
From: Danilo Krummrich <dakr@kernel.org>
To: akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	vbabka@suse.cz
Cc: mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 2/4] mm: vrealloc: consider spare memory for __GFP_ZERO
Date: Tue, 30 Jul 2024 20:49:42 +0200
Message-ID: <20240730185049.6244-3-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730185049.6244-1-dakr@kernel.org>
References: <20240730185049.6244-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zero spare memory when shrinking a buffer with __GFP_ZERO.

Fixes: 1f39ee9615a8 ("mm: vmalloc: implement vrealloc()")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 mm/vmalloc.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 2a6d4ce57b73..6a2fef6378e4 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4077,12 +4077,15 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
 		old_size = get_vm_area_size(vm);
 	}
 
+	/*
+	 * TODO: Shrink the vm_area, i.e. unmap and free unused pages. What
+	 * would be a good heuristic for when to shrink the vm_area?
+	 */
 	if (size <= old_size) {
-		/*
-		 * TODO: Shrink the vm_area, i.e. unmap and free unused pages.
-		 * What would be a good heuristic for when to shrink the
-		 * vm_area?
-		 */
+		/* Zero out spare memory. */
+		if (want_init_on_alloc(flags))
+			memset((void *)p + size, 0, old_size - size);
+
 		return (void *)p;
 	}
 
-- 
2.45.2


