Return-Path: <linux-kernel+bounces-547454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B8DA50967
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5F91882D27
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBA6253B79;
	Wed,  5 Mar 2025 18:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XifHhBB9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1E9253B67
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198584; cv=none; b=F2hD6ILZKLXSi5UXrEyekUAWoqQ3KGZDoCXi2nAeZsjdA5setm+IwMdJFrcTIB2kyQL0NYBtgLbyyCI4mVH8fodwN9HJwTHwqm3puagzPPNhVHWtyqZuoAczd0dLfhIjwq8YskRfUChL1Y+ujRomDoJMuyWtUH2HtD92brNREkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198584; c=relaxed/simple;
	bh=4+ggVfIvFgjcdAiiBX8MuJhj0bQWEcWPio982NmoaDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rR2Jr1uH5M67WSX/hcRfl4Ptxlze2K7XoWJ7H9JtRxY0b43WSdUvkrzGqps9VtWDdPXzMclWKALfYFGpMOKyOkdttb5c0xinUeAup9lRHIW6GbvcQlYvcDoIcWFdLY9zlbOSMEdg7E9AoarH7Y+qvCdZMBdQT79OXkVP5AJaUqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XifHhBB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93788C4CEE9;
	Wed,  5 Mar 2025 18:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741198584;
	bh=4+ggVfIvFgjcdAiiBX8MuJhj0bQWEcWPio982NmoaDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XifHhBB9EGx7WTdY5Gq0ixSMzm4RkQK0ZqOZ9h5RteCQnJpOLL7PXW1hXZgCieJA9
	 bwRB8sDJVdiADPtwYVrSaV16QQDvsSjJXn+pyfHS0EDC707FUaUPhiSjwVtM3Oh0VI
	 9TwicXQjUUfeNlDPCuG4B+7B6aoA7+GLOw+mIhbRTl1E3iXz9ucdlFnYQXLTfXOSkM
	 VSAmDDuARX2Rkz42f/sh9oUZ4giZ4AJ7MkwEZC95GbWgJq0KLCQP+qH0x17J9/cn0M
	 pq1OiyZJ1eNsUiztLw9lmF4XyWY7x7T6q8DSyrjAxc9DQmXHpz62zgUp8YpDW+2c5/
	 XDl0CABH8E5Uw==
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
Subject: [RFC PATCH 04/16] mm/madvise: remove len parameter of madvise_do_behavior()
Date: Wed,  5 Mar 2025 10:15:59 -0800
Message-Id: <20250305181611.54484-5-sj@kernel.org>
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

Because madise_should_skip() logic is factored out, making
madvise_do_behavior() calculates 'len' on its own rather then receiving
it as a parameter makes code simpler.  Remove the parameter.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/madvise.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 265b325d8829..c5e1a4d1df72 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1666,7 +1666,7 @@ static bool is_memory_populate(int behavior)
 }
 
 static int madvise_do_behavior(struct mm_struct *mm,
-		unsigned long start, size_t len_in, size_t len, int behavior)
+		unsigned long start, size_t len_in, int behavior)
 {
 	struct blk_plug plug;
 	unsigned long end;
@@ -1675,7 +1675,7 @@ static int madvise_do_behavior(struct mm_struct *mm,
 	if (is_memory_failure(behavior))
 		return madvise_inject_error(behavior, start, start + len_in);
 	start = untagged_addr_remote(mm, start);
-	end = start + len;
+	end = start + PAGE_ALIGN(len_in);
 
 	blk_start_plug(&plug);
 	if (is_memory_populate(behavior))
@@ -1768,8 +1768,7 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
 	error = madvise_lock(mm, behavior);
 	if (error)
 		return error;
-	error = madvise_do_behavior(mm, start, len_in, PAGE_ALIGN(len_in),
-			behavior);
+	error = madvise_do_behavior(mm, start, len_in, behavior);
 	madvise_unlock(mm, behavior);
 
 	return error;
@@ -1801,8 +1800,7 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
 		if (madvise_should_skip(start, len_in, behavior, &error))
 			ret = error;
 		else
-			ret = madvise_do_behavior(mm, start, len_in,
-					PAGE_ALIGN(len_in), behavior);
+			ret = madvise_do_behavior(mm, start, len_in, behavior);
 		/*
 		 * An madvise operation is attempting to restart the syscall,
 		 * but we cannot proceed as it would not be correct to repeat
-- 
2.39.5

