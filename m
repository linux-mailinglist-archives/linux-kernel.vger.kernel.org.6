Return-Path: <linux-kernel+bounces-289502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FD69546CC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3FBA284556
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB24196446;
	Fri, 16 Aug 2024 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Crf7XWmW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2046B2A1CF
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723804384; cv=none; b=P8LIJZCpsdj7uusEllVd7q+Lrmg/d6ZseAtHLdIRoohIvY8KZAhSzUBdOKH1Qs5b8xKVZrWGW2HsfpiflNPbeaos6Q2QxZIbo7iyl+1RiuIb2TIpp9ZhX9HhtAtVXDTE2wP9AOA2fqHCH8LzfNreAPm+20MQoucKeWnNQXH1hkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723804384; c=relaxed/simple;
	bh=KY7NhCiUHZDopvNuTWvNdanGToJoLGVuxDNiMiFgZXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RoTAZQ+oeu+LqX5IEiSEUITKgBNvGw5p62E6uTKz9U1I3KmUOK87FCcka3dkYGKrajL0Ygyxwrz4+ynysecOC+Vv1YO+/Uvhr9DYiSdRfFRyqCfJCAtwM8I06b90Kts0Yz/9MJgMk0iSOyG9L63Ial/VKm5H27e/LFvTKBGxY2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Crf7XWmW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723804380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Fs9xcyJg7s52rkpgu5pEX5FPQ0ebM/lCKmDb5KCxkoU=;
	b=Crf7XWmWTApv93Hb7PzS2UYZMlbQZQkbr6BTZ6AxwiluVdglhRRdgZiBMz7akIlfaSiHqw
	XIFuh3AFdWgbGyruRWuA0m4l64PivI5SnRPUOIdvYqCbalZJxeeCt6kcEA2iHiWCvHVrSm
	qKJDcDoBG94BfGbQxpJxGqrVnuByf6M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-1CGh2Qs_PGCFqBIbNkQ_3g-1; Fri,
 16 Aug 2024 06:32:57 -0400
X-MC-Unique: 1CGh2Qs_PGCFqBIbNkQ_3g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E27D1955D44;
	Fri, 16 Aug 2024 10:32:56 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.216])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 320363001FE5;
	Fri, 16 Aug 2024 10:32:52 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1] mm/rmap: use folio->_mapcount for small folios
Date: Fri, 16 Aug 2024 12:32:46 +0200
Message-ID: <20240816103246.719209-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

We have some cases left whereby we operate on small folios and still
refer to page->_mapcount. Let's just use folio->_mapcount instead, which
currently still overlays page->_mapcount, so no change.

This change will make it easier to later spot any remaining users of
page->_mapcount that target tail pages.

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 4 ++--
 mm/rmap.c            | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 07854d1f9ad65..d5e93e44322e5 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -331,7 +331,7 @@ static __always_inline void __folio_dup_file_rmap(struct folio *folio,
 	switch (level) {
 	case RMAP_LEVEL_PTE:
 		if (!folio_test_large(folio)) {
-			atomic_inc(&page->_mapcount);
+			atomic_inc(&folio->_mapcount);
 			break;
 		}
 
@@ -425,7 +425,7 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
 		if (!folio_test_large(folio)) {
 			if (PageAnonExclusive(page))
 				ClearPageAnonExclusive(page);
-			atomic_inc(&page->_mapcount);
+			atomic_inc(&folio->_mapcount);
 			break;
 		}
 
diff --git a/mm/rmap.c b/mm/rmap.c
index 4c330635aa4e7..c09c6c03fc9dc 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1165,7 +1165,7 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 	switch (level) {
 	case RMAP_LEVEL_PTE:
 		if (!folio_test_large(folio)) {
-			nr = atomic_inc_and_test(&page->_mapcount);
+			nr = atomic_inc_and_test(&folio->_mapcount);
 			break;
 		}
 
@@ -1535,7 +1535,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 	switch (level) {
 	case RMAP_LEVEL_PTE:
 		if (!folio_test_large(folio)) {
-			nr = atomic_add_negative(-1, &page->_mapcount);
+			nr = atomic_add_negative(-1, &folio->_mapcount);
 			break;
 		}
 
-- 
2.45.2


