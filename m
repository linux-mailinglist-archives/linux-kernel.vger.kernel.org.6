Return-Path: <linux-kernel+bounces-569874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A257A6A8C6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7A79188AF9E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECA21E1A05;
	Thu, 20 Mar 2025 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6U/SpBh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD3D1DF25C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481097; cv=none; b=ITquZuM6sTCtPI37dMxfbNjMJ6IfgqwyoZ17Ejc77NVNGmeRT3hYaJL21aoERTliqcADAAoOep3IRB5xl0q5QIokx+b1979Q4QdN8Pa4PyKKvTbfKEJK3hxd5eFgElS7Zf9uUTZ8NxNJ/AW81yGb9n6qfkBJhWri6kanuktINKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481097; c=relaxed/simple;
	bh=V4oXNxWWOCRdo7fmBrP4xpCzkm9kYC6f+LIUB6cElTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h+8+a/Jr8ap7ZgcvpKFQj1CkNA8kIr5CUlEsOcnpNlYuDlt8uHKls3U7UN4Nir1AIPivn61aSBlgeBrB9pLKcBgD3kVBts/HZckAss0Sgp9l91vF+BzsYA0AZ4RGwvobX8jcSl30+YJud3XmvBEQYdQH8Z8FBlnIq2POQtuHpIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6U/SpBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27359C4CEE3;
	Thu, 20 Mar 2025 14:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742481097;
	bh=V4oXNxWWOCRdo7fmBrP4xpCzkm9kYC6f+LIUB6cElTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F6U/SpBhuE3I1INNjTgE2Hl0r2EwD1GxorTXxzE+XnBfWVm5YUJ4fu/tyLPb3BkGy
	 qhyTVeBIiTThHL/w+H82Ry4tqZAQztepZxl+Fa6wyz9E1FJS2oBTfUUPcBXwTCYWdU
	 LX3sHRycitwatKyfFkaQHlkOiWAhnZwWqkrecvIbzYZBS94F6P0JEpFilXo1PHUTYP
	 GQEXYLTFPzxmqc3l6HBnyrHPOpOKuWyFmna2XL87jRf7km5vq4IUmDpp+CvDBoV3+w
	 u0vYvrdcqMsF6v6Em+hgiER2lkXpxaCTBhH3B7beBcRRkXkJnlIgfb6K07jp9dxS9A
	 yRl/uhOzXIF6Q==
From: Sasha Levin <sashal@kernel.org>
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun.feng@gmail.com
Cc: longman@redhat.com,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4/4] locking/lockdep: Use hashtable.h for stack_trace_hash
Date: Thu, 20 Mar 2025 10:31:20 -0400
Message-Id: <20250320143120.3119975-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250320143120.3119975-1-sashal@kernel.org>
References: <20250320143120.3119975-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert stack_trace_hash in lockdep.c to use the generic hashtable
implementation from hashtable.h instead of the manual hlist_head array
implementation.

This simplifies the code and makes it more maintainable by using the
standard hashtable API and removes the need for custom hash lookup
functions.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/locking/lockdep.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 151fec00f1c2c..987b81f2ddb77 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -541,7 +541,8 @@ struct lock_trace {
  * Stack-trace: sequence of lock_trace structures. Protected by the graph_lock.
  */
 static unsigned long stack_trace[MAX_STACK_TRACE_ENTRIES];
-static struct hlist_head stack_trace_hash[STACK_TRACE_HASH_SIZE];
+#define STACK_TRACE_HASH_BITS (ilog2(STACK_TRACE_HASH_SIZE))
+static DEFINE_HASHTABLE(stack_trace_hash, STACK_TRACE_HASH_BITS);
 
 static bool traces_identical(struct lock_trace *t1, struct lock_trace *t2)
 {
@@ -553,7 +554,6 @@ static bool traces_identical(struct lock_trace *t1, struct lock_trace *t2)
 static struct lock_trace *save_trace(void)
 {
 	struct lock_trace *trace, *t2;
-	struct hlist_head *hash_head;
 	u32 hash;
 	int max_entries;
 
@@ -580,13 +580,13 @@ static struct lock_trace *save_trace(void)
 	hash = jhash(trace->entries, trace->nr_entries *
 		     sizeof(trace->entries[0]), 0);
 	trace->hash = hash;
-	hash_head = stack_trace_hash + (hash & (STACK_TRACE_HASH_SIZE - 1));
-	hlist_for_each_entry(t2, hash_head, hash_entry) {
+
+	hash_for_each_possible(stack_trace_hash, t2, hash_entry, hash)
 		if (traces_identical(trace, t2))
 			return t2;
-	}
+
 	nr_stack_trace_entries += LOCK_TRACE_SIZE_IN_LONGS + trace->nr_entries;
-	hlist_add_head(&trace->hash_entry, hash_head);
+	hash_add(stack_trace_hash, &trace->hash_entry, hash);
 
 	return trace;
 }
@@ -598,11 +598,8 @@ u64 lockdep_stack_trace_count(void)
 	u64 c = 0;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(stack_trace_hash); i++) {
-		hlist_for_each_entry(trace, &stack_trace_hash[i], hash_entry) {
-			c++;
-		}
-	}
+	hash_for_each(stack_trace_hash, i, trace, hash_entry)
+		c++;
 
 	return c;
 }
@@ -613,7 +610,7 @@ u64 lockdep_stack_hash_count(void)
 	u64 c = 0;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(stack_trace_hash); i++)
+	for (i = 0; i < HASH_SIZE(stack_trace_hash); i++)
 		if (!hlist_empty(&stack_trace_hash[i]))
 			c++;
 
-- 
2.39.5


