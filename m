Return-Path: <linux-kernel+bounces-339371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E568986401
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7241C27BB0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F80219E0;
	Wed, 25 Sep 2024 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EXWy5Vr2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF9A1D5AD7
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727279044; cv=none; b=HovXEmm6D79Zbt26n5ga59PPN9XQcCIAptka9axZ3vPKSYGN+VzE3MQMmmEWkkMMUiz4AtYU6qqahonYjRRQprIyPAy0f7OyprTKSFFHhkcD+KWTYFsfRXdkwtAZ6b7x4Je6tXvMWcFaT4IuqJywIKjkDkRoSHhemsNGz5e9yrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727279044; c=relaxed/simple;
	bh=MWXGrbZKhplb8b5pdAR8zTppw4TNyfFnSpLm65mxNg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXa+6pVlvoGLe6oa7trlz1RitobvJYyP+qTkUn01PBRD8ILkMMaQc23lgvTXvuHTZEQEnGq1Jstvy4a1Ec/cjbSDtucTATPC5NWVAo587mbiDakfrm4nB0cYo4mkOsdAyk+wdhnSIEsTNGltTBuIetpyuJC1hzmbt4B3OCeS7mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EXWy5Vr2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727279043; x=1758815043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MWXGrbZKhplb8b5pdAR8zTppw4TNyfFnSpLm65mxNg8=;
  b=EXWy5Vr25AF34kCJbthg5/oFeLd8OcAOQfUvEaa7MzyKcEDz1kXxn2Ft
   xlk5GeF79OilCf7g234A+O5oECtTi+qkR/MJxzPRZZRmsRqQBiTtNh2sV
   ByTTvGzY0cjXhCqG9hpTvAK5m5ivPXJcKthdUO9ZVyk8yC11sSdPXySdL
   C2Xn6RE3NWbqbi1iGQP7an2lUY07ork6UAOuX/gHR+wf4/Y9U4naOmzFh
   yKTHUAISaSSTn4mJyHV0aOVbao8qN4XikQwLhEYrY3dVf3HYozGc8jZi8
   cJ3aghskfhw5OvkMYCKX5fT5AMDsASBQAxJG4zUIuP13DtY8P/k47BUQj
   w==;
X-CSE-ConnectionGUID: 6jAZviWHRS6tuyGeY5j2zw==
X-CSE-MsgGUID: RCpq5zMeQnWS+ijCkPaRzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="51752543"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="51752543"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 08:44:01 -0700
X-CSE-ConnectionGUID: OpeOVUwgQUCWEHsaGrBRZA==
X-CSE-MsgGUID: WUgH7Bn0R0SKdoldUzzWAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="71411835"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 25 Sep 2024 08:43:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4BE23565; Wed, 25 Sep 2024 18:43:58 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] resource: Introduce is_type_match() helper and use it
Date: Wed, 25 Sep 2024 18:43:35 +0300
Message-ID: <20240925154355.1170859-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240925154355.1170859-1-andriy.shevchenko@linux.intel.com>
References: <20240925154355.1170859-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are already a couple of places where we may replace
a few lines of code by calling a helper, which increases
readability while deduplicating the code.

Introduce is_type_match() helper and use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/resource.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 6880c0e283dd..2d266b5ff881 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -297,6 +297,11 @@ int release_resource(struct resource *old)
 
 EXPORT_SYMBOL(release_resource);
 
+static bool is_type_match(struct resource *p, unsigned long flags, unsigned long desc)
+{
+	return (p->flags & flags) == flags && (desc == IORES_DESC_NONE || desc == p->desc);
+}
+
 /**
  * find_next_iomem_res - Finds the lowest iomem resource that covers part of
  *			 [@start..@end].
@@ -339,13 +344,9 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 		if (p->end < start)
 			continue;
 
-		if ((p->flags & flags) != flags)
-			continue;
-		if ((desc != IORES_DESC_NONE) && (desc != p->desc))
-			continue;
-
 		/* Found a match, break */
-		break;
+		if (is_type_match(p, flags, desc))
+			break;
 	}
 
 	if (p) {
@@ -542,7 +543,7 @@ static int __region_intersects(struct resource *parent, resource_size_t start,
 	int type = 0; int other = 0;
 	struct resource *p, *dp;
 	struct resource res, o;
-	bool is_type, covered;
+	bool covered;
 
 	res.start = start;
 	res.end = start + size - 1;
@@ -550,9 +551,7 @@ static int __region_intersects(struct resource *parent, resource_size_t start,
 	for (p = parent->child; p ; p = p->sibling) {
 		if (!resource_intersection(p, &res, &o))
 			continue;
-		is_type = (p->flags & flags) == flags &&
-			(desc == IORES_DESC_NONE || desc == p->desc);
-		if (is_type) {
+		if (is_type_match(p, flags, desc)) {
 			type++;
 			continue;
 		}
@@ -572,9 +571,7 @@ static int __region_intersects(struct resource *parent, resource_size_t start,
 		for_each_resource(p, dp, false) {
 			if (!resource_overlaps(dp, &res))
 				continue;
-			is_type = (dp->flags & flags) == flags &&
-				(desc == IORES_DESC_NONE || desc == dp->desc);
-			if (is_type) {
+			if (is_type_match(dp, flags, desc)) {
 				type++;
 				/*
 				 * Range from 'o.start' to 'dp->start'
-- 
2.43.0.rc1.1336.g36b5255a03ac


