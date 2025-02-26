Return-Path: <linux-kernel+bounces-533730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A848EA45E21
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AB1C1899293
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2013221F23;
	Wed, 26 Feb 2025 12:01:55 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A7A221719
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571315; cv=none; b=NtOin0PIjcvPGeCkOvC6aWSzV0uKuMUvLt0HBk80HAoMt5MAGj3owlHFYzWtTYmJOdxxC0JAZky5b90KLg/Gllqum63E2+0urxVJ7BJsNRIPn2kk2QOEWwFs5YLPYp+luYQyb+HBtciLZFK7vEbN7cbiuyEBLUUsvjjnsG3z6y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571315; c=relaxed/simple;
	bh=BXX4IgwOKrHiH/TlO8SNVwHO+h812egXxxdkbdLaGDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=eHdiwO3JUCvRXy95EEcHytYNi58RjZRCaoR1CdKu5a6UWKZ+YmZEV7CCacs6IgM5cu1wPIii+BYEHVWShAVyQDP3NVCQ8uvXkS8vO37ltuYROlF95mp/o6HKU5u3RqwmFDTP1Z9quuTFFVxkla2SMXo8Hc6r8/Or5kD8aHzhZno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-1c-67bf02a76aa4
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	vernhao@tencent.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	rjgolo@gmail.com
Subject: [RFC PATCH v12 based on mm-unstable as of Feb 21, 2025 18/25]  mm/page_alloc: retry 3 times to take pcp pages on luf check failure
Date: Wed, 26 Feb 2025 21:01:25 +0900
Message-Id: <20250226120132.28469-18-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120132.28469-1-byungchul@sk.com>
References: <20250226113342.GB1935@system.software.com>
 <20250226120132.28469-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsXC9ZZnke5ypv3pBvv3i1vMWb+GzeLzhn9s
	Fl/X/2K2ePqpj8Xi8q45bBb31vxntTi/ay2rxY6l+5gsLh1YwGRxvPcAk8X8e5/ZLDZvmsps
	cXzKVEaL3z/msDnweXxv7WPx2DnrLrvHgk2lHptXaHlsWtXJ5rHp0yR2j3fnzrF7nJjxm8Xj
	/b6rbB5bf9l5NE69xubxeZNcAE8Ul01Kak5mWWqRvl0CV8bZ3rssBU+4Kp6/X87UwLiFo4uR
	k0NCwESicfJhRhj7zs9NzCA2m4C6xI0bP8FsEQEziYOtf9i7GLk4mAWWMUnsPdHABuIIC3Qz
	Sqw8eRWsm0VAVWLVzTMsIDYvUMe8yxugpspLrN5wAGwSJ1D83+7f7CC2kECyRMv63ywggyQE
	7rNJXPv5hx2iQVLi4IobLBMYeRcwMqxiFMrMK8tNzMwx0cuozMus0EvOz93ECAzsZbV/oncw
	froQfIhRgINRiYf3wZm96UKsiWXFlbmHGCU4mJVEeDkz96QL8aYkVlalFuXHF5XmpBYfYpTm
	YFES5zX6Vp4iJJCeWJKanZpakFoEk2Xi4JRqYEy9XC2RuCf75rKaENFqN5WOFG/FH3yBS17G
	nauTnP1tpa6BtvoFp8tRWzpnKGyXfFXk/CRld3dy4QJzt09Mq1t4VsavyF9SG26xZfUUjvt6
	ipsXlOx5H+i0Nzdyj1JiWP6F29PnX9H7p9nBs2ZH0E7xCgmLr+wZwkzLhL5HnLJb9HrfgumP
	jJVYijMSDbWYi4oTAdW9NNZoAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsXC5WfdrLucaX+6wb7D/BZz1q9hs/i84R+b
	xdf1v5gtnn7qY7E4PPckq8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/f8xhc+D3+N7ax+Kxc9Zddo8Fm0o9Nq/Q8ti0qpPNY9OnSewe786dY/c4
	MeM3i8f7fVfZPBa/+MDksfWXnUfj1GtsHp83yQXwRnHZpKTmZJalFunbJXBlnO29y1LwhKvi
	+fvlTA2MWzi6GDk5JARMJO783MQMYrMJqEvcuPETzBYRMJM42PqHvYuRi4NZYBmTxN4TDWwg
	jrBAN6PEypNXGUGqWARUJVbdPMMCYvMCdcy7vIERYqq8xOoNB8AmcQLF/+3+zQ5iCwkkS7Ss
	/80ygZFrASPDKkaRzLyy3MTMHFO94uyMyrzMCr3k/NxNjMAwXVb7Z+IOxi+X3Q8xCnAwKvHw
	PjizN12INbGsuDL3EKMEB7OSCC9n5p50Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxe4akJQgLp
	iSWp2ampBalFMFkmDk6pBsZNn6cJfFqT4Hfudpj5eeWtZ2L3aCSp/91h7q/LNVHMQXCj/Cq+
	k7pnZ15vzDY67HRut9eumDsFZ41lVghGnnRbkTxzq2r83rIz2qtWPto7YbK8NqPb1J6kX5eL
	Xss6Oq8tZ9Db8zTB9d/s3z9u1eV5vNGIPneL5dXz2gRXwZdXROafbdgVdf2yEktxRqKhFnNR
	cSIA/NkYRU8CAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 mm/page_alloc.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7b023b34d53da..f35ae2550019f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3384,6 +3384,12 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 {
 	struct page *page;
 
+	/*
+	 * give up taking page from pcp if it fails to take pcp page
+	 * 3 times due to the tlb shootdownable issue.
+	 */
+	int try_luf_pages = 3;
+
 	do {
 		if (list_empty(list)) {
 			int batch = nr_pcp_alloc(pcp, zone, order);
@@ -3398,11 +3404,21 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 				return NULL;
 		}
 
-		page = list_first_entry(list, struct page, pcp_list);
-		if (!luf_takeoff_check_and_fold(page))
+		list_for_each_entry(page, list, pcp_list) {
+			if (luf_takeoff_check_and_fold(page)) {
+				list_del(&page->pcp_list);
+				pcp->count -= 1 << order;
+				break;
+			}
+			if (!--try_luf_pages)
+				return NULL;
+		}
+
+		/*
+		 * If all the pages in the list fails...
+		 */
+		if (list_entry_is_head(page, list, pcp_list))
 			return NULL;
-		list_del(&page->pcp_list);
-		pcp->count -= 1 << order;
 	} while (check_new_pages(page, order));
 
 	return page;
-- 
2.17.1


