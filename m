Return-Path: <linux-kernel+bounces-285939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C8B951481
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71522867D5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5EF86126;
	Wed, 14 Aug 2024 06:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="asw0pJuv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062417345B
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 06:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723616914; cv=none; b=nao6cVFhHS7Om1petO9yJd7fV6eRhm5kG7wqdGtfwybiumCe4pGRqPGr/soqnWxKXjBRxrSB8g6qjL0sDd1vtuzITupesYGDd48pt9S9xYfGHML4sDTVO3urip7oW/+F0DeTdfRSwYNjD49NdGgGLVdKB4Eg/I+lVKIeS/+BlQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723616914; c=relaxed/simple;
	bh=oe1u+d7vabSLdycsD7ncPotAgciyDo4K/Y5B+/jbgp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i6V111o9x/ieufx4r10RVDl29POaZ33/R2BFlNIxddOVwvwT1u9pHHKc5045KyLswUmK5Uxg+FnraGW7nuTRhUKyjUphz40oPXL+Hbsf3hbAMhmclZZ4X+fX+HlTF7Too+N+zQHfM4ziDAIGMAQdSf5SoZLR/ZoTjgncZS2X6hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=asw0pJuv; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723616913; x=1755152913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oe1u+d7vabSLdycsD7ncPotAgciyDo4K/Y5B+/jbgp0=;
  b=asw0pJuv4b6JlcQ7mtfEFTo2OPelilOhZ/lylaVXwqfyyXRNZVxIbBIJ
   6ZA4XVONA8bMNnECEILjTWV1EGVVyhCcXvfZve2EzWGJgLobbpzDChgll
   Kl52mFEGujXXbLpTJvMEFspNkRMGE2Y55oWoDa5yylNxqThvo/rE3h0mm
   Xd82DaDsOt/VtTHdDjAPIHKQ0pe2LInMB54u56oTCEPugw4wYMyTrS3tb
   dROcncbDo8XQGo5QDDFCoh8TEvc1SrdWPGt8rA7kyWPyT2dAfetT0qYiN
   IFPmgipYiaitsQFKEIvn5N9egUUdNdAGa7V4zr5j5ktL16sWlcUTjAR2y
   w==;
X-CSE-ConnectionGUID: LdadFAniTzKdHGhAvwLzDg==
X-CSE-MsgGUID: rWyyKTZMShCnsHYOoyJDDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="44332997"
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; 
   d="scan'208";a="44332997"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 23:28:32 -0700
X-CSE-ConnectionGUID: kzgamZ+BQ3SH8LR1nuZ/yg==
X-CSE-MsgGUID: ClU524GxSxK+fXEp+PHjlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; 
   d="scan'208";a="63568749"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa004.fm.intel.com with ESMTP; 13 Aug 2024 23:28:32 -0700
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
Subject: [RFC PATCH v1 1/4] mm: zswap: zswap_is_folio_same_filled() takes an index in the folio.
Date: Tue, 13 Aug 2024 23:28:27 -0700
Message-Id: <20240814062830.26833-2-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240814062830.26833-1-kanchana.p.sridhar@intel.com>
References: <20240814062830.26833-1-kanchana.p.sridhar@intel.com>
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
index a50e2986cd2f..a6b0a7c636db 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1373,14 +1373,14 @@ static void shrink_worker(struct work_struct *w)
 /*********************************
 * same-filled functions
 **********************************/
-static bool zswap_is_folio_same_filled(struct folio *folio, unsigned long *value)
+static bool zswap_is_folio_same_filled(struct folio *folio, long index, unsigned long *value)
 {
 	unsigned long *page;
 	unsigned long val;
 	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*page) - 1;
 	bool ret = false;
 
-	page = kmap_local_folio(folio, 0);
+	page = kmap_local_folio(folio, index * PAGE_SIZE);
 	val = page[0];
 
 	if (val != page[last_pos])
@@ -1450,7 +1450,7 @@ bool zswap_store(struct folio *folio)
 		goto reject;
 	}
 
-	if (zswap_is_folio_same_filled(folio, &value)) {
+	if (zswap_is_folio_same_filled(folio, 0, &value)) {
 		entry->length = 0;
 		entry->value = value;
 		atomic_inc(&zswap_same_filled_pages);
-- 
2.27.0


