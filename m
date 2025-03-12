Return-Path: <linux-kernel+bounces-558127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4EEA5E200
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72DD43B9E7A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8578242904;
	Wed, 12 Mar 2025 16:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4ZB8b+W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464FC1D8A10
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741798077; cv=none; b=iHMC+oa9Rnu1GiucvpX7zKqxJz9FXVAdsdl/DGZKDniy+DGi639a1qyhGplRQs+PgbVX+RE1exMC/eYSGnlKJmEapqqXv6Ma5a2DJs+hyhQv0J6PPFfbtlHMkiFYLTi5W1b3duo8529aD6f3iP+BkqR06ImedI7VKrPUnpuYcl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741798077; c=relaxed/simple;
	bh=R+e8CTxMlC5a9+cJIUD2kjg5SVKUgmKQ8eqkhBREN1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e9yl11NPLVwH+2H4ljz2afNQVOWEM6lHBBNBDAtdeqZnyW+wV+eokRfJy+eEH+vy7hwLH6nYom+4zv4i5Pu28h5dZRSDTtQvuq+u6XMmBxFohNF2A8lLozvZtBai88HrhDrMfz/xkAR2C9P5oLIOKfKYx4mIoQyM9rPeAfncPJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4ZB8b+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9002EC4CEEA;
	Wed, 12 Mar 2025 16:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741798076;
	bh=R+e8CTxMlC5a9+cJIUD2kjg5SVKUgmKQ8eqkhBREN1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S4ZB8b+WRB9tABLA+kR6BoJJoJsGvVdSB9/bBxdiCpolouipSi4/O7Qr5BGUeLkSa
	 6MUp6ZdCqNSkxP1bPjpjQjhSdjM+rPY6VAeslqbuEn6XMrHwu+jTgZOTI+Jv0GBLPY
	 PDBFfPnRuww0RNcyeKsQ+/xmnVIurib3COiNir+gm57rhKRfGcAnCWDahE5d3Uexoz
	 Ar7bx+A81pamWTcDzuzA255+sPkcOf/2W+e/njmMuT1bWGWNqTxGXhpeJ7tpYH9XxL
	 PRFvWx4rNkCBQbt/vQeqeayLcIgJ0TPgVMF3EASutKH/BhfPkFyxif7enETN7aPvxP
	 peoJCzeWNDWfA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <howlett@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/4] mm/madvise: use is_memory_failure() from madvise_do_behavior()
Date: Wed, 12 Mar 2025 09:47:47 -0700
Message-Id: <20250312164750.59215-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250312164750.59215-1-sj@kernel.org>
References: <20250312164750.59215-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To reduce redundant open-coded checks of CONFIG_MEMORY_FAILURE and
MADV_{HWPOISON,SOFT_OFFLINE} in madvise_[un]lock(), is_memory_failure()
is introduced.  madvise_do_behavior() is still doing the same open-coded
check, though.  Use is_memory_failure() instead.

To avoid build failure on !CONFIG_MEMORY_FAILURE case, implement an
empty madvise_inject_error() under the config.  Also move the definition
of is_memory_failure() inside #ifdef CONFIG_MEMORY_FAILURE clause for
madvise_inject_error() definition, to reduce duplicated ifdef clauses.

Signed-off-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/madvise.c | 49 +++++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 388dc289b5d1..c3ab1f283b18 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1392,7 +1392,32 @@ static int madvise_inject_error(int behavior,
 
 	return 0;
 }
-#endif
+
+static bool is_memory_failure(int behavior)
+{
+	switch (behavior) {
+	case MADV_HWPOISON:
+	case MADV_SOFT_OFFLINE:
+		return true;
+	default:
+		return false;
+	}
+}
+
+#else
+
+static int madvise_inject_error(int behavior,
+		unsigned long start, unsigned long end)
+{
+	return 0;
+}
+
+static bool is_memory_failure(int behavior)
+{
+	return false;
+}
+
+#endif	/* CONFIG_MEMORY_FAILURE */
 
 static bool
 madvise_behavior_valid(int behavior)
@@ -1569,24 +1594,6 @@ int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 }
 #endif /* CONFIG_ANON_VMA_NAME */
 
-#ifdef CONFIG_MEMORY_FAILURE
-static bool is_memory_failure(int behavior)
-{
-	switch (behavior) {
-	case MADV_HWPOISON:
-	case MADV_SOFT_OFFLINE:
-		return true;
-	default:
-		return false;
-	}
-}
-#else
-static bool is_memory_failure(int behavior)
-{
-	return false;
-}
-#endif
-
 static int madvise_lock(struct mm_struct *mm, int behavior)
 {
 	if (is_memory_failure(behavior))
@@ -1640,10 +1647,8 @@ static int madvise_do_behavior(struct mm_struct *mm,
 	unsigned long end;
 	int error;
 
-#ifdef CONFIG_MEMORY_FAILURE
-	if (behavior == MADV_HWPOISON || behavior == MADV_SOFT_OFFLINE)
+	if (is_memory_failure(behavior))
 		return madvise_inject_error(behavior, start, start + len_in);
-#endif
 	start = untagged_addr_remote(mm, start);
 	end = start + len;
 
-- 
2.39.5

