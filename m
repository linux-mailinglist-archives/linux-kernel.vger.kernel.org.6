Return-Path: <linux-kernel+bounces-289019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023EB954153
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829EF2887CD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 05:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C80184A2B;
	Fri, 16 Aug 2024 05:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P+wJxvBY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A4881ACB
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723787293; cv=none; b=cqI94NIhdLTFkkCilya7Qww0L9EUYkMt4Nhlpj+o+qUS3YIp+Wu3g0W8zQM53KILgWgdIE2tJsmRNtJZGU9EpYd71tv7gbe0bRlzl08SuHZzJ6p3SlIMzy1Gn8iOkIrOivpCIDA5mS1DjdZIBrxEv+K3OgyBtzo3kxiEr0Rot6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723787293; c=relaxed/simple;
	bh=pIv8/Aymq35M3mk+Ip2dqi+IlPE8wYobMr4oum9ku1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c3geManx+iWEcZMuLTf8/MXpm1KuugTvcsRIHXF1uFoX2m4tagwvdaDdERjDUo483nql/9BI2ROMkU8nQULj92pzE96nBzWbbSTee+6ZlSsUFFB9k1y/8fFIYcZj0pU2wrLHo/cNbOOL1jjSAOumbakcyJpH2dzQIeymetj7YyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P+wJxvBY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723787292; x=1755323292;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pIv8/Aymq35M3mk+Ip2dqi+IlPE8wYobMr4oum9ku1Y=;
  b=P+wJxvBYskjtF7kfXxg/oeJEI0FT1sEaAGWwJpTszRVu1Z9RVwLuVooW
   GRuxJDnsm7s9Y2QdrzhKurJFHYnCAeMNmKXls2ZNUWfW0ngocGI9J7xlr
   B3E2f+zi1TUzOcwezZCO7nHQvNkm5v7K39iPWacc7OlqNwSKWe19xUNXE
   IdVKBZLGZgEd6am1jJgoaC/XJC0iJEF7JgNL2kqVm6TCZET/0MQ+bjEUv
   9VYlukZB00rMyES+L3VRZGlJi6caV5YCHTOvKup+8/24G0vqbkVdd1Jm1
   kNTcdCzABbjAjRv+C3pOn90s5/PmG59S2fui2AOqNQCo8FSBvFeQmzLSK
   g==;
X-CSE-ConnectionGUID: z6NMVYS+S9iy/SHjW4l3uA==
X-CSE-MsgGUID: sRPe6J+7SE6xFAcjt2y2jQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="32648136"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="32648136"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 22:48:07 -0700
X-CSE-ConnectionGUID: Lw57TrXiShu8ilNs3A/XgQ==
X-CSE-MsgGUID: YVfs9eGNSDGbKoVTja+gQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="59415342"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa010.jf.intel.com with ESMTP; 15 Aug 2024 22:48:06 -0700
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
Subject: [PATCH v2 4/4] mm: swap: Count successful mTHP ZSWAP stores in sysfs mTHP stats.
Date: Thu, 15 Aug 2024 22:48:05 -0700
Message-Id: <20240816054805.5201-5-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240816054805.5201-1-kanchana.p.sridhar@intel.com>
References: <20240816054805.5201-1-kanchana.p.sridhar@intel.com>
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


