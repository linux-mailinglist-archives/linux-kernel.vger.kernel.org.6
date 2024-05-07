Return-Path: <linux-kernel+bounces-172546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EDA8BF357
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293AE1F24AF1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E50F101E3;
	Wed,  8 May 2024 00:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d9q9iekI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468B2DDD2;
	Wed,  8 May 2024 00:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715127002; cv=none; b=aDq0bGQrBV2SAHHn+hLk+4Xdd7qd5540jRAUtrEq68ehe479tuqMyd4VBptCZHTuyXbODa/yNrdVcplx35EWurvl2MwF4MrzxqSfuZ9joZJIRqRCMAG6fdg6r8Z8B0EMVZn6JTpUPrj/Qb60fwsqzfOBLt8nOONKwOlpK57nqyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715127002; c=relaxed/simple;
	bh=pchJQwMeuUa0o3tBMgXDteU0jYMBM/uBpyKmx6EjaS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NCpCHZHZf/K7mVKFtmtbPaZSwsBS3LMSDQjV32Tmzluw4i8IvylJKIGIHKLmb36TGa/BJS51alLvg3cvkWVYWLfY+dOezLz2tI72vpuJ5RlUIV3wmYrKOBfmZpfHGblGC2i7yat4KbJSs+TIEcUAaiUn35d2rbdYSuYf4KOEQ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d9q9iekI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715127001; x=1746663001;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pchJQwMeuUa0o3tBMgXDteU0jYMBM/uBpyKmx6EjaS8=;
  b=d9q9iekIJGnnLZ2MUQG7s3PQKVTCe1mHg65MeToc0zeniFMwYLBSulR5
   Ngr1SH4zdxEc5OMEmOR6RoWBK0mLzmb3SqaYdLFezE/eUWgBBzohdlfCD
   Q5OkcQSie0xWliF5gAbb7suskiiFpaJJE0WUQJKuzxm3tCypv1+WYs46J
   T5IlATeDABUcSYDCFA9reUZ5oVV9m09hGY4E4iT3OhT8y8IiGbAZan5Lk
   jJHXBLuX+ycPt13siBDiwxOQQOgIC/TUMPmxVkKCWIfnuN9v/hqBcjCFV
   wObz25SPAYipamZu+Ote6khVL4MBaajoIhWNxXjwg2dqugLyLa/Qv+3z8
   w==;
X-CSE-ConnectionGUID: Bm0tcxaQQxaAl5totk9p/Q==
X-CSE-MsgGUID: lynrChNpSBa/IXuEDwV+hg==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10898757"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="10898757"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 17:10:01 -0700
X-CSE-ConnectionGUID: L6gDmP1JQ1ebyp6Y2tc8eA==
X-CSE-MsgGUID: G9VE80+jQgu79JyboCs2sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="29108952"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orviesa006.jf.intel.com with ESMTP; 07 May 2024 17:10:01 -0700
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
	chang.seok.bae@intel.com
Subject: [PATCH v2 2/2] platform/x86/intel/ifs: Initialize AMX state for the scan test
Date: Tue,  7 May 2024 16:53:44 -0700
Message-Id: <20240507235344.249103-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507235344.249103-1-chang.seok.bae@intel.com>
References: <20240430212508.105117-1-chang.seok.bae@intel.com>
 <20240507235344.249103-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In-Field Scan aborts if AMX state is not in initialized state. Use
kernel_fpu_begin_mask(KFPU_AMX) to ensure AMX state is initialized.

Introduce custom FPU handling wrappers to ensure compliance with the
established FPU API semantics. This change follows the EFI case from
commit b0dc553cfc9d ("x86/fpu: Make the EFI FPU calling convention
explicit").

Then, use these wrappers to surround the MSR_ACTIVATE_SCAN write to
minimize the critical section. To prevent unnecessary delays, invoke
ifs_fpu_begin() before entering the rendezvous loop.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Jithu Joseph <jithu.joseph@intel.com>
Tested-by: Jithu Joseph <jithu.joseph@intel.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
---
V1 -> V2: Massage the changelog (Ashok), add a space to the code comment
          (Ilpo), and include the header file explicitly (0-day).
---
 drivers/platform/x86/intel/ifs/ifs.h     | 15 +++++++++++++++
 drivers/platform/x86/intel/ifs/runtest.c |  6 ++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 56b9f3e3cf76..a2ec0dab809b 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -129,6 +129,7 @@
  */
 #include <linux/device.h>
 #include <linux/miscdevice.h>
+#include <asm/fpu/api.h>
 
 #define MSR_ARRAY_BIST				0x00000105
 #define MSR_COPY_SCAN_HASHES			0x000002c2
@@ -325,4 +326,18 @@ int do_core_test(int cpu, struct device *dev);
 extern struct attribute *plat_ifs_attrs[];
 extern struct attribute *plat_ifs_array_attrs[];
 
+static inline void ifs_fpu_begin(void)
+{
+	/*
+	 * The AMX state must be initialized prior to executing In-Field
+	 * Scan tests, according to Intel SDM.
+	 */
+	kernel_fpu_begin_mask(KFPU_AMX);
+}
+
+static inline void ifs_fpu_end(void)
+{
+	kernel_fpu_end();
+}
+
 #endif
diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index 95b4b71fab53..ca2b496a6b01 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -188,6 +188,9 @@ static int doscan(void *data)
 	/* Only the first logical CPU on a core reports result */
 	first = cpumask_first(cpu_smt_mask(cpu));
 
+	/* Prepare FPU state before entering the rendezvous loop */
+	ifs_fpu_begin();
+
 	wait_for_sibling_cpu(&scan_cpus_in, NSEC_PER_SEC);
 
 	/*
@@ -199,6 +202,9 @@ static int doscan(void *data)
 	 * are processed in a single pass) before it retires.
 	 */
 	wrmsrl(MSR_ACTIVATE_SCAN, params->activate->data);
+
+	ifs_fpu_end();
+
 	rdmsrl(MSR_SCAN_STATUS, status.data);
 
 	trace_ifs_status(ifsd->cur_batch, start, stop, status.data);
-- 
2.34.1


