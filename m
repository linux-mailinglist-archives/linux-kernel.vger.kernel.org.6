Return-Path: <linux-kernel+bounces-344918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D068698AFAF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D988B23DF4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB2D199E9E;
	Mon, 30 Sep 2024 22:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SwgW9i/m"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BD1188A3E
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 22:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727734350; cv=none; b=bvxCjttqFd89sU1UW8ytSiAjImLOD4gIQimcdEiD6UbumqDP+TEB4HffpdDXYqJgob/lb21PKw7dKfXmGW1/aQ05aJsGxeqZs1dH11xD1mhozKQ68vXeVXr5DTVYKE1n8p7LyHKKV6vgDgYlSulXVv56eMl27XsOC1z2licsL6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727734350; c=relaxed/simple;
	bh=9WsgnlbaWxDYzoSeOHrRpgB8xi3C6kSbFeaymu5ESD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S/JAYT91BK+Mp1Lb54LAD7w5lT9K9U+Xkt9a03G+CnMs98e/SF7LGKOYAGeHQMlbpUHogJvorJIEyQUTpU+Zv5zmtNt/uLL53DhpBV27/Fn7O9VQho9/IIFsaofjYDnzj+oAZlRCR/Cz07hlJIygLgSJOrAFS0xb60wm/82XsQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SwgW9i/m; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727734349; x=1759270349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9WsgnlbaWxDYzoSeOHrRpgB8xi3C6kSbFeaymu5ESD4=;
  b=SwgW9i/mUz+hDh47jNP654MdTXpQuEcto7P4MupxnmFaJFU7EsRN+Rdk
   hRJ8dtv/LqO6NRrviYxjyyOrwoiQrO8yj3Tmv0tW/+b0FKyQE8brvLwPw
   2gv8ZR+DmHRjjTubhRYQa7uKrqMGhmwkj8TmlUBvx1JP2GBr7hx4mKdBx
   cAt3fjYPVSafPAoUdCaoZ/lwNoI5cxWrvl09POhbTMX7NmIMFnGKUY6pr
   taZH6b5fiJVhOaXJayiqmIzlEcKINR9CC4XEUdYOXoqfnvM60zpDn9dSe
   KlFuamPx6qmDzvPP4e773A4bCqE5HqKXxi+ZhoeTKD6pFzungVPzNZ3wb
   g==;
X-CSE-ConnectionGUID: 7VJ9BGmrQ02/mu9W16CUJQ==
X-CSE-MsgGUID: wbnJIcjvTT+7YuanNUZ8Zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="49368457"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="49368457"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 15:12:25 -0700
X-CSE-ConnectionGUID: T9yraZJRTZCRQZahtHf09g==
X-CSE-MsgGUID: prXEZfqVSHWeMdbJj+LIig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="77985597"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa004.fm.intel.com with ESMTP; 30 Sep 2024 15:12:24 -0700
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
	akpm@linux-foundation.org,
	willy@infradead.org
Cc: nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v9 7/7] mm: swap: Count successful large folio zswap stores in hugepage zswpout stats.
Date: Mon, 30 Sep 2024 15:12:21 -0700
Message-Id: <20240930221221.6981-8-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240930221221.6981-1-kanchana.p.sridhar@intel.com>
References: <20240930221221.6981-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added a new MTHP_STAT_ZSWPOUT entry to the sysfs transparent_hugepage
stats so that successful large folio zswap stores can be accounted under
the per-order sysfs "zswpout" stats:

/sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/zswpout

Other non-zswap swap device swap-out events will be counted under
the existing sysfs "swpout" stats:

/sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/swpout

Also, added documentation for the newly added sysfs per-order hugepage
"zswpout" stats. The documentation clarifies that only non-zswap swapouts
will be accounted in the existing "swpout" stats.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 8 ++++++--
 include/linux/huge_mm.h                    | 1 +
 mm/huge_memory.c                           | 3 +++
 mm/page_io.c                               | 1 +
 4 files changed, 11 insertions(+), 2 deletions(-)

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
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 5eb4b0376c7d..3eca60f3d512 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -119,6 +119,7 @@ enum mthp_stat_item {
 	MTHP_STAT_ANON_FAULT_ALLOC,
 	MTHP_STAT_ANON_FAULT_FALLBACK,
 	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
+	MTHP_STAT_ZSWPOUT,
 	MTHP_STAT_SWPOUT,
 	MTHP_STAT_SWPOUT_FALLBACK,
 	MTHP_STAT_SHMEM_ALLOC,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 13bf59b84075..f596f57a3a90 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -611,6 +611,7 @@ static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
 DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
+DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
 DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
 DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
 #ifdef CONFIG_SHMEM
@@ -629,6 +630,7 @@ static struct attribute *anon_stats_attrs[] = {
 	&anon_fault_fallback_attr.attr,
 	&anon_fault_fallback_charge_attr.attr,
 #ifndef CONFIG_SHMEM
+	&zswpout_attr.attr,
 	&swpout_attr.attr,
 	&swpout_fallback_attr.attr,
 #endif
@@ -659,6 +661,7 @@ static struct attribute_group file_stats_attr_grp = {
 
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


