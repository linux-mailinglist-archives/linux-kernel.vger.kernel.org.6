Return-Path: <linux-kernel+bounces-383076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7759B171C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 12:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47BE1B23310
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 10:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793951D278C;
	Sat, 26 Oct 2024 10:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aODZ7a8R"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212A118787E
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729938977; cv=none; b=kE5FHjzUYtOYTCrT3JYLwO5CZy3mEz86YCo2vXl0UQRf338Cw5KOztJP4Ywas3xXinxShFRtHxjOVksj8nloHXi7gvyvOIAOAAWuCZFOLjDhnCiRk4p3wHp7o+ywSL0I0s2zE+Xtf2J7tbKmmWVwqk73lS/ejdZATEq+QDOh21c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729938977; c=relaxed/simple;
	bh=4UXt8/Kszg8bsU7aXTCyE6xJPcY3M4s4X1dsWDs0I7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EdHaUcKSEUlm19oysiWl74EyePt0nFpJG2AYe8dsgKxW2duA+86mF0fbpdkPpOr8HY78nwa+h3EHpsLnCBS4eRgS9xXFml42+upxdjXTu1rWGhD3FG2/JAYaSE8TG9yf5aL9Hq5ctXAubvQQ+SuYYBlu7G3luUVm/avd8N7VTOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aODZ7a8R; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729938971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dypdP8xMbSsHFX0JaTEq7tX3wslgItQ6sGcFHYZDhjE=;
	b=aODZ7a8RGcbipFvJ9KkTmBh6u+2cjZIvy2bF4dKa8aJLDJwfi2XP9ELw8vk2zdPVVvDHlB
	7qPXGYqkQ8stbZsvkeA4mCMxHeC4+BBU6RjTtxH3SvA7Ry1cD+eo2jclixh4FLwEREe4bZ
	f7no3UpRYkO+jJaENIMpPpaYtjgzXbg=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/show_mem: Use str_yes_no() helper in show_free_areas()
Date: Sat, 26 Oct 2024 12:35:53 +0200
Message-ID: <20241026103552.6790-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_yes_no() helper function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 mm/show_mem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/show_mem.c b/mm/show_mem.c
index ec885a398fa0..43afb56abbd3 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -285,8 +285,7 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
 #endif
 			K(node_page_state(pgdat, NR_PAGETABLE)),
 			K(node_page_state(pgdat, NR_SECONDARY_PAGETABLE)),
-			pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES ?
-				"yes" : "no");
+			str_yes_no(pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES));
 	}
 
 	for_each_populated_zone(zone) {
-- 
2.47.0


