Return-Path: <linux-kernel+bounces-348023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC9D98E19E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0858F1C22C0E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378541D1739;
	Wed,  2 Oct 2024 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cd5GoHKC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25384195811
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890232; cv=none; b=P6e6ka9QWK51hbyBKB/WEgdgorXnYMf8U5UCY7YvvraGydpCMkuCUNUhzAvgGzy2OqoRHKO80XOmC38YzZiUJDLzeJDCg6kxRis8sVq4japObEz2NUfAvztBbQMjsnEQBe79l9HZidaCzXMct6E2AfAGEOsIvMX/gzXae9xlnVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890232; c=relaxed/simple;
	bh=2ELES4Kbwfg1bRDv3Fg/Pic/+KP79M6fZWl7HfTF6vU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mqHn4ta2bJCbzOeleR5g51pF+iC9BCuZrZ8v7jwAD6Uegfg/St9RE5moF8feu96EVOmDqRnkcVdPbMZXe/EdqxMGxHEHiU3Ews4f/sjpJ67Wg0kUOl2HFTnAO0xBjvJEz5SZgi63l9kVoHO731Ri7S7qimDjqvNsF91UNftNQ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cd5GoHKC; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727890231; x=1759426231;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2ELES4Kbwfg1bRDv3Fg/Pic/+KP79M6fZWl7HfTF6vU=;
  b=Cd5GoHKCJ0mRLwetGr3xb2oLkwTumTVJTHqLUFqG91wjnbaTG6JRZSAM
   UnX6C5GZ2f/okE2WVjRQJUdS7tpVF+VWGTViRB/ElifC1Q845v50nZNDf
   gApmeS1bfhq8ajUuZUnKFODBzGaICAGYT+urtRggA2PcA+aV5WKxOpylm
   NowhdpaXMSz+ThbFh8DIsvuPuGtSN4tqynllmarpRAzdR9WW24R6s6yFA
   kF9I7eaP4AbRtH4BxxXsrnKda+yQZD0MIX/iGNJQei24HqKWcQEM1j4B1
   AmdkGgxRDXbiiDezu8H9+70yhozNl0mel0Cgel+eSaMLyasgNMHS9I2mW
   w==;
X-CSE-ConnectionGUID: Uj691a+sSjypClXXApMvqA==
X-CSE-MsgGUID: AK1ZhW4/SUuKV/muaGQOPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="38199923"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="38199923"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 10:30:31 -0700
X-CSE-ConnectionGUID: vCREuwdORgeYm4C9noXeAA==
X-CSE-MsgGUID: cbsfuzteSPSQsEpQkAanJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="79038099"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa004.jf.intel.com with ESMTP; 02 Oct 2024 10:30:30 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v1] mm: swap: Call count_mthp_stat() outside ifdef CONFIG_TRANSPARENT_HUGEPAGE.
Date: Wed,  2 Oct 2024 10:30:30 -0700
Message-Id: <20241002173030.213536-1-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch moves the call to count_mthp_stat() in count_swpout_vm_event()
to be outside the "ifdef CONFIG_TRANSPARENT_HUGEPAGE" based on changes
made in commit 246d3aa3e53151fa150f10257ddd8a4facd31a6a ("mm: cleanup
 count_mthp_stat() definition").

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 mm/page_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 4aa34862676f..a28d28b6b3ce 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -289,8 +289,8 @@ static inline void count_swpout_vm_event(struct folio *folio)
 		count_memcg_folio_events(folio, THP_SWPOUT, 1);
 		count_vm_event(THP_SWPOUT);
 	}
-	count_mthp_stat(folio_order(folio), MTHP_STAT_SWPOUT);
 #endif
+	count_mthp_stat(folio_order(folio), MTHP_STAT_SWPOUT);
 	count_memcg_folio_events(folio, PSWPOUT, folio_nr_pages(folio));
 	count_vm_events(PSWPOUT, folio_nr_pages(folio));
 }
-- 
2.27.0


