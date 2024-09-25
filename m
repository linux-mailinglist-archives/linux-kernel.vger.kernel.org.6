Return-Path: <linux-kernel+bounces-337933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB542985129
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D48EB21E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 03:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E001487D6;
	Wed, 25 Sep 2024 03:03:48 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC4C322A
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 03:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727233427; cv=none; b=E/zq/sWLQkbuYlcuWCFDGi+G3je6jCpBv5DC7o3YY9CdAbOBUidANA84Ur7Reg16MADwB5Lk8mfUv79m1wVfh1l4NFGN5DN6WEHW53t9mX0UUI0CZHuUwhE1pzCC0xWEJORJuxTwVM95gy9cDtn57ygzYJyufoiNKySNpIdPeAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727233427; c=relaxed/simple;
	bh=oIuzwVgGgaozzhnOfveY9UAvrBCIiWl6YUdZzKIp4e4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iCmE1dtUuRqsPTDzlQI0XGiTY08LkopRinsxYCV7xXwdW9S3UgTtGYfzWtOswI2iWkSPH+R3gtYq+3dj9WTxtcnK90HqL3cqBAvf1dehjupcNN9Klk/wNrQbGul4BVZgXgZXKrmGh8kMFWSDwKn1YY4vWhcrMjLqMhYa3p2WQas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 48P32ahN055927;
	Wed, 25 Sep 2024 11:02:36 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4XD1Y72yJFz2NZbG3;
	Wed, 25 Sep 2024 10:54:51 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 25 Sep 2024 11:02:33 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand
	<david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Yu Zhao
	<yuzhao@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCH] mm: migrate LRU_REFS_MASK bits in folio_migrate_flags
Date: Wed, 25 Sep 2024 11:02:25 +0800
Message-ID: <20240925030225.236143-1-zhaoyang.huang@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 48P32ahN055927

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Bits of LRU_REFS_MASK are not inherited during migration which lead to
new_folio start from tier0. Fix this by migrate the bits domain.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 include/linux/mm_inline.h | 8 ++++++++
 mm/migrate.c              | 1 +
 2 files changed, 9 insertions(+)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index f4fe593c1400..ecf07a2a8201 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -291,6 +291,12 @@ static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio *folio,
 	return true;
 }
 
+static inline void folio_migrate_refs(struct folio *new_folio, struct folio *folio)
+{
+	unsigned long refs = READ_ONCE(folio->flags) & LRU_REFS_MASK;
+
+	set_mask_bits(&new_folio->flags, LRU_REFS_MASK, refs);
+}
 #else /* !CONFIG_LRU_GEN */
 
 static inline bool lru_gen_enabled(void)
@@ -313,6 +319,8 @@ static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio *folio,
 	return false;
 }
 
+static inline void folio_migrate_refs(struct folio *new_folio, struct folio *folio)
+{}
 #endif /* CONFIG_LRU_GEN */
 
 static __always_inline
diff --git a/mm/migrate.c b/mm/migrate.c
index 923ea80ba744..60c97e235ae7 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -618,6 +618,7 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 	if (folio_test_idle(folio))
 		folio_set_idle(newfolio);
 
+	folio_migrate_refs(newfolio, folio);
 	/*
 	 * Copy NUMA information to the new page, to prevent over-eager
 	 * future migrations of this same page.
-- 
2.25.1


