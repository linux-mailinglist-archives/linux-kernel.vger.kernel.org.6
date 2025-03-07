Return-Path: <linux-kernel+bounces-551841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4890BA571D6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 326EA3B3544
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C2D2505D4;
	Fri,  7 Mar 2025 19:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="SFFHlPiQ"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB33221DB9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741375854; cv=none; b=VW7NKKXjiQ4K+lIgF+FvTNj82CmKA47jY5RszpceUdWfNWtV79TIDMUy38fGD+EvnWOUAUURi7iKqe1GQsQ7N3D3asxBJ6hZ3dvijO3PBX352yFa2GR8ipsQQGgSwhkPTftoYz1ZtkIlTXHPDNQ7UFcVAFGhDVk9D9EJj4cypKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741375854; c=relaxed/simple;
	bh=I7qUEBsf9z9DvFVeTUwEL2QF/mwYSpxIB5OX23QFtcU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eb15sAPBV51/VG3imYL8kIXLRitXVrG3xdb10IOYZZKdoXJLEVEKFBm2aeUUV/m3SEwIYFPhRs+ljqNih/I1NZ9uuhILMkt090F5SooZShEVyVpRzEPc1OuEMuFkpthCAzHR3TXAxgPalXdv71UTam4Un3hZHGo0m3gDVUUS+hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=SFFHlPiQ; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1741375851;
	bh=I7qUEBsf9z9DvFVeTUwEL2QF/mwYSpxIB5OX23QFtcU=;
	h=From:To:Cc:Subject:Date:From;
	b=SFFHlPiQ1dVRlkA83oEwuD3d/a54xPfyT7af1B56LbjBkK/qQx8EPBooVir5Xs/PP
	 YxGzct4ODrmkgHTHkZwnmo0ATuRRc/KHU8rW3KKL6C4Imra6Y4zOIDMFvysDE/jOfb
	 a0oimfFSYWEs5uXP9CkxbuL5QXmK6LtMlYVpaoabLXi1NzV7LLLRm6g/mYyAFiivtO
	 0prauRBELPV8Pqk0Yohajy7xlCeMI2qQHPAEYV4TlMwTZkIaytCPrRj32k7Y4zLiAC
	 CUxskCVt+Bm9uC4wlzCauOiIw2ew0yIQRtXv00qPOUJAcGlSjwslPr/VYrOprNy4r8
	 zbwl56EPgfkrA==
Received: from localhost.localdomain (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Z8bx71SLyz1gPP;
	Fri,  7 Mar 2025 14:30:51 -0500 (EST)
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
Subject: [RFC PATCH] mm: Add missing release barrier on PGDAT_RECLAIM_LOCKED unlock
Date: Fri,  7 Mar 2025 14:30:47 -0500
Message-Id: <20250307193047.66079-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PGDAT_RECLAIM_LOCKED bit is used to provide mutual exclusion of
node reclaim for struct pglist_data using a single bit.

It is "locked" with a test_and_set_bit (similarly to a try lock) which
provides full ordering with respect to loads and stores done within
__node_reclaim().

It is "unlocked" with clear_bit(), which does not provide any ordering
with respect to loads and stores done before clearing the bit.

The lack of clear_bit() memory ordering with respect to stores within
__node_reclaim() can cause a subsequent CPU to fail to observe stores
from a prior node reclaim. This is not an issue in practice on TSO (e.g.
x86), but it is an issue on weakly-ordered architectures (e.g. arm64).

Fix this with following changes:

A) Use clear_bit_unlock rather than clear_bit to clear PGDAT_RECLAIM_LOCKED
   with a release memory ordering semantic.

This provides stronger memory ordering (release rather than relaxed).

B) Use test_and_set_bit_lock rather than test_and_set_bit to test-and-set
   PGDAT_RECLAIM_LOCKED with an acquire memory ordering semantic.

This changes the "lock" acquisition from a full barrier to an acquire
memory ordering, which is weaker. The acquire semi-permeable barrier
paired with the release on unlock is sufficient for this mutual
exclusion use-case.

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
 mm/vmscan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index c22175120f5d..021b25bdba91 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7567,11 +7567,11 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
 	if (node_state(pgdat->node_id, N_CPU) && pgdat->node_id != numa_node_id())
 		return NODE_RECLAIM_NOSCAN;
 
-	if (test_and_set_bit(PGDAT_RECLAIM_LOCKED, &pgdat->flags))
+	if (test_and_set_bit_lock(PGDAT_RECLAIM_LOCKED, &pgdat->flags))
 		return NODE_RECLAIM_NOSCAN;
 
 	ret = __node_reclaim(pgdat, gfp_mask, order);
-	clear_bit(PGDAT_RECLAIM_LOCKED, &pgdat->flags);
+	clear_bit_unlock(PGDAT_RECLAIM_LOCKED, &pgdat->flags);
 
 	if (ret)
 		count_vm_event(PGSCAN_ZONE_RECLAIM_SUCCESS);
-- 
2.25.1


