Return-Path: <linux-kernel+bounces-416276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D83F9D42BC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8BB71F232CF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9811F1C878B;
	Wed, 20 Nov 2024 19:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YbT3ADRA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF4D1C75EB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 19:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732132415; cv=none; b=Xb7zMqjWi5fKtnsEMV5H7KCYF9vvQczljzrcZ/ezGLicyOm6kjf3aBeCrETD2Fv207HhYOie1KzAvjd9fZy8ay8rTZPxFhTNNA3BhOXxHqsFlwJtT11Ej6hqsEcY3rmmtKwb0za33cZVzlpPr+9KzQn5k8gOWEhFXQ301lJ6T50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732132415; c=relaxed/simple;
	bh=XGEydlqDd6ucRMq17/SAt12CAeMPRM0NGmY+dJiGY24=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=cJqUKYuUh9SQVsSJsg3VBO3VbbK5PdsupwI/5Ggs1UjOVbty5oMvht9/6xHZvpMuGEq7cJkCql1PBQwJGoHPGmJBpnR7joB/VoUCbuVBIVLc75v8k45hwOKcrBDczXgAbE/FHjJWQ8Z+n+xb4su4qeVI+iuIoehgixqL7zqy0CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YbT3ADRA; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732132413; x=1763668413;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=XGEydlqDd6ucRMq17/SAt12CAeMPRM0NGmY+dJiGY24=;
  b=YbT3ADRAgTxPj8Ibrf2vkRJIrV6acMOcQF67r3FgDdo0B3tJoJbJTY3x
   qKNprZ8DLemnnYz6/V8euT0FkIM5Bc4pSWl07mrdgnKFiP/a8gu/+5a1b
   ixzG47lvJsGx6LVqUVoCYm6TEmXjQQXM4OwLIVNNomp/pyzWP7NMehgUx
   VnV5cInRiJxNB0pnZh8aKz88JYIsTQJWEmu2XNR288Ke3hunYiyPSISEb
   X5jRDGJ0sBL0LJM1tR5X7EONHpzdq2SaN/IhNVb5/DVisqyd+Qme1DDj6
   kc/xozmlTqU0CFMDFc32RLI6gwZopdhN/ZWmo5n5I/DuhxMExOvZHinyw
   w==;
X-CSE-ConnectionGUID: 1T9AHZchQPeLVp8+sK2qeg==
X-CSE-MsgGUID: 1wTUHFtsTLK4Jxwk9pWt4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="31580950"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="31580950"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 11:53:33 -0800
X-CSE-ConnectionGUID: yo+fgcG1RpyGIIP7BMm2FA==
X-CSE-MsgGUID: mK1a3HZWQ1ykmjbQRy/cKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="120884162"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa002.jf.intel.com with ESMTP; 20 Nov 2024 11:53:33 -0800
Subject: [PATCH 04/11] x86/acpi: Check MWAIT feature instead of CPUID level
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,dave.jiang@intel.com,irenic.rajneesh@gmail.com,david.e.box@intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 20 Nov 2024 11:53:32 -0800
References: <20241120195327.26E06A69@davehans-spike.ostc.intel.com>
In-Reply-To: <20241120195327.26E06A69@davehans-spike.ostc.intel.com>
Message-Id: <20241120195332.929A7C44@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

I think this code is possibly buggy.  The CPU could have a high
c->cpuid_level and not support MWAIT at all.  It is much more clear to
just check for MWAIT support directly.  Also, because of the CPU level
dependency code, any CPU that has X86_FEATURE_MWAIT also has a
high-enough CPUID level.

Check X86_FEATURE_MWAIT instead of the CPUID level.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/kernel/acpi/cstate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/x86/kernel/acpi/cstate.c~mwait-leaf-checks-3 arch/x86/kernel/acpi/cstate.c
--- a/arch/x86/kernel/acpi/cstate.c~mwait-leaf-checks-3	2024-11-20 11:44:17.225650902 -0800
+++ b/arch/x86/kernel/acpi/cstate.c	2024-11-20 11:44:17.225650902 -0800
@@ -173,7 +173,7 @@ int acpi_processor_ffh_cstate_probe(unsi
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	long retval;
 
-	if (!cpu_cstate_entry || c->cpuid_level < CPUID_MWAIT_LEAF)
+	if (!cpu_cstate_entry || cpu_has(c, X86_FEATURE_MWAIT))
 		return -1;
 
 	if (reg->bit_offset != NATIVE_CSTATE_BEYOND_HALT)
_

