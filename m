Return-Path: <linux-kernel+bounces-290543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF53595557F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 07:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58BF2B22FA3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 05:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEFD770F6;
	Sat, 17 Aug 2024 05:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ioVR7Rqr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A69885283
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 05:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723871374; cv=none; b=ZF1Nu21DY6XNLPkIFZutTADH8IELyF2Hl/g5pm/3e3M4PplkMlX9WN8qDP9QXuR2Ulmac+KAj9AwuQDBYY/bmSMniMPK4BATR/SDNjd8j0C7XWzWwyMEzZKQ0jgFS38gh20zHrPhuTS78AbRw2HxINr0XrNHDqrvhqDdfVRipkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723871374; c=relaxed/simple;
	bh=pIv8/Aymq35M3mk+Ip2dqi+IlPE8wYobMr4oum9ku1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YTnpN7TFJIuJS6M5Mg7dtuTpZvfoYzwfTRHZFzSSSrVYODj7o5Bvg4YjqlbGJYEqeZjJlPVnu0VcUuG77k2mr9F/Dy7Ppjw+b+zwMa9TOjm3uOMGdD344U6vAJbkF7X49nDEJxr3am20Vnh3fb7O8YIu5s1zx1x3JRmMKsCF4/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ioVR7Rqr; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723871372; x=1755407372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pIv8/Aymq35M3mk+Ip2dqi+IlPE8wYobMr4oum9ku1Y=;
  b=ioVR7Rqr9ZgapfLWy4X+8U+OtZ98GG8Q+eOWXgGRZqMyk3GtFWPsFrM+
   s9A2xNsYdDO9d7zHmM/UAY8hFYQ37263kzjgECEHhlkSOxaWuxajv/xQv
   9UR4dyoVIekgcuXmLMtUf3ldjSH5j8kVemYG0g6+qhNPGsAAkN0AvSxv6
   yO/YkkxFxLbX83sumQlqQhODtq25V82Zj8RAz+2NN8octvcxdEbb4n6p0
   bdEhV4ENLzcRewcx+7dVOeEBLuyolN6DQ2o60Zao1vdIbXqtuw6e6oT8Z
   Se2Ypnh5qfTF4dANEsfk3Dn1tpP8KiHtpT8UF1EK2XqWkE502kZ0sZ4vG
   w==;
X-CSE-ConnectionGUID: i683/gphS+S53/42wCH/ag==
X-CSE-MsgGUID: jchyHopvQAacm/kbxZwHIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="25929485"
X-IronPort-AV: E=Sophos;i="6.10,154,1719903600"; 
   d="scan'208";a="25929485"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 22:09:22 -0700
X-CSE-ConnectionGUID: G3ES7ewjRXi5YjsXLL3eQQ==
X-CSE-MsgGUID: fZPmCcW6RFSDaGvIag7BFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,154,1719903600"; 
   d="scan'208";a="60141501"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa006.jf.intel.com with ESMTP; 16 Aug 2024 22:09:22 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org
Cc: nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v3 4/4] mm: swap: Count successful mTHP ZSWAP stores in sysfs mTHP stats.
Date: Fri, 16 Aug 2024 22:09:21 -0700
Message-Id: <20240817050921.18462-5-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240817050921.18462-1-kanchana.p.sridhar@intel.com>
References: <20240817050921.18462-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If zswap_store() successfully stores an mTHP, it will be
counted under the per-order sysfs "zswpout" stats:

/sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/zswpout

Other block dev/fs mTHP swap-out events will be counted under
the existing sysfs "swpout" stats:

/sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/swpout

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 mm/page_io.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/page_io.c b/mm/page_io.c
index ff8c99ee3af7..debd04fbdfd0 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -172,6 +172,12 @@ int generic_swapfile_activate(struct swap_info_struct *sis,
 	goto out;
 }
 
+static inline void count_mthp_zswpout_vm_event(struct folio *folio)
+{
+	if (IS_ENABLED(CONFIG_THP_SWAP))
+		count_mthp_stat(folio_order(folio), MTHP_STAT_ZSWPOUT);
+}
+
 /*
  * We may have stale swap cache pages in memory: notice
  * them here and get rid of the unnecessary final write.
@@ -196,6 +202,7 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 		return ret;
 	}
 	if (zswap_store(folio)) {
+		count_mthp_zswpout_vm_event(folio);
 		folio_unlock(folio);
 		return 0;
 	}
-- 
2.27.0


