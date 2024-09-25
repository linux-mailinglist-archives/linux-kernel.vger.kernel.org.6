Return-Path: <linux-kernel+bounces-339370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30099986400
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39691F276EA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F5017C6C;
	Wed, 25 Sep 2024 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NmV/OSdk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A1417BB4
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727279043; cv=none; b=d92Q+aSqAH8ue5Esi5PkNDSnNKE39zLDoZ31h/GfNu33jigee3rQpY0byrGu4cO8maMdWLSHwhX6D8lJysM4dQwUQWkU4U/kKEMnrmwEazUd27b9SIWF8DYeR5vFKDJKhGnrR3NW85NL1wt5YPrnT+AGpxhX4wRk2iNOPPIqzYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727279043; c=relaxed/simple;
	bh=rFOs3yP2cOBTsiJkJ/FO03Pb+M8BQkMQ2nUOI+pby7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpgQkuSFK5+B+J1c/3Rdx76ESCKwMrmT34Awk6gOcjxn0HhSXRunoOB2YNPWUfI+9lS5jv05nQZ3vOONWp2nvs3kYYB678UMAh11VJjnChRT4XLCwOUhe2bvxey6jPQmvmqtSKcfUWL2fwnAxFrUwEjMARqBPoQTvDswAc/TZkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NmV/OSdk; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727279041; x=1758815041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rFOs3yP2cOBTsiJkJ/FO03Pb+M8BQkMQ2nUOI+pby7U=;
  b=NmV/OSdkKFud3CN5StAZvpHwMxEENnYSu5DvBRMXuwxE70vuZHbEJAfs
   Biu/1IzKLg1TpPx3ngT95+LgU7jSa8z6JxR+5cVP91NltVNO+7PdRf+oI
   CyBA5JZbjnUJGi5PLPU03NPd8TvVA/1CCuk7A3gAiKwyxavwmAZfdj0jd
   bMzQTQO4fqh6UWh9BFNJvRnIIsjMrLQYTFCYsjFbyRNbigmCtCEIT53wa
   T1xSyIVoc5KMUe1N4gD58dgbxa49e8crnGItN15js31JT3tJf0ed456pn
   e0YVbvXF+ceZC7PNXFvF7bvwePBf7drj6D/sTZfIcqROsOdPs0Mw4ral5
   Q==;
X-CSE-ConnectionGUID: dqLp00SyQSeRzFsh+ko3qA==
X-CSE-MsgGUID: 9AviA2Q3QO2jQcO4FpFryQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26488841"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="26488841"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 08:44:01 -0700
X-CSE-ConnectionGUID: RF04esb5SQC8ADsxB+gErw==
X-CSE-MsgGUID: g19OvBGlToOYx5eZZ0QyFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="76748836"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 25 Sep 2024 08:43:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 42C7315C; Wed, 25 Sep 2024 18:43:58 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] resource: Replace open coded resource_intersection()
Date: Wed, 25 Sep 2024 18:43:34 +0300
Message-ID: <20240925154355.1170859-2-andriy.shevchenko@linux.intel.com>
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

The __region_intersects() uses open coded resource_intersection().
Replace it with existing API which also make more clear what we
are checking.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/resource.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index b730bd28b422..6880c0e283dd 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -539,17 +539,16 @@ static int __region_intersects(struct resource *parent, resource_size_t start,
 			       size_t size, unsigned long flags,
 			       unsigned long desc)
 {
-	resource_size_t ostart, oend;
 	int type = 0; int other = 0;
 	struct resource *p, *dp;
+	struct resource res, o;
 	bool is_type, covered;
-	struct resource res;
 
 	res.start = start;
 	res.end = start + size - 1;
 
 	for (p = parent->child; p ; p = p->sibling) {
-		if (!resource_overlaps(p, &res))
+		if (!resource_intersection(p, &res, &o))
 			continue;
 		is_type = (p->flags & flags) == flags &&
 			(desc == IORES_DESC_NONE || desc == p->desc);
@@ -570,8 +569,6 @@ static int __region_intersects(struct resource *parent, resource_size_t start,
 		 * |-- "System RAM" --||-- "CXL Window 0a" --|
 		 */
 		covered = false;
-		ostart = max(res.start, p->start);
-		oend = min(res.end, p->end);
 		for_each_resource(p, dp, false) {
 			if (!resource_overlaps(dp, &res))
 				continue;
@@ -580,17 +577,17 @@ static int __region_intersects(struct resource *parent, resource_size_t start,
 			if (is_type) {
 				type++;
 				/*
-				 * Range from 'ostart' to 'dp->start'
+				 * Range from 'o.start' to 'dp->start'
 				 * isn't covered by matched resource.
 				 */
-				if (dp->start > ostart)
+				if (dp->start > o.start)
 					break;
-				if (dp->end >= oend) {
+				if (dp->end >= o.end) {
 					covered = true;
 					break;
 				}
 				/* Remove covered range */
-				ostart = max(ostart, dp->end + 1);
+				o.start = max(o.start, dp->end + 1);
 			}
 		}
 		if (!covered)
-- 
2.43.0.rc1.1336.g36b5255a03ac


