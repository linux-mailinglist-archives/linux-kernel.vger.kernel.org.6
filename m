Return-Path: <linux-kernel+bounces-345253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFEE98B3B0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8689D282FC9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 05:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5257B1BBBC4;
	Tue,  1 Oct 2024 05:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XMZGQ65s"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AB518E02D
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 05:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727761029; cv=none; b=pQnwzQwIblgpfhuMtDgSyixgWijcONd13xCriGFu90JeowhctTex85HNfkl4VpfZSEcZg8pHjISNa+PoVWplqUXzRF10aZaZp89m9tRL2Rle+TySw6a3OLfSLDJgtAInGFkempDahy/yr745Dbe6jEBWept8SMJBWfZuEMSCLfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727761029; c=relaxed/simple;
	bh=HXPnxaS0BG2kkNkoIrCoeh8TspMXuNCwKniqdIZtWWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ls/IWK2Z9W7oGK4M7qX/TEx63FCQr2+PhIyQu1IJccMCSBx8UaosE7EeWU3UweyPeCQ250K+y6xhh19M7zIskANT8opqmVwOGFdNR+0Vt9jVkvljj0TnZDJgTLRgZbIzTv2KJ79xCA0RfVwEZSCHp0jjYcIZyzbVO6fmC2n+fLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XMZGQ65s; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727761028; x=1759297028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HXPnxaS0BG2kkNkoIrCoeh8TspMXuNCwKniqdIZtWWM=;
  b=XMZGQ65smx+ALRQJjuRIqAoKyRPJ2tEbTkpCSt1+kFCsAsoU2sblWoIO
   7gu1LBSYoHFURtdNHFaUk/Q0mDkspkv0+emsBR8oABMOVa3lB2ZLs0KMK
   fQv+rV18WMy3FxIBtewaUXBY0effQIhvpO8hKiw0CZQLeWUgmko5njczv
   DH+SE8c9XmOOkNTj02lOTSpBZ69/1L+6HeDOF6pRAL4DFVwhvSqYsHN4a
   SpHx5dBuN5K/nQRFNuIJDzGRBrYbiXSShCGVsvDltVbAtRkPCI2Z2Dgs3
   6rZ7NooYVn3LqKeFGf+mcoPsRqhNnbza7OGNpuQIXzBQE5/ZnW+wJscYX
   w==;
X-CSE-ConnectionGUID: NJAPLnU0SziO0NXTr3anww==
X-CSE-MsgGUID: CxccQfA1Qj+TXDqqnRcrRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="37465066"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="37465066"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 22:32:23 -0700
X-CSE-ConnectionGUID: 5FyCjXUQQY2zJJxclxHnuw==
X-CSE-MsgGUID: 4DdRtYD0TvK3eIsp+yhRmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="73205793"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa007.fm.intel.com with ESMTP; 30 Sep 2024 22:32:23 -0700
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
Subject: [PATCH v10 1/7] mm: Define obj_cgroup_get() if CONFIG_MEMCG is not defined.
Date: Mon, 30 Sep 2024 22:32:16 -0700
Message-Id: <20241001053222.6944-2-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20241001053222.6944-1-kanchana.p.sridhar@intel.com>
References: <20241001053222.6944-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This resolves an issue with obj_cgroup_get() not being defined if
CONFIG_MEMCG is not defined.

Before this patch, we would see build errors if obj_cgroup_get() is
called from code that is agnostic of CONFIG_MEMCG.

The zswap_store() changes for large folios in subsequent commits will
require the use of obj_cgroup_get() in zswap code that falls into this
category.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 34d2da05f2f1..15c2716f9aa3 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1282,6 +1282,10 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css)
 	return NULL;
 }
 
+static inline void obj_cgroup_get(struct obj_cgroup *objcg)
+{
+}
+
 static inline void obj_cgroup_put(struct obj_cgroup *objcg)
 {
 }
-- 
2.27.0


