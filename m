Return-Path: <linux-kernel+bounces-342320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DEC988D8B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 04:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B19282505
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 02:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01B815AD90;
	Sat, 28 Sep 2024 02:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OectKrhh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64F26F30C
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 02:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727489791; cv=none; b=YXtBYI0bM8iSsCaM/fjH6pTGpNPfWg73ZqL2zluf/ljr7KrCFlr8LUiSOkM714THZ2WIgr2bGNb4Q/Cr7qWzmOk5h+osfiq/2xGx8mALw8Wgs9MlumA5ucyIkfE99TyESyIi2QvhksYsJZlbK1TH1v7rJt86hPoTX3aV+7ufZC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727489791; c=relaxed/simple;
	bh=jeCu3iqu/2EXy9IfjtlKEtm4q6TnkB4czmIDU7q2LAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nq55BZ4RKskcWxZhRu17OFaCjJqFegd4bKZE06AFSn7dXZlQWjkQjR82z95dlgHWCi9p9wpQsXnzx0856XcdBRuFHF+NVbuSTd82gZhOd7L4Oe9jc68x4CIb6ZY6O1rzwRgOI56Vc4Di34KJ3Gnb6sYwb1Nnf4GV3AqNObGvczA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OectKrhh; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727489789; x=1759025789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jeCu3iqu/2EXy9IfjtlKEtm4q6TnkB4czmIDU7q2LAY=;
  b=OectKrhhRg2WkVuZe+l7FNj5RNL8WnT0uDFwSYZm5CB09PoWnMA55UB9
   ph0PwZ45Q3qaqFLYMhGdsrIvY38h47bUEAgQU0Cg023O7CJIkjcC8qq8m
   vBIVUg5AUgBSAy4WzmpECgzPh68jSCIjNOowCZQ6Yl3I2YNX591EHmySf
   bu+a9sPix6xKExXwM92L6/xaZTNSx3eE1tQX1HGOB/sWratFEfa7zRhWX
   K5WNphOc8AETR+OjP/K8F6BfChXLs2JH+qxMGffdZL2/TVXsfQpWt4OjN
   uMF3qggHLKWUx9l1jUrVEadSPssC5WFT0HiCWJtVRx1AKj8jrQiqn3OJx
   Q==;
X-CSE-ConnectionGUID: WpFbIHHWTkqjEoFx90ctZA==
X-CSE-MsgGUID: k/PlLgqyRK6ucLhlYNeoKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11208"; a="29526918"
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="29526918"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 19:16:21 -0700
X-CSE-ConnectionGUID: cRQ5tnNWR5CUGZgxe6qXrg==
X-CSE-MsgGUID: qgNMbP/jRMKqlKVlPbychw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="73507136"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa008.jf.intel.com with ESMTP; 27 Sep 2024 19:16:22 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	shakeel.butt@linux.dev,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org
Cc: nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v8 8/8] mm: Document the newly added sysfs large folios zswpout stats.
Date: Fri, 27 Sep 2024 19:16:20 -0700
Message-Id: <20240928021620.8369-9-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added documentation for the newly added sysfs per-order hugepage
"zswpout" stats.

Clarified that only non-zswap swapouts will be accounted in the existing
"swpout" stats.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index cfdd16a52e39..2a171ed5206e 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -530,10 +530,14 @@ anon_fault_fallback_charge
 	instead falls back to using huge pages with lower orders or
 	small pages even though the allocation was successful.
 
-swpout
-	is incremented every time a huge page is swapped out in one
+zswpout
+	is incremented every time a huge page is swapped out to zswap in one
 	piece without splitting.
 
+swpout
+	is incremented every time a huge page is swapped out to a non-zswap
+	swap device in one piece without splitting.
+
 swpout_fallback
 	is incremented if a huge page has to be split before swapout.
 	Usually because failed to allocate some continuous swap space
-- 
2.27.0


