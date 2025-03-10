Return-Path: <linux-kernel+bounces-554790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D33CA59DB8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C15E16C82E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797AE23099F;
	Mon, 10 Mar 2025 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfK2CND5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F53231CB0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627407; cv=none; b=rPhKIRDEogVoZlXfWXODCzYm2yN+zdUGDJT0NSvRjYAy4MStWjwDeglPRZumbd702ody9z+kCuMl1KGhUPkKqP6adJSeBdGKOkjrPacwX/EmYhJHb5MtCQzUEqaUFOoXZX3rFaUgynUMwmQIJjPYrZldpuoo/sJmFGwVaNwx5Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627407; c=relaxed/simple;
	bh=wUeeTxoF6/W5BNmB2wyQPZvoKyORH7hO5pM78LtrSAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C6suPgmxVUUJpGa+mfbkKlMIeyNbbWpwS9G7IGIqLDBPjMXZMCUG0ct7c/CByqfhA9el9aKjVdsQ6yRchj12CGu0+ddw7jwkutlCSKJetpXUTWAoFg7vYx2hiE3HM9mY8Du+D8rsBZK1atPmh2cq7wzi7lEpRomSx+Ek5DrWFZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfK2CND5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3427AC4CEEC;
	Mon, 10 Mar 2025 17:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741627407;
	bh=wUeeTxoF6/W5BNmB2wyQPZvoKyORH7hO5pM78LtrSAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cfK2CND5xWYz9nn8nUacYGS/fBI3F77IP5i/AnejOywNLUUScO7lFdcvtIqseomMj
	 EeJnrxKN9JefLc0Rx5KoOLV0nimE3wn8gMM9f93f+CvKNBenCp2BXokS8fjdiwdmf3
	 R0qA0M9s5Fe9S+kBRKu5nS7Pzh4vE4wTRWzZe8RA28TE9ujg9vagLeypltyUywXpui
	 DWQjz+kPfXe/Ghjo7OpB2glKV/S/A72l3FZVrrNFJR0QOlQKQAjp7Tz2V6EgPm4ql9
	 yASG4MgVpytpi5cvrfDIYPvKpJ55rstceXLqloJMGS4JTTgxOFrEeZzirMoDK+wrpc
	 pvGTGCY2URD0g==
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
Subject: [PATCH 3/9] mm/madvise: deduplicate madvise_do_behavior() skip case handlings
Date: Mon, 10 Mar 2025 10:23:12 -0700
Message-Id: <20250310172318.653630-4-sj@kernel.org>
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

The logic for checking if a given madvise() request for a single memory
range can skip real work, namely madvise_do_behavior(), is duplicated in
do_madvise() and vector_madvise().  Split out the logic to a function
and resue it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/madvise.c | 53 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 611db868ae38..764ec1f2475b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1640,6 +1640,27 @@ static bool is_valid_madvise(unsigned long start, size_t len_in, int behavior)
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
 static bool is_madvise_populate(int behavior)
 {
 	switch (behavior) {
@@ -1747,23 +1768,15 @@ static int madvise_do_behavior(struct mm_struct *mm,
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
@@ -1790,19 +1803,13 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
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

