Return-Path: <linux-kernel+bounces-547457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570DCA50963
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2151165B24
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BBD254AE8;
	Wed,  5 Mar 2025 18:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJNXUPRx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E39D254860
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198588; cv=none; b=U+JQ+BYq4vuSWTnmhdG8oZi6CYHOdgGJVCCx4qYbzrxfGDTqa1UWRE+cpzIob6RrE/HLXyqN/Pwa1jaWmMXlErDdkgtgU5qQwjZLVTdYeYrHEKV0Lw/PFtZUhCMas/4aZtulCpUemL/UrizznKr0XUgTeVnaj8/I7VlA2VKE7VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198588; c=relaxed/simple;
	bh=3LG3O8N+F8TPPzR8Mb+NGODzxzconMM3ZSxJjGwNDUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n28+wb0yq0740JVdFeAnQBMBrqqxOEKq7ypTiZqp6iaUBwEQEZRAtqO+8TS8caSJlVluaI9ZhZ5qqz0XV9WP+Yay3/xbU6mfSFgktdbufO0DPyT8V2CMWYAEpyyUXHaokpXHVwFaGZwGo/EjpSNUL2z7xYU8PtZD9uys4W1dGrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJNXUPRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25D9C4CED1;
	Wed,  5 Mar 2025 18:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741198588;
	bh=3LG3O8N+F8TPPzR8Mb+NGODzxzconMM3ZSxJjGwNDUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NJNXUPRxqjS1gIwtMlxNbHOdcW9b79WtuUL9PyyAEjlIn+Vmdx0iNdtdhmifJPV/R
	 GCVbmonJu8xRM/kk1GlHomD/e5U5XgM1Mb4hpN+hhnvzr0gKLqLDQ6Kgx4D530bHXB
	 Gme7DF42kCSOhJa6YAaCSpl/2/uZLtNh3bZ4RcoB8CGYExP2VclEe8CSPjg7C7oPfq
	 0CWC2UoS3J+VTBFxclXBq8041eB+Tr3mNqQTsnpMPctCSCNU8Caa8ZF3vNxC4wlPuT
	 Xf7drlusvq8z2sRG9d+2OvVKAG+6QfWdADuPevd6T8pyRWvg80ned9ISgfgActsxyB
	 dJGUsCap7Ys/g==
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
Subject: [RFC PATCH 07/16] mm/madvise: make madvise_walk_vmas() visit function receives a void pointer
Date: Wed,  5 Mar 2025 10:16:02 -0800
Message-Id: <20250305181611.54484-8-sj@kernel.org>
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

madvise_walk_vmas() is used for two visit functions, namely
madvise_vma_anon_name() and madvise_walk_vmas().  The visit function
type is defined to receive an 'unsigned long' type argument.  But, both
visit functions need a pointer argument, so casting the arguments
between 'unsinged long' and the real pointer types.  It is more
idiomatic and clean to use a void pointer type for such cases.  Update
the visit function type to receive a void pointer as the argument and
cleanup the type-casting code.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/madvise.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 8c4c128eaeb7..6fa7dabe5bad 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1253,9 +1253,9 @@ struct madvise_behavior {
 static int madvise_vma_behavior(struct vm_area_struct *vma,
 				struct vm_area_struct **prev,
 				unsigned long start, unsigned long end,
-				unsigned long behavior_arg)
+				void *behavior_arg)
 {
-	struct madvise_behavior *arg = (struct madvise_behavior *)behavior_arg;
+	struct madvise_behavior *arg = behavior_arg;
 	int behavior = arg->behavior;
 	int error;
 	struct anon_vma_name *anon_name;
@@ -1468,10 +1468,10 @@ static bool process_madvise_remote_valid(int behavior)
  */
 static
 int madvise_walk_vmas(struct mm_struct *mm, unsigned long start,
-		      unsigned long end, unsigned long arg,
+		      unsigned long end, void *arg,
 		      int (*visit)(struct vm_area_struct *vma,
 				   struct vm_area_struct **prev, unsigned long start,
-				   unsigned long end, unsigned long arg))
+				   unsigned long end, void *arg))
 {
 	struct vm_area_struct *vma;
 	struct vm_area_struct *prev;
@@ -1529,7 +1529,7 @@ int madvise_walk_vmas(struct mm_struct *mm, unsigned long start,
 static int madvise_vma_anon_name(struct vm_area_struct *vma,
 				 struct vm_area_struct **prev,
 				 unsigned long start, unsigned long end,
-				 unsigned long anon_name)
+				 void *anon_name)
 {
 	int error;
 
@@ -1538,7 +1538,7 @@ static int madvise_vma_anon_name(struct vm_area_struct *vma,
 		return -EBADF;
 
 	error = madvise_update_vma(vma, prev, start, end, vma->vm_flags,
-				   (struct anon_vma_name *)anon_name);
+				   anon_name);
 
 	/*
 	 * madvise() returns EAGAIN if kernel resources, such as
@@ -1570,7 +1570,7 @@ int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 	if (end == start)
 		return 0;
 
-	return madvise_walk_vmas(mm, start, end, (unsigned long)anon_name,
+	return madvise_walk_vmas(mm, start, end, anon_name,
 				 madvise_vma_anon_name);
 }
 #endif /* CONFIG_ANON_VMA_NAME */
@@ -1689,8 +1689,7 @@ static int madvise_do_behavior(struct mm_struct *mm,
 	if (is_memory_populate(behavior))
 		error = madvise_populate(mm, start, end, behavior);
 	else
-		error = madvise_walk_vmas(mm, start, end,
-					  (unsigned long)madv_behavior,
+		error = madvise_walk_vmas(mm, start, end, madv_behavior,
 					  madvise_vma_behavior);
 	blk_finish_plug(&plug);
 	return error;
-- 
2.39.5

