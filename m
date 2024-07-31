Return-Path: <linux-kernel+bounces-269529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D41C9433DC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B19286299
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A503A1BBBE1;
	Wed, 31 Jul 2024 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkzUFwov"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286E31CAA9
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722442089; cv=none; b=VBq+I4qT6FOu4SJ/ZUhaIIi3pB/jGwelocaRqtSXTmreupQaiMM7T20wqyVkZc/p1CHbuLUYZEL80LxgjP0eTbjrUAbOB+5oLcz8kCqAvr4TBjT890b67skWTN+t+fYgisX4KKF9BAduvzZiO66s4ieS67TkLdU4u0pjtWu1uW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722442089; c=relaxed/simple;
	bh=FdjzrVjIqCQJBuKBk/cVhXfnfcfrFsX2HJ7cLjXPNcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rnUKHzvQjP70mChnwaIPylWdgxkS3Oe6basOomGKiRPSUPdX3gM741/ZBqr3hQw0WemKdsPvaEZZvF0+jLVktrdbe3nCWPOiRDXZ6aAob+AlMD8kVqvmJmCH5QvF9/nXcypVEgOPEtkEzRnzeufP6S52P0+SU+nUlsHQlEA8Ef8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TkzUFwov; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722442087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GoBWNItCy+5p/s715HtqO2A6k5AaBk19nlaEIZQ3fA8=;
	b=TkzUFwov5of/MvnKg/r40swoQ0NA1MdhHIA7LNzTpt9HvRobLyJA590Rma8qAd6JgMOQh2
	+LK4SyRmwKp/MGuiRqR/FWQtgsAY2nMYjJQ6J4BDDBfgNEVQQnamUKRSMCNpQiaonIMfvf
	oJ4RupFDALOcglJmQ9Plx7JTbh9X/gk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-UW0f7oMtOV6TwNVlqTZEhg-1; Wed,
 31 Jul 2024 12:08:04 -0400
X-MC-Unique: UW0f7oMtOV6TwNVlqTZEhg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE4E21955D45;
	Wed, 31 Jul 2024 16:08:02 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.228])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 400311955D42;
	Wed, 31 Jul 2024 16:08:00 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1] mm: clarify folio_likely_mapped_shared() documentation for KSM folios
Date: Wed, 31 Jul 2024 18:07:58 +0200
Message-ID: <20240731160758.808925-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

For KSM folios, the function actually does what it is supposed to do:
even having multiple mappings inside the same MM is considered
"sharing", as there is no real relationship between these KSM page
mappings -- in contrast to mapping the same file range twice and having the
same pagecache page mapped twice.

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a890a1731c14..58ca060f5dce 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2132,14 +2132,19 @@ static inline size_t folio_size(const struct folio *folio)
  * MM ("mapped shared"), or if the folio is only mapped into a single MM
  * ("mapped exclusively").
  *
+ * For KSM folios, this function also returns "mapped shared" when a folio is
+ * mapped multiple times into the same MM, because the individual page mappings
+ * are independent.
+ *
  * As precise information is not easily available for all folios, this function
  * estimates the number of MMs ("sharers") that are currently mapping a folio
  * using the number of times the first page of the folio is currently mapped
  * into page tables.
  *
- * For small anonymous folios (except KSM folios) and anonymous hugetlb folios,
- * the return value will be exactly correct, because they can only be mapped
- * at most once into an MM, and they cannot be partially mapped.
+ * For small anonymous folios and anonymous hugetlb folios, the return
+ * value will be exactly correct: non-KSM folios can only be mapped at most once
+ * into an MM, and they cannot be partially mapped. KSM folios are
+ * considered shared even if mapped multiple times into the same MM.
  *
  * For other folios, the result can be fuzzy:
  *    #. For partially-mappable large folios (THP), the return value can wrongly
@@ -2148,9 +2153,6 @@ static inline size_t folio_size(const struct folio *folio)
  *    #. For pagecache folios (including hugetlb), the return value can wrongly
  *       indicate "mapped shared" (false positive) when two VMAs in the same MM
  *       cover the same file range.
- *    #. For (small) KSM folios, the return value can wrongly indicate "mapped
- *       shared" (false positive), when the folio is mapped multiple times into
- *       the same MM.
  *
  * Further, this function only considers current page table mappings that
  * are tracked using the folio mapcount(s).
-- 
2.45.2


