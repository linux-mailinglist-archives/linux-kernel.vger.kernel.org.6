Return-Path: <linux-kernel+bounces-175353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5FB8C1E74
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF0F1F227F9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C3F15FA94;
	Fri, 10 May 2024 06:52:32 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B6915E810
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715323952; cv=none; b=Uy1AD/qAtb4hXOmlx+NNd0lM+gLAAOQZaEzO6OcC/Zd8qgOdqDLH0W2ZYerSVhFZpPig60Ajvb329pz2kzlTT3/t7FQQpMjugWzX/2g+V8bVd0Znc+kx4fCGz3O58Ii5uyt8uD2zpoiZSAX8nPdvexzVYIsO4SwRYxg9XDxUYdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715323952; c=relaxed/simple;
	bh=jZYYEN22FwfgAv99f+tq0XQ/kj/yrRu6yCvqz8y5jmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=R9www4ELfJq4kjFP1YBpWbZntNShKPRY+5CcBQsSZ+hmL0wa5EP//ja2RCYXsWOMwfzHGquOqT8tRU3iBdNGfZDQFhbWxYnfbEnm5jFi44NCT1XlczzEewqojWhQCCcd5epOz9V063qU5uft8ECIpsbNKjXLeKmR8jSLSEDrPRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-d8-663dc421ab13
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
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
	dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: [PATCH v10 05/12] mm: buddy: make room for a new variable, ugen, in struct page
Date: Fri, 10 May 2024 15:51:59 +0900
Message-Id: <20240510065206.76078-6-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240510065206.76078-1-byungchul@sk.com>
References: <20240510065206.76078-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsXC9ZZnoa7iEds0g9XTlCzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	gm8P2QquqlQc7pzE0sDYJtvFyMkhIWAi8X3GPHYY+/m3CawgNpuAusSNGz+ZQWwRATOJg61/
	wGqYBe4ySRzoZwOxhQUiJO69WsjUxcjOwSKgKnHYvouRg4NXwFTidAMTxEB5idUbDoAN4QQa
	8mHZDLC4EFBJx4OJjBA1n9kkWlcGQ9iSEgdX3GCZwMi7gJFhFaNQZl5ZbmJmjoleRmVeZoVe
	cn7uJkZgyC+r/RO9g/HTheBDjAIcjEo8vDs226QJsSaWFVfmHmKU4GBWEuGtqrFOE+JNSays
	Si3Kjy8qzUktPsQozcGiJM5r9K08RUggPbEkNTs1tSC1CCbLxMEp1cDoWPRIju/nDkU3n6tZ
	C+4zX1a1u+z/zbMq9umZiScz50g8msSxyOA524uMjwueF8Yvm9cTIGBw+U2ZTTlr2Xd9tt+T
	m466iezMjWgu2T1747+M3NOT8+V2ZU2L37W550fDqwSX2TXbMiasesS84+jT3OJviz5N52xf
	V+H6Q2di1fMNc1t+h5dkKLEUZyQaajEXFScCAFsp97R1AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsXC5WfdrKt4xDbN4E27hMWc9WvYLD5v+Mdm
	8WJDO6PF1/W/mC2efupjsTg89ySrxeVdc9gs7q35z2pxftdaVosdS/cxWVw6sIDJ4njvASaL
	+fc+s1ls3jSV2eL4lKmMFr9/ABWfnDWZxUHQ43trH4vHzll32T0WbCr12LxCy2PxnpdMHptW
	dbJ5bPo0id3j3blz7B4nZvxm8Zh3MtDj/b6rbB6LX3xg8tj6y86jceo1No/Pm+QC+KO4bFJS
	czLLUov07RK4MhZ8e8hWcFWl4nDnJJYGxjbZLkZODgkBE4nn3yawgthsAuoSN278ZAaxRQTM
	JA62/mEHsZkF7jJJHOhnA7GFBSIk7r1ayNTFyM7BIqAqcdi+i5GDg1fAVOJ0AxPEQHmJ1RsO
	gA3hBBryYdkMsLgQUEnHg4mMExi5FjAyrGIUycwry03MzDHVK87OqMzLrNBLzs/dxAgM4WW1
	fybuYPxy2f0QowAHoxIP747NNmlCrIllxZW5hxglOJiVRHiraqzThHhTEiurUovy44tKc1KL
	DzFKc7AoifN6hacmCAmkJ5akZqemFqQWwWSZODilGhgltu8Mvux5OU+RNT9R8EXD9N7dcw/o
	ce3xzUlPt2xb+Ch41YPtuZa7j16ynLjiySLmwzELlzuvX1LpaiOSYqn1syizrXC5fvjqS1cb
	/zfeYJ/KbT7TfmPLzXtFh59x9W+41rngjMC5rU/S/af//W+pf33G41pR7ln/DpjnsJ7j4DaV
	Dq958f+aEktxRqKhFnNRcSIAGjUyt10CAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Functionally, no change.  This is a preparation for luf mechanism that
