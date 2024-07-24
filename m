Return-Path: <linux-kernel+bounces-261494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CDB93B7F2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74018280C4F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1C916E887;
	Wed, 24 Jul 2024 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T4pLX8wN"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A0116D4D5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721852479; cv=none; b=NtHMhqblKfI/bstrDdczDhdhrIVrpTUaUmISXnX6RWqemTwklvUV4fEEWfFlFfF25c1yRYyLA0ptSmq4ZSVzqHqVGmyHo3/P/JnGBVJv6/ATaX1xyuKWPE3ULiqCpi022nydUl+Ifr9AJ9U67SqrojCe0bO/XdhzUj9/YIWjDY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721852479; c=relaxed/simple;
	bh=C2dOML3uDveQIuLFcor84G87VpUkDHIfUwNdxdfiqpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gb1GSZfkMFPnsPg/d9SmsUngEzmVjL/mPL8vFtgvRHvR31i3hzf2ZZOzBUriB0gwu7qOJzF7sbMPD5dmVt+ciiP9gA1uvEa7W20fPZbP2OZ+sQIQQX5/pa6yjQcpocfr/XRVZDRAxsm15jtOs+f7OcIXqDQuz62knqGDqjqJysE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T4pLX8wN; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721852475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lYZidUGk8Ov2rzxeyGytgB3mibsabUB7JDKLCQIcDhM=;
	b=T4pLX8wNIKFmF53zTNuwU/H5E2+h8nH7GHs80XJpR/tkYgGQ9BpQw3b0N76p3VmP4HzeF1
	Od8siMmfRV+Q2jRv3r8YdSVxtJW1KHydUAOZcyQ4c0w2A4a821Q7OaBO6sm0BIoT1hVKV5
	oYYJvY32MTZK4U4DP4Ozv2hK5835KJ4=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 2/5] mm: page_counters: put page_counter_calculate_protection() under CONFIG_MEMCG
Date: Wed, 24 Jul 2024 20:21:00 +0000
Message-ID: <20240724202103.1210065-3-roman.gushchin@linux.dev>
In-Reply-To: <20240724202103.1210065-1-roman.gushchin@linux.dev>
References: <20240724202103.1210065-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Put page_counter_calculate_protection() under CONFIG_MEMCG.

The protection functionality (min/low limits) is not supported by any
other cgroup subsystem, so page_counter_calculate_protection() and
related static effective_protection() can be compiled out if
CONFIG_MEMCG is not enabled.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/page_counter.h | 6 ++++++
 mm/page_counter.c            | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index b31fd5b208aa..d85fc7df3280 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -91,8 +91,14 @@ static inline void page_counter_reset_watermark(struct page_counter *counter)
 	counter->local_watermark = usage;
 }
 
+#ifdef CONFIG_MEMCG
 void page_counter_calculate_protection(struct page_counter *root,
 				       struct page_counter *counter,
 				       bool recursive_protection);
+#else
+static inline void page_counter_calculate_protection(struct page_counter *root,
+						     struct page_counter *counter,
+						     bool recursive_protection) {}
+#endif
 
 #endif /* _LINUX_PAGE_COUNTER_H */
diff --git a/mm/page_counter.c b/mm/page_counter.c
index a54382a58ace..b249d15af9dd 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -288,6 +288,7 @@ int page_counter_memparse(const char *buf, const char *max,
 }
 
 
+#ifdef CONFIG_MEMCG
 /*
  * This function calculates an individual page counter's effective
  * protection which is derived from its own memory.min/low, its
@@ -459,3 +460,4 @@ void page_counter_calculate_protection(struct page_counter *root,
 			atomic_long_read(&parent->children_low_usage),
 			recursive_protection));
 }
+#endif /* CONFIG_MEMCG */
-- 
2.46.0.rc1.232.g9752f9e123-goog


