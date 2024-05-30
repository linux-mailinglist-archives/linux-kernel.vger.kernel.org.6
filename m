Return-Path: <linux-kernel+bounces-195837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBB98D5288
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 21:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3662CB2465D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 19:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A053158A00;
	Thu, 30 May 2024 19:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YbaAp5so"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BFC158A0D;
	Thu, 30 May 2024 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717098253; cv=none; b=XIM3vk6gSFctYVJD9VcLk3zFSQXvTCFyi6rjk7o4IG5P6fG67rCHgOR0lhIYYf6+xO/BL0GjaGz6NELKLIZPt8xsLvzQob0n01On16qClQ9VLNUJEtC6p8JlgnFn+yLDfsjei0hFhHSFQw5qLgVmZx65mP/2TJ/JCnqgXhye7FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717098253; c=relaxed/simple;
	bh=Swv+nuFCro+i5I34h3+DF1nKDezzVeomXVrOHHcYQts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gE7d842XP7ePbedXdrYbDHaoOfyeDH5o5bYPt8ktfPFSn1BKg3mVXbOXQT9nhmZwGdqVMKOqkKtWjZzhRbaa3+d88MOs+Pvi1NYaBxH5ur24YFSu/hB6pmPZwCLDtl/wk/PxSxeY4FVhVLqo6KtQ6T30yZvshXEvcqCwDFDMOP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YbaAp5so; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717098249; x=1748634249;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Swv+nuFCro+i5I34h3+DF1nKDezzVeomXVrOHHcYQts=;
  b=YbaAp5so237r19NgQ4XoeNejVu0BJm5Si0cw3P0L68NpFQ2/dfQih/Z1
   6YHpLPfMeRnLX4XNuxZ/6MGEpLOSGrWjK1ZNyP+ajgy1qvBNeUAGZuK26
   1NwRs01lGYXJsTAmrYHdbDmQ+zcZ+fsqX+cE0nFzSwlSLKBgsChAOYtNI
   s6Pj6EZ+xhzFdHuYxKT6T4CpVCRx5f80kDKDbwQ6brh3K3sjOCs7o1W25
   ssDCVEbGBhkNiyCw/5a+1zhjAyUTxY6JH5ZYMTB14AMl95Jk4faivTBF7
   y/CB9ayw3MA5Yw04ZzZMyzHh/dKAEJCjApjt2MSXbo8kpUihx7AOAB+3P
   g==;
X-CSE-ConnectionGUID: Df67wi9iTTqt2bHbB14K/g==
X-CSE-MsgGUID: PrnINVKETy+VJyQ5++Kf9A==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="31144002"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="31144002"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 12:44:09 -0700
X-CSE-ConnectionGUID: iRRt9hkMRJmIPl5TPnGpjA==
X-CSE-MsgGUID: yD599GxkQzaoqyI/8Q2KmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="36027635"
Received: from chang-linux-3.sc.intel.com ([172.25.66.177])
  by orviesa009.jf.intel.com with ESMTP; 30 May 2024 12:44:09 -0700
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
Subject: [PATCH v3 3/3] platform/x86/intel/ifs: Initialize FPU states for the scan test
Date: Thu, 30 May 2024 12:27:39 -0700
Message-Id: <20240530192739.172566-4-chang.seok.bae@intel.com>
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

The In-Field Scan process aborts if AMX state is not in initialized
state. Use fpu_reset_fpregs() to ensure AMX state is initialized before
entering the rendezvous loop.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Tested-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
V2 -> V3: Use fpu_reset_user_fpregs().
	  Thanks to everyone who provided tags on previous versions. Due
	  to the code change, I felt it necessary to revoke them, but the
	  high-level logic remains the same.

V1 -> V2: Revised the changelog (Ashok), added a space to the code comment
	  (Ilpo), and included the header file explicitly (0-day).
---
 drivers/platform/x86/intel/ifs/ifs.h     | 1 +
 drivers/platform/x86/intel/ifs/runtest.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 56b9f3e3cf76..5e7ba94b4054 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -129,6 +129,7 @@
  */
 #include <linux/device.h>
 #include <linux/miscdevice.h>
+#include <asm/fpu/api.h>
 
 #define MSR_ARRAY_BIST				0x00000105
 #define MSR_COPY_SCAN_HASHES			0x000002c2
diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index 282e4bfe30da..68e128ea57ed 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -191,6 +191,10 @@ static int doscan(void *data)
 	/* Only the first logical CPU on a core reports result */
 	first = cpumask_first(cpu_smt_mask(cpu));
 
+	/* Prepare FPU state before entering the rendezvous loop */
+	kernel_fpu_begin();
+	fpu_reset_fpregs();
+
 	wait_for_sibling_cpu(&scan_cpus_in, NSEC_PER_SEC);
 
 	/*
@@ -202,6 +206,9 @@ static int doscan(void *data)
 	 * are processed in a single pass) before it retires.
 	 */
 	wrmsrl(MSR_ACTIVATE_SCAN, params->activate->data);
+
+	kernel_fpu_end();
+
 	rdmsrl(MSR_SCAN_STATUS, status.data);
 
 	trace_ifs_status(ifsd->cur_batch, start, stop, status.data);
-- 
2.34.1


