Return-Path: <linux-kernel+bounces-542239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA28A4C78B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F30A3AF5CF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24E823BF90;
	Mon,  3 Mar 2025 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+NAwzYP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5110923A99C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019432; cv=none; b=Eq3uLk3svadPJfGYchfN1Aje3mgRzBTjqa1SBEQkV0KJtXCanOKCo7/A42t9UzFm1F5+4rjMJAnoWfOX3k+R76HPCbgIha9YvymlLxLQ/J8DBrFUCQINdrtLr5nUbIQcedYXvCoyUvF3KBdq1vqrOzhWcKI6oQvKbwKFu33qpGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019432; c=relaxed/simple;
	bh=PXIkz9IhpVUA0dg2bzzU7MBYAWcAI8b7mocN+X2/mhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0B3CJ7qoZeRn7TdY+r1Q8eVgJCbPOi/03T0Jnv3a0E8qxKzE7xiykqmHelw0QyaxUF57Pfqzvfy3uZclvBn4GLbFaOGJlHh8h46YEJtKhNZrqVTSSjagZOXCsglRMO4MhlowWVMdIknD0IYilc/nVeHaE/wIKwQE7SB+s4Jkd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O+NAwzYP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YXwoThNtp+x7X/3NlVobY8ZdtRlIGCn0KXkmBvKPXvw=;
	b=O+NAwzYPempijNGt2/ySs6GpzQcA5I6TQs+/3WlAZ/X/MsadLoOhmAYm+yDl9Plh2p/zkJ
	JS+pkc8ZgJFYo+0w5BfNkHiykQ8PwFU+KjSwW+SOtkdegG2YS4okwUlWDQGWirLbXua7K5
	LrMQ9DddoVlZI5ccsLLITYt9SsTGBSA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-26PUxLtxOBSlOpd83WNZwA-1; Mon, 03 Mar 2025 11:30:22 -0500
X-MC-Unique: 26PUxLtxOBSlOpd83WNZwA-1
X-Mimecast-MFC-AGG-ID: 26PUxLtxOBSlOpd83WNZwA_1741019422
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ab5baf62cso34108735e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:30:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019421; x=1741624221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXwoThNtp+x7X/3NlVobY8ZdtRlIGCn0KXkmBvKPXvw=;
        b=Drj85+JYOx7dXhe9eLzdBcdj9Mbze1f10coLwi+gVajCRIYCAiPZFsLnZgQee+Xr6D
         aUYliWsIk3kmVlirG8Ap2vgqZCEOCRy8DX8NIfh5e7oqo/R7Agz1IYcr0D/3ElXYa7uX
         VxF3SNYTk3qGzNb5T0mL5baX/OFNikP6C6clI3Nwlh5+HKuETHQ6H/kLzxJ4bjMssFSa
         HcS9u04CBaX7vk5Vy6aRhJOu/21yzCl1mhrrrNRL5aH8UmSa+wVJLFljlQB6j1xFKWcc
         8s7aY4B9xkIRLX42exMirnjd/1TwDsXgqY9Y7K/hr4BsQjikxb8AO/BG+yimq+xlV6ir
         ctTg==
X-Gm-Message-State: AOJu0Yw2PIljdFr9rR33dY34ZoiAAQdjffeN7HGYYBQ0ha4eNYMJBYR6
	98hDZQ/E/5xvaI3jWFEStjoJ8FT8zDhbCzSGWebmSC4wcewJDClCII8yRPh10T4vbgmHO8RXwNu
	lI6c+lfu0WeXPxH3cKS8gKYjR0zxmqfySLpM0Vk01oqQwJ2Ty0ceM4aGRwS0RsS2FC199mVZEUB
	dC63kH9R7IEJPe9mjY8muDLw7+4Czfh9g606slrljFA15Z
