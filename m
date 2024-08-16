Return-Path: <linux-kernel+bounces-289017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C332B954151
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48127B23301
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 05:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD3D8248C;
	Fri, 16 Aug 2024 05:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QyDlOuVn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA187DA96
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723787291; cv=none; b=VLIGBPuG3teTf38ZHOWnDJl+bhnjGhyenvtKd9v3Hd5Elz+GC/hNu+5QtSa44Sm8RNQSBN8pKYmTSJr23gEYlzkY1ZkPfUcgqiGMh88v4EZDCK61jXTrbSTIAK0WYOQOlHeqoXLuaObFbBAR753XSq8BeeUHAVxLV9b/MMC3AME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723787291; c=relaxed/simple;
	bh=Rhd+o6cIvQZsonqH5BjtpwXRBNEn4sYl6ZxLr6ObqFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PwyTstmgPl9MN2HheZFJ9Gm3xmduy39HLtjUX4mBWfHIHhp5vFm5PT1aBZBC9HXXulMgVFliB/AtNHpwWtWeyb3dkxVaHeCqwIV+J6nYPWf65oJLJwjZA7Q1kRyL8/mu7RI3FeQe7yCIZPHH4gDca563TM/R/09kEhenNcUH328=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QyDlOuVn; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723787290; x=1755323290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rhd+o6cIvQZsonqH5BjtpwXRBNEn4sYl6ZxLr6ObqFU=;
  b=QyDlOuVnexha2xlo9Jiym5jvjCEtsOTL+wF5PrykUlX39gU6Nh/qpCho
   RIc8TGme9WsHH5xE3uQerKTImIk0Lnl7wIQ8sI5KEs0LDuLo+FJLTb7ul
   LCrg/7DNqeTP8eaKLrdLvOwg8lYyvW6fkUMOOj1iX82iorMca18ohQDIT
   iLn84zkVauyFdBbKEFFJL8bvy3iGioWt0/KRDgkSq0xMBorI86piPLGiJ
   kO/PrY8iaORd/m/O872rC7+GWfSKFprAiV7etW3uXpI6+PpTiTihbFbUP
   Rjt2UWB5RHql9pdtJOyo1Xcsq8Gfo9RXLzzGE8IxHtat06IhKaOU4d2GW
   g==;
X-CSE-ConnectionGUID: Pw8QB3S4RpCjgrRC+iA2WQ==
X-CSE-MsgGUID: vJmeeCzhTc+L5N+lbWvGdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="32648125"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="32648125"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 22:48:07 -0700
X-CSE-ConnectionGUID: QU3cm6lVSTygm9MQstxIWw==
X-CSE-MsgGUID: 2AV6aJjrTpmXJ/AXuljOAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="59415339"
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
Subject: [PATCH v2 3/4] mm: Add MTHP_STAT_ZSWPOUT to sysfs per-order mthp stats.
Date: Thu, 15 Aug 2024 22:48:04 -0700
Message-Id: <20240816054805.5201-4-kanchana.p.sridhar@intel.com>
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

Add a new MTHP_STAT_ZSWPOUT entry to the sysfs mTHP stats so that
per-order mTHP folio ZSWAP stores can be accounted.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 include/linux/huge_mm.h | 1 +
 mm/huge_memory.c        | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e25d9ebfdf89..44609d84f2dd 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -273,6 +273,7 @@ enum mthp_stat_item {
 	MTHP_STAT_ANON_FAULT_ALLOC,
 	MTHP_STAT_ANON_FAULT_FALLBACK,
 	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
+	MTHP_STAT_ZSWPOUT,
 	MTHP_STAT_SWPOUT,
 	MTHP_STAT_SWPOUT_FALLBACK,
 	MTHP_STAT_SHMEM_ALLOC,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f4be468e06a4..7e97b6ed6ff1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -574,6 +574,7 @@ static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
 DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
+DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
 DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
 DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
 DEFINE_MTHP_STAT_ATTR(shmem_alloc, MTHP_STAT_SHMEM_ALLOC);
@@ -587,6 +588,7 @@ static struct attribute *stats_attrs[] = {
 	&anon_fault_alloc_attr.attr,
 	&anon_fault_fallback_attr.attr,
 	&anon_fault_fallback_charge_attr.attr,
+	&zswpout_attr.attr,
 	&swpout_attr.attr,
 	&swpout_fallback_attr.attr,
 	&shmem_alloc_attr.attr,
-- 
2.27.0