tracks need of tlb flush for each page residing in buddy, using a
generation number in struct page.

Fortunately, since the private field in struct page is used only to
store page order in buddy, ranging from 0 to MAX_PAGE_ORDER, that can be
covered with unsigned short int.  So splitted it into two smaller ones,
order and ugen, so that the both can be used in buddy at the same time.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mm_types.h | 40 +++++++++++++++++++++++++++++++++-------
 mm/internal.h            |  4 ++--
 mm/page_alloc.c          | 13 ++++++++-----
 3 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index db0adf5721cc..cd4ec0d10ffb 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -108,13 +108,25 @@ struct page {
 				pgoff_t index;		/* Our offset within mapping. */
 				unsigned long share;	/* share count for fsdax */
 			};
-			/**
-			 * @private: Mapping-private opaque data.
-			 * Usually used for buffer_heads if PagePrivate.
-			 * Used for swp_entry_t if PageSwapCache.
-			 * Indicates order in the buddy system if PageBuddy.
-			 */
-			unsigned long private;
+			union {
+				/**
+				 * @private: Mapping-private opaque data.
+				 * Usually used for buffer_heads if PagePrivate.
+				 * Used for swp_entry_t if PageSwapCache.
+				 */
+				unsigned long private;
+				struct {
+					/*
+					 * Indicates order in the buddy system if PageBuddy.
+					 */
+					unsigned short int order;
+					/*
+					 * Tracks need of tlb flush used by luf,
+					 * which stands for lazy unmap flush.
+					 */
+					unsigned short int ugen;
+				};
+			};
 		};
 		struct {	/* page_pool used by netstack */
 			/**
@@ -521,6 +533,20 @@ static inline void set_page_private(struct page *page, unsigned long private)
 	page->private = private;
 }
 
+#define page_buddy_order(page)		((page)->order)
+
+static inline void set_page_buddy_order(struct page *page, unsigned int order)
+{
+	page->order = (unsigned short int)order;
+}
+
+#define page_buddy_ugen(page)		((page)->ugen)
+
+static inline void set_page_buddy_ugen(struct page *page, unsigned short int ugen)
+{
+	page->ugen = ugen;
+}
+
 static inline void *folio_get_private(struct folio *folio)
 {
 	return folio->private;
diff --git a/mm/internal.h b/mm/internal.h
index c6483f73ec13..eb9c7d8650fc 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -453,7 +453,7 @@ struct alloc_context {
 static inline unsigned int buddy_order(struct page *page)
 {
 	/* PageBuddy() must be checked by the caller */
-	return page_private(page);
+	return page_buddy_order(page);
 }
 
 /*
@@ -467,7 +467,7 @@ static inline unsigned int buddy_order(struct page *page)
  * times, potentially observing different values in the tests and the actual
  * use of the result.
  */
-#define buddy_order_unsafe(page)	READ_ONCE(page_private(page))
+#define buddy_order_unsafe(page)	READ_ONCE(page_buddy_order(page))
 
 /*
  * This function checks whether a page is free && is the buddy
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 33d4a1be927b..917b22b429d1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -565,9 +565,12 @@ void prep_compound_page(struct page *page, unsigned int order)
 	prep_compound_head(page, order);
 }
 
-static inline void set_buddy_order(struct page *page, unsigned int order)
+static inline void set_buddy_order_ugen(struct page *page,
+					unsigned int order,
+					unsigned short int ugen)
 {
-	set_page_private(page, order);
+	set_page_buddy_order(page, order);
+	set_page_buddy_ugen(page, order);
 	__SetPageBuddy(page);
 }
 
@@ -834,7 +837,7 @@ static inline void __free_one_page(struct page *page,
 	}
 
 done_merging:
-	set_buddy_order(page, order);
+	set_buddy_order_ugen(page, order, 0);
 
 	if (fpi_flags & FPI_TO_TAIL)
 		to_tail = true;
@@ -1344,7 +1347,7 @@ static inline void expand(struct zone *zone, struct page *page,
 			continue;
 
 		__add_to_free_list(&page[size], zone, high, migratetype, false);
-		set_buddy_order(&page[size], high);
+		set_buddy_order_ugen(&page[size], high, 0);
 		nr_added += size;
 	}
 	account_freepages(zone, nr_added, migratetype);
@@ -6802,7 +6805,7 @@ static void break_down_buddy_pages(struct zone *zone, struct page *page,
 			continue;
 
 		add_to_free_list(current_buddy, zone, high, migratetype, false);
-		set_buddy_order(current_buddy, high);
+		set_buddy_order_ugen(current_buddy, high, 0);
 	}
 }
 
-- 
2.17.1


