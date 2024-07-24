Return-Path: <linux-kernel+bounces-260502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCDC93AA4B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 03:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61DA41C22D6C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7A4BE71;
	Wed, 24 Jul 2024 01:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J62so7Gs"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009B15C99
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 01:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721783162; cv=none; b=GEDG/FoHq9PhpZXG5OgCb+pTxdNRVMYqBQRpqVNd13RkUEVBocyYSEmq6rpRA9oq6WrkB5+nU/tH/4w39HXxtjOoQMmbSUKrixv+4t9IRXSIYUF62Wibm0TFj7VJ7dqn9fGavNjhXJg2c459fQ4Vn4L0KXBDLCV1nG5a3nQPQL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721783162; c=relaxed/simple;
	bh=GwJNvq931G20gH0CQL3xXW+3Ks7XhNZBlOUlu8sD2zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9PVn8jbzeoRHVjKK8OWCp+ORgeJ7gg+gM/8etPkm31hLRnhPA8Fo0x80S7wYNtefT7pyhKuEhN+SDJGYq8sDN3ihnwCM1AWp4MKrLGvAQbPHoUkC/TgdE51U8FsfjBnLxh7taxWSBxQoRiNmpULFQ3AALXnekXL7FqHW6gMj5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J62so7Gs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=eFusLkbviS/7xHQGQO2zQewFlhdvWZpUW4NWdWMQGhg=; b=J62so7GsQlrq2UaPlrl2663LyB
	ZTGzko4Pa1OWiKK0+XQ/DFOcOAbhFhPDJiz2ZAHinFGsmdaks02Ut/cmN9FI7N7LLxL7o6BYAjZSa
	ELwKEWyKDpXUbwYLKh0iiI2IQWYjVBQO7QNGTLKYVf+4lA+GGzbfB86lpj11TRbrwsJ8tkTCeoDzf
	UGZNTn/71tPvGcORj6fR6sC1mEVHisbh3Ayqd1heabZn1XGOHRc3HTs2JB8grYxcSbck30h1xoUgA
	0Kqqtwuv0WcPHBkKg/RsdrtnQ6uHS1pMxfymnjRAD/0JVDWDP09QCDSPzjImYpLweU331qvXR0sWC
	NrHKliGA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWQS2-00000007MpG-2NZC;
	Wed, 24 Jul 2024 01:05:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/2] mm: Remove PG_error
Date: Wed, 24 Jul 2024 02:05:47 +0100
Message-ID: <20240724010550.1755992-3-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240724010550.1755992-1-willy@infradead.org>
References: <20240724010550.1755992-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PG_error bit is now unused; delete it and free up a bit in
page->flags.

Cc: linux-mm@kvack.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page-flags.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 5769fe6e4950..a0a29bd092f8 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -66,8 +66,6 @@
  * PG_referenced, PG_reclaim are used for page reclaim for anonymous and
  * file-backed pagecache (see mm/vmscan.c).
  *
- * PG_error is set to indicate that an I/O error occurred on this page.
- *
  * PG_arch_1 is an architecture specific page state bit.  The generic code
  * guarantees that this bit is cleared for a page when it first is entered into
  * the page cache.
@@ -103,7 +101,6 @@ enum pageflags {
 	PG_waiters,		/* Page has waiters, check its waitqueue. Must be bit #7 and in the same byte as "PG_locked" */
 	PG_active,
 	PG_workingset,
-	PG_error,
 	PG_owner_priv_1,	/* Owner use. If pagecache, fs may use*/
 	PG_arch_1,
 	PG_reserved,
@@ -183,7 +180,7 @@ enum pageflags {
 	 */
 
 	/* At least one page in this folio has the hwpoison flag set */
-	PG_has_hwpoisoned = PG_error,
+	PG_has_hwpoisoned = PG_active,
 	PG_large_rmappable = PG_workingset, /* anon or file-backed */
 };
 
@@ -506,7 +503,6 @@ static inline int TestClearPage##uname(struct page *page) { return 0; }
 
 __PAGEFLAG(Locked, locked, PF_NO_TAIL)
 FOLIO_FLAG(waiters, FOLIO_HEAD_PAGE)
-PAGEFLAG(Error, error, PF_NO_TAIL) TESTCLEARFLAG(Error, error, PF_NO_TAIL)
 FOLIO_FLAG(referenced, FOLIO_HEAD_PAGE)
 	FOLIO_TEST_CLEAR_FLAG(referenced, FOLIO_HEAD_PAGE)
 	__FOLIO_SET_FLAG(referenced, FOLIO_HEAD_PAGE)
-- 
2.43.0


