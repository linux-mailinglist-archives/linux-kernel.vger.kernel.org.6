Return-Path: <linux-kernel+bounces-344911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B85AE98AFA7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632D4282990
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A29188704;
	Mon, 30 Sep 2024 22:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SPKfFx7b"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502F1187878
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 22:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727734346; cv=none; b=ibNiavbBYe6xBDABidRrMMvWlZ1IcXT2TFcJ8VH2FsiAVBZhRrNf9HYimt3WGXcKYQTJN0D4gxKM5qJbUHcsrMGtoyoHB6TYAkibKU2NNMC7FYGFO8w7pAa6LjndcnV8mLNlNbBp7E788ZnGAzP4BMIrBDuA6pquKhtMVL7L7PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727734346; c=relaxed/simple;
	bh=HXPnxaS0BG2kkNkoIrCoeh8TspMXuNCwKniqdIZtWWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aZ5SBdz1JtjgWfd279Rv0I/fJKG2dCYcybRVXHih43bPn2wYCf3ReWCtEkc+QbSMWyW53ZyiMnAdHiaFLP/WFYWPRNKoM1dYfz3pHxJEWqlu2AGb5UB/CvHXIa5CX+Pc9aX/EblmmeoqS5TNgugXOlj0bPZtV7mFssfEQO2J/qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SPKfFx7b; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727734345; x=1759270345;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HXPnxaS0BG2kkNkoIrCoeh8TspMXuNCwKniqdIZtWWM=;
  b=SPKfFx7bQmlYTAvz9vXx9PUhzJGigtUF9sWMnGIovKfAmfMu9TSMHKTj
   YXtd3JBzllNFvX3nbjKW2V43CZmAcoy/vlXtbdbtemvdif5nMYARy+2/9
   Xl9Ygv6tgOnllj2/pilrxlyUUSJQc7sgkd/NmAVkXVU0EdWyk7AsQNabv
   V0thVZ3Xx7NCYaiDbyLkGUhNnLG1z3grvvRIfpzqt+lKJdxmIWSf7jxcn
   W2p28a1WgR/KPcg7gZPqwlGmKTH7lkas2aNQRxGXZxvmgQiziy3qUVceW
   sDsmdAMeKVTlhN2as6pJCyewQJUIL+WnWireXZagVfEmvPYsRn13fdNmx
   Q==;
X-CSE-ConnectionGUID: cUv7HwuwSn+L7MsRKYADNg==
X-CSE-MsgGUID: kJiFaD3cS8KSjAwlQ9/l4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="49368396"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="49368396"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 15:12:23 -0700
X-CSE-ConnectionGUID: W5E0QIJeR6SpPmgGvxsiuw==
X-CSE-MsgGUID: myhOnlK6SsqNUZ7J0In4fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="77985572"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa004.fm.intel.com with ESMTP; 30 Sep 2024 15:12:22 -0700
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
Subject: [PATCH v9 1/7] mm: Define obj_cgroup_get() if CONFIG_MEMCG is not defined.
Date: Mon, 30 Sep 2024 15:12:15 -0700
Message-Id: <20240930221221.6981-2-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240930221221.6981-1-kanchana.p.sridhar@intel.com>
References: <20240930221221.6981-1-kanchana.p.sridhar@intel.com>
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


