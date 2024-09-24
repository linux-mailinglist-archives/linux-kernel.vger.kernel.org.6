Return-Path: <linux-kernel+bounces-336436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B87ED983ABC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 03:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802592822F9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D6C1D696;
	Tue, 24 Sep 2024 01:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mtA2eFYH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54D0C13C
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 01:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727140638; cv=none; b=lVBaGGhTNN6MaXgsctpTj7nYgfnYm2e/iUkeAcRARl7cjg+fuKfubuN0huORGTJg284Pn7hWkbDlkAwCLryEVg2hg8vuSdJKwD9TIKA72ESSmIPWkusPyvId+/9I4U0CDo6TS4ALEh8lw5lKJjg0j2W2jcENB9fHsv/Tk71aFo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727140638; c=relaxed/simple;
	bh=nZQ5WdYOudXFblQyI1xpFNONjVx0pWlV5kfygJBmOHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sv5GWdCrI57sVZL9XAOvczcZ32VJUM+KtOqdqkaCCds+Vp4dD+kUdoOtvcCfW/5C/OZH9lX8A+G7EPrIuEcP5f6uvUHixYrUyxHOls17cpag8sg3ij+wCmHPDcx3YOquZUu+vowQcgoR0XkpOZjux5Sw1YgP8raxF3BQrBfdvTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mtA2eFYH; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727140636; x=1758676636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nZQ5WdYOudXFblQyI1xpFNONjVx0pWlV5kfygJBmOHg=;
  b=mtA2eFYH2HaCeU2SemCor6gO8aJy9aXp6uMwlMjdZGVwD8UdX4L9yN/S
   bhvcqSM34ZaCRUpLbvHK2e6yAqrvM8MJoAAFpTmEMXzDqYIyPhUDHPdwo
   lciwf0WE6994Eq5DVdiEngueUApRCExm0CaUGYtUFdeGTJoI/363TtdFb
   5cvYXqS0xvqW9qz+wwYlr66KU4bhYU9jZBNzi2JDGKOxlD6RJ3AieUn+l
   +dH5SbflYOAtRZ9kUhbuySASjva8+OmF624f9TqjxSobIKgoBp4jfwRdY
   o0nZnCuWABiSEPJFYuKPProzhWho/Yv+Lk5X41a1KZ9wwQp/0sGv4x4LX
   g==;
X-CSE-ConnectionGUID: cvmXRArySz6FRWN5pDTx/A==
X-CSE-MsgGUID: zxEUhqtXQuS3wYbfUbzezQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="30002046"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="30002046"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 18:17:11 -0700
X-CSE-ConnectionGUID: udjgHgWqQzO/LxXYb+uyVQ==
X-CSE-MsgGUID: lLNNKrXVTtWLEYgP3S0l6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="108688463"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa001.jf.intel.com with ESMTP; 23 Sep 2024 18:17:10 -0700
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
Subject: [PATCH v7 7/8] mm: swap: Count successful mTHP ZSWAP stores in sysfs mTHP zswpout stats.
Date: Mon, 23 Sep 2024 18:17:08 -0700
Message-Id: <20240924011709.7037-8-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new MTHP_STAT_ZSWPOUT entry to the sysfs mTHP stats so that
per-order mTHP folio ZSWAP stores can be accounted.

If zswap_store() successfully swaps out an mTHP, it will be counted under
the per-order sysfs "zswpout" stats:

/sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/zswpout

Other block dev/fs mTHP swap-out events will be counted under
the existing sysfs "swpout" stats:

/sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/swpout

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 include/linux/huge_mm.h | 1 +
 mm/huge_memory.c        | 3 +++
 mm/page_io.c            | 1 +
 3 files changed, 5 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 0b0539f4ee1a..ab95b94e9627 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -118,6 +118,7 @@ enum mthp_stat_item {
 	MTHP_STAT_ANON_FAULT_ALLOC,
 	MTHP_STAT_ANON_FAULT_FALLBACK,
 	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
+	MTHP_STAT_ZSWPOUT,
 	MTHP_STAT_SWPOUT,
 	MTHP_STAT_SWPOUT_FALLBACK,
 	MTHP_STAT_SHMEM_ALLOC,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4e34b7f89daf..7d8ce7891ba8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -612,6 +612,7 @@ static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
 DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
+DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
 DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
 DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
 #ifdef CONFIG_SHMEM
@@ -630,6 +631,7 @@ static struct attribute *anon_stats_attrs[] = {
 	&anon_fault_fallback_attr.attr,
 	&anon_fault_fallback_charge_attr.attr,
 #ifndef CONFIG_SHMEM
+	&zswpout_attr.attr,
 	&swpout_attr.attr,
 	&swpout_fallback_attr.attr,
 #endif
@@ -660,6 +662,7 @@ static struct attribute_group file_stats_attr_grp = {
 
 static struct attribute *any_stats_attrs[] = {
 #ifdef CONFIG_SHMEM
+	&zswpout_attr.attr,
 	&swpout_attr.attr,
 	&swpout_fallback_attr.attr,
 #endif
diff --git a/mm/page_io.c b/mm/page_io.c
index bc1183299a7d..4aa34862676f 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -269,6 +269,7 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 		swap_zeromap_folio_clear(folio);
 	}
 	if (zswap_store(folio)) {
+		count_mthp_stat(folio_order(folio), MTHP_STAT_ZSWPOUT);
 		folio_unlock(folio);
 		return 0;
 	}
-- 
2.27.0


