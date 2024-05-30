Return-Path: <linux-kernel+bounces-195838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 635678D5289
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 21:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E590B288A81
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 19:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7CF158A0C;
	Thu, 30 May 2024 19:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AM9WTvxc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3BF158A0B
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 19:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717098259; cv=none; b=AbxgZDpJXRI/9ncybbrslUT1HTSWKg0S0HvqCz2AM1qrZcnHht/KqumVBRb4hrBr5HZ4iqTvQDgj8jWS3U/vDWMv/H661mIJI4yMyTDaJW6Gil3MGvtL7xrJWTFLgKCI1k0Om2/AFd2K38zJAIgFwhWgFPwGxXXtfUce5yGjxZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717098259; c=relaxed/simple;
	bh=HCfDUAxXdMfPa6GQu7fR75LAp2+0LBtFMjZmCOS4nbo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=swrwJxqTEOXDCY59uzdavjMyP514uqF9f1TX6DJtwdTXCWoSb3DmvA9w+2VtObTul2BAn7aTsLWvEnNwdBah4ZZkf5lzVeuA4RZM6fFvzZW16hMwtV1nVCweb8zLRABv3oVcvn9i50PiNGA0pDt+6t7G/EX3fuTZgsRpba3fUy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AM9WTvxc; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717098258; x=1748634258;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HCfDUAxXdMfPa6GQu7fR75LAp2+0LBtFMjZmCOS4nbo=;
  b=AM9WTvxc1XN6X9/QvyMqcL9HnYcwQX7jL9/q3hIUzVwfzfV0bKKpZOuu
   KPVKOaIzDAQZzduC28mF85vZn1gfry+vzQ5flynfpuO6olBa0G+wkADty
   Zp8l8BsRWD8PLyGE8PaSJJkalMrXp4vDwetmzIchHdrC79KLrEGCdoK55
   MZvlWhWV/kaOs9ijmlHLLRggvKdf/MR6H7w/MGtlH8bs0xuFGnbt8o3kl
   xEH86Ea5C1IInchqb9MXvPMh+f2Tt8iRKYKzjJRY+SqJo77U9/Oay1E/m
   BCwWMMskatDWRutb1VR4Mo0KD+zpnGKOJB0nRMV+cPzi9IRTPDXtpqVdV
   w==;
X-CSE-ConnectionGUID: 9ZAfzdMEQKyZJfjx8pfCZw==
X-CSE-MsgGUID: qMQ1t5AlTo66bTc/zYsm7w==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="31144016"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="31144016"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 12:44:17 -0700
X-CSE-ConnectionGUID: vjClthhERF6NOFHBqbWS4A==
X-CSE-MsgGUID: //SRyu60QHeygzBPbDMJqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="36027654"
Received: from chang-linux-3.sc.intel.com ([172.25.66.177])
  by orviesa009.jf.intel.com with ESMTP; 30 May 2024 12:44:18 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH] x86/fpu: Remove export of mxcsr_feature_mask
Date: Thu, 30 May 2024 12:27:51 -0700
Message-Id: <20240530192751.172597-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable was previously referenced in KVM code but is no longer used.
Don't export it.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/kernel/fpu/init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 998a08f17e33..45d966492159 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -94,7 +94,6 @@ static void __init fpu__init_system_early_generic(void)
  * Boot time FPU feature detection code:
  */
 unsigned int mxcsr_feature_mask __ro_after_init = 0xffffffffu;
-EXPORT_SYMBOL_GPL(mxcsr_feature_mask);
 
 static void __init fpu__init_system_mxcsr(void)
 {
-- 
2.34.1


