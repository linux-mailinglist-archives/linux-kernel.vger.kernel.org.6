Return-Path: <linux-kernel+bounces-234548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EE291C7C6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5301F22FCC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA6381ADB;
	Fri, 28 Jun 2024 21:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AxQxHOwo"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6902281ADA
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719608648; cv=none; b=Wskzovp1xnvpWapCitBPlbgIqbitV3PuuPNTQjMXVYDCHtnl4rpuL+es6aVuoYbLwvJzMemjb4G23IIAatY8gBWc4ZwxZmCp5Tu4HQCYrFaeiL32p4FmOppLp2h9XLgMCoRDgTpMO6ZEAttDT9yrSILWtWyhus4AkuJzUXa5VO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719608648; c=relaxed/simple;
	bh=+NjtEVhK/XppQDDbfg9LoUFoaYaRw4Occb0lMcT8QP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ordKVBZvwGKXwV4T8KTkJngjI30w0h7qkc0WCKKQFLxzRfMCkcW6OT7bEA4URkHwc63/SjF5mwj1WxK+X4KQemnFFup9T0Pg5O1eD7qVF9FKzn6KBILGEpECvVmBhCnG2brKRk5xrWKCqJEzJ4Xor6WzsuQE8AVF9ITsuPAaCOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AxQxHOwo; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719608642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=shh94uljBJBAw0NmdKQ5/8JVCufhJ/PY7mLMRWfBY9w=;
	b=AxQxHOwohJvObzrg/JOuI9tKWrY6KLKGsGTTTeEwGVNcVD4DZmeJulWmaac1Kf9yRId4z0
	4XilmuxIQnejQP1MwwDkF3W66UDLjc+GL8hRoRpgS0BbSZkbvujnqJRtXQx4N+4rj0jb50
	rWGud2F7XVsBx5xOBoECY2lou0HhDuo=
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
Subject: [PATCH v1 8/9] mm: memcg: put struct task_struct::memcg_in_oom under CONFIG_MEMCG_V1
Date: Fri, 28 Jun 2024 21:03:16 +0000
Message-ID: <20240628210317.272856-9-roman.gushchin@linux.dev>
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

The memcg_in_oom field of the struct task_struct is not used by
the cgroup v2's memory controller, so it can be happily compiled out
if CONFIG_MEMCG_V1 is not set.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/sched.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 61591ac6eab6..2a16023e8620 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1447,9 +1447,11 @@ struct task_struct {
 	unsigned int			kcov_softirq;
 #endif
 
-#ifdef CONFIG_MEMCG
+#ifdef CONFIG_MEMCG_V1
 	struct mem_cgroup		*memcg_in_oom;
+#endif
 
+#ifdef CONFIG_MEMCG
 	/* Number of pages to reclaim on returning to userland: */
 	unsigned int			memcg_nr_pages_over_high;
 
-- 
2.45.2.803.g4e1b14247a-goog


