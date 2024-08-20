Return-Path: <linux-kernel+bounces-294531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D77958ED2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 21:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3506284DCC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13D814D70E;
	Tue, 20 Aug 2024 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LlEUG8oB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D18159565
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724183408; cv=none; b=J8qrX7iErst17ooQVTPU8xYWhH3iBTcRH/TuX+TzbvsnrIOiNNSqQ6k64aP5LixzA/fGazDUiqyQ+LXqHDtH2dnEBBCRyrv4STU59xJEEJVdmszwdDpa/9iUhp3PFekQQ5TmMIzLs+wgG4vDIX7WoujC8AEUVHdnxjEiCYDvSoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724183408; c=relaxed/simple;
	bh=NR4mV13RpbYtBfGerxGaqEI3TdJr09SWWzNHh5/rsmo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VenOuzPmoWnsD9zx9oa92ktHVzTrF83fpM7maURUNfWZu9H6Cr8H2EibG/a0541R3fUUEpe8eR2FYfFh+9y0l99bXd8A5ydy07KyFMQ6+tXi4mCoWYyghEmO314qymaSBB7WzLWfAP258Yh86O4XEIqXtiJxjYsJWAXLtUhqql0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LlEUG8oB; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724183406; x=1755719406;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NR4mV13RpbYtBfGerxGaqEI3TdJr09SWWzNHh5/rsmo=;
  b=LlEUG8oBD4hEjav3FkjzMd0Ii8ct8XQ1wCN9hClFp7W4PIExt/miHnXn
   wdJOXWDwuiYTwam7tCR0bYRL7Tc+E7BDZec7YzFqde1rKH369O2MXTlT1
   +xN2PBGCr33kg5cNQXYQ0+odVxE5YfR8xSMoY+O3umIAvZ0RA48xbEuOf
   FZi0ivYya7FnjWIfyCJ0dvNLqnl9R660QSvX1llXS0JPkp05SK0XDK5/s
   YyvSMhkKV6Ya9xUUW6xjBkxgwYisIwk2dueoyAKejeCLhpKViFw/wqtbv
   1E4enjyrqss63Irk2OUnjIndBsYsh38pJCQgphJqcs6C19YF1ru554oBk
   w==;
X-CSE-ConnectionGUID: hodsjWUmTyezgacUmP1STQ==
X-CSE-MsgGUID: jYGLPwshRee0oFFpXQ7yPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="45035600"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="45035600"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 12:50:05 -0700
X-CSE-ConnectionGUID: mACcrAWWQleDqbgJXDNrDw==
X-CSE-MsgGUID: /4+TsTFhQG62uu2nFdW1Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="91620355"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa001.fm.intel.com with ESMTP; 20 Aug 2024 12:50:05 -0700
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
Subject: [PATCH v1] mm: Defines obj_cgroup_get() if CONFIG_MEMCG is not defined.
Date: Tue, 20 Aug 2024 12:50:05 -0700
Message-Id: <20240820195005.5941-1-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This resolves an issue with obj_cgroup_get() not being defined
if CONFIG_MEMCG is not defined. This causes build errors if
obj_cgroup_get() is called from code that is agnostic of CONFIG_MEMCG.

The patch resolves this.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 include/linux/memcontrol.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index fe05fdb92779..f693d254ab2a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1281,6 +1281,10 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css)
 	return NULL;
 }
 
+static inline void obj_cgroup_get(struct obj_cgroup *objcg)
+{
+}
+
 static inline void obj_cgroup_put(struct obj_cgroup *objcg)
 {
 }

base-commit: 7d0b0d4b77b368b2111fc8b4449e33dfb3c34087
-- 
2.27.0


