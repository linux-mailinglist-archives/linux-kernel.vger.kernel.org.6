Return-Path: <linux-kernel+bounces-558129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8ECA5E202
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E883B4D46
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F27D254847;
	Wed, 12 Mar 2025 16:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0R2BVOR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C71E2505CA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741798079; cv=none; b=lyKQfGDmIM30aN1X744Mq3YYws2G/ltLzkMRQK4yOc2aUPqkNCnMRSgZd92DUUVqw1zmKHzlbM8etj7aUsJieRFxwteC++hHaJ8JmxNDYxy29AvNsnjRd0pnhSPqtuqAy847NwWKwseG4kxPV0qhEBDtMjDFgZ3er0GRyrXH3x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741798079; c=relaxed/simple;
	bh=oQN+mH789PvTmGLvlHTcsIxu+Znjze2S0+wMa1s72FE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J3uU6USs7LhlxE2bRlWIoYkQakAeiXhnioX4DA6IgnPhXKXYv1dRwhaiDv9v+/4K/FKslP49/GL/uaDTEGf3ON/jQf1Z28HBWXLqcKpx31EZxnwTtbk6DPYEA7FKH58ck+zqGUU3vr+wLKG/ogyMWjVTAk2Hj6e5ehxx1jD4b3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0R2BVOR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A71C4CEF0;
	Wed, 12 Mar 2025 16:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741798078;
	bh=oQN+mH789PvTmGLvlHTcsIxu+Znjze2S0+wMa1s72FE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j0R2BVORIe3z3UqUZHwFFZiyYbMSgywv0UHdCOInvRehpN+8M8jbPX0167V/218YG
	 2qliFJ0mz4oVhqtkYaYWxKe2lkFz02tzY6LYW5mtMnMSptWnh8H3l7geT0gB5ZLYIy
	 GVHYLAUraEAbLRgf+zuN+hUBplGQ45BwMF/QUW8U+Kr4AzUqNkDZ6l84Nf6X9mogRg
	 scc7lFkhIPwaxHi8n6+e02hoWJWOEjkGji4YNe88ubCHrlq87dnOx7cgjqWIJjhXO1
	 0P3wJu6fSNnOmmCBXgWmWiycwscR3SABGzd9IFDFN6hf8ssnoDlMvK0CSyDomfjHJH
	 ED5w+PmylaquQ==
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
Subject: [PATCH 3/4] mm/madvise: deduplicate madvise_do_behavior() skip case handlings
Date: Wed, 12 Mar 2025 09:47:49 -0700
Message-Id: <20250312164750.59215-4-sj@kernel.org>
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

The logic for checking if a given madvise() request for a single memory
range can skip real work, namely madvise_do_behavior(), is duplicated in
do_madvise() and vector_madvise().  Split out the logic to a function
and reuse it.

Signed-off-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/madvise.c | 57 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 611db868ae38..ba006d05c7ea 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1640,6 +1640,31 @@ static bool is_valid_madvise(unsigned long start, size_t len_in, int behavior)
 	return true;
 }
 
+/*
+ * madvise_should_skip() - Return if the request is invalid or nothing.
+ * @start:	Start address of madvise-requested address range.
+ * @len_in:	Length of madvise-requested address range.
+ * @behavior:	Requested madvise behavor.
+ * @err:	Pointer to store an error code from the check.
+ *
+ * If the specified behaviour is invalid or nothing would occur, we skip the
+ * operation.  This function returns true in the cases, otherwise false.  In
+ * the former case we store an error on @err.
+ */
+static bool madvise_should_skip(unsigned long start, size_t len_in,
+		int behavior, int *err)
+{
+	if (!is_valid_madvise(start, len_in, behavior)) {
+		*err = -EINVAL;
+		return true;
+	}
+	if (start + PAGE_ALIGN(len_in) == start) {
+		*err = 0;
+		return true;
+	}
+	return false;
+}
+
 static bool is_madvise_populate(int behavior)
 {
 	switch (behavior) {
@@ -1747,23 +1772,15 @@ static int madvise_do_behavior(struct mm_struct *mm,
  */
 int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior)
 {
-	unsigned long end;
 	int error;
-	size_t len;
-
-	if (!is_valid_madvise(start, len_in, behavior))
-		return -EINVAL;
-
-	len = PAGE_ALIGN(len_in);
-	end = start + len;
-
-	if (end == start)
-		return 0;
 
+	if (madvise_should_skip(start, len_in, behavior, &error))
+		return error;
 	error = madvise_lock(mm, behavior);
 	if (error)
 		return error;
-	error = madvise_do_behavior(mm, start, len_in, len, behavior);
+	error = madvise_do_behavior(mm, start, len_in, PAGE_ALIGN(len_in),
+			behavior);
 	madvise_unlock(mm, behavior);
 
 	return error;
@@ -1790,19 +1807,13 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
 	while (iov_iter_count(iter)) {
 		unsigned long start = (unsigned long)iter_iov_addr(iter);
 		size_t len_in = iter_iov_len(iter);
-		size_t len;
-
-		if (!is_valid_madvise(start, len_in, behavior)) {
-			ret = -EINVAL;
-			break;
-		}
+		int error;
 
-		len = PAGE_ALIGN(len_in);
-		if (start + len == start)
-			ret = 0;
+		if (madvise_should_skip(start, len_in, behavior, &error))
+			ret = error;
 		else
-			ret = madvise_do_behavior(mm, start, len_in, len,
-					behavior);
+			ret = madvise_do_behavior(mm, start, len_in,
+					PAGE_ALIGN(len_in), behavior);
 		/*
 		 * An madvise operation is attempting to restart the syscall,
 		 * but we cannot proceed as it would not be correct to repeat
-- 
2.39.5

