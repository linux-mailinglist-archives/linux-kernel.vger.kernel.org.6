Return-Path: <linux-kernel+bounces-220253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 275FC90DE7D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35CD51C208FB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C067F176FAC;
	Tue, 18 Jun 2024 21:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l+gW5eaS"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C57013DDD2
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 21:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718746489; cv=none; b=qgjFWHggOyoD5v2jCamiUWzLYIRjr9YnidIepxDxb65uH+EmjT+iQcyKgpZkLkGY2ExP+ppeUa2obRNS5B5kHfXIkz5A/OSAnhtfzZ73P57RRYtm5jS23QUotl1bSs1MUlU8yxhcaE7c50dVWQE42PiaoioxHnLEcxGxRx8DtNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718746489; c=relaxed/simple;
	bh=aCMu+PMfiwJEa9jVW44po1uqrhhhuusBhEOb4kSCNb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fzd1gDGpw3jVdZo0a7/j37GyLg5OdG5W+44xhdvh4e8siuhsubY8qAkx6Kvvq4+iybOtWJeaZHsY/e3SMY4Mb/CPaN6XePV3oNHNqTnetUh4TKw4aprFdV5xJyFRI+4FplxY7VCv7Inv8x0Dv1MHEMHTcHlbAdjd39nym4BMH5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l+gW5eaS; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718746484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uCcgPhMT9v27bOz9O3+n1SaaJwS+iEnfXv26dRb41IU=;
	b=l+gW5eaSmKpsFqkM+8k3godaPJNaYfHtWPYvol12kbqM3FF1A/bsxydW9jA6tpASWGg3eT
	9kn5eZKLHFLEDpPHMQZzfE6aS55s/SS/suUNa5lqwAinKpuzc+zEx+r/16oYaOXVfiZPcn
	me3P3x9MStpUft3FdisWgWEjj7hAQrs=
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: torvalds@linux-foundation.org
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: kyle@infradead.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	kernel-team@meta.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kyle McMartin <kyle@infradead.org>
Subject: [PATCH] mm: ratelimit oversized kvmalloc warnings instead of once
Date: Tue, 18 Jun 2024 14:34:21 -0700
Message-ID: <20240618213421.282381-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

At the moment oversize kvmalloc warnings are triggered once using
WARN_ON_ONCE() macro. One issue with this approach is that it only
detects the first abuser and then ignores the remaining abusers which
complicates detecting all such abusers in a timely manner. The situation
becomes worse when the repro has low probability and requires production
traffic and thus require large set of machines to find such abusers. In
Mera production, this warn once is slowing down the detection of these
abusers. Simply replace WARN_ON_ONCE with WARN_RATELIMIT.

Reported-by: Kyle McMartin <kyle@infradead.org>
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/util.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index 10f215985fe5..de36344e8d53 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -649,7 +649,8 @@ void *kvmalloc_node_noprof(size_t size, gfp_t flags, int node)
 
 	/* Don't even allow crazy sizes */
 	if (unlikely(size > INT_MAX)) {
-		WARN_ON_ONCE(!(flags & __GFP_NOWARN));
+		WARN_RATELIMIT(!(flags & __GFP_NOWARN), "size = %zu > INT_MAX",
+			       size);
 		return NULL;
 	}
 
-- 
2.43.0


