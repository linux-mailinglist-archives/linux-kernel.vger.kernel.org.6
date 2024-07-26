Return-Path: <linux-kernel+bounces-263730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B34A93D9CC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 047E928311F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89C6149E16;
	Fri, 26 Jul 2024 20:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HOVj/DdQ"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4468148FFA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 20:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722025889; cv=none; b=HRiueB7HZsCiME7goWZiMyDnV5M2UctN9kZwaG3Xo207hJnTHTC9BSSAFOb+8H508AAB1nGLiEX5rBeP19vTGfcdCiYT6enatqAlNM5OWk/n9iyoy4Hm4pEnwU1l9QicO99km80jAzk/WT94r3EQCH4ENXilpniWGCF+p7VGs48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722025889; c=relaxed/simple;
	bh=GMzsDWYq/siYUe/XKQRxMz60p5UaafH6mFYbqgn6628=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIUh18ySdzICGEVP+kXZAKyQpg2DNnpcu9dquvrBiGmC8h+AwM7lrE1nTkpZ+1vfpm20NcBhEQWxwEMEB3dPJmbeioRCs7yGRMLX2G3Sx5T1hWwuFuRSo6Lo693hjRx4dN35eyVl959tSIQqiJUnHgbsiC01GwWE8V1mrIu1YwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HOVj/DdQ; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722025885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WSTjdbMjvEiF4hi3WOb+1xaRPO7PBio6gS846AF8ehU=;
	b=HOVj/DdQ+WS4c97tS0eRWs7o/fqICrcdjwReWyZXjlwMaJXWEM32CXoiMRuxXaeKL+ADXC
	L5METOeKuURrgb1mI9sRAswTgjti1SywOP+Urfdyz4KM/ot+4xrki+OdnJSKJ7YO2yPMgW
	eftStYwv9OrYPBblThhZXyEejHBA7cw=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v3 2/3] mm: page_counters: put page_counter_calculate_protection() under CONFIG_MEMCG
Date: Fri, 26 Jul 2024 20:31:09 +0000
Message-ID: <20240726203110.1577216-3-roman.gushchin@linux.dev>
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

Put page_counter_calculate_protection() under CONFIG_MEMCG.

The protection functionality (min/low limits) is not supported by any
other cgroup subsystem, so page_counter_calculate_protection() and
related static effective_protection() can be compiled out if
CONFIG_MEMCG is not enabled.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/page_counter.h | 6 ++++++
 mm/page_counter.c            | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index aadd42f5ab7b..cf837d0f8ed1 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -95,8 +95,14 @@ static inline void page_counter_reset_watermark(struct page_counter *counter)
 	counter->watermark = usage;
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


