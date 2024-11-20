Return-Path: <linux-kernel+bounces-416275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8337D9D42BB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0201F23473
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE54C1C830D;
	Wed, 20 Nov 2024 19:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TxSlQXJu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88231C7265
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 19:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732132414; cv=none; b=FTJ3ei3fIl+w9aKBT2hqQXE2+LgyVgCewz4r+IwT3LcKdHNb7eXff8NjKcHFxQQiOOnfhiNZjgb9ROteagf57elw34ryp6Yqq5AA8are3ZgjACQO+6bg507SRoqRmRvP7ICtUMyMU4XfEf5n1gyTIrNfYswXv4h1JhU0CpTItx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732132414; c=relaxed/simple;
	bh=UszqYxnP1r7ON+MU3InES5XqtqTfjk/PRfPJpbfMHco=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=JGGdue5A4zZBc+Cx0j1jTB6S10te3bpxOCsZp7Sbs4fCQiocanZY0kJiTfwYKQ0S21dh98sIZZV2guHIeMw9bsALcW1OKBTDTQ8N7/sk+E0PlWMZjp8iE/+Us5acKgOyY5eIPAeEB1kxb/L7U1jDX4+6Gj8v4LQyL2AOI61f3zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TxSlQXJu; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732132413; x=1763668413;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=UszqYxnP1r7ON+MU3InES5XqtqTfjk/PRfPJpbfMHco=;
  b=TxSlQXJuLKdwS5hW7bsxW/CW26AIsj5JQgg8S0hi8kYQDnVyzjS3L+8z
   ALOGau8gvNw0htqGRm1ZHQhx7q3D7HJxf8rYGlA9bGZzAERTUjG6SP+7z
   jIBJpqBpgBsOUhvF2HB4t5qCIOQa25RRbXSnJblZ8jCCi8cAHTztoJRlN
   PH7uGN20LrlVNvNHzKG1q0RYWHx5NqbOsrORkKHMVd0f3Z53MqXpe8lor
   p2kf+Yw0G4OP8a6TXxzZvZKaidfA1Pg/sNxD2GmfcWDOZ4tD/Wskzvqrk
   J4AZMYeT89ARebJ12s/oFF9PncJbs0WzYU5m37gkBmZtAi3EEVnLFMx1n
   w==;
X-CSE-ConnectionGUID: vz5FTdeoR5KNQ4daAFRQ3w==
X-CSE-MsgGUID: k5TSa5RBRby7ilyvBm8LnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="31580941"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="31580941"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 11:53:32 -0800
X-CSE-ConnectionGUID: t++Z0kLhRyKUnbiyz9wFzQ==
X-CSE-MsgGUID: 6TwuskPFTOSjgZyb5Nj7yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="120884154"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa002.jf.intel.com with ESMTP; 20 Nov 2024 11:53:32 -0800
Subject: [PATCH 03/11] x86/cpu: Remove unnecessary MwAIT leaf checks
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,dave.jiang@intel.com,irenic.rajneesh@gmail.com,david.e.box@intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 20 Nov 2024 11:53:31 -0800
References: <20241120195327.26E06A69@davehans-spike.ostc.intel.com>
In-Reply-To: <20241120195327.26E06A69@davehans-spike.ostc.intel.com>
Message-Id: <20241120195331.08EA36C8@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

The CPUID leaf dependency checker will remove X86_FEATURE_MWAIT if
the CPUID level is below the required level (CPUID_MWAIT_LEAF).
Thus, if you check X86_FEATURE_MWAIT you do not need to also
check the CPUID level.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/kernel/hpet.c    |    3 ---
 b/arch/x86/kernel/smpboot.c |    2 --
 b/drivers/acpi/acpi_pad.c   |    2 --
 b/drivers/idle/intel_idle.c |    3 ---
 4 files changed, 10 deletions(-)

diff -puN arch/x86/kernel/hpet.c~mwait-leaf-checks-2 arch/x86/kernel/hpet.c
--- a/arch/x86/kernel/hpet.c~mwait-leaf-checks-2	2024-11-20 11:44:16.665629466 -0800
+++ b/arch/x86/kernel/hpet.c	2024-11-20 11:44:16.673629773 -0800
@@ -928,9 +928,6 @@ static bool __init mwait_pc10_supported(
 	if (!cpu_feature_enabled(X86_FEATURE_MWAIT))
 		return false;
 
-	if (boot_cpu_data.cpuid_level < CPUID_MWAIT_LEAF)
-		return false;
-
 	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &mwait_substates);
 
 	return (ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED) &&
diff -puN arch/x86/kernel/smpboot.c~mwait-leaf-checks-2 arch/x86/kernel/smpboot.c
--- a/arch/x86/kernel/smpboot.c~mwait-leaf-checks-2	2024-11-20 11:44:16.669629620 -0800
+++ b/arch/x86/kernel/smpboot.c	2024-11-20 11:44:16.673629773 -0800
@@ -1291,8 +1291,6 @@ static inline void mwait_play_dead(void)
 		return;
 	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
 		return;
-	if (__this_cpu_read(cpu_info.cpuid_level) < CPUID_MWAIT_LEAF)
-		return;
 
 	eax = CPUID_MWAIT_LEAF;
 	ecx = 0;
diff -puN drivers/acpi/acpi_pad.c~mwait-leaf-checks-2 drivers/acpi/acpi_pad.c
--- a/drivers/acpi/acpi_pad.c~mwait-leaf-checks-2	2024-11-20 11:44:16.669629620 -0800
+++ b/drivers/acpi/acpi_pad.c	2024-11-20 11:44:16.673629773 -0800
@@ -47,8 +47,6 @@ static void power_saving_mwait_init(void
 
 	if (!boot_cpu_has(X86_FEATURE_MWAIT))
 		return;
-	if (boot_cpu_data.cpuid_level < CPUID_MWAIT_LEAF)
-		return;
 
 	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
 
diff -puN drivers/idle/intel_idle.c~mwait-leaf-checks-2 drivers/idle/intel_idle.c
--- a/drivers/idle/intel_idle.c~mwait-leaf-checks-2	2024-11-20 11:44:16.669629620 -0800
+++ b/drivers/idle/intel_idle.c	2024-11-20 11:44:16.673629773 -0800
@@ -2269,9 +2269,6 @@ static int __init intel_idle_init(void)
 			return -ENODEV;
 	}
 
-	if (boot_cpu_data.cpuid_level < CPUID_MWAIT_LEAF)
-		return -ENODEV;
-
 	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &mwait_substates);
 
 	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED) ||
_

