Return-Path: <linux-kernel+bounces-236877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BEB91E80F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAD0D1C21D43
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B2816F27D;
	Mon,  1 Jul 2024 18:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g+aCSeNT"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F212A16F0E0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 18:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719860386; cv=none; b=fY/zYDuOEe4ZHHHFG57OI+FlgOy/CMoyGJNbvu9euq+opFGtO7uuYfvhkeeqDcMN2fKe1HkCpKVZZ/ox3FOMZSiSlZATK7tmYKNATZfztpPMio4mg800LLa7fT5kdWmiuVHGrv4mBBpGaLp5UmOcDPS90bjQQ3tzijc8iioAZO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719860386; c=relaxed/simple;
	bh=GWNwjc5aspj1NrlHjJVs2xAQRtbM7J5giAv9cyFePwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dmlkoD3RyRcELRRElABQz1ZGOEx3YO52zWkJG8GIw/qMHopXtOrq6HeCm63CQSkOnyj4lvkYX9W0+aZbJg85nf8jNAURshfqD9OC/Wk/YuIfViUgRAdBhK7GGrfsRis4G+5G9q8l9gTTYf4bJDIyzOxoNI+jcfaQY972oeDtnz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g+aCSeNT; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719860382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=smDq7+iTT1okj9ZvP29aA6Rct11y7oIiaW2hKTFwcKY=;
	b=g+aCSeNThkUPOWTRUWoDOHDKYJhEIhoT1Modh/ERdIQOOU0GCpxLwtpkhZQxAPcacR/vcr
	cAS/UU3mdgkpx00ba7FYHoelHULHQNTkc7cbhZQqhqmiBrTHofMpawis0RaUIKHdejQvX8
	t8d2nrLzCnVUgVTY1u0SNyn3RSRC2Ow=
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: roman.gushchin@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH 2/2] mm: memcg: add cache line padding to mem_cgroup_per_node
Date: Mon,  1 Jul 2024 18:59:32 +0000
Message-ID: <20240701185932.704807-2-roman.gushchin@linux.dev>
In-Reply-To: <20240701185932.704807-1-roman.gushchin@linux.dev>
References: <20240701185932.704807-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Memcg v1-specific fields serve a buffer function between read-mostly
and update often parts of the mem_cgroup_per_node structure.
If CONFIG_MEMCG_V1 is not set and these fields are not present,
an explicit cacheline padding is needed.

Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 8b5b3ddeba05..60418934827c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -95,14 +95,16 @@ struct mem_cgroup_per_node {
 #ifdef CONFIG_MEMCG_V1
 	/*
 	 * Memcg-v1 only stuff in middle as buffer between read mostly fields
-	 * and update often fields to avoid false sharing. Once v1 stuff is
-	 * moved in a separate struct, an explicit padding is needed.
+	 * and update often fields to avoid false sharing. If v1 stuff is
+	 * not present, an explicit padding is needed.
 	 */
 
 	struct rb_node		tree_node;	/* RB tree node */
 	unsigned long		usage_in_excess;/* Set to the value by which */
 						/* the soft limit is exceeded*/
 	bool			on_tree;
+#else
+	CACHELINE_PADDING(_pad1_);
 #endif
 
 	/* Fields which get updated often at the end. */
-- 
2.45.2.803.g4e1b14247a-goog


