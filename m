Return-Path: <linux-kernel+bounces-260230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCFC93A4BE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78835283A6D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6851157E84;
	Tue, 23 Jul 2024 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ucsEjwFA"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6864814D431
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721754800; cv=none; b=WlTW1RYNhpX9KObXHyuEWAG+/oyipebFkndZ87s/MMMJeNNuOAPlxRLtdvXD34p+eSb3rfoAYOSN8CIlVxtMCqRwW/kFTVkNHcMKtRV67xhphtG6qjYcgZW3NsTwIZDvi0tw75vY8g9DFoLWBE6Ppo2mhAQfLBVuNQI8+BxCZj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721754800; c=relaxed/simple;
	bh=4paGlhH/Aypyp/LG/X6ZYeFrNUMMuieVYmt0yYwo4EU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZSi6t/bmsXFarkwUKUOWK8gLvLAXXziuHORJR0YY51AXLIyqAGX6LpkCfRSbcU+rhuQRctgJGV77CRh3+WvoHLAYAxdf2Gu+3VnwdGDXYgwk7XYecpDRKYmQbu4PbdYvwYPEEEklBhG3IuOWXdwQVzHFhtuPAVaYnmqUQBfgtHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ucsEjwFA; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721754792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dLz0vahepvw5FTvGG6yOrYP5EjiNPFCxxG6q6oBLdpU=;
	b=ucsEjwFAYOrYRoJ7GRVx8yCm1LlZ02eTPQcczoBQmZE2jz3QVYdBG9QyfTVkOx94UItfzT
	y57GDSTHLu/NOgjkCog7068lgkH9NwbmaT8/zweTTeu8RlF68+0m4fU9HHZME7KS6ZlYTV
	kMFhy2HpE2xEjQhbRAfDdLQyQJBSUic=
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: oliver.sang@intel.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] mm: memcg: add cacheline padding after lruvec in mem_cgroup_per_node
Date: Tue, 23 Jul 2024 17:12:44 +0000
Message-ID: <20240723171244.747521-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Oliver Sand reported a performance regression caused by
commit 98c9daf5ae6b ("mm: memcg: guard memcg1-specific members of struct
mem_cgroup_per_node"), which puts some fields of the
mem_cgroup_per_node structure under the CONFIG_MEMCG_V1 config option.
Apparently it causes a false cache sharing between lruvec and
lru_zone_size members of the structure. Fix it by adding an explicit
padding after the lruvec member.

Even though the padding is not required with CONFIG_MEMCG_V1 set,
it seems like the introduced memory overhead is not significant
enough to warrant another divergence in the mem_cgroup_per_node
layout, so the padding is added unconditionally.

Fixes: 98c9daf5ae6b ("mm: memcg: guard memcg1-specific members of struct mem_cgroup_per_node")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202407121335.31a10cb6-oliver.sang@intel.com
Tested-by: Oliver Sang <oliver.sang@intel.com>
Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 7e2eb091049a..0e5bf25d324f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -109,6 +109,7 @@ struct mem_cgroup_per_node {
 
 	/* Fields which get updated often at the end. */
 	struct lruvec		lruvec;
+	CACHELINE_PADDING(_pad2_);
 	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
 	struct mem_cgroup_reclaim_iter	iter;
 };
-- 
2.45.2.1089.g2a221341d9-goog


