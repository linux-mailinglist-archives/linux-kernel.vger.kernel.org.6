Return-Path: <linux-kernel+bounces-557859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02632A5DEAB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744F53A5619
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E6924DFF0;
	Wed, 12 Mar 2025 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="uVGW78IH"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3178422DFB4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741788629; cv=none; b=bV6iKhMsXM55xdCJBKKWxLBkJs+yk06qbY2FC/tK0V/ZD0V0nN7F9ibypQJnUwlRxK+FNvB82pea/0jBuX6S3gOreW8SsVoV+RChhHp9Y7CBs6JjdlftZ68nGAEvCM0Mo0DEVVXaGxCXFNL51zeEw5PW9W8DZrNAfIMC4JRf1DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741788629; c=relaxed/simple;
	bh=MipAKpvbmNfmxW0K3rXTS/6tsgSsxzcTZj33h5g1JrI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ncg4BVnIO5jtFngMze9lcGyrBNAVZB738xOzp2pLdVhMB3+55XFmm21YGTGCCMTUH13tRdms9KHRW7P2WzfQEiKbnpCG2fTjnjX5VWxhkb4TBrfHpq9Pl5K+QXn+dP7S4R8EII7rCmlRAm9NowJfzIMwIIal1/8erULGVo9Wazg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=uVGW78IH; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1741788621;
	bh=MipAKpvbmNfmxW0K3rXTS/6tsgSsxzcTZj33h5g1JrI=;
	h=From:To:Cc:Subject:Date:From;
	b=uVGW78IHEoxm9gFvMdpkcmITWNsaQ5rOcxPLphPcpCZwQ0LUDP1G2hqgsniAf4bKA
	 SfBBLPEC2tuoEKbSunREAW5o5Q/Ocv+vZ+L8VeeYcJCDvCOI96GtV1I9r/vYldcx1O
	 aSWGWlBEd0vtoaWZA711XzQRRU5U0n6VB+ritr3GBtm6SUldiy//Rj+gz5L1I8HWf/
	 1gcGbmYobSw61GINfuvxei8eRK9M0H4IAEbDyiyFZutMPqD8T4X1eMfhpS0vc1J7WY
	 /8omuRblm0pxfJR+VL/2hz1a4K4oLo/5RvkGv5aEaekyKOKARjKJlNP9RW9/khqhyr
	 Sas4MrG72guyQ==
Received: from localhost.localdomain (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4ZCXb14tPjzV0D;
	Wed, 12 Mar 2025 10:10:21 -0400 (EDT)
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
Subject: [PATCH 1/2] mm: Add missing release barrier on PGDAT_RECLAIM_LOCKED unlock
Date: Wed, 12 Mar 2025 10:10:13 -0400
Message-Id: <20250312141014.129725-1-mathieu.desnoyers@efficios.com>
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

Fix this by using clear_bit_unlock rather than clear_bit to clear
PGDAT_RECLAIM_LOCKED with a release memory ordering semantic.

This provides stronger memory ordering (release rather than relaxed).

Fixes: d773ed6b856a ("mm: test and set zone reclaim lock before starting reclaim")
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
index c22175120f5d..d7e27d5c24e7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7571,7 +7571,7 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
 		return NODE_RECLAIM_NOSCAN;
 
 	ret = __node_reclaim(pgdat, gfp_mask, order);
-	clear_bit(PGDAT_RECLAIM_LOCKED, &pgdat->flags);
+	clear_bit_unlock(PGDAT_RECLAIM_LOCKED, &pgdat->flags);
 
 	if (ret)
 		count_vm_event(PGSCAN_ZONE_RECLAIM_SUCCESS);
-- 
2.25.1


