Return-Path: <linux-kernel+bounces-337127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D589845B5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C09284CCE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8361AAE1C;
	Tue, 24 Sep 2024 12:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EMsYgFdM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353D41A7ACD
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727180074; cv=none; b=r5ipdpmVL9786UMfCgpze1sqObQv/Ovwqq8skItifDkGCk32xifmhkGtp/9vUBz1odGcBT6W5Te6RPlsBH4++hn7yfRe/uFXb4BaJWBAyFsUAONiussvTJreUCqoumS5lQAzZhCMCcjOPS3twBiFZZo5tDco+HDm3GeaN1ei2DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727180074; c=relaxed/simple;
	bh=LIcTyHmfasKpbOmTSceVs68nnCqXeXKIJPkSRF3AgaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgM5iY5lMLcO+jcoZPmrIBkgEmAHaExNuqY+UtCZ02qtF2UwdxXuMmbw0qLMtxGefTfSAhhZnqZAntijbJfcAb4k32OT4iVg9IbD+bEszyXUcv6PwtXRa6SR6559Xdaokro0jWfkSqp/0P1xJso9uWPh7VuQ3u+y7sIHJrAUeZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EMsYgFdM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727180073; x=1758716073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LIcTyHmfasKpbOmTSceVs68nnCqXeXKIJPkSRF3AgaE=;
  b=EMsYgFdMfzbEQxDXoPBV41Q2Zn208w0KwgecMQ5gjvyA6jlyfGvYrtzg
   ZBd36WNbIXt+Dy3X9+ZM2qmlumOTSUdjctOfbuMDEbfgBzdo2xJNxm0nW
   QJz/LqEweLuvUOOuN+Z2kFgTsaYEbXR42KvUlvZwRLLM9PaXch9TXmThk
   ULsaqJWUDRGugYlspfEdGq2nwRlOewbxrNBOT9ZJeJCW0POiiYlXxWUX7
   gg6RobADLtiFXJeitTHa53C0NFg9nVjPlIXTuLpk4Ifl8FavUuzVIJ7rk
   pXRMk57WoOEpCYShMYTzk/oA136qd220iu6s1CA6xzvZmu0MMcS+z1492
   g==;
X-CSE-ConnectionGUID: a2+A3A7WRlG1J5VFzZUspQ==
X-CSE-MsgGUID: gp6kqMluRvy+2c/yhWbj2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="29881909"
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="29881909"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 05:14:33 -0700
X-CSE-ConnectionGUID: AqwIIVxbT2WT3KZSgINwsQ==
X-CSE-MsgGUID: 8EX/RDWoQgG3b7ppw9DUGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="71473263"
Received: from ccbilbre-mobl3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.221.10])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 05:14:29 -0700
From: Kai Huang <kai.huang@intel.com>
To: dave.hansen@intel.com,
	bp@alien8.de,
	tglx@linutronix.de,
	peterz@infradead.org,
	mingo@redhat.com,
	hpa@zytor.com,
	kirill.shutemov@linux.intel.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	pbonzini@redhat.com,
	seanjc@google.com,
	dan.j.williams@intel.com,
	thomas.lendacky@amd.com,
	rick.p.edgecombe@intel.com,
	isaku.yamahata@intel.com,
	ashish.kalra@amd.com,
	bhe@redhat.com,
	nik.borisov@suse.com,
	sagis@google.com
Subject: [PATCH v7 5/5] x86/virt/tdx: Remove the !KEXEC_CORE dependency
Date: Wed, 25 Sep 2024 00:13:57 +1200
Message-ID: <714e950b49fa1ec4e9cad5170cf8dcf80c294798.1727179214.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1727179214.git.kai.huang@intel.com>
References: <cover.1727179214.git.kai.huang@intel.com>
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
index 9ffdacaaa725..a9e231873f6a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1975,7 +1975,6 @@ config INTEL_TDX_HOST
 	depends on X86_X2APIC
 	select ARCH_KEEP_MEMBLOCK
 	depends on CONTIG_ALLOC
-	depends on !KEXEC_CORE
 	depends on X86_MCE
 	help
 	  Intel Trust Domain Extensions (TDX) protects guest VMs from malicious
-- 
2.46.0


