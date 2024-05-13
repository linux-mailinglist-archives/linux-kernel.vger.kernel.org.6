Return-Path: <linux-kernel+bounces-177114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F64A8C3A3F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 04:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5D961F21330
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 02:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A62B145B2D;
	Mon, 13 May 2024 02:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FmFkYfFz"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8801B12AAEA
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 02:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715568564; cv=none; b=Gzgbma37GxKdX4/1oc1O3WRRtw8X5pCNlShrlG8rS7nGWXWXyoxTPz+W5cNEALnM43f6ia7tjs0Do+nvteegTw2gh/ha/Qnjg3kM7YmNtf68m7OZ7eouNw2kyZrExxcq5iEqAlA6N0dDNuI+H3DeUDAXUbPZDCz0029XuLWIpPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715568564; c=relaxed/simple;
	bh=AoOSxNydD+EHdQxuKNNinvLQoWJfJcJnolZ8LmE2xzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KMie61SYwrA8UlTm3zKx1oKJDPq8wIdqLVyN81cKBZPm/gHzFMDaYgib+tEedZckgX1O9DQJQQmjMyB3gQPEQEhgb1/Y2pIZz3D2jG35HSILSDRbigl2UkWtEV8ENpdTKMMMdDvIxyhGfDIkgqXff4U1diCOI2qHZVkB8hDidGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FmFkYfFz; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715568560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=njswxGef3dHc43byLWCmojLKMpg5Ws59Tkr0jWYQsCM=;
	b=FmFkYfFzZJIPDpFS/pNlAnJVY7lrc3DGi3cybR2t+UU+3dcr7R84B14+cb0g+19cm1TYud
	WaN4jJetf7ohZxF11gdwmH1Kbha3KJyKLTbO3wo+HZGLwNhvh8CVrkId22qQtQq86Tqzfu
	rHh8zh9oAmC8lTBnT+F4eIHKjNixHvk=
From: Chengming Zhou <chengming.zhou@linux.dev>
Date: Mon, 13 May 2024 10:48:36 +0800
Subject: [PATCH v2 1/2] mm/ksm: fix ksm_pages_scanned accounting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240513-b4-ksm-counters-v2-1-f2520183a8ca@linux.dev>
References: <20240513-b4-ksm-counters-v2-0-f2520183a8ca@linux.dev>
In-Reply-To: <20240513-b4-ksm-counters-v2-0-f2520183a8ca@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
 Andrea Arcangeli <aarcange@redhat.com>, Stefan Roesch <shr@devkernel.io>, 
 xu xin <xu.xin16@zte.com.cn>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715568553; l=1386;
 i=chengming.zhou@linux.dev; s=20240508; h=from:subject:message-id;
 bh=AoOSxNydD+EHdQxuKNNinvLQoWJfJcJnolZ8LmE2xzk=;
 b=7a9RA8YFhery7+6k8xEhRF9WE18GFQ0bBh/5dKAeMRtMoEr0EGZfdiIf/V3jIWvsCyc+Q08pB
 VHqQisoeB0+Cd1UDdjLzffuRrtqIbzLwrjV19GOyeXBoMWbKD1fntrQ
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=kx40VUetZeR6MuiqrM7kPCcGakk1md0Az5qHwb6gBdU=
X-Migadu-Flow: FLOW_OUT

During testing, I found ksm_pages_scanned is unchanged although the
scan_get_next_rmap_item() did return valid rmap_item that is not NULL.

The reason is the scan_get_next_rmap_item() will return NULL after
a full scan, so ksm_do_scan() just return without accounting of the
ksm_pages_scanned.

Fix it by just putting ksm_pages_scanned accounting in that loop,
and it will be accounted more timely if that loop would last for
a long time.

Fixes: b348b5fe2b5f ("mm/ksm: add pages scanned metric")
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 mm/ksm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index e1034bf1c937..0f9c491552ff 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2753,18 +2753,16 @@ static void ksm_do_scan(unsigned int scan_npages)
 {
 	struct ksm_rmap_item *rmap_item;
 	struct page *page;
-	unsigned int npages = scan_npages;
 
-	while (npages-- && likely(!freezing(current))) {
+	while (scan_npages-- && likely(!freezing(current))) {
 		cond_resched();
 		rmap_item = scan_get_next_rmap_item(&page);
 		if (!rmap_item)
 			return;
 		cmp_and_merge_page(page, rmap_item);
 		put_page(page);
+		ksm_pages_scanned++;
 	}
-
-	ksm_pages_scanned += scan_npages - npages;
 }
 
 static int ksmd_should_run(void)

-- 
2.45.0


