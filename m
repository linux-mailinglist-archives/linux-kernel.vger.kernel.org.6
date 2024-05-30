Return-Path: <linux-kernel+bounces-195836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E108D5285
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 21:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6ADE287F3C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 19:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3785A158A30;
	Thu, 30 May 2024 19:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4GL/ZIb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0454F15887B;
	Thu, 30 May 2024 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717098249; cv=none; b=FnogIsEP6cImgMihNpr9y9ZOUQyDFqyQ9XtBffr5AFCNyVppJwAUqrmFkjR+R/0cG0QWunhkWFUxC2ZVWReYbNBxOIsMKmmUUUbsEaIokQgfubuW7wpu3AfsoPRr+92Mw7bmU1QPOm0S5qMlGasAcgwVcgEB4HCYW94i2ymn5dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717098249; c=relaxed/simple;
	bh=Ve5uS2VOqKr/0X4j3jr4Q5dfqnZMluXSSkgqpfK+d6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H75bIImaevGqTVGlFqnZnwHfjknSQU8o0NMhpennzz+v5xrzJS3R/gHbThqdf59CcAfC/zniXk4nOwr66uZy5PhO4/pWO8IvtnL4FlBSGj86B2m8D9jdXJcfmBCGS87KniVbYnELAVDtPkDwcgwO+LkV2VBTewBbrcq3wAq1u5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4GL/ZIb; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717098248; x=1748634248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ve5uS2VOqKr/0X4j3jr4Q5dfqnZMluXSSkgqpfK+d6A=;
  b=H4GL/ZIbm6om8zVuuV8YHreWX/Vl7V82sa4eLRyhWCQ0kPcOG37BCIGr
   QQQQ8YsgeobACalW/GtV1BMFMBHdnSJFvT2XvvAzMtZX8l80mdOH+C9Bh
   n/ODdiz/p4/Ug0kU9It79W3lIn8kFVUh1ophESb9JW6MV8S9dy3JuEkij
   X1FuOa8+KRalAMU34n2QyDjebNxs2ak4rdTwWx4bA1iTuVysp1RpmfGvd
   1fR/ujP7Q98PR/G+IUxocCCU4URk4TX0DO/IjonXwE5mYaC84VJ1Yj8Xl
   S13koN/3A1w6A5E98mwO/SwtYgNjsvlNFqqmQtev2ML55sn3AdnDjFLS4
   A==;
X-CSE-ConnectionGUID: 9enjT1ZERVCiigb7nI8XgQ==
X-CSE-MsgGUID: 7W78a4BqQ2CES9eLsWrNRQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="31143996"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="31143996"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 12:44:08 -0700
X-CSE-ConnectionGUID: 7HFhOa9MQuGNLDanNa1S9w==
X-CSE-MsgGUID: SnnBpiY6TZOnajvzZ13Gfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="36027628"
Received: from chang-linux-3.sc.intel.com ([172.25.66.177])
  by orviesa009.jf.intel.com with ESMTP; 30 May 2024 12:44:08 -0700
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
Subject: [PATCH v3 2/3] x86/fpu: Allow FPU users to initialize FPU state
Date: Thu, 30 May 2024 12:27:38 -0700
Message-Id: <20240530192739.172566-3-chang.seok.bae@intel.com>
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

The In-Field Scan (IFS) test [1] is a destructive process that overwrites
the existing state to test the logic on the fly. As part of this test,
the architectural state should be saved before the test begins and then
restored upon completion.

Unfortunately, AMX state is excluded from the scope of state recovery.
This exclusion prohibits the IFS process from supporting any software
context when running the test. The kernel generally runs with live user
FPU states, including AMX.

Provide fpu_reset_fpregs() for the IFS driver to reset FPU states, which
is much simpler than specifying state components and is affordable in the
non-critical path. This, along with kernel_fpu_begin(), can allow the IFS
test to proceed.

Alternatively, system administrators may attempt to mitigate this IFS
issue by arranging some workloads not to run on CPUs selected for the
tests. But, this approach is disruptive for managing large-scaled
systems.

[1]: https://docs.kernel.org/arch/x86/ifs.html
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V2 -> V3: Switch to a simpler solution and clarify the hardware
          problem (Dave Hansen).
V1 -> V2: Revise the changelog (Dave and Ashok)

The IFS Tech Paper [2] elaborates its purpose and the requirements of the
context restoration after the scan test. Additionally, the necessity for
AMX initialization is emphasized in the Intel Software Development Manual
as of March 2024, in Section 18.2 of Vol.1.

[2]: https://www.intel.com/content/www/us/en/content-details/822279/finding-faulty-components-in-a-live-fleet-environment.html
---
 arch/x86/include/asm/fpu/api.h |  2 ++
 arch/x86/kernel/fpu/core.c     | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index f86ad3335529..284304171003 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -179,4 +179,6 @@ extern long fpu_xstate_prctl(int option, unsigned long arg2);
 
 extern void fpu_idle_fpregs(void);
 
+extern void fpu_reset_fpregs(void);
+
 #endif /* _ASM_X86_FPU_API_H */
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 2e6f43dfe98b..51d7689147f4 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -915,3 +915,14 @@ noinstr void fpu_idle_fpregs(void)
 		__this_cpu_write(fpu_fpregs_owner_ctx, NULL);
 	}
 }
+
+/*
+ * Allow FPU users to initialize the entire user FPU register state. The
+ * caller must invoke kernel_fpu_begin() beforehand.
+ */
+void fpu_reset_fpregs(void)
+{
+	WARN_ON_FPU(!this_cpu_read(in_kernel_fpu));
+	restore_fpregs_from_fpstate(&init_fpstate, XFEATURE_MASK_USER_SUPPORTED);
+}
+EXPORT_SYMBOL_GPL(fpu_reset_fpregs);
-- 
2.34.1


