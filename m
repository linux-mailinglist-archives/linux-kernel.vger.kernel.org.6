Return-Path: <linux-kernel+bounces-445551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9CA9F179E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5943F166A4D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA901EBFF7;
	Fri, 13 Dec 2024 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nty+gaI9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C2C1E3791
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123040; cv=none; b=pT7VaK7xE0b5eSn2+oTwoIB5EzS8BkZMQRh6ptnk6e46XNUgZ+I3eBQF1Ym/HO77IQZEtAVgkC/BNkCfCM3Cw+rJ3CSHSBRkvu6vxluJusAc/gd+evdMCcMqg0P1NIXvfquEJwvpnO8cpo9/aADMTnAOvnXoL7USpJ+ny4zO7JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123040; c=relaxed/simple;
	bh=xJ9tlm9UP77Tpl5VZzjFo0c/uI4CPdW7hzDDC10dl5Q=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=Lst758wSzqNe5264mdHpuT1hinNqk08CGDKNSPsp3p23YyzdYJDdw0NUIXL0m9OjrZyWBTtCfSF3ruANnatlHCLYsD22PMBT5NI0K2Mv8L8PdHfV+5+uC68JIKgmz8iczlC3cg50yNOZlMOhPV2u2VXq2zcEZpon6CewP15HwT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nty+gaI9; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734123039; x=1765659039;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=xJ9tlm9UP77Tpl5VZzjFo0c/uI4CPdW7hzDDC10dl5Q=;
  b=Nty+gaI9k9Q5195zCMfbdl6gr887ZldOXjmfRlGo+LI8PYDToUb5/eHS
   B6JroHepTl311ybAEsUM94eAKXvdalAk6lAn34HaPcTiz7Cz05z9i2XY5
   MSKDe7QjcvIDV8Y0Ze0ED9yvz4TSi0JMLU+EVyIbE46g8NZooxqPIpeDH
   PvIEm/ICX6IpCS0vCBf2DA2y9M2oJIicO4c934hrRwKJec31GBqOt6MTR
   UcRP6kmuDGbhVocfjLK1LgcGgFE1fpNSHFkihms0Ng32szl6xI0Yc1jni
   mzbqV2tQrLDx3Vm4QvpSbwO5XnQ5UOiQfFreId4cuHWhgrTYpnB0gJl4b
   Q==;
X-CSE-ConnectionGUID: eCgNuOgkRcuM/JMJiQmmcQ==
X-CSE-MsgGUID: zEoJeQojRfqVE4luuK6A4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45973171"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="45973171"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 12:50:38 -0800
X-CSE-ConnectionGUID: 0iJnRf4XSb+fQrmW6/tQLQ==
X-CSE-MsgGUID: ZJZW7GQTSSiBo00szh/VDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101599695"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa005.jf.intel.com with ESMTP; 13 Dec 2024 12:50:39 -0800
Subject: [PATCH 09/10] x86/fpu: Remove unnecessary CPUID level check
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,dave.jiang@intel.com,irenic.rajneesh@gmail.com,david.e.box@intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 13 Dec 2024 12:50:38 -0800
References: <20241213205026.25B1D283@davehans-spike.ostc.intel.com>
In-Reply-To: <20241213205026.25B1D283@davehans-spike.ostc.intel.com>
Message-Id: <20241213205038.6E71F9A4@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

The CPUID level dependency table will entirely zap X86_FEATURE_XSAVE
if the CPUID level is too low.  This code is unreachable.  Kill it.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/kernel/fpu/xstate.c |    5 -----
 1 file changed, 5 deletions(-)

diff -puN arch/x86/kernel/fpu/xstate.c~xsave-leaf-checks-2 arch/x86/kernel/fpu/xstate.c
--- a/arch/x86/kernel/fpu/xstate.c~xsave-leaf-checks-2	2024-12-13 12:45:36.903226562 -0800
+++ b/arch/x86/kernel/fpu/xstate.c	2024-12-13 12:45:36.907226732 -0800
@@ -764,11 +764,6 @@ void __init fpu__init_system_xstate(unsi
 		return;
 	}
 
-	if (boot_cpu_data.cpuid_level < XSTATE_CPUID) {
-		WARN_ON_FPU(1);
-		return;
-	}
-
 	/*
 	 * Find user xstates supported by the processor.
 	 */
_

