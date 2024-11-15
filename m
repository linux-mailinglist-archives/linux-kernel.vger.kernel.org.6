Return-Path: <linux-kernel+bounces-411200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9503A9CF47E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5082814FA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E101E1311;
	Fri, 15 Nov 2024 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PS2jU747"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEAB1E0E18
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731697371; cv=none; b=AXeO5t/qOyC8wPaO6VeGvX8fKxgz48a7YqZjfWLSl6juH60PtXfRjJCzRVaLb7k7jYhBP9s8Ho7oGf8CwVj6xYsWymD8N6xJ3Kvj0t+CawXBkTIcD487MjdK1+hc8ijis4E/btqoGX+NLjq7K/75hRrpPqXYPkxDJV/mZp+yBNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731697371; c=relaxed/simple;
	bh=4N73nbUT+IZXrfwYGdVjZGSNPpstuB7kc2Xaov+OipM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6z2V7DPMxDQaUEGNycqYOWTI4x3ID0C7mPdg1KqXWujXILutr1TFFoQw/2Z428qj/F682zj2soNDORjKMxyc+lv0nw4kZINKT/yZdRDRvjSOSKQl1tRI5M5MdEb+QJnFJDTwIuUvXrcpZpnhFUANbUTIZtku8hl7VUmuvVbeZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PS2jU747; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731697367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cChRt8Y/7rNJ+UE7EiKYAmqcqG+mD3DTpu3d12HPnTc=;
	b=PS2jU747h5/TqBqugYikH8pMT78fDosPtIf0M28FYdx2T7/Gr6zIEe3lht9AD5mbdmazLO
	S/zp1C2BigugXatQzPfouGIr828SdBJx3dPkpETc6WcAlS9TlVhmpjTy4kiwR9wm69Woz+
	rtBwb/L6PPRRVYlYQGVLrRotXjfdrbw=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH 2/2] mm: swap_cgroup: get rid of __lookup_swap_cgroup()
Date: Fri, 15 Nov 2024 19:02:29 +0000
Message-ID: <20241115190229.676440-2-roman.gushchin@linux.dev>
In-Reply-To: <20241115190229.676440-1-roman.gushchin@linux.dev>
References: <20241115190229.676440-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Because swap_cgroup map is now virtually contiguous,
swap_cgroup_record() can be simplified, which eliminates
a need to use __lookup_swap_cgroup().

Now as __lookup_swap_cgroup() is really trivial and is used only once,
it can be inlined.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/swap_cgroup.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
index 18de498c84a4..0db907308c94 100644
--- a/mm/swap_cgroup.c
+++ b/mm/swap_cgroup.c
@@ -33,13 +33,6 @@ static struct swap_cgroup_ctrl swap_cgroup_ctrl[MAX_SWAPFILES];
  *
  * TODO: we can push these buffers out to HIGHMEM.
  */
-
-static struct swap_cgroup *__lookup_swap_cgroup(struct swap_cgroup_ctrl *ctrl,
-						pgoff_t offset)
-{
-	return &ctrl->map[offset];
-}
-
 static struct swap_cgroup *lookup_swap_cgroup(swp_entry_t ent,
 					struct swap_cgroup_ctrl **ctrlp)
 {
@@ -49,7 +42,7 @@ static struct swap_cgroup *lookup_swap_cgroup(swp_entry_t ent,
 	ctrl = &swap_cgroup_ctrl[swp_type(ent)];
 	if (ctrlp)
 		*ctrlp = ctrl;
-	return __lookup_swap_cgroup(ctrl, offset);
+	return &ctrl->map[offset];
 }
 
 /**
@@ -104,16 +97,9 @@ unsigned short swap_cgroup_record(swp_entry_t ent, unsigned short id,
 
 	spin_lock_irqsave(&ctrl->lock, flags);
 	old = sc->id;
-	for (;;) {
+	for (; offset < end; offset++, sc++) {
 		VM_BUG_ON(sc->id != old);
 		sc->id = id;
-		offset++;
-		if (offset == end)
-			break;
-		if (offset % SC_PER_PAGE)
-			sc++;
-		else
-			sc = __lookup_swap_cgroup(ctrl, offset);
 	}
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 
-- 
2.47.0.338.g60cca15819-goog


