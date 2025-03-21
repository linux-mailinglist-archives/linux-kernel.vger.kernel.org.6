Return-Path: <linux-kernel+bounces-570791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C543A6B489
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBAE04847ED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7491EB184;
	Fri, 21 Mar 2025 06:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bQ0HJL6l"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F861E8333
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742539227; cv=none; b=eUFHCK87gEtMCu0Xo48oCFaHQIxAqt4X3iQE44fBPjLRci4DmyvOAojjvAgU5thfYksCCqO+uDDERj9yfzIo+4ila95iTjI/x6mP47jM6+4NLP7r+XWQ2NnOgZmFNpweXZtnDhkNW3eUGkEnbOwnjAbXSBNrECdE+PFjuuTSQ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742539227; c=relaxed/simple;
	bh=54/Yqhxj9S2BmqlXvu6SkT0VOC7bHsoQW5vYsIy9oL0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ElMgeQGAYIRTu/iCL1Wy6F2EbD8A1c0mTtbOJzSQNiB28CX4v8eUsTnjpnO2boFZSts94F2wM6mnSQF1vIqiHQMP09dn8L2MWZw7ID7bb5GTwlXKdxxX3TYZkVzcL/JxPdUD4X0LgBjV8jJQLOD9dtUInVcYvBRuZUITixlf0s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bQ0HJL6l; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742539221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wfCxnUDZ4/a0LOQ7Hfhp9OJ19Sm5M7MD6UuIrGvTujE=;
	b=bQ0HJL6lWhxf0MXlS5Sc2TmSh9daaF0DUMA76BE77ARg2roC+WQEGTAC7x7yYuoyhVSy1s
	jpjLZwq6AZ9yOV0A5XZOxyZhHoJ/FC44KE8lzZai9RHbw79zSWr8XosyGvmHj+dm6z6BC4
	g4fngpFJeObDWDcRbin6VTHgpLB8Ps4=
From: Ye Liu <ye.liu@linux.dev>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Ye Liu <liuye@kylinos.cn>,
	Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v2] mm/page_alloc: Simplify free_page_is_bad by removing free_page_is_bad_report
Date: Fri, 21 Mar 2025 14:40:11 +0800
Message-Id: <20250321064011.612336-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Ye Liu <liuye@kylinos.cn>

This patch refactors the free_page_is_bad function by directly calling
bad_page() instead of using the intermediary function
free_page_is_bad_report(). The removal of free_page_is_bad_report()
reduces unnecessary indirection, making the code cleaner and easier to
read.

The functionality remains the same, as free_page_is_bad_report() was
merely a wrapper for the bad_page() call. The patch also improves
maintainability by reducing the function call depth.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

---
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


