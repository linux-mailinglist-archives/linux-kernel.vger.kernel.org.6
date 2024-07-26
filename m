Return-Path: <linux-kernel+bounces-263731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D2F93D9CD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A95285F27
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C5614A633;
	Fri, 26 Jul 2024 20:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tPfGve9A"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948C6149C41
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 20:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722025890; cv=none; b=WhI80YLsGfHt6UNyPZily4FyaG84X9ODUFr7S2HG4Cct86p16MQoiSOg7wvCPAHD7BAhbux/2S7eKTJbct6Zy0F1Qp3vL9spNqxPhBej1ko9JkB478HeIXxRzsJTxX5EqrbZvjRYmtf9nyER8tS64pP+yMWFSbM/OKOGkhCLsgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722025890; c=relaxed/simple;
	bh=1tSc6ZqMPnCUuXZxIsPKN6jXbjQ2nGcQgPPAnf50rlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkQ43uex1tQ5wG4xr5Qb+OF3lsOUPfnXdM19HP9X48wA9Sn5T+HR1Me0LC+mbHl3YQkuanblahOe5gdPgFKZWK9NRL9DXAMMEhVMeEgK0jME3cUMnCtxZfNhTnyNPQqoJifEu4Ja2KuXBkAO3Xo6PTDO+J0Qoj8OVSbRBUj58m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tPfGve9A; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722025886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k2RQKi54iBuphHPxmjb/1iWIMtoBoWz8KpxZMw88GiU=;
	b=tPfGve9AobnH69FXzvOlaxwcck8wXf2NYe8+7xG+07UVPVn7cVKNPa3aD5YxL59MvWNtuW
	UMgzDrPzE4lb7kiFnGPkzXy9VQDDNmj3q881cb9uV9IbAIrWZjny7wtw6d4ufzJ/QFBD7G
	xQh8n9ij+WXj7sJzVJ4CbBnbTW4cBGM=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v3 3/3] mm: page_counters: initialize usage using ATOMIC_LONG_INIT() macro
Date: Fri, 26 Jul 2024 20:31:10 +0000
Message-ID: <20240726203110.1577216-4-roman.gushchin@linux.dev>
In-Reply-To: <20240726203110.1577216-1-roman.gushchin@linux.dev>
References: <20240726203110.1577216-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When a page_counter structure is initialized, there is no need to
use an atomic set operation to initialize the usage counter because
at this point the structure is not visible to anybody else.
ATOMIC_LONG_INIT() is what should be used in such cases.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/page_counter.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index cf837d0f8ed1..5da11392b382 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -53,7 +53,7 @@ static inline void page_counter_init(struct page_counter *counter,
 				     struct page_counter *parent,
 				     bool protection_support)
 {
-	atomic_long_set(&counter->usage, 0);
+	counter->usage = (atomic_long_t)ATOMIC_LONG_INIT(0);
 	counter->max = PAGE_COUNTER_MAX;
 	counter->parent = parent;
 	counter->protection_support = protection_support;
-- 
2.46.0.rc1.232.g9752f9e123-goog


