Return-Path: <linux-kernel+bounces-547455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 991E2A5096B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C0A21884F9C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D8C18E362;
	Wed,  5 Mar 2025 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuw7cR1M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4CD253F09
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198586; cv=none; b=XttIthAKQ/hWpgzraz0Ozt2NTAGB3+fCuTVkEp4R3xfKTzH/ckJLTTS47WbEC7Ck8QAf/N2eIoLDGVigg915QiYC+sS0ky5XyTQatN3O7wjuVrmLZCxdGpOqmKToaSo+0J5XJOBHbkyi1tS3F3Oz0HFgWGtasRlNMc8aBE+iiY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198586; c=relaxed/simple;
	bh=zA6hArayCI2Rl1M1lVh5I5ZUimJAVrPkFcOBSQrdmgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mq49T+4lXD+aDq4nsrqA6Mzz7Ej53AyHWsym3+7LBmMUT3fj0vudVEKpL/Z0+lzaEh5KCHE4sqGgW/OZ8OrjveZm7SO1Y+8mKDeI4IHzK8f1Iidge5eQamLYb47tyCD1xUIaIszspGrcznQaGLMVcYLk5kObz64aDi2tSFIr9VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuw7cR1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9685C4CED1;
	Wed,  5 Mar 2025 18:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741198585;
	bh=zA6hArayCI2Rl1M1lVh5I5ZUimJAVrPkFcOBSQrdmgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tuw7cR1MHr5aXndjIuHntuhVG2we1MfPpIbDEiWcfzdWAVCjwriV5BA9ak4kJ43J5
	 FqOuVr5sM11QSKbSAQgOlmUL/KObNY95VB9FOfZr/6/PE2woIGfHoPq/nHYSGSzkjv
	 14y/WzbzFk3iklvMwASgDW5TnelJWbMGFd2jponx0g3PkCxDEwXsXbr4Y0c+/OkowP
	 b4J1RfkKX3qpb6iPvKLdJpQYNDNJ8xYZJzm/xv/l24+SW8A5s8VU3AkpxnrVVLoxca
	 Ge4I3F8AKetaxegjk6tf6YcIx1EdcyWgY6x2uyisSlmZ5wpedBfyqHKuLaw8dd2jcL
	 tQw7ln6j3BFgQ==
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
Subject: [RFC PATCH 05/16] mm/madvise: define and use madvise_behavior struct for madvise_do_behavior()
Date: Wed,  5 Mar 2025 10:16:00 -0800
Message-Id: <20250305181611.54484-6-sj@kernel.org>
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

To implement batched tlb flushes for MADV_DONTNEED[_LOCKED] and
MADV_FREE, an mmu_gather object in addition to the behavior integer need
to be passed to the internal logics.  Define a struct for passing such
information together with the behavior value without increasing number
of parameters of all code paths towards the internal logic.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/madvise.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index c5e1a4d1df72..3346e593e07d 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1665,9 +1665,15 @@ static bool is_memory_populate(int behavior)
 	}
 }
 
+struct madvise_behavior {
+	int behavior;
+};
+
 static int madvise_do_behavior(struct mm_struct *mm,
-		unsigned long start, size_t len_in, int behavior)
+		unsigned long start, size_t len_in,
+		struct madvise_behavior *madv_behavior)
 {
+	int behavior = madv_behavior->behavior;
 	struct blk_plug plug;
 	unsigned long end;
 	int error;
@@ -1762,13 +1768,14 @@ static int madvise_do_behavior(struct mm_struct *mm,
 int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior)
 {
 	int error;
+	struct madvise_behavior madv_behavior = {.behavior = behavior};
 
 	if (madvise_should_skip(start, len_in, behavior, &error))
 		return error;
 	error = madvise_lock(mm, behavior);
 	if (error)
 		return error;
-	error = madvise_do_behavior(mm, start, len_in, behavior);
+	error = madvise_do_behavior(mm, start, len_in, &madv_behavior);
 	madvise_unlock(mm, behavior);
 
 	return error;
@@ -1785,6 +1792,7 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
 {
 	ssize_t ret = 0;
 	size_t total_len;
+	struct madvise_behavior madv_behavior = {.behavior = behavior};
 
 	total_len = iov_iter_count(iter);
 
@@ -1800,7 +1808,8 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
 		if (madvise_should_skip(start, len_in, behavior, &error))
 			ret = error;
 		else
-			ret = madvise_do_behavior(mm, start, len_in, behavior);
+			ret = madvise_do_behavior(mm, start, len_in,
+					&madv_behavior);
 		/*
 		 * An madvise operation is attempting to restart the syscall,
 		 * but we cannot proceed as it would not be correct to repeat
-- 
2.39.5

