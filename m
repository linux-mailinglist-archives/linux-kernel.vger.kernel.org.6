Return-Path: <linux-kernel+bounces-196828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D4A8D623D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92868B21394
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CF615884F;
	Fri, 31 May 2024 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OlFvV8X7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E963B138485
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717160188; cv=none; b=HOXmpYFooIvCZUsWWUMB3oYvUklbC35qxHFq/Vnyp9C1yh7swWY107oKKogsByOXUdLU67FW4Qn1/A6Hzb3zzzVIzgUgkTZIAi7I1gyvALpLu1Kvq0Zmgi9D+tJssUsAxory2unK9dFHXysyGyN3gDfR9BBxYngYUkRkXib416w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717160188; c=relaxed/simple;
	bh=1iHefKV1ez3+eJd6dW8V+aWnEhf6ATdue+O2jzwxzSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rnvlTTQN+SB9z0m/uJRmOXzh1gdydm4D7nZrQovUt36c/CLmiUPgnTYSDiQNW0WZZyys0tUgk5Xs1vvsW8jLMyL7InfrS2IZXYXtp5cKIBD7xfVm89JNHJX8oUu1BP3um1tvT/22NdUC+OyYnWUeW5ZXmSlGxEmDlUum4B2qVaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OlFvV8X7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717160185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5JmbUXvyxSjbvlIBB7oWRC92t6DkK3PEurnFcNBHVLA=;
	b=OlFvV8X7AoZh3NLQxxQkC9RlKRX8dVDoJrR6FkOdNZHLMnfsuXk7KkEqfBd8bjc/dRqPOc
	j78R4D94zaXDhB0EHsJJ3SCKhDtHNEo1MDsddbDADMEqCfio8ZeCdMZzPIazx+nPe2pKnx
	b7tGrPXa0V51QAyW/zKBj5DSjwrIno8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-nFMmd0dgMgm67x1EOr1SQA-1; Fri, 31 May 2024 08:56:22 -0400
X-MC-Unique: nFMmd0dgMgm67x1EOr1SQA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9123F185A780;
	Fri, 31 May 2024 12:56:21 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.113])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3B09C200A35C;
	Fri, 31 May 2024 12:56:17 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	kernel test robot <oliver.sang@intel.com>,
	Oscar Salvador <osalvador@suse.de>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v1] mm: read page_type using READ_ONCE
Date: Fri, 31 May 2024 14:56:16 +0200
Message-ID: <20240531125616.2850153-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

KCSAN complains about possible data races: while we check for a
page_type -- for example for sanity checks -- we might concurrently
modify the mapcount that overlays page_type.

Let's use READ_ONCE to avoid load tearing (shouldn't make a difference)
and to make KCSAN happy.

Likely, we might also want to use WRITE_ONCE for the writer side of
page_type, if KCSAN ever complains about that. But we'll not mess with
that for now.

Note: nothing should really be broken besides wrong KCSAN complaints.
The sanity check that triggers this was added in commit 68f0320824fa
("mm/rmap: convert folio_add_file_rmap_range() into
folio_add_file_rmap_[pte|ptes|pmd]()"). Even before that similar
races likely where possible, ever since we added page_type in
commit 6e292b9be7f4 ("mm: split page_type out from _mapcount").

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202405281431.c46a3be9-lkp@intel.com
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index f04fea86324d9..03eebb1aadbb1 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -961,9 +961,9 @@ PAGEFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
 #define PAGE_MAPCOUNT_RESERVE	(~0x0000ffff)
 
 #define PageType(page, flag)						\
-	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
+	((READ_ONCE(page->page_type) & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
 #define folio_test_type(folio, flag)					\
-	((folio->page.page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
+	((READ_ONCE(folio->page.page_type) & (PAGE_TYPE_BASE | flag))  == PAGE_TYPE_BASE)
 
 static inline int page_type_has_type(unsigned int page_type)
 {
@@ -972,7 +972,7 @@ static inline int page_type_has_type(unsigned int page_type)
 
 static inline int page_has_type(const struct page *page)
 {
-	return page_type_has_type(page->page_type);
+	return page_type_has_type(READ_ONCE(page->page_type));
 }
 
 #define FOLIO_TYPE_OPS(lname, fname)					\
-- 
2.45.1


