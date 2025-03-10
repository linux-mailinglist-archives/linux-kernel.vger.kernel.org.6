Return-Path: <linux-kernel+bounces-554788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A437FA59DB0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D6E53A6DC5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D99232373;
	Mon, 10 Mar 2025 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1BK93rR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14FC230BF8
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627405; cv=none; b=R9AUVl7jNb7d9xcllD7KgfF0S3sFj/RSkpG94CZ+1r/PHpi9+qzSuC4/Bwd7j1FIxQ8tw+DLpTKP7Mk/FbjqI7tpxAS5U4LJVTJnjozBlpLjcR9/kBaGE1Im26LjaEnpvxBGlir7q2oW+7pocIpzrwEZrteasYWHJyuJFdwf8hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627405; c=relaxed/simple;
	bh=aKpudoyGMo+z+VXYP9y3gu4MvjeTt1j3Cq/sd3oN+kg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jgopt+3IvAu0n9Nxtbr/vb+5c89VqzmS+rgDwd5UGIqljuoq3LoyE5qWmhx5+kALz0eheoseOWCjVVMCeVQBr6cxyDcrSQ7dYQgvjBOiyZrWZ4nTvmOcqfyvR3GL/gyuNBrivbGk+mXmb0OuavntNQw+qAPgVXeuFdGlyPNslp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1BK93rR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF349C4CEE5;
	Mon, 10 Mar 2025 17:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741627405;
	bh=aKpudoyGMo+z+VXYP9y3gu4MvjeTt1j3Cq/sd3oN+kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e1BK93rRkUd3fN3j1E7lnnyaxNRQGTW5BEIjfLCMLxhVvoBz+4jSN85j3VHnm26J6
	 3ZruHED9gH/KJIR2LwXrwm83oumL2S0dnHxf56U2+HlbZZlVPURpjRX5+KJ0dzTjAY
	 WVGyOAvhEvEh2nwRjdApfUatSmV5bdVGpbVs0cfxEwEuf6SyXlKjjW3gtiKAByCuy7
	 coXHx5hVZzpuPzyjBbvt+Mgxj6vZqqm30Kxl8DKnklVs7qfC/xDvmHJ6KzSBHe0x4z
	 vtTHOMLgSkugJ/9YYnTS2e0AY38HDjWOgp4TvS5tfLyt9gE/ruVGDyrKVtAbKFX7RO
	 GkthFUtl2sOFQ==
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
Subject: [PATCH 1/9] mm/madvise: use is_memory_failure() from madvise_do_behavior()
Date: Mon, 10 Mar 2025 10:23:10 -0700
Message-Id: <20250310172318.653630-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250310172318.653630-1-sj@kernel.org>
References: <20250310172318.653630-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To reduce redundant open-coded checks of CONFIG_MEMORY_FAILURE and
MADV_{HWPOISON,SOFT_OFFLINE} in madvise_[un]lock(), is_memory_failure()
has introduced.  madvise_do_behavior() is still doing the same
open-coded check, though.  Use is_memory_failure() instead.

To avoid build failure on !CONFIG_MEMORY_FAILURE case, implement an
empty madvise_inject_error() under the config.  Also move the definition
of is_memory_failure() inside #ifdef CONFIG_MEMORY_FAILURE clause for
madvise_inject_error() definition, to reduce duplicated ifdef clauses.

Signed-off-by: SeongJae Park <sj@kernel.org>
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

