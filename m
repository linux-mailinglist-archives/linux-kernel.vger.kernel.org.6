Return-Path: <linux-kernel+bounces-195835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 998088D527D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 21:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7FA1C23E77
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 19:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB91158A14;
	Thu, 30 May 2024 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RDxI+qfb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8011581E6;
	Thu, 30 May 2024 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717098248; cv=none; b=OU6wcZCtE/h15Wrvl4njNA560ILBxqmbz1V/TnAdCrYjyVcswJTZPc5upFys9DVZw48xidlmVzuBS/i2t7Z9jmevNy+lfVhVhqY9O0zYbxSdYydCL1TS/YgCWN1b8V+N++Kj8zzFA/EC9R8cbqPiBq9BMoEi50SMJGkRB+gZ8Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717098248; c=relaxed/simple;
	bh=CnFfuT0jo0I1WjsR5p2mZIX46ezAkhpyqYpDYsd/kAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DXM0YcPhG42hlvv4NouJ7ilhwhRzKp6SCjNd2IlMXyHHF0wYZ1/y3SdABAndWWAbQMQFTizj0Ctl03bwSZ/cxlHfpxPWTLRWIm7DR0R60fJnKHS1H7CD5FE9M9vtdH2Gqnh0afAT4djD3TCvplWmOy83E3aWHCE7+07v/CYdGd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RDxI+qfb; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717098247; x=1748634247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CnFfuT0jo0I1WjsR5p2mZIX46ezAkhpyqYpDYsd/kAs=;
  b=RDxI+qfb1A/bLnDjAQPAsz1pYqB9Q+eMcHTnJicx+ceiSzOV4qTs84Kb
   iWTVnJhrVhlzlgnM+T+O2eNlqghONJvlSRFEIOEWLdWg36AX6+KPAmSru
   hxm6U4r18vnI4sJPKq1Ie64XKCIrUZBUJ4+/jURmo34aaLwZQ0MjzvMJs
   2Xust8N4ZH+nKQwzY4eS/3wm93b1CP8jcByh1LHGQ0Hq0NbbyD1Gh4NeA
   qgxpwIfVV/8TGEIJaX2Rbfz8jUojbAVQnra+bFO/X83n2tpF4etCI9LGE
   7sKqUXuQdOgIdz+GOEYBqRgBmqmYYzOWt8jcLCjjLCCHXIDX2ofpyGlrf
   Q==;
X-CSE-ConnectionGUID: fiwPgeySQOygrb9r82/YOA==
X-CSE-MsgGUID: ITTbUd/KTiOBVU9uy97bgQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="31143991"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="31143991"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 12:44:06 -0700
X-CSE-ConnectionGUID: zrMYwOzdQi26eBxHzSQIRQ==
X-CSE-MsgGUID: ZF0bPGayRrKFF54U7vRZNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="36027622"
Received: from chang-linux-3.sc.intel.com ([172.25.66.177])
  by orviesa009.jf.intel.com with ESMTP; 30 May 2024 12:44:07 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	platform-driver-x86@vger.kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	tony.luck@intel.com,
	ashok.raj@intel.com,
	jithu.joseph@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v3 1/3] x86/fpu: Rename fpu_reset_fpregs() to fpu_reset_fpstate_regs()
Date: Thu, 30 May 2024 12:27:37 -0700
Message-Id: <20240530192739.172566-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530192739.172566-1-chang.seok.bae@intel.com>
References: <20240530192739.172566-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The term 'fpregs' typically refers to FPU registers. The function copies
init values to the task's memory image, not hardware registers. Rename it
to reflect what it does.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V2 -> V3: New patch to avoids conflict with the upcoming new wrapper.
---
 arch/x86/kernel/fpu/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 1209c7aebb21..2e6f43dfe98b 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -709,7 +709,7 @@ static inline void restore_fpregs_from_init_fpstate(u64 features_mask)
 /*
  * Reset current->fpu memory state to the init values.
  */
-static void fpu_reset_fpregs(void)
+static void fpu_reset_fpstate_regs(void)
 {
 	struct fpu *fpu = &current->thread.fpu;
 
@@ -744,7 +744,7 @@ void fpu__clear_user_states(struct fpu *fpu)
 
 	fpregs_lock();
 	if (!cpu_feature_enabled(X86_FEATURE_FPU)) {
-		fpu_reset_fpregs();
+		fpu_reset_fpstate_regs();
 		fpregs_unlock();
 		return;
 	}
@@ -774,7 +774,7 @@ void fpu__clear_user_states(struct fpu *fpu)
 void fpu_flush_thread(void)
 {
 	fpstate_reset(&current->thread.fpu);
-	fpu_reset_fpregs();
+	fpu_reset_fpstate_regs();
 }
 /*
  * Load FPU context before returning to userspace.
-- 
2.34.1


