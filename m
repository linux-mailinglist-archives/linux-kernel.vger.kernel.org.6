Return-Path: <linux-kernel+bounces-569197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D913A69FDC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1828A2584
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 06:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E0C1E412A;
	Thu, 20 Mar 2025 06:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZtTtNvvw"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5063979C0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 06:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742452439; cv=none; b=D3CXt5hv7GFZUVMJyOMAT5SjHQLxjvozKC1A9Xl0OBC9sonN6vb5hS2FJvRfpm/DM1D7jSRJtnmWXIO++4fujx3kr5fSr+cCMalM61dz6v6txYMODUAv2Omvx1ECyQB3hzENiftHnf8ZY1zfqlAH8X3nFCFZy7vXGawb4ZcRio4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742452439; c=relaxed/simple;
	bh=r0YxBVzqF6FT2U7ubCH5bnzBWVHa9toEWSJSXDACIlM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kwPC3qk7wsogou0BayZIhSA+C1VtoyljA4BzQyPWFUjCcZ0/qataHIablfCaDVBWpxVEb9AmWP0x2trgHY/PzLTQF+rHe616ggWjcPGApXLarDTlDEtKyYMhiS8K6/HQMumkE6+Zd8gS3SWYFh66oQuslpY8te9WGMos/sd/gcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZtTtNvvw; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742452432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o6vz2Uum7V0NtgsnsI1Vcgpq3qaTTgJQFNM5RCxP2BI=;
	b=ZtTtNvvw4VEBhb5U856KHiZLnmspfOpjMoRve7WJzlCAE5G3ckPyismGgsNHEZMoA73ylm
	Rf3X7j5x0xMW3fNIcJRhJM0sXMyL4/bpvz6WAJ52hZx+nbchYQ17MWN3s0tae4/RS8SEWY
	MuKaXHmvQvW1g45s0zBD1KonnChuLrc=
From: Ye Liu <ye.liu@linux.dev>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Ye Liu <liuye@kylinos.cn>
Subject: [PATCH] mm/page_alloc: Replace flag check with PageHWPoison() in check_new_page_bad()
Date: Thu, 20 Mar 2025 14:33:46 +0800
Message-Id: <20250320063346.489030-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Ye Liu <liuye@kylinos.cn>

This patch replaces the direct check for the __PG_HWPOISON flag with
the PageHWPoison() macro, improving code readability and maintaining
consistency with other parts of the memory management code.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fe76fd237dd0..6ef54abebf51 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1427,7 +1427,7 @@ static __always_inline void page_del_and_expand(struct zone *zone,
 
 static void check_new_page_bad(struct page *page)
 {
-	if (unlikely(page->flags & __PG_HWPOISON)) {
+	if (unlikely(PageHWPoison(page))) {
 		/* Don't complain about hwpoisoned pages */
 		if (PageBuddy(page))
 			__ClearPageBuddy(page);
-- 
2.25.1


