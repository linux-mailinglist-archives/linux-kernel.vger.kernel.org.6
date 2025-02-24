Return-Path: <linux-kernel+bounces-530147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94578A42FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9CA17B5C5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAB21FC100;
	Mon, 24 Feb 2025 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmxRY1Uj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388ED1FC0EB
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 21:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434370; cv=none; b=fg7XTFg+8P7cjQ0J5bfydTo844ZkSRZH+3plzplvuffyJqF5I8T40XpOnx0eX0LylNhPi8DlP2B/QM4ZsHl+Gy/o4Pj7noqUM+L/jRtSLd5rCfWQ2pp+QzucvrVzqJ181OdFIcQg226QMD/Y5RHMRiMYZbJoELxaZiNZ5IVIM5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434370; c=relaxed/simple;
	bh=rTjLKS6zi3fibnlja9uhJe1I0xGmSZ8izGxln042tOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OU3hZxJTFjn3YBlWbRyMxXUL9+C9C5MkYtTQby5wG3BZBVgtlCh6JDhu81QGlfZvl6sR7BB/56zxRBvFYrByozQtlpYq5VcbZNzSIUJhMcRcSgZAUq5jss22c4QTpNWv783II9PuUqw5c0fHue6cKXZMiJ0t15/lX29QB3jY5WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XmxRY1Uj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740434368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FtYeaQb9yjWDAqIxpFJ3I+Fkvf55cMTzB8yThSJBOoQ=;
	b=XmxRY1Ujax7TBC72QJcTKPD9O/V4SbeF2a25WfA2jhlE4bty1uInFV8TscR1oADSlj8I7O
	s7Y1lBdPU/f1HpilGS/vgk73gzi7xR6Uvvl5XFNaQXe7X0vqZBxyuf/RKeN/FbmmYM1Yf0
	egnEdvAGaTYi8st4MDMspFERbbNsRug=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-JUYoEci3NZm2AUhf6yksEw-1; Mon,
 24 Feb 2025 16:59:22 -0500
X-MC-Unique: JUYoEci3NZm2AUhf6yksEw-1
X-Mimecast-MFC-AGG-ID: JUYoEci3NZm2AUhf6yksEw_1740434361
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C20701800373;
	Mon, 24 Feb 2025 21:59:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.65.50])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6746D1800359;
	Mon, 24 Feb 2025 21:59:18 +0000 (UTC)
From: Luiz Capitulino <luizcap@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	david@redhat.com,
	yuzhao@google.com,
	pasha.tatashin@soleen.com
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	muchun.song@linux.dev,
	luizcap@redhat.com
Subject: [PATCH v2 1/4] mm: page_ext: make lookup_page_ext() public
Date: Mon, 24 Feb 2025 16:59:05 -0500
Message-ID: <fb46436ec9ef892b6f40b9e48d40237b9855ac16.1740434344.git.luizcap@redhat.com>
In-Reply-To: <cover.1740434344.git.luizcap@redhat.com>
References: <cover.1740434344.git.luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The next commit will use it.

Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
---
 include/linux/page_ext.h | 1 +
 mm/page_ext.c            | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index e4b48a0dda244..d6fb891c51d1d 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -79,6 +79,7 @@ static inline void page_ext_init(void)
 
 extern struct page_ext *page_ext_get(const struct page *page);
 extern void page_ext_put(struct page_ext *page_ext);
+extern struct page_ext *lookup_page_ext(const struct page *page);
 
 static inline void *page_ext_data(struct page_ext *page_ext,
 				  struct page_ext_operations *ops)
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 641d93f6af4c1..23ad30597c05c 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -165,7 +165,7 @@ void __meminit pgdat_page_ext_init(struct pglist_data *pgdat)
 	pgdat->node_page_ext = NULL;
 }
 
-static struct page_ext *lookup_page_ext(const struct page *page)
+struct page_ext *lookup_page_ext(const struct page *page)
 {
 	unsigned long pfn = page_to_pfn(page);
 	unsigned long index;
@@ -245,7 +245,7 @@ static bool page_ext_invalid(struct page_ext *page_ext)
 	return !page_ext || (((unsigned long)page_ext & PAGE_EXT_INVALID) == PAGE_EXT_INVALID);
 }
 
-static struct page_ext *lookup_page_ext(const struct page *page)
+struct page_ext *lookup_page_ext(const struct page *page)
 {
 	unsigned long pfn = page_to_pfn(page);
 	struct mem_section *section = __pfn_to_section(pfn);
-- 
2.48.1


