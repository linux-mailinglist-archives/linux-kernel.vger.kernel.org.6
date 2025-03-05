Return-Path: <linux-kernel+bounces-547453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC20A50958
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AC6C3A50C1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734FF253B4F;
	Wed,  5 Mar 2025 18:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ia7q5BFn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38EB1C5D4E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198583; cv=none; b=k2ht3Nijnof4XNTF2iV5HYuA+I6r5TJlK/0n+toAaJIW10j64u3UfOhBv4IRi2Gx3fgzaiOX2WVxLfx9ZKK/tNUB/Tl66dNZZpX7a6FFmLuklpoWP2sZ+/4GzKseh/a79GVwAUasWYAVkUlo2RZQJSMDkn5hejS0vO38i4fcsLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198583; c=relaxed/simple;
	bh=Hf/IsCKuh49/H9FxeO83Nv8vZIFMcDB1quEptKUrTMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UxFtrMUjxPSa+gtMmiXvvEUvGBlTcgFUEmKPG2PEs9RfdCV3FovKyuSuoeLvI6Dxrr6nm4IMz+mVEyqLaZYFAFlrg2QqDmiO+YCs5KR+NlJZdj1zVS9cnmkYiR5hh2w6w6b0leVNAETaBHWs0t7j6dds5AI0416AblZqBr3cBIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ia7q5BFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F099C4CEE2;
	Wed,  5 Mar 2025 18:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741198583;
	bh=Hf/IsCKuh49/H9FxeO83Nv8vZIFMcDB1quEptKUrTMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ia7q5BFnvBQEdZiYG/J9924zrl9GGOQcILKyQtO2540WBcXGDi74PQbLvgXupSOUU
	 uRq2YOJyjf13O6CJrtwZp7ybsYd/NWISFt06+mKck3lNr1V6HS+rsBPAtfhYtxAV/m
	 9mGzaCAZQ1VmtWZETYtdNHp93km18Jza5GUnZc8azzucVpDXHQay5QjAfaQ9Rxa6tQ
	 ZEBt05yTnUAhWgCFjAhWlkb4Al10XBa5hpCLWeZ9fUMHELUlrz/Wn7MbpZTN5XSDOz
	 rqOnzF+7m8gCiV6mCEjnfk01x6pPUjmbHD2tvZReVbxf58LtttlkbasvRkWlCQLwkV
	 8w93AORgrrNRQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <howlett@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 03/16] mm/madvise: deduplicate madvise_do_behavior() skip case handlings
Date: Wed,  5 Mar 2025 10:15:58 -0800
Message-Id: <20250305181611.54484-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250305181611.54484-1-sj@kernel.org>
References: <20250305181611.54484-1-sj@kernel.org>
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
and resue it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/madvise.c | 53 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 4a91590656dc..265b325d8829 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1633,6 +1633,27 @@ static bool is_valid_madvise(unsigned long start, size_t len_in, int behavior)
 	return true;
 }
 
+/*
+ * madvise_should_skip() - Return if an madivse request can skip real works.
+ * @start:	Start address of madvise-requested address range.
+ * @len_in:	Length of madvise-requested address range.
+ * @behavior:	Requested madvise behavor.
+ * @err:	Pointer to store an error code from the check.
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
 static bool is_memory_populate(int behavior)
 {
 	switch (behavior) {
@@ -1740,23 +1761,15 @@ static int madvise_do_behavior(struct mm_struct *mm,
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
@@ -1783,19 +1796,13 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
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

