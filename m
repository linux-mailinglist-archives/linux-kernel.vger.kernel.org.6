Return-Path: <linux-kernel+bounces-339899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7D6986BEC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB7DB1C21DE5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 05:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94E013BC11;
	Thu, 26 Sep 2024 05:08:14 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424B5175B1
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 05:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727327294; cv=none; b=ON4iaSGr+MZtY9WSf0oSj4UOPC7+n45XklSMAp7EBCPC8sIL6dQPKEHJbJqiePscA8+2ZG02SxstJGS+NsASfzSZ9mmhR0a72rP/N6kz1uNLgD8nlb45+f9KVtA96E0V//AP+1x423pGWE2iQHW3I6oofw9WJ3FMdnOsqu9hJnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727327294; c=relaxed/simple;
	bh=neRQVJi7dhlczwjmB81gvaayslK0+ufZDzHrc4veOUQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qTy052r7xlZAoMSLMuAFFlWi/Z8WmyCgh0QRPM2rOgh7EF2ApuKHSes3SUlIGraYoFjeDCTmxvEUwaehq0hpu2/J8dlZAqD0aBUxuzxer/QcX+oVkoodLCTFBPQGL2mMqbiBhhHiFnSN9e1ilX08aQ/L51zuEHb2Sqpl7C+0rnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 48Q56wbN046190;
	Thu, 26 Sep 2024 13:06:58 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4XDhG81T1sz2QHlsf;
	Thu, 26 Sep 2024 12:59:12 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 26 Sep 2024 13:06:56 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand
	<david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Yu Zhao
	<yuzhao@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCHv2] mm: migrate LRU_REFS_MASK bits in folio_migrate_flags
Date: Thu, 26 Sep 2024 13:06:47 +0800
Message-ID: <20240926050647.5653-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 48Q56wbN046190

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Bits of LRU_REFS_MASK are not inherited during migration which lead to
new folio start from tier0 when MGLRU enabled. Try to bring as much bits
of folio->flags as possible since compaction and alloc_contig_range
which introduce migration do happen at times.

Suggested-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
v2: modification as Yu Zhao suggested
---
---
 include/linux/mm_inline.h | 10 ++++++++++
 mm/migrate.c              |  1 +
 2 files changed, 11 insertions(+)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index f4fe593c1400..6f801c7b36e2 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -291,6 +291,12 @@ static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio *folio,
 	return true;
 }
 
+static inline void folio_migrate_refs(struct folio *new, struct folio *old)
+{
+	unsigned long refs = READ_ONCE(old->flags) & LRU_REFS_MASK;
+
+	set_mask_bits(&new->flags, LRU_REFS_MASK, refs);
+}
 #else /* !CONFIG_LRU_GEN */
 
 static inline bool lru_gen_enabled(void)
@@ -313,6 +319,10 @@ static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio *folio,
 	return false;
 }
 
+static inline void folio_migrate_refs(struct folio *new, struct folio *old)
+{
+
+}
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


