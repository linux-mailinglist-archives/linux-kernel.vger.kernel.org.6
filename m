Return-Path: <linux-kernel+bounces-576374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D742A70E68
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 02:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA21217081A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 01:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7727C20328;
	Wed, 26 Mar 2025 01:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O4CKZNso"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC09D2904
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 01:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742952313; cv=none; b=AceSh7ylCwAjB41F/OCs7YsmB/zda/nkE7ohAQmvTwg4RBCv8Rzr2qGWv3xilvLBw8LInVPNu5ANb9EgnRpDvyxnoIEFN/GC8M3f5m1/L0BNregx9bhbPKL9IIu1MvXxQmEqc+G5W7DhiR6Him2AG7W0fDqivL3ejb/t0ajkdes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742952313; c=relaxed/simple;
	bh=shUYPh4/mHAX59wbsWNJI/e4b3Zln6lKwqoKdq0wRxA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ub76PAKq55ClhBJSucdehX9tvPsgKnBub3cycYwSi/oUfXigRmFFTFbN9cWdGIKm7QwA/PKWj0FaHv5sr1QK8Wqf3NQ5v2y09Hy2lb/+9TBD26hXINAZEJ79X9DWgdAPoRc01CHTk5kvHjGljxvFUhZN7VfqOYfSfXSiR+Rma+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O4CKZNso; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742952309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T6GKle7+93Rexc24wMdk57QxfcApkMBPUwEhlyUOIQA=;
	b=O4CKZNsoRjPFpJ9iUX0D77KR/YbD2iznc1Hzq0nhFsiJ3SqWyh47DtnalnueJEvB3nfN66
	+ImI/dNFPNC492w0c57lJaBLIj80jNwA70jPCG+C4q7f+P8TraQJlubRZol2QN2JnVCmEQ
	1lhIEbTr0z7mETqRJik29mnVenoi6AA=
From: Ye Liu <ye.liu@linux.dev>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	anshuman.khandual@arm.com,
	Ye Liu <liuye@kylinos.cn>
Subject: [PATCH v3] mm/page_alloc: Simplify free_page_is_bad by removing free_page_is_bad_report
Date: Wed, 26 Mar 2025 09:24:34 +0800
Message-Id: <20250326012434.918844-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Ye Liu <liuye@kylinos.cn>

Refactors the free_page_is_bad function by directly calling bad_page() 
instead of using the intermediary function free_page_is_bad_report(). 
The removal of free_page_is_bad_report() reduces unnecessary indirection,
making the code cleaner and easier to read.

The functionality remains the same, as free_page_is_bad_report() was
merely a wrapper for the bad_page() call. The patch also improves
maintainability by reducing the function call depth.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

---
V3: Delete 'This patch'.
V2: Simplify the code by removing unnecessary line breaks.
---
---
 mm/page_alloc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 61d6a3b1b286..60c54ba78a11 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -933,19 +933,13 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
 	return bad_reason;
 }
 
-static void free_page_is_bad_report(struct page *page)
-{
-	bad_page(page,
-		 page_bad_reason(page, PAGE_FLAGS_CHECK_AT_FREE));
-}
-
 static inline bool free_page_is_bad(struct page *page)
 {
 	if (likely(page_expected_state(page, PAGE_FLAGS_CHECK_AT_FREE)))
 		return false;
 
 	/* Something has gone sideways, find it */
-	free_page_is_bad_report(page);
+	bad_page(page, page_bad_reason(page, PAGE_FLAGS_CHECK_AT_FREE));
 	return true;
 }
 
-- 
2.25.1


