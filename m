Return-Path: <linux-kernel+bounces-346325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD81698C323
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF6B01C23BE9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB92F1CDFA4;
	Tue,  1 Oct 2024 16:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PW4zcG51"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6D91CCEF9
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727799067; cv=none; b=nlHusJkAYUw3ujLbWWep1q+BEDQpimF0Qf0K7t3jWauGPkJDX+jFI8eu9MwE2l99M4Gp4u2q3qMvXzKiEZ0TVBhETurdU7ck57uhpRNBbNKgCyOw2QQLtAH81mdMx/Vv2ziXzcVq9JSnRYH7mHA8q6e9fhPqZ3zYtzCpII77Nyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727799067; c=relaxed/simple;
	bh=Gi4+fTZ7YQPE4WFdlwln3Mtoyds7xK78yHv+B3+ALEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZJ3XEFR5cQ68TARS9a+DCqzE6Q4fSnQJZUX9kQO6kl0JyckMfFrBIZZPjf0RFaqXMPI9uTOOKGtdFaJUJweZdwItyrQGqd+Vd0g6G/bwdGs+kjwZCb2+37Bc+FtIYLAm+JH68pGMB4nnJ48xzA7k292bEVlyM2zxsZkrRmA/Ag8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PW4zcG51; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727799065; x=1759335065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gi4+fTZ7YQPE4WFdlwln3Mtoyds7xK78yHv+B3+ALEc=;
  b=PW4zcG51DejQItYd21v+Q+bbqblKOQlXPkRSiG7bpps5xJIX56vE5C6Y
   7x7+FKPGuZMo/EiF8PH0com8BBtLvle3drjMAn8ycVGJMca+yyfnkswhv
   P1OycMgsVf1sWq0ilL0fqoW4g70YeSa+v1FzSWx05Euq7z4GPIXgW3wEG
   O7k5hbKb1swfu4Wc+h2Pwf9Za6lRD0uP85cYa4czIs267s7RWfjGFJsvS
   ptSSc9+H9ohDThLDNvnHQahfPjI/k82h2ileUz/tUR9LKYTjSMbN0VaF3
   psV8DYvNZGttvX5rdWHC10hKNRMLML2kYdlwkOLQRaxTWqzB+nVziGUdv
   Q==;
X-CSE-ConnectionGUID: FDBUzZ+/SuuQqZgdEfURhA==
X-CSE-MsgGUID: ZSnyyPY6TfW5a0jfZzbWHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="37539414"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="37539414"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 09:11:05 -0700
X-CSE-ConnectionGUID: p1hZAR0eTie6qn08an8SIA==
X-CSE-MsgGUID: hLt4x8+rSjmW+pMbqLyA2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="78586022"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.136.21])
  by orviesa003.jf.intel.com with ESMTP; 01 Oct 2024 09:11:06 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH RFC 7/7] x86/microcode/intel: Enable staging when available
Date: Tue,  1 Oct 2024 09:10:42 -0700
Message-Id: <20241001161042.465584-8-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001161042.465584-1-chang.seok.bae@intel.com>
References: <20241001161042.465584-1-chang.seok.bae@intel.com>
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
 arch/x86/kernel/cpu/microcode/intel.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 03c4b0e7e97c..8f2476fbe8f2 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -688,6 +688,18 @@ static __init void calc_llc_size_per_core(struct cpuinfo_x86 *c)
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
@@ -698,6 +710,11 @@ struct microcode_ops * __init init_intel_microcode(void)
 		return NULL;
 	}
 
+	if (staging_available()) {
+		pr_info("Staging is available.\n");
+		microcode_intel_ops.use_staging = true;
+	}
+
 	calc_llc_size_per_core(c);
 
 	return &microcode_intel_ops;
-- 
2.43.0


