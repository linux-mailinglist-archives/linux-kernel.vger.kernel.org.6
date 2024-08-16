Return-Path: <linux-kernel+bounces-289020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93612954154
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6D361C219F5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 05:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1E084A46;
	Fri, 16 Aug 2024 05:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jpVcvlYQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C6E81749
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723787293; cv=none; b=jFFdCHHwDqf9rG3kpdrw/JYyqOEulUdH3FjTUGOrGH5KRTwLRANR84i3G3KC+pMH30Z/AReIvHh74F2Zqj9q/KNnwMaHeshqMzUXmJmqXFjmDZVgM76JtSOzUAHybsRedZXY/3ytFYiibkJ5+VbTObWTRKnbEiidMsrKdZ6KNa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723787293; c=relaxed/simple;
	bh=8aJTLnzMPmjHtUmt/CSvhY9AKnZREM8rFjycd3MYym0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nRI9MnuniXTpWdZKrjZUs9DVy/0blxgQ8tiDoHLwL7spH+K5kV07k21gMnq1L2ooHt9rDon4gvwre7TmiG6Jzb5WioNTo7opIc3nUAwYhk5G1+gvAgvoamjEP4q54BA/HDcTdLi6UlZ3wri1QvqgQ3Gg3O7RIxQL6ohddBoP9Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jpVcvlYQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723787292; x=1755323292;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8aJTLnzMPmjHtUmt/CSvhY9AKnZREM8rFjycd3MYym0=;
  b=jpVcvlYQdrxl1jKadDtIuLEqhfTt2xUs8vrtFp18UIb/tk+dr/Te9UbM
   Dkph/Ys2IeuTuLC5jMy1Mx0Ip3pC1M9mopcOrmmtLOA22+VaU4/4TrD/m
   5uHRQKXjf7zbYYXtC0NTFD9KYtp25dyplLvPONJhYtRYlnkE/BnIPFtx3
   clqgEa2xNjnhHPgpqD//vUL9eacvKNVhzW7Hmq52pStgC4cjj1Z4S/HLv
   kP0Ij5Y4mVhLU0XnzCQzUsOOAGMYKWlMPm2XQSXT6pGpEiOTk5tzVDmm7
   PgD1msPxEitAVDesmZzakqZR0fq9DRZyvxXAit591RnZ9J9qDVU42UvO/
   w==;
X-CSE-ConnectionGUID: bKc3z4fjR6aG5odObSrzYg==
X-CSE-MsgGUID: qMK7W7bMRf2UwNLGMeuAyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="32648114"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="32648114"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 22:48:07 -0700
X-CSE-ConnectionGUID: CmHiJCcuQdavnb7D8MPHOQ==
X-CSE-MsgGUID: 39CNgtIxREOwdGxpX5wumw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="59415332"
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
Subject: [PATCH v2 1/4] mm: zswap: zswap_is_folio_same_filled() takes an index in the folio.
Date: Thu, 15 Aug 2024 22:48:02 -0700
Message-Id: <20240816054805.5201-2-kanchana.p.sridhar@intel.com>
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

This change is being made so that zswap_store can process mTHP folios.

Modified zswap_is_folio_same_filled() to work for any-order folios,
by accepting an additional "index" parameter to arrive at the
page within the folio to run the same-filled page check.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 mm/zswap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index adeaf9c97fde..6c5c656ec282 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1358,14 +1358,14 @@ static void shrink_worker(struct work_struct *w)
 /*********************************
 * same-filled functions
 **********************************/
-static bool zswap_is_folio_same_filled(struct folio *folio, unsigned long *value)
+static bool zswap_is_folio_same_filled(struct folio *folio, long index, unsigned long *value)
 {
 	unsigned long *data;
 	unsigned long val;
 	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*data) - 1;
 	bool ret = false;
 
-	data = kmap_local_folio(folio, 0);
+	data = kmap_local_folio(folio, index * PAGE_SIZE);
 	val = data[0];
 
 	if (val != data[last_pos])
@@ -1435,7 +1435,7 @@ bool zswap_store(struct folio *folio)
 		goto reject;
 	}
 
-	if (zswap_is_folio_same_filled(folio, &value)) {
+	if (zswap_is_folio_same_filled(folio, 0, &value)) {
 		entry->length = 0;
 		entry->value = value;
 		atomic_inc(&zswap_same_filled_pages);
-- 
2.27.0