X-Gm-Gg: ASbGncvvBl6M7kR9wRGbaUkiGcGTKXFf7rPPc3uupSd5pp5+lqQPmh5aDi/TBwU1dgj
	N8LtNHXYBWbRox1JLJB1blosB3wZIrHNreb2NB/1FpA3ak+sJ8lqv+liQd4q36zuAtXEQtzoaQy
	teyBoaKPPZTBaCN/lTgqmZjpdfNDeZEVuBVR9KBPDeTjc0sCbZR3M2Kq7XeD8c9OlNfj5oozdbJ
	Ph/JEPoleLQTC6Tm8v7D35atQvfAXZhhHA/k4r+ACmWcaHWU7/bVYURhkMMZx2bYltyURA8g4T9
	rTnZQ7Aeh/6HKKoMsXd1RTWWLDp6jXCqeUHceKpX5wnDkP+g2dT5d1S9H0b8rvW/YzA4rLlor4q
	4
X-Received: by 2002:a05:600c:5102:b0:43b:c0fa:f9eb with SMTP id 5b1f17b1804b1-43bc0faff85mr39510725e9.17.1741019421597;
        Mon, 03 Mar 2025 08:30:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuptMXo5vgbefj6sa5a5v3hHufhVKK5lbtZ5OlCKuge8xCX7GzdoorXNmVUyzEzt6+EvCK+w==
X-Received: by 2002:a05:600c:5102:b0:43b:c0fa:f9eb with SMTP id 5b1f17b1804b1-43bc0faff85mr39510065e9.17.1741019421019;
        Mon, 03 Mar 2025 08:30:21 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43aba58720esm198718765e9.40.2025.03.03.08.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:20 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v3 02/20] mm: factor out large folio handling from folio_nr_pages() into folio_large_nr_pages()
Date: Mon,  3 Mar 2025 17:29:55 +0100
Message-ID: <20250303163014.1128035-3-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303163014.1128035-1-david@redhat.com>
References: <20250303163014.1128035-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's factor it out into a simple helper function. This helper will
also come in handy when working with code where we know that our
folio is large.

While at it, let's consistently return a "long" value from all these
similar functions. Note that we cannot use "unsigned int" (even though
_folio_nr_pages is of that type), because it would break some callers
that do stuff like "-folio_nr_pages()". Both "int" or "unsigned long"
would work as well.

Maybe in the future we'll have the nr_pages readily available for all
large folios, maybe even for small folios, or maybe for none.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b2903bc705997..a743321dc1a5d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1199,6 +1199,18 @@ static inline unsigned int folio_large_order(const struct folio *folio)
 	return folio->_flags_1 & 0xff;
 }
 
+#ifdef CONFIG_64BIT
+static inline long folio_large_nr_pages(const struct folio *folio)
+{
+	return folio->_folio_nr_pages;
+}
+#else
+static inline long folio_large_nr_pages(const struct folio *folio)
+{
+	return 1L << folio_large_order(folio);
+}
+#endif
+
 /*
  * compound_order() can be called without holding a reference, which means
  * that niceties like page_folio() don't work.  These callers should be
@@ -2141,11 +2153,7 @@ static inline long folio_nr_pages(const struct folio *folio)
 {
 	if (!folio_test_large(folio))
 		return 1;
-#ifdef CONFIG_64BIT
-	return folio->_folio_nr_pages;
-#else
-	return 1L << folio_large_order(folio);
-#endif
+	return folio_large_nr_pages(folio);
 }
 
 /* Only hugetlbfs can allocate folios larger than MAX_ORDER */
@@ -2160,24 +2168,20 @@ static inline long folio_nr_pages(const struct folio *folio)
  * page.  compound_nr() can be called on a tail page, and is defined to
  * return 1 in that case.
  */
-static inline unsigned long compound_nr(struct page *page)
+static inline long compound_nr(struct page *page)
 {
 	struct folio *folio = (struct folio *)page;
 
 	if (!test_bit(PG_head, &folio->flags))
 		return 1;
-#ifdef CONFIG_64BIT
-	return folio->_folio_nr_pages;
-#else
-	return 1L << folio_large_order(folio);
-#endif
+	return folio_large_nr_pages(folio);
 }
 
 /**
  * thp_nr_pages - The number of regular pages in this huge page.
  * @page: The head page of a huge page.
  */
-static inline int thp_nr_pages(struct page *page)
+static inline long thp_nr_pages(struct page *page)
 {
 	return folio_nr_pages((struct folio *)page);
 }
-- 
2.48.1


