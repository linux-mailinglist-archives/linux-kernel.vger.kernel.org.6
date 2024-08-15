Return-Path: <linux-kernel+bounces-287928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 735B0952E4A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2680C1F2754F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439401A00D2;
	Thu, 15 Aug 2024 12:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dR5BWaaf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3BC19F498
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 12:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723724993; cv=none; b=Vr0F4w9LKSqWAT+051fSdsqIi6l6iLVJ9mYf3d+rHl0KxReS63fSuFdMArfzR4LliXjnft/4ZUvTLk6sf+s3HE78enlNrcLbZIaGw4lwWmnFn8VOrY2CLBnHQFKsT9upjLdSvsvwn7O4HoC0bubyMzjRPRK/XzSKVrwBxwmRtMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723724993; c=relaxed/simple;
	bh=y1A/iCqbHo6zR/G1rwhMwz6a/e6LDjaACs8825jVEsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpgLNLIVbHI37zu0LEs4QXhtUZdk/ZovbdcHW7dFcvmlPfe5I8IIoHih+0LMyBNojERFGT3rli9r2yJqnKa6kUA5XviYpfZoHxQPjEUDLqN92ZSrvTmb64j3WQHo4U5RgyzCg2c9Ncl2pvZwSEwHVCs1zi/ZD7wHSUeNGiTaeMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dR5BWaaf; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723724992; x=1755260992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y1A/iCqbHo6zR/G1rwhMwz6a/e6LDjaACs8825jVEsM=;
  b=dR5BWaaf+/IlYuian4bSIWAdDJtTIm27AsOiNNC3STbIo+vNCMugRelf
   y1TuLmZ/CrV7Qxmuwyw41qmxxwbe+kaLHrKYPdM4rXhCCDEg3Ge1Sy//r
   HMrpP2A5d4hXJmwBEGesxcKm93DfFwUSPNuaLjPouffISXBbYVwVQXfYZ
   bqawGjhyjrX6vwbzGC2gxlmgRi/qWeqzrRTDzyBDlZCgvYRnVfqsi7g4F
   zDK0b2euORxWq5ktexoNv0E69HExHJkZ5FZaSaRETFZL4xdRhGbChknAn
   V8IyfcouRpu/gBLth7KJEFv1jdPoO6j7RIjsf2bXa7o2OrEQnKjMswApb
   A==;
X-CSE-ConnectionGUID: 8cLgW+lsSuK7jMpcziJvrQ==
X-CSE-MsgGUID: BHyhCTc4TOWyejIDHlVU1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="22112279"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="22112279"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 05:29:52 -0700
X-CSE-ConnectionGUID: L3VRLcJMRdqYsbtfIsfsmA==
X-CSE-MsgGUID: dXHEQYGjS4Cc1BhddbpfXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="59489486"
Received: from unknown (HELO khuang2-desk.gar.corp.intel.com) ([10.124.223.78])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 05:29:49 -0700
From: Kai Huang <kai.huang@intel.com>
To: dave.hansen@intel.com,
	kirill.shutemov@linux.intel.com,
	bp@alien8.de,
	tglx@linutronix.de,
	peterz@infradead.org,
	mingo@redhat.com
Cc: x86@kernel.org,
	hpa@zytor.com,
	luto@kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.lendacky@amd.com,
	pbonzini@redhat.com,
	seanjc@google.com
Subject: [PATCH v5 5/5] x86/virt/tdx: Remove the !KEXEC_CORE dependency
Date: Fri, 16 Aug 2024 00:29:21 +1200
Message-ID: <47d69189e883543f2dc8923c2b86da94b0b2c3e0.1723723470.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1723723470.git.kai.huang@intel.com>
References: <cover.1723723470.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now TDX host can work with kexec().  Remove the !KEXEC_CORE dependency.

Signed-off-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d422247b2882..2da088202969 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1979,7 +1979,6 @@ config INTEL_TDX_HOST
 	depends on X86_X2APIC
 	select ARCH_KEEP_MEMBLOCK
 	depends on CONTIG_ALLOC
-	depends on !KEXEC_CORE
 	depends on X86_MCE
 	help
 	  Intel Trust Domain Extensions (TDX) protects guest VMs from malicious
-- 
2.45.2


