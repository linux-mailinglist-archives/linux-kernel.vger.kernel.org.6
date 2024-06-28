Return-Path: <linux-kernel+bounces-234543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6651E91C7C1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4FD1F22642
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51218060A;
	Fri, 28 Jun 2024 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g2NtijnZ"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF5B7D41D
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719608637; cv=none; b=UcWY2qfWSqd3CVfFn2Na08rnER24be4KINlWKkegiJmCe1+xz3a/Fi33V0WTQjPwo1Azyve4uKt/IyHhM/S/E/pSCFdM7XVIIzX93tDIIY8g+Y2Z15AlZOFJi2HGeuhoAB0D41u1bVcY2l6DtZkZzZVGBS5HM1JhSeYIJfYC0nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719608637; c=relaxed/simple;
	bh=qAel/5uzHhySWPyoYquHu1/Vl0xHr4lbbu8rGUyOea4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4QMXPUEHykQJfeKXBNzOrZz3qyLMV3drZAvvM8iI6sVmVR4pi8wCZbfa/sIKinSYVhYxpIiiINuV4xV5/j0xI/Hss3dRuZJLhvlinVJAeWaswgrd4+l78tfq6a4kOI9rgM1TRcunfZXP5d12qIRiux1xOfMv/xHoNOm3w6bMtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g2NtijnZ; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719608633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPtP5N5DyF6jTL5Hfe6ZNpWs5ObKbQpWVZsP63+oajo=;
	b=g2NtijnZEqgSMhtqKQKM5yPBi+tG0SpRLqJ+5RYIwuiLLTSg1j+c8yL4PEB+DPR8uQ88lD
	yvfYsoa9kK4zLjnW9p0ZQCAJlr333gFyf6FEdei0K7YOoa7NF/B9RIZfx9vW9RJ9IrNcqN
	3uYerGLOAvi0tAsd+SuVTh/1zamik4U=
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
Subject: [PATCH v1 3/9] mm: memcg: guard cgroup v1-specific code in mem_cgroup_print_oom_meminfo()
Date: Fri, 28 Jun 2024 21:03:11 +0000
Message-ID: <20240628210317.272856-4-roman.gushchin@linux.dev>
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

Put cgroup v1-specific code in mem_cgroup_print_oom_meminfo() under
CONFIG_MEMCG_V1.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/memcontrol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2c0605bbbb31..b69abd327549 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1532,6 +1532,7 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 		pr_info("swap: usage %llukB, limit %llukB, failcnt %lu\n",
 			K((u64)page_counter_read(&memcg->swap)),
 			K((u64)READ_ONCE(memcg->swap.max)), memcg->swap.failcnt);
+#ifdef CONFIG_MEMCG_V1
 	else {
 		pr_info("memory+swap: usage %llukB, limit %llukB, failcnt %lu\n",
 			K((u64)page_counter_read(&memcg->memsw)),
@@ -1540,6 +1541,7 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 			K((u64)page_counter_read(&memcg->kmem)),
 			K((u64)memcg->kmem.max), memcg->kmem.failcnt);
 	}
+#endif
 
 	pr_info("Memory cgroup stats for ");
 	pr_cont_cgroup_path(memcg->css.cgroup);
-- 
2.45.2.803.g4e1b14247a-goog


