Return-Path: <linux-kernel+bounces-336432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCCD983AB7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 03:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF2E1C213DD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D15C1B85F4;
	Tue, 24 Sep 2024 01:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bkVO02xn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D40184E
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 01:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727140635; cv=none; b=tUZhqD1hPaD8dakS0xtFBRfp9NoHgdhNq5JTZHpgJYA48fbrNNYgwdtE3IkXUTZMkzHqsWybDdbRYumAVN4S6kYeWwqBeX1gzheKXzxB25YPHpT1FomlYnbdLBbTuASwlee5Duz6H4R6Vgdc53KhfbQxxglB+bFheBTpunUtzvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727140635; c=relaxed/simple;
	bh=j6MRHvvdb4Y/ecSm2gb8TOi+Txe+Ci0dZeAdkAYjrOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eb1eAxDGV4NavT6ze7kONrwpV+2WQ3hVORP8VBlAsmZvqyfG5swJJBjoYicPRJPYK5yC76dzVIm3Ei+6zHsUNX2UOZvAuC9OI7UCbt3m3YJSRI1ux0I8j1sCcORcEjaFzobLi1FzNnVsLU8ZaeJTuazrlO9pX52nh8zCgmxvNIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bkVO02xn; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727140634; x=1758676634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j6MRHvvdb4Y/ecSm2gb8TOi+Txe+Ci0dZeAdkAYjrOU=;
  b=bkVO02xnEKx4CKZa8XokIOwGGEOdu396tgEUmYpH8TnOJZrOYcNe3CzZ
   X4cfB4zIGWHU6hWGZXY98/wR8WIpvHqdUPkbpsYXxHbyv++yruG6Fx7fe
   p5QNqCjVzhes7Px0w8hV+LPM/zEGL2EWNOMDE3CUCOsFXIGOItuuSx37q
   C6qR4zYoKIpjYASbQ/LAXABw4/hksaChATfuc+HkOox+HSuyjgXGTTdd6
   qytcHpR2lLWAbK7BfFCOKwjzu6jik7xosZtuOqMotI/Se9x/WDKDdXhJ3
   Vm90jaJ08l9iO3VptpBSS7ijwWJ7k38WoQaQC2rA/xKjyPKgyrmEDrzlp
   A==;
X-CSE-ConnectionGUID: f8gFNQdLR3qyH+SAqaclHA==
X-CSE-MsgGUID: RDhfqr4YSKec2upX7LJ39w==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="30001998"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="30001998"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 18:17:10 -0700
X-CSE-ConnectionGUID: im59xWO4QgiDbIGKgbJwwQ==
X-CSE-MsgGUID: mRXKs5anS0CqWg+gbdX0Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="108688443"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa001.jf.intel.com with ESMTP; 23 Sep 2024 18:17:10 -0700
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
Subject: [PATCH v7 1/8] mm: Define obj_cgroup_get() if CONFIG_MEMCG is not defined.
Date: Mon, 23 Sep 2024 18:17:02 -0700
Message-Id: <20240924011709.7037-2-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
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

The zswap_store() changes for mTHP in subsequent commits will require
the use of obj_cgroup_get() in zswap code that falls into this category.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
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


