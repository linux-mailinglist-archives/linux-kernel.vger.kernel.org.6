Return-Path: <linux-kernel+bounces-193131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 757CA8D273C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C606B27B17
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A8D13E04F;
	Tue, 28 May 2024 21:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jYmTP6P9"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC5C17B4E7
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 21:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716932702; cv=none; b=YMhM9ajZM8goJ5pa2i25tXJk257e3/gM7VF2MpqTISOwhShwFWXwCVDo66OvghTin3MZ2ALDhU3yJcm8q0eGLstQWR3YM5JScRlegndXLUMIxKFcvOIhWZIViiygLHh9pCxufeu6tOZqWL6cEyDASKgFBT0tnd6JBUOsESdDpdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716932702; c=relaxed/simple;
	bh=VTtPrR4KmhUjYljEb8kfbrxj0xWTE0j4toW05KrtPrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMfsp7Ip2fEG5Y+AnxNfCJFQJ5B2QDpQuA5dd9Oafr4TuLhNMpocW0VLYq7rFTvDzumy6Z7Yqs2I7Bsh2CBzLejPspJMRArTW+NPhF34CIns2jAkQhJxRuTfk/jDcjrnFvjU6ApvI/9pVsDWij/7ZfmPwWCA8Znw8100medlK4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jYmTP6P9; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716932697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f4ula8SYVBjOfrvxjW/OkqDvPiEodD69W30PbWhQWRY=;
	b=jYmTP6P9ngp+GGp/Jp43SJZqmrpNAcaEPMeezUJYIj/+lpi5MWRiUA6ciB715FDT4xAecG
	oonitBUfENxBApr2YtRZE8X6UqIOqFl2SnRkXf/stwdJ2BGqowM3n9CGd+fNpnm1MeTZg8
	EXI6IPdTuZauhLzmc/DCB/RMi+YuHK8=
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: roman.gushchin@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v1 11/14] mm: memcg: make memcg1_update_tree() static
Date: Tue, 28 May 2024 14:44:32 -0700
Message-ID: <20240528214435.3125304-2-roman.gushchin@linux.dev>
In-Reply-To: <20240528214435.3125304-1-roman.gushchin@linux.dev>
References: <20240528202101.3099300-1-roman.gushchin@linux.dev>
 <20240528214435.3125304-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

memcg1_update_tree() is not used outside of mm/memcontrol-v1.c
anymore, define it as static and remove the declaration from
the header file.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/memcontrol-v1.c | 2 +-
 mm/memcontrol-v1.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 3972172f83624..b69181322fb18 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -201,7 +201,7 @@ static unsigned long soft_limit_excess(struct mem_cgroup *memcg)
 	return excess;
 }
 
-void memcg1_update_tree(struct mem_cgroup *memcg, int nid)
+static void memcg1_update_tree(struct mem_cgroup *memcg, int nid)
 {
 	unsigned long excess;
 	struct mem_cgroup_per_node *mz;
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 7be4670d9abbb..7d6ac4a4fb36d 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -5,7 +5,6 @@
 
 #include <linux/cgroup-defs.h>
 
-void memcg1_update_tree(struct mem_cgroup *memcg, int nid);
 void memcg1_remove_from_trees(struct mem_cgroup *memcg);
 
 static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg)
-- 
2.45.1


