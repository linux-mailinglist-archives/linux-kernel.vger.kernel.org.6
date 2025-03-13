Return-Path: <linux-kernel+bounces-558755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36753A5EAB3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 05:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E5927AA7AD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 04:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB093149DE8;
	Thu, 13 Mar 2025 04:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="b9oT00sl"
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E261386DA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 04:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741840856; cv=none; b=lKF+KRzaJUdiDfln0oO1fPrhziSY7qEvodsIe9D/Z6iN2JqwNg0njxRwRrvQkbnhz+vgiJBVr+Kgrf9t2nNDM3xSBZ0SI6MzeP92wT6ElzuUU8o04+ERoUa/s9AuCNBzMyjIkeJO7hb7u38jDFcfgtho5BtqGNBoycVEyBhq7R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741840856; c=relaxed/simple;
	bh=g70bD4HYTcy5uhQr/oheCZwZ2hOfkGMFCmt7uvKBKUM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U5826Ze4akhwRLXgdzRvGEFL/TmnvOL6uOzQ/WuyTr0yEKBKmG+Olqg3eBiSc5XiDKrjxtPe43fotUrcDidspSh9pwujuTc0LXGb4UFSC52RqIHVNVtIE7v9427kbwT+7tpBrPh2hwZdyZcAorZHCQ35lB2VFP4e/V8rg2XxRJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=b9oT00sl; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:
	Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=lXHRa+oExN9zXZEhKA+D04KHA7QghE0Lto71uVp3zwA=; b=b9oT00slAzCp98rGiq8aMWQhnE
	20aBFhnltZYGK9TrEaOTCrtTe5w4wRIf+wMZU3NwUMIXwoss4yU0NmCswX+qx2TiGyMBu4Lc/yu9i
	Aw1O2Tx3FCkUT0wwth8gBcC8bcjYrJ5X3beNK9evTFA2AUg3i/fkuccGgbXkzuXJSwETJXq/QdvQ+
	kJ9/6exH7XC5b7uEzG1YEro+qc6NtxclAFfWd9bQO2g2+Rgxump7M/Do63w8ENfBEFqfc6eEeQawr
	t9F/VvpfX8uQ78Gg/HiE45b806lK49AGlsXilVfYc2yYSYIf4NeCzv9vwrGRpSnScOYDo68W8bErQ
	s38f3h+w==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tsaN0-00687w-14;
	Thu, 13 Mar 2025 12:40:35 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 13 Mar 2025 12:40:34 +0800
Date: Thu, 13 Mar 2025 12:40:34 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>, Zi Yan <ziy@nvidia.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] mm: Move nth_page from folio_page into folio_next
Message-ID: <Z9JhwhMIn4uhkHrI@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Discontiguous memory may require the use of nth_page instead of adding
to struct page arithmetically.  However, discontiguous memory cannot
exist within a single folio.

The function folio_page is mostly used for accessing a page within
a folio, therefore using nth_page for it is overkill.

Move it to the only place where it's needed, which is folio_next.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b1068ddcbb7..5f63ee0770f7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2115,7 +2115,7 @@ static inline int thp_nr_pages(struct page *page)
  */
 static inline struct folio *folio_next(struct folio *folio)
 {
-	return (struct folio *)folio_page(folio, folio_nr_pages(folio));
+	return (struct folio *)nth_page(&folio->page, folio_nr_pages(folio));
 }
 
 /**
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 36d283552f80..ebba355c45a5 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -275,7 +275,7 @@ static __always_inline unsigned long _compound_head(const struct page *page)
  * check that the page number lies within @folio; the caller is presumed
  * to have a reference to the page.
  */
-#define folio_page(folio, n)	nth_page(&(folio)->page, n)
+#define folio_page(folio, n)	(&(folio)->page + (n))
 
 static __always_inline int PageTail(const struct page *page)
 {
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

