Return-Path: <linux-kernel+bounces-291340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2911A956108
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9748281BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B7A3B298;
	Mon, 19 Aug 2024 02:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lIO7JEjn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D966E26AD4
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 02:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724033787; cv=none; b=fRjEePzycL3qTkJB28teVdxfEELCoZ62UBNZbXGegC0qMbtBk1PBNU6tssgwxQj7SrSB+WXyrk8t5POC11gAZu89pD/eY9r1fG8Bb/8Vf8N0q+Tv1flFW8qTIIuaHMYWNR5nenDDTkweOq5R8VR763+MaY1R2D/hOewe8i4Qfbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724033787; c=relaxed/simple;
	bh=e4dJeIMpZ7zVkmYhUNqheK2yMfNN01J1RMy+uwUX+JE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aFTcj5oY9LB8W6hOTh4puEjG9RTsMl01MFQUOK+WjgQwB68gkHeKfICAYK+AvYV5pjNYiMRz/3j86oj1F5D8jDn0+DCkhLTlAv4i8Om5Olu73wkgTZ3bpTJAOAvDpPf7W1TaITut6fSPIGs830MzQmLgiTRfcAXOV3JQGFKUBfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lIO7JEjn; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724033786; x=1755569786;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e4dJeIMpZ7zVkmYhUNqheK2yMfNN01J1RMy+uwUX+JE=;
  b=lIO7JEjnm750k6c7GH3uaWmUSTu2ei/6EquiJkp/Lyd1SksVFrApQksd
   8q35E3JbcCyGkRuSGBzSC4fIJyxY8Z9B8YQxKCPJlUnC/ctkLn44i+HOP
   X9u9Q8jHzn1JqzpDOxICx+Oklc6A/NufVet1tzurGXqswlGCYEb9cY3gB
   8A507nfT4PeMIt89XGW1agY2uJ80YNLJtxAmSyNJYhxSAhBwipemHBe85
   pBTOVNAiL3DGf9uwJ7/cMKDC/fqs/bJn/Bxbo49h+BPej+vLfWaFI86o/
   R38cqHSX4eK3DVp1eGXJF+BZAi9a/3v1l9XZfQPkJkpp5E6JJK2H4WNo+
   g==;
X-CSE-ConnectionGUID: ZZ5ckDFzRReN1XRpBU7yWA==
X-CSE-MsgGUID: 5nDFCSFJSFiLCOzWIDOcDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="44782979"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="44782979"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 19:16:24 -0700
X-CSE-ConnectionGUID: Q7fqm6iGRiq5vh7mK/HcfA==
X-CSE-MsgGUID: BTCZqOyyTrukqBfPvkuwiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="64610280"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa005.fm.intel.com with ESMTP; 18 Aug 2024 19:16:23 -0700
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
Subject: [PATCH v4 4/4] mm: swap: Count successful mTHP ZSWAP stores in sysfs mTHP stats.
Date: Sun, 18 Aug 2024 19:16:21 -0700
Message-Id: <20240819021621.29125-5-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240819021621.29125-1-kanchana.p.sridhar@intel.com>
References: <20240819021621.29125-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If zswap_store() successfully swaps out an mTHP, it will be counted under
the per-order sysfs "zswpout" stats:

/sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/zswpout

Other block dev/fs mTHP swap-out events will be counted under
the existing sysfs "swpout" stats:

/sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/swpout

Based on changes made in commit 61e751c01466ffef5dc72cb64349454a691c6bfe
("mm: cleanup count_mthp_stat() definition"), this patch also moves
the call to count_mthp_stat() in count_swpout_vm_event() to be outside
the "ifdef CONFIG_TRANSPARENT_HUGEPAGE".

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 mm/page_io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index a00e2f615118..ac5954149eb9 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -196,6 +196,7 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 		return ret;
 	}
 	if (zswap_store(folio)) {
+		count_mthp_stat(folio_order(folio), MTHP_STAT_ZSWPOUT);
 		folio_unlock(folio);
 		return 0;
 	}
@@ -215,8 +216,8 @@ static inline void count_swpout_vm_event(struct folio *folio)
 		count_memcg_folio_events(folio, THP_SWPOUT, 1);
 		count_vm_event(THP_SWPOUT);
 	}
-	count_mthp_stat(folio_order(folio), MTHP_STAT_SWPOUT);
 #endif
+	count_mthp_stat(folio_order(folio), MTHP_STAT_SWPOUT);
 	count_vm_events(PSWPOUT, folio_nr_pages(folio));
 }
 
-- 
2.27.0


