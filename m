Return-Path: <linux-kernel+bounces-342312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D37A988D82
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 04:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17FC31F22100
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 02:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6AC1B970;
	Sat, 28 Sep 2024 02:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i29WOvWa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26AA2FB6
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 02:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727489784; cv=none; b=EdOvoi4o9NFec/1yKOgVYiWjq25ui04TXDnLfcEIXHQY4nc/OUDu2gtFoaL2VR1lSLA/R8KN4eRf6P56zmvt8+L7Ty6rFPal7BU0fQM2M/SO3drjv7ri+LxA9Ya15a8ZkPOGa5cDoFpSFNEXF94JHhyuY7k/5/gmUIM+yp+WtDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727489784; c=relaxed/simple;
	bh=IbCXass7UYncWYJbpbqgopMF9OvpwOCCnOnS4dLfg9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nI0p9w+aKnuekyrl9K5hH5rYmRu9kRJSPt0HyNxUYGe+cce6afiHEX5tDTI7qp5dmKWp8m47mF5jTEhAqxi2fShrgzye0Rq05DAqYQAYkXIVJQeFMuJNyJhhyhScCk7FSocPv9dxAv5cdijBTdR3g1seIM8xi1UX50Igi9vMfTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i29WOvWa; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727489782; x=1759025782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IbCXass7UYncWYJbpbqgopMF9OvpwOCCnOnS4dLfg9g=;
  b=i29WOvWaY7ctZ5hkt2fqkB7TYORQUUNb/qxfD3CIr4arOMfsuK7o186h
   8XQEMoXFBsymLHLCxJP9XtC2xDAPXpJ1Wg+Vs2AG3Q1uBkbcwmS7DVJmY
   POze6vmN5Eye6zJeEMBlO2EsVML7FYxhNN0mBwO6LjZtCowCZL0V6CW+K
   DIUEHr+C6/vWvUIhHLfgb5szOO9kY+2gSlOviLMxJAvWDthDOKJwVnu7r
   1O032+Kg+7aPqgg9DMSiXkk0MrrOuO8BazUjD4IdgFQFGzBB4XOtXsqE3
   5Zkj2Lvi0TyrKaLfnTilaDjDW2n3a7du8+FGsp79+hIAePUwvygtnaPS1
   g==;
X-CSE-ConnectionGUID: 4NppqdQ4QU2DQAfQcqgnNg==
X-CSE-MsgGUID: PafqYNasQG+PV4C3NtFuyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11208"; a="29526863"
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="29526863"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 19:16:20 -0700
X-CSE-ConnectionGUID: 7MNZVH/3QTSILL+XMnuEgg==
X-CSE-MsgGUID: oL3sghaCRXW2zPSVQBV2gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="73507110"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa008.jf.intel.com with ESMTP; 27 Sep 2024 19:16:21 -0700
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
	akpm@linux-foundation.org
Cc: nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v8 1/8] mm: Define obj_cgroup_get() if CONFIG_MEMCG is not defined.
Date: Fri, 27 Sep 2024 19:16:13 -0700
Message-Id: <20240928021620.8369-2-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
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


