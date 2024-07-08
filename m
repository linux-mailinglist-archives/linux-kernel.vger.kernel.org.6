Return-Path: <linux-kernel+bounces-244289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F6692A23C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249A51F260E6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC85811F7;
	Mon,  8 Jul 2024 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fQomGTbz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC5780626
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440239; cv=none; b=Dd0X2/701c8fkNDACxcD0d5v+4jUKFVeI0vR94DkyvMASrNUVeGrh9XAU6jibmWrv9H/jv42/wRtPT5swN9F/zqF6PWQd86GtzkW93u4eDr5e3rFxogGGfirBKZBEyDsLvfG3tnCiSSD9j0SZaHPxziodHcJS7nmef5zCE38uj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440239; c=relaxed/simple;
	bh=DzHQZuuhc4rbXcFPPwG2NkNbtLfqLVHjk1sLEJXrM2M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pn9eZ1OSR+0GSphHd48bNvJY9l65gez8Rzszhgo0UoX2NQngZWNQ9hPITNpwy0eZ6HGLrUmngzgh6oPmH/LhGUP3RXiSMim6WNcxGNPMVfNxmmRCKUdAXQQh7h4x6KF5RBmbMLcEKIlyhC4Dwy5M20Cbg49vR2c1Gqcu8ACkZHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fQomGTbz; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720440238; x=1751976238;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DzHQZuuhc4rbXcFPPwG2NkNbtLfqLVHjk1sLEJXrM2M=;
  b=fQomGTbz/x0iE+s5XcbQVN1/AuVWPLHLdicLP5Dk5wXHLElzBr62+5ja
   Zmm6ud+HjMclp56jQoTq97O8Hwr80KvJo3jwGcJVumoUQJ+Slnh6flSHH
   2Kwfym40a6N5jZHPeDiqowsTf1ZQ//LBGIWbv3R1gY1joHNTOIfaqeZtH
   gzDXaEBbao7OVHlrkjmWeVn+94zE/0cCc2c8U+mjWoJ144aNZIpn8iIA+
   GWyHIKPhbMYNZiOV/gqcB9bYNKdA/d0n7uzyjlvsvUbAOfXKpwdadxvOu
   UHCZGOpcq9vZErKIKchPdD5wS9ej+WvpMyHAif8S0kbtw4pmzQEIG2CLJ
   w==;
X-CSE-ConnectionGUID: cLt0pzlyQYStuCEQmv90Ng==
X-CSE-MsgGUID: M7jIEl/HT26BK0CzU5D98A==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="17842459"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="17842459"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 05:03:57 -0700
X-CSE-ConnectionGUID: UB7G25qvSoWG4bPE4Ifmqg==
X-CSE-MsgGUID: xjv/NurHSLi0I06QFYnJZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="85034005"
Received: from unknown (HELO xiao-desktop.sh.intel.com) ([10.239.159.85])
  by orviesa001.jf.intel.com with ESMTP; 08 Jul 2024 05:03:55 -0700
From: Xiao Wang <xiao.w.wang@intel.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	atishp@atishpatra.org
Cc: anup@brainfault.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xiao Wang <xiao.w.wang@intel.com>
Subject: [PATCH] drivers/perf: riscv: Remove redundant macro check
Date: Mon,  8 Jul 2024 20:12:24 +0800
Message-Id: <20240708121224.1148154-1-xiao.w.wang@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macro CONFIG_RISCV_PMU must have been defined when riscv_pmu.c gets
compiled, so this patch removes the redundant check.

Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
---
 drivers/perf/riscv_pmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
index 0a02e85a8951..7644147d50b4 100644
--- a/drivers/perf/riscv_pmu.c
+++ b/drivers/perf/riscv_pmu.c
@@ -39,7 +39,6 @@ void arch_perf_update_userpage(struct perf_event *event,
 	userpg->cap_user_time_short = 0;
 	userpg->cap_user_rdpmc = riscv_perf_user_access(event);
 
-#ifdef CONFIG_RISCV_PMU
 	/*
 	 * The counters are 64-bit but the priv spec doesn't mandate all the
 	 * bits to be implemented: that's why, counter width can vary based on
@@ -47,7 +46,6 @@ void arch_perf_update_userpage(struct perf_event *event,
 	 */
 	if (userpg->cap_user_rdpmc)
 		userpg->pmc_width = to_riscv_pmu(event->pmu)->ctr_get_width(event->hw.idx) + 1;
-#endif
 
 	do {
 		rd = sched_clock_read_begin(&seq);
-- 
2.25.1


