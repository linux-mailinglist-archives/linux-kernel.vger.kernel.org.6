Return-Path: <linux-kernel+bounces-441632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9E19ED0F3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4749828F566
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4561DA622;
	Wed, 11 Dec 2024 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kRLamtuY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A4D1D63CA
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933567; cv=none; b=Cw9b016OeDosfdURhClp9kcavb5XQAAh2zdbilZ0mtsr0evTsohzL7HHIlelkyFISLcsUTFfZAwT9GNWg7/MoPVA/FxmkUuH4QG2gIlaKJlDkQ/ZjQVLX74eU4oMA6jULwd+h+K/h1ImnQa00y9zkbpNiOiBiGsjWXi6z6knLz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933567; c=relaxed/simple;
	bh=9Jo/QG5uCHIhBbOHzVrrtX8I9RxfyI5PLb6JOEaIJVM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HSvH+63qldK5lYUCVOJ8RELQesUEl8b/yU++0VASLRxKz6UzBaQd/h4yHdsYOvdd2z1gpMAb8ZuaMwtWB+xpQ9/gSKHCfONS/vVbf7aVL1cyLEL0JKMmuS4jhhIVN1EM+58xo2Nn2Sdh274lZSxqzpi1ELVpdOquSNML/I33fJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kRLamtuY; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733933566; x=1765469566;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9Jo/QG5uCHIhBbOHzVrrtX8I9RxfyI5PLb6JOEaIJVM=;
  b=kRLamtuY5oNFXHsi2390/Med1YTcNkxw5OX8UUH7pMvGypf/r3egmP/4
   T5ugPC4vIG0Ylq/ecDUGhRlw7UKEvRQeaMSDB3hyCprnrN+/ORpinfGHz
   MtJodHn3yUFZs4ma2fn1fNzBsU7s0iI1h08ZrwBadAU6rRngq3TXKSusw
   TqtAdi9BBIgc28VXHBzN/wkQ7RL3V/L/iDmylXkwGM5R+X6leFvEhinAY
   keZ3C56lWV3TMqYna2qSG73UezEqTPnlXKUwdU3eEQQcUZ9aCXBmW82gx
   7VHmrGXl/ZbOlGmtH75UH4x0gkWdLZffo/o7rB5NG2cHix3cf6tEQdK1k
   Q==;
X-CSE-ConnectionGUID: BM3NZjQKQiSEctg24qCwhw==
X-CSE-MsgGUID: qs/GVY7bSvqjtcHE45idZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="33639210"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="33639210"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 08:12:45 -0800
X-CSE-ConnectionGUID: b2HILBxBQSupaQTZek4XlA==
X-CSE-MsgGUID: MbAzxJ4RT0yPdhuNapVvOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="96054445"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa008.fm.intel.com with ESMTP; 11 Dec 2024 08:11:13 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	linux-kernel@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/intel/uncore: Add Clearwater Forest support
Date: Wed, 11 Dec 2024 08:11:46 -0800
Message-Id: <20241211161146.235253-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

From the perspective of the uncore PMU, the Clearwater Forest is the
same as the previous Sierra Forest. The only difference is the event
list, which will be supported in the perf tool later.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index d98fac567684..e7aba7349231 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1910,6 +1910,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,	&adl_uncore_init),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X,	&gnr_uncore_init),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,	&gnr_uncore_init),
+	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X,	&gnr_uncore_init),
 	{},
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_uncore_match);
-- 
2.38.1


