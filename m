Return-Path: <linux-kernel+bounces-337707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8ED984DDD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B068C1C23C66
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8341AD3EE;
	Tue, 24 Sep 2024 22:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QYrUoOsw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896CE1AB6DB;
	Tue, 24 Sep 2024 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727217130; cv=none; b=hEJ7VoB5ACDPb5lBTD8OndQpgn8NGjcuGLXLIv7KkTXFLJou9YhEWXC+PD6A7uCYu8bNQLK5ay8o2SBcsXWdYQnLYzUlebmJmyA7CAmwbSDkYSxdtO7fTECv4dGF40Z6OdWeZAZ0XYSiQ7CpZd50qfNxA1ONOXW3yQ9vYjiFvzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727217130; c=relaxed/simple;
	bh=MQ8eLb3mjCLab/2JRQu0j8MUTp2HmvQ8MTXtmcdxz7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UlRmantoSInixiee5yj80uk7EuSfkGeyHK5jk2CUB+y1QfGXEwIY91xT6BxmbPxL2VBE6tCzluqwC8nmx4UmRJbKl200Hsz+U4eF3T6FuhW3SyuYAlzad9+oHoMsr9nRPbsRP5Uif8c27Rd/DyxKco+icbqGos7yE0y7VVrmL/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QYrUoOsw; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727217129; x=1758753129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MQ8eLb3mjCLab/2JRQu0j8MUTp2HmvQ8MTXtmcdxz7s=;
  b=QYrUoOsw7vmHbycwxU23962HAoeBXjQYmIexAwz3AaNzp5s7LIa8H2HP
   NOm2Mf2OJqvFSsccqncMIvVs1wUt2r8Z2hXG73NeYfXVahqegF80aFJj7
   dZyGRN87T6AbuERtnx+oUreFDieN7XCuvbufYucgXCYnWgijwaLljnwif
   Jk343uLIyR67t/gMquDBEvPEzPZgCX+HA5pzt58wFXMvTw2oZRw/QyQvh
   yA66Mby0wl/MMgIT53XO4pfKzMEUPOWTW9T+LdDSO6CTtZKIyJtuo0uK4
   c8K2SwW0EertVwhgFSdNQJbFMAWa28DxPFF5rC2rJC+9JxzHVQa6rGEue
   w==;
X-CSE-ConnectionGUID: l74yUbgGT0OkQBW7Dn9XGQ==
X-CSE-MsgGUID: V5ab0z+zRy2n9l+7WFmsMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="36908090"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="36908090"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 15:31:58 -0700
X-CSE-ConnectionGUID: dFOzG2GlSdio8jrdbUf3Uw==
X-CSE-MsgGUID: XrhWGbaxSA67HLLZsCURQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="102384845"
Received: from laijusti-mobl.amr.corp.intel.com (HELO dsneddon-desk.sneddon.lan) ([10.125.17.198])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 15:31:57 -0700
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: hpa@zytor.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pawan.kumar.gupta@linux.intel.com
Subject: [PATCH 5/6] x86/bugs: Remove RFDS kernel parameter.
Date: Tue, 24 Sep 2024 15:31:39 -0700
Message-Id: <20240924223140.1054918-6-daniel.sneddon@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240924223140.1054918-1-daniel.sneddon@linux.intel.com>
References: <20240924223140.1054918-1-daniel.sneddon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the reg_file_data_sampling kernel parameter since it can be set
using the common clear_cpu_buffers parameter.

Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
---
 .../admin-guide/kernel-parameters.txt         | 20 -------------------
 arch/x86/kernel/cpu/bugs.c                    | 17 ----------------
 2 files changed, 37 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7afccd044fb8..2728fef51749 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1182,26 +1182,6 @@
 			The filter can be disabled or changed to another
 			driver later using sysfs.
 
-	reg_file_data_sampling=
-			[X86] Controls mitigation for Register File Data
-			Sampling (RFDS) vulnerability. RFDS is a CPU
-			vulnerability which may allow userspace to infer
-			kernel data values previously stored in floating point
-			registers, vector registers, or integer registers.
-			RFDS only affects Intel Atom processors.
-
-			on:	Turns ON the mitigation.
-			off:	Turns OFF the mitigation.
-
-			This parameter overrides the compile time default set
-			by CONFIG_MITIGATION_RFDS. Mitigation cannot be
-			disabled when other VERW based mitigations (like MDS)
-			are enabled. In order to disable RFDS mitigation all
-			VERW based mitigations need to be disabled.
-
-			For details see:
-			Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst
-
 	driver_async_probe=  [KNL]
 			List of driver names to be probed asynchronously. *
 			matches with all driver names. If * is specified, the
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 63a8cda2fe30..45411880481c 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -448,23 +448,6 @@ static void __init rfds_select_mitigation(void)
 		rfds_mitigation = RFDS_MITIGATION_UCODE_NEEDED;
 }
 
-static __init int rfds_parse_cmdline(char *str)
-{
-	if (!str)
-		return -EINVAL;
-
-	if (!boot_cpu_has_bug(X86_BUG_RFDS))
-		return 0;
-
-	if (!strcmp(str, "off"))
-		rfds_mitigation = RFDS_MITIGATION_OFF;
-	else if (!strcmp(str, "on"))
-		rfds_mitigation = RFDS_MITIGATION_VERW;
-
-	return 0;
-}
-early_param("reg_file_data_sampling", rfds_parse_cmdline);
-
 #undef pr_fmt
 #define pr_fmt(fmt)     "" fmt
 
-- 
2.25.1


