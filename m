Return-Path: <linux-kernel+bounces-228930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6A29168C9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5155A1F2313F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C5B15CD62;
	Tue, 25 Jun 2024 13:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Gf6u7xJJ"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9610158D92
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719321983; cv=none; b=sdRygFW/2CMekDDH1t4KlUWCJZXPxR8Keo94gvJi8Gu+xN/p5RyajCbVjgQ4Isj4LY2rhk9Wjqw//HWt47flo4wePIiIEm/e1+J8xlUIX7bJg6uNbP6TqcuUbAd7QbZj/2DmpypzQA17BgvgDr2bfxSofIU9rgPBr9bOqZgbyRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719321983; c=relaxed/simple;
	bh=tYQt4Y2QvAZKx4O9Yo/zsO0vApgfUJ1xi8heVdabSbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ueFWbLXw5o7bvVbeUfErF6r3dMdQupO2BEyFkziAVUenoFTFXXB3yCy3KqpZ1LnOj0rR0tYsU49TS9r1/WcIxBb9CQ0zhR1AUmlwz8pN6lRVHNgdutapiqXXEyM43zwLd/5CKQ+25TjnjC/IM4Vb0ROd/3wSPQnmRIiQMKNPEaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Gf6u7xJJ; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=S/y+Ebptg+FR+X/e86BAmbXdo6Ven/AYl1AyzE9QETw=; b=Gf6u7xJJnMS3FEBt0Lo/ATZmrA
	9hImBKOD12cISa/0UCwEfZBa+FDuXcj4NdeY6Hd75W2eor49G3XBzx9cmXTfSz6w1rjesiL6EPFQd
	6VmhXbJlA9UekcQtCp94cXsE1YmVt1Vo8Z6bfUqjrk2Q/V93a+ZF+BQbiwY7C32b28atl3nt1aRie
	k6kO6NpNsxbWDJdEdRnY29uILKaN2WJsoLkkhdPmXD3tMIByypW7qA/ibT+7q83/dO5zJRHQhTtIp
	exos9/n/EZr9KnQxKN5AqHXz597FWgUYJSNypt7wwzCj70U7afCoEsbuwRkkYNuzWd0akYKSv3Q7Z
	m2iK644g==;
Received: from [84.69.19.168] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sM6BZ-007Jbz-6w; Tue, 25 Jun 2024 15:26:13 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Huang Ying <ying.huang@intel.com>,
	Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Rik van Riel <riel@surriel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>
Subject: [PATCH] mm/numa_balancing: Teach mpol_to_str about the balancing mode
Date: Tue, 25 Jun 2024 14:26:05 +0100
Message-ID: <20240625132605.38428-1-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

If a task has had MPOL_F_NUMA_BALANCING set it is useful to show that in
procfs. Teach the mpol_to_str helper about its existance and while at it
update the comment to account for "weighted interleave" when suggesting
a recommended buffer size.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: bda420b98505 ("numa balancing: migrate on fault among multiple bound nodes")
Cc: Huang Ying <ying.huang@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: David Rientjes <rientjes@google.com>
---
 mm/mempolicy.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index aec756ae5637..d147287c4505 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3293,8 +3293,9 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
  * @pol:  pointer to mempolicy to be formatted
  *
  * Convert @pol into a string.  If @buffer is too short, truncate the string.
- * Recommend a @maxlen of at least 32 for the longest mode, "interleave", the
- * longest flag, "relative", and to display at least a few node ids.
+ * Recommend a @maxlen of at least 42 for the longest mode, "weighted
+ * interleave", the longest flag, "balancing", and to display at least a few
+ * node ids.
  */
 void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 {
@@ -3331,12 +3332,15 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 		p += snprintf(p, buffer + maxlen - p, "=");
 
 		/*
-		 * Currently, the only defined flags are mutually exclusive
+		 * The below two flags are mutually exclusive:
 		 */
 		if (flags & MPOL_F_STATIC_NODES)
 			p += snprintf(p, buffer + maxlen - p, "static");
 		else if (flags & MPOL_F_RELATIVE_NODES)
 			p += snprintf(p, buffer + maxlen - p, "relative");
+
+		if (flags & MPOL_F_NUMA_BALANCING)
+			p += snprintf(p, buffer + maxlen - p, "balancing");
 	}
 
 	if (!nodes_empty(nodes))
-- 
2.44.0


