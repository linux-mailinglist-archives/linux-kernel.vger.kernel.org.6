Return-Path: <linux-kernel+bounces-348170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6728698E3A7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300CB282E77
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D49215F6D;
	Wed,  2 Oct 2024 19:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E5WZPBez"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E194412CD88
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727898136; cv=none; b=Yca8O+7/ruAkMhrrMr/v+1bXzXMUPwOgGB2J0cgMPmGJbqfqFOWnbsuCRaId3D5w4KqL3rHjO7aISJnfwN8f38Q92orOdS9V0v+nUVADTU42XeTULePKf8ryq2dRHme+caVfUHC5YZlRdLuIHFbgemvmlBNNk6Kb/ItVDWCrKQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727898136; c=relaxed/simple;
	bh=zD7PAqvbk15VJBCVJlOAxWftJ5h8d3rAJ0uuK/4+q2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZaYUxgUFGqgNBcFlR4dR7BqlPWJNLeDNuRozpBU+zhFKl7aBORnRnu7VeB8+a+8cf3IrITzdxIdfwmfCaOINJVNvfv5yfsQB0gRmNgdnRDyoIF1Lebtjvh9mkI8PeaTE4I91L7tBGVgvdFL15Es+qwKMVXvzm2hpGGX0INWHbzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E5WZPBez; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727898135; x=1759434135;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zD7PAqvbk15VJBCVJlOAxWftJ5h8d3rAJ0uuK/4+q2Q=;
  b=E5WZPBezzZ7xtLY/PqYd85wR7WuNJEhm5ZfT2xF5Zjjnzn0UA3vr58jk
   jmA/laMw1mJUYiuCYUxr6UGFg7GXQKJq3uOcAmWpqRTk2KTDwmZefSJ+1
   LVNNOONIno55Zno+lvcE2R1UKbgCewmHuyy6EkWRy9vhajV+Mo8jql0H/
   e1ITk5JSqpy79yw4RTU+OGSMhsyd6Vd2Tpdb86UrY5HF2WJQ/uT8ErS28
   9e80xcfef/R3+xzFXgUrKLGmUzzuzLkpy0r490Bwxd3jG9guEVeB3kuOp
   VtdSez9qRooPb0psXXsOlv6ReeJGJqMQ5yKNtNQguxnjqTFqR+28RXI4j
   Q==;
X-CSE-ConnectionGUID: azztgb/YSsq0I/AcSdH5bg==
X-CSE-MsgGUID: snSfr8xlSZ+37hk5hmgmMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="30962387"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="30962387"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 12:42:14 -0700
X-CSE-ConnectionGUID: Dd9ZAYjfRTyucqYr7EMJ4g==
X-CSE-MsgGUID: SlENKAaWQpynHFmy9E9iaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="104880714"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa001.fm.intel.com with ESMTP; 02 Oct 2024 12:42:14 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v2] mm: zswap: Delete comments for "value" member of 'struct zswap_entry'.
Date: Wed,  2 Oct 2024 12:42:13 -0700
Message-Id: <20241002194213.30041-1-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Made a minor edit in the comments for 'struct zswap_entry' to delete
the description of the 'value' member that was deleted in commit
20a5532ffa53 ("mm: remove code to handle same filled pages").

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Fixes: 20a5532ffa53 ("mm: remove code to handle same filled pages")
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Usama Arif <usamaarif642@gmail.com>
---
 mm/zswap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 09aaf70f95c6..c3e257904b36 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -190,7 +190,6 @@ static struct shrinker *zswap_shrinker;
  *              section for context.
  * pool - the zswap_pool the entry's data is in
  * handle - zpool allocation handle that stores the compressed page data
- * value - value of the same-value filled pages which have same content
  * objcg - the obj_cgroup that the compressed memory is charged to
  * lru - handle to the pool's lru used to evict pages.
  */
-- 
2.27.0


