Return-Path: <linux-kernel+bounces-557858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB32A5DEAA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BAB2189C2B6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6976524BC1C;
	Wed, 12 Mar 2025 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="PghIbEkg"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3172E1F4CB7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741788628; cv=none; b=cxBZWpXH2UXOYrhsaq7RHYjdx17brjkjVzqIW1Oja8tdev0/zNICll/cE8d+nvV5juQUbFwdlxoIXryPMi6k5XizOcB1wKDfJzUmxXRc3PlXNPUjBpijQItfH3WwFOQW3bFr3lrA0pkAKR+VG2KQbyhNyCnL3xbnci6DP+L/Vvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741788628; c=relaxed/simple;
	bh=Gzhh0CL/jONkRqz2afghq1tga+QOx3jfOt+TU84UHYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iPJ3IT9bJ1mmw5TlDbli78EjxZaOdt7aw+UtWuoAOinuANXZaYvufs79Ab//eDrlG8mfgjh+llpjhSuKXx7T0iovC26DdlRTnGi+LiJRaevEqMWYqSCLoVyizlWPUpPvso5fviOUZyn1evmxZu1unVfXJu5iIbi3IgWtEHAQedY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=PghIbEkg; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1741788622;
	bh=Gzhh0CL/jONkRqz2afghq1tga+QOx3jfOt+TU84UHYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PghIbEkgaPly51Wi3eLEuUlrqXO2ZV/nlYwIqQIaeqQJ4BWQghM6+nV4AGILwwGEP
	 SZ8kbHdY7Dcu1VxHGEd+H7DVwc5CEnVcRvOqwhoMEWeebmiBH5SQhWL3DZcAmPWBo7
	 47XpB46EbA0hYJTc9ZigzmMjzRmA2epn7NmjfgKX0VfPQvdZcvxrH5EeN1w2+QJs9u
	 +t3IVEhEFvJMTUjVE6wBsuwS37mShP6QXqUUdrMMpMaQxnzL0EntJKFiDDK5YrX4jh
	 LjrzbnZZ6hge3vqqvRCkxKMwoQ8qgnzXAIRzbvrYGYuNixxKaJFB0nUDWTl4Ns0jTr
	 08ZoYYnQfW0Qw==
Received: from localhost.localdomain (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4ZCXb20QB7zV0F;
	Wed, 12 Mar 2025 10:10:22 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-mm@kvack.org
Subject: [PATCH 2/2] mm: Lock PGDAT_RECLAIM_LOCKED with acquire memory ordering
Date: Wed, 12 Mar 2025 10:10:14 -0400
Message-Id: <20250312141014.129725-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250312141014.129725-1-mathieu.desnoyers@efficios.com>
References: <20250312141014.129725-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PGDAT_RECLAIM_LOCKED bit is used to provide mutual exclusion of
node reclaim for struct pglist_data using a single bit.

Use test_and_set_bit_lock rather than test_and_set_bit to test-and-set
PGDAT_RECLAIM_LOCKED with an acquire memory ordering semantic.

This changes the "lock" acquisition from a full barrier to an acquire
memory ordering, which is weaker. The acquire semi-permeable barrier
paired with the release on unlock is sufficient for this mutual
exclusion use-case.

No behavior change intended other than to reduce overhead by using
the appropriate barrier.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-mm@kvack.org
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d7e27d5c24e7..021b25bdba91 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7567,7 +7567,7 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
 	if (node_state(pgdat->node_id, N_CPU) && pgdat->node_id != numa_node_id())
 		return NODE_RECLAIM_NOSCAN;
 
-	if (test_and_set_bit(PGDAT_RECLAIM_LOCKED, &pgdat->flags))
+	if (test_and_set_bit_lock(PGDAT_RECLAIM_LOCKED, &pgdat->flags))
 		return NODE_RECLAIM_NOSCAN;
 
 	ret = __node_reclaim(pgdat, gfp_mask, order);
-- 
2.25.1


