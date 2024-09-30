Return-Path: <linux-kernel+bounces-343427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9569989AC4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 598351F21DBE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 06:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2F71531E8;
	Mon, 30 Sep 2024 06:40:42 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37C0156960
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 06:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727678442; cv=none; b=Hie0ib8GashmosNoQp8lpdYF9NsLW9OiOhKuSFMQ8H2OFSGvVW7cDHOTswNmM8oLfXgwOXL9Tbf8Jze+6TMKXhmOG+ZmrIHxgVsvHlWjAhYyBbwnC+xYr93YIJb8ByxWLKLNMUeZ0/Vp/hrblfwuNh04c8BVwa5R8k1eNabK1Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727678442; c=relaxed/simple;
	bh=MzqW3gEeRJrhGyP1tY/hFqNBpudEX2zquWeZWAyrXwg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fViLuoW6hJpmJ/BLJFyE6vZreRxuLfFN5efmaT1olHlXFYgEEdSKXrJB0POSOO4dgBivQJsgCI6WYAznXyDbGdYjrfFeM2e/TMVYT6V/POtFeFriCQyQ/zhDj3N/5QH9UKS5CxA6fJ7Guge7tsJUhAEaFLtjCizLa6eVWnxHeJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 48U6dVJK069882;
	Mon, 30 Sep 2024 14:39:31 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4XHB6w6F09z2R6KXB;
	Mon, 30 Sep 2024 14:31:36 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 30 Sep 2024 14:39:29 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand
	<david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Yu Zhao
	<yuzhao@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCH] mm: deal with active/inactive inversion in lru_gen_is_active
Date: Mon, 30 Sep 2024 14:39:12 +0800
Message-ID: <20240930063912.196526-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 48U6dVJK069882

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

All gens will be deemed as active by lru_gen_is_active when there are
only two generations within the node, which could have the folios
to be active in the belowing scenarios. This commit would like to
solve this by judging if numbers of file type gens greater than two
since anon gens could be remains as 3 when swap is constrained and file
type seq advanced by 1.

1. New folios after migration done.
2. Dropped folios from none-reclaiming context(drop_cache, madvise)
   when they are failed of being reclaimed and go back to lru.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 include/linux/mm_inline.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 6f801c7b36e2..5e4017dbec96 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -165,11 +165,16 @@ static inline int folio_lru_gen(struct folio *folio)
 static inline bool lru_gen_is_active(struct lruvec *lruvec, int gen)
 {
 	unsigned long max_seq = lruvec->lrugen.max_seq;
+	unsigned long min_seq = lruvec->lrugen.min_seq[LRU_GEN_FILE];
 
 	VM_WARN_ON_ONCE(gen >= MAX_NR_GENS);
 
-	/* see the comment on MIN_NR_GENS */
-	return gen == lru_gen_from_seq(max_seq) || gen == lru_gen_from_seq(max_seq - 1);
+	/* see the comment on MIN_NR_GENS
+	 * judge if there is active/inactive inversion by the number of file
+	 * type gens.
+	 */
+	return gen == lru_gen_from_seq(max_seq) ||
+		max_seq - min_seq >= 2 ? gen == lru_gen_from_seq(max_seq - 1) : 0;
 }
 
 static inline void lru_gen_update_size(struct lruvec *lruvec, struct folio *folio,
-- 
2.25.1


