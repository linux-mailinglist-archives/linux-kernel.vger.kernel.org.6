Return-Path: <linux-kernel+bounces-261495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C88893B7F3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4B31C2148E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1747516D4C1;
	Wed, 24 Jul 2024 20:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CaspnUm7"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC8F16F0C3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721852483; cv=none; b=ULX7IxWjkhhoH94rlfxNPdn96Vu4aqYFZSbBDNzvAg19Ye7mTWnvRCv2+2AU8taWbYhJpW/gkRZgCUzhZsrDdGKgsa3kytgneBuc60c0by36UhQBrzDxSoPLk52k1/SHraOwigBBCFl89ffW1qNX+wFRGIE6eWdmqgQwrmoQ1K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721852483; c=relaxed/simple;
	bh=Rv3iaURf950gJ7T2uD+VmJZAb64KZo0fSUZTtAq2nn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5k5m2bahAetMZ2enx9QDEHAJcqDEC1ESuxfnAPlC8UJdNbYDDU2RD5OJ9Z+eeeairmnNns+UWAJ0oC4SblJZFat1q4G5RQLMMtRAKn7z/3IaS/MJsq9gRB8Y7mzmU14LKUP8YG2sv7/Sn1ilG94vVqdXzwRt1q+3GH2Jzj4KYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CaspnUm7; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721852479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ox/nuFAuZgruc6XJ+rhxVAoq5JDC1MSgTKgd+A57sfY=;
	b=CaspnUm7bqY8Cjk8c/ux144Bt4fYLCd41UyWZi7sAowFl+0d9E4eQqZiql4QiFzGCuXPmw
	xFaabCNGMpNcAZ66AtgYb4KS/8woN4ZpzrqNfS+g98tE0HgVctnYqVOdiXsXOk7a6TqGqR
	Fkv8B27X337kVEMdE4iBHQrJgUzUgp8=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 4/5] mm: page_counters: initialize usage using ATOMIC_LONG_INIT() macro
Date: Wed, 24 Jul 2024 20:21:02 +0000
Message-ID: <20240724202103.1210065-5-roman.gushchin@linux.dev>
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

When a page_counter structure is initialized, there is no need to
use an atomic set operation to initialize usage counters because at
this point the structure is not visible to anybody else.
ATOMIC_LONG_INIT() is what should be used in such cases.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/page_counter.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index 701e1255c456..ee740ed8cb90 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -114,7 +114,7 @@ static inline void page_counter_init(struct page_counter *counter,
 	unsigned long i;
 
 	for (i = 0; i < MCT_NR_ITEMS; i++) {
-		atomic_long_set(&counter->usage[i], 0);
+		counter->usage[i] = (atomic_long_t)ATOMIC_LONG_INIT(0);
 		counter->max[i] = PAGE_COUNTER_MAX;
 	}
 	counter->parent = parent;
-- 
2.46.0.rc1.232.g9752f9e123-goog


