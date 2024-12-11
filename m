Return-Path: <linux-kernel+bounces-440612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEF69EC1B0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 02:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A4352855A4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 01:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAFD1494CC;
	Wed, 11 Dec 2024 01:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J1Hp6gUR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A640319E7FA
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 01:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733881345; cv=none; b=uTPbtVFxWD17hp9OwNurIksGgyqhBYszms3MBoKp5+m3j8pgz6Cp7PudGQ9yncfHYGgy/zHlOGr9KV8uhay2K9puYyBSFrquQN3XejX9/qJ69UHde00wHHGfUnKuN2J7DPmstBmuIgO8Y04UzrjZkaBr2gumXFEnmoztHIv9Bsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733881345; c=relaxed/simple;
	bh=pQLNMFgBZszcxF1RYEy13JuxWPbUR+E1BWpPlL6yIsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FsaDcoGTiEUGEm0terhlavYgnyXaaKwL/Yu1bWL1mBh/oVAHKH/2uAo2/8p6OXkjvUM6jlGC7UkabsSoNGUP/mDxC2M++WeMndCw28s2SAfTh4SJ33yVggL4b8kUX/h30orIMU3Zhw2Q2v59RFqcTnUxwhbk1wH9eUN8dF+EaPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1Hp6gUR; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733881343; x=1765417343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pQLNMFgBZszcxF1RYEy13JuxWPbUR+E1BWpPlL6yIsA=;
  b=J1Hp6gURzJb8LVOiZNSrMDoICRxEXdtVOvVen0IJjHul2wihsACg6vr/
   eRto/bDNMHq7E/qtsnc99zZEfYAc2cf7aHSIM7TGu3pNqz89wzYI1qZTR
   ZznOTsxwz8qlRjF9SLRK+Ku6go0KEAjm0Iq0XsqT/tuDAzceI3Ljfluqe
   Y+dbTtRQBEbZMHk9N86+qtCtsD5fltFrp6EseC+sRNOu/SIuPK9Py62Nk
   Q1YzxxFASgwms82Fu5URBR8wGbUPRz//1LsV0EyKajEL2lBJQGWfjKUmW
   F9t/XgWDKMYXsEk/oRC52NyQBf93fczIFDcsCSVnhCYTIilo1tcu6TZVx
   Q==;
X-CSE-ConnectionGUID: nx++8aM9SvOal/n/6xJKsw==
X-CSE-MsgGUID: xefCB3sTQqSKwbxk6AD95w==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="33570564"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="33570564"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 17:42:23 -0800
X-CSE-ConnectionGUID: VzMu8KGHSM2OYznC/aPpYw==
X-CSE-MsgGUID: xekvAPtXRuu7dW3Cf0FH8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96051776"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.134.127])
  by orviesa007.jf.intel.com with ESMTP; 10 Dec 2024 17:42:21 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH 6/6] x86/microcode/intel: Enable staging when available
Date: Tue, 10 Dec 2024 17:42:12 -0800
Message-ID: <20241211014213.3671-7-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211014213.3671-1-chang.seok.bae@intel.com>
References: <20241001161042.465584-1-chang.seok.bae@intel.com>
 <20241211014213.3671-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the staging code being ready, check the relevant MSRs and set the
feature chicken bit to allow staging to be invoked from the core
microcode update process.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
RFC-V1 -> V1: Massage the enabling message.
---
 arch/x86/kernel/cpu/microcode/intel.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 325068bb5524..c988b6f8672f 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -674,6 +674,18 @@ static __init void calc_llc_size_per_core(struct cpuinfo_x86 *c)
 	llc_size_per_core = (unsigned int)llc_size;
 }
 
+static __init bool staging_available(void)
+{
+	u64 val;
+
+	val = x86_read_arch_cap_msr();
+	if (!(val & ARCH_CAP_MCU_ENUM))
+		return false;
+
+	rdmsrl(MSR_IA32_MCU_ENUMERATION, val);
+	return !!(val & MCU_STAGING);
+}
+
 struct microcode_ops * __init init_intel_microcode(void)
 {
 	struct cpuinfo_x86 *c = &boot_cpu_data;
@@ -684,6 +696,11 @@ struct microcode_ops * __init init_intel_microcode(void)
 		return NULL;
 	}
 
+	if (staging_available()) {
+		microcode_intel_ops.use_staging = true;
+		pr_info("Enabled staging feature.\n");
+	}
+
 	calc_llc_size_per_core(c);
 
 	return &microcode_intel_ops;
-- 
2.45.2


