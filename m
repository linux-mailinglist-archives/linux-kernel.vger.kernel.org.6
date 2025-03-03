Return-Path: <linux-kernel+bounces-542242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F259EA4C7D5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E11D17AA1E7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A90923E227;
	Mon,  3 Mar 2025 16:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UkEcHXnI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F1823BF88
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019435; cv=none; b=sESba6hK6d79Hj/2OS2fla8Y2edm8Dz98ONGxMud7N5AAdRGRCgn30VFHBGYaWj1h9ixyQ/oDAMawB+lO01rkatO9fgn2oAIksn/S+N5sufjx2gWV4qKGMONQITj9f8wEfWzRNFICTP5WKFlyjilUyhOVAZFWP5lcXOwsdxqWgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019435; c=relaxed/simple;
	bh=3SmHXztWFIDnuQM+XInecxapotD7TtFOOmhMRtX7whw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9aWg27dOk72/iT1yvZ3n4V5Mv3M6KMS6jCU1JJAyZZnLz9cQiWaE5GVncoh5E6xRLNkguy8YTg7Io4rLDg9seXwJ8gPXawVjACYAvkMjEdI6OVBDscsH9maQNbcIMUHyA2Q+1ARIwTFw1lqr+/oA90jdEW+BAEtOMKr42noHAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UkEcHXnI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IqquS7ke+4+XOv5L24m6qSx7K0PzdfhIUdS/cnqyVA=;
	b=UkEcHXnI3GLF8ReZDaoyS0YCTDlM4iKUqNgir6Zga/hCyQZHPEahy5rg/7BiDe+3GfwyhN
	4TXK9mmgQh3sIWTg5Xf41pHviu+1LfvO7uMmGL8zzV5BSYkYODEPlhbHg/ayyethG7m6ep
	DFgjkvr4KCrIPAq/1CSjnu3weqgfnZc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-lvltfKQNPbyJGdnSiMcbBg-1; Mon, 03 Mar 2025 11:30:20 -0500
X-MC-Unique: lvltfKQNPbyJGdnSiMcbBg-1
X-Mimecast-MFC-AGG-ID: lvltfKQNPbyJGdnSiMcbBg_1741019419
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39101511442so704078f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:30:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019419; x=1741624219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8IqquS7ke+4+XOv5L24m6qSx7K0PzdfhIUdS/cnqyVA=;
        b=UqJwbp9bQy03YXeL3f6h8p6WYy3cOXN6HmAYsqJREL6khhBYJtFZQwR3IU39WOiA7X
         /PAFcXP/Ma99EzozN0zAxbGdkSTueXI841MUwzS2rIwFBkxwI8mSl2dXadC4BCTIMJ4e
         +j9fnbwvoOe2xCVDwATrQ+CkqBItgvSgWNhVSisAtSaUWWdRl8NWueZ5vwLpUivyLS4D
         Ifu0D0xUElBnCf6ZlXpZrRzQymTzJkmYUUDXIRZrPT+IDHaR0KrVxyQ00esqHybU7igo
         P1JRguxtU/lf7nH8uO9/eUyvs8YjvGpvViU6DoF8fCkjovefADCwIi0RaUZ3hgcC7Pt7
         oauw==
X-Gm-Message-State: AOJu0Yy+94Jl8r6jqY/1d64N+4GVEhTdtu5s22M/XyZml0oT3/kFGaA9
	O492C7vrG4QMIftMpLpQ+dx5+APj4UykVvJSFBuq3u2hGCn+y4bzWzPikiY+k4bDdKf7o9izlRh
	nqLf1sOKX1b2esnMmVT7UbYRVmEYqaY+Vjajttvjvzq5jqCi1L+x9ElLOBLqjqI8L880g1zj9YH
	RLzv0WPfsRBDn0bj3rz76mXyYBGJIAsj56fFr1KZGyuzdh
X-Gm-Gg: ASbGncuudJE4WX0DfaASppkJBE6qX7iJ6bKJMs3kTUxv0rtG0d8lwi6WS6UvM8ke9f7
	vQ5mKF7f48Kj1eu9gn1qDx8jUC6grphUfnIDkEYIb7tfai522JiGTcmI1bPnoofFMNhX2DfSY69
	orUnRwTUVS4y1lllB3o0be6AGVTqytvmrhAFKuYSsRf9qI0h9s6xAFTY9693ghKbyULdrVl0cXA
	NIYGOBidYn3WK41Lqi4F91dY5D50VRljN1giIUzf5YZycCm5Zg7o08xr/0NRqsILrTs9iDKe/5l
	TUdTzw9JFfpNDFrJNtUVssRzdnmNdusRjiFb+OaqLC67FG4WflF1xw5fuKYj6abzTEto0RnTGtJ
	j
X-Received: by 2002:a05:6000:156e:b0:390:f9d0:5e7 with SMTP id ffacd0b85a97d-390f9d00782mr6547302f8f.13.1741019419323;
        Mon, 03 Mar 2025 08:30:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXzBd/+KVXhEWpKLy7bok4As8+LKdGdnCV2QCwLiXkX4QDGRFFrxDGOYHa7Hz+LJLKECZ5dQ==
X-Received: by 2002:a05:6000:156e:b0:390:f9d0:5e7 with SMTP id ffacd0b85a97d-390f9d00782mr6547256f8f.13.1741019418889;
        Mon, 03 Mar 2025 08:30:18 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e47a6a5esm15196816f8f.35.2025.03.03.08.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:18 -0800 (PST)
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
	Lance Yang <ioworker0@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v3 01/20] mm: factor out large folio handling from folio_order() into folio_large_order()
Date: Mon,  3 Mar 2025 17:29:54 +0100
Message-ID: <20250303163014.1128035-2-david@redhat.com>
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

Maybe in the future we'll have the order readily available for small and
large folios; in that case, folio_large_order() would simply translate to
folio_order().

Reviewed-by: Lance Yang <ioworker0@gmail.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b21b48627b05..b2903bc705997 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1194,6 +1194,11 @@ struct inode;
 
 extern void prep_compound_page(struct page *page, unsigned int order);
 
+static inline unsigned int folio_large_order(const struct folio *folio)
+{
+	return folio->_flags_1 & 0xff;
+}
+
 /*
  * compound_order() can be called without holding a reference, which means
  * that niceties like page_folio() don't work.  These callers should be
@@ -1207,7 +1212,7 @@ static inline unsigned int compound_order(struct page *page)
 
 	if (!test_bit(PG_head, &folio->flags))
 		return 0;
-	return folio->_flags_1 & 0xff;
+	return folio_large_order(folio);
 }
 
 /**
@@ -1223,7 +1228,7 @@ static inline unsigned int folio_order(const struct folio *folio)
 {
 	if (!folio_test_large(folio))
 		return 0;
-	return folio->_flags_1 & 0xff;
+	return folio_large_order(folio);
 }
 
 #include <linux/huge_mm.h>
@@ -2139,7 +2144,7 @@ static inline long folio_nr_pages(const struct folio *folio)
 #ifdef CONFIG_64BIT
 	return folio->_folio_nr_pages;
 #else
-	return 1L << (folio->_flags_1 & 0xff);
+	return 1L << folio_large_order(folio);
 #endif
 }
 
@@ -2164,7 +2169,7 @@ static inline unsigned long compound_nr(struct page *page)
 #ifdef CONFIG_64BIT
 	return folio->_folio_nr_pages;
 #else
-	return 1L << (folio->_flags_1 & 0xff);
+	return 1L << folio_large_order(folio);
 #endif
 }
 
-- 
2.48.1


