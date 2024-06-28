Return-Path: <linux-kernel+bounces-234547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8505D91C7C5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BF84B28795
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D797D07F;
	Fri, 28 Jun 2024 21:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ed+Zv3p6"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745FA81ADB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719608645; cv=none; b=DnNxhvhCuYdB7GfXr8F8qxcQ/kpvqA6mLnzjXAVW0JPPrQGs204RQPNZbNYnD0YmjubYsCQiJ1eAwubLEDxVq9a2TOvh7chqsv5x6FjmCycaSP6LrSJb4e6WQq8A5ybFn3Hqui0ZjS/HSc5weyJggLLVWLfSwP8ymtO7gxOaDyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719608645; c=relaxed/simple;
	bh=FqgYTcap62Eyj937oxKOCY33JrWSzlWusAUAniSkWp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHoOHPHoMQ/JX47aAzxg32QfL1JmkIc6ufQEyaS9UBLakouUvCmc6iLg5+0z1agHlJOP9nbMHf+z5/MV1mrXQxgVNUeItdJ94sOwJ84mffIsUmaPPKbaA6kPXYB0YfGcPhidNILPFA9qtacFWYgUNuqSZX2Y8mh/4LikWVBnQD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ed+Zv3p6; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719608640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7SlGJox9o6WayxiPYLup7HEpqh8S+qxFa/JeE0i8vpE=;
	b=Ed+Zv3p6n3UBjF4sV/5LuICPBPcAFb8qH5jp86026JaxfP594YrwBi2dcypRMGgQFg8Mu+
	c27SEgkKYtawry059CYJABt50s2pFEjK5BW0m5whL6fa2rAn7uDZBhJ2lbl6T+/4052ttj
	zSrycuARVaEHJzpFWNaLgkje4URL5+c=
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: roman.gushchin@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v1 7/9] mm: memcg: guard memcg1-specific members of struct mem_cgroup_per_node
Date: Fri, 28 Jun 2024 21:03:15 +0000
Message-ID: <20240628210317.272856-8-roman.gushchin@linux.dev>
In-Reply-To: <20240628210317.272856-1-roman.gushchin@linux.dev>
References: <20240628210317.272856-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Put memcg1-specific members of struct mem_cgroup_per_node under the
CONFIG_MEMCG_V1 config option.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 107b0c5d6eab..c7ef628ee882 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -92,6 +92,7 @@ struct mem_cgroup_per_node {
 	struct lruvec_stats			*lruvec_stats;
 	struct shrinker_info __rcu	*shrinker_info;
 
+#ifdef CONFIG_MEMCG_V1
 	/*
 	 * Memcg-v1 only stuff in middle as buffer between read mostly fields
 	 * and update often fields to avoid false sharing. Once v1 stuff is
@@ -102,6 +103,7 @@ struct mem_cgroup_per_node {
 	unsigned long		usage_in_excess;/* Set to the value by which */
 						/* the soft limit is exceeded*/
 	bool			on_tree;
+#endif
 
 	/* Fields which get updated often at the end. */
 	struct lruvec		lruvec;
-- 
2.45.2.803.g4e1b14247a-goog


